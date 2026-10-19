using ACT.Core;

namespace ACT.Battle;

public class CompRobot : EcsComponent
{
	public ICharacterSource robotSource;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		robotSource = null;
	}
}
