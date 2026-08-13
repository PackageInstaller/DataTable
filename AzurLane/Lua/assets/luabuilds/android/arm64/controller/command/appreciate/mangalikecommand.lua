class = var_0_10000

local var_0_0 = "MangaLikeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().mangaID
	local var_1_1 = var_2.action
	local var_1_2 = var_2.mangaCB

	getProxy = var_1_10006
	AppreciateProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	print = var_1_10007

	var_1_10007("17511 Send Manga ID", var_1_0)

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 17511, {
		id = var_1_0,
		action = var_1_1
	}, 17512, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_1_1
			MangaConst = var_2_10002

			if var_2_0 == var_2_10002.SET_MANGA_LIKE then
				local var_2_1 = var_1_3

				var_2_0.addMangaIDToLikeList(var_2_1, var_1_0)
			else
				local var_2_2 = var_1_3

				var_2_0.removeMangaIDFromLikeList(var_2_2, var_1_0)
			end

			if var_1_2 then
				var_1_2()
			end

			local var_2_3 = arg_1_0

			var_2_0 = var_2_0.sendNotification
			GAME = var_2_10004

			var_2_0(var_2_3, var_2_10004.APPRECIATE_MANGA_LIKE_DONE, {
				mangaID = var_1_0,
				action = var_1_1
			})
		else
			pg = var_2_0

			local var_2_4 = var_2_0.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips
			local var_2_6 = "17512 Manga Like Fail:"

			tostring = var_2_10005

			var_2_5(var_2_4, var_2_6 .. var_2_10005(arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
