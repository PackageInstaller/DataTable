local AffixSelectDetailView = class("AffixSelectDetailView", ReduxView)

function AffixSelectDetailView:UIName()
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillDetailsUI"
end

function AffixSelectDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function AffixSelectDetailView:OnCtor()
	return
end

function AffixSelectDetailView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectDetailView:InitUI()
	self:BindCfgUI()

	self.bossIndexController_ = ControllerUtil.GetController(self.gameObject_.transform, "bossIndex")
	self.items_ = {}
end

function AffixSelectDetailView:AddUIListener()
	self:AddBtnListener(self.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectBossInfo", {
			bossIDList = self.cfg_.boss_id,
			index = self.params_.index
		})
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = self.cfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT,
			activityID = self.params_.activityId
		})
	end)
end

function AffixSelectDetailView:AddEventListeners()
	return
end

function AffixSelectDetailView:OnTop()
	self:UpdateBar()
end

function AffixSelectDetailView:OnBehind()
	manager.windowBar:HideBar()
end

function AffixSelectDetailView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AffixSelectDetailView:OnEnter()
	self:AddEventListeners()

	self.affixDic_ = {}
	self.cfg_ = ActivityAffixSelectCfg[self.params_.activityId]
	self.affixIdList_ = self.cfg_.pool
	self.data_ = ActivityAffixSelectData:GetSubActivityData(self.params_.activityId)
	self.selectedAffixList_ = self.data_.affixList

	self:UpdateAffixDic()
	self:UpdateView()
	self:UpdateGainScore()

	local var_13_0 = getData("affixSelect", "scrollPos" .. self.params_.activityId)

	self.itemScrollRect_.verticalNormalizedPosition = var_13_0 and var_13_0 or 1
end

function AffixSelectDetailView:OnExit()
	self:RemoveAllEventListener()
	ActivityAffixSelectAction.SetAffixList(self.params_.activityId, self.selectedAffixList_)
	saveData("affixSelect", "scrollPos" .. self.params_.activityId, self.itemScrollRect_.verticalNormalizedPosition)
	manager.windowBar:HideBar()
end

function AffixSelectDetailView:UpdateView()
	self.bossIndexController_:SetSelectedState(tostring(self.params_.index))

	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. self.cfg_.boss_id[1])
	self.highestScoreLabel_.text = self.data_.point

	for iter_15_0, iter_15_1 in ipairs(self.affixIdList_) do
		self.items_[iter_15_0] = self.items_[iter_15_0] or AffixSelectAffixItemView.New(Object.Instantiate(self.itemPrefab_, self.itemContainer_), handler(self, self.OnItemSelect))

		self.items_[iter_15_0]:SetData(iter_15_0, iter_15_1, (table.indexof(self.selectedAffixList_, iter_15_1) or nil) and true)
	end

	while #self.items_ > #self.affixIdList_ do
		self.items_[#self.items_]:Dispose()

		self.items_[#self.items_] = nil
	end

	self.enemyAffixLabel_.text = GetI18NText(getAffixDesc(self.cfg_.boss_affix))
	self.enemyAffixIcon_.sprite = getAffixSprite(self.cfg_.boss_affix)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemContainer_)
end

function AffixSelectDetailView:OnItemSelect(arg_16_1, arg_16_2)
	local var_16_0 = table.indexof(self.selectedAffixList_, arg_16_1)

	if arg_16_2 then
		local var_16_1

		if self.affixDic_[ActivityAffixPoolCfg[arg_16_1].affix[1]] ~= nil then
			var_16_1 = self.affixDic_[ActivityAffixPoolCfg[arg_16_1].affix[1]]
		end

		self.affixDic_[ActivityAffixPoolCfg[arg_16_1].affix[1]] = arg_16_1

		if not var_16_0 then
			table.insert(self.selectedAffixList_, arg_16_1)
		end

		if var_16_1 ~= nil then
			local var_16_2 = table.indexof(self.selectedAffixList_, var_16_1)

			if var_16_2 then
				table.remove(self.selectedAffixList_, var_16_2)
			end
		end
	else
		self.affixDic_[ActivityAffixPoolCfg[arg_16_1].affix[1]] = nil

		if var_16_0 then
			table.remove(self.selectedAffixList_, var_16_0)
		end
	end

	self:UpdateSelect()
	self:UpdateGainScore()
end

function AffixSelectDetailView:UpdateAffixDic()
	for iter_17_0, iter_17_1 in ipairs(self.selectedAffixList_) do
		self.affixDic_[ActivityAffixPoolCfg[iter_17_1].affix[1]] = iter_17_1
	end
end

function AffixSelectDetailView:UpdateSelect()
	for iter_18_0, iter_18_1 in ipairs(self.items_) do
		iter_18_1:SetSelect(not not table.indexof(self.selectedAffixList_, self.affixIdList_[iter_18_0]))
	end
end

function AffixSelectDetailView:UpdateGainScore()
	local var_19_0 = self.cfg_.base_point

	for iter_19_0, iter_19_1 in ipairs(self.selectedAffixList_) do
		var_19_0 = var_19_0 + ActivityAffixPoolCfg[iter_19_1].point
	end

	self.scoreLabel_.text = var_19_0
end

function AffixSelectDetailView:OnMainHomeViewTop()
	return
end

function AffixSelectDetailView:Dispose()
	for iter_21_0, iter_21_1 in ipairs(self.items_) do
		iter_21_1:Dispose()
	end

	self.items_ = {}

	AffixSelectDetailView.super.Dispose(self)
end

return AffixSelectDetailView
