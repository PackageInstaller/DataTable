using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class WorldFailJumpItem : MonoBehaviour
{
	public int jumpId;

	public BImage icon;

	public LocalizeStringEvent jumpDes;

	public ActButton selfBtn;

	[SerializeField]
	private OperateBtnPrompt selectPromptA;

	private const int JUMPTOCHARACTERVIEW = 2745;

	private const int JUMPTOCHARACTERTUTORIAL = 2746;

	private bool _gamepadInputInited;

	private void Awake()
	{
		selfBtn?.SetBtnClick(Jump);
	}

	private void OnEnable()
	{
		RefreshDisplay();
		RefreshGamepadPromptState();
	}

	private void Update()
	{
		if (!(MonoECS.instance == null) && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			RefreshGamepadPromptState();
		}
	}

	private void OnDisable()
	{
		SetPromptVisible(visible: false);
	}

	private void RefreshDisplay()
	{
		if (jumpId == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("闯关失败的指引跳转Id没配，检查预制体！");
			}
			return;
		}
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(jumpId);
		if (runTimeJumpData.ModelType == LuminModelType.Unmanaged)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id为{jumpId}的跳转数据是为受系统管理的跳转，不合规，检查表或和对应策划核对");
			}
			return;
		}
		int key = runTimeJumpData.Params[0];
		JumpModel.UIJumpIdToUITypeMap.TryGetValue(key, out var value);
		LuminModelType item = value.Item2;
		int num = item switch
		{
			LuminModelType.CharacterView => 2745, 
			LuminModelType.Training => 2746, 
			_ => 0, 
		};
		if (num != 0)
		{
			jumpDes.SetReference(LocalizeTable.Common, num);
		}
		SystemOpen data = CoreUtils.GetData(item switch
		{
			LuminModelType.CharacterView => 1017, 
			LuminModelType.Training => 1024, 
			_ => -1, 
		}, RuntimeConfigs.data.systemOpens);
		if (data != null && icon != null)
		{
			this.GetImageStation().LoadImage(236, data.id, icon);
		}
	}

	private void Jump()
	{
		if (jumpId == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("闯关失败的指引跳转Id没配，检查预制体！");
			}
			return;
		}
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(jumpId);
		if (Model<JumpModel>.Interface.CanJump(runTimeJumpData).ShowType == JumpResult.JumpShowType.CanJump)
		{
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
		}
	}

	public bool JumpIsLegal()
	{
		if (jumpId == 0)
		{
			return false;
		}
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(jumpId);
		if (runTimeJumpData.ModelType == LuminModelType.Unmanaged)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id为{jumpId}的跳转数据是为受系统管理的跳转，不合规，检查表或和对应策划核对");
			}
			return false;
		}
		int key = runTimeJumpData.Params[0];
		JumpModel.UIJumpIdToUITypeMap.TryGetValue(key, out var value);
		LuminModelType item = value.Item2;
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(item switch
		{
			LuminModelType.CharacterView => SystemType.CharacterView, 
			LuminModelType.Training => SystemType.Training, 
			_ => SystemType.None, 
		}))
		{
			return false;
		}
		return true;
	}

	public void RefreshGamepadPromptState()
	{
		InitGamepadInput();
		bool flag = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && IsCurrentSelectedCell();
		SetPromptVisible(flag && JumpIsLegal() && gameObject.activeInHierarchy);
	}

	private void InitGamepadInput()
	{
		if (!_gamepadInputInited)
		{
			_gamepadInputInited = true;
			if (!(selectPromptA == null))
			{
				DisablePromptNavigation();
				selectPromptA.SetBindingAction("UI/Confirm");
				selectPromptA.SetVisible(vis: false);
				selectPromptA.RefreshIcon();
			}
		}
	}

	private void SetPromptVisible(bool visible)
	{
		if (!(selectPromptA == null))
		{
			selectPromptA.SetVisible(visible);
			if (visible)
			{
				selectPromptA.RefreshIcon();
			}
		}
	}

	private bool IsCurrentSelectedCell()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			return currentSelected.GetComponentInParent<WorldFailJumpItem>(includeInactive: true) == this;
		}
		return false;
	}

	private void DisablePromptNavigation()
	{
		ACT.ViewControl.SelectableEx[] componentsInChildren = selectPromptA.GetComponentsInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].enabled = false;
		}
		Selectable[] componentsInChildren2 = selectPromptA.GetComponentsInChildren<Selectable>(includeInactive: true);
		foreach (Selectable obj in componentsInChildren2)
		{
			UnityEngine.UI.Navigation navigation = obj.navigation;
			navigation.mode = UnityEngine.UI.Navigation.Mode.None;
			obj.navigation = navigation;
			obj.interactable = false;
		}
	}
}
