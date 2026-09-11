local BattleSettlementBlackRegionModule = class("BattleSettlementBlackRegionModule", ReduxView)

function BattleSettlementBlackRegionModule:OnCtor(arg_1_1)
	self.gameObject_ = self:InstView(arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BattleSettlementBlackRegionModule:InstView(arg_2_1)
	return (Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleBlackRegionContent"), arg_2_1))
end

function BattleSettlementBlackRegionModule:BuildContext()
	return
end

function BattleSettlementBlackRegionModule:Init()
	self:BindCfgUI()
	self:BuildContext()
end

function BattleSettlementBlackRegionModule:OnEnter()
	return
end

function BattleSettlementBlackRegionModule:OnExit()
	return
end

function BattleSettlementBlackRegionModule:RenderView(arg_7_1)
	self.stageData = arg_7_1.stageData
	self.teamindextext_.text = string.format((self.stageData:GetDest() == 0 and 1 or self.stageData:GetDest()) .. "/" .. #MythicData:GetCurLevelIdList())

	self:RenderBattleTime()
	self:RenderPoint()
end

function BattleSettlementBlackRegionModule:RenderBattleTime()
	local var_8_0 = GetTips("DAY")
	local var_8_1 = GetTips("HOUR")
	local var_8_2 = GetTips("TIP_MINUTE")
	local var_8_3 = GetTips("SECOND")
	local var_8_4 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
	local var_8_5 = math.floor(var_8_4 / 86400)
	local var_8_6 = math.fmod(math.floor(var_8_4 / 3600), 24)
	local var_8_7 = math.floor(math.fmod(math.floor(var_8_4 / 60), 60))

	self.sec1Txt_.text = var_8_3
	self.wasteSecondTxt_.text = math.floor(math.fmod(var_8_4, 60))

	if var_8_7 > 0 then
		self.min1Txt_.text = var_8_2
		self.wasteMinuteTxt_.text = var_8_7
	else
		self.min1Txt_.text = ""
		self.wasteMinuteTxt_.text = ""
	end

	local var_8_8 = MythicData:GetBattlingTime()
	local var_8_9 = math.floor(var_8_8 / 86400)
	local var_8_10 = math.fmod(math.floor(var_8_8 / 3600), 24)
	local var_8_11 = math.floor(math.fmod(math.floor(var_8_8 / 60), 60))

	self.sec2Txt_.text = var_8_3
	self.reminSecondTxt_.text = math.floor(math.fmod(var_8_8, 60))

	if var_8_11 > 0 then
		self.min2Txt_.text = var_8_2
		self.reminMinuteTxt_.text = var_8_11
	else
		self.min2Txt_.text = ""
		self.reminMinuteTxt_.text = ""
	end
end

function BattleSettlementBlackRegionModule:RenderPoint()
	if #MythicData:GetCurLevelIdList() > 1 and self.stageData:GetDest() < #MythicData:GetCurLevelIdList() then
		SetActive(self.scoreObj_, false)
	else
		if not MythicData:GetIsNew() then
			RankAction.QueryOwnCommonRank(RankConst.RANK_ID.MATRIX)
			MythicAction.UpdateMythicFinalRedPoint()
		end

		SetActive(self.scoreObj_, true)

		self.scoreTxt_.text = MythicData:GetCurPoint()
	end
end

function BattleSettlementBlackRegionModule:Dispose()
	BattleSettlementBlackRegionModule.super.Dispose(self)
end

return BattleSettlementBlackRegionModule
