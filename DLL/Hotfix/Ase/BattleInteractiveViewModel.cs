using System;
using GameFramework.Runtime;

namespace Ase;

public class BattleInteractiveViewModel : OptionBase
{
	private Action interactiveCallback;

	private bool active;

	private string iconType;

	private float process;

	private InteractionRequest onIconTypeUpdatRequest;

	private SimpleCommand onInteractiveButtonClickCommand;

	public bool Active
	{
		get
		{
			return active;
		}
		set
		{
			Set<bool>(ref active, value, "Active");
		}
	}

	public string IconType
	{
		get
		{
			return iconType;
		}
		set
		{
			Set(ref iconType, value, "IconType");
		}
	}

	public float Process
	{
		get
		{
			return process;
		}
		set
		{
			Set<float>(ref process, value, "Process");
		}
	}

	public IInteractionRequest OnIconTypeUpdatRequest => onIconTypeUpdatRequest;

	public SimpleCommand OnInteractiveButtonClickCommand => onInteractiveButtonClickCommand;

	public BattleInteractiveViewModel()
	{
	}

	public BattleInteractiveViewModel(OptionBase parent)
	{
		base.parent = parent;
		process = 0f;
		active = false;
		onIconTypeUpdatRequest = new InteractionRequest();
		onInteractiveButtonClickCommand = new SimpleCommand(OnInteractiveButtonClick);
	}

	public void OnInteractiveButtonClick()
	{
		if (interactiveCallback != null)
		{
			interactiveCallback();
			interactiveCallback = null;
		}
	}

	public void Init()
	{
		Active = false;
	}

	public void SetInteractiveCallback(Action interactiveCallback)
	{
		this.interactiveCallback = interactiveCallback;
	}
}
