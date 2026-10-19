using System.Collections.Generic;
using ACT.Battle;
using ACT.MissionSystem;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Pool;

namespace ACT.UI;

public class TaskTip_Tracing : TaskTip_Base
{
	public class ConditionUpdate
	{
		public int missionId;

		public int conditionId;

		public bool finished;

		public IEnumerable<ConditionDescription> descriptions;
	}

	public class StageUpdate
	{
		public int missionId;

		public int stageIndex;
	}

	[Header("图标")]
	public BImage missionTypeImage;

	[Header("名称")]
	public LocalizeStringEvent missionName;

	[HideInInspector]
	[Header("描述")]
	public GameObject missionContentRoot;

	[HideInInspector]
	public LocalizeStringEvent missionContent;

	[HideInInspector]
	public LocalizeStringEvent missionContent_Update;

	[Header("其他内容")]
	[HideInInspector]
	public GameObject distanceRoot;

	[HideInInspector]
	public TextMeshProUGUI distance;

	[HideInInspector]
	public GameObject inZoneRoot;

	[HideInInspector]
	public TextMeshProUGUI gotoMapText;

	[HideInInspector]
	public BetterAnimation animation;

	[HideInInspector]
	public ActButton button;

	[HideInInspector]
	public ActButton gotoButton;

	[Header("任务描述")]
	public GameObject taskTipDescriptionRoot;

	public TaskTipDescription taskTipDescriptionTemplate;

	private MissionStateAdapter m_MissionStateAdapter;

	private UnityEngine.Pool.ObjectPool<TaskTipDescription> m_TaskTipDescriptionPool;

	private void Awake()
	{
		InitPool();
	}

	private void Update()
	{
	}

	private void InitPool()
	{
		if (m_TaskTipDescriptionPool == null)
		{
			m_TaskTipDescriptionPool = new UnityEngine.Pool.ObjectPool<TaskTipDescription>(() =>
			{
				TaskTipDescription taskTipDescription = Object.Instantiate(taskTipDescriptionTemplate, taskTipDescriptionRoot.transform);
				TaskTipDescription component = taskTipDescription.GetComponent<TaskTipDescription>();
				component.Init(this);
				taskTipDescription.gameObject.SetActive(value: true);
				return component;
			}, (TaskTipDescription description) =>
			{
				description.gameObject.SetActive(value: true);
			}, (TaskTipDescription description) =>
			{
				description.gameObject.SetActive(value: false);
			});
		}
	}

	protected override void OnInit()
	{
		InitPool();
	}

	protected override void OnUnInit()
	{
		m_MissionStateAdapter = null;
	}

	public void OnMissionStageUpdate(StageUpdate stageUpdate)
	{
		if (m_MissionStateAdapter != null && stageUpdate.missionId == m_MissionStateAdapter.Id)
		{
			UpdateDescriptions();
		}
	}

	public async UniTask OnMissionConditionUpdate(ConditionUpdate conditionUpdate)
	{
		if (m_MissionStateAdapter == null || conditionUpdate.missionId != m_MissionStateAdapter.Id)
		{
			return;
		}
		if (conditionUpdate.finished)
		{
			int index = 0;
			IEnumerable<ConditionDescription> descriptions = conditionUpdate.descriptions;
			int num = 0;
			foreach (ConditionDescription item in descriptions)
			{
				num += (item.HaveContent ? 1 : 0);
			}
			for (int i = 0; i < taskTipDescriptionRoot.transform.childCount; i++)
			{
				taskTipDescriptionRoot.transform.GetChild(index).GetComponent<TaskTipDescription>().SetContentMultiLine(num <= 1);
			}
			foreach (ConditionDescription item2 in descriptions)
			{
				if (item2.MissionId != conditionUpdate.missionId || item2.ConditionId != conditionUpdate.conditionId)
				{
					continue;
				}
				for (; index < taskTipDescriptionRoot.transform.childCount; index++)
				{
					Transform child = taskTipDescriptionRoot.transform.GetChild(index);
					if (child.gameObject.activeSelf)
					{
						TaskTipDescription component = child.GetComponent<TaskTipDescription>();
						if (component.MissionId == conditionUpdate.missionId && component.ConditionId == conditionUpdate.conditionId)
						{
							await component.UpdateState(item2, GetImageStation());
							break;
						}
					}
				}
				index++;
			}
		}
		else
		{
			UpdateDescriptions();
		}
	}

