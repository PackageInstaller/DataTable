pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.ToastMgr = var_0_10001("ToastMgr")
pg = var_0

local var_0_1 = var_0.ToastMgr

require = var_1

local var_0_2 = var_1("Mgr/Pool/PoolPlural")

var_0_1.TYPE_ATTIRE = "Attire"
var_0_1.TYPE_TECPOINT = "Tecpoint"
var_0_1.TYPE_TROPHY = "Trophy"
var_0_1.TYPE_META = "Meta"
var_0_1.TYPE_CRUSING = "Crusing"
var_0_1.TYPE_VOTE = "Vote"
var_0_1.TYPE_EMOJI = "Emoji"
var_0_1.TYPE_COVER = "Cover"
var_0_1.TYPE_COMBAT_UI = "CombatUI"
var_0_1.ToastInfo = {
	[var_0_1.TYPE_ATTIRE] = {
		Attire = "attire_tpl"
	},
	[var_0_1.TYPE_TECPOINT] = {
		Buff = "buff_tpl",
		Point = "point_tpl"
	},
	[var_0_1.TYPE_TROPHY] = {
		Trophy = "trophy_tpl"
	},
	[var_0_1.TYPE_META] = {
		MetaLevel = "meta_level_tpl",
		MetaExp = "meta_exp_tpl"
	},
	[var_0_1.TYPE_CRUSING] = {
		Crusing = "crusing_pt_tpl"
	},
	[var_0_1.TYPE_VOTE] = {
		Vote = "vote_tpl"
	},
	[var_0_1.TYPE_EMOJI] = {
		Emoji = "emoji_tpl"
	},
	[var_0_1.TYPE_COVER] = {
		Cover = "cover_tpl"
	},
	[var_0_1.TYPE_COMBAT_UI] = {
		CombatUI = "combatui_tpl"
	}
}

function var_0_1.Init(arg_1_0, arg_1_1)
	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("ui", "ToastUI", function(arg_2_0)
		arg_1_0._go = arg_2_0

		local var_2_0 = arg_1_0._go

		var_1.SetActive(var_2_0, false)

		arg_1_0._tf = arg_1_0._go.transform

		local var_2_1 = arg_1_0
		local var_2_2 = arg_1_0._tf

		var_2_1.container = var_2.Find(var_2_2, "container")

		local var_2_3 = arg_1_0._go.transform
		local var_2_4 = var_1.SetParent

		pg = var_2_2

		var_2_4(var_2_3, var_2_2.UIMgr.GetInstance().OverlayToast, false)

		arg_1_0.pools = {}

		local var_2_5 = {}

		pairs = var_2

		for iter_2_0, iter_2_1 in var_2(var_0_1.ToastInfo) do
			pairs = var_2_10007

			for iter_2_2, iter_2_3 in var_2_10007(iter_2_1) do
				var_2_5[iter_2_2 .. "Tpl"] = iter_2_3
			end
		end

		pairs = var_2

		for iter_2_4, iter_2_5 in var_2(var_2_5) do
			local var_2_6 = arg_1_0._tf
			local var_2_7 = var_7.Find(var_2_6, "resources/" .. iter_2_5)

			if iter_2_5 == "meta_exp_tpl" then
				local var_2_8 = var_2_7

				var_2_6 = var_2_7.Find(var_2_8, "ExpFull/Tip")
				setText = var_2_8

				local var_2_9 = var_2_6

				i18n = iter_2_3

				var_2_8(var_2_9, iter_2_3("meta_toast_fullexp"))

				local var_2_10 = var_2_7

				iter_2_3, setText = var_2_7.Find(var_2_10, "ExpAdd/Tip"), var_2_10
				i18n = var_12

				var_2_10(iter_2_3, var_12("meta_toast_tactics"))
			end

			setActive = var_2_6

			var_2_6(var_2_7, false)

			local var_2_11 = var_2_7.gameObject

			arg_1_0.pools[iter_2_4] = var_0_2.New(var_2_11, 5)
		end

		local var_2_12 = arg_1_0

		var_2.ResetUIDandHistory(var_2_12)

		if arg_1_1 then
			arg_1_1()
		end

		return
	end, true, true)

	return
end

function var_0_1.ResetUIDandHistory(arg_3_0)
	arg_3_0.completedJob = 0
	arg_3_0.actionJob = 0
	arg_3_0.buffer = {}

	return
end

