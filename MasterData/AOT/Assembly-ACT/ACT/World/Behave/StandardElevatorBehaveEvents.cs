using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using ACT.Sound;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/StandardElevatorBehaveEvents")]
public class StandardElevatorBehaveEvents : MonoBehaviour
{
	public Animator animator;

	public InteractStandardElevator interactElevator;

	public Rigidbody rig;

	public float speed;

	private List<StandardElevatorLayer> m_ElevatorLayers;

	public bool customRayFirePoint;

	public bool InheritSpeed;

	public Transform firePoint;

	private int m_AimIndex;

	private int m_AimStateId;

	private int m_Index;

	private bool m_ArrivalHandled;

	private bool init;

	private float obstacletimeFlag;

	private bool obstacleElevator;

	private SystemTime systemTime;

	private ElevBehaveCustomData customData;

	private uint _runLoopSoundUid;

	private Vector3 _runStartPosition;

	private float _runElapsedTime;

	private float _runDuration;

	private int m_NextIndex;

	private Vector3 m_NextPos;

	private int _phase;

	public int aimIndex
	{
		get
		{
			return m_AimIndex;
		}
		set
		{
			m_AimIndex = value;
		}
	}

	public int Phase
	{
		get
		{
			return _phase;
		}
		private set
		{
			_phase = value;
			if (interactElevator.Enter)
			{
				Model<InteractModel>.Interface.SetRunningInSide(_phase == 2);
			}
		}
	}

	public void OnInit(int stateId)
	{
		systemTime = GameManager.timeSystem;
		rig = GetComponent<Rigidbody>();
		StandardElevatorData standardElevatorData = (StandardElevatorData)interactElevator.entity.GetCompStateObject().StateWorldAssetData;
		m_ElevatorLayers = standardElevatorData.layers;
		m_AimIndex = stateId;
		m_AimStateId = stateId;
		m_Index = stateId;
		m_ArrivalHandled = false;
		rig.position = m_ElevatorLayers[stateId].pos;
		customData = standardElevatorData.obstacle;
		init = true;
	}

	public void SetTargetState(int targetStateId)
	{
		StandardElevatorData standardElevatorData = (StandardElevatorData)interactElevator.entity.GetCompStateObject().StateWorldAssetData;
		m_AimStateId = targetStateId;
		m_ArrivalHandled = false;
		aimIndex = standardElevatorData.GetLayerIndex(targetStateId);
	}

	private void FixedUpdate()
	{
		if (init)
		{
			switch (Phase)
			{
			case 0:
				OnStopping();
				break;
			case 2:
				OnRunning();
				break;
			}
		}
	}

	private void CalculateNext()
	{
		int num = m_AimIndex - m_Index;
		int nextIndex;
		if (num <= 0)
		{
			if (num >= 0)
			{
				throw new NotImplementedException();
			}
			nextIndex = m_Index - 1;
		}
		else
		{
			nextIndex = m_Index + 1;
		}
		m_NextIndex = nextIndex;
		m_NextPos = m_ElevatorLayers[m_NextIndex].pos;
	}

	private void OnStopping()
	{
		if (m_AimIndex != m_Index)
		{
			CalculateNext();
			Phase = 1;
			OnStart();
		}
	}

