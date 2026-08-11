using System;
using GameFramework.Runtime;

namespace Ase;

public class TimeDuraValidData : ViewModelBase
{
	private TimeDuraSettle timeDura;

	private string timeConfig;

	private Action finishAction;

	private bool isValid;

	public string TimeConfig => timeConfig;

	public TimeDuraSettle TimeDura => timeDura;

	public bool IsTimeValid
	{
		get
		{
			return isValid;
		}
		private set
		{
			Set(ref isValid, value, "IsTimeValid");
		}
	}

	public TimeDuraValidData()
	{
	}

	public TimeDuraValidData(GroupTagEnum tag, string openTimeConfig)
	{
		timeConfig = openTimeConfig.Replace(',', '-');
		timeDura = TimeDuraSettle.CreateFromGuildCopy(tag, openTimeConfig);
		timeDura.AddValidChangedAction(OnValidChange);
	}

	public void OnValidChange(TimeValidArg validArg)
	{
		IsTimeValid = validArg.isValid;
		if (validArg.eventType == TimeEventType.End)
		{
			finishAction?.Invoke();
		}
	}

	public void AddFinishAction(Action finishAction)
	{
		this.finishAction = finishAction;
	}

	public void Clear()
	{
		finishAction = null;
	}

	public bool IsValid()
	{
		if (timeDura != null)
		{
			return timeDura.IsValid;
		}
		return false;
	}
}
