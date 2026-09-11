local CivilizationGameChooseSkillView = class("CivilizationGameChooseSkillView", ReduxView)

function CivilizationGameChooseSkillView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_SelectSkillPopUI"
end

function CivilizationGameChooseSkillView:UIParent()
	return manager.ui.uiPop.transform
end

function CivilizationGameChooseSkillView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CivilizationGameChooseSkillView:InitUI()
	self:BindCfgUI()

	self.btnController_ = self.mainControllerEx_:GetController("btn")
	self.itemList_ = {}
end

function CivilizationGameChooseSkillView:AddUIListener()
	self:AddBtnListener(self.chooseBtn_, nil, function()
		if self.type_ == CivilizationGameConst.techType.TECH then
			civilization.CivilizationLuaBridge.ChooseTech(self.selectID_)
		elseif CivilizationGameConst.techType.HEX then
			civilization.CivilizationLuaBridge.ChooseHex(self.selectID_)
			manager.notify:CallUpdateFunc(CIVILIZATION_GAIN_HEX, self.selectID_, self.hexIndex_)
		end

		JumpTools.Back()
	end)
end

function CivilizationGameChooseSkillView:OnEnter()
	self.selectID_ = 0
	self.idList_ = self.params_.idList:ToTable()
	self.type_ = self.params_.chooseType

	if self.params_.index then
		self.hexIndex_ = self.params_.index + 1
	end

	self:UpdateView()
end

function CivilizationGameChooseSkillView:UpdateView()
	if self.type_ == CivilizationGameConst.techType.TECH then
		self.titleText_.text = GetTips("GODEATER_CIVILIZATION_COMMON_FACTOR_SELECT")
	elseif CivilizationGameConst.techType.HEX then
		self.titleText_.text = GetTips("GODEATER_CIVILIZATION_SPECIAL_FACTOR_SELECT")
	end

	for iter_8_0, iter_8_1 in ipairs(self.idList_) do
		if self.itemList_[iter_8_0] then
			-- block empty
		else
			self.itemList_[iter_8_0] = CivilizationSkillChooseItem.New((Object.Instantiate(self.techGo_, self.itemContentTrs_)))
		end

		self.itemList_[iter_8_0]:SetData(self.type_, iter_8_1, function(arg_9_0)
			self:ChooseItem(arg_9_0)
		end)
		self.itemList_[iter_8_0]:SetActive(true)
	end

	for iter_8_2 = #self.itemList_, #self.idList_ + 1, -1 do
		self.itemList_[iter_8_2]:SetActive(false)
	end

	self:RefreshBtn()
end

function CivilizationGameChooseSkillView:ChooseItem(arg_10_1)
	self.selectID_ = arg_10_1

	for iter_10_0, iter_10_1 in ipairs(self.itemList_) do
		if self.selectID_ == iter_10_1:GetID() then
			iter_10_1:SetSelected(true)
		else
			iter_10_1:SetSelected(false)
		end
	end

	self:RefreshBtn()
end

function CivilizationGameChooseSkillView:RefreshBtn()
	if not self.selectID_ or self.selectID_ == 0 then
		self.btnController_:SetSelectedState("no")
	else
		self.btnController_:SetSelectedState("select")
	end
end

function CivilizationGameChooseSkillView:OnExit()
	self.selectID_ = 0

	for iter_12_0, iter_12_1 in pairs(self.itemList_) do
		iter_12_1:SetSelected(false)
	end

	manager.windowBar:HideBar()
end

function CivilizationGameChooseSkillView:OnTop()
	manager.windowBar:HideBar()
end

function CivilizationGameChooseSkillView:Dispose()
	for iter_14_0, iter_14_1 in pairs(self.itemList_) do
		iter_14_1:Dispose()
	end

	CivilizationGameChooseSkillView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CivilizationGameChooseSkillView
