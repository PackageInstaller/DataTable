local ActivityMatrixSelectAffixView = class("ActivityMatrixSelectAffixView", ReduxView)

function ActivityMatrixSelectAffixView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/AactivityMatrixSelectAffixUI"
end

function ActivityMatrixSelectAffixView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMatrixSelectAffixView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityMatrixSelectAffixView:InitUI()
	self:BindCfgUI()

	self.affixRegularList_ = LuaList.New(handler(self, self.IndexAffixWeekItem), self.m_weekList, MatrixAffixLongItem)
	self.affixGroupList_ = LuaList.New(handler(self, self.IndexGroupItem), self.m_list, MatrixAffixGroupItem)
	self.affixHeroGroupList_ = LuaList.New(handler(self, self.IndexGroupHeroIitem), self.m_heroList, MatrixAffixGroupItem)
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
	self.customData = {}
end

function ActivityMatrixSelectAffixView:AddUIListener()
	self:AddBtnListener(self.m_okBtn, nil, function()
		ActivityMatrixAction.QueryStartMatrix(self.params_.select_hero_list, self.matrix_activity_id, self.customData)
	end)
end

function ActivityMatrixSelectAffixView:Reset()
	self.customData = {}

	self:ClearItems()
end

function ActivityMatrixSelectAffixView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function ActivityMatrixSelectAffixView:OnEnter()
	self.customData = {}

	self:Reset()

	self.matrix_activity_id = self.params_.matrix_activity_id
	self.regularData = {}

	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(ActivityMatrixCfg[self.matrix_activity_id].custom_affix) do
		if ActivityAffixPoolCfg[iter_9_1].affix[3] == 3 then
			var_9_1[ActivityAffixPoolCfg[iter_9_1].affix[1]] = var_9_1[ActivityAffixPoolCfg[iter_9_1].affix[1]] or {}

			table.insert(var_9_1[ActivityAffixPoolCfg[iter_9_1].affix[1]], iter_9_1)
		else
			var_9_0[ActivityAffixPoolCfg[iter_9_1].affix[1]] = var_9_0[ActivityAffixPoolCfg[iter_9_1].affix[1]] or {}

			table.insert(var_9_0[ActivityAffixPoolCfg[iter_9_1].affix[1]], iter_9_1)
		end
	end

	for iter_9_2, iter_9_3 in ipairs(self.regularData) do
		if ActivityAffixPoolCfg[iter_9_3].affix[3] == 3 then
			var_9_1[ActivityAffixPoolCfg[iter_9_3].affix[1]] = var_9_1[ActivityAffixPoolCfg[iter_9_3].affix[1]] or {}

			table.insert(var_9_1[ActivityAffixPoolCfg[iter_9_3].affix[1]], iter_9_3)
		else
			var_9_0[ActivityAffixPoolCfg[iter_9_3].affix[1]] = var_9_0[ActivityAffixPoolCfg[iter_9_3].affix[1]] or {}

			table.insert(var_9_0[ActivityAffixPoolCfg[iter_9_3].affix[1]], iter_9_3)
		end
	end

	self.chooseData = {}
	self.chooseData_hero = {}

	for iter_9_4, iter_9_5 in pairs(var_9_0) do
		table.sort(iter_9_5, function(arg_10_0, arg_10_1)
			return arg_10_1 < arg_10_0
		end)
		table.insert(self.chooseData, {
			id = iter_9_4,
			list = iter_9_5
		})
	end

	for iter_9_6, iter_9_7 in pairs(var_9_1) do
		table.sort(iter_9_7, function(arg_11_0, arg_11_1)
			return arg_11_1 < arg_11_0
		end)
		table.insert(self.chooseData_hero, {
			id = iter_9_6,
			list = iter_9_7
		})
	end

	self:Refresh(true)
	self.lockController:SetSelectedIndex(0)
end

function ActivityMatrixSelectAffixView:OnExit()
	manager.windowBar:HideBar()
end

