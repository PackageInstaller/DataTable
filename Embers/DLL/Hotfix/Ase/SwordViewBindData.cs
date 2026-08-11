namespace Ase;

public class SwordViewBindData : WeaponActiveView.WeaponViewBindDataBase
{
	protected SwordActiveView swordView;

	public float OutLine
	{
		get
		{
			return 0f;
		}
		set
		{
			swordView?.SetOutLine(value);
		}
	}

	public SwordViewBindData(WeaponActiveView view)
		: base(view)
	{
		swordView = view as SwordActiveView;
	}
}
