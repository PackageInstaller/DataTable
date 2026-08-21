namespace Ase;

public class NewsTipViewModel : OptionBase
{
	public string content;

	public long id;

	public NewsTipViewModel(OptionBase parent, long id, string content)
	{
		base.parent = parent;
		this.id = id;
		this.content = content;
	}
}
