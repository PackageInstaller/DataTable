using System;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ToastDropdownItem : UGuiView
{
	public Text text;

	private Action callback;

	protected string configData;

	public virtual string ConfigData
	{
		get
		{
			return configData;
		}
		set
		{
			configData = value;
		}
	}

	public void Show(string text, float duration, string configData, Action callback)
	{
		if (!Visibility)
		{
			this.text.text = text;
			ConfigData = configData;
			this.callback = callback;
			Visibility = true;
			if (EnterAnimation != null)
			{
				EnterAnimation.Play();
			}
			if (duration > 0f)
			{
				StartCoroutine(DelayDismiss(duration));
			}
		}
	}

	public void Cancel()
	{
		if (this == null || Owner == null)
		{
			return;
		}
		if (!Visibility)
		{
			UnityEngine.Object.Destroy(Owner);
		}
		else if (ExitAnimation != null)
		{
			ExitAnimation.OnEnd(delegate
			{
				Visibility = false;
				UnityEngine.Object.Destroy(Owner);
				DoCallback();
			}).Play();
		}
		else
		{
			Visibility = false;
			UnityEngine.Object.Destroy(Owner);
			DoCallback();
		}
	}

	public void ForceCancel()
	{
		if (!(this == null) && !(Owner == null))
		{
			if (!Visibility)
			{
				UnityEngine.Object.Destroy(Owner);
				return;
			}
			StopAllCoroutines();
			Visibility = false;
			UnityEngine.Object.Destroy(Owner);
			DoCallback();
		}
	}

	protected IEnumerator DelayDismiss(float duration)
	{
		yield return new WaitForSecondsRealtime(duration);
		Cancel();
	}

	protected void DoCallback()
	{
		try
		{
			if (callback != null)
			{
				callback();
			}
		}
		catch (Exception)
		{
		}
	}
}
