using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class MonoAnimatorEffect : MonoEffect
{
	public Animator ani;

	protected float m_Time;

	public override void SetToBeRemove()
	{
		base.SetToBeRemove();
		isDone = true;
	}

	public override void SetSpeed(float speed)
	{
		base.SetSpeed(speed);
	}

	public override void UpdateBehave(float deltaTime)
	{
		if (!(ani == null))
		{
			ani.speed = 1f;
			ani.Update(deltaTime);
			ani.speed = 0f;
		}
	}

	private void FixedUpdate()
	{
		if (timeScale == TimeScale.NoScale && !(ani == null))
		{
			ani.speed = 1f;
			ani.Update(Time.fixedDeltaTime);
			ani.speed = 0f;
		}
	}

	public override void OnReset()
	{
		base.OnReset();
		if (!(ani == null))
		{
			ani.Rebind();
			ani.Update(0f);
		}
	}
}
