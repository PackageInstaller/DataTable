local MatrixSelectAffixView = class("MatrixSelectAffixView", ReduxView)

function MatrixSelectAffixView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function MatrixSelectAffixView:InitUI()
	self:BindCfgUI()

	self.affixRegularList_ = LuaList.New(handler(self, self.IndexAffixWeekItem), self.m_weekList, MatrixAffixLongItem)
	self.affixGroupList_ = LuaList.New(handler(self, self.IndexGroupItem), self.m_list, MatrixAffixGroupItem)
	self.affixHeroGroupList_ = LuaList.New(handler(self, self.IndexGroupHeroIitem), self.m_heroList, MatrixAffixGroupItem)
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
	self.customData = {}
end

function MatrixSelectAffixView:Reset()
	self.customData = {}

	self:ClearItems()
end

function MatrixSelectAffixView:SetData(arg_4_1)
	local var_4_0 = MatrixData:GetReadyDifficultyData(arg_4_1)

	self.regularData = var_4_0:GetRegularAffix()

	local var_4_1 = {}
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs((var_4_0:GetAllCustomAffix())) do
		if ActivityAffixPoolCfg[iter_4_1].affix[3] == 3 then
			var_4_2[ActivityAffixPoolCfg[iter_4_1].affix[1]] = var_4_2[ActivityAffixPoolCfg[iter_4_1].affix[1]] or {}

			table.insert(var_4_2[ActivityAffixPoolCfg[iter_4_1].affix[1]], iter_4_1)
		else
			var_4_1[ActivityAffixPoolCfg[iter_4_1].affix[1]] = var_4_1[ActivityAffixPoolCfg[iter_4_1].affix[1]] or {}

			table.insert(var_4_1[ActivityAffixPoolCfg[iter_4_1].affix[1]], iter_4_1)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self.regularData) do
		if ActivityAffixPoolCfg[iter_4_3].affix[3] == 3 then
			var_4_2[ActivityAffixPoolCfg[iter_4_3].affix[1]] = var_4_2[ActivityAffixPoolCfg[iter_4_3].affix[1]] or {}

			table.insert(var_4_2[ActivityAffixPoolCfg[iter_4_3].affix[1]], iter_4_3)
		else
			var_4_1[ActivityAffixPoolCfg[iter_4_3].affix[1]] = var_4_1[ActivityAffixPoolCfg[iter_4_3].affix[1]] or {}

			table.insert(var_4_1[ActivityAffixPoolCfg[iter_4_3].affix[1]], iter_4_3)
		end
	end

	self.chooseData = {}
	self.chooseData_hero = {}

	for iter_4_4, iter_4_5 in pairs(var_4_1) do
		table.sort(iter_4_5, function(arg_5_0, arg_5_1)
			return arg_5_1 < arg_5_0
		end)
		table.insert(self.chooseData, {
			id = iter_4_4,
			list = iter_4_5
		})
	end

	for iter_4_6, iter_4_7 in pairs(var_4_2) do
		table.sort(iter_4_7, function(arg_6_0, arg_6_1)
			return arg_6_1 < arg_6_0
		end)
		table.insert(self.chooseData_hero, {
			id = iter_4_6,
			list = iter_4_7
		})
	end

	self:Refresh(true)

	if not IsConditionAchieved(MatrixConst.MATRIX_UNLOCK_CUSTOM_AFFIX_CONDITION) then
		self.lockController:SetSelectedIndex(1)
	else
		self.lockController:SetSelectedIndex(0)
	end
end

