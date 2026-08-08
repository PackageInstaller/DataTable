using System.Collections.Generic;
using Config;
using Entitas;
using UnityEngine;

internal class PredictionAbilitiesSystem : ISystem, IInitializeSystem, IExecuteSystem
{
	private SimContext mSimContext;

	private IGroup<SimEntity> mEntityLocalWithAbility;

	private IGroup<SimEntity> mEnityLocalWithInput;

	private IGroup<SimEntity> mEntityWithHitRecover;

	private IGroup<SimEntity> mEnityLocalMovementGroup;

	private IGroup<SimEntity> mEnityLocalAbilityLogicInputGroup;

	private List<SimEntity> mEntityBuffer = new List<SimEntity>();

	public PredictionAbilitiesSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Execute()
	{
		Process_LogicInput();
		Process_Input();
		Process_MoveInput();
		Process_Abilities();
		Process_HitRecover();
		Process_MoveDirection();
		Process_LateInput();
	}

	private void Process_MoveDirection()
	{
		mSimContext.GetGroup(SimMatcher.PredictionMovement).DoAction(delegate(SimEntity entity)
		{
			MovementProcessor.MoveDirection(entity);
		});
	}

	private void Process_LateInput()
	{
		mEnityLocalWithInput.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			if (simEntity.entityActionManualInput.mCanDestroy)
			{
				simEntity.RemoveEntityActionManualInput();
			}
		});
	}

	private void Process_LogicInput()
	{
		mEnityLocalAbilityLogicInputGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			int mBrokenAbilityID = simEntity.entityActionAbilityLogicInput.mBrokenAbilityID;
			bool mForceBroken = simEntity.entityActionAbilityLogicInput.mForceBroken;
			AbilitiesProcessor.CheckAndAddAbilityOfSelf(simEntity, mBrokenAbilityID, mForceBroken);
			simEntity.RemoveEntityActionAbilityLogicInput();
		});
	}

	private void Process_Input()
	{
		mEnityLocalWithInput.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mLogicInputEvent != null)
			{
				simContext.GetSimInterface().mLogicInputEvent(simEntity.creationIndex, simEntity.entityActionManualInput.mInputKey);
			}
			if (simEntity.entityActionManualInput.mStatus == EntityActionStatus.E_ACTIVE)
			{
				int mInputKey = simEntity.entityActionManualInput.mInputKey;
				int abilityID = 0;
				if (simEntity.hasEntityActionAbility)
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityActionAbility.mAbilityID);
					if (config == null)
					{
						Debug.LogError((object)("无法找到 == " + simEntity.entityActionAbility.mAbilityID));
					}
					int mLogicTime = simEntity.entityActionAbility.mLogicTime;
					bool flag = config.InputActionTimelineNode.Enable && mLogicTime >= config.InputActionTimelineNode.Start;
					simEntity.entityActionManualInput.mCanDestroy = !flag;
					MovementProcessor.Stop(simEntity);
					if (mLogicTime > config.ComboOverTime)
					{
						simEntity.entityBlackboard.var.meleeIndex = 0;
					}
				}
				else
				{
					simEntity.entityActionManualInput.mCanDestroy = true;
				}
				if (AbilitiesProcessor.TryAddAbilityByInput(simEntity, mInputKey, out abilityID))
				{
					RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
					if (5 != mInputKey)
					{
						simEntity.entityBlackboard.var.meleeIndex = 0;
					}
					else
					{
						int count = simEntity.entityBlackboard.var.mMeleesSlots.Count;
						int meleeIndex = (simEntity.entityBlackboard.var.meleeIndex + 1) % count;
						simEntity.entityBlackboard.var.meleeIndex = meleeIndex;
					}
					for (int i = 0; i < roleConfig.AvoidAbility.Count; i++)
					{
						if (roleConfig.AvoidAbility.get_Item(i) == abilityID)
						{
							if (simEntity.hasEntityActionMoveDirection)
							{
								if (simEntity.entityActionMoveDirection.mDirection.sqrMagnitudeLong > 1)
								{
									simEntity.entityPositon.mForward = simEntity.entityActionMoveDirection.mDirection;
								}
								simEntity.entityPositon.mForwardAngle = IntMath.AngleOfVector(simEntity.entityPositon.mForward);
								simEntity.RemoveEntityActionMoveDirection();
							}
							break;
						}
					}
					if (simEntity.hasEntityActionMoveDirection)
					{
						MovementProcessor.SetForwardImmediately(simEntity, simEntity.entityActionMoveDirection.mDirection);
					}
					simEntity.entityActionManualInput.mCanDestroy = true;
				}
				if (mInputKey == 5 && abilityID != 0 && !AttributeProcessor.IsEnableAbility(simEntity, abilityID))
				{
					simEntity.entityBlackboard.var.meleeIndex = 0;
				}
			}
		});
	}

	private void Process_MoveInput()
	{
		mEnityLocalMovementGroup.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			if ((simEntity.hasEntityActionAbility || simEntity.hasEntityHitRecover) && AbilitiesProcessor.InterruptCheck(simEntity.creationIndex, simEntity, 0, simEntity.entityBlackboard.var.mRunSlot, 0))
			{
				MovementProcessor.EnableMovement(simEntity, isActive: true);
				if (simEntity.hasEntityActionAbility)
				{
					simEntity.entityBlackboard.var.meleeIndex = 0;
					simEntity.entityBlackboard.var.mActionBusy = false;
					simEntity.RemoveEntityActionAbility();
				}
				if (simEntity.hasEntityHitRecover)
				{
					simEntity.RemoveEntityHitRecover();
				}
			}
		});
	}

	private void Process_HitRecover()
	{
		mEntityWithHitRecover.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			if (simEntity.hasEntityHitRecover)
			{
				AbilitiesProcessor.ProcessHitRecover(simEntity);
			}
		});
	}

	public void Initialize()
	{
		mEntityLocalWithAbility = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityLocalPlayer, SimMatcher.EntityActionAbility));
		mEnityLocalWithInput = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityLocalPlayer, SimMatcher.EntityActionManualInput));
		mEnityLocalMovementGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityLocalPlayer, SimMatcher.EntityActionMoveDirection));
		mEnityLocalAbilityLogicInputGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityLocalPlayer, SimMatcher.EntityActionAbilityLogicInput));
		mEntityWithHitRecover = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityLocalPlayer, SimMatcher.EntityHitRecover));
	}

	private void Process_Abilities()
	{
		mEntityLocalWithAbility.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity)
		{
			AbilitiesProcessor.ProcessAbility(simEntity);
		});
	}
}
