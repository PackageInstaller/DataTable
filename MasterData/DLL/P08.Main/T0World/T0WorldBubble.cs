using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace T0World;

public class T0WorldBubble : MonoBehaviour
{
	public Button actionButton;

	public ControllerExCollection controllerEx;

	private ControllerEx typeController;

	private T0WorldUIFollow uiFollow;

	private T0InterationBubbleData bubbleData;

	private bool isInUse;

	private void Awake()
	{
		actionButton.onClick.AddListener(delegate
		{
			OnClick();
		});
		typeController = controllerEx?.GetController("bubbleType");
		uiFollow = GetComponentInChildren<T0WorldUIFollow>();
		if (uiFollow != null)
		{
			uiFollow.enabled = false;
			base.gameObject.SetActive(value: false);
			Canvas component = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>();
			uiFollow.canvas = component;
		}
	}

	public void RefreshBubbleShow(T0InterationBubbleData bubbleData)
	{
		this.bubbleData = bubbleData;
		if (uiFollow != null && bubbleData.isFollowUI)
		{
			T0WorldAgent agent = T0WorldScene.Scene.agentManager.GetAgent(bubbleData.entityID);
			if (agent != null)
			{
				uiFollow.origin = agent.transform;
				uiFollow.offset = bubbleData.pos;
				uiFollow.UpdatePos();
				uiFollow.enabled = true;
			}
		}
		switch (bubbleData.talkType)
		{
		case TalkType.Exit:
			typeController.SetSelectedState("exit");
			break;
		case TalkType.Interact:
			typeController.SetSelectedState("interation");
			break;
		case TalkType.Go:
			typeController.SetSelectedState("go");
			break;
		}
	}

	public void OnClick()
	{
		if (bubbleData != null && isInUse)
		{
			bubbleData.IsFinish = true;
		}
	}

	public bool CheckIsUse()
	{
		return isInUse;
	}

	public void OnCreate()
	{
		isInUse = true;
		base.gameObject.SetActive(value: true);
	}

	public void OnReuse()
	{
		isInUse = false;
		base.gameObject.SetActive(value: false);
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}
}
