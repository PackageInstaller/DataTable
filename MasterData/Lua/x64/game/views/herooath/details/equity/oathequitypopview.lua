local OathEquityPopView = class("OathEquityPopView", ReduxView)

function OathEquityPopView:UIName()
	return "Widget/System/Hero_Oath/OathDetailsView/HeroOathEquityPopUI"
end

function OathEquityPopView:UIParent()
	return manager.ui.uiPop.transform
end

function OathEquityPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OathEquityPopView:InitUI()
	self:BindCfgUI()

	self.lvStateController_ = self.controller_:GetController("lvState")
	self.lockStateController_ = self.controller_:GetController("lock")

	self:InitStageList()

	self.equityList = LuaList.New(handler(self, self.IndexEquityItem), self.uiListGo_, OathEquityItem)
	self.lockText_.text = GetTips("WEDDING_RIGHT_UNLOCK_TIPS")
end

function OathEquityPopView:IndexEquityItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.equityDataList[arg_5_1])
end

function OathEquityPopView:RefreshEquityList()
	local var_6_0 = OathTools.GetOathEquityList(self.heroID, self.selectLevel, OathConst.OATH_EQUITY_SHOW_TYPE.ONLY_EQUITY_VIEW)

	self.equityDataList = var_6_0

	self.equityList:StartScroll(#var_6_0)

	if self.stageBtnList[self.selectLevel]:GetLock() then
		self.lockStateController_:SetSelectedState("on")
	else
		self.lockStateController_:SetSelectedState("off")
	end
end

function OathEquityPopView:InitStageList()
	self.stageBtnList = {}
	self.stageBeginIndex = 1

	for iter_7_0 = 0, self.stageContent_.childCount - 1 do
		local var_7_0 = iter_7_0 + self.stageBeginIndex
		local var_7_1 = OathEquityStageItem.New(self.stageContent_:GetChild(iter_7_0).gameObject, iter_7_0 + self.stageBeginIndex)

		var_7_1:SetClickCallback(function()
			self:OnClickStageItem(var_7_0)
		end)

		self.stageBtnList[iter_7_0 + self.stageBeginIndex] = var_7_1
	end
end

function OathEquityPopView:OnClickStageItem(arg_9_1)
	if self.selectLevel == arg_9_1 then
		return
	end

	if self.selectLevel then
		self.stageBtnList[self.selectLevel]:ChangeSelectState(false)
	end

	self.selectLevel = arg_9_1

	self.stageBtnList[self.selectLevel]:ChangeSelectState(true)
	self:RefreshEquityList()
	self:RefreshLvUI()
end

function OathEquityPopView:GetDefaultStageIndex()
	if self.selectLevel then
		return self.selectLevel
	end

	return 1
end

function OathEquityPopView:UpdateStageList()
	for iter_11_0, iter_11_1 in pairs(self.stageBtnList or {}) do
		iter_11_1:SetData(self.heroID)
	end

	self:OnClickStageItem((self:GetDefaultStageIndex()))
end

function OathEquityPopView:AddUIListener()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function OathEquityPopView:OnEnter()
	self.heroID = self.params_.heroID

	self:UpdateStageList()
end

function OathEquityPopView:RefreshLvUI()
	if self.selectLevel == OathConst.OATH_MAX_LV then
		self.lvStateController_:SetSelectedState("max")
	else
		self.lvStateController_:SetSelectedState("lvl")
	end

	self.lvText_.text = self.selectLevel
end

function OathEquityPopView:OnExit()
	if self.selectLevel then
		self.stageBtnList[self.selectLevel]:ChangeSelectState(false)
	end

	self.selectLevel = nil

	manager.windowBar:HideBar()
end

function OathEquityPopView:OnTop()
	manager.windowBar:SwitchBar({})
end

function OathEquityPopView:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.stageBtnList or {}) do
		iter_18_1:Dispose()
	end

	self.stageBtnList = nil

	self.equityList:Dispose()
	self.super.Dispose(self)
end

return OathEquityPopView
