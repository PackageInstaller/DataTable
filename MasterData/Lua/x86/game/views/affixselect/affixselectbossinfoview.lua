local AffixSelectBossInfoView = class("AffixSelectBossInfoView", ReduxView)

function AffixSelectBossInfoView:UIName()
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillBossInfoUI"
end

function AffixSelectBossInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function AffixSelectBossInfoView:OnCtor()
	return
end

function AffixSelectBossInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AffixSelectBossInfoView:InitUI()
	self:BindCfgUI()

	self.itemList_ = {}
	self.skillList_ = {}
end

function AffixSelectBossInfoView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function AffixSelectBossInfoView:AddEventListeners()
	return
end

function AffixSelectBossInfoView:OnTop()
	self:UpdateBar()
end

function AffixSelectBossInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function AffixSelectBossInfoView:UpdateBar()
	manager.windowBar:HideBar()
end

function AffixSelectBossInfoView:OnEnter()
	self:AddEventListeners()

	self.bossIDList_ = self.params_.bossIDList

	self:UpdateView()
end

function AffixSelectBossInfoView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AffixSelectBossInfoView:UpdateView()
	self.nameText_.text = GetMonsterName(self.bossIDList_)
	self.raceText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.bossIDList_[1]].race)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/VersionUI/DarkFlameUI/Boss_QualsDrill/DarkFlame_boss_0000%s", self.params_.index))
	self.riskText_.text = NumberTools.IntToRomam(MonsterCfg[self.bossIDList_[1]].type + 1)

	self:UpdateData()
	self:RefreshSkill()
end

function AffixSelectBossInfoView:UpdateData()
	self.skillList_ = GetMonsterSkillDesList(self.bossIDList_)
end

function AffixSelectBossInfoView:RefreshSkill()
	for iter_16_0 = 1, 6 do
		if self.skillList_[iter_16_0] then
			self:UpdateItem(iter_16_0, self.skillList_[iter_16_0])
		elseif self.itemList_[iter_16_0] then
			self.itemList_[iter_16_0]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function AffixSelectBossInfoView:UpdateItem(arg_17_1, arg_17_2)
	self.itemList_[arg_17_1] = self.itemList_[arg_17_1] or AffixSelectBossInfoItem.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

	self.itemList_[arg_17_1]:RefreshUI(arg_17_2)
end

function AffixSelectBossInfoView:OnMainHomeViewTop()
	return
end

function AffixSelectBossInfoView:Dispose()
	for iter_19_0, iter_19_1 in ipairs(self.itemList_) do
		iter_19_1:Dispose()
	end

	AffixSelectBossInfoView.super.Dispose(self)
end

return AffixSelectBossInfoView
