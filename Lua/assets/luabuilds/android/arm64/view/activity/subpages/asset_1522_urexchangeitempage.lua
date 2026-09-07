local UrExchangeItemPage = class("UrExchangeItemPage", import("...base.BaseActivityPage"))

function UrExchangeItemPage:OnInit()
	self.exchangeBtn = self._tf:Find("AD/exchange")
	self.exchangeTip = self._tf:Find("AD/exchange/tip")
	self.battleBtn = self._tf:Find("AD/battle")
	self.taskBtn = self._tf:Find("AD/task")
	self.progress = self._tf:Find("AD/progress/Image")
	self.progressTxt = self._tf:Find("AD/Text"):GetComponent(typeof(Text))
	self.itemTF = self._tf:Find("AD/item")
	self.helpBtn = self._tf:Find("AD/help")
	self.moreBtn = self._tf:Find("AD/more")

	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ur_exchange_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.moreBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ur_exchange_help_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.exchangeBtn, function()
		local var_4_0, var_4_1 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "FragmentShop")

		if not var_4_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_4_1)

			return
		end

		self:emit(ActivityMediator.GO_SHOPS_LAYER_STEEET, {
			warp = NewShopsScene.TYPE_FRAGMENT
		})

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		self:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(self, self.taskBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)

	return
end

function UrExchangeItemPage:OnFirstFlush()
	local var_7_0 = getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])

	self.progressTxt.text = var_7_0 .. "/" .. pg.gameset.urpt_chapter_max.description[2]

	setFillAmount(self.progress, var_7_0 / pg.gameset.urpt_chapter_max.description[2])
	updateDrop(self.itemTF, Drop.New({
		count = 0,
		type = DROP_TYPE_ITEM,
		id = pg.gameset.urpt_chapter_max.description[1]
	}))
	setActive(self.exchangeTip, NotifyTipHelper.ShouldShowUrTip())

	return
end

function UrExchangeItemPage:OnUpdateFlush()
	return
end

function UrExchangeItemPage:OnDestroy()
	return
end

return UrExchangeItemPage
