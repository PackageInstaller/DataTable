using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("监听角色", "Mixin", new string[] { "listen", "change", "character" })]
public class ConfigMixinListenChangeCharacter : ConfigMixin
{
	public float cd;

	public EvtBattleChange.ChangeCharacterSource source = EvtBattleChange.ChangeCharacterSource.PlayerChange | EvtBattleChange.ChangeCharacterSource.Die;

	public bool prevIsSelf;

	[Space(30f)]
	public ListenChangeCharacterType listenUp;

	public ConfigAction[] actionOnOwnerNext;

	[Space(30f)]
	public ListenChangeCharacterType listenDown;

	public ConfigAction[] actionsOnOwnerPrev;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinListenChangeCharacter(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, actionsOnOwnerPrev, configAbility);
	}
}
