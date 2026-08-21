local var_0_0 = class("AuctionGameEntrancePaintingPanel", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.paintingDefaultAngle = arg_2_0.uiPaintingTf.localEulerAngles

	arg_2_0:SwitchDisplayPanel(true)

	arg_2_0.paintingEventCom = GetComponent(arg_2_0._tf, typeof(DftAniEvent))

	onButton(arg_2_0, arg_2_0.uiDisplayBtn, function()
		seriesAsync({
			function(arg_4_0)
				arg_2_0:SwitchDisplayPanel(true)
				arg_2_0.paintingEventCom:SetEndEvent(arg_4_0)
				quickPlayAnimation(arg_2_0._tf, "Anim_AuctionGameEntranceUI_leftPanel_in")

				return
			end
		}, function()
			return
		end)

		return
	end)
	onButton(arg_2_0, arg_2_0.uiCollapseBtn, function()
		seriesAsync({
			function(arg_7_0)
				arg_2_0.paintingEventCom:SetEndEvent(arg_7_0)
				quickPlayAnimation(arg_2_0._tf, "Anim_AuctionGameEntranceUI_leftPanel_out")

				return
			end
		}, function()
			arg_2_0:SwitchDisplayPanel(false)

			return
		end)

		return
	end)

	return
end

function var_0_0.didEnter(arg_9_0)
	local var_9_9000
	local var_9_0 = getProxy(PlayerProxy)

	arg_9_0.shipVO = getProxy(BayProxy).GetShipPhantom(var_9_0, var_9_0.getRawData(var_9_9000):GetShipPhantomMarks()[1])

	arg_9_0:RefreshPainting()

	return
end

function var_0_0.RefreshPainting(arg_10_0)
	setPaintingPrefabAsync(arg_10_0.uiPaintingTf, arg_10_0:GetPaintingName(), "biandui", nil, {
		skinID = arg_10_0.shipVO:getSkinId(),
		rotateZ = arg_10_0.paintingDefaultAngle.z
	})

	return
end

function var_0_0.SwitchDisplayPanel(arg_11_0, arg_11_1)
	setActive(arg_11_0.uiDisplayBtn, not arg_11_1)
	setActive(arg_11_0.uiPaintingPanel, arg_11_1)

	return
end

function var_0_0.GetPaintingName(arg_12_0)
	return (arg_12_0.shipVO:getPainting())
end

function var_0_0.willExit(arg_13_0)
	arg_13_0:detach()
	arg_13_0.paintingEventCom:SetEndEvent(nil)
	retPaintingPrefab(arg_13_0.uiPaintingTf, arg_13_0:GetPaintingName())

	return
end

return var_0_0