function MatrixSelectAffixView:Refresh(arg_7_1)
	if arg_7_1 then
		self.affixRegularList_:StartScroll(#self.regularData)
		self.affixGroupList_:StartScroll(#self.chooseData)
		self.affixHeroGroupList_:StartScroll(#self.chooseData_hero)
	else
		self.affixRegularList_:StartScrollByPosition(#self.regularData, self.affixRegularList_:GetScrolledPosition())
		self.affixGroupList_:Refresh()
		self.affixHeroGroupList_:Refresh()
	end

	local var_7_0 = 0
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(self.regularData) do
		var_7_0 = var_7_0 + ActivityAffixPoolCfg[iter_7_1].point
		var_7_1 = var_7_1 + ActivityAffixPoolCfg[iter_7_1].multiple
	end

	for iter_7_2, iter_7_3 in ipairs(self.customData) do
		var_7_0 = var_7_0 + ActivityAffixPoolCfg[iter_7_3].point
		var_7_1 = var_7_1 + ActivityAffixPoolCfg[iter_7_3].multiple
	end

	self.m_scoreLab.text = "" .. var_7_0
	self.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_7_1 / 10 .. "%")

	if not arg_7_1 then
		self:RefreshItems()
	end
end

function MatrixSelectAffixView:IndexAffixWeekItem(arg_8_1, arg_8_2)
	arg_8_2:Refresh(ActivityAffixPoolCfg[self.regularData[arg_8_1]].affix, 2)
end

function MatrixSelectAffixView:IndexAffixOptionalItem(arg_9_1, arg_9_2)
	arg_9_2:Refresh(ActivityAffixPoolCfg[self.customData[arg_9_1]].affix, 2)
end

function MatrixSelectAffixView:IndexGroupItem(arg_10_1, arg_10_2)
	arg_10_2:Refresh(self.chooseData[arg_10_1], self.regularData, self.customData)
	arg_10_2:RegistCallBack(handler(self, self.OnChooseCallBack))
end

function MatrixSelectAffixView:IndexGroupHeroIitem(arg_11_1, arg_11_2)
	arg_11_2:Refresh(self.chooseData_hero[arg_11_1], self.regularData, self.customData)
	arg_11_2:RegistCallBack(handler(self, self.OnChooseCallBack))
end

function MatrixSelectAffixView:OnChooseCallBack(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(self.regularData) do
		if ActivityAffixPoolCfg[arg_12_1].affix[1] == ActivityAffixPoolCfg[iter_12_1].affix[1] then
			return
		end
	end

	local var_12_0 = false

	for iter_12_2, iter_12_3 in ipairs(self.customData) do
		if iter_12_3 == arg_12_1 then
			table.remove(self.customData, iter_12_2)

			var_12_0 = true

			break
		end

		if ActivityAffixPoolCfg[arg_12_1].affix[1] == ActivityAffixPoolCfg[iter_12_3].affix[1] then
			self.customData[iter_12_2] = arg_12_1
			var_12_0 = true

			break
		end
	end

	if not var_12_0 then
		table.insert(self.customData, 1, arg_12_1)
	end

	self:Refresh()
end

function MatrixSelectAffixView:Dispose()
	self.affixRegularList_:Dispose()
	self.affixGroupList_:Dispose()
	self.affixHeroGroupList_:Dispose()
	MatrixSelectAffixView.super.Dispose(self)
end

function MatrixSelectAffixView:StartScroll()
	return
end

function MatrixSelectAffixView:StartScrollByPosition()
	return
end

function MatrixSelectAffixView:RefreshItems()
	print(self.m_content.childCount)

	for iter_16_0 = 0, self.m_content.childCount - 1 do
		self.m_content:GetChild(iter_16_0).gameObject:SetActive(false)
	end

	print(self.m_content.childCount)

	if self.m_content.childCount < #self.customData then
		for iter_16_1 = 1, #self.customData - self.m_content.childCount do
			Object.Instantiate(self.m_item.gameObject, self.m_content.transform):SetActive(true)
		end
	end

	local var_16_1 = 0

	for iter_16_2, iter_16_3 in pairs(self.customData) do
		local var_16_3 = self.m_content:GetChild(var_16_1).gameObject

		var_16_1 = var_16_1 + 1

		var_16_3:SetActive(true)
		MatrixAffixLongItem.New(var_16_3):Refresh(ActivityAffixPoolCfg[iter_16_3].affix, 2)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content:GetComponent("RectTransform"))

	for iter_16_4 = 0, self.m_content.childCount - 1 do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_content:GetChild(iter_16_4))
	end
end

function MatrixSelectAffixView:ClearItems()
	print(self.m_content.childCount)

	for iter_17_0 = 0, self.m_content.childCount - 1 do
		self.m_content:GetChild(iter_17_0).gameObject:SetActive(false)
	end
end

return MatrixSelectAffixView
