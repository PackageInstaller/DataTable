using GameFramework.Runtime;

namespace Ase;

public class TowerBlackScreenViewModel : OptionBase
{
	private float hideTime;

	private InteractionRequest balckScreenHide = new InteractionRequest();

	private InteractionRequest showEndTimeRequest = new InteractionRequest();

	public float HideTime => hideTime;

	public IInteractionRequest BalckScreenHide => balckScreenHide;

	public IInteractionRequest ShowEndTimeRequest => showEndTimeRequest;

	public void PlayBlackScreenHide()
	{
		balckScreenHide.Raise();
	}

	public void SetHideTime(float windowHideTime)
	{
		hideTime = windowHideTime;
	}

	public void ShowEndTime()
	{
		showEndTimeRequest.Raise();
	}
}
