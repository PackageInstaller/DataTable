local AdvanceTest4AffixSelectView = class("AdvanceTest4AffixSelectView", ReduxView)

function AdvanceTest4AffixSelectView:UIName()
	return "Widget/System/AdvanceTest/AdvanceTest_StageType4UI"
end

function AdvanceTest4AffixSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function AdvanceTest4AffixSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdvanceTest4AffixSelectView:InitUI()
	self:BindCfgUI()

	self.showTipController = self.controller_:GetController("showTips")
	self.buffList = LuaList.New(handler(self, self.IndexBuffItem), self.bufflList_, AdvanceTest4AffixSelectItem)
	self.deBuffList = LuaList.New(handler(self, self.IndexDeBuffItem), self.debuffList_, AdvanceTest4AffixSelectItem)
	self.selectList = LuaList.New(handler(self, self.IndexSelectItem), self.uiListGo_, AdvanceTest4AffixCurSelectItem)
	self.clickAffixHandler = handler(self, self.ClickAffix)
	self.selectAffixHandler = handler(self, self.SelectAffix)
end

function AdvanceTest4AffixSelectView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self.showTipController:SetSelectedIndex(0)

		self.showSelectGen = 0

		self.buffList:Refresh()
		self.deBuffList:Refresh()
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = AdvanceTestCfg[self.subStageID].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST,
			stageDifficult = AdvanceTestCfg[self.subStageID].stage_type,
			activityID = self.mainActivityID_,
			dest = AdvanceTestCfg[self.subStageID].id
		})
	end)
end

function AdvanceTest4AffixSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AdvanceTest4AffixSelectView:OnEnter()
	self.subStageID = self.params_.stageID
	self.select_affix = AdvanceTestData:GetSelectGen(self.subStageID)
	self.mainActivityID_ = self.params_.activityID
	self.showSelectGen = 0

	self.showTipController:SetSelectedIndex(0)

	self.maxSelect = GameSetting.test_challenge_core_mode1_affix_num.value[1]
	self.activityID = self.params_.activityID

	local var_9_0 = AdvanceTestCfg[self.subStageID]

	self.titleText_.text = AdvanceTestCfg[self.subStageID].stage_name

	local var_9_1 = AdvanceTestData:GetHistortyMaxScoreByIndex(var_9_0.stage_type, self.mainActivityID_)

	self.scoreText_.text = (var_9_1 == -1 or var_9_1 == 0) and "--" or var_9_1
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/Bgbc", var_9_0.stage_target))

	if var_9_0.affix_id ~= "" then
		local var_9_2 = var_9_0.affix_id[1] or 0

		if ActivityAffixPoolCfg[var_9_2] then
			self.comAffixName_.text = getAffixName(ActivityAffixPoolCfg[var_9_2].affix)
			self.comAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[var_9_2].affix)

			goto label_9_0
		end
	end

	self.comAffixName_.text = ""
	self.comAffixDesc_.text = ""

	::label_9_0::

	if var_9_0.affix_id ~= "" then
		local var_9_3 = var_9_0.affix_id[2] or 0

		if ActivityAffixPoolCfg[var_9_3] then
			self.stageAffixName_.text = getAffixName(ActivityAffixPoolCfg[var_9_3].affix)
			self.stageAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[var_9_3].affix)
			self.stageAffixImg_.sprite = getAffixSprite(ActivityAffixPoolCfg[var_9_3].affix)

			goto label_9_1
		end
	end

	self.stageAffixName_.text = ""
	self.stageAffixDesc_.text = ""

	::label_9_1::

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bufflList_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.debuffList_.transform)
	TimeTools.StartAfterSeconds(0.033, function()
		if var_9_0.affix_buff == "" then
			self.buffList:StartScroll(0)
		else
			self.affix_buff = var_9_0.affix_buff

			self.buffList:StartScroll(#self.affix_buff)
		end

		if var_9_0.affix_debuff == "" then
			self.deBuffList:StartScroll(0)
		else
			self.affix_debuff = var_9_0.affix_debuff

			self.deBuffList:StartScroll(#self.affix_debuff)
		end

		self:RefreshUI(true)
	end, {})
end

function AdvanceTest4AffixSelectView:OnExit()
	manager.windowBar:HideBar()

	self.showSelectGen = 0

	self.showTipController:SetSelectedIndex(0)
	self:RecordSelect()
end

function AdvanceTest4AffixSelectView:RecordSelect()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.select_affix) do
		local var_12_1 = iter_12_1 % 100

		table.insert(var_12_0, ((math.floor(iter_12_1 / 100) == 0 or nil) and (self.affix_buff or self.affix_debuff))[var_12_1][1])
	end

	AdvanceTestData:RecordSelectAffix(self.subStageID, self.select_affix, var_12_0)
end

function AdvanceTest4AffixSelectView:Dispose()
	self.buffList:Dispose()
	self.deBuffList:Dispose()
	self.selectList:Dispose()
	AdvanceTest4AffixSelectView.super.Dispose(self)
end

function AdvanceTest4AffixSelectView:RefreshUI(arg_14_1)
	local var_14_0 = 100

	for iter_14_0, iter_14_1 in pairs(self.select_affix) do
		if math.floor(iter_14_1 / 100) == 0 then
			if not self.affix_buff then
				-- block empty
			end
		end

		var_14_0 = var_14_0 + self.affix_debuff[iter_14_1 % 100][2]
	end

	self.affixNum_.text = #self.select_affix .. "/" .. self.maxSelect
	self.efficiencyNum_.text = var_14_0 .. "%"

	if not arg_14_1 then
		self.buffList:Refresh()
		self.deBuffList:Refresh()
	end

	self.selectList:StartScroll(#self.select_affix)
end

function AdvanceTest4AffixSelectView:ShowTipsView(arg_15_1)
	self.showTipController:SetSelectedIndex(1)

	self.tipsNameText_.text = getAffixName(ActivityAffixPoolCfg[arg_15_1].affix)
	self.tipsDescText_.text = getAffixDesc(ActivityAffixPoolCfg[arg_15_1].affix)
	self.tipsLvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), ActivityAffixPoolCfg[arg_15_1].affix[2])
	self.tipsSubText_.text = ""

	self.buffList:Refresh()
	self.deBuffList:Refresh()
