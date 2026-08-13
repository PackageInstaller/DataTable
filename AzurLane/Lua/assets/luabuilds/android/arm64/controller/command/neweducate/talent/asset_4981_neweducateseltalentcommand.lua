class = var_0_10000

local var_0_0 = "NewEducateSelTalentCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.talentId
	local var_1_2 = var_2.idx

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 29023, {
		id = var_1_0,
		talent = var_1_1
	}, 29024, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_2.GetFSM(var_2_1)
			local var_2_3 = var_3.GetState

			NewEducateFSM = var_2_10006

			local var_2_4 = var_2_3(var_2_2, var_2_10006.SYSTEM.TALENT)

			var_3.MarkFinish(var_2_4)

			NewEducateDropHelper = var_4

			local var_2_5 = var_4.HandleDrops(arg_2_0.drop)
			local var_2_6 = arg_1_0
			local var_2_7 = var_5.sendNotification

			GAME = var_2_10008

			var_2_7(var_2_6, var_2_10008.NEW_EDUCATE_SEL_TALENT_DONE, {
				idx = var_1_2,
				drops = var_2_5
			})

			getProxy = var_2_7
			NewEducateProxy = var_2_6

			local var_2_8 = var_2_7(var_2_6)
			local var_2_9 = var_5.GetCurChar(var_2_8)

			pg = var_6

			local var_2_10 = var_6.m02
			local var_2_11 = var_6.sendNotification

			GAME = var_9

			local var_2_12 = var_9.NEW_EDUCATE_TRACK

			NewEducateTrackCommand = var_10

			local var_2_13 = var_10.BuildDataTalent
			local var_2_14 = var_2_9.id
			local var_2_15 = var_2_9:GetGameCnt()
			local var_2_16 = var_2_9:GetRoundData().round
			local var_2_17 = 2
			local var_2_18 = var_1_1

			table = var_2_10017

			var_2_11(var_2_10, var_2_12, var_2_13(var_2_14, var_2_15, var_2_16, var_2_17, var_2_18, var_2_10017.concat(var_3:GetTalents(), ",")))
		else
			pg = var_1

			local var_2_19 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_19, "NewEducate_SelTalent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
