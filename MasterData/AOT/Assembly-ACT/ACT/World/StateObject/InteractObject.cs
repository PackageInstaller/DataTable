using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractObject")]
public class InteractObject : StateObjectBase, ISerializationCallbackReceiver
{
	[SerializeField]
	[Tooltip("交互物转变改变时同步信息，比如角色装态和位置 ")]
	public bool m_IsSyncCharacterInfo = true;

	[SerializeField]
	[Tooltip("（前提是交互物需要在服务器存档）")]
	private bool m_ServiceSave = true;

	public List<InteractState> interactStates = new List<InteractState>();

	private InteractState _currentState;

	public override bool serviceSave => m_ServiceSave;

	public InteractState currentState
	{
		get
		{
			return _currentState;
		}
		private set
		{
			_currentState = value;
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		for (int i = 0; i < interactStates.Count; i++)
		{
			interactStates[i].BindInteractObject(this);
		}
	}

	public InteractState GetState(int stateId)
	{
		return interactStates.Find((InteractState x) => x.id == stateId);
	}

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		for (int i = 0; i < interactStates.Count; i++)
		{
			for (int j = 0; j < interactStates[i].interactEntries.Count; j++)
			{
				interactStates[i].interactEntries[j].BindData(compStateObject.StateWorldAssetData);
			}
		}
		base.InitStateObject(stateId);
		currentState?.OnInitStateObject();
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		currentState = GetState(toStateId);
	}

	protected override void HandleInitState(int stateId)
	{
		currentState.OnInit(stateId);
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		currentState.OnUnInit(stateId);
	}

	protected override void HandleEnterInteract()
	{
		currentState.OnEnter();
	}

	protected override void HandleExitInteract()
	{
		currentState.OnExit();
	}

	protected override void OnCompleteTransition()
	{
		currentState.OnCompleteTransition();
	}

	public override void OnExitExposed()
	{
		currentState.OnExitExposed();
		entity.GetCompInteract()?.InvokeOnExitExposed();
	}

	public override void OnExposed()
	{
		currentState.OnExposed();
		entity.GetCompInteract()?.InvokeOnExpose(entity);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return currentState.transition.Contains(toStateId);
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (entryIndex < currentState.interactEntries.Count)
		{
			InteractEntry interactEntry = currentState.interactEntries[entryIndex];
			if (interactEntry.InteractType == InteractType.Button)
			{
				if (interactEntry.ConditionPassed)
				{
					interactEntry.HandleInteract(eb, interactSource);
				}
				else
				{
					GameUtility.OpenToolTip(LocalizationCommonData.CommonString.MissingRequireItem);
				}
			}
			else
			{
				interactEntry.HandleInteract(eb, interactSource);
			}
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return interactStates.Exists((InteractState x) => x.id == stateId);
	}

	protected override bool NeedInteractTip()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry == null || interactEntry.TipIcon == -1)
		{
			return base.NeedInteractTip();
		}
		return true;
	}

	protected override InteractEntry GetInteractEntry()
	{
		InteractState interactState = currentState;
		if (interactState != null)
		{
			List<InteractEntry> interactEntries = interactState.interactEntries;
			if (interactEntries != null && interactEntries.Count > 0)
			{
				return currentState.interactEntries.FirstOrDefault();
			}
		}
		return null;
	}

	public override Transform GetInteractTipTransform()
	{
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry != null)
		{
			return interactEntry.TipTransform;
		}
		foreach (InteractState interactState in interactStates)
		{
			if (interactState == null)
			{
				continue;
			}
			List<InteractEntry> interactEntries = interactState.interactEntries;
			if (interactEntries != null && interactEntries.Count > 0)
			{
				InteractEntry interactEntry2 = interactState.interactEntries.FirstOrDefault((InteractEntry x) => x.TipTransform);
				if (interactEntry2 != null)
				{
					return interactEntry2.TipTransform;
				}
			}
		}
		return transform;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (entity.GetCompStateObject().StateWorldAssetData is LightHouseData)
		{
			if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
			{
				return ShowType.Show;
			}
			return ShowType.Hide;
		}
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry == null)
		{
			return ShowType.Hide;
		}
		if (interactEntry.InteractType == InteractType.Button)
		{
			if (!interactEntry.ConditionPassed)
			{
				return interactEntry.ConditionFailShowType;
			}
			return ShowType.Show;
		}
		return ShowType.Show;
	}

	public override bool ShowInteractTip()
	{
		if (entity.GetCompStateObject().StateWorldAssetData is LightHouseData)
		{
			return !Singleton<ProtagonistManager>.instance.IsProtagonist;
		}
		return GetInteractEntry()?.TipConditionPassed ?? false;
	}

	public override bool CanInteract()
	{
		if (!base.CanInteract())
		{
			return false;
		}
		if (entity.GetCompStateObject().StateWorldAssetData is LightHouseData)
		{
			return !Singleton<ProtagonistManager>.instance.IsProtagonist;
		}
		InteractEntry interactEntry = GetInteractEntry();
		if (interactEntry == null)
		{
			return false;
		}
		if (interactEntry.InteractType == InteractType.Button)
		{
			return interactEntry.ShowType != ShowType.Hide;
		}
		return true;
	}
}
