using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.PassiveSkill;

public class PerkSkill_5110302 : SkillAdvancedBase
{
	private readonly FP _searchRange = 8;

	private readonly int _bulletNum = 2;

	private readonly string _bulletPath = "Actor/Common/Weapons/Perks/PerkSkill_5110301_bullet";

	protected override void OnSkillEnable()
	{
		List<LogicEntity> list = new List<LogicEntity>();
		List<DeterministicCollider> list2 = null;
		if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(_searchRange, _actor.tsTransform.Position, list2, 256))
		{
			for (int i = 0; i < list2.Count; i++)
			{
				AdventureActor adventureActor = (AdventureActor)list2.get_Item(i).Entity;
				if (adventureActor != null && adventureActor.actorHealthInfo.isAlive && adventureActor != _actor && _actor.IsConfrontWith(adventureActor))
				{
					list.Add(adventureActor);
				}
			}
		}
		if (list.Count > 0)
		{
			_actor.SearchEntitySortByDistance(list);
			TSVector2 position = _actor.tsTransform.Position + new TSVector2(0, 0.1);
			for (int j = 0; j < _bulletNum; j++)
			{
				string bulletPath = _bulletPath;
				AdventureActor actor = _actor;
				FP range = 5;
				TSVector2 position2 = ((AdventureActor)list.get_Item(0)).tsTransform.Position;
				ILRuntimeAPI.Shoot(bulletPath, actor, range, position, default, position2, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
		}
		_skill.Clear();
	}
}
