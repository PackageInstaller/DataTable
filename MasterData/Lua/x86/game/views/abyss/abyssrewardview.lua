local AbyssRewardView = class("AbyssRewardView", ReduxView)

function AbyssRewardView:UIName()
	return "Widget/System/Challenge_Abyss/AbyssRewardUI"
end

function AbyssRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function AbyssRewardView:OnCtor()
	return
end

function AbyssRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssRewardView:InitUI()
	self:BindCfgUI()

	self.ispassController_ = ControllerUtil.GetController(self.gameObject_.transform, "ispass")
	self.empty1Controller_ = ControllerUtil.GetController(self.gameObject_.transform, "empty1")
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.list_, AbyssRewardItemView)
end

function AbyssRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, AbyssCfg[self.idList_[arg_6_1]].level)
end

function AbyssRewardView:OnAbyssRefresh()
	JumpTools.OpenPageByJump("/abyssMain", {
		refresh = true
	})
end

function AbyssRewardView:AddUIListener()
	self:AddBtnListener(self.receiveallBtn_, nil, function()
		local var_9_0 = AbyssData:GetCanGetLayers()

		if #var_9_0 > 0 then
			AbyssAction.GetLayerBonus(var_9_0)
		end
	end)
end

function AbyssRewardView:AddEventListeners()
	self:RegistEventListener(ABYSS_LAYER_BONUS_GET, function(arg_11_0)
		self:UpdateView()
	end)
end

function AbyssRewardView:OnTop()
	self:UpdateBar()
end

function AbyssRewardView:OnBehind()
	manager.windowBar:HideBar()
end

function AbyssRewardView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AbyssRewardView:OnEnter()
	self:AddEventListeners()
	self:UpdateView()
	self:StartTimer()
	self:OnTimer()
end

function AbyssRewardView:OnExit()
	self:RemoveAllEventListener()
	self:StopTimer()
	manager.windowBar:HideBar()
end

function AbyssRewardView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:OnTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function AbyssRewardView:OnTimer()
	self.timeLabel_.text = manager.time:GetLostTimeStr(AbyssData:GetRefreshTimestamp(), nil, true)
end

function AbyssRewardView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AbyssRewardView:UpdateView()
	self:UpdateList()

	self.passLabel_.text = GetI18NText(AbyssData:GetMaxLayer())

	if #AbyssData:GetCanGetLayers() > 0 then
		self.ispassController_:SetSelectedState("true")
	else
		self.ispassController_:SetSelectedState("noreward")
	end
end

function AbyssRewardView:UpdateList()
	self.idList_ = {}

	table.insertto(self.idList_, AbyssData:GetCurrentIdList(), 1)
	table.sort(self.idList_, function(arg_23_0, arg_23_1)
		local var_23_0 = self:GetBonusStatus(arg_23_0)
		local var_23_1 = self:GetBonusStatus(arg_23_1)

		if var_23_0 ~= var_23_1 then
			return var_23_0 < var_23_1
		end

		return arg_23_0 < arg_23_1
	end)

	if AbyssData:GetMaxLayer() > 0 then
		self.empty1Controller_:SetSelectedState("normal")
	else
		self.empty1Controller_:SetSelectedState("empty")
	end

	self.uiList_:StartScroll(#self.idList_)
end

function AbyssRewardView:GetBonusStatus(arg_24_1)
	if AbyssData:IsLayerBonusGet(AbyssCfg[arg_24_1].level) then
		return 3
	elseif AbyssCfg[arg_24_1].level <= AbyssData:GetMaxLayer() then
		return 1
	else
		return 2
	end
end

function AbyssRewardView:OnMainHomeViewTop()
	return
end

function AbyssRewardView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	self:StopTimer()
	AbyssRewardView.super.Dispose(self)
end

return AbyssRewardView
