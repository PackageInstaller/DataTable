local MainMetaSkillSequence = class("MainMetaSkillSequence")

function MainMetaSkillSequence:Execute(arg_1_1)
	arg_1_1 = arg_1_1 or function()
		return
	end

	local var_1_0 = getProxy(MetaCharacterProxy)

	if not var_1_0 then
		arg_1_1()

		return
	end

	local var_1_1 = getProxy(ChapterProxy)
	local var_1_2 = var_1_1:getActiveChapter()

	if (var_1_2 or nil) and var_1_1:GetChapterAutoFlag(var_1_2.id) == 1 then
		arg_1_1()

		return
	end

	local var_1_4 = var_1_0:getMetaSkillLevelMaxInfoList()

	if var_1_4 and #var_1_4 > 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("meta_skill_maxtip", (self:GetShipName(var_1_4))),
			onYes = function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
					autoOpenTactics = true,
					autoOpenShipConfigID = var_1_4[1].metaShipVO.configId
				})

				return
			end,
			onClose = arg_1_1
		})
	else
		arg_1_1()
	end

	var_1_0:clearMetaSkillLevelMaxInfoList()

	return
end

function MainMetaSkillSequence:GetShipName(arg_4_1)
	local var_4_0 = ""

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_2 = setColorStr(iter_4_1.metaShipVO:getName(), COLOR_GREEN)

		var_4_0 = iter_4_0 < #arg_4_1 and var_4_0 .. var_4_2 .. "、" or var_4_0 .. var_4_2
	end

	return var_4_0
end

return MainMetaSkillSequence
