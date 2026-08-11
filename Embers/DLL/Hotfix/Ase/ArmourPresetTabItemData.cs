namespace Ase;

public class ArmourPresetTabItemData : TabItemData
{
	private readonly ArmourPresetSlotData slotData;

	private readonly HeroModel heroModel;

	public ArmourPresetSlotData SlotData => slotData;

	public bool IsCurrent
	{
		get
		{
			if (slotData != null)
			{
				return slotData.IsCurrent;
			}
			return false;
		}
	}

	public bool IsCreated
	{
		get
		{
			if (slotData != null)
			{
				return slotData.IsCreated;
			}
			return false;
		}
	}

	public ArmourPresetTabItemData(OptionBase parent, ArmourPresetSlotData slotData, HeroModel heroModel = null)
		: base(parent, slotData?.SlotId ?? 0)
	{
		this.slotData = slotData;
		this.heroModel = heroModel;
		RefreshText();
		RefreshIcon();
	}

	public void RefreshText()
	{
		string text = ((slotData == null) ? string.Empty : slotData.PresetName);
		if (string.IsNullOrEmpty(text))
		{
			text = ArmourPresetSlotData.GetDefaultName(slotData?.SlotId ?? 0);
		}
		base.TextNormal = text;
		base.TextSelected = text;
	}

	public void RefreshIcon()
	{
		if (!IsCurrent || heroModel == null)
		{
			base.IconNormal = string.Empty;
			base.IconSelected = string.Empty;
		}
		else
		{
			string iconSelected = (base.IconNormal = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.CardHorizontal, heroModel));
			base.IconSelected = iconSelected;
		}
	}
}
