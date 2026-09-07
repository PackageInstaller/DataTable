local MainPlayerInfoBtn4Mellow = class("MainPlayerInfoBtn4Mellow", import(".MainPlayerInfoBtn"))

function MainPlayerInfoBtn4Mellow:Ctor(arg_1_1, arg_1_2)
	MainPlayerInfoBtn4Mellow.super.super.Ctor(self, arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.playerInfoBtn = findTF(self._tf, "name_bg")
	self.playerNameTxt = findTF(self._tf, "name_bg/Text"):GetComponent(typeof(Text))
	self.playerLevelTr = findTF(self._tf, "name_bg/level/Text")
	self.playerLevelTxt = findTF(self._tf, "name_bg/level/Text"):GetComponent(typeof(Text))
	self.expTxt = findTF(self._tf, "name_bg/level/mask/Text"):GetComponent(typeof(Text))
	self.goldMax = findTF(self._tf, "res/gold/max"):GetComponent(typeof(Text))
	self.goldValue = findTF(self._tf, "res/gold/Text"):GetComponent(typeof(Text))
	self.oilMax = findTF(self._tf, "res/oil/max"):GetComponent(typeof(Text))
	self.oilValue = findTF(self._tf, "res/oil/Text"):GetComponent(typeof(Text))
	self.gemValue = findTF(self._tf, "res/gem/Text"):GetComponent(typeof(Text))
	self.expTr = findTF(self._tf, "name_bg/level/mask")

	onButton(self, findTF(self._tf, "res/gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "res/oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "res/gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	self:bind(PlayerProxy.UPDATED, function()
		self:Flush()

		return
	end)
	self:bind(GAME.GUILD_GET_USER_INFO_DONE, function()
		self:Flush()

		return
	end)
	self:bind(GAME.GET_PUBLIC_GUILD_USER_DATA_DONE, function()
		self:Flush()

		return
	end)

	return
end

function MainPlayerInfoBtn4Mellow:Flush(arg_8_1)
	MainPlayerInfoBtn4Mellow.super.Flush(self, arg_8_1)
	self:UpdateRes()

	return
end

function MainPlayerInfoBtn4Mellow:UpdateRes()
	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), self.goldMax, self.goldValue, self.oilMax, self.oilValue, self.gemValue)

	return
end

function MainPlayerInfoBtn4Mellow:UpdateExp()
	local var_10_1 = getProxy(PlayerProxy):getRawData()

	self.playerLevelTxt.text = var_10_1.level
	self.expTxt.text = var_10_1.level
	self.expTr.sizeDelta = Vector2(70, 34 * (var_10_1.level == var_10_1:getMaxLevel() and 1 or var_10_1.exp / getConfigFromLevel1(pg.user_level, var_10_1.level).exp_interval))

	return
end

function MainPlayerInfoBtn4Mellow:Dispose()
	MainPlayerInfoBtn4Mellow.super.Dispose(self)
	pg.DelegateInfo.Dispose(self)

	return
end

return MainPlayerInfoBtn4Mellow
