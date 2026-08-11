using Ase.ECS;
using Cysharp.Threading.Tasks;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public abstract class BaseTrigger : SerializedMonoBehaviour, IInit, IDispose
{
	[SerializeField]
	private int uid;

	public LevelArea levelArea;

	public string Desc;

	[Tooltip("触发器默认关闭，可由外部激活触发开关。如果默认打开，则玩家进入就会直接触发")]
	public bool triggerInitSwitch;

	public AreaTriggerType triggerType;

	public float delayTime;

	[Tooltip("剩余可激活次数。")]
	public int executeTime = -1;

	public bool SaveNode;

	public bool SaveData;

	protected bool triggerSwitch;

	private int initExecuteTime = -1;

	protected bool isStart;

	protected BaseEntity triggerEntity;

	protected Vector3 triggerPostion;

	protected SceneSystem sceneSystem;

	[SerializeField]
	[Range(-180f, 180f)]
	protected float startAngle;

	[SerializeField]
	protected bool invertCondition;

	[SerializeField]
	[Range(-180f, 180f)]
	protected float endAngle = 180f;

	public int Uid => uid;

	public abstract string TriggerName { get; }

	private LevelAreaType LevelAreaType => levelArea.areaType;

	protected bool isLoop => executeTime == -1;

	public SceneSystem SceneSystem
	{
		get
		{
			return sceneSystem;
		}
		set
		{
			sceneSystem = value;
		}
	}

	protected virtual bool OpenAngleCheck => false;

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		triggerSwitch = triggerInitSwitch;
		if (SaveNode)
		{
			LevelSaveService.TriggerData triggerData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetTriggerData(sceneSystem.GetLevelId(), uid);
			if (triggerData != null)
			{
				executeTime = triggerData.ExecuteTime;
			}
		}
		initExecuteTime = executeTime;
	}

	public void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		if (eventType == LevelMapDataEvent.RestLevel)
		{
			OnRestLevel();
		}
	}

	public void OnRestLevel()
	{
		triggerSwitch = triggerInitSwitch;
		if (SaveNode)
		{
			LevelSaveService.TriggerData triggerData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetTriggerData(sceneSystem.GetLevelId(), uid);
			if (triggerData != null)
			{
				executeTime = triggerData.ExecuteTime;
			}
		}
		else
		{
			executeTime = initExecuteTime;
		}
		OnRestTrigger();
	}

	public void OnDispose()
	{
		OnRestTrigger();
	}

	protected virtual void OnRestTrigger()
	{
	}

	private void UpdateName()
	{
		((Object)this).name = (triggerInitSwitch ? "√ " : "x ") + TriggerName + " - " + Desc;
	}

	public void OnTrigger(AreaTriggerType type, BaseEntity entity)
	{
		if (entity == null)
		{
			triggerPostion = Vector3.zero;
		}
		else
		{
			triggerPostion = entity.transform.position;
		}
		switch (type)
		{
		case AreaTriggerType.Enter:
			triggerEntity = entity;
			break;
		case AreaTriggerType.Exit:
			triggerEntity = null;
			break;
		}
		if (triggerType == type)
		{
			ExecuteDelay();
		}
	}

	public async void ExecuteDelay()
	{
		if (delayTime <= 0f)
		{
			Execute();
			return;
		}
		await UniTask.WaitForSeconds(delayTime);
		Execute();
	}

	public virtual async void Execute()
	{
		if (OpenAngleCheck)
		{
			bool flag = CheckExit(triggerPostion);
			if ((invertCondition & flag) || (!invertCondition && !flag))
			{
				return;
			}
		}
		if (!triggerSwitch || executeTime == 0)
		{
			isStart = false;
			return;
		}
		if (!isLoop)
		{
			executeTime--;
			if (SaveNode)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SetTriggerData(sceneSystem.GetLevelId(), uid, executeTime);
				if (SaveData)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(sceneSystem.GetLevelId());
				}
			}
		}
		DoExecute();
	}

	protected virtual void DoExecute()
	{
	}

	public virtual void Active()
	{
		triggerSwitch = true;
	}

	public virtual void Disable()
	{
		triggerSwitch = false;
	}

	protected bool CheckExit(Vector3 exitPoint)
	{
		exitPoint.y = ((Component)this).transform.position.y;
		Vector3 to = exitPoint - ((Component)this).transform.position;
		float num = Vector3.SignedAngle(((Component)this).transform.forward, to, Vector3.up);
		if (num > startAngle)
		{
			return num <= endAngle;
		}
		return false;
	}

	private bool IsInEditMode()
	{
		if (!Application.isPlaying)
		{
			return false;
		}
		return executeTime == 0;
	}

	public virtual void DeleteTrigger()
	{
		Object.DestroyImmediate(((Component)this).gameObject);
	}

	public void TestTrigger()
	{
		Active();
		Execute();
	}
}
