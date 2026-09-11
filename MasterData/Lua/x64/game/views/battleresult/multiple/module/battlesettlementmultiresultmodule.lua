local BattleSettlemenMultiResultModule = class("BattleSettlemenMultiResultModule", ReduxView)

function BattleSettlemenMultiResultModule:OnCtor(arg_1_1)
	self.gameObject_ = self:InstView(arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BattleSettlemenMultiResultModule:InstView(arg_2_1)
	return (Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleMultipleResultContent"), arg_2_1))
end

function BattleSettlemenMultiResultModule:BuildContext()
	return
end

function BattleSettlemenMultiResultModule:Init()
	self:BindCfgUI()
	self:BuildContext()

	self.scrollHelper = LuaList.New(handler(self, self.RenderItem), self.rewardsListObj_, BattleSettlementMultiResultItem)
	self.scrollRect = self.rewardsListObj_:GetComponent(typeof(ScrollRectEx))
	self.autoDecomposeController_ = self.controllerEx_:GetController("tips")
end

function BattleSettlemenMultiResultModule:OnEnter()
	return
end

function BattleSettlemenMultiResultModule:OnExit()
	return
end

function BattleSettlemenMultiResultModule:RenderView(arg_7_1)
	self.stageData = arg_7_1.stageData
	self.rewardList = arg_7_1.rewardList
	self.extraReward = arg_7_1.extraReward
	self.multiple = arg_7_1.rewardTimes

	local var_7_0 = self.stageData:GetType()
	local var_7_1 = false

	if var_7_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP then
		var_7_1 = EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.NORMAL)
	elseif var_7_0 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL and ActivityPtRouletteStageCfg[self.stageData:GetDest()].cost[1] ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
		var_7_1 = EquipData:GetAutoDecompose(BattleConst.BATTLE_EQUIP_TYPE.PT)
	end

	self.autoDecomposeController_:SetSelectedState(tostring(var_7_1))
	self.scrollHelper:StartScroll(self.multiple or 0)
end

function BattleSettlemenMultiResultModule:RenderItem(arg_8_1, arg_8_2)
	local var_8_0

	if self.extraReward and type(self.extraReward) == "table" then
		var_8_0 = self.extraReward[arg_8_1]
	end

	arg_8_2:TryInitScroll(self.scrollRect)
	arg_8_2:RenderView(arg_8_1, clone(self.rewardList[arg_8_1]), clone(var_8_0))
end

function BattleSettlemenMultiResultModule:Dispose()
	self.scrollHelper:Dispose()

	self.scrollRect = nil

	BattleSettlemenMultiResultModule.super.Dispose(self)
end

return BattleSettlemenMultiResultModule
