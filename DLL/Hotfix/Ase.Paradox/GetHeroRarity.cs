using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取Hero品质", 0)]
[Description("根据HeroID获取HeroInfo表内的Rarity。")]
[Category("✫ DragonLost/Entity")]
public class GetHeroRarity : ActionTaskBase
{
	[Name("EntityID", 0)]
	[Description("实体ID")]
	public BBParameter<int> entityId;

	[Space(10)]
	[Name("返回Hero品质", 0)]
	public BBParameter<int> rarity;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: true);
		if (entity == null)
		{
			EndAction();
			return;
		}
		if (entity is HeroEntity heroEntity)
		{
			rarity.value = heroEntity.BattleHeroData?.HeroModel.Rarity ?? 0;
		}
		OnActionFinish();
	}
}
