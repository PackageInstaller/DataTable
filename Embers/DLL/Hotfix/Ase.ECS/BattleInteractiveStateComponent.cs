using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class BattleInteractiveStateComponent : BaseComponent
{
	private InteractiveStateChecker interactiveStateChecker;

	private AIParadoxComponent aiParadoxComponent;

	private bool canInteractive;

	private Vector3 centerOffset;

	private float checkRadius;

	private string triggerShape;

	private float shapeParam2;

	private float shapeParam3;

	private string iconType;

	private int interactiveStateId;

	private float interactiveTimeLength;

	private List<int> interactivingEntities = new List<int>();

	private List<int> interactivedEntities = new List<int>();

	private float time;

	private EntitySystem _entitySystem;

	public bool CanInteractive => canInteractive;

	public int InteractivintCount => interactivingEntities.Count;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_entitySystem = mBaseEntity.GetSystem<EntitySystem>();
	}

	public override void OnStart(object data)
	{
		base.OnStart(data);
		aiParadoxComponent = mBaseEntity.GetComponent<AIParadoxComponent>();
		checkRadius = GetData<float>(Constant.InteractiveConstant.INTERACTIVE_RADIUS_KEY);
		centerOffset = GetData<Vector3>(Constant.InteractiveConstant.INTERACTIVE_CENTEROFFSET_KEY);
		interactiveTimeLength = GetData<float>(Constant.InteractiveConstant.INTERACTIVE_TIMELENGTH_KEY);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"interactiveTimeLength：{interactiveTimeLength}", mBaseEntity);
		}
		iconType = GetData<string>(Constant.InteractiveConstant.INTERACTIVE_ICONTYPE_KEY);
		string data2 = GetData<string>(Constant.InteractiveConstant.INTERACTIVE_NAME);
		interactiveStateId = ((interactiveTimeLength != 0f) ? GetData<int>(Constant.InteractiveConstant.INTERACTIVE_STATEID_KEY) : 0);
		triggerShape = GetData<string>(Constant.InteractiveConstant.TRIGGERSHAPE);
		shapeParam2 = GetData<float>(Constant.InteractiveConstant.SHAPELENGTH);
		shapeParam3 = GetData<float>(Constant.InteractiveConstant.SHAPEHEIGHT);
		canInteractive = true;
		interactiveStateChecker = new InteractiveStateChecker(mBaseEntity.Id, interactiveTimeLength, interactiveStateId, iconType, data2, InteractiveStartCallback, InteractiveFinishCallback, InteractiveCloseCallback);
	}

	public override void OnDispose()
	{
		interactiveStateChecker.Release();
		interactiveStateChecker = null;
		_entitySystem = null;
		base.OnDispose();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		CheckEnter();
	}

	private void CheckEnter()
	{
		List<int> teamEntityId = mBaseEntity.GetSystem<EntitySystem>().GetTeamEntityId(0, isIncludeEntity: true);
		for (int i = 0; i < teamEntityId.Count; i++)
		{
			BaseEntity entity = _entitySystem.GetEntity(teamEntityId[i]);
			if (entity == null)
			{
				return;
			}
			HeroInteractiveComponent component = entity.GetComponent<HeroInteractiveComponent>();
			if (component == null)
			{
				return;
			}
			if (!canInteractive)
			{
				if (interactivingEntities.Contains(teamEntityId[i]))
				{
					interactivingEntities.Remove(teamEntityId[i]);
					component.RemoveInteractive(interactiveStateChecker);
				}
			}
			else
			{
				if (component.CheckInteractivingOther(interactiveStateChecker))
				{
					continue;
				}
				Vector3 vector = base.transform.position + base.transform.rotation * centerOffset;
				bool flag = false;
				if (!string.IsNullOrEmpty(triggerShape))
				{
					if (triggerShape.Equals("Circle"))
					{
						flag = (vector - entity.transform.position).sqrMagnitude < checkRadius * checkRadius;
					}
					else if (triggerShape.Equals("Box"))
					{
						flag = TSUtil.IsPointInsideBox(vector.x, vector.y, vector.z, shapeParam2, checkRadius, shapeParam3, entity.transform.position.x, entity.transform.position.y, entity.transform.position.z);
					}
				}
				if (interactivingEntities.Contains(teamEntityId[i]))
				{
					if (!flag)
					{
						interactivingEntities.Remove(teamEntityId[i]);
						component.RemoveInteractive(interactiveStateChecker);
					}
					continue;
				}
				StateComponent component2 = entity.GetComponent<StateComponent>();
				if (flag && component2 != null && component2.IsNormalState())
				{
					interactivingEntities.Add(teamEntityId[i]);
					entity.GetComponent<HeroInteractiveComponent>().ShowInterctiveIcon(interactiveStateChecker);
				}
			}
		}
		CollectionPool<List<int>, int>.Release(teamEntityId);
	}

	public void InteractiveStartCallback(int entityId)
	{
	}

	public void InteractiveFinishCallback(int entityId)
	{
		if (!interactivedEntities.Contains(entityId))
		{
			interactivedEntities.Add(entityId);
			aiParadoxComponent.SetVariableValues("interactivedEntities", interactivedEntities);
		}
	}

	public void InteractiveCloseCallback(int value)
	{
		if (interactivingEntities.Contains(value))
		{
			interactivingEntities.Remove(value);
		}
	}

	public void FinishInteractive(int value)
	{
		if (interactivedEntities.Contains(value))
		{
			interactivedEntities.Remove(value);
		}
		if (interactivingEntities.Contains(value))
		{
			interactivingEntities.Remove(value);
		}
	}

	public void ChangeInteractiveSwitch(bool value)
	{
		canInteractive = value;
	}
}
