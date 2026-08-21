using Ase;
using ParadoxNotion.Design;

[Name("注释", 0)]
public class Comment : ActionTaskBase
{
	public string Content1;

	protected override string info => $"{Content1}";

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
