namespace Ase;

public class ArmourFilterOptionViewModel : ReportItemViewModel
{
	private readonly int filterId;

	private readonly int filterTypeId;

	private readonly EquipmentFilterLogic filterLogic;

	public int MatchId => base.ReportId;

	public int FilterId => filterId;

	public int FilterTypeId => filterTypeId;

	public EquipmentFilterLogic FilterLogic => filterLogic;

	public ArmourFilterOptionViewModel(OptionBase parent, string name, int filterId, int matchId, int filterTypeId, bool isSelect)
		: this(parent, name, filterId, matchId, filterTypeId, isSelect, EquipmentFilterDefinition.GetDefaultFilterLogic(filterTypeId))
	{
	}

	public ArmourFilterOptionViewModel(OptionBase parent, string name, int filterId, int matchId, int filterTypeId, bool isSelect, EquipmentFilterLogic filterLogic)
		: base(parent, name, matchId)
	{
		this.filterId = filterId;
		this.filterTypeId = filterTypeId;
		this.filterLogic = filterLogic;
		SetSelect(isSelect);
	}

	public override void OnClick()
	{
		SetSelect(!base.IsSelect);
		parent?.ItemOnClick(this);
	}
}
