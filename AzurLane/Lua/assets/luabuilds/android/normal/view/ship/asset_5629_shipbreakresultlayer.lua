class = var_0_10000

local var_0_0 = "ShipBreakResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ShipBreakResultUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_0, "frame")

	local var_2_1 = arg_2_0._tf

	arg_2_0.attrPanel = var_1.Find(var_2_1, "right_panel/top/attrs")

	local var_2_2 = arg_2_0._tf

	arg_2_0.rarePanel = var_1.Find(var_2_2, "right_panel/top/rare")

	local var_2_3 = arg_2_0._tf

	arg_2_0.paintContain = var_1.Find(var_2_3, "paint")

	local var_2_4 = arg_2_0._tf

	arg_2_0.qCharaContain = var_1.Find(var_2_4, "right_panel/top/q_chara")

	local var_2_5 = arg_2_0.paintContain

	arg_2_0._chat = var_1.Find(var_2_5, "chat")
	pg = var_1

	local var_2_6 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_6, arg_2_0._tf)

	local var_2_7 = arg_2_0._tf

	arg_2_0._shake = var_1.Find(var_2_7, "shake_panel")

	local var_2_8 = arg_2_0._shake

	arg_2_0._bg = var_1.Find(var_2_8, "bg")

	local var_2_9 = arg_2_0._tf

	arg_2_0._paintingShadowTF = var_1.Find(var_2_9, "shadow")

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

local var_0_2 = {
	"durability",
	"cannon",
	"torpedo",
	"antiaircraft",
	"air"
}

