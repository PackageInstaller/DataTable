using NetProcol;
using UnityEngine;

public class ComponentEnemyView : CMonoBehaviour
{
	public string mEffectPath = "";

	private GameObject locker1;

	private WarningManager warning;

	private EffectController effectController;

	public int FULL_OBSTACLE_LAYER;

	public int HALF_OBSTACLE_LAYER;

	private bool active;

	public string mAttachPoint = "";

	public float mViewDegree;

	public float mDistanceInViewToFindStandChar;

	public float mDistanceInViewToFindCrawlChar;

	public float mDistanceOutViewToFindStandChar;

	private float mAlertValue;

	public float mAlertMaxValue;

	public float mAlertUpdateAddValue;

	public float mAlertUpdateSubValue;

	public int mAlertUpdateInterval;

	private int currentTime;

	private bool targetInView;

	private Camera mainCamera;

	private void Awake()
	{
		FULL_OBSTACLE_LAYER = LayerMask.GetMask("ViewObstacle");
		HALF_OBSTACLE_LAYER = LayerMask.GetMask("HalfViewObstacle");
	}

	public override void UpdateBehavior()
	{
		if (!active)
		{
			return;
		}
		currentTime++;
		if (currentTime <= mAlertUpdateInterval)
		{
			return;
		}
		currentTime = 0;
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		if (playerAgent as AgentHuman == null || playerAgent.transform == null || mAgent == null || mAgent.transform == null)
		{
			return;
		}
		Vector3 vector = playerAgent.transform.position - mAgent.transform.position;
		ComponentCrawlState componentCrawlState = (playerAgent as AgentHuman).ComponentCrawlState;
		bool num = componentCrawlState != null && componentCrawlState.isCrawl;
		float num2 = Vector3.Angle(mAgent.transform.forward, vector);
		float magnitude = vector.magnitude;
		bool flag;
		if (num)
		{
			flag = num2 <= mViewDegree / 2f && magnitude <= mDistanceInViewToFindCrawlChar;
			if (flag && Physics.Raycast(base.transform.position, vector, out var _, magnitude, FULL_OBSTACLE_LAYER | HALF_OBSTACLE_LAYER))
			{
				flag = false;
			}
		}
		else
		{
			flag = num2 <= mViewDegree / 2f && magnitude <= mDistanceInViewToFindStandChar;
			if (!flag)
			{
				flag = magnitude <= mDistanceOutViewToFindStandChar;
			}
			if (flag && Physics.Raycast(base.transform.position, vector, out var _, magnitude, FULL_OBSTACLE_LAYER))
			{
				flag = false;
			}
		}
		if (flag)
		{
			if (!targetInView)
			{
				targetInView = true;
				SendCommand(EnemyAlertState.Found);
			}
			if (mAlertValue < mAlertMaxValue)
			{
				mAlertValue += mAlertUpdateAddValue;
				if (mAlertValue >= mAlertMaxValue)
				{
					mAlertValue = mAlertMaxValue;
					SendCommand(EnemyAlertState.AlertValueMax);
					if (warning != null && warning.shape != WarningManager.Shape.Circle)
					{
						warning.shape = WarningManager.Shape.Circle;
					}
				}
			}
			if (warning == null || effectController == null)
			{
				GameObject gameObject = Asset.Instantiate(mEffectPath);
				if (gameObject != null)
				{
					effectController = EffectController.GetEffectController(gameObject);
					if (effectController != null)
					{
						effectController.Initialize(isLoop: true, 10f, 1f, EEffectQuality.Fantastic, null);
						effectController.Simulator(0f);
					}
					warning = gameObject.GetComponentInChildren<WarningManager>();
					if (warning.shape != WarningManager.Shape.Fanshape)
					{
						warning.shape = WarningManager.Shape.Fanshape;
					}
					gameObject.transform.parent = base.transform.Find(mAttachPoint);
					gameObject.transform.localPosition = Vector3.zero;
					locker1 = gameObject;
				}
			}
			if (warning != null && effectController != null)
			{
				effectController.Hide(v: false);
				warning.Angle = mAlertValue * 2f / mAlertMaxValue;
				if (mainCamera == null)
				{
					mainCamera = Camera.main;
				}
				if (mainCamera != null)
				{
					locker1.transform.forward = -mainCamera.transform.forward;
				}
			}
			return;
		}
		if (targetInView)
		{
			targetInView = false;
			SendCommand(EnemyAlertState.LoseTarget);
		}
		if (mAlertValue > 0f)
		{
			mAlertValue -= mAlertUpdateSubValue;
			if (mAlertValue <= 0f)
			{
				mAlertValue = 0f;
				SendCommand(EnemyAlertState.AlertValueEmpty);
			}
		}
		if (!(warning != null) || !(effectController != null))
		{
			return;
		}
		if (mAlertValue > 0f)
		{
			if (warning.shape != WarningManager.Shape.Fanshape)
			{
				warning.shape = WarningManager.Shape.Fanshape;
			}
			effectController.Hide(v: false);
			warning.Angle = mAlertValue * 2f / mAlertMaxValue;
			if (mainCamera == null)
			{
				mainCamera = Camera.main;
			}
			if (mainCamera != null)
			{
				locker1.transform.forward = -mainCamera.transform.forward;
			}
		}
		else
		{
			effectController.Hide(v: true);
		}
	}

	public void SendCommand(EnemyAlertState state)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null)
		{
			NAgent playerAgent = agentManager.GetPlayerAgent();
			if (!(playerAgent as AgentHuman == null) && !(playerAgent.transform == null) && !(mAgent == null) && !(mAgent.transform == null))
			{
				EnemyAlertCommand enemyAlertCommand = CommandFactory.Create(NetprotoOperationCode.CmdEnemyAlert) as EnemyAlertCommand;
				enemyAlertCommand.SetData(playerAgent.AgentID, mAgent.AgentID, state);
				ClientSimulator.Instance.SendLocalCommand(enemyAlertCommand);
			}
		}
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		active = false;
		targetInView = false;
		mAlertValue = 0f;
		warning = null;
		effectController = null;
		if (locker1 != null)
		{
			PooledAsset.DestroyOrReturn(locker1);
		}
	}

	public void ActiveComponent()
	{
		active = true;
		currentTime = 0;
		targetInView = false;
		mAlertValue = 0f;
	}
}
