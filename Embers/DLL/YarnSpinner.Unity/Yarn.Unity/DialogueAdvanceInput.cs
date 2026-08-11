using System;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Yarn.Unity;

public class DialogueAdvanceInput : MonoBehaviour
{
	public enum ContinueButtonActionType
	{
		Up,
		Down
	}

	public enum ContinueActionType
	{
		None,
		KeyCode,
		VirtualButton,
		InputSystemAction,
		InputSystemActionFromAsset
	}

	[SerializeField]
	public DialogueViewBase dialogueView;

	[SerializeField]
	public ContinueActionType continueActionType = ContinueActionType.KeyCode;

	[SerializeField]
	public KeyCode continueActionKeyCode = KeyCode.Space;

	[SerializeField]
	public string continueActionButtonName = "Jump";

	[SerializeField]
	public ContinueButtonActionType continueActionOnButtonRelease;

	[SerializeField]
	public InputActionReference continueActionReference;

	[SerializeField]
	public InputAction continueAction = new InputAction("Skip", InputActionType.Button, CommonUsages.Submit);

	[SerializeField]
	public bool enableActionOnStart = true;

	public InputAction Action
	{
		get
		{
			switch (continueActionType)
			{
			case ContinueActionType.None:
			case ContinueActionType.KeyCode:
				return null;
			case ContinueActionType.InputSystemAction:
				return continueAction;
			case ContinueActionType.InputSystemActionFromAsset:
				if (!(continueActionReference != null))
				{
					return null;
				}
				return continueActionReference.action;
			default:
				throw new IndexOutOfRangeException($"Invalid continue action type {continueActionType}");
			}
		}
	}

	internal void Start()
	{
		if (dialogueView == null)
		{
			dialogueView = GetComponent<DialogueViewBase>();
		}
		if (Action != null)
		{
			Action.performed += UserPerformedAdvanceAction;
			if (enableActionOnStart)
			{
				Action.Enable();
			}
		}
	}

	internal void OnDisable()
	{
		if (Action != null)
		{
			Action.performed -= UserPerformedAdvanceAction;
		}
	}

	private void UserPerformedAdvanceAction(InputAction.CallbackContext obj)
	{
		dialogueView.UserRequestedViewAdvancement();
	}

	internal void Update()
	{
		bool flag = false;
		if (continueActionType == ContinueActionType.KeyCode)
		{
			flag = ((continueActionOnButtonRelease != ContinueButtonActionType.Up) ? Input.GetKeyDown(continueActionKeyCode) : Input.GetKeyUp(continueActionKeyCode));
		}
		else if (continueActionType == ContinueActionType.VirtualButton)
		{
			flag = ((continueActionOnButtonRelease != ContinueButtonActionType.Up) ? Input.GetButtonDown(continueActionButtonName) : Input.GetButtonUp(continueActionButtonName));
		}
		if (flag)
		{
			dialogueView.UserRequestedViewAdvancement();
		}
	}
}
