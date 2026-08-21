namespace Ase;

public class BowViewBindData : WeaponActiveView.WeaponViewBindDataBase
{
	protected BowActiveView bowView;

	public float ColorState
	{
		get
		{
			return 0f;
		}
		set
		{
			bowView.ColorState = value;
		}
	}

	public float FillNormal
	{
		get
		{
			return 0f;
		}
		set
		{
			bowView.FillNormal.fillAmount = value;
		}
	}

	public float FillAwaken
	{
		get
		{
			return 0f;
		}
		set
		{
			bowView.FillAwaken.fillAmount = value;
			bowView.FillAwaken1.fillAmount = value;
			bowView.FillAwaken2.fillAmount = value;
		}
	}

	public WeaponMechanismBow.BowState BowState
	{
		get
		{
			return WeaponMechanismBow.BowState.None;
		}
		set
		{
			bowView.BowState = value;
		}
	}

	public BowViewBindData(WeaponActiveView view)
		: base(view)
	{
		bowView = view as BowActiveView;
	}
}
