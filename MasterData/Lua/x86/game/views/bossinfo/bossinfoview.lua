local BossInfoView = class("BossInfoView", ReduxView)

function BossInfoView:UIName()
	return "UI/BossInfoUI"
end

function BossInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function BossInfoView:OnCtor()
	return
end

function BossInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BossInfoView:InitUI()
	self:BindCfgUI()

	self.itemList_ = {}
	self.skillList_ = {}
end

function BossInfoView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
end

function BossInfoView:AddEventListeners()
	return
end

function BossInfoView:OnTop()
	self:UpdateBar()
end

function BossInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function BossInfoView:UpdateBar()
	manager.windowBar:HideBar()
end

function BossInfoView:OnEnter()
	self:AddEventListeners()

	self.id_ = self.params_.bossID

	self:UpdateView()
end

function BossInfoView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function BossInfoView:UpdateView()
	self.nameText_.text = GetMonsterName({
		self.id_
	})
	self.raceText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.id_].race)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(self.params_.spritePath)
	self.riskText_.text = NumberTools.IntToRomam(MonsterCfg[self.id_].type + 1)

	self:UpdateData()
	self:RefreshSkill()
end

function BossInfoView:UpdateData()
	self.skillList_ = GetMonsterSkillDesList({
		self.id_
	})
end

function BossInfoView:RefreshSkill()
	for iter_16_0 = 1, 6 do
		if self.skillList_[iter_16_0] then
			self:UpdateItem(iter_16_0, self.skillList_[iter_16_0])
		elseif self.itemList_[iter_16_0] then
			self.itemList_[iter_16_0]:Hide()
		end
	end

	self.scrollviewSr_.normalizedPosition = Vector2(0, 1)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function BossInfoView:UpdateItem(arg_17_1, arg_17_2)
	self.itemList_[arg_17_1] = self.itemList_[arg_17_1] or BossInfoItemView.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

	self.itemList_[arg_17_1]:RefreshUI(arg_17_2)
end

function BossInfoView:OnMainHomeViewTop()
	return
end

function BossInfoView:Dispose()
	for iter_19_0, iter_19_1 in ipairs(self.itemList_) do
		iter_19_1:Dispose()
	end

	BossInfoView.super.Dispose(self)
end

return BossInfoView
