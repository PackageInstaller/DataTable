ChapterPlot19MapBaseLocation = import(".ChapterPlot19MapBaseLocation")

local ChapterPlot19MapClue = class("ChapterPlot19MapClue", ChapterPlot19MapBaseLocation)

function ChapterPlot19MapClue:Ctor(arg_1_1, arg_1_2)
	ChapterPlot19MapClue.super.Ctor(self, arg_1_1, arg_1_2)

	self.controller_ = self.controllerEx_:GetController("clue")
	self.onOpenClueInfoHandler_ = handler(self, self.OnOpenClueInfo)

	manager.notify:RegistListener(CHAPTER_GET_CLUE, self.onOpenClueInfoHandler_)
end

function ChapterPlot19MapClue:Dispose()
	manager.notify:RemoveListener(CHAPTER_GET_CLUE, self.onOpenClueInfoHandler_)

	self.onOpenClueInfoHandler_ = nil

	ChapterPlot19MapClue.super.Dispose(self)
end

function ChapterPlot19MapClue:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if not ChapterTools.IsEnableLocation(self.locationID_) then
			return
		end

		local var_4_0 = ChapterLocationCfg[self.locationID_]

		if ChapterLocationCfg[self.locationID_].need_scan == 0 then
			BattleStageAction.ReadLoacationClue(self.mapID_, self.locationID_, var_4_0.clue[1])
			JumpTools.OpenPageByJump("stageArchive", {
				isClue = true,
				archiveID = var_4_0.clue[1]
			})
		elseif var_4_0.type == BattleConst.LOCATION_TYPE.CLUE then
			if ChapterTools.IsReadClue(self.mapID_, self.locationID_) then
				local var_4_1 = BattleStageData:GetMapLocationData(self.mapID_)[self.locationID_] or var_4_0.clue[1]

				JumpTools.OpenPageByJump("stageArchive", {
					isClue = true,
					archiveID = var_4_1
				})

				return
			end

			BattleStageAction.GetClueLocation(self.locationID_)
		elseif var_4_0.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
			ChapterTools.DoReadyBattle(ChapterCfg[self.chapterID_].type, var_4_0.sub_stage_list[1])
		end
	end)
end

function ChapterPlot19MapClue:UpdateLocation()
	ChapterPlot19MapClue.super.UpdateLocation(self)

	if ChapterTools.IsReadClue(self.mapID_, self.locationID_) then
		self.controller_:SetSelectedState("state2")
	elseif ChapterLocationCfg[self.locationID_].type == BattleConst.LOCATION_TYPE.CLUE then
		self.controller_:SetSelectedState("state0")
	else
		self.controller_:SetSelectedState("state1")
	end
end

function ChapterPlot19MapClue:OnOpenClueInfo(arg_6_1)
	if arg_6_1 ~= self.locationID_ then
		return
	end

	self:UpdateLocation()
	JumpTools.OpenPageByJump("stageArchive", {
		archiveID = BattleStageData:GetMapLocationData(self.mapID_)[self.locationID_]
	})
end

function ChapterPlot19MapClue:Show(arg_7_1)
	ChapterPlot19MapClue.super.Show(self, arg_7_1)

	if arg_7_1 and self.needRefreshAnimaor_ then
		self.animator_:Play("verClue", -1, 0)
	end

	self.needRefreshAnimaor_ = false
end

return ChapterPlot19MapClue