end

function AdvanceTest4AffixSelectView:IndexBuffItem(arg_16_1, arg_16_2)
	arg_16_2:RefreshUI(arg_16_1, self.affix_buff[arg_16_1], 0, table.indexof(self.select_affix, 0 + arg_16_1) ~= false, self.showSelectGen == 0 + arg_16_1)
	arg_16_2:RegisterClickListener(self.clickAffixHandler)
	arg_16_2:RegisterSelectListener(self.selectAffixHandler)
end

function AdvanceTest4AffixSelectView:IndexDeBuffItem(arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(arg_17_1, self.affix_debuff[arg_17_1], 1, table.indexof(self.select_affix, 100 + arg_17_1) ~= false, self.showSelectGen == 100 + arg_17_1)
	arg_17_2:RegisterClickListener(self.clickAffixHandler)
	arg_17_2:RegisterSelectListener(self.selectAffixHandler)
end

function AdvanceTest4AffixSelectView:IndexSelectItem(arg_18_1, arg_18_2)
	local var_18_0 = math.floor(self.select_affix[arg_18_1] / 100)

	arg_18_2:SetData(arg_18_1, ((var_18_0 == 0 or nil) and (self.affix_buff or self.affix_debuff))[self.select_affix[arg_18_1] % 100][1], var_18_0)
end

function AdvanceTest4AffixSelectView:ClickAffix(arg_19_1, arg_19_2, arg_19_3)
	if self.showSelectGen == arg_19_2 * 100 + arg_19_1 then
		self.showTipController:SetSelectedIndex(0)
		self:RefreshUI()

		self.showSelectGen = 0
	else
		self.showSelectGen = arg_19_2 * 100 + arg_19_1

		self:ShowTipsView(arg_19_3)
	end
end

function AdvanceTest4AffixSelectView:SelectAffix(arg_20_1, arg_20_2)
	local var_20_0 = table.indexof(self.select_affix, arg_20_2 * 100 + arg_20_1)

	if var_20_0 then
		table.remove(self.select_affix, var_20_0)
		self:RefreshUI()
	else
		if #self.select_affix >= self.maxSelect then
			ShowTips("PROFILE_LABEL_MAX_NUM")

			return
		end

		table.insert(self.select_affix, arg_20_2 * 100 + arg_20_1)
		self:RefreshUI()
	end
end

return AdvanceTest4AffixSelectView
