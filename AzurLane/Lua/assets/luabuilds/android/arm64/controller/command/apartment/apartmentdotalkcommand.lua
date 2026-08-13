class = var_0_10000

local var_0_0 = "ApartmentDoTalkCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().talkId
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.dorm3d_dialogue_group[var_1_0].char_id

	getProxy = var_1_10006
	ApartmentProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_5

	if var_6.getApartment(var_1_3, var_1_2).talkDic[var_1_0] then
		existCall = var_1_5

		var_1_5(var_1_1)

		local var_1_4 = arg_1_0

		var_1_5 = arg_1_0.sendNotification
		GAME = var_1_10011

		var_1_5(var_1_4, var_1_10011.APARTMENT_DO_TALK_DONE, {
			talkId = var_1_0
		})

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 28015, {
		dialog_id = var_1_0
	}, 28016, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg = var_1

			if var_1.dorm3d_recall.get_id_list_by_story_id[var_1_0] and not var_0.talkDic[var_1_0] then
				PlayerPrefs = var_2

				var_2.SetInt("apartment_collection_recall", var_1_0)
			end

			var_2_10004 = var_0

			var_2.ModifyApartment(var_2_10004, var_1_2, function(arg_3_0)
				arg_3_0.talkDic[var_1_0] = true

				return
			end)

			PlayerConst = var_2

			local var_2_0 = var_2.addTranDrop(arg_2_0.drop_list)

			existCall = var_2_10003

			var_2_10003(var_1_1, var_2_0)

			local var_2_1 = arg_1_0
			local var_2_2 = var_3.sendNotification

			GAME = var_6

			var_2_2(var_2_1, var_6.APARTMENT_DO_TALK_DONE, {
				talkId = var_1_0,
				awards = var_2_0
			})
		else
			pg = var_1

			local var_2_3 = var_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
