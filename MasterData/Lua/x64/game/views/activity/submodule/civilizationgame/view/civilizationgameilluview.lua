local CivilizationGameIlluView = class("CivilizationGameIlluView", ReduxView)

function CivilizationGameIlluView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Culture/V4_2_GodEaterUI_Culture_illustrationUI"
end

function CivilizationGameIlluView:UIParent()
	return manager.ui.uiMain.transform
end

function CivilizationGameIlluView:Init()
	self:InitUI()

	self.selectID_ = 1
	self.selectType = 1
	self.allItems = {}
	self.gridItemList_ = {}
	self.hexItemList_1 = {}
	self.hexItemList_2 = {}
	self.techItemList_ = {}
	self.lockController_ = self.mainControllerEx_:GetController("lock")
	self.typeController_ = self.typeControllerEx_:GetController("card")
end

function CivilizationGameIlluView:InitUI()
	self:BindCfgUI()
end

function CivilizationGameIlluView:OnEnter()
	self.gridIlluIDList_ = {}
	self.hexIlluIDList_1 = {}
	self.hexIlluIDList_2 = {}
	self.techIlluIDList_ = {}
	self.illuIDList_ = CivilizationGameData:GetDataByPara("illu_list")

	self:ParseData()
	self:RefreshItem()
	self:ChooseItem(self.selectType, self.selectID_)
	self:RefreshUI(self.selectType)
end

function CivilizationGameIlluView:ParseData()
	for iter_6_0, iter_6_1 in ipairs(self.illuIDList_) do
		if table.indexof(ActivityCivilizationIlluCfg.get_id_list_by_group_id[1], iter_6_1) then
			table.insert(self.gridIlluIDList_, iter_6_1)
		elseif table.indexof(ActivityCivilizationIlluCfg.get_id_list_by_group_id[2], iter_6_1) then
			table.insert(self.hexIlluIDList_1, iter_6_1)
		elseif table.indexof(ActivityCivilizationIlluCfg.get_id_list_by_group_id[3], iter_6_1) then
			table.insert(self.hexIlluIDList_2, iter_6_1)
		else
			table.insert(self.techIlluIDList_, iter_6_1)
		end
	end
end

local function var_0_1(arg_7_0)
	table.sort(arg_7_0, function(arg_8_0, arg_8_1)
		return ActivityCivilizationIlluCfg[arg_8_0].group_display_order < ActivityCivilizationIlluCfg[arg_8_1].group_display_order
	end)

	return arg_7_0
end

function CivilizationGameIlluView:RefreshItem()
	for iter_9_0, iter_9_1 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[1])) do
		self.gridItemList_[iter_9_0] = self.gridItemList_[iter_9_0] or CivilizationIlluItem.New((Object.Instantiate(self.cardItemGo_, self.gridContentTrs_)))

		self.gridItemList_[iter_9_0]:SetData(1, iter_9_1, function(arg_10_0)
			self:ChooseItem(1, arg_10_0)
		end)
		self.gridItemList_[iter_9_0]:SetActive(true)
		table.insert(self.allItems, self.gridItemList_[iter_9_0])
	end

	for iter_9_2, iter_9_3 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[2])) do
		self.hexItemList_1[iter_9_2] = self.hexItemList_1[iter_9_2] or CivilizationIlluItem.New((Object.Instantiate(self.cardItemGo_, self.hex1ContentTrs_)))

		self.hexItemList_1[iter_9_2]:SetData(2, iter_9_3, function(arg_11_0)
			self:ChooseItem(2, arg_11_0)
		end)
		self.hexItemList_1[iter_9_2]:SetActive(true)
		table.insert(self.allItems, self.hexItemList_1[iter_9_2])
	end

	for iter_9_4, iter_9_5 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[3])) do
		self.hexItemList_2[iter_9_4] = self.hexItemList_2[iter_9_4] or CivilizationIlluItem.New((Object.Instantiate(self.cardItemGo_, self.hex2ContentTrs_)))

		self.hexItemList_2[iter_9_4]:SetData(3, iter_9_5, function(arg_12_0)
			self:ChooseItem(3, arg_12_0)
		end)
		self.hexItemList_2[iter_9_4]:SetActive(true)
		table.insert(self.allItems, self.hexItemList_2[iter_9_4])
	end

	for iter_9_6, iter_9_7 in ipairs(var_0_1(ActivityCivilizationIlluCfg.get_id_list_by_group_id[4])) do
		self.techItemList_[iter_9_6] = self.techItemList_[iter_9_6] or CivilizationIlluItem.New((Object.Instantiate(self.cardItemGo_, self.techContentTrs_)))

		self.techItemList_[iter_9_6]:SetData(self.type_, iter_9_7, function(arg_13_0)
			self:ChooseItem(4, arg_13_0)
		end)
		self.techItemList_[iter_9_6]:SetActive(true)
		table.insert(self.allItems, self.techItemList_[iter_9_6])
	end
end

function CivilizationGameIlluView:ChooseItem(arg_14_1, arg_14_2)
	if self.selectID_ == arg_14_2 then
		return
	end

	self.rightAnimator_:Play("UI_GodEaterUI_Com_rightbg01_cx", 0, 0)

	self.selectID_ = arg_14_2
	self.selectType = arg_14_1

	for iter_14_0, iter_14_1 in ipairs(self.allItems) do
		if iter_14_1:GetID() == self.selectID_ then
			iter_14_1:SetSelect(true)
		else
			iter_14_1:SetSelect(false)
		end
	end

	self:RefreshUI(arg_14_1)
end

function CivilizationGameIlluView:RefreshUI(arg_15_1)
	local var_15_0 = ActivityCivilizationIlluCfg[self.selectID_]

	if arg_15_1 == 1 then
		self.typeController_:SetSelectedState("grid")

		self.gridImg_.sprite = getSpriteViaConfig("CivilizationGame", var_15_0.picture)
		self.tagText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_1")
	elseif arg_15_1 == 4 then
		self.typeController_:SetSelectedState("skill")

		self.techImg_.sprite = getSpriteViaConfig("CivilizationGame", var_15_0.picture)
		self.tagText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_2")
	else
		self.typeController_:SetSelectedState("Hekes")

		self.hexImg_.sprite = getSpriteViaConfig("CivilizationGame", var_15_0.picture)
		self.tagText_.text = arg_15_1 == 2 and GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_4") or GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_3")
	end

	if table.indexof(self.illuIDList_, self.selectID_) then
		self.lockController_:SetSelectedState("unlock")
	else
		self.lockController_:SetSelectedState("lock")
	end

	self.titleText_.text = var_15_0.name
	self.descText_.text = var_15_0.desc
	self.gridTitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_1")
	self.hex1TitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_4")
	self.hex2TitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_3")
	self.techTitleText_.text = GetTips("GODEATER_CIVILIZATION_FACTOR_TYPE_2")
end

function CivilizationGameIlluView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CivilizationGameIlluView:OnExit()
	manager.windowBar:HideBar()
end

function CivilizationGameIlluView:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.allItems) do
		iter_18_1:Dispose()
	end

	CivilizationGameIlluView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CivilizationGameIlluView
