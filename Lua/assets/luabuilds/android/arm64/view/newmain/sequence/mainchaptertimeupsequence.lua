local var_0_0 = class("MainChapterTimeUpSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(ChapterProxy)

	var_1_0:checkRemasterInfomation()

	local var_1_1 = var_1_0:getActiveChapter()
	local var_1_2 = var_1_1 and var_1_0:getMapById(var_1_1:getConfig("map"))

	if var_1_1 and (not var_1_1:inWartime() or not var_1_2:isRemaster() and not var_1_1:inActTime()) then
		ChapterOpCommand.PrepareChapterRetreat(function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_chapter_timeout"))

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
