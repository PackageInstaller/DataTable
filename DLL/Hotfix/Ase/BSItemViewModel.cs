using UnityEngine;

namespace Ase;

public class BSItemViewModel : OptionBase
{
	private Color color;

	private string statisticName;

	private int totalValue;

	private float proportion;

	public Color Color
	{
		get
		{
			return color;
		}
		private set
		{
			Set(ref color, value, "Color");
		}
	}

	public string StatisticName
	{
		get
		{
			return statisticName;
		}
		private set
		{
			Set(ref statisticName, value, "StatisticName");
		}
	}

	public int TotalValue
	{
		get
		{
			return totalValue;
		}
		private set
		{
			Set(ref totalValue, value, "TotalValue");
		}
	}

	public float Proportion
	{
		get
		{
			return proportion;
		}
		private set
		{
			Set(ref proportion, value, "Proportion");
		}
	}

	public BSItemViewModel()
	{
	}

	public BSItemViewModel(Color color, string name, int totalValue, float proportion)
	{
		this.color = color;
		statisticName = name;
		this.totalValue = totalValue;
		this.proportion = proportion;
	}
}
