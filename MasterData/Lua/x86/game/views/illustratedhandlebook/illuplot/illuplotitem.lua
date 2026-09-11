local IlluPlotItem = class("IlluPlotItem", ReduxView)

function IlluPlotItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluPlotItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluPlotItem:InitUI()
	self:BindCfgUI()

	self.iconImg_.cacheLimit = 3
	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
	self.lockController_ = ControllerUtil.GetController(self.gameObject_.transform, "lock")
end

function IlluPlotItem:RefreshUI(arg_4_1, arg_4_2)
	self.info_ = arg_4_1
	self.selType_ = arg_4_2

	table.sort(self.info_.storyList)

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(self.info_.storyList) do
		if IllustratedData:GetPlotInfo()[iter_4_1] then
			var_4_0 = var_4_0 + 1
		elseif iter_4_1 == 101110501 and IllustratedData:GetPlotInfo()[101110401] then
			var_4_0 = var_4_0 + 1
		end
	end

	self.unlockNum_ = var_4_0

	if var_4_0 == 0 then
		self.controller_:SetSelectedState("0")
	else
		self.controller_:SetSelectedState("1")

		if arg_4_2 == 1 then
			self.nameText_.text = GetI18NText(ChapterClientCfg[ChapterCfg[arg_4_1.chapterID].clientID].name)
			self.reveiveText_.text = var_4_0 .. "/" .. arg_4_1.all
			self.iconImg_.spriteAsync = SpritePathCfg.CollectPlotSmall.path .. ChapterClientCfg[arg_4_1.chapterID].chapter_paint

			if self.info_.chapterID and ChapterClientCfg[self.info_.chapterID] then
				if not manager.assetPend:CheckAssetPend(ChapterClientCfg[self.info_.chapterID].asset_pend_key) then
					self.lockController_:SetSelectedState("assetpend")
				else
					self.lockController_:SetSelectedState("false")
				end
			else
				self.lockController_:SetSelectedState("false")
			end
		elseif arg_4_2 == 2 then
			self.nameText_.text = GetI18NText(ActivityCfg[arg_4_1.chapterID].remark)
			self.reveiveText_.text = var_4_0 .. "/" .. arg_4_1.all
			self.iconImg_.spriteAsync = SpritePathCfg.CollectPlotSmall.path .. CollectStoryCfg[CollectStoryCfg.get_id_list_by_activity[arg_4_1.chapterID][1]].picture

			self.lockController_:SetSelectedState("false")
		elseif arg_4_2 == 3 then
			self.nameText_.text = GetI18NText(StoryCfg[self.info_.storyList[1]].name)
			self.reveiveText_.text = var_4_0 .. "/" .. arg_4_1.all
			self.iconImg_.spriteAsync = SpritePathCfg.CollectPlotSmall.path .. CollectStoryCfg[self.info_.storyList[1]].picture

			self.lockController_:SetSelectedState("false")
		end
	end
end

function IlluPlotItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.selType_ == 1 then
			if self.info_.chapterID and ChapterClientCfg[self.info_.chapterID] then
				if not manager.assetPend:CheckAssetPend(ChapterClientCfg[self.info_.chapterID].asset_pend_key) then
					manager.assetPend:ShowAssetPendMessageBox(ChapterClientCfg[self.info_.chapterID].asset_pend_key)

					return
				end
			end
		end

		if self.unlockNum_ > 0 then
			JumpTools.OpenPageByJump("/illuPlotDetail", {
				storyList = self.info_.storyList,
				chapterID = self.info_.chapterID,
				selType = self.selType_
			})
		elseif self.selType_ == 1 then
			local var_6_0 = getStageViaStoryID(self.info_.storyList[1])
			local var_6_1, var_6_2 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(var_6_0).toggle, var_6_0)

			ShowTips((string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(var_6_0), GetI18NText(var_6_1), GetI18NText(var_6_2))))
		end
	end)
end

function IlluPlotItem:Dispose()
	IlluPlotItem.super.Dispose(self)
end

return IlluPlotItem
