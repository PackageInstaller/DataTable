using ACT.Battle;
using ACT.Sound;
using ACT.Utility;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

public class SubmergePlatformBehaveEvents : MonoBehaviour
{
	public Animator animator;

	public Rigidbody rig;

	private InteractSubmergePlatform m_SubmergePlatform;

	private SubmergePlatformData m_Data;

	private bool m_Init;

	private Vector3 m_NextPos;

	private float m_Speed;

	private SystemTime m_SystemTime;

	private float m_WaitTime;

	private float m_ReverseWaitTime;

	private float m_InChingTime;

	private int m_NextIndex;

	public int m_LastIndex;

	private float _effectTime;

	private bool _inEffectTime;

	private bool _effect;

	private int m_Phase;

	private uint m_StartToEndLoopEvent;

	private uint m_EndToStartLoopEvent;

	public bool Effect
	{
		get
		{
			if (!_effect)
			{
				return _inEffectTime;
			}
			return true;
		}
		set
		{
			if (value != _effect)
			{
				if (value)
				{
					_inEffectTime = false;
					Phase = 0;
				}
				else
				{
					_inEffectTime = true;
					_effectTime = m_Data.inPlatformTime;
				}
				_effect = value;
			}
		}
	}

	internal int Phase
	{
		get
		{
			return m_Phase;
		}
		set
		{
			OnChangePhase(m_Phase, value);
			m_Phase = value;
		}
	}

	public void Init(InteractSubmergePlatform interact, SubmergePlatformData data, int state)
	{
		m_SystemTime = GameManager.timeSystem;
		m_SubmergePlatform = interact;
		m_Data = data;
		OnChangeState(state, data);
		PushImpetusGameObject componentInChildren = GetComponentInChildren<PushImpetusGameObject>();
		if (componentInChildren != null)
		{
			componentInChildren.InitConfig(m_Data.pushImpetusConfig);
		}
		m_Init = true;
	}

	public void OnChangeState(int state, SubmergePlatformData data)
	{
		if (state == 0)
		{
			gameObject.SetActive(value: true);
			Transform transform = base.transform;
			Vector3 nextPos = (rig.position = data.pathInfos[state].position);
			transform.position = (m_NextPos = nextPos);
			m_NextIndex = (m_LastIndex = state);
			m_WaitTime = data.waitTime;
			m_ReverseWaitTime = data.reverseWaitTime;
			m_InChingTime = data.inchingTime;
			Phase = 4;
		}
		if (state == -1)
		{
			gameObject.SetActive(value: false);
		}
	}

	private void FixedUpdate()
	{
		if (!m_Init || m_Data.pathInfos.Length == 0)
		{
			return;
		}
		if (_inEffectTime)
		{
			_effectTime -= m_SubmergePlatform.entity.GetCompTime().fixedDeltaTime;
			if (_effectTime <= 0f)
			{
				_inEffectTime = false;
				Phase = 0;
			}
		}
		switch (Phase)
		{
		case 0:
			OnStart();
			break;
		case 1:
			OnWaiting();
			break;
		case 2:
			OnInching();
			break;
		case 3:
			OnUniforming();
			break;
		case 4:
			OnStartPoint();
			break;
		case 5:
			OnEndPoint();
			break;
		}
	}

	private void CalculateNextPos()
	{
		if (!Effect)
		{
			if (m_NextIndex > m_LastIndex)
			{
				m_NextIndex = m_LastIndex;
			}
			else
			{
				m_NextIndex = m_LastIndex - 1;
			}
			if (m_NextIndex < 0)
			{
				m_NextIndex = 0;
				Phase = 4;
			}
		}
		else
		{
			if (m_NextIndex >= m_LastIndex)
			{
				m_NextIndex = m_LastIndex + 1;
			}
			else
			{
				m_NextIndex = m_LastIndex;
			}
			if (m_NextIndex > m_Data.pathInfos.Length - 1)
			{
				m_NextIndex = m_Data.pathInfos.Length - 1;
				Phase = 5;
			}
		}
		m_NextPos = m_Data.pathInfos[m_NextIndex].position;
	}

