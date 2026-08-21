public class HexAnimatorExtendStone : HexAnimator
{
	public float stoneFireTime = 1f;

	private int fireTimer;

	public void StoneMove(int curx, int curz)
	{
		m_animator.Play("skill1", 0, 0f);
		fireTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			_ = base.transform.forward;
			HexEntity stone = HexManager.Instance.FindEntity(curx, curz);
			HexStoneManager.Instance.StoneStartToMove(stone, base.transform.forward);
		}, stoneFireTime, 1);
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
