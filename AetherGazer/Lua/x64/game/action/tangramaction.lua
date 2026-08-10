local var_0_0 = {
	DecodeGameInfo = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			return {
				stageID = arg_1_1.stage_id,
				answerList = arg_1_1.tips_id_list
			}
		end
	end
}

manager.net:Bind(86008, function(arg_2_0)
	TangramGameData:InitTrangraData(arg_2_0)
	TangramGameTools:UpdataGlobalRedPoint()
end)

local var_0_1

function var_0_0.SaveStageProcess(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = TangramGameData:GetCurRunGameActivityID()

	var_0_1 = arg_3_3

	if var_3_0 and arg_3_1 and arg_3_2 then
		manager.net:SendWithLoadingNew(86006, {
			activity_id = var_3_0,
			stage_id = arg_3_1,
			tips_id_list = arg_3_2
		}, 86007, var_0_0.SaveStageProcessCallBack)
	end
end

function var_0_0.SaveStageProcessCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		local var_4_0 = TangramGameData:GetStageInfoByStageID(arg_4_1.stage_id)

		if var_4_0 then
			local var_4_1 = {}

			for iter_4_0, iter_4_1 in ipairs(arg_4_1.tips_id_list) do
				table.insert(var_4_1, iter_4_1)
			end

			var_4_0:UpdataStageProcess(var_4_1)
		end

		TangramGameTools:UpdataDecodeStageRedPoint()
		TangramGameTools:UpdataNewStageRedPoint(arg_4_1.stage_id)

		if var_0_1 then
			var_0_1()
		end
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.SaveStageWatch(arg_5_0, arg_5_1)
	local var_5_0 = TangramGameData:GetCurRunGameActivityID()

	manager.net:SendWithLoadingNew(86009, {
		activity_id = var_5_0,
		stage_id = arg_5_1
	}, 86010, var_0_0.SaveStageWatchCallBack)
end

function var_0_0.SaveStageWatchCallBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		TangramGameData:GetStageInfoByStageID(arg_6_1.stage_id).isWatch = true
	else
		ShowTips(arg_6_0.result)
	end
end

return var_0_0
