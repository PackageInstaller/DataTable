local var_0_0 = class("CipherTestLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CipherTest"
end

function var_0_0.init(arg_2_0)
	arg_2_0.nextBtn = arg_2_0._tf:Find("Next")
	arg_2_0.gcBtn = arg_2_0._tf:Find("GC")
	arg_2_0.live2dContainer = arg_2_0._tf:Find("Painting/Live2D")
	arg_2_0.l2dList = arg_2_0:GetL2DList()
	arg_2_0.curIndex = 0
	arg_2_0.live2dChar = nil
	arg_2_0.skinID = nil

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.nextBtn, function()
		arg_3_0:ClearL2dPainting()

		arg_3_0.curIndex = arg_3_0.curIndex + 1
		arg_3_0.curL2D = arg_3_0.l2dList[arg_3_0.curIndex]

		arg_3_0:LoadL2dPainting(arg_3_0.curL2D)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.gcBtn, function()
		gcAll()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.willExit(arg_6_0)
	return
end

function var_0_0.GetL2DList(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(pg.ship_skin_template.all) do
		local var_7_0 = ShipSkin.New({
			id = iter_7_1
		})

		if var_7_0:IsLive2d() then
			table.insert({}, iter_7_1)
		end
	end

	return {}
end

function var_0_0.LoadL2dPainting(arg_8_0, arg_8_1)
	local var_8_0 = Live2DPainting.GenerateData({
		ship = Ship.New({
			id = 999,
			configId = ShipGroup.getDefaultShipConfig(pg.ship_skin_template[arg_8_1].ship_group).id,
			skin_id = arg_8_1
		}),
		position = Vector3(0, 0, -1),
		parent = arg_8_0.live2dContainer
	})

	var_8_0.shopPreView = true

	pg.UIMgr.GetInstance():LoadingOn()

	local var_8_1

	var_8_1 = Live2DPainting.New(var_8_0, function(arg_9_0)
		arg_9_0:IgonreReactPos(true)
		arg_8_0:ClearL2dPainting()
		pg.UIMgr.GetInstance():LoadingOff()

		arg_8_0.live2dChar = var_8_1

		return
	end)

	return
end

function var_0_0.ClearL2dPainting(arg_10_0)
	if arg_10_0.live2dChar then
		arg_10_0.live2dChar:Dispose()

		arg_10_0.live2dChar = nil
	end

	return
end

return var_0_0
