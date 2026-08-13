class = var_0_10000

local var_0_0 = var_0_10000("MainMetaSkillSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or function()
		return
	end
	getProxy = var_1_10002
	MetaCharacterProxy = var_1_10004

	if not var_1_10002(var_1_10004) then
		arg_1_1()

		return
	end

	getProxy = var_1_10003
	ChapterProxy = var_1_10005

	local var_1_0 = var_1_10003(var_1_10005)
	local var_1_1 = var_3.getActiveChapter(var_1_0)
	local var_1_2

	if var_1_1 then
		var_1_2 = var_3:GetChapterAutoFlag(var_1_1.id) == 1
	end

	if var_1_2 then
		arg_1_1()

		return
	end

	if var_2:getMetaSkillLevelMaxInfoList() then
		local var_1_3 = #var_6

		if 0 < var_1_3 then
			local var_1_4 = arg_1_0:GetShipName(var_6)

			pg = var_8

			local var_1_5 = var_8.MsgboxMgr.GetInstance()
			local var_1_6 = var_8.ShowMsgBox
			local var_1_7 = {}

			i18n = var_1_10012
			var_1_7.content = var_1_10012("meta_skill_maxtip", var_1_4)

			function var_1_7.onYes()
				pg = var_2_10000

				local var_3_0 = var_2_10000.m02
				local var_3_1 = var_0.sendNotification

				GAME = var_2_10003

				local var_3_2 = var_2_10003.GO_SCENE

				SCENE = var_2_10004

				var_3_1(var_3_0, var_3_2, var_2_10004.METACHARACTER, {
					autoOpenTactics = true,
					autoOpenShipConfigID = var_0[1].metaShipVO.configId
				})

				return
			end

			var_1_7.onClose = arg_1_1

			var_1_6(var_1_5, var_1_7)

			goto label_1_0
		end
	end

	arg_1_1()

	::label_1_0::

	var_2:clearMetaSkillLevelMaxInfoList()

	return
end

function var_0_0.GetShipName(arg_4_0, arg_4_1)
	local var_4_0 = ""

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_1) do
		local var_4_1 = iter_4_1.metaShipVO
		local var_4_2 = iter_4_1.metaSkillID
		local var_4_3

		var_4_3, setColorStr = var_4_1:getName(), var_1_10011
		COLOR_GREEN = var_1_10014

		local var_4_4 = var_1_10011(var_4_3, var_1_10014)

		if iter_4_0 < #arg_4_1 then
			var_4_0 = var_4_0 .. var_4_4 .. "、"
		else
			var_4_0 = var_4_0 .. var_4_4
		end
	end

	return var_4_0
end

return var_0_0