function var_0_1.updateStatistics(arg_5_0)
	local var_5_0 = arg_5_0.contextData.newShip
	local var_5_1 = arg_5_0.contextData.oldShip

	intProperties = var_1_10003

	local var_5_2 = var_1_10003(var_5_0:getShipProperties())

	intProperties = var_4

	local var_5_3 = var_5_1
	local var_5_4 = var_4(var_5_1.getShipProperties(var_5_3))
	local var_5_5 = arg_5_0.attrPanel

	ipairs = var_5_3

	for iter_5_0, iter_5_1 in var_5_3(var_0_2) do
		local var_5_6 = var_5_5
		local var_5_7 = var_5_5.GetChild(var_5_6, iter_5_0 - 1)

		setText = var_5_6

		local var_5_8 = var_5_7
		local var_5_9 = var_5_7.Find(var_5_8, "name")

		AttributeType = var_5_8

		var_5_6(var_5_9, var_5_8.Type2Name(iter_5_1))

		setText = var_5_6

		var_5_6(var_5_7:Find("value"), var_5_4[iter_5_1])

		setText = var_5_6

		var_5_6(var_5_7:Find("value1"), var_5_2[iter_5_1])

		local var_5_10 = var_5_7:Find("addition")

		if var_5_2[iter_5_1] - var_5_4[iter_5_1] == 0 then
			setActive = var_14

			var_14(var_5_10, false)
		else
			setText = var_14

			var_14(var_5_10, "+" .. var_13)
		end
	end

	local var_5_11 = var_5_5:GetChild(5)
	local var_5_12 = var_5_1:getBattleTotalExpend()
	local var_5_13 = var_5_0
	local var_5_14 = var_5_0.getBattleTotalExpend(var_5_13)

	setText = var_5_13

	local var_5_15 = var_5_11
	local var_5_16 = var_5_11.Find(var_5_15, "name")

	AttributeType = var_5_15

	local var_5_17 = var_5_15.Type2Name

	AttributeType = var_12

	var_5_13(var_5_16, var_5_17(var_12.Expend))

	setText = var_5_13

	var_5_13(var_5_11:Find("value"), var_5_12)

	setText = var_5_13

	var_5_13(var_5_11:Find("value1"), var_5_14)

	local var_5_18 = var_5_11
	local var_5_19 = var_5_11.Find(var_5_18, "addition")

	math = var_5_18

	if var_5_18.abs(var_5_14 - var_5_12) == 0 then
		setActive = var_11

		var_11(var_5_19, false)
	else
		setText = var_11

		var_11(var_5_19, "+" .. var_10)
	end

	local var_5_20 = var_5_0:getStar()
	local var_5_21 = var_5_1:getStar()
	local var_5_22 = arg_5_0.rarePanel
	local var_5_23 = var_13.Find(var_5_22, "stars_from")
	local var_5_24 = arg_5_0.rarePanel
	local var_5_25 = var_14.Find(var_5_24, "stars_to")

	for iter_5_2 = 1, var_5_21 do
		setActive = var_1_10019

		var_1_10019(var_5_23:GetChild(iter_5_2 - 1), true)
	end

	for iter_5_3 = 1, var_5_20 do
		setActive = var_1_10019

		var_1_10019(var_5_25:GetChild(iter_5_3 - 1), true)
	end

	setPaintingPrefabAsync = var_15

	var_15(arg_5_0.paintContain, var_5_0:getPainting(), "chuanwu")

	setPaintingPrefabAsync = var_15

	var_15(arg_5_0._paintingShadowTF, var_5_0:getPainting(), "chuanwu", function()
		findTF = var_2_10000

		local var_6_0 = var_2_10000(arg_5_0._paintingShadowTF, "fitter")
		local var_6_1 = var_0.GetChild(var_6_0, 0)
		local var_6_2 = var_0.GetComponent(var_6_1, "Image")

		Color = var_6_1
		var_6_2.color = var_6_1.New(0, 0, 0)
		findTF = var_2

		local var_6_3 = var_2(var_0, "layers")

		IsNil = var_3

		local var_6_5

		if not var_3(var_6_3) then
			local var_6_4 = var_6_3

			var_6_5 = var_6_3.GetComponentsInChildren
			typeof = var_5
			Image = var_2_10006

			local var_6_6 = var_6_5(var_6_4, var_5(var_2_10006))

			var_6_5 = var_6_5.ToTable(var_6_6)
			ipairs = var_6_6

			for iter_6_0, iter_6_1 in var_6_6(var_6_5) do
				Color = var_2_10009
				iter_6_1.color = var_2_10009.New(0, 0, 0)
			end
		end

		findTF = var_6_5

		local var_6_7 = var_6_5(var_0, "face")

		IsNil = var_4

		if not var_4(var_6_7) then
			local var_6_8 = var_6_7
			local var_6_9 = var_6_7.GetComponent(var_6_8, "Image")

			Color = var_6_8
			var_6_9.color = var_6_8.New(0, 0, 0)
		end

		return
	end)

	local var_5_26 = var_5_0
	local var_5_27 = var_5_0.getPrefab(var_5_26)

	pg = var_5_26

	local var_5_28 = var_5_26.UIMgr.GetInstance()

	var_16.LoadingOn(var_5_28)

	SpineAnimChar = var_16

	local var_5_29 = var_16.New()

	var_16.SetPaint(var_5_29, var_5_27)
	var_16:Load(true, function(arg_7_0)
		pg = var_2_10001

		local var_7_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_7_0)

		arg_5_0.shipPrefab = var_5_27
		arg_5_0.shipModel = arg_7_0

		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.SetLocalScale

		Vector3 = var_2_10003

		var_7_2(var_7_1, var_2_10003(1, 1, 1))
		arg_7_0:SetParent(arg_5_0.qCharaContain)
		arg_7_0:SetAction("stand", 0)

		return
	end)

	GetSpriteFromAtlasAsync = var_17

	var_17("newshipbg/bg_" .. var_5_0:rarity2bgPrintForGet(), "", function(arg_8_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_5_0._tf, arg_8_0, false)

		return
	end)

	local var_5_30 = var_5_0
	local var_5_31 = var_5_0.getCVIntimacy(var_5_30)

	ShipWordHelper = var_5_30

	local var_5_32 = var_5_30.GetWordAndCV
	local var_5_33 = var_5_0
	local var_5_34 = var_5_0.getSkinId(var_5_33)

	ShipWordHelper = var_5_33

	local var_5_35, var_5_36, var_5_37 = var_5_32(var_5_34, var_5_33.WORD_TYPE_UPGRADE, nil, nil, var_5_31)

	setWidgetText = var_21

	var_21(arg_5_0._chat, var_5_37)

	local var_5_38 = arg_5_0._chat
	local var_5_39 = var_21.Find(var_5_38, "Text")
	local var_5_40 = var_21.GetComponent

	typeof = var_23
	Text = var_1_10024

	local var_5_41 = #var_5_40(var_5_39, var_23(var_1_10024)).text

	CHAT_POP_STR_LEN = var_23

	if var_23 < var_5_41 then
		TextAnchor = var_5_41

		if not var_5_41.MiddleLeft then
			TextAnchor = var_5_41
			var_5_41 = var_5_41.MiddleCenter
		end

		var_21.alignment = var_5_41

		local var_5_42 = arg_5_0._chat.transform

		Vector3 = var_23
		var_5_42.localScale = var_23(0, 0, 1)
		LeanTween = var_5_42

		local var_5_43 = var_5_42.delayedCall
		local var_5_44 = 0.6

		System = var_24
		arg_5_0.delayTId = var_5_43(var_5_44, var_24.Action(function()
			SetActive = var_2_10000

			var_2_10000(arg_5_0._chat, true)

			LeanTween = var_2_10000

			local var_9_0 = var_2_10000.scale

			rtf = var_1

			local var_9_1 = var_1(arg_5_0._chat)

			Vector3 = var_2

			local var_9_2 = var_9_0(var_9_1, var_2.New(1, 1, 1), 0.3)
			local var_9_3 = var_0.setEase

			LeanTweenType = var_2

			var_9_3(var_9_2, var_2.easeOutBack)

			local var_9_4 = arg_5_0

			var_0.voice(var_9_4, var_5_36)

			return
		end)).id

		local var_5_45 = var_5_0
		local var_5_46 = var_23.isBluePrintShip(var_5_45)
		local var_5_47 = var_23
		local var_5_48 = var_23.isMetaShip(var_5_47)

		GetSpriteFromAtlasAsync = var_5_47

		var_5_47("newshipbg/bg_" .. var_23:rarity2bgPrintForGet(), "", function(arg_10_0)
			setImageSprite = var_2_10001

			var_2_10001(arg_5_0._bg, arg_10_0)

			return
		end)

		if var_5_46 then
			if arg_5_0.metaBg then
				setActive = var_5_47

				var_5_47(arg_5_0.metaBg, false)
			end

			if arg_5_0.designBg and arg_5_0.designName ~= "raritydesign" .. var_23:getRarity() then
				PoolMgr = var_5_47

				local var_5_49 = var_5_47.GetInstance()

				var_5_47.ReturnUI(var_5_49, arg_5_0.designName, arg_5_0.designBg)

				arg_5_0.designBg = nil
			end

			if not arg_5_0.designBg then
				PoolMgr = var_5_47

				local var_5_50 = var_5_47.GetInstance()

				var_5_47.GetUI(var_5_50, "raritydesign" .. var_23:getRarity(), true, function(arg_11_0)
					arg_5_0.designBg = arg_11_0

					local var_11_0 = arg_5_0
					local var_11_1 = "raritydesign"
					local var_11_2 = var_0

					var_11_0.designName = var_11_1 .. var_3.getRarity(var_11_2)

					local var_11_3 = arg_11_0.transform

					var_1.SetParent(var_11_3, arg_5_0._shake, false)

					local var_11_4 = arg_11_0.transform

					Vector3 = var_11_3
					var_11_4.localPosition = var_11_3(1, 1, 1)

					local var_11_5 = arg_11_0.transform

					Vector3 = var_2
					var_11_5.localScale = var_2(1, 1, 1)

					local var_11_6 = arg_11_0.transform

					var_1.SetSiblingIndex(var_11_6, 1)

					setActive = var_1

					var_1(arg_11_0, true)

					return
				end)
			else
				setActive = var_5_47

				var_5_47(arg_5_0.designBg, true)
			end
		elseif var_5_48 then
			if arg_5_0.designBg then
				setActive = var_5_47

				var_5_47(arg_5_0.designBg, false)
			end

			if arg_5_0.metaBg and arg_5_0.metaName ~= "raritymeta" .. var_23:getRarity() then
				PoolMgr = var_5_47

				local var_5_51 = var_5_47.GetInstance()

				var_5_47.ReturnUI(var_5_51, arg_5_0.metaName, arg_5_0.metaBg)

				arg_5_0.metaBg = nil
			end

			if not arg_5_0.metaBg then
				PoolMgr = var_5_47

				local var_5_52 = var_5_47.GetInstance()

				var_5_47.GetUI(var_5_52, "raritymeta" .. var_23:getRarity(), true, function(arg_12_0)
					arg_5_0.metaBg = arg_12_0

					local var_12_0 = arg_5_0
					local var_12_1 = "raritymeta"
					local var_12_2 = var_0

					var_12_0.metaName = var_12_1 .. var_3.getRarity(var_12_2)

					local var_12_3 = arg_12_0.transform

					var_1.SetParent(var_12_3, arg_5_0._shake, false)

					local var_12_4 = arg_12_0.transform

					Vector3 = var_12_3
					var_12_4.localPosition = var_12_3(1, 1, 1)

					local var_12_5 = arg_12_0.transform

					Vector3 = var_2
					var_12_5.localScale = var_2(1, 1, 1)

					local var_12_6 = arg_12_0.transform

					var_1.SetSiblingIndex(var_12_6, 1)

					setActive = var_1

					var_1(arg_12_0, true)

					return
				end)
			else
				setActive = var_5_47

				var_5_47(arg_5_0.metaBg, true)
			end
		else
			if arg_5_0.designBg then
				setActive = var_5_47

				var_5_47(arg_5_0.designBg, false)
			end

			if arg_5_0.metaBg then
				setActive = var_5_47

				var_5_47(arg_5_0.metaBg, false)
			end
		end

		PoolMgr = var_5_47

		local var_5_53 = var_5_47.GetInstance()

		var_26.GetUI(var_5_53, "tupo_" .. var_23:getRarity(), true, function(arg_13_0)
			local var_13_0 = arg_13_0.transform

			var_1.SetParent(var_13_0, arg_5_0._tf, false)

			local var_13_1 = arg_13_0.transform

			Vector3 = var_13_0
			var_13_1.localPosition = var_13_0(1, 1, 1)

			local var_13_2 = arg_13_0.transform

			Vector3 = var_2
			var_13_2.localScale = var_2(1, 1, 1)

			local var_13_3 = arg_13_0.transform

			var_1.SetSiblingIndex(var_13_3, 4)

			setActive = var_1

			var_1(arg_13_0, true)

			return
		end)

		PoolMgr = var_26

		local var_5_54 = var_26.GetInstance()

		var_26.GetUI(var_5_54, var_23:isMetaShip() and "tupo_meta" or "tupo", true, function(arg_14_0)
			local var_14_0 = arg_14_0.transform

			var_1.SetParent(var_14_0, arg_5_0._tf, false)

			local var_14_1 = arg_14_0.transform

			Vector3 = var_14_0
			var_14_1.localPosition = var_14_0(1, 1, 1)

			local var_14_2 = arg_14_0.transform

			Vector3 = var_2
			var_14_2.localScale = var_2(1, 1, 1)

			local var_14_3 = arg_14_0.transform

			var_1.SetAsLastSibling(var_14_3)

			setActive = var_1

			var_1(arg_14_0, true)

			return
		end)

		return
	end
