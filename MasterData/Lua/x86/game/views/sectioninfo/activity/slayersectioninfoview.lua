SectionInfoBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local SlayerSectionInfoView = class("SlayerSectionInfoView", SectionInfoBaseView)

function SlayerSectionInfoView:InitUI()
	SlayerSectionInfoView.super.InitUI(self)
	SetActive(self.tipsPanel_, true)

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")

	self.controller_:SetSelectedState("slayer")

	if self.readyTxt_ then
		self.readyTxt_.text = GetTips("BATTLE_READY_1")
	end

	self.slayerComs = {}

	ComponentBinder.GetInstance():BindCfgUI(self.slayerComs, self.slayerPanel_)

	self.slayerBuffList = {}

	SetActive(self.resourcePanel_, false)
end

function SlayerSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		sectionType = self.stageType_,
		region_activity_id = self.params_.region_activity_id,
		activityID = self.params_.slayer_activity_id
	})
end

function SlayerSectionInfoView:RefreshData()
	SlayerSectionInfoView.super.RefreshData(self)

	local var_3_0 = BattleSlayerStageCfg[self.stageID_]

	self.lock_ = PlayerData:GetPlayerInfo().userLevel < BattleSlayerStageCfg[self.stageID_].level
	self.lockTips_ = string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_3_0.level)
	self.cost = 0
	self.drop_lib_id = 0
	self.isFirstClear_ = false
end

function SlayerSectionInfoView:RefreshStageInfo()
	if self.oldCfgID_ ~= BattleSlayerStageCfg[self.stageID_].id then
		self.sectionName_.text = GetI18NText(BattleSlayerStageCfg[self.stageID_].name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, BattleSlayerStageCfg[self.stageID_].background_1))
		self.slayerComs.m_tips.text = GetI18NText(BattleSlayerStageCfg[self.stageID_].tips)
		self.oldCfgID_ = BattleSlayerStageCfg[self.stageID_].id
	end

	local var_4_0 = self.params_.region_activity_id
	local var_4_1 = self.params_.slayer_activity_id

	if ActivitySlayerCfg[self.params_.region_activity_id] then
		self.buffData = ActivitySlayerCfg[self.params_.region_activity_id].buff_desc or {}
	end

	for iter_4_0 = 1, #self.buffData do
		self.slayerBuffList[iter_4_0] = self.slayerBuffList[iter_4_0] or SlayerSectionItem.New((Object.Instantiate(self.slayerComs.m_buffItem, self.slayerComs.m_buffParent)))

		self.slayerBuffList[iter_4_0]:SetData(self.buffData[iter_4_0])
		self.slayerBuffList[iter_4_0]:SetActive(true)
	end

	for iter_4_1 = #self.buffData + 1, #self.slayerBuffList do
		self.slayerBuffList[iter_4_1]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.slayerComs.m_buffParent)

	self.slayerComs.m_maxScore.text = SlayerData:GetPoint(var_4_1, var_4_0)
	self.slayerComs.m_scrollView.verticalNormalizedPosition = 1
end

function SlayerSectionInfoView:Dispose()
	for iter_5_0, iter_5_1 in ipairs(self.slayerBuffList) do
		iter_5_1:Dispose()
	end

	self.slayerBuffList = {}

	SlayerSectionInfoView.super.Dispose(self)
end

return SlayerSectionInfoView
