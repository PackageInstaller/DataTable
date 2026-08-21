using GameFramework.Runtime;

namespace Ase;

public class BuildingEffectItemViewModel : ViewModelBase
{
	private int effectId;

	private string name;

	private string cur;

	private string next;

	private float nextVal;

	private bool showVal;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public bool ShowVal
	{
		get
		{
			return showVal;
		}
		private set
		{
			Set(ref showVal, value, "ShowVal");
		}
	}

	public string Cur
	{
		get
		{
			return cur;
		}
		private set
		{
			Set(ref cur, value, "Cur");
		}
	}

	public string Next
	{
		get
		{
			return next;
		}
		private set
		{
			Set(ref next, value, "Next");
		}
	}

	public float NextVal => nextVal;

	public int EffectId => effectId;

	public void RefreshEffect(DRHomeLandLevelEffect landLevelEffect, float curVal, float nextVal)
	{
		effectId = landLevelEffect.Id;
		Name = landLevelEffect.Name;
		ShowVal = landLevelEffect.ShowValue;
		this.nextVal = nextVal;
		if (!ShowVal)
		{
			Cur = "";
			Next = "";
		}
		else
		{
			Cur = (landLevelEffect.IsPrefix ? $"{landLevelEffect.Unit}{curVal}" : $"{curVal}{landLevelEffect.Unit}");
			Next = (landLevelEffect.IsPrefix ? $"{landLevelEffect.Unit}{nextVal}" : $"{nextVal}{landLevelEffect.Unit}");
		}
	}
}
