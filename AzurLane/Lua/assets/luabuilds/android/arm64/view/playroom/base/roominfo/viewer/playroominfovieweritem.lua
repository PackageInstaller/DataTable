local var_0_0 = class("PlayRoomInfoViewerItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.didEnter(arg_3_0, arg_3_1, arg_3_2)
	setText(arg_3_0.uiNameText, arg_3_1.name)
	setText(arg_3_0.uiPtCntText, arg_3_1.ptCnt)
	setText(arg_3_0.uiServeText, "区服")
	setActive(arg_3_0.uiKickBtn, arg_3_2)
	onButton(arg_3_0, arg_3_0.uiKickBtn, function()
		arg_3_0:emit(PlayRoomInfoViewerMediator.ON_CLICK_KICK, {
			id = arg_3_1.id
		})

		return
	end, SFX_PANEL)
	LoadSpriteAsync("qicon/" .. Ship.New({
		configId = arg_3_1.displayicon
	}):getPrefab(), function(arg_5_0)
		arg_3_0.uiIcon.sprite = arg_5_0

		return
	end)

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_0
