using GameFramework.Runtime;

namespace Ase;

public class YarnSpinnerStoryViewModel : OptionBase
{
	private InteractionRequest skipRequest;

	private bool autoState;

	private bool fastState;

	public IInteractionRequest SkipRequest => skipRequest;

	public bool AutoState
	{
		get
		{
			return autoState;
		}
		set
		{
			Set(ref autoState, value, "AutoState");
		}
	}

	public bool FastState
	{
		get
		{
			return fastState;
		}
		set
		{
			Set(ref fastState, value, "FastState");
		}
	}

	public YarnSpinnerStoryViewModel()
	{
		skipRequest = new InteractionRequest(this);
	}

	public void Skip()
	{
		skipRequest.Raise();
	}
}
