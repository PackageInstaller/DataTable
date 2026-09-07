local UpdateLoadingPicCommand = class("UpdateLoadingPicCommand", pm.SimpleCommand)

function UpdateLoadingPicCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.diyModeOpenFlag

	if var_1_0.diyModeOpenFlag == nil then
		var_1_1 = var_1_0.loading_pic_open_flag
	end

	local var_1_2 = var_1_0.galleryPicIDList or var_1_0.loading_pic_id_list_1
	local var_1_3 = var_1_0.mangaPicIDList or var_1_0.loading_pic_id_list_2
	local var_1_4 = var_1_0.callback
	local var_1_5 = getProxy(LoadingPicProxy)

	if var_1_1 == nil then
		var_1_1 = var_1_5:getDiyModeOpenFlag()
	end

	if var_1_2 == nil then
		var_1_2 = var_1_5:getGalleryPicIDList()
	end

	if var_1_3 == nil then
		var_1_3 = var_1_5:getMangaPicIDList()
	end

	if #var_1_2 + #var_1_3 > AppreciatePicConst.MAX_COUNT then
		pg.TipsMgr.GetInstance():ShowTips(i18n("loading_pic_max"))

		return
	end

	local var_1_6 = var_1_1 == true and 1 or 0
	local var_1_7 = {
		loading_pic_open_flag = var_1_1 == true and 1 or 0,
		loading_pic_id_list_1 = var_1_2,
		loading_pic_id_list_2 = var_1_3
	}

	pg.ConnectionMgr.GetInstance():Send(11034, var_1_7, 11035, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_5:updateDiyModeOpenFlag(var_1_6)
			var_1_5:updateGalleryPicIDList(var_1_2)
			var_1_5:updateMangaPicIDList(var_1_3)
			pg.m02:sendNotification(GAME.UPDATE_LOADING_PIC_DONE, var_1_7)

			if var_1_4 then
				var_1_4()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return UpdateLoadingPicCommand
