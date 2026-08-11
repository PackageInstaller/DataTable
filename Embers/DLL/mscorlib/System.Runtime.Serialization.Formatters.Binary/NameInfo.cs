namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class NameInfo
{
	internal string NIFullName;

	internal long NIobjectId;

	internal long NIassemId;

	internal InternalPrimitiveTypeE NIprimitiveTypeEnum;

	internal Type NItype;

	internal bool NIisSealed;

	internal bool NIisArray;

	internal bool NIisArrayItem;

	internal bool NItransmitTypeOnObject;

	internal bool NItransmitTypeOnMember;

	internal bool NIisParentTypeOnObject;

	internal InternalArrayTypeE NIarrayEnum;

	private bool NIsealedStatusChecked;

	public bool IsSealed
	{
		get
		{
			if (!NIsealedStatusChecked)
			{
				NIisSealed = NItype.IsSealed;
				NIsealedStatusChecked = true;
			}
			return NIisSealed;
		}
	}

	public string NIname
	{
		get
		{
			if (NIFullName == null)
			{
				NIFullName = NItype.FullName;
			}
			return NIFullName;
		}
		set
		{
			NIFullName = value;
		}
	}

	internal NameInfo()
	{
	}

	internal void Init()
	{
		NIFullName = null;
		NIobjectId = 0L;
		NIassemId = 0L;
		NIprimitiveTypeEnum = InternalPrimitiveTypeE.Invalid;
		NItype = null;
		NIisSealed = false;
		NItransmitTypeOnObject = false;
		NItransmitTypeOnMember = false;
		NIisParentTypeOnObject = false;
		NIisArray = false;
		NIisArrayItem = false;
		NIarrayEnum = InternalArrayTypeE.Empty;
		NIsealedStatusChecked = false;
	}
}
