namespace Ase;

public class CastingMaterialItemData : OptionBase
{
	private int need;

	private string numShow;

	private KnapsackPropData propData;

	public string NumShow
	{
		get
		{
			return numShow;
		}
		private set
		{
			Set(ref numShow, value, "NumShow");
		}
	}

	public int Need => need;

	public KnapsackPropData PropData => propData;

	public CastingMaterialItemData(OptionBase parent, int materialNeed, KnapsackPropData propData, bool needShowContrast = true)
	{
		base.parent = parent;
		this.propData = propData;
		need = materialNeed;
		if (needShowContrast)
		{
			string text = ((need <= propData.Amount) ? "#9dde8e" : "#ea6250");
			NumShow = "<color=" + text + ">" + propData.Amount + "</color>/" + need;
		}
		else
		{
			numShow = $"{need}";
		}
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}

	public void UpdateNumShow(KnapsackPropData propData)
	{
		this.propData = propData;
		string text = ((need <= this.propData.Amount) ? "#9dde8e" : "#ea6250");
		NumShow = "<color=" + text + ">" + this.propData.Amount + "</color>/" + need;
	}
}
