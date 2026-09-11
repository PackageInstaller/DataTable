local MoonPartyOpenView = class("MoonPartyOpenView", ReduxView)

function MoonPartyOpenView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyOpenUI"
end

function MoonPartyOpenView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonPartyOpenView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonPartyOpenView:InitUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.planController1_ = ControllerUtil.GetController(self.planTrans1_, "status")
	self.planController2_ = ControllerUtil.GetController(self.planTrans2_, "status")
end

function MoonPartyOpenView:AddUIListener()
	for iter_5_0 = 1, 2 do
		self:AddBtnListener(self[string.format("planBtn%d_", iter_5_0)], nil, function()
			if not ActivityData:GetActivityIsOpen(self.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			self:SelectPlan(iter_5_0)
		end)
	end

	self:AddBtnListener(self.confirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if self.selectPlan_ == 0 then
			return
		end

		ShowMessageBox({
			title = GetTips("COMFIRM"),
			content = GetTips("MID_AUTUMN_FESTIVAL_PARTY_BEGIN"),
			OkCallback = function()
				MoonCakeAction.OpenParty(self.activityID_, self.selectPlan_)
			end
		})
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function MoonPartyOpenView:OnEnter()
	self.activityID_ = self.params_.activityID

	local var_11_0, var_11_1, var_11_2 = MoonCakeTools.CheckPartyPlanValid(self.activityID_, MoonCakeConst.PARTY_TYPE.CAKE)

	self.planDescText1_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_1"), var_11_2)
	self.progressText1_.text = string.format(GetTips("%d/%d"), var_11_1, var_11_2)

	self.planController1_:SetSelectedState(var_11_0 and "on" or "off")

	local var_11_3, var_11_4, var_11_5 = MoonCakeTools.CheckPartyPlanValid(self.activityID_, MoonCakeConst.PARTY_TYPE.VISIT)

	self.planDescText2_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_2"), var_11_5)
	self.progressText2_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_CONSUME_PROGRESS"), var_11_4, var_11_5)

	self.planController2_:SetSelectedState(var_11_3 and "on" or "off")

	self.selectPlan_ = 0

	if var_11_0 then
		self.selectPlan_ = 1
	elseif var_11_3 then
		self.selectPlan_ = 2
	end

	self:SelectPlan(self.selectPlan_)
	self:BindRedPoint()
end

function MoonPartyOpenView:OnExit()
	self:UnBindRedPoint()
end

function MoonPartyOpenView:SelectPlan(arg_13_1)
	self.selectPlan_ = arg_13_1

	self.selectController_:SetSelectedIndex(arg_13_1)
end

function MoonPartyOpenView:OnPartyOpen()
	self:Back()
end

function MoonPartyOpenView:OnPartyReset()
	if not manager.messageBox:GetIsAllFree() then
		manager.messageBox:HideAll()
	end
end

function MoonPartyOpenView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.confirmBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, self.activityID_)))
end

function MoonPartyOpenView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.confirmBtn_.transform, (string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, self.activityID_)))
end

return MoonPartyOpenView
