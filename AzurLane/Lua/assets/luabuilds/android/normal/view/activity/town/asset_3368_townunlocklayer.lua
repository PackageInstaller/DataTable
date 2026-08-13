class = var_0_10000

local var_0_0 = "TownUnlockLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.TYPE = {
	LEVEL = 2,
	NEW = 1
}

function var_0_1.getUIName(arg_1_0)
	return "TownUnlockUI"
end

function var_0_1.init(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "frame/content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiList = var_2_0(var_2_2, var_3.Find(var_2_3, "frame/content/tpl"))

	local var_2_4 = arg_2_0.uiList

	var_1.make(var_2_4, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0.unlockInfos[arg_3_1 + 1].type
			local var_3_1 = arg_2_0.unlockInfos[arg_3_1 + 1].id

			pg = var_5

			local var_3_2 = var_5.activity_town_work_level[var_3_1].pic

			setImageSprite = var_2_10006

			local var_3_3 = arg_3_2
			local var_3_4 = arg_3_2.Find(var_3_3, "icon")

			GetSpriteFromAtlas = var_3_3

			var_2_10006(var_3_4, var_3_3("ui/townui_atlas", var_3_2), true)

			setActive = var_2_10006

			var_2_10006(arg_3_2:Find("new"), var_3_0 == var_0_1.TYPE.NEW)

			if var_3_0 == var_0_1.TYPE.NEW then
				i18n = var_3_5

				local var_3_5

				if not var_3_5("town_unlcok_new") then
					i18n = var_3_5
					var_3_5 = var_3_5("town_unlcok_level")
				end

				setText = var_7

				var_7(arg_3_2:Find("tip/Text"), var_3_5)

				return
			end
		end
	end)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	arg_4_0.unlockInfos = {}
	underscore = var_1

	var_1.each(arg_4_0.contextData.newIds, function(arg_6_0)
		table = var_2_10001

		var_2_10001.insert(arg_4_0.unlockInfos, {
			type = var_0_1.TYPE.NEW,
			id = arg_6_0
		})

		return
	end)

	underscore = var_1

	var_1.each(arg_4_0.contextData.limitIds, function(arg_7_0)
		table = var_2_10001

		var_2_10001.insert(arg_4_0.unlockInfos, {
			type = var_0_1.TYPE.LEVEL,
			id = arg_7_0
		})

		return
	end)

	local var_4_3 = arg_4_0.uiList

	var_1.align(var_4_3, #arg_4_0.unlockInfos)

	return
end

function var_0_1.willExit(arg_8_0)
	if arg_8_0.contextData.removeFunc then
		arg_8_0.contextData.removeFunc()

		arg_8_0.contextData.removeFunc = nil
	end

	return
end

return var_0_1
