using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ToastDropdownView : UGuiView
{
	public ToastDropdownItem toastTemplate;

	private List<ToastDropdownItem> toasts = new List<ToastDropdownItem>();

	private float duration;

	private IUIViewGroup viewGroup;

	private UILayout layout;

	private void Update()
	{
		if (duration <= 0f)
		{
			Cancel();
		}
		else
		{
			duration -= Time.deltaTime;
		}
	}

	public void ShowToast(string text, float duration, Action callback, string configData)
	{
		GetToastView().Show(text, duration, configData, callback);
		this.duration += duration;
	}

	public ToastDropdownItem GetToastView()
	{
		ToastDropdownItem toastDropdownItem = UnityEngine.Object.Instantiate(toastTemplate, base.transform);
		toasts.Add(toastDropdownItem);
		toastDropdownItem.Visibility = false;
		return toastDropdownItem;
	}

	public void Init(IUIViewGroup viewGroup, UILayout layout)
	{
		this.viewGroup = viewGroup;
		this.layout = layout;
		this.viewGroup.AddView(this, this.layout);
		Visibility = true;
		if (EnterAnimation != null)
		{
			EnterAnimation.Play();
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
				viewGroup.RemoveView(this);
				UnityEngine.Object.Destroy(Owner);
			}).Play();
		}
		else
		{
			Visibility = false;
			viewGroup.RemoveView(this);
			UnityEngine.Object.Destroy(Owner);
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
			viewGroup.RemoveView(this);
			UnityEngine.Object.Destroy(Owner);
		}
	}

	protected override void OnDestroy()
	{
		if (toasts != null)
		{
			for (int num = toasts.Count - 1; num >= 0; num--)
			{
				UnityEngine.Object.DestroyImmediate(toasts[num]);
				toasts[num] = null;
			}
			toasts = null;
		}
		GameEntry.Resource.UnloadAsset(AssetUtility.GetUIFormAsset("Common/ToastDropdownView"));
		base.OnDestroy();
	}
}
