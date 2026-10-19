using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Sound;
using ACT.Utility;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/DarkCoreStoneBehaveEvents")]
public class DarkCoreStoneBehaveEvents : MonoBehaviour
{
	public bool useSpeed;

	public bool closeSound;

	public EventReference startSound;

	public AudioEventReference audioStartSound;

	public EventReference stopSound;

	public AudioEventReference audioStopSound;

	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public float speed;

	public InteractDarkCoreStone interactDarkCoreStone;

	public Animator animator;

	public int stopAniIndex;

	public int phase;

	[NonSerialized]
	public bool stop;

	[NonSerialized]
	public int stateId;

	private ElevBehaveCustomData m_CustomData;

	private List<StoneStopInfo> m_StopInfos;

	private int m_AimIndex;

	private Rigidbody m_Rig;

	private SystemTime m_SystemTime;

	private int m_Index;

	private int m_NextIndex;

	private Vector3 m_NextPos;

	private bool m_Init;

	private Vector3 m_CurrTargetPos;

	private float m_ObstacletimeFlag;

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

	public void OnInit(int stateId)
	{
		m_SystemTime = GameManager.timeSystem;
		m_Rig = GetComponent<Rigidbody>();
		DarkCoreStoneData darkCoreStoneData = interactDarkCoreStone.entity.GetCompStateObject().StateWorldAssetData as DarkCoreStoneData;
		m_StopInfos = darkCoreStoneData.stopInfos;
		m_CustomData = darkCoreStoneData.behaveCustom;
		m_AimIndex = stateId;
		m_Index = (m_NextIndex = stateId);
		if (m_CustomData.useSpeed)
		{
			useSpeed = true;
			speed = m_CustomData.speed;
		}
		if (m_CustomData.usePathTime)
		{
			useSpeed = false;
		}
		m_Rig.position = m_StopInfos[stateId].position;
		m_Init = true;
	}

	private void FixedUpdate()
	{
		if (m_Init)
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

	private void OnStopping()
	{
		if (m_AimIndex != m_Index)
		{
			CalculateNext();
			phase = 1;
			OnStart();
		}
	}

	public void Hide()
	{
		animator.SetInteger("state", 2);
	}

	public void Show()
	{
		animator.SetInteger("state", 0);
	}

	private void OnStart()
	{
		phase = 2;
		if (!closeSound)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
			{
				attachTarget = interactDarkCoreStone.entity.GetRootTransform()
			});
		}
	}

	private void OnRunning()
	{
		if (stop)
		{
			phase = 3;
			OnBrake();
		}
		if (!MonoECS.instance.running)
		{
			return;
		}
		m_CurrTargetPos = InterpolationUtility.FixedLerp(transform.position, m_NextPos, speed * Time.fixedDeltaTime * m_SystemTime.globalSpeed, out var _);
		if (m_CustomData.obstacleDetection)
		{
			_ = m_CurrTargetPos - transform.position;
		}
		if (Time.time - m_ObstacletimeFlag < m_CustomData.waitTime)
		{
			return;
		}
		if (m_CurrTargetPos == m_NextPos)
		{
			m_Index = m_NextIndex;
			if (m_Index == m_AimIndex)
			{
				phase = 3;
				OnBrake();
			}
			else
			{
				CalculateNext();
			}
		}
		m_Rig.MovePosition(m_CurrTargetPos);
	}

	private void OnBrake()
	{
		if (!closeSound)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioStopSound, new AudioPlayOptions
			{
				attachTarget = interactDarkCoreStone.entity.GetRootTransform()
			});
		}
	}

	private void CalculateNext()
	{
		if (m_Index == m_StopInfos.Count - 1)
		{
			m_NextIndex = 0;
		}
		else
		{
			m_NextIndex = m_Index + 1;
		}
		m_NextPos = m_StopInfos[m_NextIndex].position;
		if (!useSpeed)
		{
			speed = Vector3.Distance(m_StopInfos[m_Index].position, m_NextPos) / NextPathTime(m_Index);
		}
	}

	private float NextPathTime(int index)
	{
		return m_StopInfos[index].nextPathTime;
	}
}
