local HellaHeroGiftView = class("HellaHeroGiftView", ReduxView)

function HellaHeroGiftView:UIName()
	return "UI/VersionUI/HellaUI/HellaHeroGiftUI"
end

function HellaHeroGiftView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaHeroGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaHeroGiftView:InitUI()
	self:BindCfgUI()

	self.receivedController = ControllerUtil.GetController(self.transform_, "recevied")
	self.item = CommonItem.New(self.m_item)
	self.item2 = CommonItem.New(self.m_item2)
end

function HellaHeroGiftView:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if ActivityData:GetActivityIsOpen(self.activity_id) then
			HeroGiftAction.QueryReceiveHeroGift(self.activity_id)
		else
			ShowTips("TIME_OVER")
		end
	end)
end

function HellaHeroGiftView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HellaHeroGiftView:OnEnter()
	self.activity_id = ActivityConst.HELLA_HERO_GIFT

	self:Refresh()

	if ActivityData:GetActivityIsOpen(self.activity_id) then
		self.timer = Timer.New(function()
			self:OnTimerEvent()
		end, 1, -1)

		self.timer:Start()
	end

	self:OnTimerEvent()
end

function HellaHeroGiftView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function HellaHeroGiftView:OnTimerEvent()
	local var_11_0 = ActivityData:GetActivityData(self.activity_id)

	self.m_timeLab.text = var_11_0 and var_11_0:IsActivitying() and manager.time:GetLostTimeStr(var_11_0.stopTime) or GetTips("TIME_OVER")
end

function HellaHeroGiftView:Refresh()
	if HeroGiftData:GetReceiveHeroGift(self.activity_id) == 0 then
		self.receivedController:SetSelectedIndex(0)
	else
		self.receivedController:SetSelectedIndex(1)
	end

	local var_12_0 = ActivityHeroGiftCfg[self.activity_id]

	if ActivityHeroGiftCfg[self.activity_id] then
		self:RefreshItem(var_12_0.reward[1], self.item)
		self:RefreshItem(var_12_0.reward[2], self.item2)
	end
end

function HellaHeroGiftView:RefreshItem(arg_13_1, arg_13_2)
	if arg_13_1 then
		arg_13_2:RefreshData(formatReward(arg_13_1))
		arg_13_2:RegistCallBack(function()
			ShowPopItem(POP_ITEM, arg_13_1)
		end)
		arg_13_2:Show(true)
	else
		arg_13_2:Show(false)
	end
end

function HellaHeroGiftView:Dispose()
	HellaHeroGiftView.super.Dispose(self)

	if self.item then
		self.item:Dispose()

		self.item = nil
	end

	if self.item2 then
		self.item2:Dispose()

		self.item2 = nil
	end
end

function HellaHeroGiftView:OnHeroGiftReward()
	self:Refresh()
end

return HellaHeroGiftView
