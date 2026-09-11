local EquipSeizureRewardView = class("EquipSeizureRewardView", ReduxView)

function EquipSeizureRewardView:UIName()
	return "Widget/System/Equip_Seizure/EquipSeizuRerewardPopUI"
end

function EquipSeizureRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function EquipSeizureRewardView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = self.controlExCo_:GetController("state")
	self.itemList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, EquipSeizureRewardItem)
	self.updateHandler_ = handler(self, self.RefreshUI)
	self.receiveHandler_ = handler(self, self.RefreshUI)
end

function EquipSeizureRewardView:OnEnter()
	manager.notify:RegistListener(EQUIP_SEIZURE_UPDATE, self.updateHandler_)
	manager.notify:RegistListener(EQUIP_SEIZURE_REWARD, self.receiveHandler_)
	self:RefreshUI()
end

function EquipSeizureRewardView:OnExit()
	self:StopTimer()
	manager.notify:RemoveListener(EQUIP_SEIZURE_UPDATE, self.updateHandler_)
	manager.notify:RemoveListener(EQUIP_SEIZURE_REWARD, self.receiveHandler_)
end

function EquipSeizureRewardView:Dispose()
	EquipSeizureRewardView.super.Dispose(self)
	self.itemList_:Dispose()

	self.itemList_ = nil
	self.updateHandler_ = nil
	self.receiveHandler_ = nil
end

function EquipSeizureRewardView:AddListeners()
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		if #EquipSeizureData:GetCanReceiveList() <= 0 then
			return
		end

		self:ClickItem()
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function EquipSeizureRewardView:ClickItem()
	EquipSeizureAction.SendReceiveReward(EquipSeizureData:GetCanReceiveList(), function(arg_11_0)
		self:RefreshUI()
	end)
end

function EquipSeizureRewardView:RefreshUI()
	if #EquipSeizureData:GetCanReceiveList() > 0 then
		self.controller_:SetSelectedState("canget")
	else
		self.controller_:SetSelectedState("unfinish")
	end

	self.itemList_:StartScroll(#EquipSeizurePointRewardCfg.all)

	self.pointText_.text = EquipSeizureData:GetTotalScore()

	self:AddTimer()
end

function EquipSeizureRewardView:RefreshItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(EquipSeizureData:GetSortRewardList()[arg_13_1])
end

function EquipSeizureRewardView:AddTimer()
	self:StopTimer()

	self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	self.timer_ = Timer.New(function()
		self.timeText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr2(EquipSeizureData:NextRefreshTimestamp(), nil, true))
	end, 1, -1)

	self.timer_:Start()
end

function EquipSeizureRewardView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return EquipSeizureRewardView
