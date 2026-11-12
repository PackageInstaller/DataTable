using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/震荡型子弹(不支持追踪目标)")]
public class AdventureOscillationBullet : AdventureBullet
{
	public FP Oscillation_Distance = 0.2f;

	public FP Oscillation_Accelerated = 0f;

	public FP Oscillation_Durtion = 1f;

	public FP Oscillation_Max = 5f;

	protected FP currentTime;

	protected int lifeIndex;

	protected readonly int lifeCount = 4;

	protected bool legal;

	protected FP offsetDis;

	private TSVector2 rightNormal => new TSVector2(velocityDirection.y, -velocityDirection.x).normalized;

	private TSVector2 leftNormal => new TSVector2(-velocityDirection.y, velocityDirection.x).normalized;

	protected override void OnActive()
	{
		base.OnActive();
		lifeIndex = 0;
		currentTime = Oscillation_Durtion;
		legal = Oscillation_Distance > 0 || Oscillation_Accelerated > 0;
		offsetDis = GetOffset();
	}

	public override void Move(FP dt)
	{
		base.Move(dt);
		if (legal)
		{
			int num = lifeIndex % lifeCount;
			if (num == 0 || num == 3)
			{
				tsTransform.Position += offsetDis * leftNormal * dt;
			}
			else
			{
				tsTransform.Position += offsetDis * rightNormal * dt;
			}
			currentTime -= dt;
			if (currentTime <= 0)
			{
				lifeIndex++;
				offsetDis = GetOffset();
				currentTime = Oscillation_Durtion;
			}
		}
	}

	private FP GetOffset()
	{
		if (lifeIndex > 0 || Oscillation_Distance > 0)
		{
			int num = lifeIndex / 2;
			FP fP = Oscillation_Distance + num * Oscillation_Accelerated;
			fP = ((fP > Oscillation_Max) ? Oscillation_Max : fP);
			if (Oscillation_Durtion <= 0)
			{
				return fP;
			}
			return fP / Oscillation_Durtion;
		}
		return 0;
	}
}
