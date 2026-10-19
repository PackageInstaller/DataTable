using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Sound;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/ElevatorBehaveEvents")]
public class ElevatorBehaveEvents : MonoBehaviour
{
	public bool useSpeed;

	public InteractElevator interactElevator;

	public Renderer tarRenderer;

	public AudioEventReference audioStartSound;

	public AudioEventReference audioStopSound;

	public AudioEventReference audioRunSound;

	public Color defaultColor;

	public Color runColor;

	public float tarColorTime;

	public float speed;

	public bool customRayFirePoint;

	public Transform firePoint;

	private ElevBehaveCustomData customData;

	[NonSerialized]
	public int stateId;

	[SerializeField]
	private List<ElevatorInfo> stopInfos;

	private Rigidbody rig;

	private bool m_Reverse;

	private int m_AimIndex;

	private int m_Index;

	private bool obstacleElevator;

	private bool auto;

	[NonSerialized]
	public bool stop;

	private bool init;

	private float stopTime;

	private float timeFlag;

	private float obstacletimeFlag;

	private uint soundTagUid;

	private Vector3 currTargetPos;

	private SystemTime systemTime;

	private Quaternion m_CurTargetRotate;

	private Vector3 runStartPos;

	private Quaternion runStartRotate;

	private float runElapsedTime;

	private float runMoveDuration;

	private float runRotateDuration;

	private bool m_InvalidStopIndexLogged;

	private int nextIndex;

	private Vector3 nextPos;

	private Quaternion m_NextRotate;

	private float m_RotateSpeed;

	public int phase;

	public int aimIndex
	{
		get
		{
			return m_AimIndex;
		}
		set
		{
			if (CheckStopIndex(value, "aimIndex"))
			{
				m_AimIndex = value;
			}
		}
	}

	public bool reverse
	{
		get
		{
			return m_Reverse;
		}
		set
		{
			if (m_Reverse != value)
			{
				onReverseChanged?.Invoke();
			}
			m_Reverse = value;
		}
	}

	public event Action onReverseChanged;

