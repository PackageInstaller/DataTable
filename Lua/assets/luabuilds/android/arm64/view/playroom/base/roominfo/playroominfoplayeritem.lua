local var_0_0 = class("PlayRoomInfoPlayerItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBgTf, function()
		arg_2_0:emit(PlayRoomInfoMediator.ON_CLICK_INVITE)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiKickTf, function()
		arg_2_0:emit(PlayRoomInfoMediator.ON_CLICK_KICK, {
			id = arg_2_0.playerData.id
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiSwitchCharacterBtn, function()
		arg_2_0:emit(PlayRoomInfoMediator.ON_CLICK_CHANGE_CHARACTER)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0.isSelf = false

	if arg_6_1 then
		arg_6_0.playerData = arg_6_1

		local var_6_0 = getProxy(PlayerProxy):getPlayerId()
		local var_6_1 = var_6_0 == arg_6_1.id

		arg_6_0.isSelf = var_6_0 == arg_6_1.id

		setActive(arg_6_0.uiBgTf, false)
		setActive(arg_6_0.uiMainTf, true)
		setText(arg_6_0.uiNameText, arg_6_1.name)
		setActive(arg_6_0.uiRoomOwnerGo, arg_6_2 == arg_6_1.id)
		setActive(arg_6_0.uiKickTf, arg_6_2 == var_6_0 and not var_6_1)

		local var_6_2 = getProxy(PlayRoomProxy):GetRoomData()

		setActive(arg_6_0.uiSwitchCharacterBtn, (arg_6_2 == var_6_0 or not arg_6_4) and var_6_1 and arg_6_3 ~= IslandCheaterTavernConst.SceneRoomType.MatchInfoRoom and not arg_6_5)
	else
		setActive(arg_6_0.uiBgTf, true)
		setActive(arg_6_0.uiMainTf, false)
	end

	if arg_6_5 then
		setActive(arg_6_0.uiLoadProcessBg, true)

		arg_6_0.uiLoadProcess.fillAmount = arg_6_5 / 100
	else
		setActive(arg_6_0.uiLoadProcessBg, false)
	end

	setActive(arg_6_0._go, true)

	return
end

function var_0_0.RefreshSelfLoad(arg_7_0, arg_7_1)
	if arg_7_0.isSelf then
		setActive(arg_7_0.uiLoadProcessBg, true)

		arg_7_0.uiLoadProcess.fillAmount = arg_7_1 / 100
	end

	return
end

function var_0_0.willExit(arg_8_0)
	arg_8_0:detach()
	Object.Destroy(arg_8_0._go)

	arg_8_0._go = nil
	arg_8_0._tf = nil

	return
end

return var_0_0
