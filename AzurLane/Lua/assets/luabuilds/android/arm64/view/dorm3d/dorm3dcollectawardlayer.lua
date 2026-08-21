local var_0_0 = class("Dorm3dCollectAwardLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dCollectAwardUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	GetSpriteFromAtlasAsync("dorm3dcollection/" .. pg.dorm3d_collection_template[arg_2_0.contextData.itemId].icon, "", function(arg_3_0)
		arg_2_0.iconSprite = arg_3_0

		arg_2_1()

		return
	end)

	return
end

function var_0_0.init(arg_4_0)
	onButton(arg_4_0, arg_4_0._tf:Find("bg"), function()
		if arg_4_0.isBlock then
			return
		end

		arg_4_0:closeView()

		return
	end, SFX_CANCEL)

	arg_4_0.isBlock = true

	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)

	return
end

function var_0_0.onBackPressed(arg_6_0)
	if arg_6_0.isBlock then
		return
	end

	var_0_0.super.onBackPressed(arg_6_0)

	return
end

function var_0_0.didEnter(arg_7_0)
	setText(arg_7_0._tf:Find("panel/name/Text"), pg.dorm3d_collection_template[arg_7_0.contextData.itemId].name)
	setText(arg_7_0._tf:Find("panel/desc/content/desc"), pg.dorm3d_collection_template[arg_7_0.contextData.itemId].desc)

	if pg.dorm3d_collection_template[arg_7_0.contextData.itemId].award > 0 then
		setText(arg_7_0._tf:Find("panel/favor/Text"), i18n("dorm3d_collect_favor_plus") .. pg.dorm3d_favor_trigger[pg.dorm3d_collection_template[arg_7_0.contextData.itemId].award].num)
		setActive(arg_7_0._tf:Find("panel/favor"), arg_7_0.contextData.isNew)
	else
		setActive(arg_7_0._tf:Find("panel/favor"), false)
	end

	setImageSprite(arg_7_0._tf:Find("panel/icon"), arg_7_0.iconSprite, true)
	LeanTween.delayedCall(1.5, System.Action(function()
		arg_7_0.isBlock = false

		return
	end))

	return
end

function var_0_0.willExit(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf)

	return
end

return var_0_0
