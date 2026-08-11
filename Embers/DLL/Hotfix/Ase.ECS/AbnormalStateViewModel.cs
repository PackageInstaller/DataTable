using UnityEngine;

namespace Ase.ECS;

public class AbnormalStateViewModel : OptionBase
{
	private AbnormalState abnormalState;

	private float maxProgress;

	private float currentProgress;

	private bool isActive;

	private bool isDead;

	private Color outColor;

	private Color innerColor;

	private string stateIcon;

	private float removeCanvasGroup;

	private bool willRemove;

	private float willRemoveDec;

	private float removeTime = 2f;

	public AbnormalState AbnormalState => abnormalState;

	public bool IsDead
	{
		get
		{
			return isDead;
		}
		set
		{
			Set(ref isDead, value, "IsDead");
		}
	}

	public float MaxProgress
	{
		get
		{
			return maxProgress;
		}
		set
		{
			Set(ref maxProgress, value, "MaxProgress");
		}
	}

	public float CurrentProgress
	{
		get
		{
			return currentProgress;
		}
		set
		{
			Set(ref currentProgress, value, "CurrentProgress");
		}
	}

	public bool IsActive
	{
		get
		{
			return isActive;
		}
		set
		{
			Set(ref isActive, value, "IsActive");
		}
	}

	public Color OutColor
	{
		get
		{
			return outColor;
		}
		set
		{
			Set(ref outColor, value, "OutColor");
		}
	}

	public Color InnerColor
	{
		get
		{
			return innerColor;
		}
		set
		{
			Set(ref innerColor, value, "InnerColor");
		}
	}

	public string StateIcon
	{
		get
		{
			return stateIcon;
		}
		set
		{
			Set(ref stateIcon, value, "StateIcon");
		}
	}

	public bool WillRemove
	{
		get
		{
			return willRemove;
		}
		set
		{
			Set(ref willRemove, value, "WillRemove");
		}
	}

	public float RemoveCanvasGroup
	{
		get
		{
			return removeCanvasGroup;
		}
		set
		{
			Set(ref removeCanvasGroup, value, "RemoveCanvasGroup");
		}
	}

	public AbnormalStateViewModel(AbnormalState abnormalState)
	{
		this.abnormalState = abnormalState;
		isActive = abnormalState.IsActive;
		currentProgress = abnormalState.CurrentProgress;
		maxProgress = abnormalState.MaxProgress;
		StateIcon = abnormalState.Config.AbnormalIcon;
		ColorUtility.TryParseHtmlString(abnormalState.Config.IconOutColor, out outColor);
		ColorUtility.TryParseHtmlString(abnormalState.Config.IconInnerColor, out innerColor);
		OutColor = outColor;
		InnerColor = innerColor;
		removeTime = this.abnormalState.Config.Duration;
		RemoveCanvasGroup = 1f;
	}

	public void Update(float deltaTime)
	{
		if (WillRemove)
		{
			CurrentProgress -= willRemoveDec * deltaTime;
			removeTime -= deltaTime;
			if (removeTime < 0.1f)
			{
				RemoveCanvasGroup = removeTime / 0.1f;
			}
		}
		else if (abnormalState != null)
		{
			IsActive = abnormalState.IsActive;
			if (IsActive)
			{
				SetWillRemove();
			}
			IsDead = abnormalState.IsDead;
			CurrentProgress = abnormalState.CurrentProgress;
			MaxProgress = abnormalState.MaxProgress;
		}
	}

	private void SetWillRemove()
	{
		WillRemove = true;
		CurrentProgress = abnormalState.CurrentProgress;
		willRemoveDec = CurrentProgress / removeTime;
	}

	public void RecudeRemoveTime()
	{
		CurrentProgress -= willRemoveDec * abnormalState.Config.ImmunizationTime;
	}

	public void RemoveTimeChanged(float coolTime)
	{
		removeTime = coolTime;
		willRemoveDec = currentProgress / coolTime;
	}
}
