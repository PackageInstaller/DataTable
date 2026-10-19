using System.Collections.Generic;
using ACT.Game.Data;
using Bamboo.ECS;

namespace ACT.MultiPlayer;

public sealed class RuntimeBattleTeam
{
	private const int TeamMemberCount = 3;

	private const int SwitchMemberCount = 2;

	private readonly Character[] _characters = new Character[3];

	private readonly EntityId[] _entityRefs = new EntityId[3];

	private readonly EntityId[] _switchEntityRefs = new EntityId[2];

	public RuntimeBattleTeamSource Source { get; private set; } = RuntimeBattleTeamSource.MainNormal;

	public IReadOnlyList<Character> Characters => _characters;

	public int EquipPotionId { get; private set; }

	public int BattleEntityIndex { get; internal set; }

	internal EntityId[] EntityRefs => _entityRefs;

	internal EntityId[] SwitchEntityRefs => _switchEntityRefs;

	internal void Reset(RuntimeBattleTeamSource source, IReadOnlyList<Character> characters, EntityId[] entityRefs, int potionId, int battleEntityIndex)
	{
		Source = source;
		EquipPotionId = potionId;
		BattleEntityIndex = battleEntityIndex;
		for (int i = 0; i < 3; i++)
		{
			_characters[i] = ((characters != null && i < characters.Count) ? characters[i] : null);
			_entityRefs[i] = ((entityRefs != null && i < entityRefs.Length) ? entityRefs[i] : EntityId.Invalid);
		}
		for (int j = 0; j < 2; j++)
		{
			_switchEntityRefs[j] = EntityId.Invalid;
		}
	}

	public void SetPotionId(int potionId)
	{
		EquipPotionId = potionId;
	}
}
