local TowerSelectionInfoView = class("TowerSelectionInfoView", import("..SectionInfoBaseView"))

function TowerSelectionInfoView:Init()
	TowerSelectionInfoView.super.Init(self)
	self.hideStageDescController_:SetSelectedState("false")
	self.hideDropPanelController_:SetSelectedState("false")
	self.guildStateController_:SetSelectedState("hide")
	self.hideFatigueController_:SetSelectedState("close")
end

function TowerSelectionInfoView:OnEnter()
	self.towerId_ = self.params_.towerId
	self.curId = self.params_.curId
	self.clickBackFunc_ = self.params_.clickBackFunc
	self.btnTips_ = self.params_.btnTips

	self:RefreshData()
	self:RefreshUI()

	self.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER

	self:RefreshTitleDesc()
end

function TowerSelectionInfoView:OnUpdate()
	if self.towerId_ == self.params_.towerId then
		return
	end

	self.towerId_ = self.params_.towerId
	self.btnTips_ = self.params_.btnTips

	self:RefreshData()
	self:RefreshUI()
end

function TowerSelectionInfoView:RefreshData()
	self.cfg_ = BattleTowerStageCfg[self.towerId_]
	self.lock_ = false
	self.lockTips_ = ""
	self.cost_ = 0
	self.dropLibID_ = self.cfg_.drop_lib_id
	self.isFirstClear_ = self.curId and self.towerId_ >= self.curId
end

function TowerSelectionInfoView:RefreshUI()
	self:RefreshReward()

	self.sectionName_.text = GetI18NText(self.cfg_.name)
	self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.cfg_.background_1))
	self.storyText_.text = GetI18NText(self.cfg_.tips)
	self.btnText_.text = self.btnTips_
end

function TowerSelectionInfoView:OnClickBtn()
	if not self.curId or self.towerId_ <= self.curId then
		local var_6_0 = BattleTowerStageCfg[self.towerId_].level

		if BattleTowerStageCfg[self.towerId_].level <= PlayerData:GetPlayerInfo().userLevel then
			JumpTools.Back()
			self:Go("/sectionSelectHero", {
				section = self.towerId_,
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER
			})
		else
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_6_0))
		end
	else
		self.clickBackFunc_()
	end
end

function TowerSelectionInfoView:Dispose()
	TowerSelectionInfoView.super.Dispose(self)
end

return TowerSelectionInfoView
