class = var_0_10000

local var_0_0 = "GalleryLikeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().picID
	local var_1_1 = var_2.isAdd
	local var_1_2 = var_2.likeCBFunc

	getProxy = var_1_10006
	AppreciateProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 17505, {
		id = var_1_0,
		action = var_1_1
	}, 17506, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			if var_1_1 == 0 then
				local var_2_0 = var_1_3

				var_2_3.addPicIDToLikeList(var_2_0, var_1_0)
			elseif var_1_1 == 1 then
				local var_2_1 = var_1_3

				var_2_3.removePicIDFromLikeList(var_2_1, var_1_0)
			end

			if var_1_2 then
				var_1_2()
			end

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10003

			var_2_3(var_2_2, var_2_10003.APPRECIATE_GALLERY_LIKE_DONE, {
				picID = var_1_0,
				action = var_1_1
			})
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips
			local var_2_6 = "Like Fail"

			tostring = var_2_10004

			var_2_5(var_2_4, var_2_6 .. var_2_10004(arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
