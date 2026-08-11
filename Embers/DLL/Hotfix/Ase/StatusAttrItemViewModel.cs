namespace Ase;

public class StatusAttrItemViewModel : OptionBase
{
	public string Icon;

	public string Name;

	public string OuterValue;

	public string DeltaValue;

	public double DeltaRaw;

	public int Index;

	public bool IsPositive => DeltaRaw > 0.0;

	public bool IsNegative => DeltaRaw < 0.0;

	public StatusAttrItemViewModel(string name, string outer, string delta, double deltaRaw, string icon = "", int index = 0)
	{
		Icon = icon;
		Name = name;
		OuterValue = outer;
		DeltaValue = delta;
		DeltaRaw = deltaRaw;
		Index = index;
	}

	public StatusAttrItemViewModel()
	{
	}

	public static StatusAttrItemViewModel CreateBasic(string name, string value, string icon = "", int index = 0)
	{
		return new StatusAttrItemViewModel(name, value, string.Empty, 0.0, icon, index);
	}
}
