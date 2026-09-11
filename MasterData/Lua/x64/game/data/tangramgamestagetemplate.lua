TangramGameStageTemplate = class("TangramGameStageTemplate")

function TangramGameStageTemplate:Ctor(arg_1_1)
	self.stageID = arg_1_1.stage_id
	self.stageType = ActivityTangramGameStageCfg[self.stageID].stage_type
	self.finishChipList = {}

	if arg_1_1.tips_id_list then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.tips_id_list) do
			table.insert(self.finishChipList, iter_1_1)
		end
	end

	self.isFin = false
	self.isWatch = arg_1_1.is_animation_finish or false

	self:UpdataFinState()
end

function TangramGameStageTemplate:UpdataStageProcess(arg_2_1)
	self.finishChipList = arg_2_1

	self:UpdataFinState()
end

function TangramGameStageTemplate:UpdataFinState()
	if self.stageType == TangramGameConst.stageType.thread or self.stageType == TangramGameConst.stageType.specialThread then
		if #self.finishChipList == ActivityTangramGameStageCfg[self.stageID].clue_num then
			self.isFin = true

			manager.notify:Invoke(TANGRAM_GAME_STAGE_CLEAR, self.stageID)
		end
	elseif self.stageType == TangramGameConst.stageType.decode then
		self.isFin = true

		for iter_3_0, iter_3_1 in ipairs(ActivityTangramGameStageCfg[self.stageID].answer) do
			if iter_3_1 ~= self.finishChipList[iter_3_0] then
				self.isFin = false

				break
			end
		end
	end
end

function TangramGameStageTemplate:GetInferenceStageWatchPlay()
	if self.stageType == TangramGameConst.stageType.decode then
		return self.isWatch
	else
		Debug.LogError("非推理关卡" .. self.stageID)
	end
end
