using System;
using UnityEngine;

namespace Ase.ECS;

public class InteractiveStateComponent : BaseComponent
{
	private AIParadoxComponent aiParadoxComponent;

	private InteractiveStateChecker interactiveStateChecker;

	private Vector3 centerOffset;

	private float checkRadius;

	private string triggerShape;

	private float shapeParam2;

	private float shapeParam3;

	private DialogChainComponent dialogChainComponent;

	private string iconType;

	private int interactiveStateId;

	private float interactiveTimeLength;

	private MapItemState itemState;

	private EventHandler<DialogueViewModel> OnEnterInteractiveCallback;

	private EventHandler OnFinishedInteractiveCallback;

	private EventHandler<MapItemEventType> OnSendInteractiveEventCallback;

	private float coolTime = 0.5f;

	public bool IsCanInteractive
	{
		get
		{
			if (itemState != MapItemState.Idle && itemState != MapItemState.Enter && itemState != MapItemState.WaitInteractive)
			{
				return itemState == MapItemState.Exit;
			}
			return true;
		}
	}

	public bool IsInteractiving
	{
		get
		{
			if (itemState != MapItemState.DoInteractive && itemState != MapItemState.Interactive && itemState != MapItemState.Interactiving)
			{
				return itemState == MapItemState.Finish;
			}
			return true;
		}
	}

	public override void OnStart(object data)
	{
		base.OnStart(data);
		aiParadoxComponent = mBaseEntity.GetComponent<AIParadoxComponent>();
		dialogChainComponent = mBaseEntity.GetComponent<DialogChainComponent>();
		itemState = MapItemState.Idle;
		checkRadius = GetData<float>(Constant.InteractiveConstant.INTERACTIVE_RADIUS_KEY);
		centerOffset = GetData<Vector3>(Constant.InteractiveConstant.INTERACTIVE_CENTEROFFSET_KEY);
		interactiveTimeLength = GetData<float>(Constant.InteractiveConstant.INTERACTIVE_TIMELENGTH_KEY);
		iconType = GetData<string>(Constant.InteractiveConstant.INTERACTIVE_ICONTYPE_KEY);
		string data2 = GetData<string>(Constant.InteractiveConstant.INTERACTIVE_NAME);
		interactiveStateId = ((interactiveTimeLength != 0f) ? GetData<int>(Constant.InteractiveConstant.INTERACTIVE_STATEID_KEY) : 0);
		triggerShape = GetData<string>(Constant.InteractiveConstant.TRIGGERSHAPE);
		shapeParam2 = GetData<float>(Constant.InteractiveConstant.SHAPELENGTH);
		shapeParam3 = GetData<float>(Constant.InteractiveConstant.SHAPEHEIGHT);
		interactiveStateChecker = new InteractiveStateChecker(mBaseEntity.Id, interactiveTimeLength, interactiveStateId, iconType, data2, InteractiveStartCallback, InteractiveFinishCallback, InteractiveCloseCallback);
	}

	public void InteractiveStartCallback(int entityId)
	{
		ChangeInteractiveState(MapItemState.DoInteractive);
	}

	public void InteractiveFinishCallback(int entityId)
	{
		ChangeInteractiveState(MapItemState.Interactiving);
	}

	public void InteractiveCloseCallback(int value)
	{
		if (itemState != MapItemState.Finish && itemState != MapItemState.Interactiving)
		{
			ChangeInteractiveState(MapItemState.Exit);
		}
	}

	private bool CheckEnter()
	{
		BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(mBaseEntity.GetWorld().ActorId);
		Vector3 vector = mBaseEntity.GetCenterPosition() + centerOffset;
		entity?.GetComponent<StateComponent>();
		bool result = false;
		if (!string.IsNullOrEmpty(triggerShape))
		{
			if (triggerShape.Equals("Circle"))
			{
				result = (vector - entity.transform.position).sqrMagnitude < checkRadius * checkRadius;
			}
			else if (triggerShape.Equals("Box"))
			{
				result = TSUtil.IsPointInsideBox(vector, new Vector3(shapeParam2, shapeParam3, checkRadius), entity.transform.position, base.transform.eulerAngles.y);
			}
		}
		return result;
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (!base.Entity.IsSurvival)
		{
			return;
		}
		BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(mBaseEntity.GetWorld().ActorId);
		if (entity == null)
		{
			return;
		}
		HeroInteractiveComponent component = entity.GetComponent<HeroInteractiveComponent>();
		if (component == null)
		{
			return;
		}
		if (!component.CheckCanInteractiving())
		{
			if (coolTime > 0f)
			{
				coolTime -= deltaTime;
				return;
			}
			coolTime = 0.5f;
		}
		if (itemState == MapItemState.Idle && CheckEnter() && component.CheckCanInteractiving())
		{
			ChangeInteractiveState(MapItemState.Enter);
		}
		if (itemState == MapItemState.Enter)
		{
			if (!CheckEnter() && component.ContanisInteractiveChecker(interactiveStateChecker))
			{
				component.RemoveInteractive(interactiveStateChecker);
			}
			else if (!CheckEnter() && !component.ContanisInteractiveChecker(interactiveStateChecker))
			{
				ChangeInteractiveState(MapItemState.Exit);
			}
		}
		if (itemState == MapItemState.WaitInteractive && !CheckEnter())
		{
			component.RemoveInteractive(interactiveStateChecker);
		}
		if (itemState == MapItemState.Interactiving && (!CheckEnter() || component.CheckInteractivingOther(interactiveStateChecker)))
		{
			component.RemoveInteractive(interactiveStateChecker);
		}
	}

