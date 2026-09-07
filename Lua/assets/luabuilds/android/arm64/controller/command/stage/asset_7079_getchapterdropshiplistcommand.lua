local GetChapterDropShipListCommand = class("GetChapterDropShipListCommand", pm.SimpleCommand)

function GetChapterDropShipListCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.chapterId
	local var_1_2 = var_1_0.callback

	assert(var_1_0.chapterId)

	local var_1_3 = getProxy(ChapterProxy)

	var_1_3.FectchDropShipListFlags = var_1_3.FectchDropShipListFlags or {}

	if not var_1_3.FectchDropShipListFlags[var_1_0.chapterId] then
		pg.ConnectionMgr.GetInstance():Send(13109, {
			id = var_1_0.chapterId
		}, 13110, function(arg_2_0)
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.drop_ship_list) do
				table.insert(var_2_0, iter_2_1)
			end

			local var_2_1 = var_1_3:getChapterById(var_1_1)

			var_2_1:UpdateDropShipList(var_2_0)

			var_1_3.FectchDropShipListFlags[var_1_1] = true

			var_1_3:updateChapter(var_2_1)

			local var_2_2 = var_2_1:GetDropShipList()

			if var_1_2 then
				var_1_2(var_2_2)
			end

			self:sendNotification(GAME.GET_CHAPTER_DROP_SHIP_LIST_DONE, {
				shipIds = var_2_2
			})

			return
		end)
	else
		local var_1_4 = var_1_3:getChapterById(var_1_0.chapterId):GetDropShipList()

		if var_1_0.callback then
			var_1_0.callback(var_1_4)
		end

		self:sendNotification(GAME.GET_CHAPTER_DROP_SHIP_LIST_DONE, {
			shipIds = var_1_4
		})
	end

	return
end

return GetChapterDropShipListCommand
