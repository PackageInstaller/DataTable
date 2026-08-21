using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;

namespace Ase.ECS;

public class DialogChainComponent : BaseComponent
{
	public class DialogButton
	{
		private DRDialogButton config;

		private Func<DialogButton, Task<bool>> OnClick;

		private string state;

		public string Text => config.Text;

		public string Result => config.Result;

		public string Args => config.Args;

		public string ParadoxArgs => config.ParadoxArgs;

		public int ID => config.Id;

		public string State => state;

		public string IconType => config.IconType;

		public DialogButton(DRDialogButton config, string state, Func<DialogButton, Task<bool>> onClick)
		{
			this.config = config;
			OnClick = onClick;
			this.state = state;
		}

		public Task<bool> ClickButton()
		{
			return OnClick(this);
		}

		public void ChangeState(string state)
		{
			this.state = state;
		}
	}

	public class DialogChain
	{
		private DRDialogChain config;

		public int NoButtonResult => config.NoButtonResult;

		public List<List<int>> DialogueChainConfig => config.ButtonGroupList;

		public List<List<int>> DialoguePrologueConfig => config.PrologueList;

		public DialogChain(DRDialogChain config)
		{
			this.config = config;
		}
	}

	public static string DialogueSelectResultKey = "DialogueSelectResultKey";

	private AIParadoxComponent aiParadoxComponent;

	public Dictionary<string, Func<DialogButton, bool>> buttonActions = new Dictionary<string, Func<DialogButton, bool>>();

	private List<DialogButton> dialogButtons = new List<DialogButton>();

	private DialogChain dialogChain;

	private List<DRDialogPrologue> dialogPrologue = new List<DRDialogPrologue>();

	private DialogueChainConfig dialogueConfig;

	private DialogueViewModel dialogueViewModel;

	private InteractiveStateComponent interactiveStateComponent;

	public override void OnStart(object data)
	{
		base.OnStart(data);
		buttonActions = new Dictionary<string, Func<DialogButton, bool>>
		{
			{ "打开对话链", CreateChain },
			{ "关闭界面", Close },
			{ "返回首页", ReturnFirst },
			{ "返回对话链首页", ReturnChainFirst },
			{ "创建按钮组", CreateButtonGroup },
			{ "锁定按钮", LockButton },
			{ "解锁按钮", UnLockButton }
		};
		interactiveStateComponent = mBaseEntity.GetComponent<InteractiveStateComponent>();
		aiParadoxComponent = mBaseEntity.GetComponent<AIParadoxComponent>();
	}

	public void BindingConfig(DialogueChainConfig dialogueChainConfig)
	{
		if (!((UnityEngine.Object)(object)dialogueChainConfig == null))
		{
			dialogueConfig = dialogueChainConfig;
			UpdateDialogPrologue(dialogueConfig.GetDialogPrologue());
			UpdateDialogButton(dialogueConfig.GetDialogButtonGroup());
		}
	}

	public DialogueViewModel GetDialogueViewModel()
	{
		return dialogueViewModel;
	}

	public bool NeedOpenUI()
	{
		if ((UnityEngine.Object)(object)dialogueConfig == null)
		{
			return false;
		}
		UpdateDialogPrologue(dialogueConfig.GetDialogPrologue());
		UpdateDialogButton(dialogueConfig.GetDialogButtonGroup());
		if (dialogPrologue != null)
		{
			if (dialogPrologue.Count <= 0)
			{
				return dialogButtons.Count > 0;
			}
			return true;
		}
		return false;
	}

	public DialogueViewModel OpenDialogUI()
	{
		if ((UnityEngine.Object)(object)dialogueConfig == null)
		{
			return null;
		}
		return dialogueViewModel;
	}

	public void UpdateDialogueViewModel()
	{
		if (dialogueViewModel == null)
		{
			dialogueViewModel = new DialogueViewModel(delegate
			{
				if (interactiveStateComponent != null)
				{
					interactiveStateComponent.ChangeInteractiveState(MapItemState.Finish);
				}
				CloseDialogUI();
			}, delegate
			{
				ReturnFirst(null);
			});
		}
		dialogueViewModel.UpdateData(dialogButtons, dialogPrologue, dialogChain?.NoButtonResult ?? 2);
	}

	public void CloseDialogUI()
	{
		if (dialogueViewModel != null)
		{
			dialogueViewModel.OnCloseDialogUIRequest();
		}
	}

	private void UpdateDialogPrologue(List<int> prologueGroup)
	{
		dialogPrologue.Clear();
		if (prologueGroup == null || prologueGroup.Count <= 0)
		{
			return;
		}
		foreach (int item in prologueGroup)
		{
			if (item > 0)
			{
				DRDialogPrologue dataRow = GameEntry.DataTable.GetDataRow<DRDialogPrologue>(item);
				if (dataRow != null)
				{
					dialogPrologue.Add(dataRow);
				}
			}
		}
		UpdateDialogueViewModel();
	}