function ActivityMatrixSelectAffixView:Refresh(arg_13_1)
	if arg_13_1 then
		self.affixRegularList_:StartScroll(#self.regularData)
		self.affixGroupList_:StartScroll(#self.chooseData)
		self.affixHeroGroupList_:StartScroll(#self.chooseData_hero)
	else
		self.affixRegularList_:StartScrollByPosition(#self.regularData, self.affixRegularList_:GetScrolledPosition())
		self.affixGroupList_:Refresh()
		self.affixHeroGroupList_:Refresh()
	end

	local var_13_0 = 0
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in ipairs(self.regularData) do
		var_13_0 = var_13_0 + ActivityAffixPoolCfg[iter_13_1].point
		var_13_1 = var_13_1 + ActivityAffixPoolCfg[iter_13_1].multiple
	end

	for iter_13_2, iter_13_3 in ipairs(self.customData) do
		var_13_0 = var_13_0 + ActivityAffixPoolCfg[iter_13_3].point
		var_13_1 = var_13_1 + ActivityAffixPoolCfg[iter_13_3].multiple
	end

	self.m_scoreLab.text = "" .. var_13_0
	self.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_13_1 / 10 .. "%")

	if not arg_13_1 then
		self:RefreshItems()
	end
end

function ActivityMatrixSelectAffixView:IndexAffixWeekItem(arg_14_1, arg_14_2)
	arg_14_2:Refresh(ActivityAffixPoolCfg[self.regularData[arg_14_1]].affix, 2)
end

function ActivityMatrixSelectAffixView:IndexAffixOptionalItem(arg_15_1, arg_15_2)
	arg_15_2:Refresh(ActivityAffixPoolCfg[self.customData[arg_15_1]].affix, 2)
end

function ActivityMatrixSelectAffixView:IndexGroupItem(arg_16_1, arg_16_2)
	arg_16_2:Refresh(self.chooseData[arg_16_1], self.regularData, self.customData)
	arg_16_2:RegistCallBack(handler(self, self.OnChooseCallBack))
end

function ActivityMatrixSelectAffixView:IndexGroupHeroIitem(arg_17_1, arg_17_2)
	arg_17_2:Refresh(self.chooseData_hero[arg_17_1], self.regularData, self.customData)
	arg_17_2:RegistCallBack(handler(self, self.OnChooseCallBack))
end

function ActivityMatrixSelectAffixView:OnChooseCallBack(arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(self.regularData) do
		if ActivityAffixPoolCfg[arg_18_1].affix[1] == ActivityAffixPoolCfg[iter_18_1].affix[1] then
			return
		end
	end

	local var_18_0 = false

	for iter_18_2, iter_18_3 in ipairs(self.customData) do
		if iter_18_3 == arg_18_1 then
			table.remove(self.customData, iter_18_2)

			var_18_0 = true

			break
		end

		if ActivityAffixPoolCfg[arg_18_1].affix[1] == ActivityAffixPoolCfg[iter_18_3].affix[1] then
			self.customData[iter_18_2] = arg_18_1
			var_18_0 = true

			break
		end
	end

	if not var_18_0 then
		table.insert(self.customData, 1, arg_18_1)
	end

	self:Refresh()
end

function ActivityMatrixSelectAffixView:StartScroll()
	return
end

function ActivityMatrixSelectAffixView:StartScrollByPosition()
	return
end

function ActivityMatrixSelectAffixView:RefreshItems()
	print(self.m_content.childCount)

	for iter_21_0 = 0, self.m_content.childCount - 1 do
		self.m_content:GetChild(iter_21_0).gameObject:SetActive(false)
	end

	print(self.m_content.childCount)

	if self.m_content.childCount < #self.customData then
		for iter_21_1 = 1, #self.customData - self.m_content.childCount do
			Object.Instantiate(self.m_item.gameObject, self.m_content.transform):SetActive(true)
		end
	end

	local var_21_1 = 0

	for iter_21_2, iter_21_3 in pairs(self.customData) do
		local var_21_3 = self.m_content:GetChild(var_21_1).gameObject

		var_21_1 = var_21_1 + 1

		var_21_3:SetActive(true)
		MatrixAffixLongItem.New(var_21_3):Refresh(ActivityAffixPoolCfg[iter_21_3].affix, 2)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content:GetComponent("RectTransform"))

	for iter_21_4 = 0, self.m_content.childCount - 1 do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content:GetChild(iter_21_4))
	end
end

function ActivityMatrixSelectAffixView:ClearItems()
	print(self.m_content.childCount)

	for iter_22_0 = 0, self.m_content.childCount - 1 do
		self.m_content:GetChild(iter_22_0).gameObject:SetActive(false)
	end
end

function ActivityMatrixSelectAffixView:Dispose()
	self.affixRegularList_:Dispose()
	self.affixGroupList_:Dispose()
	self.affixHeroGroupList_:Dispose()
	ActivityMatrixSelectAffixView.super.Dispose(self)
end

return ActivityMatrixSelectAffixView
