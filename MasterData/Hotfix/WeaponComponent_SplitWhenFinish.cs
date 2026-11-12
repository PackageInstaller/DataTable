using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器组件/武器通用_结束时分裂子弹组件(目前仅炸弹可用)")]
[DisallowMultipleComponent]
public class WeaponComponent_SplitWhenFinish : LogicMonoComponent, IBombComponent
{
	[Space]
	public int level = 1;

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

	protected AdventureWeapon _context;

	public bool KeepAlive { get; set; } = true;

	public void Setup()
	{
		_context = Entity as AdventureWeapon;
	}

	public void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		KeepAlive = true;
	}

	public void Finish()
	{
		Split();
		KeepAlive = false;
	}

	private void Split()
	{
		if (_context == null)
		{
			return;
		}
		GameObject gameObject = splitBulletPrefab;
		int num = level * splitBulletCount;
		AdventureActor component = _context.owner.GetComponent<AdventureActor>();
		if (gameObject == null || num <= 0 || component == null)
		{
			return;
		}
		if (splitShootDuration > 0f)
		{
			TSVector2 position = _context.tsTransform.Position;
			FP positionY = _context.tsTransform.PositionY;
			TSVector2 velocityDirection = _context.velocityDirection;
			component.StartLogicCoroutine(component.shootBehaviour.MultipleShoot(splitShootShape, gameObject, num, shapeWidth, shapeLength, shapeAngle, shapeRadius, shapeInnerRadius, position, positionY, velocityDirection, splitShootBulletDirectionOffset, splitShootStyle, splitShootDuration, alignShoot, alignShootDelay));
			return;
		}
		int num2 = component.shootBehaviour.QueryMultipleShootWaveCount(splitShootShape, splitShootStyle, num);
		int waveIndex = 0;
		while (waveIndex < num2)
		{
			TSVector2 position2 = _context.tsTransform.Position;
			FP positionY2 = _context.tsTransform.PositionY;
			TSVector2 velocityDirection2 = _context.velocityDirection;
			component.shootBehaviour.MultipleShoot(splitShootShape, gameObject, num, shapeWidth, shapeLength, shapeAngle, shapeRadius, shapeInnerRadius, position2, positionY2, velocityDirection2, splitShootBulletDirectionOffset, splitShootStyle, ref waveIndex, 0f, alignShoot, alignShootDelay);
		}
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_context = null;
	}
}
