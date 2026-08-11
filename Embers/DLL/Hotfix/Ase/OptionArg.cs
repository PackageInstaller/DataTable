namespace Ase;

public class OptionArg
{
	private string optionName;

	private object obj;

	public string OptionName => optionName;

	public object Obj => obj;

	public OptionArg(object obj, string optionName)
	{
		this.optionName = optionName;
		this.obj = obj;
	}
}
