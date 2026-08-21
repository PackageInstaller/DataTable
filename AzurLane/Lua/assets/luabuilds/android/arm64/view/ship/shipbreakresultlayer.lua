local var_0_0 = class("ShipBreakResultLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ShipBreakResultUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.frame = arg_2_0._tf:Find("frame")
	arg_2_0.attrPanel = arg_2_0._tf:Find("right_panel/top/attrs")
	arg_2_0.rarePanel = arg_2_0._tf:Find("right_panel/top/rare")
	arg_2_0.paintContain = arg_2_0._tf:Find("paint")
	arg_2_0.qCharaContain = arg_2_0._tf:Find("right_panel/top/q_chara")
	arg_2_0._chat = arg_2_0.paintContain:Find("chat")

	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0._shake = arg_2_0._tf:Find("shake_panel")
	arg_2_0._bg = arg_2_0._shake:Find("bg")
	arg_2_0._paintingShadowTF = arg_2_0._tf:Find("shadow")

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)

	return
end

local var_0_1 = {
	"durability",
	"cannon",
	"torpedo",
	"antiaircraft",
	"air"
}

function var_0_0.updateStatistics(arg_5_0)
	local var_5_0 = arg_5_0.contextData.newShip
	local var_5_2 = intProperties(arg_5_0.contextData.newShip:getShipProperties())
	local var_5_3 = intProperties(arg_5_0.contextData.oldShip:getShipProperties())

	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		local var_5_4 = arg_5_0.attrPanel:GetChild(iter_5_0 - 1)

		setText(var_5_4:Find("name"), AttributeType.Type2Name(iter_5_1))
		setText(var_5_4:Find("value"), var_5_3[iter_5_1])
		setText(var_5_4:Find("value1"), var_5_2[iter_5_1])

		local var_5_5 = var_5_4:Find("addition")

		if var_5_2[iter_5_1] - var_5_3[iter_5_1] == 0 then
			setActive(var_5_5, false)
		else
			setText(var_5_5, "+" .. var_5_2[iter_5_1] - var_5_3[iter_5_1])
		end
	end

	local var_5_6 = arg_5_0.attrPanel:GetChild(5)
	local var_5_7 = var_5_1:getBattleTotalExpend()
	local var_5_8 = var_5_0:getBattleTotalExpend()

	setText(var_5_6:Find("name"), AttributeType.Type2Name(AttributeType.Expend))
	setText(var_5_6:Find("value"), var_5_7)
	setText(var_5_6:Find("value1"), var_5_8)

	local var_5_9 = var_5_6:Find("addition")
	local var_5_10 = math.abs(var_5_8 - var_5_7)

	if var_5_10 == 0 then
		setActive(var_5_9, false)
	else
		setText(var_5_9, "+" .. var_5_10)
	end

	local var_5_11 = var_5_0:getStar()
	local var_5_12 = arg_5_0.rarePanel:Find("stars_from")
	local var_5_13 = arg_5_0.rarePanel:Find("stars_to")

	for iter_5_2 = 1, var_5_1:getStar() do
		setActive(var_5_12:GetChild(iter_5_2 - 1), true)
	end

	for iter_5_3 = 1, var_5_11 do
		setActive(var_5_13:GetChild(iter_5_3 - 1), true)
	end

	setPaintingPrefabAsync(arg_5_0.paintContain, var_5_0:getPainting(), "chuanwu")
	setPaintingPrefabAsync(arg_5_0._paintingShadowTF, var_5_0:getPainting(), "chuanwu", function()
		local var_6_0 = findTF(arg_5_0._paintingShadowTF, "fitter"):GetChild(0)

		var_6_0:GetComponent("Image").color = Color.New(0, 0, 0)

		local var_6_1 = findTF(var_6_0, "layers")

		if not IsNil(var_6_1) then
			for iter_6_0, iter_6_1 in ipairs((var_6_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
				iter_6_1.color = Color.New(0, 0, 0)
			end
		end

		local var_6_2 = findTF(var_6_0, "face")

		if not IsNil(var_6_2) then
			var_6_2:GetComponent("Image").color = Color.New(0, 0, 0)
		end

		return
	end)

	local var_5_14 = var_5_0:getPrefab()

	pg.UIMgr.GetInstance():LoadingOn()

	local var_5_15 = SpineAnimChar.New()

	var_5_15:SetPaint((var_5_0:getPrefab()))
	var_5_15:Load(true, function(arg_7_0)
		pg.UIMgr.GetInstance():LoadingOff()

		arg_5_0.shipPrefab = var_5_14
		arg_5_0.shipModel = arg_7_0

		arg_7_0:SetLocalScale(Vector3(1, 1, 1))
		arg_7_0:SetParent(arg_5_0.qCharaContain)
		arg_7_0:SetAction("stand", 0)

		return
	end)
	GetSpriteFromAtlasAsync("newshipbg/bg_" .. var_5_0:rarity2bgPrintForGet(), "", function(arg_8_0)
		setImageSprite(arg_5_0._tf, arg_8_0, false)

		return
	end)

	local var_5_16, var_5_17, var_5_18 = ShipWordHelper.GetWordAndCV(var_5_0:getSkinId(), ShipWordHelper.WORD_TYPE_UPGRADE, nil, nil, (var_5_0:getCVIntimacy()))

	setWidgetText(arg_5_0._chat, var_5_18)

	local var_5_19 = arg_5_0._chat:Find("Text"):GetComponent(typeof(Text))

	if #var_5_19.text > CHAT_POP_STR_LEN then
		var_5_19.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
		arg_5_0._chat.transform.localScale = Vector3(0, 0, 1)
		arg_5_0.delayTId = LeanTween.delayedCall(0.6, System.Action(function()
			SetActive(arg_5_0._chat, true)
			LeanTween.scale(rtf(arg_5_0._chat), Vector3.New(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack)
			arg_5_0:voice(var_5_17)

			return
		end)).id

		local var_5_20 = var_5_0

		GetSpriteFromAtlasAsync("newshipbg/bg_" .. var_5_0:rarity2bgPrintForGet(), "", function(arg_10_0)
			setImageSprite(arg_5_0._bg, arg_10_0)

			return
		end)

		if var_5_0:isBluePrintShip() then
			if arg_5_0.metaBg then
				setActive(arg_5_0.metaBg, false)
			end

			if arg_5_0.designBg and arg_5_0.designName ~= "raritydesign" .. var_5_20:getRarity() then
				PoolMgr.GetInstance():ReturnUI(arg_5_0.designName, arg_5_0.designBg)

				arg_5_0.designBg = nil
			end

			if not arg_5_0.designBg then
				PoolMgr.GetInstance():GetUI("raritydesign" .. var_5_20:getRarity(), true, function(arg_11_0)
					arg_5_0.designBg = arg_11_0
					arg_5_0.designName = "raritydesign" .. var_5_20:getRarity()

					arg_11_0.transform:SetParent(arg_5_0._shake, false)

					arg_11_0.transform.localPosition = Vector3(1, 1, 1)
					arg_11_0.transform.localScale = Vector3(1, 1, 1)

					arg_11_0.transform:SetSiblingIndex(1)
					setActive(arg_11_0, true)

					return
				end)
			else
				setActive(arg_5_0.designBg, true)
			end
		elseif var_5_0:isMetaShip() then
			if arg_5_0.designBg then
				setActive(arg_5_0.designBg, false)
			end

			if arg_5_0.metaBg and arg_5_0.metaName ~= "raritymeta" .. var_5_20:getRarity() then
				PoolMgr.GetInstance():ReturnUI(arg_5_0.metaName, arg_5_0.metaBg)

				arg_5_0.metaBg = nil
			end

			if not arg_5_0.metaBg then
				PoolMgr.GetInstance():GetUI("raritymeta" .. var_5_20:getRarity(), true, function(arg_12_0)
					arg_5_0.metaBg = arg_12_0
					arg_5_0.metaName = "raritymeta" .. var_5_20:getRarity()

					arg_12_0.transform:SetParent(arg_5_0._shake, false)

					arg_12_0.transform.localPosition = Vector3(1, 1, 1)
					arg_12_0.transform.localScale = Vector3(1, 1, 1)

					arg_12_0.transform:SetSiblingIndex(1)
					setActive(arg_12_0, true)

					return
				end)
			else
				setActive(arg_5_0.metaBg, true)
			end
		else
			if arg_5_0.designBg then
				setActive(arg_5_0.designBg, false)
			end

			if arg_5_0.metaBg then
				setActive(arg_5_0.metaBg, false)
			end
		end

		PoolMgr.GetInstance():GetUI("tupo_" .. var_5_20:getRarity(), true, function(arg_13_0)
			arg_13_0.transform:SetParent(arg_5_0._tf, false)

			arg_13_0.transform.localPosition = Vector3(1, 1, 1)
			arg_13_0.transform.localScale = Vector3(1, 1, 1)

			arg_13_0.transform:SetSiblingIndex(4)
			setActive(arg_13_0, true)

			return
		end)
		PoolMgr.GetInstance():GetUI(var_5_20:isMetaShip() and "tupo_meta" or "tupo", true, function(arg_14_0)
			arg_14_0.transform:SetParent(arg_5_0._tf, false)

			arg_14_0.transform.localPosition = Vector3(1, 1, 1)
			arg_14_0.transform.localScale = Vector3(1, 1, 1)

			arg_14_0.transform:SetAsLastSibling()
			setActive(arg_14_0, true)

			return
		end)

		return
	end
end

function var_0_0.voice(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	arg_15_0:stopVoice()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_15_1)

	arg_15_0._currentVoice = arg_15_1

	return
end

function var_0_0.stopVoice(arg_16_0)
	if arg_16_0._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_16_0._currentVoice)
	end

	arg_16_0._currentVoice = nil

	return
end

function var_0_0.recycleSpineChar(arg_17_0)
	if arg_17_0.shipPrefab and arg_17_0.shipModel then
		arg_17_0.shipModel:Dispose()

		arg_17_0.shipPrefab = nil
		arg_17_0.shipModel = nil
	end

	return
end

function var_0_0.willExit(arg_18_0)
	if arg_18_0.delayTId then
		LeanTween.cancel(arg_18_0.delayTId)
	end

	arg_18_0:recycleSpineChar()

	if arg_18_0.designBg then
		PoolMgr.GetInstance():ReturnUI(arg_18_0.designName, arg_18_0.designBg)
	end

	if arg_18_0.metaBg then
		PoolMgr.GetInstance():ReturnUI(arg_18_0.metaName, arg_18_0.metaBg)
	end

	arg_18_0:stopVoice()

	if arg_18_0.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(arg_18_0.loadedCVBankName)

		arg_18_0.loadedCVBankName = nil
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_18_0._tf)

	return
end

return var_0_0
