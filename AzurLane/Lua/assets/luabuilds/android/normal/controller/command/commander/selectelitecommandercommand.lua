class = var_0_10000

local var_0_0 = "SelectEliteCommanderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().chapterId
	local var_1_1 = var_2.index
	local var_1_2 = var_2.pos
	local var_1_3 = var_2.commanderId
	local var_1_4 = var_2.callback

	getProxy = var_1_10008
	ChapterProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)
	local var_1_6 = var_8.getChapterById(var_1_5, var_1_0)

	if var_1_3 and var_1_3 ~= 0 then
		Commander = var_1_5

		local var_1_7, var_1_8 = var_1_5.canEquipToEliteChapter(var_1_0, var_1_1, var_1_2, var_1_3)

		if not var_1_7 then
			pg = var_12

			local var_1_9 = var_12.TipsMgr.GetInstance()

			var_12.ShowTips(var_1_9, var_1_8)

			return
		end
	end

	var_1_6:updateCommander(var_1_1, var_1_2, var_1_3)
	var_8:updateChapter(var_1_6)
	var_8:duplicateEliteFleet(var_1_6)

	if var_1_4 then
		var_1_4()
	end

	return
end

return var_0_1
