local var_0_0 = class("TownUnlockLayer", import("view.base.BaseUI"))

var_0_0.TYPE = {
	LEVEL = 2,
	NEW = 1
}

function var_0_0.getUIName(arg_1_0)
	return "TownUnlockUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.uiList = UIItemList.New(arg_2_0._tf:Find("frame/content"), arg_2_0._tf:Find("frame/content/tpl"))

	arg_2_0.uiList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = arg_2_0.unlockInfos[arg_3_1 + 1].type

			setImageSprite(arg_3_2:Find("icon"), GetSpriteFromAtlas("ui/townui_atlas", pg.activity_town_work_level[arg_2_0.unlockInfos[arg_3_1 + 1].id].pic), true)
			setActive(arg_3_2:Find("new"), var_3_0 == var_0_0.TYPE.NEW)

			local var_3_1 = var_3_0 == var_0_0.TYPE.NEW and i18n("town_unlcok_new") or i18n("town_unlcok_level")

			setText(arg_3_2:Find("tip/Text"), var_3_1)
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf, function()
		arg_4_0:onBackPressed()

		return
	end, SFX_PANEL)

	arg_4_0.unlockInfos = {}

	underscore.each(arg_4_0.contextData.newIds, function(arg_6_0)
		table.insert(arg_4_0.unlockInfos, {
			type = var_0_0.TYPE.NEW,
			id = arg_6_0
		})

		return
	end)
	underscore.each(arg_4_0.contextData.limitIds, function(arg_7_0)
		table.insert(arg_4_0.unlockInfos, {
			type = var_0_0.TYPE.LEVEL,
			id = arg_7_0
		})

		return
	end)
	arg_4_0.uiList:align(#arg_4_0.unlockInfos)

	return
end

function var_0_0.willExit(arg_8_0)
	if arg_8_0.contextData.removeFunc then
		arg_8_0.contextData.removeFunc()

		arg_8_0.contextData.removeFunc = nil
	end

	return
end

return var_0_0
