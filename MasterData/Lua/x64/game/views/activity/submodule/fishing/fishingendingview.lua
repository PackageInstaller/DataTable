local FishEndingView = class("FishEndingView", ReduxView)

function FishEndingView:UIName()
	return "UI/Fishing/FishingEndingUI"
end

function FishEndingView:UIParent()
	return manager.ui.uiMain.transform
end

function FishEndingView:OnCtor()
	return
end

function FishEndingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishEndingView:InitUI()
	self:BindCfgUI()

	self.emptyStatusController_ = ControllerUtil.GetController(self.gameObject_.transform, "emptyStatus")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, FishIcon)
end

function FishEndingView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetId(self.fishes_[arg_6_1].id)
	manager.audio:PlayEffect("minigame_fishing", "fishing_win_bubble", "")
end

function FishEndingView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		JumpTools.Back()

		if self.params_.callback ~= nil then
			self.params_.callback()
		end
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.Back()

		if self.params_.callback ~= nil then
			self.params_.callback()
		end
	end)
end

function FishEndingView:AddEventListeners()
	return
end

function FishEndingView:OnTop()
	self:UpdateBar()
end

function FishEndingView:UpdateBar()
	return
end

function FishEndingView:OnEnter()
	self:AddEventListeners()

	self.score_ = self.params_.score
	self.fishes_ = self.params_.fishes
	self.gainScore_ = self.params_.gainScore

	self:UpdateView()
end

function FishEndingView:OnExit()
	self:RemoveAllEventListener()
end

function FishEndingView:UpdateView()
	self.uiList_:StartScroll(#self.fishes_)

	self.scoreValueLabel_.text = self.score_
	self.coinValueLabel_.text = tostring(FishingData:GetActivityData().today_total_score) .. "/" .. GameSetting.activity_fishing_money_max.value[1]

	local var_15_0 = FishingData:GetActivityData().today_treasure_num

	self.fishValueLabel_.text = tostring(var_15_0) .. "/" .. GameSetting.activity_fishing_fish_max.value[1]

	if var_15_0 >= GameSetting.activity_fishing_fish_max.value[1] then
		self.emptyStatusController_:SetSelectedState("full")
	else
		self.emptyStatusController_:SetSelectedState("no")
	end
end

function FishEndingView:OnMainHomeViewTop()
	return
end

function FishEndingView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishEndingView.super.Dispose(self)
end

return FishEndingView
