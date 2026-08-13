class = var_0_10000

local var_0_0 = "ShipChangeNameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ShipChangeNameView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0._renamePanel = arg_2_0._tf

	local var_2_0 = arg_2_0._renamePanel

	arg_2_0._renameConfirmBtn = var_1.Find(var_2_0, "frame/queren")

	local var_2_1 = arg_2_0._renamePanel

	arg_2_0._renameCancelBtn = var_1.Find(var_2_1, "frame/cancel")

	local var_2_2 = arg_2_0._renamePanel

	arg_2_0._renameRevert = var_1.Find(var_2_2, "frame/revert_button")

	local var_2_3 = arg_2_0._renamePanel

	arg_2_0._renameCloseBtn = var_1.Find(var_2_3, "frame/close_btn")
	setText = var_1
	findTF = var_2_3

	local var_2_4 = var_2_3(arg_2_0._tf, "frame/name_field/Placeholder")

	i18n = var_3

	var_1(var_2_4, var_3("rename_input"))

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0._renameConfirmBtn

	local function var_2_7()
		getInputText = var_2_10000
		findTF = var_2_10001

		local var_3_0 = var_2_10000(var_2_10001(arg_2_0._renamePanel, "frame/name_field"))
		local var_3_1 = arg_2_0
		local var_3_2 = var_1.emit

		ShipMainMediator = var_3

		local var_3_3 = var_3.RENAME_SHIP
		local var_3_4 = arg_2_0

		var_3_2(var_3_1, var_3_3, var_4.GetShipVO(var_3_4).id, var_3_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_5, var_2_6, var_2_7, var_1_10005)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0._renameRevert

	local function var_2_10()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.GetShipVO(var_4_0)

		if var_0.isRemoulded(var_4_1) then
			pg = var_4_2

			local var_4_2 = var_4_2.ship_skin_template

			var_2_10002 = arg_2_0
			var_2_10002 = var_4_1.GetShipVO(var_2_10002)

			if not var_4_2[var_4_1.getRemouldSkinId(var_2_10002)].name then
				pg = var_4_2
				var_4_2 = var_4_2.ship_data_statistics
				var_2_10002 = arg_2_0
				var_4_2 = var_4_2[var_4_1.GetShipVO(var_2_10002).configId].name
			end

			setInputText = var_4_1
			findTF = var_2_10002

			var_4_1(var_2_10002(arg_2_0._renamePanel, "frame/name_field"), var_4_2)

			return
		end
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_8, var_2_9, var_2_10, var_1_10005)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0._renameCloseBtn

	local function var_2_13()
		local var_5_0 = arg_2_0

		var_0.DisplayRenamePanel(var_5_0, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_11, var_2_12, var_2_13, var_1_10005)

	onButton = var_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0._renameCancelBtn

	local function var_2_16()
		local var_6_0 = arg_2_0

		var_0.DisplayRenamePanel(var_6_0, false)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_2_14, var_2_15, var_2_16, var_1_10005)

	return
end

function var_0_1.SetShareData(arg_7_0, arg_7_1)
	arg_7_0.shareData = arg_7_1

	return
end

function var_0_1.GetShipVO(arg_8_0)
	if arg_8_0.shareData and arg_8_0.shareData.shipVO then
		return arg_8_0.shareData.shipVO
	end

	return nil
end

function var_0_1.DisplayRenamePanel(arg_9_0, arg_9_1)
	arg_9_0.isOpenRenamePanel = arg_9_1
	SetActive = var_1_10002

	var_1_10002(arg_9_0._renamePanel, arg_9_1)

	if arg_9_1 then
		pg = var_1_10002

		local var_9_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_9_0, arg_9_0._renamePanel)

		local var_9_1 = arg_9_0:GetShipVO()

		var_1_10002 = var_1_10002.getName(var_9_1)
		setInputText = var_9_1
		findTF = var_4

		var_9_1(var_4(arg_9_0._renamePanel, "frame/name_field"), var_1_10002)
	else
		pg = var_1_10002

		local var_9_2 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_9_2, arg_9_0._renamePanel, arg_9_0._tf)
	end

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0.shareData = nil

	return
end

return var_0_1
