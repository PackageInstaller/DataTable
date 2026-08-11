using System.Collections.Generic;
using Sirenix.OdinInspector;

namespace Ase;

public static class MapDataHelper
{
	public const string ES3EditorPath = "/Art/LevelSave/OriginSave.es3";

	public const string ES3StreamPath = "/LevelSave/OriginSave.es3";

	public const string ESKey_upLoadTime = "UpLoadTime";

	public const string ESKey_TeachGuide = "TeachGuide";

	public const int version_default = 0;

	public const int FirstLevel = 100;

	public const int GuideLevel = 10;

	public static Dictionary<int, (string, HeroSkillTypeEnum)> TeachGuideCtrUIs = new Dictionary<int, (string, HeroSkillTypeEnum)>
	{
		{
			1,
			("TouchInputWindow-Attack", HeroSkillTypeEnum.Attack)
		},
		{
			2,
			("TouchInputWindow-Roll", HeroSkillTypeEnum.Roll)
		},
		{
			3,
			("TouchInputWindow-Skill1", HeroSkillTypeEnum.Skill1)
		},
		{
			4,
			("TouchInputWindow-Skill2", HeroSkillTypeEnum.Skill2)
		},
		{
			5,
			("TouchInputWindow-Skill3", HeroSkillTypeEnum.Skill3)
		},
		{
			6,
			("TouchInputWindow-SkillMax", HeroSkillTypeEnum.Skill4)
		},
		{
			7,
			("TouchInputWindow-PropSkill1", HeroSkillTypeEnum.PropSkill)
		},
		{
			8,
			("TouchInputWindow-PropSkill2", HeroSkillTypeEnum.DeputyPropSkill)
		},
		{
			9,
			("BattleWindow-Set", HeroSkillTypeEnum.None)
		},
		{
			10,
			("BattleWindow-Weapon", HeroSkillTypeEnum.None)
		}
	};

	public static List<ValueDropdownItem<int>> GetSubscriptionType = new List<ValueDropdownItem<int>>
	{
		new ValueDropdownItem<int>("Task", 0),
		new ValueDropdownItem<int>("PlayerLevel", 1),
		new ValueDropdownItem<int>("CopyOpen", 2)
	};

	public static List<HeroSkillTypeEnum> TeachSkillSetTypeEnums = new List<HeroSkillTypeEnum>(8)
	{
		HeroSkillTypeEnum.Roll,
		HeroSkillTypeEnum.Attack,
		HeroSkillTypeEnum.Skill1,
		HeroSkillTypeEnum.Skill2,
		HeroSkillTypeEnum.Skill3,
		HeroSkillTypeEnum.Skill4,
		HeroSkillTypeEnum.PropSkill,
		HeroSkillTypeEnum.DeputyPropSkill
	};
}
