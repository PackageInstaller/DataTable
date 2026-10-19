using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class TrackSkillEvt : TrackBaseEvt<TrackSkillEvt>
{
	public int skillId;

	public Entity caster;

	public string stateName;

	public override void ReleaseEvt()
	{
		caster = default;
		base.ReleaseEvt();
	}

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (!EventConfigs.EventDictionary.TryGetValue("use_skill", out var value) || !caster.TryGetCompCharacter(out CompCharacter component) || MonoECS.instance.playState != PlayState.Battle)
		{
			return;
		}
		ACT.Config.UseSkill data = CoreUtils.GetData(component.characterSource.Id(), RuntimeConfigs.data.useSkills);
		if (data == null)
		{
			return;
		}
		string[] array = data.stateName;
		string[] abilityName = data.abilityName;
		CompAbility compAbility = caster.GetCompAbility();
		string[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			if (!array2[i].Equals(stateName))
			{
				continue;
			}
			foreach (Ability ability in compAbility.abilities)
			{
				string[] array3 = abilityName;
				foreach (string text in array3)
				{
					if (ability.config.name.Equals(text))
					{
						((JArray)value["ability_list"])?.Clear();
						((JArray)value["ability_list"])?.Add(text + "," + ability.stack);
					}
				}
			}
			SetTransNo(value);
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["character_id"] = component.characterSource.Id();
			value["state_name"] = stateName;
			value["skill_id"] = skillId;
			_ = LuminApplication.LogEnabled;
			Send("use_skill", value);
			break;
		}
	}
}
