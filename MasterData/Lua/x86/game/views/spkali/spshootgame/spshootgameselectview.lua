local SpShootGameSelectView = class("SpShootGameSelectView", ReduxView)

function SpShootGameSelectView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_kailistartUI"
end

function SpShootGameSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function SpShootGameSelectView:OnCtor()
	return
end

function SpShootGameSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SpShootGameSelectView:InitUI()
	self:BindCfgUI()
end

function SpShootGameSelectView:OnEnter()
	if self.params_ then
		self.activity_id = self.params_.activityID or ActivityConst.ACTIVITY_3_6_KALI_SHOOTGAME
	end

	self.remainTime = ActivityData:GetActivityRefreshTime(self.params_.activityID)
	self.texttimeText_.text = string.format(GetTips("TIME_DISPLAY_9"), manager.time:GetLostTimeStrWith2Unit((self:GetNextrefreshTime())))

	self:UpdateTxt()

	self.updateTimer_ = Timer.New(function()
		self.texttimeText_.text = string.format(GetTips("TIME_DISPLAY_9"), manager.time:GetLostTimeStrWith2Unit((self:GetNextrefreshTime())))
	end, 1, -1, 1)

	self.updateTimer_:Start()
end

function SpShootGameSelectView:GetNextrefreshTime()
	return manager.time:GetZeroTime() + REFRESH_CLOCK
end

function SpShootGameSelectView:OnTop()
	self:RefreshBar()
end

function SpShootGameSelectView:UpdateTxt()
	local var_10_0 = SpShooGameData:GetActivityData(self.activity_id)

	self.textnum01Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward1NowAndMax(self.activity_id))
	self.textnum02Text_.text = SpKaliTool.GetNumDes(SpKaliTool.GetShootReward2NowAndMax(self.activity_id))
	self.icon3Img_.sprite = ItemTools.getItemSprite(SpKaliConst.ItemConst.coinID1)
	self.icon4Img_.sprite = ItemTools.getItemSprite(SpKaliConst.ItemConst.coinID2)
end

function SpShootGameSelectView:OnUpdateSkillInfo(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(self.skillIcon) do
		iter_11_1.fillAmount = arg_11_1[iter_11_0] or 1
	end
end

function SpShootGameSelectView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function SpShootGameSelectView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		SpKaliConst.ItemConst.coinID1,
		SpKaliConst.ItemConst.coinID2
	})
	manager.windowBar:SetBarCanClick(SpKaliConst.ItemConst.coinID1, true)
	manager.windowBar:SetBarCanClick(SpKaliConst.ItemConst.coinID2, true)
	manager.windowBar:RegistBackCallBack(function()
		LuaExchangeHelper.GoToMain()
		DestroyLua()
	end)
end

function SpShootGameSelectView:RegisterEvents()
	return
end

function SpShootGameSelectView:AddUIListener()
	self:AddBtnListener(self.btnstartBtn_, nil, function()
		SpShootGameBridge.StartGameUI()
	end)
end

function SpShootGameSelectView:Dispose()
	SpShootGameSelectView.super.Dispose(self)
end

return SpShootGameSelectView
