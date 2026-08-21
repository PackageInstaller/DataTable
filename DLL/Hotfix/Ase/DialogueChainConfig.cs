using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public class DialogueChainConfig : SerializedMonoBehaviour
{
	[Serializable]
	public class DialogueTaskButton : DialogueButtonConfig
	{
		public bool invertCondition;

		public List<OpenCondition> activeTaskCondition = new List<OpenCondition>();

		public override bool TaskConditionResult
		{
			get
			{
				CheckTaskCondition();
				return taskConditionResult;
			}
		}

		private void CheckTaskCondition()
		{
			if (invertCondition)
			{
				taskConditionResult = !Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().CheckMapDataNodeActived(activeTaskCondition);
			}
			else
			{
				taskConditionResult = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().CheckMapDataNodeActived(activeTaskCondition);
			}
		}
	}

	[Serializable]
	public class DialogueButtonConfig
	{
		public int buttonId;

		public int priority;

		protected bool taskConditionResult = true;

		public virtual bool TaskConditionResult => taskConditionResult;
	}

	[SerializeField]
	private List<DialogueButtonConfig> dialogGroup = new List<DialogueButtonConfig>();

	[SerializeField]
	private List<int> prologueIds;

	[SerializeField]
	private List<DialogueTaskButton> taskDialogGroup = new List<DialogueTaskButton>();

	[SerializeField]
	private List<TaskPrologue> taskPrologues;

	[SerializeField]
	private Dictionary<int, List<DialogueChainEventTrigger>> dialogueEventTriggers = new Dictionary<int, List<DialogueChainEventTrigger>>();

	[SerializeField]
	private Dictionary<int, string> dialogButtonLockState = new Dictionary<int, string>();

	public void RequiredData(List<int> prologueIds, List<int> dialogGroup, Dictionary<int, string> dialogButtonLockState, Dictionary<int, List<DialogueChainEventTrigger>> eventTriggers)
	{
		this.dialogGroup.Clear();
		this.dialogButtonLockState.Clear();
		dialogueEventTriggers.Clear();
		for (int i = 0; i < dialogGroup.Count; i++)
		{
			this.dialogGroup.Add(new DialogueButtonConfig
			{
				buttonId = dialogGroup[i],
				priority = 0
			});
		}
		this.prologueIds = prologueIds;
		foreach (KeyValuePair<int, string> item in dialogButtonLockState)
		{
			this.dialogButtonLockState.Add(item.Key, item.Value);
		}
		foreach (KeyValuePair<int, List<DialogueChainEventTrigger>> eventTrigger in eventTriggers)
		{
			List<DialogueChainEventTrigger> list = new List<DialogueChainEventTrigger>();
			list.AddRange(eventTrigger.Value);
			dialogueEventTriggers.Add(eventTrigger.Key, list);
		}
	}

	public void UpdateData(List<int> prologueIds, List<DialogueButtonConfig> dialogGroup)
	{
		this.dialogGroup = dialogGroup;
		this.prologueIds = prologueIds;
	}

	public void UpdateData(List<int> prologueIds, List<int> dialogGroup, Dictionary<int, string> dialogButtonLockState, Dictionary<int, List<DialogueChainEventTrigger>> eventTriggers)
	{
		this.dialogGroup = new List<DialogueButtonConfig>();
		for (int i = 0; i < dialogGroup.Count; i++)
		{
			this.dialogGroup.Add(new DialogueButtonConfig
			{
				buttonId = dialogGroup[i],
				priority = 0
			});
		}
		this.prologueIds = prologueIds;
		dialogueEventTriggers = eventTriggers;
		this.dialogButtonLockState = dialogButtonLockState;
	}

	public void Clear()
	{
		dialogGroup.Clear();
		dialogButtonLockState.Clear();
		prologueIds.Clear();
	}

	public List<DialogueButtonConfig> GetDialogButtonConfig()
	{
		return dialogGroup;
	}

	public Dictionary<int, string> GetDialogButtonState()
	{
		return dialogButtonLockState;
	}

	public List<int> GetDialogButtonGroup()
	{
		List<int> list = new List<int>();
		List<DialogueButtonConfig> list2 = new List<DialogueButtonConfig>();
		if (dialogGroup != null)
		{
			list2.AddRange(dialogGroup);
		}
		if (taskDialogGroup != null)
		{
			list2.AddRange(taskDialogGroup);
		}
		list2.Sort((DialogueButtonConfig x, DialogueButtonConfig y) => x.priority.CompareTo(y.priority));
		for (int num = 0; num < list2.Count; num++)
		{
			if (list2[num].TaskConditionResult)
			{
				list.Add(list2[num].buttonId);
			}
		}
		return list;
	}

	public List<int> GetDialogPrologue()
	{
		List<int> list = null;
		if (taskPrologues != null && taskPrologues.Count > 0)
		{
			foreach (TaskPrologue taskPrologue in taskPrologues)
			{
				if (taskPrologue.CheckTaskCondition())
				{
					if (list == null)
					{
						list = new List<int>();
					}
					list.Add(taskPrologue.PrologueId);
				}
			}
		}
		if (list != null)
		{
			return list;
		}
		return prologueIds ?? new List<int>();
	}

	public List<int> GetNormalDialogPrologue()
	{
		return prologueIds ?? new List<int>();
	}

	public string GetDialogButtonState(int buttonId)
	{
		if (dialogButtonLockState.ContainsKey(buttonId))
		{
			return dialogButtonLockState[buttonId];
		}
		return string.Empty;
	}

	public void ChangeDialogueButtonState(int buttonId, string state)
	{
		if (dialogButtonLockState.ContainsKey(buttonId))
		{
			dialogButtonLockState[buttonId] = state;
		}
		else
		{
			dialogButtonLockState.Add(buttonId, state);
		}
	}

	public void OnDialogSelect(int result)
	{
		if (!dialogueEventTriggers.ContainsKey(result))
		{
			return;
		}
		foreach (DialogueChainEventTrigger item in dialogueEventTriggers[result])
		{
			item.Execute();
		}
	}
}
