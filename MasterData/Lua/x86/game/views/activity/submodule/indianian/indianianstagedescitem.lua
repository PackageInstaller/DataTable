local IndiaNianStageDescItem = class("IndiaNianStageDescItem", ReduxView)

function IndiaNianStageDescItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "selected")
end

function IndiaNianStageDescItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if not IndiaNianData:GetStageHasClearedByID(self.cfg_.id) then
			ShowTips("ACTIVITY_INDIA_NIAN_DESC_LOCK")
		end

		IndiaNianData:SetSelectedDescIndex(self.index_)

		if self.callBack then
			self.callBack(self.index_)
		end
	end)
end

function IndiaNianStageDescItem:RefreshUI()
	self.nameText_.text = self.cfg_.name
	self.iconImg_.sprite = getSprite("Atlas/IndiaUI_2_8", self.cfg_.icon)

	self:RefreshState()
end

function IndiaNianStageDescItem:RefreshState()
	local var_5_0 = getData("ActivityIndiaNian" .. IndiaNianData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "unlockNewStage" .. self.cfg_.id) == 1
	local var_5_1 = IndiaNianData:GetStageHasClearedByID(self.cfg_.id)
	local var_5_2 = self.index_ == IndiaNianData:GetSelectedDescIndex()

	if self.cfg_.round > IndiaNianData:GetRound() then
		self.controller_:SetSelectedState("lock")
	elseif var_5_1 then
		self.controller_:SetSelectedState("open")
	end

	self.selectController_:SetSelectedState(tostring(var_5_2))

	if var_5_1 then
		SetActive(self.effectGo_, not var_5_0)
	end
end

function IndiaNianStageDescItem:SetCallBack(arg_6_1)
	self.callBack = arg_6_1
end

function IndiaNianStageDescItem:SetData(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.cfg_ = arg_7_2

	self:RefreshUI()
end

function IndiaNianStageDescItem:OnExit()
	if IndiaNianData:GetStageHasClearedByID(self.cfg_.id) then
		saveData("ActivityIndiaNian" .. IndiaNianData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "unlockNewStage" .. self.cfg_.id, 1)
	end
end

return IndiaNianStageDescItem
