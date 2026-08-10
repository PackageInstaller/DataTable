local var_0_0 = class("QWorldSoundMgr")

function var_0_0.Init(arg_1_0)
	arg_1_0.defaultSound = {}
	arg_1_0.taskSoundList = {}
	arg_1_0.taskIndexMap = {}
	arg_1_0.curSound = {
		cueSheet = "",
		taskId = -1,
		index = -1,
		cueName = ""
	}
	arg_1_0.funcHandle = handler(arg_1_0, arg_1_0.OnQuestFinish)

	manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, arg_1_0.funcHandle)
end

function var_0_0.InitMapSound(arg_2_0, arg_2_1)
	local var_2_0 = SandPlayMapCfg[arg_2_1]

	arg_2_0.defaultSound = var_2_0.default_bgm
	arg_2_0.curSound.cueSheet = arg_2_0.defaultSound[1]
	arg_2_0.curSound.cueName = arg_2_0.defaultSound[2]
	arg_2_0.curSound.taskId = 0

	local var_2_1 = var_2_0.after_task_bgm
	local var_2_2 = 0

	if var_2_1 and var_2_1 ~= "" then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			var_2_2 = var_2_2 + 1

			table.insert(arg_2_0.taskSoundList, {
				taskId = iter_2_1[1],
				curSheet = iter_2_1[2],
				cueName = iter_2_1[3],
				isFinished = QWorldQuestTool.IsSubQuestFinish(iter_2_1[1])
			})

			if QWorldQuestTool.IsSubQuestFinish(iter_2_1[1]) then
				arg_2_0.curSound.cueSheet = iter_2_1[2]
				arg_2_0.curSound.cueName = iter_2_1[3]
				arg_2_0.curSound.taskId = iter_2_1[1]
				arg_2_0.curSound.index = var_2_2
			end

			arg_2_0.taskIndexMap[iter_2_1[1]] = var_2_2
		end
	end

	if arg_2_0.curSound.taskId ~= -1 then
		manager.audio:PlayBGM(arg_2_0.curSound.cueSheet, arg_2_0.curSound.cueName, arg_2_0.curSound.cueName)
	end
end

function var_0_0.OnQuestFinish(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.taskIndexMap[arg_3_1]

	if var_3_0 and var_3_0 > arg_3_0.curSound.index then
		local var_3_1 = arg_3_0.taskSoundList[var_3_0]

		arg_3_0.curSound.cueSheet = var_3_1.curSheet
		arg_3_0.curSound.cueName = var_3_1.cueName
		arg_3_0.curSound.taskId = var_3_1.taskId
		arg_3_0.curSound.index = var_3_0

		manager.audio:PlayBGM(arg_3_0.curSound.cueSheet, arg_3_0.curSound.cueName, arg_3_0.curSound.cueName)
	end
end

function var_0_0.Dispose(arg_4_0)
	manager.notify:RemoveListener(QWORLD_SUB_QUEST_FINISH, arg_4_0.funcHandle)
end

return var_0_0
