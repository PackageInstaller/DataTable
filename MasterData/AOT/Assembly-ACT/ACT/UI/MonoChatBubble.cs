using System;
using ACT.Model.ChatBubbleModel;
using ACT.Utility;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoChatBubble : MonoBehaviour
{
	public LocalizeStringEvent content;

	private IBubbleObject _bubbleObject;

	private RuntimeChatBubbleGroupData _runtimeChatBubbleGroupData;

	public void BindBubbleObject(IBubbleObject bubbleObject)
	{
		_bubbleObject = bubbleObject;
		Transform transform = _bubbleObject?.GetBubbleRootTransform();
		base.transform.SetParent(transform ? transform : GameUtility.npcInfoRoot, worldPositionStays: false);
		base.transform.localPosition = Vector3.zero;
	}

	public void BindChatBubbleGroupData(RuntimeChatBubbleGroupData newData)
	{
		if (_runtimeChatBubbleGroupData != null)
		{
			RuntimeChatBubbleGroupData runtimeChatBubbleGroupData = _runtimeChatBubbleGroupData;
			runtimeChatBubbleGroupData.onSingleBubbleHide = (Action)Delegate.Remove(runtimeChatBubbleGroupData.onSingleBubbleHide, new Action(Hide));
			RuntimeChatBubbleGroupData runtimeChatBubbleGroupData2 = _runtimeChatBubbleGroupData;
			runtimeChatBubbleGroupData2.onSingleBubbleShow = (Action)Delegate.Remove(runtimeChatBubbleGroupData2.onSingleBubbleShow, new Action(Show));
		}
		_runtimeChatBubbleGroupData = newData;
		RuntimeChatBubbleGroupData runtimeChatBubbleGroupData3 = _runtimeChatBubbleGroupData;
		runtimeChatBubbleGroupData3.onSingleBubbleHide = (Action)Delegate.Combine(runtimeChatBubbleGroupData3.onSingleBubbleHide, new Action(Hide));
		RuntimeChatBubbleGroupData runtimeChatBubbleGroupData4 = _runtimeChatBubbleGroupData;
		runtimeChatBubbleGroupData4.onSingleBubbleShow = (Action)Delegate.Combine(runtimeChatBubbleGroupData4.onSingleBubbleShow, new Action(Show));
	}

	private void OnDestroy()
	{
		ResetData();
	}

	private void ResetData()
	{
		_bubbleObject = null;
		if (_runtimeChatBubbleGroupData != null)
		{
			RuntimeChatBubbleGroupData runtimeChatBubbleGroupData = _runtimeChatBubbleGroupData;
			runtimeChatBubbleGroupData.onSingleBubbleHide = (Action)Delegate.Remove(runtimeChatBubbleGroupData.onSingleBubbleHide, new Action(Hide));
			RuntimeChatBubbleGroupData runtimeChatBubbleGroupData2 = _runtimeChatBubbleGroupData;
			runtimeChatBubbleGroupData2.onSingleBubbleShow = (Action)Delegate.Remove(runtimeChatBubbleGroupData2.onSingleBubbleShow, new Action(Show));
			_runtimeChatBubbleGroupData = null;
		}
	}

	public void Reset()
	{
		ResetData();
		if ((bool)gameObject)
		{
			if ((bool)GameUtility.npcInfoRoot)
			{
				transform.SetParent(GameUtility.npcInfoRoot, worldPositionStays: false);
			}
			gameObject.SetActive(value: false);
		}
	}

	private void Hide()
	{
		gameObject.SetActive(value: false);
	}

	private void Show()
	{
		gameObject.SetActive(value: true);
		UpdateContent();
	}

	private void UpdateContent()
	{
		content.SetTable("MainStory");
		content.StringReference.TableEntryReference = _runtimeChatBubbleGroupData.dialogueBubbleContentData.BubbleText;
	}
}
