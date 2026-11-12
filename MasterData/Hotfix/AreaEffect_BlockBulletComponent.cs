using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_阻挡飞行道具和武器")]
[RequireComponent(typeof(AreaEffectEntity))]
[DisallowMultipleComponent]
public class AreaEffect_BlockBulletComponent : AreaEffect_Component
{
	public TargetFilterCriteriaInfo criteriaInfo;

	public GameObject finishPrefab;

	public int blockCount;

	public bool finishWhenBlockEmpty;

	private int _blockCount;

	private bool BlockFinish
	{
		get
		{
			if (blockCount > 0)
			{
				return _blockCount >= blockCount;
			}
			return false;
		}
	}

	protected override void OnSetup()
	{
		base.OnSetup();
		_blockCount = 0;
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_blockCount = 0;
	}

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (!BlockFinish && entity is AdventureWeapon { canBeBlock: not false } adventureWeapon && _context.CheckTarget(adventureWeapon.owner, criteriaInfo) && (!(adventureWeapon.owner is AdventureActor adventureActor) || !checkTargetWithTag || _checkTagHashCode == 0 || adventureActor.CheckTag(_checkTagHashCode)))
		{
			if (finishPrefab != null)
			{
				AdventureFXPlayer.PlayFX(finishPrefab, 1f, adventureWeapon.transform.position, adventureWeapon.transform.rotation, _context.transform.localScale.x);
			}
			adventureWeapon.Finish(cancel: true, catched: false, ignorFinishFX: true);
			_blockCount++;
			AdventureBulletBlockEvent adventureBulletBlockEvent = AdventureBulletBlockEvent.Generate();
			adventureBulletBlockEvent.sender = _context;
			adventureBulletBlockEvent.owner = _context.owner;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureBulletBlockEvent);
			if (BlockFinish && finishWhenBlockEmpty)
			{
				FinishAreaEffect = true;
			}
		}
	}
}
