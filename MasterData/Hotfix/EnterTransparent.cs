[AdventureEffect(HotfixEnum.effectType.ENTER_TRANSPARENT)]
public class EnterTransparent : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).TransparentFadeIn();
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).TransparentFadeOut();
		}
	}
}
