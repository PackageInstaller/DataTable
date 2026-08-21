namespace Ase;

public class ShowViewArg
{
	private object userData;

	private bool isShow;

	public object UserData => userData;

	public bool IsShow => isShow;

	public ShowViewArg(object userData, bool isShow)
	{
		this.userData = userData;
		this.isShow = isShow;
	}
}
