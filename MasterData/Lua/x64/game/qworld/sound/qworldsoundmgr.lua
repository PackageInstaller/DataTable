local QWorldSoundMgr = class("QWorldSoundMgr")

function QWorldSoundMgr:Init()
	self.defaultSound = {}
	self.taskSoundList = {}
	self.taskIndexMap = {}
	self.curSound = {
		cueSheet = "",
		taskId = -1,
		index = -1,
		cueName = ""
	}
	self.funcHandle = handler(self, self.OnQuestFinish)

	manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, self.funcHandle)
end

function QWorldSoundMgr:InitMapSound(arg_2_1)
	self.defaultSound = SandPlayMapCfg[arg_2_1].default_bgm
	self.curSound.cueSheet = self.defaultSound[1]
	self.curSound.cueName = self.defaultSound[2]
	self.curSound.taskId = 0

	local var_2_0 = 0

	if SandPlayMapCfg[arg_2_1].after_task_bgm and SandPlayMapCfg[arg_2_1].after_task_bgm ~= "" then
		for iter_2_0, iter_2_1 in ipairs(SandPlayMapCfg[arg_2_1].after_task_bgm) do
			var_2_0 = var_2_0 + 1

			table.insert(self.taskSoundList, {
				taskId = iter_2_1[1],
				curSheet = iter_2_1[2],
				cueName = iter_2_1[3],
				isFinished = QWorldQuestTool.IsSubQuestFinish(iter_2_1[1])
			})

			if QWorldQuestTool.IsSubQuestFinish(iter_2_1[1]) then
				self.curSound.cueSheet = iter_2_1[2]
				self.curSound.cueName = iter_2_1[3]
				self.curSound.taskId = iter_2_1[1]
				self.curSound.index = var_2_0
			end

			self.taskIndexMap[iter_2_1[1]] = var_2_0
		end
	end

	if self.curSound.taskId ~= -1 then
		manager.audio:PlayBGM(self.curSound.cueSheet, self.curSound.cueName, self.curSound.cueName)
	end
end

function QWorldSoundMgr:OnQuestFinish(arg_3_1)
	if self.taskIndexMap[arg_3_1] and self.taskIndexMap[arg_3_1] > self.curSound.index then
		self.curSound.cueSheet = self.taskSoundList[self.taskIndexMap[arg_3_1]].curSheet
		self.curSound.cueName = self.taskSoundList[self.taskIndexMap[arg_3_1]].cueName
		self.curSound.taskId = self.taskSoundList[self.taskIndexMap[arg_3_1]].taskId
		self.curSound.index = self.taskIndexMap[arg_3_1]

		manager.audio:PlayBGM(self.curSound.cueSheet, self.curSound.cueName, self.curSound.cueName)
	end
end

function QWorldSoundMgr:Dispose()
	manager.notify:RemoveListener(QWORLD_SUB_QUEST_FINISH, self.funcHandle)
end

return QWorldSoundMgr
