using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("连携奥义开始事件(连携ID&实体类型ID)", 0)]
[Category("Common/事件")]
[Description("接收连携奥义开始事件")]
public class DoCooperateUniqueSkillBeginEvent2 : DoUniqueSkillEventBase
{
	private ValueInput<int> _cooperateIDInput;

	private ValueInput<int> _roleIDInput;

	protected override void AddCustomValueInput()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		_cooperateIDInput = AddValueInput<int>("连携奥义ID", "cooperateIDInput");
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool IsCurrentCategory(UniqueSkillEvent pEvt)
	{
		return pEvt.mIsCooperating;
	}

	protected override bool IsCurrentStep(UniqueSkillEvent pEvt)
	{
		return pEvt.mStep == 1;
	}

	protected override void EvtHandler(UniqueSkillEvent pEvt)
	{
		if (!IsCurrentCategory(pEvt) || !IsCurrentStep(pEvt))
		{
			return;
		}
		SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
		if (simWorldState.m_CooperateUniqueSkillID != _cooperateIDInput.value || !ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(simWorldState.m_CooperateUniqueSkillID, out var config))
		{
			return;
		}
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(pEvt.mCasterID);
		if (!config.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
		{
			return;
		}
		_event = pEvt;
		if (m_needDelay && _isRenderInput.value)
		{
			_delayTime = 1;
		}
		Flow f = CreateFlow();
		if (entityWithEntityID.entityConfig.mId == _roleIDInput.value)
		{
			_out.Call(f);
			return;
		}
		int casterID = _casterID;
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = simWorldState.mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int mEntityID = enumerator.Current.Value.mEntityID;
			if (mEntityID != casterID)
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard && config.CooperateRoleIds.Contains(entityWithEntityID2.entityConfig.mId) && entityWithEntityID2.entityBlackboard.var.mHP > 0 && entityWithEntityID2.entityConfig.mId == _roleIDInput.value)
				{
					_casterID = mEntityID;
					_out.Call(f);
					break;
				}
			}
		}
	}
}
