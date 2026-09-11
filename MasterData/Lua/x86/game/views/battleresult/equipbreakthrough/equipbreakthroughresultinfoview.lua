local EquipBreakThroughResultInfoView = class("EquipBreakThroughResultInfoView", ReduxView)

function EquipBreakThroughResultInfoView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
end

function EquipBreakThroughResultInfoView:SetData(arg_2_1)
	self.stageData_ = arg_2_1

	self:RefreshUI()
end

function EquipBreakThroughResultInfoView:OnExit()
	return
end

function EquipBreakThroughResultInfoView:Dispose()
	EquipBreakThroughResultInfoView.super.Dispose(self)
end

function EquipBreakThroughResultInfoView:RefreshUI()
	self.timeText_.text = manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	self.titleText_.text = BattleEquipBreakThroughMaterialStageCfg[self.stageData_:GetStageId()].name

	local var_5_0 = EquipBreakThroughMaterialMapCfg[self.stageData_:GetServerExtant()]

	self.pointText_.text = EquipBreakThroughMaterialPointCfg[var_5_0.stage_type].stage_point[var_5_0.col]

	local var_5_1 = BattleFieldData:GetBattleResultData().buffID

	if var_5_1 == 0 then
		self.buffText_.text = ""
	else
		local var_5_2 = EquipBreakThroughMaterialData:GetAttributeList()[var_5_1] or 1
		local var_5_3
		local var_5_4

		if var_5_2 == 1 then
			var_5_3 = 0
			var_5_4 = getAttributeAffixValue(var_5_1, 1)
		else
			var_5_3 = getAttributeAffixValue(var_5_1, var_5_2 - 1)
			var_5_4 = getAttributeAffixValue(var_5_1, var_5_2)
		end

		self.buffText_.text = string.format(GetI18NText(EquipBreakThroughMaterialItemCfg[var_5_1].desc), (var_5_4 - var_5_3) / 10)
	end
end

return EquipBreakThroughResultInfoView
