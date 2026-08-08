using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("奥义事件", 0)]
[Category("Common/事件")]
[Description("接收奥义事件;\n监听分类:0-全部,1-仅普通奥义,2-仅连携奥义;监听阶段:0-全部,1-开始,2-结束")]
public class DoUniqueSkillEvent : DoUniqueSkillEventBase
{
	private ValueInput<int> _listenCategoryInput;

	private ValueInput<int> _listenStepInput;

	private ValueInput<bool> _onlyCasterOfCooperateInput;

	protected override void AddCustomValueInput()
	{
		_listenCategoryInput = AddValueInput<int>("监听分类(看备注)", "listenCategory");
		_listenStepInput = AddValueInput<int>("监听阶段", "listenState");
		_onlyCasterOfCooperateInput = AddValueInput<bool>("连携仅走发起者", "onlyCasterOfCooperate");
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool IsCurrentCategory(UniqueSkillEvent pEvt)
	{
		if (_listenCategoryInput.value == 1 && pEvt.mIsCooperating)
		{
			return false;
		}
		if (_listenCategoryInput.value == 2 && !pEvt.mIsCooperating)
		{
			return false;
		}
		return true;
	}

	protected override bool IsCurrentStep(UniqueSkillEvent pEvt)
	{
		if (_listenStepInput.value != 0)
		{
			return _listenStepInput.value == pEvt.mStep;
		}
		return true;
	}

	protected override void EvtHandler(UniqueSkillEvent pEvt)
	{
		if (!IsCurrentCategory(pEvt) || !IsCurrentStep(pEvt))
		{
			return;
		}
		_event = pEvt;
		if (m_needDelay && _isRenderInput.value)
		{
			_delayTime = 1;
		}
		Flow f = CreateFlow();
		_out.Call(f);
		if (!_isCooperating || _onlyCasterOfCooperateInput.value)
		{
			return;
		}
		SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
		if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(simWorldState.m_CooperateUniqueSkillID, out var config))
		{
			return;
		}
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_casterID);
		if (!config.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
		{
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
				if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard && config.CooperateRoleIds.Contains(entityWithEntityID2.entityConfig.mId) && entityWithEntityID2.entityBlackboard.var.mHP > 0)
				{
					_casterID = mEntityID;
					_out.Call(f);
				}
			}
		}
	}
}
