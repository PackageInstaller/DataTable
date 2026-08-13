class = var_0_10000

local var_0_0 = "UpdateLoadingPicCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if arg_1_1:getBody().diyModeOpenFlag == nil then
		var_1_0 = var_2.loading_pic_open_flag
	end

	local var_1_1

	if not var_2.galleryPicIDList then
		var_1_1 = var_2.loading_pic_id_list_1
	end

	local var_1_2

	if not var_2.mangaPicIDList then
		var_1_2 = var_2.loading_pic_id_list_2
	end

	local var_1_3 = var_2.callback

	getProxy = var_1_10007
	LoadingPicProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)

	if var_1_0 == nil then
		var_1_0 = var_1_4:getDiyModeOpenFlag()
	end

	if var_1_1 == nil then
		var_1_1 = var_1_4:getGalleryPicIDList()
	end

	if var_1_2 == nil then
		var_1_2 = var_1_4:getMangaPicIDList()
	end

	local var_1_5 = #var_1_1 + #var_1_2

	AppreciatePicConst = var_9

	local var_1_6

	if var_9.MAX_COUNT < var_1_5 then
		pg = var_1_5
		var_1_6 = var_1_5.TipsMgr.GetInstance()

		local var_1_7 = var_8.ShowTips

		i18n = var_1_10010

		var_1_7(var_1_6, var_1_10010("loading_pic_max"))

		return
	end

	local var_1_8 = var_1_0 == true and 1 or 0
	local var_1_9 = {
		loading_pic_open_flag = var_1_8,
		loading_pic_id_list_1 = var_1_1,
		loading_pic_id_list_2 = var_1_2
	}

	pg = var_1_6

	local var_1_10 = var_1_6.ConnectionMgr.GetInstance()

	var_9.Send(var_1_10, 11034, var_1_9, 11035, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_4

			var_2_4.updateDiyModeOpenFlag(var_2_0, var_1_8)

			local var_2_1 = var_1_4

			var_2_4.updateGalleryPicIDList(var_2_1, var_1_1)

			local var_2_2 = var_1_4

			var_2_4.updateMangaPicIDList(var_2_2, var_1_2)

			pg = var_2_4

			local var_2_3 = var_2_4.m02

			var_2_4 = var_2_4.sendNotification
			GAME = var_2_10003

			var_2_4(var_2_3, var_2_10003.UPDATE_LOADING_PIC_DONE, var_1_9)

			if var_1_3 then
				var_1_3()
			end
		else
			pg = var_2_4

			local var_2_5 = var_2_4.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_6(var_2_5, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
