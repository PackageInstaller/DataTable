using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/完结时分裂子弹")]
public class WeaponFeatureSplitWhenFinish : WeaponFeature
{
	[Space]
	public HitBox.Shape splitShootShape;

	public FP shapeWidth = 1f;

	public FP shapeLength = 1f;

	public FP shapeRadius = 1f;

	public FP shapeInnerRadius = 0f;

	public FP shapeAngle = 45f;

	[Space]
	public AdventureWeapon.MultipleShootStyle splitShootStyle = AdventureWeapon.MultipleShootStyle.FromCenterToSide;

	[Space]
	public GameObject splitBulletPrefab;

	[Space]
	public int splitBulletCount = 10;

	[Space]
	public FP splitShootDuration = 0f;

	public FP splitShootBulletDirectionOffset = 0f;

	[Space]
	public bool alignShoot;

	public FP alignShootDelay = 0f;

	public override bool OnEnd()
	{
		Split();
		return base.OnEnd();
	}

	private void Split()
	{
		GameObject gameObject = splitBulletPrefab;
		int num = level * splitBulletCount;
		AdventureActor component = attachedWeapon.owner.GetComponent<AdventureActor>();
		if (gameObject == null || num <= 0 || component == null)
		{
			return;
		}
		if (splitShootDuration > 0f)
		{
			TSVector2 position = attachedWeapon.tsTransform.Position;
			FP positionY = attachedWeapon.tsTransform.PositionY - component.tsTransform.PositionY;
			TSVector2 velocityDirection = attachedWeapon.velocityDirection;
			component.StartLogicCoroutine(component.shootBehaviour.MultipleShoot(splitShootShape, gameObject, num, shapeWidth, shapeLength, shapeAngle, shapeRadius, shapeInnerRadius, position, positionY, velocityDirection, splitShootBulletDirectionOffset, splitShootStyle, splitShootDuration, alignShoot, alignShootDelay));
			return;
		}
		int num2 = component.shootBehaviour.QueryMultipleShootWaveCount(splitShootShape, splitShootStyle, num);
		int waveIndex = 0;
		while (waveIndex < num2)
		{
			TSVector2 position2 = attachedWeapon.tsTransform.Position;
			FP positionY2 = attachedWeapon.tsTransform.PositionY - component.tsTransform.PositionY;
			TSVector2 velocityDirection2 = attachedWeapon.velocityDirection;
			component.shootBehaviour.MultipleShoot(splitShootShape, gameObject, num, shapeWidth, shapeLength, shapeAngle, shapeRadius, shapeInnerRadius, position2, positionY2, velocityDirection2, splitShootBulletDirectionOffset, splitShootStyle, ref waveIndex, 0f, alignShoot, alignShootDelay);
		}
	}
}
