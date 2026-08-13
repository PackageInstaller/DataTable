class = var_0_10000

local var_0_0 = "MetaCharacterLevelMaxBoxShowCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	MetaCharacterProxy = var_1_10004

	if not var_1_0(var_1_10004) then
		return
	end

	getProxy = var_1_10004
	ChapterProxy = var_1_10005

	local var_1_2 = var_1_10004(var_1_10005)
	local var_1_3 = var_4.getActiveChapter(var_1_2)
	local var_1_4

	if var_1_3 then
		var_1_4 = var_4:GetChapterAutoFlag(var_1_3.id) == 1
	end

	if var_1_4 then
		return
	end

	if var_3:getMetaSkillLevelMaxInfoList() then
		local var_1_5 = #var_7

		if 0 < var_1_5 then
			local var_1_6 = ""

			ipairs = var_9

			for iter_1_0, iter_1_1 in var_9(var_7) do
				local var_1_7 = iter_1_1.metaShipVO
				local var_1_8 = iter_1_1.metaSkillID
				local var_1_9 = var_1_7
				local var_1_10

				var_1_10, setColorStr = var_1_7.getName(var_1_9), var_1_9
				COLOR_GREEN = var_1_10019

				local var_1_11 = var_1_9(var_1_10, var_1_10019)

				if iter_1_0 < #var_7 then
					var_1_6 = var_1_6 .. var_1_11 .. "、"
				else
					var_1_6 = var_1_6 .. var_1_11
				end
			end

			pg = var_9

			local var_1_12 = var_9.MsgboxMgr.GetInstance()
			local var_1_13 = var_9.ShowMsgBox
			local var_1_14 = {}

			i18n = iter_1_0
			var_1_14.content = iter_1_0("meta_skill_maxtip", var_1_6)

			function var_1_14.onYes()
				pg = var_2_10000

				local var_2_0 = var_2_10000.m02
				local var_2_1 = var_0.sendNotification

				GAME = var_2_10002

				local var_2_2 = var_2_10002.GO_SCENE

				SCENE = var_2_10003

				var_2_1(var_2_0, var_2_2, var_2_10003.METACHARACTER, {
					autoOpenTactics = true,
					autoOpenShipConfigID = var_0[1].metaShipVO.configId
				})

				return
			end

			function var_1_14.onClose()
				if var_1_1.closeFunc then
					var_1_1.closeFunc()
				end

				return
			end

			var_1_13(var_1_12, var_1_14)
		end
	end

	var_3:clearMetaSkillLevelMaxInfoList()

	return
end

return var_0_1
