local Shrine2022SelectShipView = class("Shrine2022SelectShipView", import("...base.BaseSubView"))

function Shrine2022SelectShipView:getUIName()
	return "Shrine2022SelectShipUI"
end

function Shrine2022SelectShipView:OnInit()
	self:initData()
	self:initUI()
	self:updateCardList()
	self:Show()
	self:playEnterAni(true)

	return
end

function Shrine2022SelectShipView:OnDestroy()
	self:cleanManagedTween()

	return
end

function Shrine2022SelectShipView:setUIData()
	self.shipCardSpriteList = {}

	for iter_4_0 = 1, 7 do
		table.insert(self.shipCardSpriteList, (LoadSprite("Shrine2022/" .. "cardselect_" .. iter_4_0, "cardselect_" .. iter_4_0)))
	end

	self.shipNameSpriteList = {}

	for iter_4_1 = 1, 7 do
		table.insert(self.shipNameSpriteList, (LoadSprite("Shrine2022/" .. "cardselectname_" .. iter_4_1, "cardselectname_" .. iter_4_1)))
	end

	return
end

function Shrine2022SelectShipView:updateShipCardUI(arg_5_1, arg_5_2)
	setImageSprite(arg_5_1, self.shipCardSpriteList[arg_5_2], true)

	local var_5_0 = arg_5_1:Find("Name")

	setImageSprite(var_5_0, self.shipNameSpriteList[arg_5_2], true)
	setLocalPosition(arg_5_1, self.cardPosList[arg_5_2])

	local var_5_1 = self:isSelected(arg_5_2)

	setActive(arg_5_1:Find("Selected"), var_5_1)
	setActive(var_5_0, not var_5_1)

	GetComponent(arg_5_1, "Toggle").enabled = not var_5_1

	return
end

function Shrine2022SelectShipView:initData()
	self.cardPosList = {
		{
			x = -80,
			y = 240
		},
		{
			x = -80,
			y = 40
		},
		{
			x = -80,
			y = -162
		},
		{
			x = -80,
			y = -363
		},
		{
			x = 94,
			y = 195
		},
		{
			x = 94,
			y = -7
		},
		{
			x = 94,
			y = -210
		}
	}
	self.confirmPosList = {
		{
			x = -452,
			y = -34
		},
		{
			x = -160,
			y = -34
		},
		{
			x = 140,
			y = -34
		},
		{
			x = 440,
			y = -34
		},
		{
			x = -304,
			y = -400
		},
		{
			x = -6,
			y = -400
		},
		{
			x = 297,
			y = -400
		}
	}
	self.onCloseFunc = self.contextData.onClose
	self.onSelectFunc = self.contextData.onSelect
	self.onConfirmFunc = self.contextData.onConfirm
	self.shipGameID = self.contextData.shipGameID
	self.shipGameData = getProxy(MiniGameProxy):GetMiniGameData(self.shipGameID)
	self.selectingCardIndex = self.contextData.selectingCardIndex
	self.curSelectIndex = nil

	return
end

function Shrine2022SelectShipView:initUI()
	self:setUIData()

	self.bg = self._tf:Find("BG")
	self.cardTpl = self._tf:Find("CardTpl")
	self.backBtn = self._tf:Find("Adapt/BackBtn")
	self.helpBtn = self._tf:Find("Adapt/HelpBtn")
	self.panelTF = self._tf:Find("Adapt/Panel")
	self.tipTF = self._tf:Find("Adapt/Tip")
	self.cardContainer = self.panelTF:Find("CardContainer")
	self.cardUIItemList = UIItemList.New(self.cardContainer, self.cardTpl)
	self.confirmBtn = self._tf:Find("ConfirmBtn")

	onButton(self, self.bg, function()
		self:closeSelf()

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:closeSelf()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.Pray_activity_tips1.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		setActive(self.confirmBtn, false)
		self:confirmSelf()

		return
	end, SFX_PANEL)
	self.cardUIItemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			local var_12_0 = arg_12_1 + 1

			self:updateShipCardUI(arg_12_2, arg_12_1 + 1)

			if not isSelected then
				onToggle(self, arg_12_2, function(arg_13_0)
					if arg_13_0 then
						self.curSelectIndex = var_12_0

						if self.onSelectFunc then
							self.onSelectFunc(var_12_0)
						end
					end

					self:updateConfirmBtn(arg_13_0)

					return
				end, SFX_PANEL)
			end
		end

		return
	end)

	return
end

function Shrine2022SelectShipView:closeSelf()
	if self.isPlaying then
		return
	end

	self:playEnterAni(false, function()
		if self.onCloseFunc then
			self.onCloseFunc()
		end

		self:Destroy()

		return
	end)

	return
end

function Shrine2022SelectShipView:confirmSelf()
	if self.isPlaying then
		return
	end

	if self.onCloseFunc then
		self.onCloseFunc()
	end

	self:playEnterAni(false, function()
		if self.onConfirmFunc then
			self.onConfirmFunc(self.curSelectIndex)
		end

		self:Destroy()

		return
	end)

	return
end

function Shrine2022SelectShipView:updateConfirmBtn(arg_18_1)
	setLocalPosition(self.confirmBtn, self.confirmPosList[self.selectingCardIndex])
	setActive(self.confirmBtn, arg_18_1)

	return
end

function Shrine2022SelectShipView:updateCardList()
	self.cardUIItemList:align(7)

	return
end

function Shrine2022SelectShipView:playEnterAni(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1 and -1000 or 0
	local var_20_1 = arg_20_1 and 0 or -1000
	local var_20_2 = 0.3
	local var_20_3 = {
		x = arg_20_1 and -1000 or 0,
		y = rtf(self.panelTF).anchoredPosition.y
	}

	self.isPlaying = true

	self:managedTween(LeanTween.value, nil, go(self.panelTF), var_20_0, var_20_1, var_20_2):setOnUpdate(System.Action_float(function(arg_21_0)
		var_20_3.x = arg_21_0

		setAnchoredPosition(self.panelTF, var_20_3)

		return
	end)):setOnComplete(System.Action(function()
		self.isPlaying = false

		if arg_20_2 then
			arg_20_2()
		end

		return
	end))

	local var_20_4 = {
		x = rtf(self.tipTF).anchoredPosition.x,
		y = arg_20_1 and -100 or 38
	}

	self:managedTween(LeanTween.value, nil, go(self.tipTF), arg_20_1 and -100 or 38, arg_20_1 and 38 or -100, var_20_2):setOnUpdate(System.Action_float(function(arg_23_0)
		var_20_4.y = arg_23_0

		setAnchoredPosition(self.tipTF, var_20_4)

		return
	end))

	return
end

function Shrine2022SelectShipView:isSelected(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(self.shipGameData:GetRuntimeData("kvpElements")[1]) do
		if iter_24_1.value == arg_24_1 then
			return true
		end
	end

	return false
end

return Shrine2022SelectShipView