function var_0_1.ShowToast(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = #arg_4_0.buffer

	table = var_1_10004

	var_1_10004.insert(arg_4_0.buffer, {
		state = 0,
		type = arg_4_1,
		info = arg_4_2
	})

	setActive = var_4

	var_4(arg_4_0._tf, true)

	if #arg_4_0.buffer == 1 or arg_4_0.buffer[var_4_0].state >= 2 then
		arg_4_0:Toast()
	end

	return
end

function var_0_1.Toast(arg_5_0)
	if arg_5_0.actionJob >= #arg_5_0.buffer then
		return
	end

	if arg_5_0.buffer[arg_5_0.actionJob] and arg_5_0.buffer[arg_5_0.actionJob].state < 2 then
		return
	elseif arg_5_0.buffer[arg_5_0.actionJob] and arg_5_0.buffer[arg_5_0.actionJob].type ~= arg_5_0.buffer[arg_5_0.actionJob + 1].type and arg_5_0.buffer[arg_5_0.actionJob].state < 3 then
		return
	end

	arg_5_0.actionJob = arg_5_0.actionJob + 1

	local var_5_0 = arg_5_0.buffer[arg_5_0.actionJob]
	local var_5_1 = arg_5_0.actionJob

	var_5_0.state = 1

	arg_5_0["Update" .. var_5_0.type](arg_5_0, var_5_0, function()
		var_5_0.state = 2

		local var_6_0 = arg_5_0

		var_0.Toast(var_6_0)

		return
	end, function()
		var_5_0.state = 3

		if arg_5_0.buffer[var_5_1 + 1] and arg_5_0.buffer[var_5_1 + 1].state < 1 then
			local var_7_0 = arg_5_0

			var_0.Toast(var_7_0)
		end

		arg_5_0.completedJob = arg_5_0.completedJob + 1

		if arg_5_0.completedJob >= #arg_5_0.buffer then
			local var_7_1 = arg_5_0

			var_0.ResetUIDandHistory(var_7_1)

			setActive = var_0

			var_0(arg_5_0._tf, false)

			pairs = var_0

			for iter_7_0, iter_7_1 in var_0(arg_5_0.pools) do
				iter_7_1:ClearItems(false)
			end
		end

		return
	end)

	return
end

function var_0_1.GetAndSet(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.pools[arg_8_1 .. "Tpl"]
	local var_8_1 = var_3.Dequeue(var_8_0)

	setActive = var_8_0

	var_8_0(var_8_1, true)

	setParent = var_8_0

	var_8_0(var_8_1, arg_8_2)

	local var_8_2 = var_8_1.transform

	var_4.SetAsLastSibling(var_8_2)

	return var_8_1
end

function var_0_1.UpdateAttire(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:GetAndSet(arg_9_1.type, arg_9_0.container)
	local var_9_1 = var_4.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10008

	local var_9_2 = var_9_1(var_9_0, var_7(var_1_10008))

	var_5.SetTriggerEvent(var_9_2, function(arg_10_0)
		if arg_9_2 then
			arg_9_2()
		end

		local var_10_0 = var_0

		var_1.SetTriggerEvent(var_10_0, nil)

		return
	end)
	var_5:SetEndEvent(function(arg_11_0)
		setActive = var_2_10001

		var_2_10001(var_0, false)

		local var_11_0 = arg_9_0.pools[arg_9_1.type .. "Tpl"]

		var_1.Enqueue(var_11_0, var_0)

		local var_11_1 = var_0

		var_1.SetEndEvent(var_11_1, nil)

		if arg_9_3 then
			arg_9_3()
		end

		return
	end)

	local var_9_3 = var_4
	local var_9_4 = var_4.GetComponent

	typeof = var_8
	Animation = var_1_10009

	local var_9_5 = var_9_4(var_9_3, var_8(var_1_10009))

	var_6.Play(var_9_5, "attire")

	local var_9_6 = arg_9_1.info

	assert = var_9_5
	isa = var_8

	local var_9_7 = var_9_6

	AttireFrame = var_1_10010

	var_9_5(var_8(var_9_7, var_1_10010))

	local var_9_8 = var_9_6
	local var_9_9 = var_9_6.getType(var_9_8)

	setActive = var_9_8

	local var_9_10 = var_4.transform
	local var_9_11 = var_9.Find(var_9_10, "bg/icon_frame")

	AttireConst = var_9_10

	var_9_8(var_9_11, var_9_9 == var_9_10.TYPE_ICON_FRAME)

	setActive = var_9_8

	local var_9_12 = var_4.transform
	local var_9_13 = var_9.Find(var_9_12, "bg/chat_frame")

	AttireConst = var_9_12

	var_9_8(var_9_13, var_9_9 == var_9_12.TYPE_CHAT_FRAME)

	setText = var_9_8

	local var_9_14 = var_4.transform
	local var_9_15 = var_9.Find(var_9_14, "bg/Text")

	HXSet = var_9_14

	var_9_8(var_9_15, var_9_14.hxLan(var_9_6:getConfig("name")))

	return
end

function var_0_1.UpdateCombatUI(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.GetAndSet(var_12_0, arg_12_1.type, arg_12_0.container)

	pg = var_12_0

	local var_12_2 = var_12_0.item_data_battleui[arg_12_1.info.id]

	LoadImageSpriteAsync = var_6

	local var_12_3 = "Props/" .. var_12_2.display_icon
	local var_12_4 = var_12_1.transform

	var_6(var_12_3, var_8.Find(var_12_4, "content/icon"), true)

	setText = var_6

	local var_12_5 = var_12_1.transform

	var_6(var_7.Find(var_12_5, "content/name"), var_12_2.name)

	setText = var_6

	local var_12_6 = var_12_1.transform
	local var_12_7 = var_7.Find(var_12_6, "content/label")

	i18n = var_12_6

	var_6(var_12_7, var_12_6("battle_ui_unlock"))

	local var_12_8 = var_12_1.transform
	local var_12_9 = var_6.Find(var_12_8, "content")

	Vector2 = var_12_8
	var_12_9.anchoredPosition = var_12_8(-550, 0)
	LeanTween = var_7

	local var_12_10 = var_7.moveX

	rtf = var_8

	var_12_10(var_8(var_12_9), 0, 0.5)

	LeanTween = var_12_10

	local var_12_11 = var_12_10.moveX

	rtf = var_8

	local var_12_12 = var_12_11(var_8(var_12_9), -550, 0.5)
	local var_12_13 = var_7.setDelay(var_12_12, 5)
	local var_12_14 = var_7.setOnComplete

	System = var_9

	var_12_14(var_12_13, var_9.Action(function()
		setActive = var_2_10000

		var_2_10000(var_12_1, false)

		local var_13_0 = arg_12_0.pools[arg_12_1.type .. "Tpl"]

		var_0.Enqueue(var_13_0, var_12_1)

		if arg_12_3 then
			arg_12_3()
		end

		return
	end))

	if arg_12_2 then
		arg_12_2()
	end

	return
end

function var_0_1.UpdateEmoji(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:GetAndSet(arg_14_1.type, arg_14_0.container)
	local var_14_1 = var_4.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10008

	local var_14_2 = var_14_1(var_14_0, var_7(var_1_10008))

	var_5.SetTriggerEvent(var_14_2, function(arg_15_0)
		if arg_14_2 then
			arg_14_2()
		end

		local var_15_0 = var_0

		var_1.SetTriggerEvent(var_15_0, nil)

		return
	end)
	var_5:SetEndEvent(function(arg_16_0)
		setActive = var_2_10001

		var_2_10001(var_0, false)

		local var_16_0 = arg_14_0.pools[arg_14_1.type .. "Tpl"]

		var_1.Enqueue(var_16_0, var_0)

		local var_16_1 = var_0

		var_1.SetEndEvent(var_16_1, nil)

		if arg_14_3 then
			arg_14_3()
		end

		return
	end)

	local var_14_3 = var_4
	local var_14_4 = var_4.GetComponent

	typeof = var_8
	Animation = var_1_10009

	local var_14_5 = var_14_4(var_14_3, var_8(var_1_10009))

	var_6.Play(var_14_5, "attire")

	local var_14_6 = arg_14_1.info

	setText = var_14_5

	local var_14_7 = var_4.transform
	local var_14_8 = var_8.Find(var_14_7, "bg/label")

	i18n = var_14_7

	var_14_5(var_14_8, var_14_7("word_emoji_unlock"))

	setText = var_14_5

	local var_14_9 = var_4.transform
	local var_14_10 = var_8.Find(var_14_9, "bg/Text")

	i18n = var_14_9

	var_14_5(var_14_10, var_14_9("word_get_emoji", var_14_6.item_name))

	return
end

var_0_1.FADE_TIME = 0.4
var_0_1.FADE_OUT_TIME = 1
var_0_1.SHOW_TIME = 1.5
var_0_1.DELAY_TIME = 0.3

function var_0_1.UpdateTecpoint(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1.info.point
	local var_17_1 = var_4.typeList
	local var_17_2 = var_4.attr
	local var_17_3 = var_4.value
	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.GetAndSet(var_17_4, "Point", arg_17_0.container)

	GetComponent = var_17_4

	local var_17_6 = var_17_4(var_17_5.transform, "CanvasGroup")

	var_17_6.alpha = 0
	setText = var_17_6
	findTF = var_11

	var_17_6(var_11(var_17_5, "PointText"), "+" .. var_17_0)

	local var_17_7 = {}

	if var_17_1 then
		for iter_17_0 = 1, #var_17_1 do
			var_1_10016 = arg_17_0

			local var_17_8 = arg_17_0.GetAndSet(var_1_10016, "Buff", arg_17_0.container)

			GetComponent = var_1_10016
			var_1_10016 = var_1_10016(var_17_8.transform, "CanvasGroup")
			var_1_10016.alpha = 0

			local var_17_9 = var_17_8.transform

			var_1_10016 = var_1_10016.Find(var_17_9, "TypeImg")

			local var_17_10 = var_17_8.transform
			local var_17_11 = var_17.Find(var_17_10, "AttrText")
			local var_17_12 = var_17_8.transform
			local var_17_13 = var_18.Find(var_17_12, "ValueText")
			local var_17_14 = var_17_1[iter_17_0]

			GetSpriteFromAtlas = var_20

			local var_17_15 = var_20("ShipType", "buffitem_tec_" .. var_17_14)

			setImageSprite = var_21

			var_21(var_1_10016.transform, var_17_15)

			setText = var_21
			var_1_10022 = var_17_11.transform
			AttributeType = var_23

			local var_17_16 = var_23.Type2Name

			pg = var_1_10024

			var_21(var_1_10022, var_17_16(var_1_10024.attribute_info_by_type[var_17_2].name))

			setText = var_21

			var_21(var_17_13.transform, "+" .. var_17_3)

			go = var_21
			var_17_7[iter_17_0] = var_21(var_17_8)
		end
	end

	local function var_17_17()
		if arg_17_2 then
			arg_17_2()
		end

		if arg_17_3 then
			arg_17_3()
		end

		return
	end

	go = var_12

	local var_17_18 = var_12(var_17_5)

	GetComponent = var_13

	local var_17_19 = var_13(var_17_5, "CanvasGroup")

	local function var_17_20(arg_19_0)
		var_17_19.alpha = arg_19_0

		return
	end

	local function var_17_21()
		LeanTween = var_2_10000

		local var_20_0 = var_2_10000.moveX

		rtf = var_2_10001

		var_20_0(var_2_10001(var_17_18), 0, var_0_1.FADE_OUT_TIME)

		LeanTween = var_20_0

		local var_20_1 = var_20_0.value(var_17_18, 1, 0, var_0_1.FADE_OUT_TIME)
		local var_20_2 = var_0.setOnUpdate

		System = var_2

		local var_20_3 = var_20_2(var_20_1, var_2.Action_float(var_17_20))
		local var_20_4 = var_0.setOnComplete

		System = var_2

		var_20_4(var_20_3, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(var_17_5, false)

			local var_21_0 = arg_17_0.pools.PointTpl

			var_0.Enqueue(var_21_0, var_17_5)

			if not var_17_1 then
				var_17_17()
			end

			return
		end))

		return
	end

	LeanTween = var_1_10016

	local var_17_22 = var_1_10016.value(var_17_18, 0, 1, var_0_1.FADE_TIME)
	local var_17_23 = var_16.setOnUpdate

	System = var_18

	local var_17_24 = var_17_23(var_17_22, var_18.Action_float(var_17_20))
	local var_17_25 = var_16.setOnComplete

	System = var_18

	var_17_25(var_17_24, var_18.Action(function()
		LeanTween = var_2_10000

		local var_22_0 = var_2_10000.delayedCall
		local var_22_1 = var_17_18
		local var_22_2 = var_0_1.SHOW_TIME

		System = var_2_10003

		var_22_0(var_22_1, var_22_2, var_2_10003.Action(var_17_21))

		return
	end))

	local function var_17_26(arg_23_0, arg_23_1, arg_23_2)
		GetComponent = var_2_10003

		local var_23_0 = var_2_10003(arg_23_0.transform, "CanvasGroup")

		local function var_23_1(arg_24_0)
			var_23_0.alpha = arg_24_0

			return
		end

		local function var_23_2()
			LeanTween = var_3_10000

			local var_25_0 = var_3_10000.moveX

			rtf = var_3_10001

			var_25_0(var_3_10001(arg_23_0), 0, var_0_1.FADE_OUT_TIME)

			LeanTween = var_25_0

			local var_25_1 = var_25_0.value(arg_23_0, 1, 0, var_0_1.FADE_OUT_TIME)
			local var_25_2 = var_0.setOnUpdate

			System = var_2

			local var_25_3 = var_25_2(var_25_1, var_2.Action_float(var_23_1))
			local var_25_4 = var_0.setOnComplete

			System = var_2

			var_25_4(var_25_3, var_2.Action(function()
				setActive = var_4_10000

				var_4_10000(arg_23_0, false)

				local var_26_0 = arg_17_0.pools.BuffTpl

				var_0.Enqueue(var_26_0, arg_23_0)

				if arg_23_2 then
					var_17_17()
				end

				return
			end))

			return
		end

		LeanTween = var_2_10006

		local var_23_3 = var_2_10006.value(arg_23_0, 0, 1, var_0_1.FADE_TIME)
		local var_23_4 = var_6.setOnUpdate

		System = var_8

		local var_23_5 = var_23_4(var_23_3, var_8.Action_float(var_23_1))
		local var_23_6 = var_6.setOnComplete

		System = var_8

		var_23_6(var_23_5, var_8.Action(function()
			LeanTween = var_3_10000

			local var_27_0 = var_3_10000.delayedCall
			local var_27_1 = arg_23_0
			local var_27_2 = var_0_1.SHOW_TIME + (var_0_1.FADE_OUT_TIME - var_0_1.DELAY_TIME) * arg_23_1

			System = var_3

			var_27_0(var_27_1, var_27_2, var_3.Action(var_23_2))

			return
		end))

		return
	end

	ipairs = var_17_24

	for iter_17_1, iter_17_2 in var_17_24(var_17_7) do
		LeanTween = var_1_10022
		var_1_10022 = var_1_10022.delayedCall

		local var_17_27 = var_17_18
		local var_17_28 = iter_17_1 * var_0_1.DELAY_TIME

		System = var_1_10025

		var_1_10022(var_17_27, var_17_28, var_1_10025.Action(function()
			var_17_26(iter_17_2, iter_17_1, iter_17_1 == #var_17_7)

			return
		end))
	end

	return
end

function var_0_1.UpdateTrophy(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	pg = var_1_10004

	local var_29_0 = var_1_10004.CriMgr.GetInstance()
	local var_29_1 = var_4.PlaySoundEffect_V3

	if not arg_29_1.info.sound then
		SFX_UI_TIP = var_6
	end

	var_29_1(var_29_0, var_6)

	local var_29_2 = arg_29_0
	local var_29_3 = arg_29_0.GetAndSet(var_29_2, arg_29_1.type, arg_29_0.container)

	pg = var_29_2

	local var_29_4 = var_29_2.medal_template[arg_29_1.info.id]

	LoadImageSpriteAsync = var_6

	local var_29_5 = "medal/s_" .. var_29_4.icon
	local var_29_6 = var_29_3.transform

	var_6(var_29_5, var_8.Find(var_29_6, "content/icon"), true)

	setText = var_6

	local var_29_7 = var_29_3.transform

	var_6(var_7.Find(var_29_7, "content/name"), var_29_4.name)

	setText = var_6

	local var_29_8 = var_29_3.transform
	local var_29_9 = var_7.Find(var_29_8, "content/label")

	i18n = var_29_8

	var_6(var_29_9, var_29_8("trophy_achieved"))

	local var_29_10 = var_29_3.transform
	local var_29_11 = var_6.Find(var_29_10, "content")

	Vector2 = var_29_10
	var_29_11.anchoredPosition = var_29_10(-550, 0)
	LeanTween = var_7

	local var_29_12 = var_7.moveX

	rtf = var_8

	var_29_12(var_8(var_29_11), 0, 0.5)

	LeanTween = var_29_12

	local var_29_13 = var_29_12.moveX

	rtf = var_8

	local var_29_14 = var_29_13(var_8(var_29_11), -550, 0.5)
	local var_29_15 = var_7.setDelay(var_29_14, 5)
	local var_29_16 = var_7.setOnComplete

	System = var_9

	var_29_16(var_29_15, var_9.Action(function()
		setActive = var_2_10000

		var_2_10000(var_29_3, false)

		local var_30_0 = arg_29_0.pools[arg_29_1.type .. "Tpl"]

		var_0.Enqueue(var_30_0, var_29_3)

		if arg_29_3 then
			arg_29_3()
		end

		return
	end))

	if arg_29_2 then
		arg_29_2()
	end

	return
end

function var_0_1.UpdateMeta(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_1.info.metaShipVO

	MetaCharacterConst = var_1_10006

	local var_31_1 = var_1_10006.GetMetaShipGroupIDByConfigID(var_31_0.configId)
	local var_31_2 = arg_31_0:GetAndSet("MetaExp", arg_31_0.container)
	local var_31_3 = arg_31_0:GetAndSet("MetaLevel", arg_31_0.container)
	local var_31_4 = var_31_2.transform
	local var_31_5 = var_9.Find(var_31_4, "ShipImg")

	MetaCharacterConst = var_31_4

	local var_31_6, var_31_7 = var_31_4.GetMetaCharacterToastPath(var_31_1)

	setImageSprite = var_1_10012

	local var_31_8 = var_31_5

	LoadSprite = var_1_10014

	var_1_10012(var_31_8, var_1_10014(var_31_6, var_31_7))

	local var_31_9 = var_31_2.transform
	local var_31_10 = var_12.Find(var_31_9, "Progress")

	pg = var_31_9

	local var_31_11 = var_31_9.gameset.meta_skill_exp_max.key_value
	local var_31_12 = var_4.newDayExp
	local var_31_13 = var_4.addDayExp
	local var_31_14 = var_31_11 <= var_31_12

	setSlider = var_1_10017

	var_1_10017(var_31_10, 0, var_31_11, var_31_12)

	local var_31_15 = var_4.curSkillID
	local var_31_16 = var_4.oldSkillLevel < var_4.newSkillLevel
	local var_31_17 = var_31_2.transform
	local var_31_18 = var_21.Find(var_31_17, "ExpFull")
	local var_31_19 = var_31_2.transform
	local var_31_20 = var_22.Find(var_31_19, "ExpAdd")
	local var_31_21

	if var_31_14 then
		setActive = var_31_19

		var_31_19(var_31_18, true)

		setActive = var_31_19

		var_31_19(var_31_20, false)
	else
		var_31_21 = var_31_2.transform

		local var_31_22

		var_31_22, setText = var_23.Find(var_31_21, "ExpAdd/Value"), var_31_21
		string = var_1_10026

		var_31_21(var_31_22, var_1_10026.format("+%d", var_31_13))

		setActive = var_31_21

		var_31_21(var_31_18, false)

		setActive = var_31_21

		var_31_21(var_31_20, var_31_16)
	end

	if var_31_16 then
		var_31_21 = var_31_3.transform

		local var_31_23 = var_23.Find(var_31_21, "Skill/Icon")

		getSkillConfig = var_31_21
		var_31_21 = var_31_21(var_31_15)
		setImageSprite = var_25

		local var_31_24 = var_31_23

		LoadSprite = var_1_10027

		var_25(var_31_24, var_1_10027("skillicon/" .. var_31_21.icon))

		local var_31_25 = var_31_3.transform
		local var_31_26 = var_25.Find(var_31_25, "LevelUp")
		local var_31_27 = var_31_3.transform
		local var_31_28 = var_26.Find(var_31_27, "LevelMax")

		pg = var_31_27

		if var_19 >= var_31_27.skill_data_template[var_31_15].max_level then
			setActive = var_29

			var_29(var_31_26, false)

			setActive = var_29

			var_29(var_31_28, true)
		else
			var_1_10030 = var_31_3.transform

			local var_31_29

			var_31_29, setText = var_29.Find(var_1_10030, "LevelUp/Value"), var_1_10030
			string = var_1_10032

			var_1_10030(var_31_29, var_1_10032.format("+%d", var_19 - var_18))

			setActive = var_1_10030

			var_1_10030(var_31_26, true)

			setActive = var_1_10030

			var_1_10030(var_31_28, false)
		end
	end

	local function var_31_30()
		if arg_31_2 then
			arg_31_2()
		end

		if arg_31_3 then
			arg_31_3()
		end

		return
	end

	GetComponent = var_31_21

	local var_31_31 = var_31_21(var_31_2, "CanvasGroup")

	GetComponent = var_25

	local var_31_32 = var_25(var_31_3, "CanvasGroup")

	var_31_31.alpha = 0
	var_31_32.alpha = 0

	if var_31_14 or var_31_16 then
		local function var_31_33(arg_33_0)
			var_31_31.alpha = arg_33_0

			return
		end

		local function var_31_34()
			LeanTween = var_2_10000

			local var_34_0 = var_2_10000.moveX

			rtf = var_2_10001

			var_34_0(var_2_10001(var_31_2.transform), 0, var_0_1.FADE_OUT_TIME)

			LeanTween = var_34_0

			local var_34_1 = var_34_0.value(var_31_2, 1, 0, var_0_1.FADE_OUT_TIME)
			local var_34_2 = var_0.setOnUpdate

			System = var_2

			local var_34_3 = var_34_2(var_34_1, var_2.Action_float(var_31_33))
			local var_34_4 = var_0.setOnComplete

			System = var_2

			var_34_4(var_34_3, var_2.Action(function()
				local var_35_0 = arg_31_0.pools.MetaExpTpl

				var_0.Enqueue(var_35_0, var_31_2)

				if not var_31_16 then
					local var_35_1 = arg_31_0.pools.MetaLevelTpl

					var_0.Enqueue(var_35_1, var_31_3)
					var_31_30()
				end

				return
			end))

			return
		end

		local function var_31_35()
			LeanTween = var_2_10000

			local var_36_0 = var_2_10000.delayedCall
			local var_36_1 = var_31_2
			local var_36_2 = var_0_1.SHOW_TIME

			System = var_2_10003

			var_36_0(var_36_1, var_36_2, var_2_10003.Action(var_31_34))

			return
		end

		LeanTween = var_1_10030

		local var_31_36 = var_1_10030.value(var_31_2, 0, 1, var_0_1.FADE_TIME)

		var_1_10030 = var_1_10030.setOnUpdate
		System = var_32

		local var_31_37 = var_1_10030(var_31_36, var_32.Action_float(var_31_33))

		var_1_10030 = var_1_10030.setOnComplete
		System = var_32

		var_1_10030(var_31_37, var_32.Action(var_31_35))
	end

	if var_31_16 then
		local function var_31_38(arg_37_0)
			var_31_32.alpha = arg_37_0

			return
		end

		local function var_31_39()
			LeanTween = var_2_10000

			local var_38_0 = var_2_10000.moveX

			rtf = var_2_10001

			var_38_0(var_2_10001(var_31_3.transform), 0, var_0_1.FADE_OUT_TIME)

			LeanTween = var_38_0

			local var_38_1 = var_38_0.value(var_31_3, 1, 0, var_0_1.FADE_OUT_TIME)
			local var_38_2 = var_0.setOnUpdate

			System = var_2

			local var_38_3 = var_38_2(var_38_1, var_2.Action_float(var_31_38))
			local var_38_4 = var_0.setOnComplete

			System = var_2

			var_38_4(var_38_3, var_2.Action(function()
				local var_39_0 = arg_31_0.pools.MetaLevelTpl

				var_0.Enqueue(var_39_0, var_31_3)
				var_31_30()

				return
			end))

			return
		end

		local function var_31_40()
			LeanTween = var_2_10000

			local var_40_0 = var_2_10000.delayedCall
			local var_40_1 = var_31_3
			local var_40_2 = var_0_1.SHOW_TIME

			System = var_2_10003

			var_40_0(var_40_1, var_40_2, var_2_10003.Action(var_31_39))

			return
		end

		LeanTween = var_1_10030

		local var_31_41 = var_1_10030.delayedCall
		local var_31_42 = var_31_3
		local var_31_43 = var_0_1.DELAY_TIME

		System = var_1_10033

		var_31_41(var_31_42, var_31_43, var_1_10033.Action(function()
			LeanTween = var_2_10000

			local var_41_0 = var_2_10000.value(var_31_3, 0, 1, var_0_1.FADE_TIME)
			local var_41_1 = var_0.setOnUpdate

			System = var_2

			local var_41_2 = var_41_1(var_41_0, var_2.Action_float(var_31_38))
			local var_41_3 = var_0.setOnComplete

			System = var_2

			var_41_3(var_41_2, var_2.Action(var_31_40))

			return
		end))
	end

	return
end

function var_0_1.UpdateCrusing(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = arg_42_1.info.ptId
	local var_42_1 = var_4.ptCount

	pg = var_1_10007

	local var_42_2 = var_1_10007.CriMgr.GetInstance()
	local var_42_3 = var_7.PlaySoundEffect_V3

	if not arg_42_1.info.sound then
		SFX_UI_TIP = var_9
	end

	var_42_3(var_42_2, var_9)

	tf = var_42_3

	local var_42_4 = var_42_3(arg_42_0:GetAndSet(arg_42_1.type, arg_42_0.container))

	Drop = var_8

	local var_42_5 = var_8.New
	local var_42_6 = {}

	DROP_TYPE_VITEM = var_10
	var_42_6.type = var_10
	var_42_6.id = var_42_0

	local var_42_7 = var_42_5(var_42_6)

	LoadImageSpriteAtlasAsync = var_42_6

	var_42_6(var_42_7:getIcon(), "", var_42_4:Find("PointIcon"), true)

	setText = var_42_6

	var_42_6(var_42_4:Find("info/name"), var_42_7:getName())

	setText = var_42_6

	var_42_6(var_42_4:Find("info/pt"), "+" .. var_42_1)

	setAnchoredPosition = var_42_6

	var_42_6(var_42_4, {
		x = var_42_4.rect.width
	})

	GetComponent = var_42_6

	local var_42_8 = var_42_4

	typeof = var_11
	CanvasGroup = var_12

	local var_42_9 = var_42_6(var_42_8, var_11(var_12))

	LeanTween = var_42_8

	local var_42_10 = var_42_8.alphaCanvas(var_42_9, 1, 0.5)
	local var_42_11 = var_10.setFrom(var_42_10, 0)
	local var_42_12 = var_10.setOnComplete

	System = var_12

	var_42_12(var_42_11, var_12.Action(function()
		LeanTween = var_2_10000

		local var_43_0 = var_2_10000.alphaCanvas(var_42_9, 0, 0.5)
		local var_43_1 = var_0.setDelay(var_43_0, 5)
		local var_43_2 = var_0.setOnComplete

		System = var_2

		var_43_2(var_43_1, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(var_42_4, false)

			local var_44_0 = arg_42_0.pools[arg_42_1.type .. "Tpl"]
			local var_44_1 = var_0.Enqueue

			go = var_2

			var_44_1(var_44_0, var_2(var_42_4))

			if arg_42_3 then
				arg_42_3()
			end

			return
		end))

		if arg_42_2 then
			arg_42_2()
		end

		return
	end))

	return
end

function var_0_1.UpdateVote(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = arg_45_1.info.ptId
	local var_45_1 = var_4.ptCount

	Drop = var_1_10007

	local var_45_2 = var_1_10007.New
	local var_45_3 = {}

	DROP_TYPE_ITEM = var_1_10009
	var_45_3.type = var_1_10009
	var_45_3.id = var_45_0

	local var_45_4 = var_45_2(var_45_3)

	tf = var_45_3

	local var_45_5 = var_45_3(arg_45_0:GetAndSet(arg_45_1.type, arg_45_0.container))

	LoadImageSpriteAtlasAsync = var_9

	var_9(var_45_4:getIcon(), "", var_45_5:Find("PointIcon"), true)

	setText = var_9

	var_9(var_45_5:Find("info/name"), var_45_4:getName())

	setText = var_9

	var_9(var_45_5:Find("info/pt"), "+" .. var_45_1)

	setAnchoredPosition = var_9

	var_9(var_45_5, {
		x = var_45_5.rect.width
	})

	GetComponent = var_9

	local var_45_6 = var_45_5

	typeof = var_11
	CanvasGroup = var_12

	local var_45_7 = var_9(var_45_6, var_11(var_12))

	LeanTween = var_45_6

	local var_45_8 = var_45_6.alphaCanvas(var_45_7, 1, 0.5)
	local var_45_9 = var_10.setFrom(var_45_8, 0)
	local var_45_10 = var_10.setOnComplete

	System = var_12

	var_45_10(var_45_9, var_12.Action(function()
		LeanTween = var_2_10000

		local var_46_0 = var_2_10000.alphaCanvas(var_45_7, 0, 0.5)
		local var_46_1 = var_0.setDelay(var_46_0, 5)
		local var_46_2 = var_0.setOnComplete

		System = var_2

		var_46_2(var_46_1, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(var_45_5, false)

			local var_47_0 = arg_45_0.pools[arg_45_1.type .. "Tpl"]
			local var_47_1 = var_0.Enqueue

			go = var_2

			var_47_1(var_47_0, var_2(var_45_5))

			if arg_45_3 then
				arg_45_3()
			end

			return
		end))

		if arg_45_2 then
			arg_45_2()
		end

		return
	end))

	return
end

function var_0_1.UpdateCover(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_0:GetAndSet(arg_48_1.type, arg_48_0.container)
	local var_48_1 = var_4.GetComponent

	typeof = var_7
	DftAniEvent = var_1_10008

	local var_48_2 = var_48_1(var_48_0, var_7(var_1_10008))

	var_5.SetTriggerEvent(var_48_2, function(arg_49_0)
		if arg_48_2 then
			arg_48_2()
		end

		local var_49_0 = var_0

		var_1.SetTriggerEvent(var_49_0, nil)

		return
	end)
	var_5:SetEndEvent(function(arg_50_0)
		setActive = var_2_10001

		var_2_10001(var_0, false)

		local var_50_0 = arg_48_0.pools[arg_48_1.type .. "Tpl"]

		var_1.Enqueue(var_50_0, var_0)

		local var_50_1 = var_0

		var_1.SetEndEvent(var_50_1, nil)

		if arg_48_3 then
			arg_48_3()
		end

		return
	end)

	local var_48_3 = var_4
	local var_48_4 = var_4.GetComponent

	typeof = var_8
	Animation = var_1_10009

	local var_48_5 = var_48_4(var_48_3, var_8(var_1_10009))

	var_6.Play(var_48_5, "attire")

	local var_48_6 = arg_48_1.info

	setText = var_48_5

	local var_48_7 = var_4.transform
	local var_48_8 = var_8.Find(var_48_7, "bg/Text")

	HXSet = var_48_7

	var_48_5(var_48_8, var_48_7.hxLan(var_48_6:getConfig("get_tips")))

	return
end

function var_0_1.Dispose(arg_51_0)
	setActive = var_1_10001

	var_1_10001(arg_51_0._tf, false)
	arg_51_0:ResetUIDandHistory()

	pairs = var_1

	for iter_51_0, iter_51_1 in var_1(arg_51_0.pools) do
		iter_51_1:Clear(false)
	end

	return
end

return
