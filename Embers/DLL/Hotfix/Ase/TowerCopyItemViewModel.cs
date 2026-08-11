namespace Ase;

public class TowerCopyItemViewModel : OptionBase
{
	private bool finishLevel;

	private bool selectlevel;

	private bool unLock;

	private CopyData copyData;

	public int CopyId => copyData.Id;

	public CopyData CopyData => copyData;

	public bool FinishLevel
	{
		get
		{
			return finishLevel;
		}
		set
		{
			Set(ref finishLevel, value, "FinishLevel");
		}
	}

	public bool SelectLevel
	{
		get
		{
			return selectlevel;
		}
		set
		{
			Set(ref selectlevel, value, "SelectLevel");
		}
	}

	public bool UnLock
	{
		get
		{
			return unLock;
		}
		set
		{
			Set(ref unLock, value, "UnLock");
		}
	}

	public TowerCopyItemViewModel(bool finish, CopyData copyData, bool isUnLock)
	{
		this.copyData = copyData;
		FinishLevel = finish;
		unLock = isUnLock;
	}

	public override void SetParent(OptionBase parent)
	{
		base.SetParent(parent);
		base.parent = parent;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		parent.ItemOnClick(this);
	}
}
