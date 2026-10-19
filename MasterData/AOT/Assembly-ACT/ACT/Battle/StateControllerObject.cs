namespace ACT.Battle;

public abstract class StateControllerObject
{
	public abstract string ToString(int padLeft = 0);

	protected string PadLeft(int padLeft = 0)
	{
		string text = "";
		if (padLeft > 0)
		{
			text += "├";
		}
		for (int i = 0; i < padLeft - 1; i++)
		{
			text += "─";
		}
		return text;
	}
}
