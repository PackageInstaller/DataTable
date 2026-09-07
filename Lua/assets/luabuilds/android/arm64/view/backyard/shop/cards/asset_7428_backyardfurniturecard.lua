local BackYardFurnitureCard = class("BackYardFurnitureCard")

function BackYardFurnitureCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.group = self._tf:GetComponent(typeof(CanvasGroup))
	self.icon = findTF(self._tf, "icon"):GetComponent(typeof(Image))
	self.comfortableTF = findTF(self._tf, "comfortable")
	self.comfortable = findTF(self._tf, "comfortable"):GetComponent(typeof(Text))
	self.name = findTF(self._tf, "name"):GetComponent(typeof(Text))
	self.themeName = findTF(self._tf, "theme"):GetComponent(typeof(Text))
	self.desc = findTF(self._tf, "desc"):GetComponent(typeof(Text))
	self.resGold = findTF(self._tf, "res/gold")
	self.resGoldTxt = findTF(self._tf, "res/gold/Text"):GetComponent(typeof(Text))
	self.resGemTxt = findTF(self._tf, "res/gem/Text"):GetComponent(typeof(Text))
	self.resGem = findTF(self._tf, "res/gem")
	self.cantPurchase = findTF(self._tf, "res/unopen")
	self.countTxt = findTF(self._tf, "count"):GetComponent(typeof(Text))
	self.maskTF = findTF(self._tf, "mask")
	self.hotTF = findTF(self._tf, "hot")
	self.newTF = findTF(self._tf, "new")
	self.skinMark = findTF(self._tf, "skin_mark")
	self.maskUnOpen = findTF(self._tf, "mask1")
	self.countDownTm = findTF(self._tf, "time/Text"):GetComponent(typeof(Text))
	self.timerTr = findTF(self._tf, "time")

	setActive(self.timerTr, false)

	return
end

function BackYardFurnitureCard:Update(arg_2_1)
	if self.group then
		self.group.alpha = 1
	end

	self.furniture = arg_2_1
	self.name.text = shortenString(HXSet.hxLan(arg_2_1:getConfig("name")), 9)
	self.themeName.text = shortenString(arg_2_1:GetThemeName(), 7)
	self.desc.text = HXSet.hxLan(arg_2_1:getConfig("describe"))
	self.comfortable.text = "+" .. arg_2_1:getConfig("comfortable")

	GetSpriteFromAtlasAsync("furnitureicon/" .. arg_2_1:getConfig("icon"), "", function(arg_3_0)
		if IsNil(self.icon) then
			return
		end

		self.icon.sprite = arg_3_0

		return
	end)

	local var_2_0 = arg_2_1:getConfig("count")

	if var_2_0 > 1 then
		self.countTxt.text = arg_2_1.count .. "/" .. var_2_0 or ""
	end

	local var_2_1 = arg_2_1:canPurchaseByGem()

	setActive(self.resGem, var_2_1)

	local var_2_2 = arg_2_1:canPurchaseByDormMoeny()

	setActive(self.resGold, var_2_2)

	local var_2_3 = arg_2_1:canPurchase()

	if self.maskUnOpen then
		setActive(self.maskUnOpen, var_2_3 and (not var_2_1 and not var_2_2 or not arg_2_1:inTime()))
	end

	self.resGoldTxt.text = arg_2_1:getPrice(PlayerConst.ResDormMoney)
	self.resGemTxt.text = arg_2_1:getPrice(PlayerConst.ResDiamond)

	setActive(self.maskTF, not var_2_3)
	setActive(self.hotTF, false)
	setActive(self.newTF, arg_2_1:IsNew() and var_2_3)

	local var_2_4, var_2_5 = arg_2_1:inTime()
	local var_2_6 = arg_2_1:isTimeLimit() and var_2_4

	if var_2_6 then
		self:UpdateCountdown(var_2_5)
	else
		self:DestoryTimer()

		self.countDownTm.text = ""
	end

	setActive(self.timerTr, var_2_6)
	self:UpdateSkinType()

	return
end

function BackYardFurnitureCard:UpdateSkinType()
	if IsNil(self.skinMark) then
		return
	end

	setActive(self.skinMark, (Goods.ExistFurniture((Goods.FurnitureId2Id(self.furniture.id)))))

	return
end

function BackYardFurnitureCard:UpdateCountdown(arg_5_1)
	local var_5_0 = pg.TimeMgr.GetInstance()

	self:DestoryTimer()

	local var_5_1 = var_5_0:Table2ServerTime(arg_5_1)

	self.prevStr = ""
	self.updateTimer = Timer.New(function()
		local var_6_0 = ""
		local var_6_1 = var_5_0:GetServerTime()

		if var_6_1 > var_5_1 then
			self.countDownTm.text = ""

			setActive(self.timerTr, false)
			self:DestoryTimer()

			return
		end

		local var_6_2 = var_5_1 - var_6_1

		var_6_2 = var_5_1 - var_6_1 < 0 and 0 or var_6_2

		local var_6_3 = math.floor(var_6_2 / 0)

		if var_6_3 > 0 then
			var_6_0 = var_6_3 .. i18n("word_date")
		else
			local var_6_4 = math.floor(var_6_2 / 16)

			if var_6_4 > 0 then
				var_6_0 = var_6_4 .. i18n("word_hour")
			else
				local var_6_5 = math.floor(var_6_2 / 60)

				var_6_0 = var_6_5 > 0 and var_6_5 .. i18n("word_minute") or var_6_2 .. i18n("word_second")
			end
		end

		if var_6_0 ~= self.prevStr then
			self.prevStr = var_6_0
			self.countDownTm.text = var_6_0
		end

		return
	end, 1, -1)

	self.updateTimer:Start()
	self.updateTimer.func()

	return
end

function BackYardFurnitureCard:DestoryTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	return
end

function BackYardFurnitureCard:Clear()
	self:DestoryTimer()

	return
end

return BackYardFurnitureCard
