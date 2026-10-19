using ACT.Battle.Configs;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.Battle;

public class MonoEffect : MonoBehaviour
{
	public bool controlRemove;

	protected TimeScale timeScale;

	[HideInInspector]
	public bool isDone;

	[HideInInspector]
	protected float simulationSpeed;

	public UnityEvent onSetToBeRemove;

	public virtual void SetToBeRemove()
	{
		onSetToBeRemove.Invoke();
	}

	public virtual void SetSpeed(float speed)
	{
		simulationSpeed = speed;
	}

	public virtual void SetTimeScale(TimeScale scale)
	{
		timeScale = scale;
	}

	public virtual void StartEffect(EffectRuntimeItem item)
	{
	}

	public void SetDone()
	{
		isDone = true;
	}

	public virtual void OnReset()
	{
		isDone = false;
	}

	public virtual void UpdateBehave(float deltaTime)
	{
	}
}
