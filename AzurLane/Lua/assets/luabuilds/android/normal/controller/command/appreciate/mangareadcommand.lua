class = var_0_10000

local var_0_0 = "MangaReadCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().mangaID
	local var_1_1 = var_2.mangaCB

	getProxy = var_1_10005
	AppreciateProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	print = var_1_10006

	var_1_10006("17509 Send Manga ID", var_1_0)

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 17509, {
		id = var_1_0
	}, 17510, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_2.addMangaIDToReadList(var_2_0, var_1_0)

			if var_1_1 then
				var_1_1()
			end

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_3

			var_2_2(var_2_1, var_3.APPRECIATE_MANGA_READ_DONE, {
				mangaID = var_1_0
			})
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips
			local var_2_5 = "17510 Manga Read Fail"

			tostring = var_2_10004

			var_2_4(var_2_3, var_2_5 .. var_2_10004(arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
