using System;
using ACT.Game.Data;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Game;

public class LocalCharacterProfile : ScriptableObject
{
	[Serializable]
	public class LocalSkill
	{
		public int id;

		public int level;

		public Skill ToPB()
		{
			return new Skill
			{
				Id = id,
				Level = level
			};
		}
	}

	public int id;

	public int level;

	public int exp;

	[FormerlySerializedAs("breakThrou")]
	public int stage;

	public int constellation;

	public int hp;

	public float ExEnery;

	public float assistEnergy;

	public float energyValue;

	public int weapon;

	public int[] chips;

	public LocalSkill[] skillGroup;

	public Character ToPB()
	{
		Character character = new Character();
		character.Id = id;
		character.SkinId = id;
		character.Level = level;
		character.Exp = exp;
		character.Stage = stage;
		character.WeaponUid = weapon;
		CharacterStatus characterStatus = new CharacterStatus();
		characterStatus.ExPower = ExEnery;
		characterStatus.AssistPower = assistEnergy;
		characterStatus.EnergyPower = energyValue;
		characterStatus.Hp = hp;
		character.Status = characterStatus;
		character.Constellation = constellation;
		character.EliteInfo = new CharacterEliteInfo
		{
			Point = 0
		};
		for (int i = 1; i <= constellation; i++)
		{
			character.ConstellationEnabledStatus.Add(i, value: true);
		}
		if (skillGroup != null)
		{
			for (int j = 0; j < skillGroup.Length; j++)
			{
				character.SkillGroupLevels.Add(skillGroup[j].id, skillGroup[j].level);
			}
		}
		return character;
	}
}
