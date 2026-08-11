using System;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DrawCardTouchViewModel : OptionBase
{
	private DrawCardManager drawCardManager;

	private SimpleCommand skipCmd;

	private Action openDrawCardSingleActon;

	private Action closeKnockAction;

	private bool isOpen;

	private string actionName;

	private InteractionRequest closeWindowRequest;

	private bool showKnock;

	public SimpleCommand SkipCmd => skipCmd;

	public InteractionRequest CloseWindowRequest => closeWindowRequest;

	public bool ShowKnock
	{
		get
		{
			return showKnock;
		}
		set
		{
			Set(ref showKnock, value, "ShowKnock");
		}
	}

	public DrawCardTouchViewModel(OptionBase parent)
	{
		base.parent = parent;
		isOpen = false;
		skipCmd = new SimpleCommand(SkipOnClick);
		openDrawCardSingleActon = OpenDrawCardSingleWindow;
		closeKnockAction = CloseKnockObj;
		LoadDrawCardScene();
		actionName = "OpenResult";
		closeWindowRequest = new InteractionRequest();
		showKnock = true;
	}

	private async void LoadDrawCardScene()
	{
		Loading obj = await Loading.Show();
		drawCardManager = UnityEngine.Object.FindObjectOfType<DrawCardManager>();
		drawCardManager.OpenDrawCardScene(openDrawCardSingleActon, closeKnockAction);
		obj.Dispose();
	}

	private void CloseKnockObj()
	{
		if (ShowKnock)
		{
			ShowKnock = false;
		}
	}

	private void OpenDrawCardSingleWindow()
	{
		if (!isOpen)
		{
			isOpen = true;
			PlayOutAnimation();
			parent.ItemOnClick(actionName);
		}
	}

	private void PlayOutAnimation()
	{
		closeWindowRequest.Raise();
	}

	private void SkipOnClick()
	{
		skipCmd.Enabled = false;
		actionName = "BeatStoneSkip";
		OpenDrawCardSingleWindow();
	}
}