	private bool IsPlaying()
	{
		AnimatorStateInfo currentAnimatorStateInfo = Manager.animationController.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.normalizedTime >= 1f)
		{
			return currentAnimatorStateInfo.IsName("Base.TaskProceed");
		}
		return false;
	}

	private void OnClick()
	{
		Manager.View.GetController()?.OnOpenMissionTarget(force: false);
	}

	private void ClearDescriptions()
	{
		for (int i = 0; i < taskTipDescriptionRoot.transform.childCount; i++)
		{
			Transform child = taskTipDescriptionRoot.transform.GetChild(i);
			if (child.gameObject.activeSelf)
			{
				TaskTipDescription component = child.GetComponent<TaskTipDescription>();
				if ((bool)component)
				{
					m_TaskTipDescriptionPool?.Release(component);
				}
			}
		}
	}

	private void UpdateDescriptions()
	{
		ClearDescriptions();
		if (m_MissionStateAdapter == null)
		{
			return;
		}
		int num = 0;
		int num2 = 0;
		foreach (ConditionDescription missionDescription in Singleton<MissionManager>.instance.GetMissionDescriptions(m_MissionStateAdapter.Id))
		{
			TaskTipDescription taskTipDescription = m_TaskTipDescriptionPool.Get();
			taskTipDescription.SetUp(missionDescription, GetImageStation());
			taskTipDescription.transform.SetSiblingIndex(num);
			num++;
			num2 += (missionDescription.HaveContent ? 1 : 0);
		}
		for (int i = 0; i < taskTipDescriptionRoot.transform.childCount; i++)
		{
			taskTipDescriptionRoot.transform.GetChild(i).GetComponent<TaskTipDescription>().SetContentMultiLine(num2 <= 1);
		}
	}

	private void UpdateDistance()
	{
		if (m_MissionStateAdapter == null || !MonoECS.instance.isStartWorld)
		{
			return;
		}
		missionContentRoot.SetActive(value: true);
		m_MissionStateAdapter.RefreshDistanceText();
		bool flag = m_MissionStateAdapter.IsCrossMap();
		string distanceText = m_MissionStateAdapter.GetDistanceText();
		distance.text = distanceText;
		distance.color = m_MissionStateAdapter.GetDistanceColor();
		if (flag)
		{
			inZoneRoot.SetActive(value: false);
			distanceRoot.SetActive(value: false);
			gotoMapText.gameObject.SetActive(value: true);
			gotoMapText.text = m_MissionStateAdapter.GetTeleportText();
			return;
		}
		if (m_MissionStateAdapter.IsInZone())
		{
			distanceRoot.SetActive(value: false);
			inZoneRoot.SetActive(value: true);
		}
		else
		{
			distanceRoot.SetActive(value: true);
			inZoneRoot.SetActive(value: false);
		}
		gotoMapText.gameObject.SetActive(value: false);
	}

	public void RefreshMission(MissionStateAdapter missionInfoAdapter)
	{
		m_MissionStateAdapter = missionInfoAdapter;
		if (missionInfoAdapter != null)
		{
			ImageAssetStation imageStation = GetImageStation();
			int missionType = missionInfoAdapter.GetMissionType();
			string arg = missionInfoAdapter.GetMissionName();
			string missionTitle = missionInfoAdapter.GetMissionTitle();
			imageStation?.LoadImage(200, missionType, missionTypeImage);
			missionName.OnUpdateString?.Invoke(arg);
			missionContent.OnUpdateString?.Invoke(missionTitle);
			missionContent_Update.OnUpdateString?.Invoke(missionTitle);
			gameObject.SetActive(value: true);
			Manager.animationController.SetBool(TaskTip_Base.Proceed, value: true);
			animation.GetSequence("Normal").Play();
			UpdateDescriptions();
			UpdateDistance();
		}
		else
		{
			Clear();
		}
	}

	public async UniTask PlayConditionStateUpdate(MissionStateAdapter missionInfoAdapter, int conditionId)
	{
		_ = missionInfoAdapter.Id;
		_ = m_MissionStateAdapter.Id;
	}

	public void Clear()
	{
		if (!(gameObject == null) && (bool)gameObject)
		{
			m_MissionStateAdapter = null;
			ClearDescriptions();
			gameObject.SetActive(value: false);
			missionName.StringReference.TableEntryReference = null;
			missionName.OnUpdateString.Invoke(string.Empty);
			missionContent.StringReference.TableEntryReference = null;
			missionContent.OnUpdateString.Invoke(string.Empty);
			missionContent_Update.StringReference.TableEntryReference = null;
			missionContent_Update.OnUpdateString.Invoke(string.Empty);
		}
	}
}
