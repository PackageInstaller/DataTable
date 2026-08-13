class = var_0_10000

local var_0_0 = var_0_10000("MainChapterTimeUpSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)

	var_2.checkRemasterInfomation(var_1_0)

	local var_1_1 = var_2:getActiveChapter() and var_2:getMapById(var_3:getConfig("map"))

	if var_3 and (not var_3:inWartime() or not var_1_1:isRemaster() and not var_3:inActTime()) then
		ChapterOpCommand = var_5

		var_5.PrepareChapterRetreat(function()
			pg = var_2_10000

			local var_2_0 = var_2_10000.TipsMgr.GetInstance()
			local var_2_1 = var_0.ShowTips

			i18n = var_2_10003

			var_2_1(var_2_0, var_2_10003("levelScene_chapter_timeout"))

			if arg_1_1 then
				arg_1_1()
			end

			return
		end)
	elseif arg_1_1 then
		arg_1_1()
	end

	return
end

return var_0_0
