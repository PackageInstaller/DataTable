class = var_0_10000

local var_0_0 = "MangaFullScreenMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.APPRECIATE_MANGA_READ_DONE
	GAME = var_2
	var_2_0[2] = var_2.APPRECIATE_MANGA_LIKE_DONE
	GAME = var_2
	var_2_0[3] = var_2.UPDATE_LOADING_PIC_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	GAME = var_3_1

	local var_3_3

	if var_3_0 == var_3_1.APPRECIATE_MANGA_READ_DONE then
		var_3_3 = var_3_2.mangaID

		if arg_3_0.contextData.mangaContext then
			local var_3_4 = arg_3_0.contextData.mangaContext

			var_5.updateLineAfterRead(var_3_4, var_3_3)
		end
	else
		GAME = var_3_3

		if var_3_0 == var_3_3.APPRECIATE_MANGA_LIKE_DONE then
			local var_3_5 = arg_3_0.viewComponent

			var_4.updateLikeBtn(var_3_5)
		else
			GAME = var_4

			if var_3_0 == var_4.UPDATE_LOADING_PIC_DONE then
				local var_3_6 = arg_3_0.viewComponent

				var_4.updateLoadingBtn(var_3_6)
			end
		end
	end

	return
end

return var_0_1
