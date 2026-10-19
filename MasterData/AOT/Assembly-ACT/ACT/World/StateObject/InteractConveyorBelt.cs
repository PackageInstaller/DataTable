using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Sound;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.Behave;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using Runtime.World.StateObject.Behave;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractConveyorBelt : StateObjectBase
{
	private Vector3 m_Dir;

	private float m_BeltLength;

	private ConveyorBeltData m_Data;

	private float m_Velocity;

	private bool m_Init;

	private List<StateObjectBase> m_LinkObjs = new List<StateObjectBase>();

	private Dictionary<StateObjectBase, Vector3> m_ObjectPositions = new Dictionary<StateObjectBase, Vector3>();

	private AssetLoadHandle[] m_Handles;

	private IDisposable m_SyncAttackablePositionDisposable;

	private Vector3 m_TargetPos;

	private Vector3 m_NextPos;

	private float m_DistanceFromStart;

	private Rigidbody m_PrarentRigdBody;

	[SerializeField]
	private Transform m_Start;

	[SerializeField]
	private Transform m_End;

	private ConveyorBeltModel[] _beltModels;

	private uint _runLoopEvent;

	private uint _stopLoopEvent;

	public override bool serviceSave => true;

	public override async void InitStateObject(int stateId)
	{
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is ConveyorBeltData data))
		{
			return;
		}
		m_Data = data;
		m_Start.position = m_Data.startPos.value;
		m_End.position = m_Data.endPos.value;
		m_BeltLength = Vector3.Distance(m_Start.position, m_End.position);
		float step = 2f;
		Vector3 direction = (m_End.position - m_Start.position).normalized;
		int count = Mathf.Max(0, Mathf.FloorToInt((m_BeltLength - 2f) / step) + 1);
		_beltModels = new ConveyorBeltModel[count];
		m_Handles = new AssetLoadHandle[count];
		for (int i = 0; i < count; i++)
		{
			float num = 1f + (float)i * step;
			Vector3 position = m_Start.position + direction * num;
			Vector3 localPos = transform.InverseTransformPoint(position);
			if (m_Data.conveyorBeltAddressAssetID != null && m_Data.conveyorBeltAddressAssetID.RuntimeKeyIsValid())
			{
				m_Handles[i] = AssetStationManager.BattleStation.InstantiateAsync(m_Data.conveyorBeltAddressAssetID, transform);
				await m_Handles[i];
				GameObject gameObject = m_Handles[i].AsGameObject();
				gameObject.transform.localPosition = localPos;
				_beltModels[i] = gameObject.GetComponent<ConveyorBeltModel>();
				_beltModels[i].Init();
				_beltModels[i].OnChangeState(stateId);
			}
		}
		GameObject gameObject2 = new GameObject("BeltCollider");
		gameObject2.transform.parent = transform;
		gameObject2.transform.position = (m_Start.position + m_End.position) / 2f;
		BoxCollider boxCollider = gameObject2.AddComponent<BoxCollider>();
		ConveyorBeltBehaveEvent conveyorBeltBehaveEvent = gameObject2.AddComponent<ConveyorBeltBehaveEvent>();
		boxCollider.size = new Vector3(m_BeltLength, 0.15f, 2.5f);
		conveyorBeltBehaveEvent.interactConveyorBelt = this;
		base.InitStateObject(stateId);
		SyncLinkObjs().Forget();
	}

	protected override void HandleInitState(int stateId)
	{
		if (stateId == 0 || stateId == 1)
		{
			AudioEventReference audioRunLoopEvent = m_Data.AudioRunLoopEvent;
			if (!audioRunLoopEvent.IsNull())
			{
				_runLoopEvent = Singleton<GameManager>.instance.audioManager.PlaySound(audioRunLoopEvent, new AudioPlayOptions
				{
					IsLoop = true,
					attachTarget = transform
				});
			}
			if (_stopLoopEvent != 0)
			{
				Singleton<GameManager>.instance.audioManager.Stop(_stopLoopEvent);
			}
		}
		switch (stateId)
		{
		case 0:
			m_Velocity = m_Data.velocity;
			m_Dir = (m_End.position - m_Start.position).normalized;
			break;
		case 1:
			m_Velocity = m_Data.velocity;
			m_Dir = (m_Start.position - m_End.position).normalized;
			break;
		case 2:
		{
			m_Velocity = 0f;
			AudioEventReference audioStopLoopEvent = m_Data.AudioStopLoopEvent;
			if (!audioStopLoopEvent.IsNull())
			{
				_stopLoopEvent = Singleton<GameManager>.instance.audioManager.PlaySound(audioStopLoopEvent, new AudioPlayOptions
				{
					IsLoop = true,
					attachTarget = transform
				});
			}
			if (_runLoopEvent != 0)
			{
				Singleton<GameManager>.instance.audioManager.Stop(_runLoopEvent);
			}
			break;
		}
		case -1:
			m_Velocity = 0f;
			gameObject.SetActive(value: false);
			foreach (StateObjectBase linkObj in m_LinkObjs)
			{
				linkObj.gameObject.SetActive(value: false);
			}
			break;
		}
		ConveyorBeltModel[] beltModels = _beltModels;
		foreach (ConveyorBeltModel conveyorBeltModel in beltModels)
		{
			if ((bool)conveyorBeltModel)
			{
				conveyorBeltModel.OnChangeState(stateId);
			}
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (fromStateId == -1)
		{
			foreach (StateObjectBase linkObj in m_LinkObjs)
			{
				linkObj.gameObject.SetActive(value: true);
			}
			gameObject.SetActive(value: true);
		}
		if ((fromStateId == 0 || fromStateId == 1) && (toStateId == 0 || toStateId == 1))
		{
			AudioEventReference audioChangeEvent = m_Data.AudioChangeEvent;
			if (!audioChangeEvent.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(audioChangeEvent, new AudioPlayOptions
				{
					attachTarget = transform
				});
			}
		}
	}

	private async UniTask SyncLinkObjs()
	{
		if (m_Data.linkStateComps == null)
		{
			return;
		}
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		foreach (StateWorldUid uid in m_Data.linkStateComps)
		{
			if (!StateWorldAsset.TryGetWorldAssetBySwid(uid, out var stateWorldAsset))
			{
				int num;
				do
				{
					num = uid;
				}
				while (num != await ruleManager.parentSwid.WaitAsync());
				StateWorldAsset.TryGetWorldAssetBySwid(uid, out var stateWorldAsset2);
				Rigidbody rigidbody = stateWorldAsset2.stateObjectBase.gameObject.AddComponent<Rigidbody>();
				rigidbody.isKinematic = true;
				rigidbody.useGravity = false;
				rigidbody.interpolation = RigidbodyInterpolation.Interpolate;
				rigidbody.collisionDetectionMode = CollisionDetectionMode.Discrete;
				m_LinkObjs.Add(stateWorldAsset2.stateObjectBase);
				m_ObjectPositions[stateWorldAsset2.stateObjectBase] = stateWorldAsset2.stateObjectBase.transform.position;
			}
			else
			{
				Rigidbody rigidbody2 = stateWorldAsset.stateObjectBase.gameObject.AddComponent<Rigidbody>();
				rigidbody2.isKinematic = true;
				rigidbody2.useGravity = false;
				rigidbody2.interpolation = RigidbodyInterpolation.Interpolate;
				rigidbody2.collisionDetectionMode = CollisionDetectionMode.Discrete;
				m_LinkObjs.Add(stateWorldAsset.stateObjectBase);
				m_ObjectPositions[stateWorldAsset.stateObjectBase] = stateWorldAsset.stateObjectBase.transform.position;
			}
		}
		m_SyncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			Vector3 vector = ((currentStateId == 0) ? (m_End.position - m_Start.position).normalized : (m_Start.position - m_End.position).normalized);
			Vector3 vector2 = ((currentStateId == 0) ? m_Start.position : m_End.position);
			Vector3 b = ((currentStateId == 0) ? m_End.position : m_Start.position);
			m_BeltLength = Vector3.Distance(vector2, b);
			SystemTime timeSystem = GameManager.timeSystem;
			foreach (StateObjectBase linkObj in m_LinkObjs)
			{
				if (!(linkObj == null))
				{
					float num2 = timeSystem.globalSpeed * linkObj.entity.GetCompTime().fixedDeltaTime;
					Rigidbody component = linkObj.GetComponent<Rigidbody>();
					Vector3 vector3 = Vector3.zero;
					if (m_ObjectPositions.ContainsKey(this))
					{
						Vector3 vector4 = m_ObjectPositions[this];
						vector3 = (transform.position - vector4) / num2;
					}
					Vector3 vector5 = vector;
					if (vector3.magnitude > 0.01f)
					{
						vector5 = (vector * m_Velocity + vector3).normalized;
					}
					float num3 = m_Velocity;
					if (vector3.magnitude > 0.01f)
					{
						float num4 = Vector3.Dot(vector3, vector);
						num3 = Mathf.Sqrt(m_Velocity * m_Velocity + vector3.magnitude * vector3.magnitude + 2f * m_Velocity * num4);
					}
					m_NextPos = component.position + vector5 * num3 * num2;
					float num5 = Vector3.Distance(m_NextPos, b);
					float num6 = Vector3.Distance(component.position, vector2);
					if (num5 < 0.1f || num6 > m_BeltLength * 1.5f)
					{
						Vector3 vector6 = Vector3.ProjectOnPlane(component.position - vector2, vector);
						m_NextPos = vector2 + vector6;
					}
					component.MovePosition(m_NextPos);
					m_ObjectPositions[linkObj] = m_NextPos;
				}
			}
			if (!m_ObjectPositions.ContainsKey(this))
			{
				m_ObjectPositions.Add(this, transform.position);
			}
			else
			{
				m_ObjectPositions[this] = transform.position;
			}
		});
		m_Init = true;
	}

	private void Update()
	{
		if (!m_Init)
		{
			return;
		}
		int num = currentStateId;
		if (num != 0 && num != 1)
		{
			return;
		}
		foreach (StateObjectBase linkObj in m_LinkObjs)
		{
			if (linkObj != null)
			{
				Rigidbody component = linkObj.GetComponent<Rigidbody>();
				switch (currentStateId)
				{
				case 0:
					m_DistanceFromStart = Vector3.Distance(m_Start.position, component.position);
					break;
				case 1:
					m_DistanceFromStart = Vector3.Distance(m_End.position, component.position);
					break;
				}
				if (m_DistanceFromStart > m_BeltLength)
				{
					component.isKinematic = false;
					component.position -= m_DistanceFromStart * m_Dir;
					component.isKinematic = true;
				}
			}
		}
		ConveyorBeltModel[] beltModels = _beltModels;
		foreach (ConveyorBeltModel conveyorBeltModel in beltModels)
		{
			if (Vector3.Dot(m_Dir, Vector3.right) > 0f)
			{
				conveyorBeltModel.UpdateValue(0f - m_Velocity, left: false);
			}
			else
			{
				conveyorBeltModel.UpdateValue(m_Velocity, left: true);
			}
		}
	}

	public void PhysicsInteract(Entity entity)
	{
		if (entity.IsCharacter() || (entity.IsMonster() && CompPhysics.IsGroundLikeMotion(entity.GetCompPhysics().motion)))
		{
			entity.GetCompPhysics().characterMovement.AddForce(m_Dir * m_Velocity, ForceMode.VelocityChange);
		}
	}

	public override void ReleaseStateObject()
	{
		for (int i = 0; i < m_Handles.Length; i++)
		{
			if (AssetLoadHandleExtensions.IsValid(m_Handles[i]))
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_Handles[i]);
			}
		}
		m_SyncAttackablePositionDisposable?.Dispose();
		if (_runLoopEvent != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_runLoopEvent);
		}
		if (_stopLoopEvent != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_stopLoopEvent);
		}
		base.ReleaseStateObject();
	}

	public void OnDestroy()
	{
		m_SyncAttackablePositionDisposable?.Dispose();
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1 && stateId != 2)
		{
			return stateId == -1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
