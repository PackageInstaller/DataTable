local MetaCharacterLevelMaxBoxShowCommand = class("MetaCharacterLevelMaxBoxShowCommand", pm.SimpleCommand)

function MetaCharacterLevelMaxBoxShowCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(MetaCharacterProxy)

	if not var_1_1 then
		return
	end

	local var_1_2 = getProxy(ChapterProxy)
	local var_1_3 = var_1_2:getActiveChapter()

	if (var_1_3 or nil) and var_1_2:GetChapterAutoFlag(var_1_3.id) == 1 then
		return
	end

	local var_1_5 = var_1_1:getMetaSkillLevelMaxInfoList()

	if var_1_5 and #var_1_5 > 0 then
		local var_1_6 = ""

		for iter_1_0, iter_1_1 in ipairs(var_1_5) do
			local var_1_8 = setColorStr(iter_1_1.metaShipVO:getName(), COLOR_GREEN)

			var_1_6 = iter_1_0 < #var_1_5 and var_1_6 .. var_1_8 .. "、" or var_1_6 .. var_1_8
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("meta_skill_maxtip", var_1_6),
			onYes = function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.METACHARACTER, {
					autoOpenTactics = true,
					autoOpenShipConfigID = var_1_5[1].metaShipVO.configId
				})

				return
			end,
			onClose = function()
				if var_1_0.closeFunc then
					var_1_0.closeFunc()
				end

				return
			end
		})
	end

	var_1_1:clearMetaSkillLevelMaxInfoList()

	return
end

return MetaCharacterLevelMaxBoxShowCommand
