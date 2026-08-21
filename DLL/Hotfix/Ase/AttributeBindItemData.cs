namespace Ase;

public class AttributeBindItemData : OptionBase
{
	private string heroImg;

	private string heroSkillDesc;

	private string heroAttribute;

	private bool isEmpty;

	public string HeroImg => heroImg;

	public string HeroSkillDesc => heroSkillDesc;

	public string HeroAttribute => heroAttribute;

	public bool IsEmpty => isEmpty;

	public AttributeBindItemData()
	{
	}

	public AttributeBindItemData(int heroId, HeroAttributeEnum heroAttributeEnum = HeroAttributeEnum.Fire)
	{
		if (heroId == 0)
		{
			LoadDefault();
			return;
		}
		isEmpty = false;
		DRHeroPassive dataRow = GameEntry.DataTable.GetDataRow<DRHeroPassive>(heroId);
		if (dataRow != null)
		{
			heroSkillDesc = dataRow.TeamPassive.Replace("\\n", "\n");
		}
		heroImg = $"{heroId}_Upgrade_0";
		heroAttribute = $"hero_attr_{(int)heroAttributeEnum}";
	}

	private void LoadDefault()
	{
		isEmpty = true;
		heroImg = "empty";
		heroAttribute = "empty";
	}
}