	private void UpdateDialogButton(List<int> dialogGroup)
	{
		if ((UnityEngine.Object)(object)dialogueConfig == null)
		{
			return;
		}
		dialogButtons.Clear();
		if (dialogGroup == null || dialogGroup.Count <= 0)
		{
			return;
		}
		foreach (int item in dialogGroup)
		{
			DRDialogButton dataRow = GameEntry.DataTable.GetDataRow<DRDialogButton>(item);
			if (dataRow != null)
			{
				dialogButtons.Add(new DialogButton(dataRow, dialogueConfig.GetDialogButtonState(item), OnDialogButtonClick));
			}
		}
		UpdateDialogueViewModel();
	}

	private void LockDialogButton(int buttonId, string state)
	{
		ChangeDialogueButtonState(buttonId, state);
	}

	public void ChangeDialogueButtonState(int buttonId, string state)
	{
		if (!((UnityEngine.Object)(object)dialogueConfig == null))
		{
			NPCNode data = base.Entity.GetData<NPCNode>("MAPDATANODEKEY");
			if (!((UnityEngine.Object)(object)data == null))
			{
				int levelId = data.SceneSystem.GetLevelId();
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateDialogueButtonState(levelId, data.Uid, buttonId, state);
			}
		}
	}

	public void UpdateDialogButtonInstantiate(int buttonId, string state)
	{
		dialogButtons.Find((DialogButton x) => x.ID == buttonId)?.ChangeState(state);
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		CloseDialogUI();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		CloseDialogUI();
	}

	private bool CreateChain(DialogButton dialogButton)
	{
		DRDialogChain dataRow = GameEntry.DataTable.GetDataRow<DRDialogChain>(int.Parse(dialogButton.Args));
		if (dataRow == null)
		{
			return false;
		}
		dialogChain = new DialogChain(dataRow);
		if (dialogChain.DialogueChainConfig != null && dialogChain.DialogueChainConfig.Count > 0)
		{
			UpdateDialogButton(dialogChain.DialogueChainConfig[0]);
		}
		else
		{
			UpdateDialogButton(null);
		}
		if (dialogChain.DialoguePrologueConfig != null && dialogChain.DialoguePrologueConfig.Count > 0)
		{
			UpdateDialogPrologue(dialogChain.DialoguePrologueConfig[0]);
		}
		else
		{
			UpdateDialogPrologue(null);
		}
		return true;
	}

	private bool Close(DialogButton dialogButton)
	{
		if (interactiveStateComponent != null)
		{
			interactiveStateComponent.ChangeInteractiveState(MapItemState.Finish);
		}
		CloseDialogUI();
		return true;
	}

	private bool ReturnFirst(DialogButton dialogButton)
	{
		UpdateDialogPrologue(dialogueConfig.GetDialogPrologue());
		UpdateDialogButton(dialogueConfig.GetDialogButtonGroup());
		return true;
	}

	private bool ReturnChainFirst(DialogButton dialogButton)
	{
		if (dialogChain != null && dialogChain.DialogueChainConfig != null && dialogChain.DialogueChainConfig.Count > 0)
		{
			UpdateDialogButton(dialogChain.DialogueChainConfig[0]);
		}
		else
		{
			UpdateDialogButton(null);
		}
		if (dialogChain != null && dialogChain.DialoguePrologueConfig != null && dialogChain.DialoguePrologueConfig.Count > 0)
		{
			UpdateDialogPrologue(dialogChain.DialoguePrologueConfig[0]);
		}
		else
		{
			UpdateDialogPrologue(null);
		}
		return true;
	}

	private bool CreateButtonGroup(DialogButton dialogButton)
	{
		if (int.TryParse(dialogButton.Args, out var result))
		{
			if (dialogChain != null && dialogChain.DialogueChainConfig != null && dialogChain.DialogueChainConfig.Count > result)
			{
				UpdateDialogButton(dialogChain.DialogueChainConfig[result]);
			}
			if (dialogChain != null && dialogChain.DialoguePrologueConfig != null && dialogChain.DialoguePrologueConfig.Count > result)
			{
				UpdateDialogPrologue(dialogChain.DialoguePrologueConfig[result]);
			}
		}
		return true;
	}

	private bool LockButton(DialogButton dialogButton)
	{
		if (int.TryParse(dialogButton.Args, out var result))
		{
			LockDialogButton(result, "lock");
		}
		return true;
	}

	private bool UnLockButton(DialogButton dialogButton)
	{
		if (int.TryParse(dialogButton.Args, out var result))
		{
			LockDialogButton(result, "unlock");
		}
		return true;
	}

	private async Task<bool> OnDialogButtonClick(DialogButton dialogButton)
	{
		if ((UnityEngine.Object)(object)dialogueConfig == null)
		{
			return false;
		}
		if (aiParadoxComponent != null && !string.IsNullOrEmpty(dialogButton.ParadoxArgs))
		{
			aiParadoxComponent.SetVariableValues(DialogueSelectResultKey, dialogButton.ParadoxArgs);
		}
		dialogueConfig.OnDialogSelect(dialogButton.ID);
		if (buttonActions.TryGetValue(dialogButton.Result, out var value))
		{
			return value(dialogButton);
		}
		return true;
	}
}
