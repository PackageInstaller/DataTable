using AIScript.Monster.Template;

namespace AIScript.Monster._70061WuYu.HorrorGhost;

public class Parallel_TerrorGhost : AIScript.Monster.Template.Parallel
{
	private const float Transparency = 1f;

	private const float FadeDuration = 0.5f;

	public override void OnStart()
	{
		base.OnStart();
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
		_actor.TransparentFadeIn(1f);
	}

	public override void OnDisable()
	{
		_actor.TransparentFadeOut();
		base.OnDisable();
	}
}
