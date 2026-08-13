class = var_0_10000

local var_0_0 = var_0_10000("MainMetaSkillSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or function()
		return
	end
	getProxy = var_1_10002
	MetaCharacterProxy = var_1_10003

	if not var_1_10002(var_1_10003) then
		arg_1_1()

		return
	end

	getProxy = var_1_10003
	ChapterProxy = var_1_10004

	local var_1_0 = var_1_10003(var_1_10004)
	local var_1_1 = var_3.getActiveChapter(var_1_0)
	local var_1_2

	if var_1_1 then
		var_1_2 = var_3:GetChapterAutoFlag(var_1_1.id) == 1
	end

	if var_1_2 then
		arg_1_1()

		return
	end

	if var_2:getMetaSkillLevelMaxInfoList() and #var_6 > 0 then
		local var_1_3 = arg_1_0
		local var_1_4 = arg_1_0.GetShipName(var_1_3, var_6)

		pg = var_1_3

		local var_1_5 = var_1_3.MsgboxMgr.GetInstance()
		local var_1_6 = var_8.ShowMsgBox
		local var_1_7 = {}

		i18n = var_1_10011
		var_1_7.content = var_1_10011("meta_skill_maxtip", var_1_4)

		function var_1_7.onYes()
			pg = var_2_10000

			local var_3_0 = var_2_10000.m02
			local var_3_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_3_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_3_1(var_3_0, var_3_2, var_2_10003.METACHARACTER, {
				autoOpenTactics = true,
				autoOpenShipConfigID = var_0[1].metaShipVO.configId
			})

			return
		end

		var_1_7.onClose = arg_1_1

		var_1_6(var_1_5, var_1_7)
	else
		arg_1_1()
	end

	var_2:clearMetaSkillLevelMaxInfoList()

	return
end

function var_0_0.GetShipName(arg_4_0, arg_4_1)
	local var_4_0 = ""

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_1) do
		local var_4_1 = iter_4_1.metaShipVO
		local var_4_2 = iter_4_1.metaSkillID
		local var_4_3 = var_4_1
		local var_4_4

		var_4_4, setColorStr = var_4_1.getName(var_4_3), var_4_3
		COLOR_GREEN = var_1_10013

		local var_4_5 = var_4_3(var_4_4, var_1_10013)

		if iter_4_0 < #arg_4_1 then
			var_4_0 = var_4_0 .. var_4_5 .. "、"
		else
			var_4_0 = var_4_0 .. var_4_5
		end
	end

	return var_4_0
end

return var_0_0
