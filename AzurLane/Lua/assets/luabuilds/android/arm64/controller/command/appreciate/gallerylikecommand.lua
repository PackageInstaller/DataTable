local var_0_0 = class("GalleryLikeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.likeCBFunc
	local var_1_2 = getProxy(AppreciateProxy)

	pg.ConnectionMgr.GetInstance():Send(17505, {
		id = var_1_0.picID,
		action = var_1_0.isAdd
	}, 17506, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_0 == 0 then
				var_1_2:addPicIDToLikeList(var_0)
			elseif var_0 == 1 then
				var_1_2:removePicIDFromLikeList(var_0)
			end

			if var_1_1 then
				var_1_1()
			end

			arg_1_0:sendNotification(GAME.APPRECIATE_GALLERY_LIKE_DONE, {
				picID = var_0,
				action = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("Like Fail" .. tostring(arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
