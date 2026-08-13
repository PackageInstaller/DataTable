class = var_0_10000

local var_0_0 = "AppreciatePicViewMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.UPDATE_LOADING_PIC_DONE
	GAME = var_2
	var_2_0[2] = var_2.APPRECIATE_GALLERY_LIKE_DONE
	GAME = var_2
	var_2_0[3] = var_2.APPRECIATE_MANGA_LIKE_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getName(var_3_0)
	local var_3_2 = arg_3_1:getBody()

	GAME = var_3_0

	if var_3_1 ~= var_3_0.UPDATE_LOADING_PIC_DONE then
		GAME = var_4

		if var_3_1 ~= var_4.APPRECIATE_GALLERY_LIKE_DONE then
			GAME = var_4

			if var_3_1 == var_4.APPRECIATE_MANGA_LIKE_DONE then
				local var_3_3 = arg_3_0.viewComponent

				var_4.updatePanel(var_3_3)
			end

			return
		end
	end
end

return var_0_1
