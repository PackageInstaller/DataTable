class = var_0_10000

local var_0_0 = "NewEducateGetTalentsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29019, {
		id = var_1_1
	}, 29020, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.SetSystemNo

			NewEducateFSM = var_2_10004

			var_2_3(var_2_2, var_2_10004.SYSTEM.TALENT)

			NewEducateTalentState = var_2_3

			local var_2_4 = var_2_3.New({
				finished = 0,
				talents = arg_2_0.talents,
				retalents = {}
			})
			local var_2_5 = var_1
			local var_2_6 = var_1.SetState

			NewEducateFSM = var_2_10005

			var_2_6(var_2_5, var_2_10005.SYSTEM.TALENT, var_2_4)

			local var_2_8

			if #arg_2_0.talents == 0 then
				var_2_5 = var_2_4

				var_2_4.MarkFinish(var_2_5)
			else
				getProxy = var_2_8
				NewEducateProxy = var_2_5

				local var_2_7 = var_2_8(var_2_5)

				var_2_8 = var_2_8.GetCurChar(var_2_7)
				pg = var_2_7

				local var_2_9 = var_2_7.m02
				local var_2_10 = var_4.sendNotification

				GAME = var_6

				local var_2_11 = var_6.NEW_EDUCATE_TRACK

				NewEducateTrackCommand = var_2_10007

				local var_2_12 = var_2_10007.BuildDataTalent
				local var_2_13 = var_2_8.id
				local var_2_14 = var_2_8:GetGameCnt()
				local var_2_15 = var_2_8:GetRoundData().round
				local var_2_16 = 1
				local var_2_17 = 0

				table = var_2_10013

				var_2_10(var_2_9, var_2_11, var_2_12(var_2_13, var_2_14, var_2_15, var_2_16, var_2_17, var_2_10013.concat(arg_2_0.talents, ",")))
			end

			existCall = var_2_8

			var_2_8(var_1_0)
		else
			pg = var_1

			local var_2_18 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_18, "NewEducate_GetTalents: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
