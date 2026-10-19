namespace Com.ForbiddenByte.OSA.Core;

public class BaseItemViewsHolder : AbstractViewsHolder
{
	public int itemIndexInView;

	public override string ToString()
	{
		return itemIndexInView + "R" + ItemIndex;
	}

	public virtual void ShiftIndexInView(int shift, int modulo)
	{
		int num = itemIndexInView;
		itemIndexInView += shift;
		if (itemIndexInView >= modulo)
		{
			throw new OSAException("BaseItemViewsHolder.ShiftIndex: (itemIndexInView=" + num + ")+(shift=" + shift + ") >= (modulo=" + modulo + ")");
		}
		if (itemIndexInView < 0)
		{
			throw new OSAException("BaseItemViewsHolder.ShiftIndex: (itemIndexInView=" + num + ")+(shift=" + shift + ") < 0");
		}
	}
}
