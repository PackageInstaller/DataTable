local RoguelikeAffixSelectView = class("RoguelikeAffixSelectView", ReduxView)

function RoguelikeAffixSelectView:UIBackCount()
	return 2
end

function RoguelikeAffixSelectView:UIName()
	return "Widget/System/MatrixlUI/StrategyMatrixSelectAffixUI"
end

function RoguelikeAffixSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function RoguelikeAffixSelectView:Init()
	self:InitUI()
	self:AddUIListener()

	self.customItems = {}
end

function RoguelikeAffixSelectView:OnEnter()
	self.customData = {}
	self.activity_id = self.params_.activity_id
	self.cfg = StrategyMatrixCfg[self.activity_id]

	self:MappingConfig(self.cfg)
	self:Refresh(true)
end

function RoguelikeAffixSelectView:Reset()
	self.customData = {}
end

function RoguelikeAffixSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(self.activity_id))
end

function RoguelikeAffixSelectView:OnExit()
	manager.windowBar:HideBar()
end

function RoguelikeAffixSelectView:InitUI()
	self.gameObject_:InjectUI(self)

	self.affixGroupList_ = LuaList.New(handler(self, self.IndexGroupItem), self.RectMonster, MatrixAffixGroupItem)
	self.affixHeroGroupList_ = LuaList.New(handler(self, self.IndexGroupHeroItem), self.RectHero, MatrixAffixGroupItem)
end

function RoguelikeAffixSelectView:AddUIListener()
	self:AddBtnListener(self.Btnbtn_ok, nil, function()
		StrategyMatrixAction.QueryStartMatrix(self.cfg.hero_standard_system_id_list, self.activity_id, self.customData)
	end)
end

function RoguelikeAffixSelectView:MappingConfig(arg_12_1)
	if not arg_12_1 then
		return
	end

	self.monster_affix = {}
	self.hero_affix = {}

	local var_12_0 = {}
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.custom_affix) do
		local var_12_2 = ActivityAffixPoolCfg[iter_12_1].affix[1]

		if ActivityAffixPoolCfg[iter_12_1].affix[3] == 3 then
			var_12_1[var_12_2] = var_12_1[var_12_2] or {}

			table.insert(var_12_1[var_12_2], iter_12_1)
		else
			var_12_0[var_12_2] = var_12_0[var_12_2] or {}

			table.insert(var_12_0[var_12_2], iter_12_1)
		end
	end

	for iter_12_2, iter_12_3 in pairs(var_12_1) do
		table.sort(iter_12_3, function(arg_13_0, arg_13_1)
			return arg_13_1 < arg_13_0
		end)
		table.insert(self.hero_affix, {
			id = iter_12_2,
			list = iter_12_3
		})
	end

	for iter_12_4, iter_12_5 in pairs(var_12_0) do
		table.sort(iter_12_5, function(arg_14_0, arg_14_1)
			return arg_14_1 < arg_14_0
		end)
		table.insert(self.monster_affix, {
			id = iter_12_4,
			list = iter_12_5
		})
	end

	print("词缀长度-------------->", #self.monster_affix, "--", #self.hero_affix)
end

function RoguelikeAffixSelectView:GetHeroData()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self.cfg.hero_standard_system_id_list) do
		table.insert(var_15_0, {
			hero_type = 2,
			hero_standard_system_id = iter_15_1
		})
	end

	return var_15_0
end

function RoguelikeAffixSelectView:Refresh(arg_16_1)
	self:GenerateItems(self.customItems, #self.customData, MatrixAffixLongItem, self.GoItem, self.Content)

	for iter_16_0 = 1, #self.customData do
		self.customItems[iter_16_0]:Refresh(ActivityAffixPoolCfg[self.customData[iter_16_0]].affix, 2)
	end

	if arg_16_1 then
		self.affixGroupList_:StartScroll(#self.monster_affix)
		self.affixHeroGroupList_:StartScroll(#self.hero_affix)
	else
		self.affixGroupList_:Refresh()
		self.affixHeroGroupList_:Refresh()
	end

	local var_16_0 = 0
	local var_16_1 = 0

	for iter_16_1, iter_16_2 in ipairs(self.customData) do
		var_16_0 = var_16_0 + ActivityAffixPoolCfg[iter_16_2].point
		var_16_1 = var_16_1 + ActivityAffixPoolCfg[iter_16_2].multiple
	end

	self.TxtDifficult.text = tostring(var_16_0)
	self.TxtRate.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_16_1 / 10 .. "%")
end

function RoguelikeAffixSelectView:IndexAffixOptionalItem(arg_17_1, arg_17_2)
	arg_17_2:Refresh(ActivityAffixPoolCfg[self.customData[arg_17_1]].affix, 2)
end

function RoguelikeAffixSelectView:IndexGroupItem(arg_18_1, arg_18_2)
	arg_18_2:Refresh(self.monster_affix[arg_18_1], {}, self.customData)
	arg_18_2:RegistCallBack(handler(self, self.OnChooseCallBack))
end

function RoguelikeAffixSelectView:IndexGroupHeroItem(arg_19_1, arg_19_2)
	arg_19_2:Refresh(self.hero_affix[arg_19_1], {}, self.customData)
	arg_19_2:RegistCallBack(handler(self, self.OnChooseCallBack))
end

function RoguelikeAffixSelectView:GenerateItems(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	self.pool = self.pool or {}

	local var_20_0 = #self.pool
	local var_20_1 = #arg_20_1

	while var_20_1 < arg_20_2 do
		if var_20_0 > 0 then
			self.pool[var_20_0].transform_:SetParent(arg_20_5)
			table.insert(arg_20_1, self.pool[var_20_0])
			table.remove(self.pool, var_20_0)
		else
			table.insert(arg_20_1, (arg_20_3.New((Object.Instantiate(arg_20_4, arg_20_5)))))
		end

		var_20_1 = var_20_1 + 1
	end

	while arg_20_2 < var_20_1 do
		arg_20_1[var_20_1].gameObject_:SetActive(false)
		table.insert(self.pool, arg_20_1[var_20_1])
		table.remove(arg_20_1, var_20_1)

		var_20_1 = var_20_1 - 1
	end

	for iter_20_0 = 1, var_20_1 do
		arg_20_1[iter_20_0].gameObject_:SetActive(true)
	end
end

function RoguelikeAffixSelectView:OnChooseCallBack(arg_21_1)
	local var_21_0 = false

	for iter_21_0, iter_21_1 in ipairs(self.customData) do
		if iter_21_1 == arg_21_1 then
			table.remove(self.customData, iter_21_0)

			var_21_0 = true

			break
		end

		if ActivityAffixPoolCfg[arg_21_1].affix[1] == ActivityAffixPoolCfg[iter_21_1].affix[1] then
			self.customData[iter_21_0] = arg_21_1
			var_21_0 = true

			break
		end
	end

	if not var_21_0 then
		table.insert(self.customData, 1, arg_21_1)
	end

	self:Refresh()
end

function RoguelikeAffixSelectView:Dispose()
	self.affixGroupList_:Dispose()
	self.affixHeroGroupList_:Dispose()

	for iter_22_0, iter_22_1 in ipairs(self.customItems) do
		iter_22_1:Dispose()
	end

	self.customItems = {}

	RoguelikeAffixSelectView.super.Dispose(self)
end

return RoguelikeAffixSelectView
