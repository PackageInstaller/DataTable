local SelectEliteCommanderCommand = class("SelectEliteCommanderCommand", pm.SimpleCommand)

function SelectEliteCommanderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ChapterProxy)
	local var_1_2 = var_1_1:getChapterById(var_1_0.chapterId)

	if var_1_0.commanderId and var_1_0.commanderId ~= 0 then
		local var_1_3, var_1_4 = Commander.canEquipToEliteChapter(var_1_0.chapterId, var_1_0.index, var_1_0.pos, var_1_0.commanderId)

		if not var_1_3 then
			pg.TipsMgr.GetInstance():ShowTips(var_1_4)

			return
		end
	end

	var_1_2:updateCommander(var_1_0.index, var_1_0.pos, var_1_0.commanderId)
	var_1_1:updateChapter(var_1_2)
	var_1_1:duplicateEliteFleet(var_1_2)

	if var_1_0.callback then
		var_1_0.callback()
	end

	return
end

return SelectEliteCommanderCommand
