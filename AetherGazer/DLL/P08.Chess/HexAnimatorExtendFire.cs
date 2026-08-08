using Chess;
using UnityEngine;

public class HexAnimatorExtendFire : HexAnimator
{
	public float bulletFireTime = 2.2f;

	private int fireTimer;

	public void Fire()
	{
		m_animator.Play("skill1", 0, 0f);
		fireTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			Vector3 forward = base.transform.forward;
			HexBulletManager.Instance.FireBullet(base.GridPosition.x, base.GridPosition.z, ChessHelper.GetDirectionByForward(forward));
		}, bulletFireTime, 1);
	}

	protected new void OnDestroy()
	{
		base.OnDestroy();
		if (fireTimer > 0 && FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.RemoveFuncTimer(fireTimer);
		}
	}
}
