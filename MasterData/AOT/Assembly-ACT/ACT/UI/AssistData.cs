using System;
using ACT.Event;
using UnityEngine;

namespace ACT.UI;

public abstract class AssistData
{
	public float assistPercent { get; protected set; }

	public event Action<float> OnAssistPercentChanged;

	public event Action<CharacterAssistActiveChangeEvt> OnCharacterAssistActiveChange;

	public void HandleActiveChange(CharacterAssistActiveChangeEvt evt)
	{
		OnCharacterAssistActiveChange?.Invoke(evt);
	}

	public virtual void UpdateAssistPercent(float percent)
	{
		if (!Mathf.Approximately(assistPercent, percent))
		{
			assistPercent = percent;
			OnAssistPercentChanged?.Invoke(assistPercent);
		}
	}
}
