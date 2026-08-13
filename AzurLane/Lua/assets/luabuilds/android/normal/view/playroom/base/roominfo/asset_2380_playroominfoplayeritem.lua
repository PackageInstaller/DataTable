class = var_0_10000

local var_0_0 = "PlayRoomInfoPlayerItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBgTf

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		PlayRoomInfoMediator = var_2_10002

		var_3_1(var_3_0, var_2_10002.ON_CLICK_INVITE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiKickTf

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		PlayRoomInfoMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_CLICK_KICK, {
			id = arg_2_0.playerData.id
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiSwitchCharacterBtn

	local function var_2_8()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		PlayRoomInfoMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_CLICK_CHANGE_CHARACTER)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	return
end

function var_0_1.didEnter(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0.isSelf = false

	if arg_6_1 then
		arg_6_0.playerData = arg_6_1
		getProxy = var_6_4
		PlayerProxy = var_1_10007

		local var_6_0 = var_6_4(var_1_10007)

		arg_6_0.isSelf = var_6_4.getPlayerId(var_6_0) == arg_6_1.id
		setActive = var_1_10008

		var_1_10008(arg_6_0.uiBgTf, false)

		setActive = var_1_10008

		var_1_10008(arg_6_0.uiMainTf, true)

		setText = var_1_10008

		var_1_10008(arg_6_0.uiNameText, arg_6_1.name)

		setActive = var_1_10008

		var_1_10008(arg_6_0.uiRoomOwnerGo, arg_6_2 == arg_6_1.id)

		setActive = var_1_10008

		var_1_10008(arg_6_0.uiKickTf, arg_6_2 == var_6_4 and not var_7)

		getProxy = var_1_10008
		PlayRoomProxy = var_9

		local var_6_1 = var_1_10008(var_9)
		local var_6_2 = var_8.GetRoomData(var_6_1)

		setActive = var_6_1

		local var_6_3 = arg_6_0.uiSwitchCharacterBtn

		if arg_6_2 == var_6_4 or not arg_6_4 then
			if var_7 then
				::label_6_0::

				IslandCheaterTavernConst = var_1_10012

				if arg_6_3 ~= var_1_10012.SceneRoomType.MatchInfoRoom then
					var_1_10012 = not arg_6_5

					goto label_6_1
				end

				var_1_10012 = false

				if false then
					var_1_10012 = true
				end
			end

			::label_6_1::

			var_6_1(var_6_3, var_1_10012)

			if false then
				setActive = var_6_4

				var_6_4(arg_6_0.uiBgTf, true)

				setActive = var_6_4

				var_6_4(arg_6_0.uiMainTf, false)
			end

			local var_6_4

			if arg_6_5 then
				setActive = var_6_4

				var_6_4(arg_6_0.uiLoadProcessBg, true)

				var_6_4 = arg_6_0.uiLoadProcess
				var_6_4.fillAmount = arg_6_5 / 100
			else
				setActive = var_6_4

				var_6_4(arg_6_0.uiLoadProcessBg, false)
			end

			setActive = var_6_4

			var_6_4(arg_6_0._go, true)

			return
		end
	end
end

function var_0_1.RefreshSelfLoad(arg_7_0, arg_7_1)
	if arg_7_0.isSelf then
		setActive = var_2

		var_2(arg_7_0.uiLoadProcessBg, true)

		arg_7_0.uiLoadProcess.fillAmount = arg_7_1 / 100
	end

	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:detach()

	Object = var_1

	var_1.Destroy(arg_8_0._go)

	arg_8_0._go = nil
	arg_8_0._tf = nil

	return
end

return var_0_1