end

function var_0_1.voice(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	arg_15_0:stopVoice()

	pg = var_2

	local var_15_0 = var_2.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_15_0, arg_15_1)

	arg_15_0._currentVoice = arg_15_1

	return
end

function var_0_1.stopVoice(arg_16_0)
	if arg_16_0._currentVoice then
		pg = var_1

		local var_16_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_16_0, arg_16_0._currentVoice)
	end

	arg_16_0._currentVoice = nil

	return
end

function var_0_1.recycleSpineChar(arg_17_0)
	if arg_17_0.shipPrefab and arg_17_0.shipModel then
		local var_17_0 = arg_17_0.shipModel

		var_1.Dispose(var_17_0)

		arg_17_0.shipPrefab = nil
		arg_17_0.shipModel = nil
	end

	return
end

function var_0_1.willExit(arg_18_0)
	if arg_18_0.delayTId then
		LeanTween = var_1

		var_1.cancel(arg_18_0.delayTId)
	end

	arg_18_0:recycleSpineChar()

	if arg_18_0.designBg then
		PoolMgr = var_1

		local var_18_0 = var_1.GetInstance()

		var_1.ReturnUI(var_18_0, arg_18_0.designName, arg_18_0.designBg)
	end

	if arg_18_0.metaBg then
		PoolMgr = var_1

		local var_18_1 = var_1.GetInstance()

		var_1.ReturnUI(var_18_1, arg_18_0.metaName, arg_18_0.metaBg)
	end

	arg_18_0:stopVoice()

	if arg_18_0.loadedCVBankName then
		pg = var_1

		var_1.CriMgr.UnloadCVBank(arg_18_0.loadedCVBankName)

		arg_18_0.loadedCVBankName = nil
	end

	pg = var_1

	local var_18_2 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_18_2, arg_18_0._tf)

	return
end

return var_0_1
