local ShipBreakResultLayer = class("ShipBreakResultLayer", import("..base.BaseUI"))

function ShipBreakResultLayer:getUIName()
	return "ShipBreakResultUI"
end

function ShipBreakResultLayer:init()
	self.frame = self._tf:Find("frame")
	self.attrPanel = self._tf:Find("right_panel/top/attrs")
	self.rarePanel = self._tf:Find("right_panel/top/rare")
	self.paintContain = self._tf:Find("paint")
	self.qCharaContain = self._tf:Find("right_panel/top/q_chara")
	self._chat = self.paintContain:Find("chat")

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self._shake = self._tf:Find("shake_panel")
	self._bg = self._shake:Find("bg")
	self._paintingShadowTF = self._tf:Find("shadow")

	return
end

function ShipBreakResultLayer:didEnter()
	onButton(self, self._tf, function()
		self:emit(ShipBreakResultLayer.ON_CLOSE)

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

function ShipBreakResultLayer:updateStatistics()
	local var_5_0 = self.contextData.newShip
	local var_5_1 = self.contextData.oldShip
	local var_5_2 = intProperties(self.contextData.newShip:getShipProperties())
	local var_5_3 = intProperties(self.contextData.oldShip:getShipProperties())

	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		local var_5_4 = self.attrPanel:GetChild(iter_5_0 - 1)

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

	local var_5_6 = self.attrPanel:GetChild(5)
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
	local var_5_12 = self.rarePanel:Find("stars_from")
	local var_5_13 = self.rarePanel:Find("stars_to")

	for iter_5_2 = 1, var_5_1:getStar() do
		setActive(var_5_12:GetChild(iter_5_2 - 1), true)
	end

	for iter_5_3 = 1, var_5_11 do
		setActive(var_5_13:GetChild(iter_5_3 - 1), true)
	end

	setPaintingPrefabAsync(self.paintContain, var_5_0:getPainting(), "chuanwu")
	setPaintingPrefabAsync(self._paintingShadowTF, var_5_0:getPainting(), "chuanwu", function()
		local var_6_0 = findTF(self._paintingShadowTF, "fitter"):GetChild(0)

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

	var_5_15:SetPaint(var_5_14)
	var_5_15:Load(true, function(arg_7_0)
		pg.UIMgr.GetInstance():LoadingOff()

		self.shipPrefab = var_5_14
		self.shipModel = arg_7_0

		arg_7_0:SetLocalScale(Vector3(1, 1, 1))
		arg_7_0:SetParent(self.qCharaContain)
		arg_7_0:SetAction("stand", 0)

		return
	end)
	GetSpriteFromAtlasAsync("newshipbg/bg_" .. var_5_0:rarity2bgPrintForGet(), "", function(arg_8_0)
		setImageSprite(self._tf, arg_8_0, false)

		return
	end)

	local var_5_16, var_5_17, var_5_18 = ShipWordHelper.GetWordAndCV(var_5_0:getSkinId(), ShipWordHelper.WORD_TYPE_UPGRADE, nil, nil, (var_5_0:getCVIntimacy()))

	setWidgetText(self._chat, var_5_18)

	local var_5_19 = self._chat:Find("Text"):GetComponent(typeof(Text))

	if #var_5_19.text > CHAT_POP_STR_LEN then
		var_5_19.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter
	end

	self._chat.transform.localScale = Vector3(0, 0, 1)
	self.delayTId = LeanTween.delayedCall(0.6, System.Action(function()
		SetActive(self._chat, true)
		LeanTween.scale(rtf(self._chat), Vector3.New(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack)
		self:voice(var_5_17)

		return
	end)).id

	local var_5_20 = var_5_0

	GetSpriteFromAtlasAsync("newshipbg/bg_" .. var_5_0:rarity2bgPrintForGet(), "", function(arg_10_0)
		setImageSprite(self._bg, arg_10_0)

		return
	end)

	if var_5_0:isBluePrintShip() then
		if self.metaBg then
			setActive(self.metaBg, false)
		end

		if self.designBg and self.designName ~= "raritydesign" .. var_5_20:getRarity() then
			PoolMgr.GetInstance():ReturnUI(self.designName, self.designBg)

			self.designBg = nil
		end

		if not self.designBg then
			PoolMgr.GetInstance():GetUI("raritydesign" .. var_5_20:getRarity(), true, function(arg_11_0)
				self.designBg = arg_11_0
				self.designName = "raritydesign" .. var_5_20:getRarity()

				arg_11_0.transform:SetParent(self._shake, false)

				arg_11_0.transform.localPosition = Vector3(1, 1, 1)
				arg_11_0.transform.localScale = Vector3(1, 1, 1)

				arg_11_0.transform:SetSiblingIndex(1)
				setActive(arg_11_0, true)

				return
			end)
		else
			setActive(self.designBg, true)
		end
	elseif var_5_0:isMetaShip() then
		if self.designBg then
			setActive(self.designBg, false)
		end

		if self.metaBg and self.metaName ~= "raritymeta" .. var_5_20:getRarity() then
			PoolMgr.GetInstance():ReturnUI(self.metaName, self.metaBg)

			self.metaBg = nil
		end

		if not self.metaBg then
			PoolMgr.GetInstance():GetUI("raritymeta" .. var_5_20:getRarity(), true, function(arg_12_0)
				self.metaBg = arg_12_0
				self.metaName = "raritymeta" .. var_5_20:getRarity()

				arg_12_0.transform:SetParent(self._shake, false)

				arg_12_0.transform.localPosition = Vector3(1, 1, 1)
				arg_12_0.transform.localScale = Vector3(1, 1, 1)

				arg_12_0.transform:SetSiblingIndex(1)
				setActive(arg_12_0, true)

				return
			end)
		else
			setActive(self.metaBg, true)
		end
	else
		if self.designBg then
			setActive(self.designBg, false)
		end

		if self.metaBg then
			setActive(self.metaBg, false)
		end
	end

	PoolMgr.GetInstance():GetUI("tupo_" .. var_5_20:getRarity(), true, function(arg_13_0)
		arg_13_0.transform:SetParent(self._tf, false)

		arg_13_0.transform.localPosition = Vector3(1, 1, 1)
		arg_13_0.transform.localScale = Vector3(1, 1, 1)

		arg_13_0.transform:SetSiblingIndex(4)
		setActive(arg_13_0, true)

		return
	end)
	PoolMgr.GetInstance():GetUI(var_5_20:isMetaShip() and "tupo_meta" or "tupo", true, function(arg_14_0)
		arg_14_0.transform:SetParent(self._tf, false)

		arg_14_0.transform.localPosition = Vector3(1, 1, 1)
		arg_14_0.transform.localScale = Vector3(1, 1, 1)

		arg_14_0.transform:SetAsLastSibling()
		setActive(arg_14_0, true)

		return
	end)

	return
end

function ShipBreakResultLayer:voice(arg_15_1)
	if not arg_15_1 then
		return
	end

	self:stopVoice()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_15_1)

	self._currentVoice = arg_15_1

	return
end

function ShipBreakResultLayer:stopVoice()
	if self._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(self._currentVoice)
	end

	self._currentVoice = nil

	return
end

function ShipBreakResultLayer:recycleSpineChar()
	if self.shipPrefab and self.shipModel then
		self.shipModel:Dispose()

		self.shipPrefab = nil
		self.shipModel = nil
	end

	return
end

function ShipBreakResultLayer:willExit()
	if self.delayTId then
		LeanTween.cancel(self.delayTId)
	end

	self:recycleSpineChar()

	if self.designBg then
		PoolMgr.GetInstance():ReturnUI(self.designName, self.designBg)
	end

	if self.metaBg then
		PoolMgr.GetInstance():ReturnUI(self.metaName, self.metaBg)
	end

	self:stopVoice()

	if self.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(self.loadedCVBankName)

		self.loadedCVBankName = nil
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ShipBreakResultLayer
