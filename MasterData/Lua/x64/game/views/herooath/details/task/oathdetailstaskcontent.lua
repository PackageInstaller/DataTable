local OathBubbleContent = class("OathBubbleContent", ReduxView)

function OathBubbleContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function OathBubbleContent:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.uiList_ = LuaList.New(handler(self, self.IndexRewardItem), self.uiListGo_, OathDetailsTaskItem)
	self.oneClickController_ = self.controller_:GetController("oneclick")
	self.emptyController_ = self.controller_:GetController("empty")

	self:InitStageUIList()
end

function OathBubbleContent:InitStageUIList()
	self.stageItemList = {}

	for iter_3_0 = 0, self.stageContent_.childCount - 1 do
		local var_3_0 = 1 + iter_3_0
		local var_3_1 = OathDetailsStageItem.New(self.stageContent_:GetChild(iter_3_0).gameObject, 1 + iter_3_0)

		var_3_1:SetClickCallback(function()
			self:OnClickStageItem(var_3_0)
		end)
		table.insert(self.stageItemList, var_3_1)
	end

	self.maxLvRange = #self.stageItemList
end

function OathBubbleContent:UpdateStageUI()
	for iter_5_0, iter_5_1 in pairs(self.stageItemList or {}) do
		iter_5_1:SetData(self.heroID)
	end
end

function OathBubbleContent:OnClickStageItem(arg_6_1)
	if self.selectLevel == arg_6_1 then
		return
	end

	self.selectLevel = arg_6_1

	for iter_6_0, iter_6_1 in pairs(self.stageItemList or {}) do
		if iter_6_1 then
			iter_6_1:SetSelectState(iter_6_1.level == arg_6_1)
		end
	end

	self:RefreshTaskList()
end

function OathBubbleContent:AddEventListeners()
	self:RegistEventListener(OATH_TASK_UPDATE, handler(self, self.OnTaskUpdate))
	self:RegistEventListener(OATH_HERO_LV_UPDATE, handler(self, self.OnLvUpdate))
end

function OathBubbleContent:AddListeners()
	self:AddBtnListener(self.oneClickBtn_, nil, function()
		self:OnClickOneClickBtn()
	end)
end

function OathBubbleContent:OnClickOneClickBtn()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self.oathTaskList) do
		local var_10_1 = OathAssignmentData:GetOathAssignmentByID(iter_10_1)

		if var_10_1.status == 0 and var_10_1.progress >= WeddingAssignmentCfg[iter_10_1].need then
			table.insert(var_10_0, iter_10_1)
		end
	end

	OathAssignmentAction.SubmitOathTask(var_10_0)
end

function OathBubbleContent:OnLvUpdate()
	self:UpdateStageUI()
	self:OnClickStageItem((Mathf.Min(self.selectLevel + 1, self.maxLvRange)))
end

function OathBubbleContent:OnTaskUpdate()
	self:RefreshTaskList()
	self:UpdateStageUI()
end

function OathBubbleContent:IndexRewardItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.oathTaskList[arg_13_1], #self.oathTaskList)
end

function OathBubbleContent:GetDefaultSelectIndex()
	local var_14_0, var_14_1 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(self.heroID, 1)

	if var_14_0 < var_14_1 then
		return 1
	else
		local var_14_2, var_14_3 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(self.heroID, 2)

		if var_14_3 > var_14_2 then
			return 2
		else
			return 3
		end
	end
end

function OathBubbleContent:RefreshUI(arg_15_1)
	self.heroID = arg_15_1
	self.emptyText_.text = GetI18NText(WeddingCfg[arg_15_1].no_task_desc)

	self:UpdateStageUI()
	self:OnClickStageItem((self:GetDefaultSelectIndex()))
end

function OathBubbleContent:RefreshTaskList()
	local var_16_0

	if not self.selectLevel then
		do return end

		var_16_0 = {}
	end

	for iter_16_0, iter_16_1 in ipairs(WeddingAssignmentCfg.get_id_list_by_hero_id[self.heroID]) do
		if WeddingAssignmentCfg[iter_16_1] and WeddingAssignmentCfg[iter_16_1].wedding_level == self.selectLevel then
			table.insert(var_16_0, iter_16_1)
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0 < arg_17_1
	end)

	self.oathTaskList = var_16_0

	self.uiList_:StartScroll(#self.oathTaskList)

	local var_16_1 = false

	for iter_16_2, iter_16_3 in ipairs(self.oathTaskList) do
		local var_16_2 = OathAssignmentData:GetOathAssignmentByID(iter_16_3)

		if var_16_2.status == 0 and var_16_2.progress >= WeddingAssignmentCfg[iter_16_3].need then
			var_16_1 = true

			break
		end
	end

	if var_16_1 then
		self.oneClickController_:SetSelectedState("show")
	else
		self.oneClickController_:SetSelectedState("hide")
	end

	if #self.oathTaskList == 0 then
		self.emptyController_:SetSelectedState("state1")
	else
		self.emptyController_:SetSelectedState("state0")
	end
end

function OathBubbleContent:OnShow()
	self:AddEventListeners()
end

function OathBubbleContent:OnHide()
	self:RemoveAllListeners()
end

function OathBubbleContent:OnEnter()
	return
end

function OathBubbleContent:OnExit()
	self.selectLevel = nil

	self:RemoveAllListeners()
end

function OathBubbleContent:Dispose()
	self:RemoveAllListeners()

	for iter_22_0, iter_22_1 in pairs(self.stageItemList) do
		iter_22_1:Dispose()

		iter_22_1 = nil
	end

	self.stageItemList = {}

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	self.super.Dispose(self)
end

return OathBubbleContent
