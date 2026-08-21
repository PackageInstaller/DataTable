using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("清空指令缓存", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改完后会刷新当前的缓存时间")]
public class ClearCommandCacheAction : ActionTaskBase
{
	[Name("指令类型", 0)]
	[Description("指令类型")]
	public BBParameter<HeroSkillTypeEnum> CommandType;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().ClearCommandCache(CommandType.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"清空指令缓存  指令类型 ： {CommandType.value}", ownerEntity);
		}
		EndAction();
	}
}
