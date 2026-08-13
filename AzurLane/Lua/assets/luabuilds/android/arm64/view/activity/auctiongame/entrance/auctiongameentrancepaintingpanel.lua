class = var_0_10000

local var_0_0 = "AuctionGameEntrancePaintingPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0.paintingDefaultAngle = arg_2_0.uiPaintingTf.localEulerAngles

	arg_2_0:SwitchDisplayPanel(true)

	GetComponent = var_1

	local var_2_0 = arg_2_0._tf

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_2_0.paintingEventCom = var_1(var_2_0, var_4(var_1_10006))
	onButton = var_1

	var_1(arg_2_0, arg_2_0.uiDisplayBtn, function()
		local var_3_0 = {
			function(arg_4_0)
				local var_4_0 = arg_2_0

				var_1.SwitchDisplayPanel(var_4_0, true)

				local var_4_1 = arg_2_0.paintingEventCom

				var_1.SetEndEvent(var_4_1, arg_4_0)

				quickPlayAnimation = var_1

				var_1(arg_2_0._tf, "Anim_AuctionGameEntranceUI_leftPanel_in")

				return
			end
		}

		seriesAsync = var_1

		var_1(var_3_0, function()
			return
		end)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.uiCollapseBtn, function()
		local var_6_0 = {
			function(arg_7_0)
				local var_7_0 = arg_2_0.paintingEventCom

				var_1.SetEndEvent(var_7_0, arg_7_0)

				quickPlayAnimation = var_1

				var_1(arg_2_0._tf, "Anim_AuctionGameEntranceUI_leftPanel_out")

				return
			end
		}

		seriesAsync = var_1

		var_1(var_6_0, function()
			local var_8_0 = arg_2_0

			var_0.SwitchDisplayPanel(var_8_0, false)

			return
		end)

		return
	end)

	return
end

function var_0_1.didEnter(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getRawData(var_9_0)
	local var_9_2 = var_1.GetShipPhantomMarks(var_9_1)[1]

	getProxy = var_9_0
	BayProxy = var_1_10005

	local var_9_3 = var_9_0(var_1_10005)

	arg_9_0.shipVO = var_3.GetShipPhantom(var_9_3, var_9_2)

	arg_9_0:RefreshPainting()

	return
end

function var_0_1.RefreshPainting(arg_10_0)
	setPaintingPrefabAsync = var_1_10001

	local var_10_0 = arg_10_0.uiPaintingTf
	local var_10_1 = arg_10_0:GetPaintingName()
	local var_10_2 = "biandui"
	local var_10_3
	local var_10_4 = {}
	local var_10_5 = arg_10_0.shipVO

	var_10_4.skinID = var_8.getSkinId(var_10_5)
	var_10_4.rotateZ = arg_10_0.paintingDefaultAngle.z

	var_1_10001(var_10_0, var_10_1, var_10_2, var_10_3, var_10_4)

	return
end

function var_0_1.SwitchDisplayPanel(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.uiDisplayBtn, not arg_11_1)

	setActive = var_1_10002

	var_1_10002(arg_11_0.uiPaintingPanel, arg_11_1)

	return
end

function var_0_1.GetPaintingName(arg_12_0)
	local var_12_0 = arg_12_0.shipVO

	return (var_1.getPainting(var_12_0))
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:detach()

	local var_13_0 = arg_13_0.paintingEventCom

	var_1.SetEndEvent(var_13_0, nil)

	retPaintingPrefab = var_1

	var_1(arg_13_0.uiPaintingTf, arg_13_0:GetPaintingName())

	return
end

return var_0_1
