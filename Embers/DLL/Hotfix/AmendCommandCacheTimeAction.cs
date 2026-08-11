using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("修改指令的缓存时间", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改完后会刷新当前的缓存时间")]
public class AmendCommandCacheTimeAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> SkillEnum;

	[Name("缓存时间", 0)]
	[Description("缓存时间")]
	public BBParameter<float> CacheTime;

	[Name("还原缓存时间", 0)]
	[Description("在行为树结束时还原数据")]
	public bool RestoreCacheTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().AmendCommandCacheTime(SkillEnum.value, CacheTime.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && RestoreCacheTime)
		{
			ownerEntity.GetComponent<SkillComponent>()?.RestoreCacheTime(SkillEnum.value);
		}
	}
}