	private bool CheckStopIndex(int index, string source)
	{
		if (stopInfos != null && index >= 0 && index < stopInfos.Count)
		{
			return true;
		}
		if (!m_InvalidStopIndexLogged)
		{
			m_InvalidStopIndexLogged = true;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"电梯站点索引无效：name={name}, position={transform.position}, source={source}, index={index}, count={stopInfos?.Count ?? 0}, current={m_Index}, aim={m_AimIndex}, next={nextIndex}, auto={auto}, direct={customData.nonautoDirectMovement}, phase={phase}", this);
			}
		}
		return false;
	}

	public void OnInit(int stateId)
	{
		init = false;
		systemTime = GameManager.timeSystem;
		rig = GetComponent<Rigidbody>();
		ElevatorData elevatorData = (ElevatorData)interactElevator.entity.GetCompStateObject().StateWorldAssetData;
		stopInfos = elevatorData.stopInfos;
		auto = interactElevator.auto;
		customData = elevatorData.behaveCustom;
		m_AimIndex = stateId;
		m_Index = (nextIndex = stateId);
		if (CheckStopIndex(stateId, "OnInit"))
		{
			if (customData.useSpeed)
			{
				useSpeed = true;
				speed = customData.speed;
			}
			if (customData.usePathTime)
			{
				useSpeed = false;
			}
			rig.position = stopInfos[stateId].position;
			rig.rotation = stopInfos[stateId].position.rotate;
			onReverseChanged += ReverseRun;
			init = true;
		}
	}

	private void FixedUpdate()
	{
		if (init)
		{
			switch (phase)
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

	private void OnDestroy()
	{
		Singleton<GameManager>.instance.audioManager.Stop(soundTagUid);
	}

	public void HandleEnterState(int stateId)
	{
		switch (stateId)
		{
		case 0:
			stop = false;
			break;
		case 1:
			stop = true;
			break;
		case 2:
			stop = true;
			reverse = false;
			break;
		case 3:
			stop = true;
			reverse = true;
			break;
		case 4:
			stop = false;
			reverse = false;
			break;
		case 5:
			stop = false;
			reverse = true;
			break;
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
			break;
		}
	}

	public int GetState()
	{
		if (stop)
		{
			if (!reverse)
			{
				return 2;
			}
			return 3;
		}
		if (!reverse)
		{
			return 4;
		}
		return 5;
	}

	public int CalcuAimIndex(bool backward)
	{
		int result;
		int index;
		if (backward)
		{
			index = m_Index;
			if (index <= 0)
			{
				if (index < 0)
				{
					throw new NotImplementedException();
				}
				result = stopInfos.Count - 1;
			}
			else
			{
				result = m_Index - 1;
			}
			return result;
		}
		result = stopInfos.Count - 1 - m_Index;
		if (result <= 0)
		{
			if (result < 0)
			{
				throw new NotImplementedException();
			}
			index = 0;
		}
		else
		{
			index = m_Index + 1;
		}
		return index;
	}

	private bool TryCalculateNext()
	{
		if (!CheckStopIndex(m_Index, "TryCalculateNext") || (!auto && !CheckStopIndex(m_AimIndex, "TryCalculateNext")))
		{
			return false;
		}
		if (!auto)
		{
			if (customData.nonautoDirectMovement)
			{
				nextIndex = m_AimIndex;
			}
			else if (m_Index == stopInfos.Count - 1)
			{
				nextIndex = 0;
			}
			else
			{
				nextIndex = m_Index + 1;
			}
		}
		else
		{
			nextIndex = (m_AimIndex = CalcuAimIndex(reverse));
		}
		m_NextRotate = stopInfos[nextIndex].position.rotate;
		nextPos = stopInfos[nextIndex].position;
		if (!useSpeed)
		{
			speed = Vector3.Distance(stopInfos[m_Index].position, nextPos) / NextPathTime(m_Index);
		}
		m_RotateSpeed = Quaternion.Angle(stopInfos[m_Index].position.rotate, m_NextRotate) / NextPathTime(m_Index);
		return true;
	}

	private float NextPathTime(int index)
	{
		if (reverse)
		{
			return stopInfos[(index - 1 < 0) ? (stopInfos.Count - 1) : (index - 1)].nextPathTime;
		}
		return stopInfos[index].nextPathTime;
	}

	private void ResetRunProgress()
	{
		runStartPos = rig.position;
		runStartRotate = rig.rotation;
		runElapsedTime = 0f;
		float amount = Vector3.Distance(runStartPos, nextPos);
		float amount2 = Quaternion.Angle(runStartRotate, m_NextRotate);
		runMoveDuration = (useSpeed ? CalculateDuration(amount, speed) : NextPathTime(m_Index));
		runRotateDuration = CalculateDuration(amount2, m_RotateSpeed);
	}

	private float CalculateDuration(float amount, float speed)
	{
		if (amount <= 0f)
		{
			return 0f;
		}
		if (!(speed > 0f))
		{
			return float.PositiveInfinity;
		}
		return amount / speed;
	}

	private float CalculateProgress(float elapsedTime, float duration)
	{
		if (!(duration <= 0f))
		{
			return Mathf.Clamp01(elapsedTime / duration);
		}
		return 1f;
	}

	private Vector3 CalculateRunPosition(float elapsedTime)
	{
		return Vector3.Lerp(runStartPos, nextPos, CalculateProgress(elapsedTime, runMoveDuration));
	}

	private Quaternion CalculateRunRotation(float elapsedTime)
	{
		return Quaternion.Slerp(runStartRotate, m_NextRotate, CalculateProgress(elapsedTime, runRotateDuration));
	}

	private bool IsRunFinished()
	{
		if (runElapsedTime >= runMoveDuration)
		{
			return runElapsedTime >= runRotateDuration;
		}
		return false;
	}

	private void OnStopping()
	{
		if (!CheckStopIndex(m_Index, "OnStopping"))
		{
			return;
		}
		if (auto)
		{
			if (stop)
			{
				stopTime = 1000f;
				return;
			}
			stopTime += interactElevator.entity.GetCompTime().fixedDeltaTime * systemTime.globalSpeed;
			if (stopTime >= stopInfos[m_Index].waitingTime)
			{
				stopTime = 0f;
				if (TryCalculateNext())
				{
					phase = 1;
					OnStart();
				}
			}
		}
		else if (m_AimIndex != m_Index && TryCalculateNext())
		{
			phase = 1;
			OnStart();
		}
	}

	private void OnStart()
	{
		ResetRunProgress();
		phase = 2;
		Singleton<GameManager>.instance.audioManager.PlaySound(audioStartSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		soundTagUid = Singleton<GameManager>.instance.audioManager.PlaySound(audioRunSound, new AudioPlayOptions
		{
			attachTarget = transform,
			IsLoop = true
		});
		timeFlag = Time.time;
	}

	private void OnRunning()
	{
		if (!CheckStopIndex(m_Index, "OnRunning") || !CheckStopIndex(nextIndex, "OnRunning"))
		{
			OnBrake();
			return;
		}
		if (stop)
		{
			phase = 3;
			OnBrake();
		}
		if (!MonoECS.instance.running)
		{
			return;
		}
		float num = interactElevator.entity.GetCompTime().fixedDeltaTime * systemTime.globalSpeed;
		float elapsedTime = runElapsedTime + num;
		currTargetPos = CalculateRunPosition(elapsedTime);
		m_CurTargetRotate = CalculateRunRotation(elapsedTime);
		if (tarRenderer != null)
		{
			tarRenderer.material.SetColor("_EmissionColor", Color.Lerp(defaultColor, runColor, (Time.time - timeFlag) * systemTime.globalSpeed / tarColorTime));
		}
		if (interactElevator.elevatorGroup && interactElevator.obstacle && !obstacleElevator)
		{
			return;
		}
		if (customData.obstacleDetection)
		{
			Vector3 vector = currTargetPos - rig.position;
			bool flag = false;
			if (MathF.Abs(Vector3.Dot(vector.normalized, Vector3.right)) >= MathF.Cos(MathF.PI / 4f))
			{
				if (customData.x)
				{
					flag = true;
				}
			}
			else if (MathF.Abs(Vector3.Dot(vector.normalized, Vector3.forward)) >= MathF.Cos(MathF.PI / 4f))
			{
				if (customData.z)
				{
					flag = true;
				}
			}
			else if (customData.y)
			{
				flag = true;
			}
			if (flag && Physics.CheckBox((customRayFirePoint ? firePoint.position : rig.position) + customData.stopDistance * vector.normalized, customData.boxSize / 2f, rig.rotation, customData.colliderLayer.value, QueryTriggerInteraction.Ignore))
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
		runElapsedTime = elapsedTime;
		if (IsRunFinished())
		{
			m_Index = nextIndex;
			if (auto)
			{
				phase = 3;
				OnBrake();
			}
			else if (m_Index == m_AimIndex)
			{
				Finish();
				phase = 3;
				OnBrake();
			}
			else
			{
				if (!TryCalculateNext())
				{
					OnBrake();
					return;
				}
				ResetRunProgress();
			}
		}
		rig.MoveRotation(m_CurTargetRotate);
		rig.MovePosition(currTargetPos);
	}

	private void Finish()
	{
		if (interactElevator.elevatorGroup && this == interactElevator.elevators[0])
		{
			interactElevator.TaskFinishCallBack();
		}
		else
		{
			interactElevator.TaskFinishCallBack();
		}
	}

	private void OnBrake()
	{
		if (tarRenderer != null)
		{
			tarRenderer.material.SetColor("_EmissionColor", defaultColor);
		}
		Singleton<GameManager>.instance.audioManager.PlaySound(audioStopSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		Singleton<GameManager>.instance.audioManager.Stop(soundTagUid);
		phase = 0;
	}

	public void ReverseRun()
	{
		if (m_Index != nextIndex && CheckStopIndex(m_Index, "ReverseRun") && CheckStopIndex(nextIndex, "ReverseRun"))
		{
			int index = m_Index;
			m_Index = nextIndex;
			nextIndex = index;
			nextPos = stopInfos[nextIndex].position;
			ResetRunProgress();
		}
	}
}
