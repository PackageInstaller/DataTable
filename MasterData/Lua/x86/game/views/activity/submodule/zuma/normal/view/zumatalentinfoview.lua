local ZumaTalentInfoView = class("ZumaTalentInfoView", ReduxView)
local var_0_1 = {
	showState = {
		name = "lock",
		canOpenNotConditon = "canOpenNotConditon",
		isUse = "isUse",
		canOpen = "canOpen",
		lock = "lock"
	}
}

function ZumaTalentInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function ZumaTalentInfoView:InitUI()
	self:BindCfgUI()

	self.showController = self.controllerexcollection_:GetController(var_0_1.showState.name)

	self:AddBtnListener(self.openBtn_, nil, function()
		self:OnClickUpTalentBtn()
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips("ACTIVITY_ZUMA_TALENT_LOCK")
	end)
end

function ZumaTalentInfoView:OnClickUpTalentBtn()
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	local var_5_0 = self.useTalentID

	if not ActivityZumaTalentCfg[self.useTalentID] then
		return
	end

	if ActivityZumaTalentCfg[self.useTalentID].need > ZumaData:GetZumaCoin() then
		ShowTips("ACTIVITY_ZUMA_TALENT_COST")

		return
	end

	ZumaAction.OpenZumaTalent(var_5_0)
end

function ZumaTalentInfoView:RefreshTalentInfoUi(arg_6_1)
	self.useTalentID = arg_6_1
	self.costnumText_.text = ActivityZumaTalentCfg[arg_6_1].need
	self.talentnameText_.text = ActivityZumaTalentCfg[arg_6_1].name
	self.talentDescText_.text = ActivityZumaTalentCfg[arg_6_1].desc

	local var_6_0 = ""
	local var_6_1 = false

	for iter_6_0, iter_6_1 in pairs(ActivityZumaTalentCfg[arg_6_1].pre_id_list) do
		if iter_6_1 ~= 0 then
			var_6_1 = true
			var_6_0 = string.format(GetTips("ACTIVITY_ZUMA_TALENT_UNLOCK_CONDITION"), ActivityZumaTalentCfg[iter_6_1].name)
		end
	end

	self.conditiondescireText_.text = var_6_0

	if ZumaData:GetZumaTalentIsOpen(arg_6_1) then
		self.showController:SetSelectedState(var_0_1.showState.isUse)
	elseif ZumaData:GetZumaTalentIsCanOpen(arg_6_1) then
		if var_6_1 then
			self.showController:SetSelectedState(var_0_1.showState.canOpenNotConditon)
		else
			self.showController:SetSelectedState(var_0_1.showState.canOpen)
		end
	else
		self.showController:SetSelectedState(var_0_1.showState.lock)
	end
end

return ZumaTalentInfoView