	private void OnInteractiveStateChanged()
	{
		BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(mBaseEntity.GetWorld().ActorId);
		if (entity == null)
		{
			return;
		}
		HeroInteractiveComponent component = entity.GetComponent<HeroInteractiveComponent>();
		if (itemState == MapItemState.Enter)
		{
			SetVariableValues(Constant.InteractiveConstant.MapItemTriggerId, mBaseEntity.GetWorld().ActorId);
		}
		else if (itemState == MapItemState.WaitInteractive)
		{
			if (component != null && !component.ContanisInteractiveChecker(interactiveStateChecker))
			{
				component.ShowInterctiveIcon(interactiveStateChecker);
			}
			else
			{
				ChangeInteractiveState(MapItemState.Exit);
			}
		}
		else if (itemState == MapItemState.Interactiving)
		{
			OnEnterInteractiveState();
		}
		else if (itemState == MapItemState.Finish)
		{
			OnFinishedInteractive();
		}
		else if (itemState == MapItemState.Dead)
		{
			SetVariableValues(Constant.InteractiveConstant.MapItemTriggerId, 0);
			if (component != null && component.ContanisInteractiveChecker(interactiveStateChecker))
			{
				component.RemoveInteractiveStateChecker(interactiveStateChecker, isFinishInter: false);
				OnExitorDead();
			}
		}
		else if (itemState == MapItemState.Exit)
		{
			SetVariableValues(Constant.InteractiveConstant.MapItemTriggerId, 0);
			if (component != null && component.ContanisInteractiveChecker(interactiveStateChecker))
			{
				component.RemoveInteractiveStateChecker(interactiveStateChecker, isFinishInter: false);
				OnExitorDead();
			}
		}
	}

	private void OnExitorDead()
	{
		if (dialogChainComponent != null)
		{
			dialogChainComponent.CloseDialogUI();
		}
	}

	public void ReigisterCallback(EventHandler<DialogueViewModel> OnEnterInteractiveCallback, EventHandler OnFinishedInteractiveCallback, EventHandler<MapItemEventType> OnSendInteractiveEventCallback)
	{
		this.OnEnterInteractiveCallback = OnEnterInteractiveCallback;
		this.OnFinishedInteractiveCallback = OnFinishedInteractiveCallback;
		this.OnSendInteractiveEventCallback = OnSendInteractiveEventCallback;
	}

	public void SendInteractiveEvent(MapItemEventType eventType)
	{
		if (OnSendInteractiveEventCallback != null)
		{
			OnSendInteractiveEventCallback(this, eventType);
		}
	}

	private void OnFinishedInteractive()
	{
		if (OnFinishedInteractiveCallback != null)
		{
			OnFinishedInteractiveCallback(this, null);
		}
	}

	private void OnEnterInteractiveState()
	{
		if (dialogChainComponent != null)
		{
			if (dialogChainComponent.NeedOpenUI())
			{
				DialogueViewModel e = dialogChainComponent.OpenDialogUI();
				OnEnterInteractiveCallback(this, e);
			}
			else
			{
				ChangeInteractiveState(MapItemState.Finish);
			}
		}
		else
		{
			ChangeInteractiveState(MapItemState.Finish);
		}
	}

	public MapItemState GetState()
	{
		return itemState;
	}

	public Vector3 GetCenterOffset()
	{
		return centerOffset;
	}

	public float GetCheckRadius()
	{
		return checkRadius;
	}

	public void ChangeInteractiveState(MapItemState targetState)
	{
		itemState = targetState;
		SetVariableValues(Constant.InteractiveConstant.ItemStateKey, targetState);
		OnInteractiveStateChanged();
	}

	private void SetVariableValues<T>(string paramKey, T paramValue)
	{
		if (aiParadoxComponent != null)
		{
			aiParadoxComponent.SetVariableValues(paramKey, paramValue);
		}
	}

	public override void OnEntityRelease()
	{
		ChangeInteractiveState(MapItemState.Exit);
		base.OnEntityRelease();
	}

	public override void OnDispose()
	{
		ChangeInteractiveState(MapItemState.Exit);
		interactiveStateChecker.Release();
		interactiveStateChecker = null;
		base.OnDispose();
	}
}
