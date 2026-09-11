local StrongholdBattleResultOrderItem = class("StrongholdBattleResultOrderItem", ReduxView)

function StrongholdBattleResultOrderItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdBattleResultOrderItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdBattleResultOrderItem:InitUI()
	self:BindCfgUI()

	self.typeController = ControllerUtil.GetController(self.gameObject_.transform, "type")
end

function StrongholdBattleResultOrderItem:AddUIListener()
	return
end

function StrongholdBattleResultOrderItem:SetData(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0

	if arg_5_1 == 1 then
		var_5_0 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_1

		self.typeController:SetSelectedIndex(0)
	elseif arg_5_1 == 2 then
		var_5_0 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_2

		self.typeController:SetSelectedIndex(1)
	else
		var_5_0 = CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_3

		self.typeController:SetSelectedIndex(2)
	end

	local var_5_1 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		if var_5_0 == iter_5_1[1] then
			var_5_1 = iter_5_1[2]
		end
	end

	local var_5_2, var_5_3, var_5_4, var_5_5 = StrongholdData:GetStrongholdLevel(arg_5_1)

	self.m_name.text = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. arg_5_1)
	self.m_lvLab.text = ActivityStrongholdLevelCfg[var_5_2].level_des

	if ActivityStrongholdLevelCfg[var_5_2 + 1] then
		self.m_expSlider.value = var_5_4 / (ActivityStrongholdLevelCfg[var_5_2 + 1].exp - ActivityStrongholdLevelCfg[var_5_2].exp)
		self.m_exoLab.text = "+" .. var_5_1
	else
		self.m_expSlider.value = 1
		self.m_exoLab.text = ""
	end

	self.m_ceilLab.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. StrongholdData:GetWeeklyExp(arg_5_3, arg_5_1) .. "/" .. StrongholdData:GetWeeklyMaxExp(arg_5_3, arg_5_1)
end

function StrongholdBattleResultOrderItem:Dispose()
	StrongholdBattleResultOrderItem.super.Dispose(self)
end

return StrongholdBattleResultOrderItem
