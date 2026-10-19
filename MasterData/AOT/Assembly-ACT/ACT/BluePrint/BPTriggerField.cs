using System;
using System.Threading;
using ACT.Battle;
using ACT.World;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.BluePrint;

public class BPTriggerField : MonoTriggerEvent, ITrigger
{
	public string triggerName;

	public Action<string> onEnter;

	public Action<string> onExit;

	private CancellationTokenSource m_Source;

	protected virtual void Awake()
	{
		m_Source = new CancellationTokenSource();
	}

	private async void OnTriggerEnter(Collider collision)
	{
		if (gameObject.activeInHierarchy)
		{
			MonoEntity entity = collision.gameObject.GetComponent<MonoEntity>();
			if (entity != null && MonoECS.instance.IsMainEntity(entity.entity) && MonoECS.instance.PlayerControlType != MonoECS.ControlType.OreCar && (MonoECS.instance.isStartWorld || !(await UniTask.WaitUntil(() => MonoECS.instance.isStartWorld, PlayerLoopTiming.Update, m_Source.Token).SuppressCancellationThrow())) && !(await WaitForMovementTransitionEnd()))
			{
				onEnter?.Invoke(triggerName);
				OnEnterEvt(entity.entity, this);
			}
		}
	}

	private async void OnTriggerExit(Collider collision)
	{
		if (gameObject.activeInHierarchy)
		{
			MonoEntity entity = collision.gameObject.GetComponent<MonoEntity>();
			if (entity != null && MonoECS.instance.IsMainEntity(entity.entity) && MonoECS.instance.PlayerControlType != MonoECS.ControlType.OreCar && !(await WaitForMovementTransitionEnd()))
			{
				onExit?.Invoke(triggerName);
				OnExitEvt(entity.entity, this);
			}
		}
	}

	private async UniTask<bool> WaitForMovementTransitionEnd()
	{
		if (!IsMovementTransitionActive())
		{
			return false;
		}
		return await UniTask.WaitUntil(() => !IsMovementTransitionActive() || Singleton<GameState>.instance.WorldState == WorldState.Leave, PlayerLoopTiming.Update, m_Source.Token).SuppressCancellationThrow() || MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave;
	}

	private static bool IsMovementTransitionActive()
	{
		MonoECS instance = MonoECS.instance;
		if (instance != null)
		{
			if (!instance.InPlayerTag(MonoECS.PlayerTag.MovingPath))
			{
				return instance.InPlayerTag(MonoECS.PlayerTag.CameraMoving);
			}
			return true;
		}
		return false;
	}

	private void OnDestroy()
	{
		m_Source.Cancel();
		m_Source.Dispose();
	}

	public void TriggerExit()
	{
		if ((bool)this)
		{
			_ = gameObject.activeInHierarchy;
		}
	}
}
