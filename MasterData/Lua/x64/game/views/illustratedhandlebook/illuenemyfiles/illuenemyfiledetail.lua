local IlluEnemyFileDetail = class("IlluEnemyFileDetail", ReduxView)

function IlluEnemyFileDetail:UIName()
	return "Widget/System/IllustratedHandbook/IlluEnemyDetailUI"
end

function IlluEnemyFileDetail:UIParent()
	return manager.ui.uiMain.transform
end

function IlluEnemyFileDetail:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemList_ = {}
	self.conList_ = {}
	self.infoList_ = {}
	self.skillList_ = {}
end

function IlluEnemyFileDetail:InitUI()
	self:BindCfgUI()

	self.enemyAvatarView_ = EnemyAvatarView.New(self, self.displayGo_)
	self.riskCon_ = ControllerUtil.GetController(self.transform_, "conName")
	self.toggleController_ = self.bossInfo_.transform:GetComponent("ControllerExCollection"):GetController("toggle")
end

function IlluEnemyFileDetail:AddUIListener()
	self:AddBtnListener(self.dataBtn_, nil, function()
		self.toggleController_:SetSelectedState("data")
		self:RefreshInfo()
	end)
	self:AddBtnListener(self.skillBtn_, nil, function()
		self.toggleController_:SetSelectedState("skill")
		self:RefreshSkill()
	end)
end

function IlluEnemyFileDetail:RefreshUI()
	self.nameText_.text = GetMonsterName({
		self.id_
	})
	self.raceText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.id_].race)
	self.descText_.text = GetI18NText(MonsterCfg[self.id_].desc)

	self.riskCon_:SetSelectedState(MonsterCfg[self.id_].type)
	self:UpdateData()
	self.toggleController_:SetSelectedState("data")
	self:RefreshInfo()
end

function IlluEnemyFileDetail:RefreshInfo()
	for iter_9_0 = 1, 3 do
		self:UpdateItem(iter_9_0, self.infoList_[iter_9_0])
	end

	for iter_9_1 = 4, #self.itemList_ do
		self.itemList_[iter_9_1]:Hide()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function IlluEnemyFileDetail:RefreshSkill()
	for iter_10_0 = 1, 6 do
		self:UpdateItem(iter_10_0, self.skillList_[iter_10_0])
	end

	for iter_10_1 = 1, 6 do
		if string.len(self.skillList_[iter_10_1].name) == 0 then
			self.itemList_[iter_10_1]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function IlluEnemyFileDetail:UpdateItem(arg_11_1, arg_11_2)
	self.itemList_[arg_11_1] = self.itemList_[arg_11_1] or IlluEnemyFileDetailItem.New((Object.Instantiate(self.itemGo_, self.contentTrs_)))

	self.itemList_[arg_11_1]:RefreshUI(arg_11_2)
end

function IlluEnemyFileDetail:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.ui:SetMainCamera("enemyFile")

	self.id_ = self.params_.id

	self.enemyAvatarView_:OnEnter()
	self.enemyAvatarView_:SetBossID(self.id_)
	self:RefreshUI()
end

function IlluEnemyFileDetail:OnExit()
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()
	self.enemyAvatarView_:OnExit()
end

function IlluEnemyFileDetail:UpdateData()
	self.infoList_ = {}
	self.skillList_ = {}

	for iter_14_0 = 1, 3 do
		self.infoList_[iter_14_0] = {
			isLock = false,
			name = string.format(GetTips("MONSTER_INFORMATION") .. iter_14_0),
			info = MonsterCfg[self.id_]["information" .. iter_14_0]
		}
	end

	for iter_14_1 = 1, 6 do
		self.skillList_[iter_14_1] = {
			isLock = false,
			name = MonsterCfg[self.id_]["skill" .. iter_14_1],
			info = MonsterCfg[self.id_]["skill_desc" .. iter_14_1]
		}
	end
end

function IlluEnemyFileDetail:Dispose()
	self.enemyAvatarView_:Dispose()

	self.enemyAvatarView_ = nil

	for iter_15_0, iter_15_1 in ipairs(self.itemList_) do
		iter_15_1:Dispose()
	end

	IlluEnemyFileDetail.super.Dispose(self)
end

return IlluEnemyFileDetail
