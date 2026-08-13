class = var_0_10000

local var_0_0 = "GetChapterDropShipListCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().chapterId
	local var_1_1 = var_2.callback

	assert = var_1_10005

	var_1_10005(var_1_0)

	getProxy = var_1_10005
	ChapterProxy = var_6

	if not var_1_10005(var_6).FectchDropShipListFlags then
		var_5.FectchDropShipListFlags = {}
	end

	if not var_5.FectchDropShipListFlags[var_1_0] then
		pg = var_6

		local var_1_2 = var_6.ConnectionMgr.GetInstance()

		var_6.Send(var_1_2, 13109, {
			id = var_1_0
		}, 13110, function(arg_2_0)
			local var_2_0 = {}

			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.drop_ship_list) do
				table = var_2_10007

				var_2_10007.insert(var_2_0, iter_2_1)
			end

			local var_2_1 = var_0
			local var_2_2 = var_2.getChapterById(var_2_1, var_1_0)

			var_2.UpdateDropShipList(var_2_2, var_2_0)

			var_0.FectchDropShipListFlags[var_1_0] = true

			local var_2_3 = var_0

			var_3.updateChapter(var_2_3, var_2)

			local var_2_4 = var_2:GetDropShipList()

			if var_1_1 then
				var_1_1(var_2_4)
			end

			local var_2_5 = arg_1_0
			local var_2_6 = var_4.sendNotification

			GAME = iter_2_1

			var_2_6(var_2_5, iter_2_1.GET_CHAPTER_DROP_SHIP_LIST_DONE, {
				shipIds = var_2_4
			})

			return
		end)
	else
		local var_1_3 = var_5:getChapterById(var_1_0)
		local var_1_4 = var_6.GetDropShipList(var_1_3)

		if var_1_1 then
			var_1_1(var_1_4)
		end

		local var_1_5 = arg_1_0
		local var_1_6 = arg_1_0.sendNotification

		GAME = var_1_10010

		var_1_6(var_1_5, var_1_10010.GET_CHAPTER_DROP_SHIP_LIST_DONE, {
			shipIds = var_1_4
		})
	end

	return
end

return var_0_1