	private void OnStart()
	{
		ResetRunProgress(rig.position);
		StandardElevatorData data = interactElevator.Data;
		Singleton<GameManager>.instance.audioManager.PlaySound(data.AudioStartSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		_runLoopSoundUid = Singleton<GameManager>.instance.audioManager.PlaySound(data.AudioRunLoopSound, new AudioPlayOptions
		{
			attachTarget = transform,
			IsLoop = true
		});
		animator.SetBool("isOpen", value: false);
	}

	public void CompleteClose()
	{
		Phase = 2;
	}

	private void OnRunning()
	{
		ChangeElevatorToMovingPlatformOnRunning();
		float num = interactElevator.entity.GetCompTime().fixedDeltaTime * systemTime.globalSpeed;
		float num2 = _runElapsedTime + num;
		Vector3 vector = Vector3.Lerp(_runStartPosition, m_NextPos, CalculateRunProgress(num2));
		bool flag = num2 >= _runDuration;
		if (customData.obstacleDetection)
		{
			Vector3 vector2 = vector - transform.position;
			bool flag2 = false;
			if (MathF.Abs(Vector3.Dot(vector2.normalized, Vector3.right)) >= MathF.Cos(MathF.PI / 4f))
			{
				if (customData.x)
				{
					flag2 = true;
				}
			}
			else if (MathF.Abs(Vector3.Dot(vector2.normalized, Vector3.forward)) >= MathF.Cos(MathF.PI / 4f))
			{
				if (customData.z)
				{
					flag2 = true;
				}
			}
			else if (customData.y)
			{
				flag2 = true;
			}
			if (flag2 && Physics.CheckBox((customRayFirePoint ? firePoint.position : transform.position) + customData.stopDistance * vector2.normalized, customData.boxSize / 2f, transform.rotation, customData.colliderLayer.value, QueryTriggerInteraction.Ignore))
			{
				obstacletimeFlag = Time.time;
				interactElevator.obstacle = true;
				obstacleElevator = true;
				return;
			}
			if (Time.time - obstacletimeFlag < customData.waitTime)
			{
				return;
			}
			if (interactElevator.obstacle)
			{
				interactElevator.obstacle = false;
			}
			if (obstacleElevator)
			{
				obstacleElevator = false;
			}
		}
		_runElapsedTime = num2;
		if (flag)
		{
			m_Index = m_NextIndex;
			if (m_Index == m_AimIndex)
			{
				Phase = 3;
				OnBrake();
			}
			else
			{
				CalculateNext();
				ResetRunProgress(vector);
			}
		}
		rig.MovePosition(vector);
	}

	private void ResetRunProgress(Vector3 startPosition)
	{
		_runStartPosition = startPosition;
		_runElapsedTime = 0f;
		float num = Vector3.Distance(m_ElevatorLayers[m_Index].pos, m_NextPos);
		ref float runDuration = ref _runDuration;
		float num2;
		if (num <= 0f)
		{
			num2 = 0f;
		}
		else
		{
			num2 = ((speed > 0f) ? (num / speed) : float.PositiveInfinity);
		}
		runDuration = num2;
	}

	private float CalculateRunProgress(float elapsedTime)
	{
		if (!(_runDuration <= 0f))
		{
			return Mathf.Clamp01(elapsedTime / _runDuration);
		}
		return 1f;
	}

	public void Update()
	{
		if (init && Phase == 3 && !m_ArrivalHandled)
		{
			m_ArrivalHandled = true;
			interactElevator.NetEnterState(m_AimStateId).Forget();
			interactElevator.RunChangeStateObjects(start: false);
		}
	}

	private void OnBrake()
	{
		StandardElevatorData data = interactElevator.Data;
		Singleton<GameManager>.instance.audioManager.PlaySound(data.AudioStopSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		Singleton<GameManager>.instance.audioManager.Stop(_runLoopSoundUid);
		animator.SetBool("isOpen", value: true);
	}

	public void CompleteOpen()
	{
		Phase = 0;
		interactElevator.CompleteTransitionClear();
		MonoECS.instance.mainEntity.GetCompPhysics().characterMovement.SetPlatform(null);
		if (interactElevator.Enter)
		{
			Model<InteractModel>.Interface.OnElevatorHandleMove(isMoving: false);
		}
	}

	private void ChangeElevatorToMovingPlatformOnRunning()
	{
		if (InheritSpeed && interactElevator.Enter && _phase == 2)
		{
			bool isValid = MonoECS.instance.mainEntity.IsValid;
			CompPhysics compPhysics = MonoECS.instance.mainEntity.GetCompPhysics();
			if (isValid && compPhysics != null && compPhysics.characterMovement != null)
			{
				compPhysics.characterMovement.SetPlatform(rig);
			}
		}
	}

	private void OnDestroy()
	{
		Singleton<GameManager>.instance.audioManager.Stop(_runLoopSoundUid);
	}
}
