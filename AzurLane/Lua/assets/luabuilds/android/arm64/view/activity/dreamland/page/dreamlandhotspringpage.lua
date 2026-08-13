class = var_0_10000

local var_0_0 = "DreamlandHotSpringPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "DreamlandHotSpringUI"
end

function var_0_1.OnLoaded(arg_2_0)
	arg_2_0.slots = {}
	UIItemList = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "bg/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_0(var_2_2, var_4.Find(var_2_3, "bg/list/tpl"))
	arg_2_0.iconList = {
		"icon_1",
		"icon_2",
		"icon_3"
	}
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "bg/list/tpl/lock/Text")

	i18n = var_4

	var_1(var_2_5, var_4("dreamland_spring_lock_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.bind

	DreamlandScene = var_3_1

	var_3_4(var_3_3, var_3_1.ON_SPRING_DATA_UPDATE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.UpdateSpringActUpdate(var_5_0, arg_5_1.data)

		return
	end)
	arg_3_0:InitSlots()

	return
end

function var_0_1.UpdateSpringActUpdate(arg_6_0, arg_6_1)
	if not arg_6_0:isShowing() then
		return
	end

	arg_6_0:Flush(arg_6_1)

	return
end

function var_0_1.InitSlots(arg_7_0)
	local var_7_0 = arg_7_0.uiItemList

	var_1.make(var_7_0, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_7_0

			var_3.UpdateSlot(var_8_0, arg_8_2, arg_8_1)
		end

		return
	end)

	return
end

function var_0_1.Show(arg_9_0, arg_9_1)
	var_0_1.super.Show(arg_9_0)

	pg = var_2

	local var_9_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_9_0, arg_9_0._tf)
	arg_9_0:Flush(arg_9_1)

	return
end

function var_0_1.Flush(arg_10_0, arg_10_1)
	arg_10_0.shipList = arg_10_1:GetHotSpringData()

	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.GetHotSpringMaxCnt(var_10_0)
	local var_10_2 = arg_10_1:GetHotSpringAddition()

	setText = var_10_0

	local var_10_3 = arg_10_0._tf
	local var_10_4 = var_6.Find(var_10_3, "bg/Text")

	i18n = var_1_10007

	var_10_0(var_10_4, var_1_10007("dreamland_spring_tip", var_10_2))

	arg_10_0.gameData = arg_10_1

	local var_10_5 = arg_10_0.uiItemList

	var_4.align(var_10_5, var_10_1)

	return
end

function var_0_1.UpdateSlot(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.shipList[arg_11_2 + 1]
	local var_11_1 = arg_11_0.gameData
	local var_11_2 = var_4.IsLockSpringSlot(var_11_1, arg_11_2 + 1)
	local var_11_3 = var_11_0 and var_11_0 > 0

	setActive = var_11_1

	var_11_1(arg_11_1:Find("add"), not var_11_2 and not var_11_3)

	setActive = var_11_1

	var_11_1(arg_11_1:Find("ship"), not var_11_2 and var_11_3)

	setActive = var_11_1

	var_11_1(arg_11_1:Find("lock"), var_11_2)

	onButton = var_11_1

	local var_11_4 = arg_11_0
	local var_11_5 = arg_11_1

	local function var_11_6()
		if var_11_2 then
			return
		end

		local var_12_0

		if var_11_3 then
			getProxy = var_1
			BayProxy = var_2_10003

			local var_12_1 = var_1(var_2_10003)

			var_12_0 = var_1.getShipById(var_12_1, var_11_0)
		end

		local var_12_2 = arg_11_0
		local var_12_3 = var_1.emit

		DreamlandScene = var_2_10004

		var_12_3(var_12_2, var_2_10004.ON_SPRING_OP)

		local var_12_4 = arg_11_0.gameData
		local var_12_5 = var_1.GetUnlockSpringCnt(var_12_4)
		local var_12_6 = arg_11_0
		local var_12_7 = var_2.emit

		DreamlandMediator = var_2_10005

		var_12_7(var_12_6, var_2_10005.HOT_SPRING_OP, arg_11_2 + 1, var_12_5, var_12_0)

		return
	end

	SFX_PANEL = var_11

	var_11_1(var_11_4, var_11_5, var_11_6, var_11)

	if not var_11_3 then
		return
	end

	arg_11_0:UpdateShipSlot(arg_11_1, var_11_0)

	return
end

function var_0_1.UpdateShipSlot(arg_13_0, arg_13_1, arg_13_2)
	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_13_0 = var_1_10003(var_1_10005)
	local var_13_1 = var_3.RawGetShipById(var_13_0, arg_13_2)

	LoadSprite = var_1_10004

	local var_13_2 = var_1_10004("qicon/" .. var_13_1:getPrefab())
	local var_13_3 = arg_13_1:Find("ship")
	local var_13_4 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	local var_13_5 = var_13_4(var_13_3, var_8(var_1_10010))

	var_13_5.sprite = var_13_2
	math = var_13_5

	local var_13_6 = var_13_5.random(1, #arg_13_0.iconList)
	local var_13_7 = arg_13_0.iconList[var_13_6]

	GetSpriteFromAtlas = var_7

	local var_13_8 = var_7("ui/DlHotSpringUI_atlas", var_13_7)
	local var_13_9 = arg_13_1:Find("ship/icon")
	local var_13_10 = var_8.GetComponent

	typeof = var_11
	Image = var_1_10013

	local var_13_11 = var_13_10(var_13_9, var_11(var_1_10013))

	var_13_11.sprite = var_13_8

	var_13_11:SetNativeSize()

	return
end

function var_0_1.Hide(arg_14_0)
	var_0_1.super.Hide(arg_14_0)

	pg = var_1

	local var_14_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf, arg_14_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_15_0)
	if arg_15_0:isShowing() then
		arg_15_0:Hide()
	end

	return
end

return var_0_1
