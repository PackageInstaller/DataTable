using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置实体激活", "Action", new string[] { "set", "entity", "active", "state", "status", "tag" })]
public class ActionSetEntityActive : ConfigAction
{
	public bool value;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		MonoECS.instance.SetBehaveActive(entity, value);
		MonoECS.instance.EntityDissolve(entity, 0f, isShow: false);
		MonoECS.instance.ResetEffect(entity, isBack: true);
		entity.SetBool("isActive", value);
		if (!value)
		{
			entity.GetMono().weaponModel?.GetComponent<Animator>()?.SetTrigger("weaponAnimExit");
			MonoECS.instance.FireChangeEffect(entity, GameLoader.meta.switchSkillChangeCharacter.hide.effectAssetID, GameLoader.meta.switchSkillChangeCharacter.hide.delayTime, isConnect: false, default, null, null, noOwner: true).Forget();
		}
	}
}
