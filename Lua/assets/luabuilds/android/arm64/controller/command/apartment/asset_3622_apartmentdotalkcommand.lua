local ApartmentDoTalkCommand = class("ApartmentDoTalkCommand", pm.SimpleCommand)

function ApartmentDoTalkCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.talkId
	local var_1_2 = var_1_0.callback
	local var_1_3 = pg.dorm3d_dialogue_group[var_1_0.talkId].char_id
	local var_1_4 = getProxy(ApartmentProxy)
	local var_1_5 = var_1_4:getApartment(pg.dorm3d_dialogue_group[var_1_0.talkId].char_id)

	if var_1_5.talkDic[var_1_0.talkId] then
		existCall(var_1_0.callback)
		self:sendNotification(GAME.APARTMENT_DO_TALK_DONE, {
			talkId = var_1_0.talkId
		})

		return
	end

	pg.ConnectionMgr.GetInstance():Send(28015, {
		dialog_id = var_1_0.talkId
	}, 28016, function(arg_2_0)
		if arg_2_0.result == 0 then
			if pg.dorm3d_recall.get_id_list_by_story_id[var_1_1] and not var_1_5.talkDic[var_1_1] then
				PlayerPrefs.SetInt("apartment_collection_recall", var_1_1)
			end

			var_1_4:ModifyApartment(var_1_3, function(arg_3_0)
				arg_3_0.talkDic[var_1_1] = true

				return
			end)

			local var_2_0 = PlayerConst.addTranDrop(arg_2_0.drop_list)

			existCall(var_1_2, var_2_0)
			self:sendNotification(GAME.APARTMENT_DO_TALK_DONE, {
				talkId = var_1_1,
				awards = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ApartmentDoTalkCommand
