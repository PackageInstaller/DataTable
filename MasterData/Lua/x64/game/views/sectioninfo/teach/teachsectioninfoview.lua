local TeachSectionInfoView = class("TeachSectionInfoView", SectionInfoBaseView)

function TeachSectionInfoView:UpdateBar()
	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
end

function TeachSectionInfoView:OnUpdate()
	if self.stageID_ == self.params_.section then
		return
	end

	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	self:RefreshData()
	self:RefreshUI()
end

function TeachSectionInfoView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		self:OnClickBtn()
	end)
	self:AddBtnListener(self.buttonWeb_, nil, function()
		if not SDKTools.IsSDK() then
			OperationAction.OpenNormalUrl(TeachStageExInfoCfg[self.stageID_].video_url)
		else
			LuaForUtil.OpenWebView(TeachStageExInfoCfg[self.stageID_].video_url, true, function()
				manager.audio:PauseAll(true)
				print("--->> open webView")
			end, function()
				print("====>>> close webView")
				manager.audio:PauseAll(false)
			end)
		end

		SDKTools.SendMessageToSDK("lecture_video", {
			channel_type = 2,
			videro_channel = self.stageID_
		})
	end)
end

function TeachSectionInfoView:RefreshUI()
	TeachSectionInfoView.super.RefreshUI(self)
	self:RefreshVideoUI()
	self.hideFatigueController_:SetSelectedState("close")
end

function TeachSectionInfoView:RefreshData()
	local var_9_0

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == self.stageType_ then
		var_9_0 = BattleBaseTeachStageCfg[self.stageID_]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == self.stageType_ then
		var_9_0 = BattleHeroTeachStageCfg[self.stageID_]
	end

	self.stageCfg_ = var_9_0
	self.lock_ = false
	self.lockTips_ = ""
	self.cost_ = 0
	self.isFirstClear_ = (BattleTeachData:GetStageData()[self.stageID_] or 0) <= 0

	if self.stageCfg_ then
		self.dropLibID_ = self.stageCfg_.drop_lib_id or 0
	end

	BattleFieldData:SetCacheStage(getChapterAndSectionID(self.stageID_), self.stageID_)
	self.hideStageDescController_:SetSelectedState("false")
end

function TeachSectionInfoView:RefreshVideoUI()
	local var_10_0 = TeachStageExInfoCfg[self.stageID_]

	if SDKTools.GetIsOverSea() then
		self.btnWebController_:SetSelectedState("notshow")
	elseif not not (var_10_0 and var_10_0.video_url ~= "") then
		self.btnWebController_:SetSelectedState("show")
	else
		self.btnWebController_:SetSelectedState("notshow")
	end
end

function TeachSectionInfoView:RefreshStageInfo()
	local var_11_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if self.oldCfgID_ ~= var_11_0.id then
		local var_11_1, var_11_2 = BattleStageTools.GetChapterSectionIndex(self.stageType_, self.stageID_)

		self.sectionText_.text = string.format("%s-%s", GetI18NText(var_11_1), GetI18NText(var_11_2))
		self.sectionName_.text = GetI18NText(var_11_0.name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_11_0.background_1))
		self.oldCfgID_ = var_11_0.id
		self.storyText_.text = GetI18NText(var_11_0.tips)
	end
end

function TeachSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.stageID_,
		sectionType = self.stageType_
	})
end

return TeachSectionInfoView
