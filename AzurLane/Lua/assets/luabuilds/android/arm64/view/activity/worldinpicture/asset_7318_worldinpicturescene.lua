class = var_0_10000

local var_0_0 = "WorldInPictureScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))
local var_0_2 = 0
local var_0_3 = 1

function var_0_1.getUIName(arg_1_0)
	return "WorldInPictureUI"
end

function var_0_1.emit(arg_2_0, ...)
	if arg_2_0.inAniming then
		return
	end

	var_0_1.super.emit(arg_2_0, ...)

	return
end

function var_0_1.OnOpenCellErro(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0.onkeyTravelProcess = false

		arg_3_0:UpdateTravelBtnState()
	end

	return
end

function var_0_1.OnOpenCell(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:CloseSelector(arg_4_1, arg_4_2)
	arg_4_0:HideBox(arg_4_1, arg_4_2)

	arg_4_0.inAniming = true

	local var_4_0 = arg_4_0.cells[arg_4_1][arg_4_2].gameObject.transform.anchoredPosition

	arg_4_0:DoAnimtion("picture_faguang", var_4_0, function()
		var_0.alpha = 1

		if arg_4_3 then
			local var_5_0 = arg_4_0.data

			if var_0.ExistBox(var_5_0, arg_4_1, arg_4_2) then
				local var_5_1 = arg_4_0

				var_0.RpAnim(var_5_1, arg_4_1, arg_4_2)
			end
		end

		local var_5_2 = arg_4_0

		var_0.HightLightOpenArea(var_5_2, arg_4_1, arg_4_2)

		local var_5_3 = arg_4_0

		var_0.UpdatePoints(var_5_3)

		local var_5_4 = arg_4_0

		var_0.UpdateSwitcherState(var_5_4)

		local var_5_5 = arg_4_0.data
		local var_5_6 = var_0.IsFirstTravel(var_5_5)
		local var_5_7 = arg_4_0
		local var_5_8 = var_1.UpdateChar

		Vector2 = var_4

		var_5_8(var_5_7, var_4(arg_4_1, arg_4_2), not var_5_6)

		local var_5_9 = arg_4_0

		var_1.SaveCharPosition(var_5_9, arg_4_1, arg_4_2)

		arg_4_0.inAniming = false
		arg_4_0.forceStopTravelPorcess = false

		if arg_4_3 then
			local var_5_10 = arg_4_0.onkeyTravelProcess

			arg_4_0.onkeyTravelProcess = false

			local var_5_11 = arg_4_0

			var_2.UpdateTravelBtnState(var_5_11)

			if var_5_10 then
				local var_5_12 = arg_4_0.data
				local var_5_14

				if not var_5_14.FindNextTravelable(var_5_12) then
					local var_5_13 = arg_4_0

					var_5_14 = var_5_14.emit
					WorldInPictureMediator = var_5

					var_5_14(var_5_13, var_5.RESULT_ONEKEY_AWARD)
				elseif var_5_10 == true then
					triggerButton = var_5_14

					var_5_14(arg_4_0.onekeyTravelBtn)
				end

				return
			end
		end
	end)

	return
end

function var_0_1.CloseSelector(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.data

	if var_3.IsFirstTravel(var_6_0) then
		ipairs = var_3

		for iter_6_0, iter_6_1 in var_3(arg_6_0.selectors) do
			ipairs = var_1_10008

			for iter_6_2, iter_6_3 in var_1_10008(iter_6_1) do
				iter_6_3.alpha = 0
			end
		end
	elseif arg_6_0.selectors[arg_6_1][arg_6_2] and var_3.alpha ~= 0 then
		var_3.alpha = 0
	end

	return
end

function var_0_1.HightLightOpenArea(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	Vector2 = var_1_10004
	var_7_0[1] = var_1_10004(arg_7_1 + 1, arg_7_2)
	Vector2 = var_4
	var_7_0[2] = var_4(arg_7_1, arg_7_2 + 1)
	Vector2 = var_4
	var_7_0[3] = var_4(arg_7_1 - 1, arg_7_2)
	Vector2 = var_4
	var_7_0[4] = var_4(arg_7_1, arg_7_2 - 1)

	local function var_7_1(arg_8_0)
		local var_8_0 = arg_7_0.data

		if not var_1.IsOpened(var_8_0, arg_8_0.x, arg_8_0.y) then
			local var_8_1 = arg_7_0.data

			if var_1.OutSide(var_8_1, arg_8_0.x, arg_8_0.y) then
				return
			end

			if not arg_7_0.selectors[arg_8_0.x] or not arg_7_0.selectors[arg_8_0.x][arg_8_0.y] then
				local var_8_2 = arg_7_0

				var_1.CreateSelector(var_8_2, arg_8_0.x, arg_8_0.y)
			else
				arg_7_0.selectors[arg_8_0.x][arg_8_0.y].alpha = 1
			end

			return
		end
	end

	_ = var_1_10005

	var_1_10005.each(var_7_0, var_7_1)

	return
end

function var_0_1.RpAnim(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:GetRedPacket()
	local var_9_1 = arg_9_0.cells[arg_9_1][arg_9_2].gameObject.transform.anchoredPosition

	Vector2 = var_1_10006
	var_9_0.anchoredPosition = var_9_1 + var_1_10006(48, 48)
	LeanTween = var_5

	local var_9_2 = var_5.value(var_9_0.gameObject, var_9_0.anchoredPosition.y, var_9_0.anchoredPosition.y + 35, 0.75)
	local var_9_3 = var_5.setOnUpdate

	System = var_8

	local var_9_4 = var_9_3(var_9_2, var_8.Action_float(function(arg_10_0)
		local var_10_0 = var_9_0

		Vector2 = var_2_10002
		var_10_0.anchoredPosition = var_2_10002(var_9_0.anchoredPosition.x, arg_10_0)

		return
	end))
	local var_9_5 = var_5.setOnComplete

	System = var_8

	var_9_5(var_9_4, var_8.Action(function()
		if arg_9_0.exited then
			return
		end

		setActive = var_0

		var_0(var_9_0, false)

		table = var_0

		var_0.insert(arg_9_0.redpackets, var_9_0)

		return
	end))

	return
end

function var_0_1.HideBox(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_0.boxes[arg_12_1] then
		var_12_0 = arg_12_0.boxes[arg_12_1][arg_12_2]
	end

	if var_12_0 then
		var_12_0.alpha = 0
	end

	return
end

function var_0_1.OnDrawAreaErro(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.onkeyDrawPorcess = false

		arg_13_0:UpdateDrawBtnState()
	end

	return
end

function var_0_1.OnDrawArea(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:HideDrawarea(arg_14_1, arg_14_2)

	arg_14_0.inAniming = true

	arg_14_0:CreateAnimal(arg_14_1, arg_14_2, false, function(arg_15_0)
		local var_15_0 = arg_14_0.data
		local var_15_1 = var_1.GetDrawAnimData(var_15_0, arg_14_1, arg_14_2)
		local var_15_2 = arg_15_0.sizeDelta.x * arg_15_0.localScale.x * 0.5 + 90
		local var_15_3 = arg_15_0.sizeDelta.y * arg_15_0.localScale.y * 0.5

		Vector2 = var_4

		local var_15_4 = var_4(var_15_1[2] + var_15_2, var_15_1[3] - var_15_3)
		local var_15_5 = arg_14_0

		var_5.DoAnimtion(var_15_5, "picture_bichu", var_15_4, function()
			LeanTween = var_3_10000

			local var_16_0 = var_3_10000.value(arg_15_0.gameObject, 0, 1, 0.5)
			local var_16_1 = var_0.setOnUpdate

			System = var_3

			var_16_1(var_16_0, var_3.Action_float(function(arg_17_0)
				if arg_14_0.exited then
					return
				end

				local var_17_0 = arg_15_0
				local var_17_1 = var_1.GetComponent

				typeof = var_4_10004
				CanvasGroup = var_4_10006
				var_17_1(var_17_0, var_4_10004(var_4_10006)).alpha = arg_17_0

				return
			end))

			local var_16_2 = arg_14_0

			var_0.UpdatePoints(var_16_2)

			arg_14_0.inAniming = false
			arg_14_0.forceStopDrawPorcess = false

			if arg_14_3 then
				local var_16_3 = arg_14_0.onkeyDrawPorcess

				arg_14_0.onkeyDrawPorcess = false

				local var_16_4 = arg_14_0

				var_1.UpdateDrawBtnState(var_16_4)

				if var_16_3 then
					local var_16_5 = arg_14_0.data

					if not var_1.FindNextDrawableAreaHead(var_16_5) then
						local var_16_6 = arg_14_0
						local var_16_7 = var_1.emit

						WorldInPictureMediator = var_4

						var_16_7(var_16_6, var_4.RESULT_ONEKEY_AWARD)
					elseif arg_14_3 and var_16_3 == true then
						triggerButton = var_1

						var_1(arg_14_0.onekeyDrawBtn)
					end

					return
				end
			end
		end)

		return
	end)

	return
end

function var_0_1.HideDrawarea(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if arg_18_0.drawableAare[arg_18_1] then
		var_18_0 = arg_18_0.drawableAare[arg_18_1][arg_18_2]
	end

	if var_18_0 then
		var_18_0.alpha = 0
	end

	return
end

function var_0_1.SetData(arg_19_0, arg_19_1)
	arg_19_0.data = arg_19_1

	return
end

function var_0_1.init(arg_20_0)
	Input = var_1_10001
	var_1_10001.multiTouchEnabled = false

	local var_20_0 = arg_20_0._tf

	arg_20_0.redpacket = var_1.Find(var_20_0, "redpackets/redpacket")

	local var_20_1 = arg_20_0._tf

	arg_20_0.lineHrzTpl = var_1.Find(var_20_1, "lines/line_hrz")

	local var_20_2 = arg_20_0._tf

	arg_20_0.lineVecTpl = var_1.Find(var_20_2, "lines/line_vec")

	local var_20_3 = arg_20_0._tf

	arg_20_0.animalTpl = var_1.Find(var_20_3, "animals/animal")

	local var_20_4 = arg_20_0._tf

	arg_20_0.areaTpl = var_1.Find(var_20_4, "drawablearea/area")

	local var_20_5 = arg_20_0._tf

	arg_20_0.boxTpl = var_1.Find(var_20_5, "boxes/box")

	local var_20_6 = arg_20_0._tf

	arg_20_0.selectorTpl = var_1.Find(var_20_6, "selectors/selector")

	local var_20_7 = arg_20_0._tf

	arg_20_0.tpl = var_1.Find(var_20_7, "grids/grid")

	local var_20_8 = arg_20_0._tf

	arg_20_0.backBtn = var_1.Find(var_20_8, "back")

	local var_20_9 = arg_20_0._tf

	arg_20_0.helpBtn = var_1.Find(var_20_9, "help")

	local var_20_10 = arg_20_0._tf
	local var_20_11 = var_1.Find(var_20_10, "points/travel")
	local var_20_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_20_0.travelPointTxt = var_20_12(var_20_11, var_4(var_1_10006))

	local var_20_13 = arg_20_0._tf
	local var_20_14 = var_1.Find(var_20_13, "points/draw")
	local var_20_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_20_0.drawPointTxt = var_20_15(var_20_14, var_4(var_1_10006))

	local var_20_16 = arg_20_0._tf
	local var_20_17 = var_1.Find(var_20_16, "progress/travel")
	local var_20_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_20_0.travelProgressTxt = var_20_18(var_20_17, var_4(var_1_10006))

	local var_20_19 = arg_20_0._tf
	local var_20_20 = var_1.Find(var_20_19, "progress/draw")
	local var_20_21 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_20_0.drawProgressTxt = var_20_21(var_20_20, var_4(var_1_10006))

	local var_20_22 = arg_20_0._tf

	arg_20_0.switchBtn = var_1.Find(var_20_22, "swticher")

	local var_20_23 = arg_20_0.switchBtn

	arg_20_0.onDisable = var_1.Find(var_20_23, "on_disable")

	local var_20_24 = arg_20_0.switchBtn

	arg_20_0.btnOn = var_1.Find(var_20_24, "on_enable/draw")

	local var_20_25 = arg_20_0.switchBtn

	arg_20_0.btnOff = var_1.Find(var_20_25, "on_enable/off")

	local var_20_26 = arg_20_0._tf

	arg_20_0.onekeyTravelBtn = var_1.Find(var_20_26, "onekey_travel")

	local var_20_27 = arg_20_0._tf

	arg_20_0.onekeyTravelingBtn = var_1.Find(var_20_27, "onekey_travel/Image")

	local var_20_28 = arg_20_0._tf

	arg_20_0.onekeyDrawBtn = var_1.Find(var_20_28, "onekey_draw")

	local var_20_29 = arg_20_0._tf

	arg_20_0.onekeyDrawingBtn = var_1.Find(var_20_29, "onekey_draw/Image")

	local var_20_30 = arg_20_0._tf

	arg_20_0.char = var_1.Find(var_20_30, "char/char")
	setActive = var_1

	var_1(arg_20_0.char, false)

	local var_20_31 = arg_20_0._tf
	local var_20_32 = var_1.Find(var_20_31, "selectors")
	local var_20_33 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_20_0.selectorContainer = var_20_33(var_20_32, var_4(var_1_10006))

	local var_20_34 = arg_20_0._tf
	local var_20_35 = var_1.Find(var_20_34, "drawablearea")
	local var_20_36 = var_1.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_20_0.drawableAreaContainer = var_20_36(var_20_35, var_4(var_1_10006))
	arg_20_0.startPos = arg_20_0.tpl.anchoredPosition
	Vector2 = var_1
	arg_20_0.offset = var_1(0.5, 0.5)
	arg_20_0.width = arg_20_0.tpl.sizeDelta.x
	arg_20_0.height = arg_20_0.tpl.sizeDelta.y
	arg_20_0.cells = {}
	arg_20_0.selectors = {}
	arg_20_0.boxes = {}
	arg_20_0.drawableAare = {}
	arg_20_0.animals = {}
	arg_20_0.redpackets = {
		arg_20_0.redpacket
	}

	return
end

function var_0_1.didEnter(arg_21_0)
	onButton = var_1_10001

	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.backBtn

	local function var_21_2()
		if arg_21_0.opType == var_0_2 and arg_21_0.onkeyTravelProcess then
			arg_21_0.onkeyTravelProcess = false

			local var_22_0 = arg_21_0

			var_0.UpdateTravelBtnState(var_22_0)

			return
		elseif arg_21_0.opType == var_0_3 and arg_21_0.onkeyDrawPorcess then
			arg_21_0.onkeyDrawPorcess = false

			local var_22_1 = arg_21_0

			var_0.UpdateDrawBtnState(var_22_1)

			return
		end

		local var_22_2 = arg_21_0

		var_0.emit(var_22_2, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_21_0, var_21_1, var_21_2, var_1_10006)

	onButton = var_1_10001

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_0.helpBtn

	local function var_21_5()
		pg = var_2_10000

		local var_23_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_23_1 = var_0.ShowMsgBox
		local var_23_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_23_2.type = var_2_10004
		pg = var_2_10004
		var_23_2.helps = var_2_10004.gametip.worldinpicture_help.tip

		var_23_1(var_23_0, var_23_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_21_3, var_21_4, var_21_5, var_1_10006)

	onButton = var_1_10001

	local var_21_6 = arg_21_0
	local var_21_7 = arg_21_0.onekeyTravelBtn

	local function var_21_8()
		if arg_21_0.forceStopTravelPorcess then
			return
		end

		local var_24_0 = arg_21_0.data

		if var_0.IsTravelAll(var_24_0) then
			return
		end

		local var_24_1 = arg_21_0.data

		if var_0.GetTravelPoint(var_24_1) <= 0 then
			pg = var_0

			local var_24_2 = var_0.TipsMgr.GetInstance()
			local var_24_3 = var_0.ShowTips

			i18n = var_2_10003

			var_24_3(var_24_2, var_2_10003("worldinpicture_tavel_point_tip"))

			return
		end

		if arg_21_0.onkeyTravelProcess then
			arg_21_0.onkeyTravelProcess = false
			arg_21_0.forceStopTravelPorcess = true

			local var_24_4 = arg_21_0

			var_0.UpdateTravelBtnState(var_24_4)

			return
		end

		local var_24_5 = arg_21_0.data
		local var_24_6, var_24_7 = var_0.FindNextTravelable(var_24_5)

		if var_24_6 and var_24_7 then
			arg_21_0.onkeyTravelProcess = true

			local var_24_8 = arg_21_0

			var_2.UpdateTravelBtnState(var_24_8)

			local var_24_9 = arg_21_0
			local var_24_10 = var_2.emit

			WorldInPictureMediator = var_2_10005

			var_24_10(var_24_9, var_2_10005.ON_AUTO_TRAVEL, var_24_6.x, var_24_6.y, var_24_7)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_21_6, var_21_7, var_21_8, var_1_10006)

	onButton = var_1_10001

	local var_21_9 = arg_21_0
	local var_21_10 = arg_21_0.onekeyDrawBtn

	local function var_21_11()
		if arg_21_0.forceStopDrawPorcess then
			return
		end

		local var_25_0 = arg_21_0.data

		if var_0.IsDrawAll(var_25_0) then
			return
		end

		local var_25_1 = arg_21_0.data

		if var_0.GetDrawPoint(var_25_1) <= 0 then
			pg = var_0

			local var_25_2 = var_0.TipsMgr.GetInstance()
			local var_25_3 = var_0.ShowTips

			i18n = var_2_10003

			var_25_3(var_25_2, var_2_10003("worldinpicture_draw_point_tip"))

			return
		end

		if arg_21_0.onkeyDrawPorcess then
			arg_21_0.onkeyDrawPorcess = false
			arg_21_0.forceStopDrawPorcess = true

			local var_25_4 = arg_21_0

			var_0.UpdateDrawBtnState(var_25_4)

			return
		end

		local var_25_5 = arg_21_0.data
		local var_25_6, var_25_7 = var_0.FindNextDrawableAreaHead(var_25_5)

		if var_25_6 and var_25_7 then
			arg_21_0.onkeyDrawPorcess = true

			local var_25_8 = arg_21_0

			var_2.UpdateDrawBtnState(var_25_8)

			local var_25_9 = arg_21_0
			local var_25_10 = var_2.emit

			WorldInPictureMediator = var_2_10005

			var_25_10(var_25_9, var_2_10005.ON_AUTO_DRAW, var_25_6.x, var_25_6.y, var_25_7)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_21_9, var_21_10, var_21_11, var_1_10006)

	arg_21_0.opType = var_0_2
	onButton = var_1

	local var_21_12 = arg_21_0
	local var_21_13 = arg_21_0.onDisable

	local function var_21_14()
		pg = var_2_10000

		local var_26_0 = var_2_10000.TipsMgr.GetInstance()
		local var_26_1 = var_0.ShowTips

		i18n = var_2_10003

		var_26_1(var_26_0, var_2_10003("worldinpicture_not_area_can_draw"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_21_12, var_21_13, var_21_14, var_1_10006)

	onButton = var_1

	local var_21_15 = arg_21_0
	local var_21_16 = arg_21_0.btnOn

	local function var_21_17()
		if arg_21_0.opType == var_0_2 and arg_21_0.onkeyTravelProcess then
			arg_21_0.onkeyTravelProcess = false

			local var_27_0 = arg_21_0

			var_0.UpdateTravelBtnState(var_27_0)

			return
		elseif arg_21_0.opType == var_0_3 and arg_21_0.onkeyDrawPorcess then
			arg_21_0.onkeyDrawPorcess = false

			local var_27_1 = arg_21_0

			var_0.UpdateDrawBtnState(var_27_1)

			return
		end

		if arg_21_0.inAniming then
			return
		end

		arg_21_0.opType = var_0_3

		local var_27_2 = arg_21_0

		var_0.UpdateSwitcherState(var_27_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_21_15, var_21_16, var_21_17, var_1_10006)

	onButton = var_1

	local var_21_18 = arg_21_0
	local var_21_19 = arg_21_0.btnOff

	local function var_21_20()
		if arg_21_0.opType == var_0_2 and arg_21_0.onkeyTravelProcess then
			arg_21_0.onkeyTravelProcess = false

			local var_28_0 = arg_21_0

			var_0.UpdateTravelBtnState(var_28_0)

			return
		elseif arg_21_0.opType == var_0_3 and arg_21_0.onkeyDrawPorcess then
			arg_21_0.onkeyDrawPorcess = false

			local var_28_1 = arg_21_0

			var_0.UpdateDrawBtnState(var_28_1)

			return
		end

		if arg_21_0.inAniming then
			return
		end

		arg_21_0.opType = var_0_2

		local var_28_2 = arg_21_0

		var_0.UpdateSwitcherState(var_28_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_21_18, var_21_19, var_21_20, var_1_10006)
	arg_21_0:UpdateSwitcherState()
	arg_21_0:InitView()

	return
end

function var_0_1.UpdateDrawBtnState(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.onekeyDrawingBtn, arg_29_0.onkeyDrawPorcess)

	return
end

function var_0_1.UpdateTravelBtnState(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.onekeyTravelingBtn, arg_30_0.onkeyTravelProcess)

	return
end

function var_0_1.GetRecordCharPos(arg_31_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_31_0 = var_1_10001(var_1_10003)
	local var_31_1 = var_1.getRawData(var_31_0).id

	PlayerPrefs = var_1_10002

	local var_31_2 = var_1_10002.GetString("WorldInPictureScene_1" .. var_31_1, "0#0")

	string = var_31_0

	local var_31_3 = var_31_0.split(var_31_2, "#")

	Vector2 = var_4
	tonumber = var_6

	local var_31_4 = var_6(var_31_3[1])

	tonumber = var_1_10007

	return var_4(var_31_4, var_1_10007(var_31_3[2]))
end

function var_0_1.SaveCharPosition(arg_32_0, arg_32_1, arg_32_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_32_0 = var_1_10003(var_1_10005)
	local var_32_1 = var_3.getRawData(var_32_0).id

	PlayerPrefs = var_1_10004

	var_1_10004.SetString("WorldInPictureScene_1" .. var_32_1, arg_32_1 .. "#" .. arg_32_2)

	PlayerPrefs = var_4

	var_4.Save()

	return
end

function var_0_1.moveChar(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	LeanTween = var_1_10004

	local var_33_0 = var_1_10004.isTweening

	go = var_1_10006

	local var_33_1

	if var_33_0(var_1_10006(arg_33_0.char)) then
		LeanTween = var_33_1
		var_33_1 = var_33_1.cancel
		go = var_6

		var_33_1(var_6(arg_33_0.char))
	end

	isActive = var_33_1

	if var_33_1(arg_33_0.char) then
		arg_33_0:hideChar(function()
			local var_34_0 = arg_33_0

			var_0.showChar(var_34_0, arg_33_1, arg_33_2, arg_33_3)

			return
		end)
	else
		arg_33_0:showChar(arg_33_1, arg_33_2, arg_33_3)
	end

	return
end

function var_0_1.showChar(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_0.char.transform

	Vector3 = var_1_10005
	var_35_0.localPosition = var_1_10005(arg_35_1, arg_35_2 + 50)
	setActive = var_35_0

	var_35_0(arg_35_0.char, true)

	LeanTween = var_35_0

	local var_35_1 = var_35_0.value

	go = var_6

	local var_35_2 = var_35_1(var_6(arg_35_0.char), 0, 1, 0.2)
	local var_35_3 = var_4.setOnUpdate

	System = var_7

	var_35_3(var_35_2, var_7.Action_float(function(arg_36_0)
		GetOrAddComponent = var_2_10001

		local var_36_0 = arg_35_0.char

		typeof = var_2_10004
		CanvasGroup = var_2_10006
		var_2_10001(var_36_0, var_2_10004(var_2_10006)).alpha = arg_36_0

		return
	end))

	LeanTween = var_35_3

	local var_35_4 = var_35_3.moveLocal

	go = var_35_2

	local var_35_5 = var_35_2(arg_35_0.char)

	Vector3 = var_7

	local var_35_6 = var_35_4(var_35_5, var_7(arg_35_1, arg_35_2, 0), 0.2)
	local var_35_7 = var_4.setOnComplete

	System = var_7

	var_35_7(var_35_6, var_7.Action(function()
		if arg_35_3 then
			arg_35_3()
		end

		return
	end))

	return
end

function var_0_1.hideChar(arg_38_0, arg_38_1)
	LeanTween = var_1_10002

	local var_38_0 = var_1_10002.value

	go = var_1_10004

	local var_38_1 = var_38_0(var_1_10004(arg_38_0.char), 1, 0, 0.2)
	local var_38_2 = var_2.setOnUpdate

	System = var_5

	var_38_2(var_38_1, var_5.Action_float(function(arg_39_0)
		GetOrAddComponent = var_2_10001

		local var_39_0 = arg_38_0.char

		typeof = var_2_10004
		CanvasGroup = var_2_10006
		var_2_10001(var_39_0, var_2_10004(var_2_10006)).alpha = arg_39_0

		return
	end))

	local var_38_3 = arg_38_0.char.transform.localPosition

	LeanTween = var_1_10003

	local var_38_4 = var_1_10003.moveLocal

	go = var_5

	local var_38_5 = var_5(arg_38_0.char)

	Vector3 = var_6

	local var_38_6 = var_38_4(var_38_5, var_6(var_38_3.x, var_38_3.y + 50, 0), 0.2)
	local var_38_7 = var_3.setOnComplete

	System = var_6

	var_38_7(var_38_6, var_6.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_38_0.char, false)

		if arg_38_1 then
			arg_38_1()
		end

		return
	end))

	return
end

function var_0_1.UpdateChar(arg_41_0, arg_41_1, arg_41_2)
	Vector2 = var_1_10003

	if arg_41_1 == var_1_10003.zero then
		setActive = var_3

		var_3(arg_41_0.char, false)

		return
	end

	LeanTween = var_3

	if var_3.isTweening(arg_41_0.char) then
		LeanTween = var_3

		var_3.cancel(arg_41_0.char)
	end

	local var_41_0 = arg_41_0.data

	if var_3.IsTravelAll(var_41_0) then
		setActive = var_1_10004

		var_1_10004(arg_41_0.char, false)

		return
	end

	local var_41_1 = arg_41_0.cells[arg_41_1.x][arg_41_1.y].gameObject.transform.anchoredPosition

	Vector2 = var_1_10006

	local var_41_2 = var_1_10006(var_41_1.x, var_41_1.y - 50)

	if arg_41_2 then
		arg_41_0:moveChar(var_41_2.x, var_41_2.y, function()
			return
		end)
	else
		arg_41_0.char.transform.localPosition = var_41_2
	end

	return
end

function var_0_1.UpdateSwitcherState(arg_43_0)
	local var_43_0 = arg_43_0.opType == var_0_3
	local var_43_1 = arg_43_0.data
	local var_43_2 = var_2.AnyAreaCanDraw(var_43_1)

	setActive = var_1_10003

	var_1_10003(arg_43_0.btnOff, var_43_0)

	setActive = var_1_10003

	var_1_10003(arg_43_0.onDisable, not var_43_0 and not var_43_2)

	setActive = var_1_10003

	var_1_10003(arg_43_0.btnOn, not var_43_0 and var_43_2)

	setActive = var_1_10003

	var_1_10003(arg_43_0.onekeyTravelBtn, not var_43_0)

	setActive = var_1_10003

	var_1_10003(arg_43_0.onekeyDrawBtn, var_43_0)

	setActive = var_1_10003

	local var_43_3 = arg_43_0.char
	local var_43_5

	if not var_43_0 then
		local var_43_4 = arg_43_0.data

		var_43_5 = not var_6.IsTravelAll(var_43_4)
	else
		var_43_5 = false
	end

	if false then
		var_43_5 = true
	end

	var_1_10003(var_43_3, var_43_5)

	arg_43_0.selectorContainer.alpha = var_43_0 and 0 or 1
	arg_43_0.drawableAreaContainer.alpha = var_43_0 and 1 or 0

	if var_43_0 then
		arg_43_0:UpdateDrawableAreas()
	end

	return
end

function var_0_1.InitView(arg_44_0)
	local var_44_0 = arg_44_0.data
	local var_44_1, var_44_2 = var_1.GetMapRowAndColumn(var_44_0)
	local var_44_3 = {}

	for iter_44_0 = 1, var_44_1 do
		table = var_1_10008

		var_1_10008.insert(var_44_3, function(arg_45_0)
			for iter_45_0 = var_44_2, 1, -1 do
				local var_45_0 = arg_44_0

				var_5.CreateCell(var_45_0, iter_44_0, iter_45_0, (iter_44_0 - 1) * var_44_2 + iter_45_0)
			end

			onNextTick = var_1

			var_1(arg_45_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_44_3, function()
		local var_46_0 = arg_44_0

		var_0.InitLines(var_46_0)

		local var_46_1 = arg_44_0
		local var_46_2 = var_0.UpdateChar
		local var_46_3 = arg_44_0

		var_46_2(var_46_1, var_3.GetRecordCharPos(var_46_3))

		return
	end)
	arg_44_0:UpdatePoints()

	return
end

function var_0_1.InitLines(arg_47_0)
	local var_47_0 = arg_47_0.data
	local var_47_1, var_47_2 = var_1.GetMapRowAndColumn(var_47_0)
	local var_47_3 = arg_47_0.tpl.sizeDelta.y * var_47_1 + 10

	for iter_47_0 = 1, var_47_2 - 1 do
		if iter_47_0 ~= 1 or not arg_47_0.lineVecTpl then
			Object = var_1_10008
			var_1_10008 = var_1_10008.Instantiate(arg_47_0.lineVecTpl, arg_47_0.lineVecTpl.parent)
		end

		Vector2 = var_1_10009
		var_1_10008.sizeDelta = var_1_10009(var_1_10008.sizeDelta.x, var_47_3)
		var_1_10010 = arg_47_0.cells[1][iter_47_0].gameObject.transform.anchoredPosition.x + var_1_10009.gameObject.transform.sizeDelta.x * 0.5
		Vector2 = var_11
		var_1_10008.anchoredPosition = var_11(var_1_10010 + arg_47_0.offset.x, var_1_10008.anchoredPosition.y)
	end

	local var_47_4 = arg_47_0.tpl.sizeDelta.x * var_47_2 + 20

	for iter_47_1 = 1, var_47_1 - 1 do
		if iter_47_1 ~= 1 or not arg_47_0.lineHrzTpl then
			Object = var_1_10009
			var_1_10009 = var_1_10009.Instantiate(arg_47_0.lineHrzTpl, arg_47_0.lineHrzTpl.parent)
		end

		Vector2 = var_1_10010
		var_1_10009.sizeDelta = var_1_10010(var_1_10009.sizeDelta.x, var_47_4)

		local var_47_5 = arg_47_0.cells[iter_47_1][1].gameObject.transform.anchoredPosition.y - var_1_10010.gameObject.transform.sizeDelta.y * 0.5

		Vector2 = var_12
		var_1_10009.anchoredPosition = var_12(var_1_10009.anchoredPosition.x, var_47_5 + arg_47_0.offset.y)
	end

	return
end

function var_0_1.CreateCell(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if arg_48_0.exited then
		return
	end

	local var_48_0

	if arg_48_2 ~= 1 or arg_48_1 ~= 1 or not arg_48_0.tpl then
		Object = var_48_0
		var_48_0 = var_48_0.Instantiate(arg_48_0.tpl, arg_48_0.tpl.parent).transform
	end

	local var_48_1 = arg_48_0.startPos.x + (arg_48_2 - 1) * (arg_48_0.width + arg_48_0.offset.x)
	local var_48_2 = arg_48_0.startPos.y - (arg_48_1 - 1) * (arg_48_0.height + arg_48_0.offset.y)

	LoadSpriteAtlasAsync = var_7

	var_7("ui/WorldInPicture_atlas", "view_" .. arg_48_3 - 1, function(arg_49_0)
		if arg_48_0.exited then
			return
		end

		local var_49_0 = var_48_0
		local var_49_1 = var_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10006

		local var_49_2 = var_49_1(var_49_0, var_2_10004(var_2_10006))

		var_49_2.sprite = arg_49_0

		var_49_2:SetNativeSize()

		local var_49_3 = var_48_0

		Vector2 = var_49_0
		var_49_3.anchoredPosition = var_49_0(var_48_1, var_48_2)

		local var_49_4 = arg_48_0

		var_2.CreateSelector(var_49_4, arg_48_1, arg_48_2)

		local var_49_5 = arg_48_0

		var_2.CreateBox(var_49_5, arg_48_1, arg_48_2)

		local var_49_6 = arg_48_0

		var_2.CreateDrawableArea(var_49_6, arg_48_1, arg_48_2)

		local var_49_7 = arg_48_0

		var_2.CreateAnimal(var_49_7, arg_48_1, arg_48_2, true)

		return
	end)

	local var_48_3

	if not arg_48_0.cells[arg_48_1] then
		var_48_3 = arg_48_0.cells
		var_48_3[arg_48_1] = {}
	end

	onButton = var_48_3

	local var_48_4 = arg_48_0
	local var_48_5 = var_48_0

	local function var_48_6()
		if arg_48_0.opType == var_0_2 then
			if arg_48_0.onkeyTravelProcess then
				arg_48_0.onkeyTravelProcess = false

				local var_50_0 = arg_48_0

				var_0.UpdateTravelBtnState(var_50_0)

				return
			end

			local var_50_1 = arg_48_0.data

			if var_0.IsTravelAll(var_50_1) then
				return
			end

			local var_50_2 = arg_48_0.data

			if var_0.GetTravelPoint(var_50_2) <= 0 then
				pg = var_0

				local var_50_3 = var_0.TipsMgr.GetInstance()
				local var_50_4 = var_0.ShowTips

				i18n = var_2_10003

				var_50_4(var_50_3, var_2_10003("worldinpicture_tavel_point_tip"))

				return
			end

			local var_50_5 = arg_48_0.data

			if var_0.CanSelect(var_50_5, arg_48_1, arg_48_2) then
				local var_50_6 = arg_48_0
				local var_50_7 = var_0.emit

				WorldInPictureMediator = var_2_10003

				var_50_7(var_50_6, var_2_10003.ON_TRAVEL, arg_48_1, arg_48_2, arg_48_3)
			end
		elseif arg_48_0.opType == var_0_3 then
			if arg_48_0.onkeyDrawPorcess then
				arg_48_0.onkeyDrawPorcess = false

				local var_50_8 = arg_48_0

				var_0.UpdateDrawBtnState(var_50_8)

				return
			end

			local var_50_9 = arg_48_0.data

			if var_0.IsDrawAll(var_50_9) then
				return
			end

			local var_50_10 = arg_48_0.data

			if var_0.GetDrawPoint(var_50_10) <= 0 then
				pg = var_0

				local var_50_11 = var_0.TipsMgr.GetInstance()
				local var_50_12 = var_0.ShowTips

				i18n = var_2_10003

				var_50_12(var_50_11, var_2_10003("worldinpicture_draw_point_tip"))

				return
			end

			local var_50_13 = arg_48_0.data

			if var_0.CanDraw(var_50_13, arg_48_1, arg_48_2) then
				local var_50_14 = arg_48_0.data
				local var_50_15, var_50_16, var_50_17 = var_0.Convert2DrawAreaHead(var_50_14, arg_48_1, arg_48_2)
				local var_50_18 = arg_48_0
				local var_50_19 = var_3.emit

				WorldInPictureMediator = var_2_10006

				var_50_19(var_50_18, var_2_10006.ON_DRAW, var_50_15, var_50_16, var_50_17)
			end
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_48_3(var_48_4, var_48_5, var_48_6, var_1_10012)

	local var_48_7 = var_48_0
	local var_48_8 = var_48_0.GetComponent

	typeof = var_48_5
	CanvasGroup = var_1_10012

	local var_48_9 = var_48_8(var_48_7, var_48_5(var_1_10012))
	local var_48_10 = arg_48_0.data

	var_48_9.alpha = var_8.IsOpened(var_48_10, arg_48_1, arg_48_2) and 1 or 0
	arg_48_0.cells[arg_48_1][arg_48_2] = var_48_9

	return
end

function var_0_1.CreateSelector(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0.data

	if not var_3.CanSelect(var_51_0, arg_51_1, arg_51_2) then
		return
	end

	table = var_1_10004

	local var_51_1

	if var_1_10004.getCount(arg_51_0.selectors) ~= 0 or not arg_51_0.selectorTpl then
		Object = var_51_1
		var_51_1 = var_51_1.Instantiate(arg_51_0.selectorTpl, arg_51_0.selectorTpl.parent).transform
	end

	local var_51_2 = arg_51_0.cells[arg_51_1][arg_51_2].gameObject.transform.anchoredPosition

	Vector2 = var_7
	var_51_1.anchoredPosition = var_51_2 + var_7(-5, -4.8)

	local var_51_3 = var_51_1
	local var_51_4 = var_51_1.GetComponent

	typeof = var_9
	CanvasGroup = var_1_10011

	local var_51_5 = var_51_4(var_51_3, var_9(var_1_10011))

	var_51_5.alpha = 1

	if not arg_51_0.selectors[arg_51_1] then
		arg_51_0.selectors[arg_51_1] = {}
	end

	arg_51_0.selectors[arg_51_1][arg_51_2] = var_51_5

	return
end

function var_0_1.CreateBox(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0.data

	if var_3.ExistBox(var_52_0, arg_52_1, arg_52_2) then
		local var_52_1 = arg_52_0.data

		if var_1_10004.IsOpened(var_52_1, arg_52_1, arg_52_2) then
			return
		end

		table = var_1_10004

		local var_52_2

		if var_1_10004.getCount(arg_52_0.boxes) ~= 0 or not arg_52_0.boxTpl then
			Object = var_52_2
			var_52_2 = var_52_2.Instantiate(arg_52_0.boxTpl, arg_52_0.boxTpl.parent).transform
		end

		local var_52_3 = var_52_2
		local var_52_4 = var_52_2.GetComponent

		typeof = var_1_10008
		CanvasGroup = var_1_10010

		local var_52_5 = var_52_4(var_52_3, var_1_10008(var_1_10010))

		var_52_5.alpha = 1
		var_52_2.anchoredPosition = arg_52_0.cells[arg_52_1][arg_52_2].gameObject.transform.anchoredPosition

		if not arg_52_0.boxes[arg_52_1] then
			arg_52_0.boxes[arg_52_1] = {}
		end

		arg_52_0.boxes[arg_52_1][arg_52_2] = var_52_5

		return
	end
end

function var_0_1.CreateDrawableArea(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0.data

	if var_3.GetDrawableArea(var_53_0, arg_53_1, arg_53_2) then
		local var_53_1 = arg_53_0.data

		if var_1_10004.IsDrawed(var_53_1, arg_53_1, arg_53_2) then
			return
		end

		table = var_1_10004

		local var_53_2

		if var_1_10004.getCount(arg_53_0.drawableAare) ~= 0 or not arg_53_0.areaTpl then
			Object = var_53_2
			var_53_2 = var_53_2.Instantiate(arg_53_0.areaTpl, arg_53_0.areaTpl.parent).transform
		end

		local var_53_3 = var_3[#var_3] - var_3[1]

		Vector2 = var_6

		local var_53_4 = var_53_3 + var_6(1, 1)
		local var_53_5 = arg_53_0.cells[arg_53_1][arg_53_2]
		local var_53_6 = arg_53_0.tpl.sizeDelta * 0.5
		local var_53_7 = var_53_5.gameObject.transform.anchoredPosition

		Vector2 = var_9
		var_53_2.anchoredPosition = var_53_7 - var_9(var_53_6.x, -var_53_6.y)

		local var_53_8 = var_53_2
		local var_53_9 = var_53_2.GetComponent

		typeof = var_11
		CanvasGroup = var_1_10013

		local var_53_10 = var_53_9(var_53_8, var_11(var_1_10013))

		var_53_10.alpha = 1

		if not arg_53_0.drawableAare[arg_53_1] then
			arg_53_0.drawableAare[arg_53_1] = {}
		end

		arg_53_0.drawableAare[arg_53_1][arg_53_2] = var_53_10

		return
	end
end

function var_0_1.UpdateDrawableAreas(arg_54_0)
	local var_54_0 = arg_54_0.data
	local var_54_1 = var_1.GetDrawableAreasState(var_54_0)

	ipairs = var_1_10002

	for iter_54_0, iter_54_1 in var_1_10002(var_54_1) do
		local var_54_2 = iter_54_1.position

		if arg_54_0.drawableAare[var_54_2.x] and arg_54_0.drawableAare[var_54_2.x][var_54_2.y] then
			arg_54_0.drawableAare[var_54_2.x][var_54_2.y].alpha = iter_54_1.open and 1 or 0
		end
	end

	return
end

function var_0_1.CreateAnimal(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local var_55_0 = arg_55_0.data

	if var_5.GetDrawableArea(var_55_0, arg_55_1, arg_55_2) then
		local var_55_1 = arg_55_0.data

		if not var_1_10006.IsDrawed(var_55_1, arg_55_1, arg_55_2) then
			return
		end

		table = var_1_10006

		local var_55_2

		if var_1_10006.getCount(arg_55_0.animals) ~= 0 or not arg_55_0.animalTpl then
			Object = var_55_2
			var_55_2 = var_55_2.Instantiate(arg_55_0.animalTpl, arg_55_0.animalTpl.parent).transform
		end

		local var_55_3 = arg_55_0.data
		local var_55_4 = var_7.GetDrawAnimData(var_55_3, arg_55_1, arg_55_2)

		Vector2 = var_8

		local var_55_5 = var_8(var_55_4[2], var_55_4[3])

		LoadSpriteAtlasAsync = var_55_3

		var_55_3("ui/WorldInPicture_atlas", var_55_4[1], function(arg_56_0)
			if arg_55_0.exited then
				return
			end

			local var_56_0 = var_55_2
			local var_56_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10006

			local var_56_2 = var_56_1(var_56_0, var_2_10004(var_2_10006))

			var_56_2.sprite = arg_56_0

			var_56_2:SetNativeSize()

			local var_56_3 = var_55_2

			Vector3 = var_56_0

			local var_56_4

			if not var_55_4[4] then
				var_56_4 = 1
			end

			local var_56_5

			if not var_55_4[4] then
				var_56_5 = 1
			end

			var_56_3.localScale = var_56_0(var_56_4, var_56_5, 1)

			if arg_55_4 then
				arg_55_4(var_55_2)
			end

			return
		end)

		Vector3 = var_55_3
		var_55_2.localScale = var_55_3.zero
		var_55_2.localPosition = var_55_5

		if not arg_55_0.animals[arg_55_1] then
			arg_55_0.animals[arg_55_1] = {}
		end

		local var_55_6 = var_55_2
		local var_55_7 = var_55_2.GetComponent

		typeof = var_12
		CanvasGroup = var_1_10014

		local var_55_8 = var_55_7(var_55_6, var_12(var_1_10014))

		var_55_8.alpha = arg_55_3 and 1 or 0
		arg_55_0.animals[arg_55_1][arg_55_2] = var_55_8

		return
	end
end

local function var_0_4(arg_57_0, arg_57_1)
	return "<color=#DAC6B3>" .. arg_57_0 .. "</color><color=#A38052>/" .. arg_57_1 .. "</color>"
end

function var_0_1.UpdatePoints(arg_58_0)
	local var_58_0 = arg_58_0.travelPointTxt
	local var_58_1 = arg_58_0.data

	var_58_0.text = var_2.GetTravelPoint(var_58_1)

	local var_58_2 = arg_58_0.drawPointTxt
	local var_58_3 = arg_58_0.data

	var_58_2.text = var_2.GetDrawPoint(var_58_3)

	local var_58_4 = arg_58_0.travelProgressTxt
	local var_58_5 = var_0_4
	local var_58_6 = arg_58_0.data
	local var_58_7 = var_4.GetTravelProgress(var_58_6)
	local var_58_8 = arg_58_0.data

	var_58_4.text = var_58_5(var_58_7, var_5.GetMaxTravelCnt(var_58_8))

	local var_58_9 = arg_58_0.drawProgressTxt
	local var_58_10 = var_0_4
	local var_58_11 = arg_58_0.data
	local var_58_12 = var_4.GetDrawProgress(var_58_11)
	local var_58_13 = arg_58_0.data

	var_58_9.text = var_58_10(var_58_12, var_5.GetMaxDrawCnt(var_58_13))

	return
end

function var_0_1.DoAnimtion(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if arg_59_0.timer then
		local var_59_0 = arg_59_0.timer

		var_4.Stop(var_59_0)

		arg_59_0.timer = nil
	end

	local function var_59_1(arg_60_0)
		arg_59_0[arg_59_1] = arg_60_0
		arg_60_0.anchoredPosition = arg_59_2
		setActive = var_1

		var_1(arg_60_0, true)

		local var_60_0 = arg_59_0

		Timer = var_2
		var_60_0.timer = var_2.New(function()
			setActive = var_3_10000

			var_3_10000(arg_60_0, false)

			local var_61_0 = arg_59_0.timer

			var_0.Stop(var_61_0)

			arg_59_0.timer = nil

			arg_59_3()

			return
		end, 0.6, 1)

		local var_60_1 = arg_59_0.timer

		var_1.Start(var_60_1)

		return
	end

	if not arg_59_0[arg_59_1] then
		arg_59_0:LoadEffect(arg_59_1, var_59_1)
	else
		var_59_1(var_5)
	end

	return
end

function var_0_1.GetRedPacket(arg_62_0)
	local var_62_0

	if #arg_62_0.redpackets <= 0 then
		Object = var_62_0
		var_62_0 = var_62_0.Instantiate(arg_62_0.redpacket, arg_62_0.redpacket.parent)
		table = var_2

		var_2.insert(arg_62_0.redpackets, var_62_0.transform)
	end

	table = var_62_0

	local var_62_1 = var_62_0.remove(arg_62_0.redpackets, 1)

	setActive = var_2

	var_2(var_62_1, true)

	return var_62_1
end

function var_0_1.LoadEffect(arg_63_0, arg_63_1, arg_63_2)
	ResourceMgr = var_1_10003

	local var_63_0 = var_1_10003.Inst
	local var_63_1 = var_3.getAssetAsync
	local var_63_2 = "UI/" .. arg_63_1
	local var_63_3 = ""

	UnityEngine = var_1_10008

	var_63_1(var_63_0, var_63_2, var_63_3, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_64_0)
		if arg_63_0.exited then
			return
		end

		local var_64_0 = arg_63_2

		Object = var_2_10003

		var_64_0(var_2_10003.Instantiate(arg_64_0, arg_63_0._tf).transform)

		return
	end), true, true)

	return
end

function var_0_1.willExit(arg_65_0)
	ipairs = var_1_10001

	for iter_65_0, iter_65_1 in var_1_10001(arg_65_0.redpackets) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_65_1.gameObject) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_65_1)
		end
	end

	LeanTween = var_1

	if var_1.isTweening(arg_65_0.char) then
		LeanTween = var_1

		var_1.cancel(arg_65_0.char)
	end

	if arg_65_0.timer then
		local var_65_0 = arg_65_0.timer

		var_1.Stop(var_65_0)

		arg_65_0.timer = nil
	end

	Input = var_1
	var_1.multiTouchEnabled = true

	return
end

return var_0_1
