local AbyssBossDetailItemView = class("AbyssBossDetailItemView", ReduxView)

function AbyssBossDetailItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssBossDetailItemView:Init()
	self.itemList_ = {}
	self.skillList_ = {}

	self:InitUI()
	self:AddUIListener()
end

function AbyssBossDetailItemView:InitUI()
	self:BindCfgUI()
end

function AbyssBossDetailItemView:AddUIListener()
	return
end

function AbyssBossDetailItemView:AddEventListeners()
	return
end

function AbyssBossDetailItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.id_ = arg_6_2
	self.monsterCollectId_ = AbyssUICfg[self.id_].enemy_id

	self:UpdateView()
end

function AbyssBossDetailItemView:UpdateView()
	self.nameText_.text = GetMonsterName({
		self.monsterCollectId_
	})
	self.raceText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.monsterCollectId_].race)
	self.riskText_.text = NumberTools.IntToRomam(MonsterCfg[self.monsterCollectId_].type + 1)
	self.portraitImage_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. self.monsterCollectId_)

	self:UpdateData()
	self:RefreshSkill()
end

function AbyssBossDetailItemView:UpdateData()
	self.skillList_ = GetMonsterSkillDesList({
		self.monsterCollectId_
	})
end

function AbyssBossDetailItemView:RefreshSkill()
	for iter_9_0 = 1, 6 do
		if self.skillList_[iter_9_0] then
			self:UpdateItem(iter_9_0, self.skillList_[iter_9_0])
		elseif self.itemList_[iter_9_0] then
			self.itemList_[iter_9_0]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function AbyssBossDetailItemView:UpdateItem(arg_10_1, arg_10_2)
	self.itemList_[arg_10_1] = self.itemList_[arg_10_1] or AffixSelectBossInfoItem.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

	self.itemList_[arg_10_1]:RefreshUI(arg_10_2)
end

function AbyssBossDetailItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssBossDetailItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssBossDetailItemView:OnMainHomeViewTop()
	return
end

function AbyssBossDetailItemView:Dispose()
	for iter_14_0, iter_14_1 in pairs(self.itemList_) do
		iter_14_1:Dispose()
	end

	self.itemList_ = nil
	self.data_ = nil

	AbyssBossDetailItemView.super.Dispose(self)
end

return AbyssBossDetailItemView