	private void OnChangePhase(int from, int to)
	{
		if (to == 2)
		{
			if (Effect)
			{
				m_StartToEndLoopEvent = Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioStartToEndLoopEvent, new AudioPlayOptions
				{
					attachTarget = transform
				});
				Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioStartToEndEvent, new AudioPlayOptions
				{
					attachTarget = transform
				});
			}
			else
			{
				m_EndToStartLoopEvent = Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioEndToStartLoopEvent, new AudioPlayOptions
				{
					attachTarget = transform
				});
				Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioEndToStartEvent, new AudioPlayOptions
				{
					attachTarget = transform
				});
			}
		}
		if (to == 0 || to == 4 || to == 5)
		{
			if (!m_Data.startToEndLoopEvent.IsNull)
			{
				Singleton<GameManager>.instance.audioManager.Stop(m_StartToEndLoopEvent);
			}
			if (!m_Data.endToStartLoopEvent.IsNull)
			{
				Singleton<GameManager>.instance.audioManager.Stop(m_EndToStartLoopEvent);
			}
		}
	}

	private void OnWaiting()
	{
		float fixedDeltaTime = m_SubmergePlatform.entity.GetCompTime().fixedDeltaTime;
		if (!Effect)
		{
			m_ReverseWaitTime -= fixedDeltaTime;
			if (m_ReverseWaitTime < 0f)
			{
				m_ReverseWaitTime += m_Data.reverseWaitTime;
				CalculateNextPos();
				Phase = 2;
			}
		}
		else
		{
			m_WaitTime -= fixedDeltaTime;
			if (m_WaitTime < 0f)
			{
				m_WaitTime += m_Data.waitTime;
				CalculateNextPos();
				Phase = 2;
			}
		}
	}

	private void OnInching()
	{
		float fixedDeltaTime = m_SubmergePlatform.entity.GetCompTime().fixedDeltaTime;
		m_InChingTime -= fixedDeltaTime;
		if (m_InChingTime < 0f)
		{
			m_InChingTime += m_Data.inchingTime;
			Phase = 3;
			return;
		}
		if (m_Data.inchingTime != 0f)
		{
			float num = 1f - m_InChingTime / m_Data.inchingTime;
			m_Speed = m_Data.speed * num;
		}
		else
		{
			m_Speed = m_Data.speed;
		}
		Move();
	}

	private void OnUniforming()
	{
		m_Speed = m_Data.speed;
		Move();
	}

	private void Move()
	{
		Vector3 vector = InterpolationUtility.FixedLerp(transform.position, m_NextPos, m_Speed * m_SubmergePlatform.entity.GetCompTime().fixedDeltaTime * m_SystemTime.globalSpeed, out var _);
		if (vector == m_NextPos)
		{
			PathInfo[] pathInfos = m_Data.pathInfos;
			if (vector == pathInfos[pathInfos.Length - 1].position)
			{
				Phase = 5;
			}
			else if (vector == m_Data.pathInfos[0].position)
			{
				Phase = 4;
			}
			else
			{
				m_LastIndex = m_NextIndex;
				CalculateNextPos();
			}
		}
		rig.MovePosition(vector);
	}

	private void OnStart()
	{
		m_Speed = 0f;
		m_InChingTime = m_Data.inchingTime;
		m_WaitTime = m_Data.waitTime;
		m_ReverseWaitTime = m_Data.reverseWaitTime;
		Phase = 1;
	}

	private void OnEndPoint()
	{
		m_LastIndex = m_Data.pathInfos.Length - 1;
		m_NextIndex = m_LastIndex - 1;
		m_NextPos = m_Data.pathInfos[m_NextIndex].position;
		if (!Effect)
		{
			Phase = 0;
		}
	}

	private void OnStartPoint()
	{
		m_LastIndex = 0;
		m_NextIndex = m_LastIndex + 1;
		m_NextPos = m_Data.pathInfos[m_NextIndex].position;
		if (Effect)
		{
			Phase = 0;
		}
	}
}
