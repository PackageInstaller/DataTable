local ValentineQtePage = class("ValentineQtePage", import("view.base.BaseActivityPage"))

ValentineQtePage.MINIGAME_HUB_ID = 42
ValentineQtePage.MINIGAME_ID = 50

function ValentineQtePage:OnInit()
	self.awardPreviewBtn = self._tf:Find("AD/award_preview_btn")
	self.goBtn = self._tf:Find("AD/go")
	self.indexTxt = self._tf:Find("AD/index"):GetComponent(typeof(Text))
	self.iconBtn = self._tf:Find("AD/icon")
	self.markContainer = self._tf:Find("AD/marks")
	self.markTpl = self._tf:Find("AD/marks/1")

	setActive(self.markTpl, false)

	self.markTrs = {}

	for iter_1_0 = 1, 7 do
		table.insert(self.markTrs, (cloneTplTo(self.markTpl, self.markContainer, iter_1_0)))
	end

	return
end

function ValentineQtePage:OnDataSetting()
	return
end

function ValentineQtePage:OnFirstFlush()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, ValentineQtePage.MINIGAME_ID)

		return
	end, SFX_PANEL)
	onButton(self, self.iconBtn, function()
		self:ShowAwards()

		return
	end, SFX_PANEL)
	onButton(self, self.indexTxt, function()
		self:ShowAwards()

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(ValentineQtePage.MINIGAME_HUB_ID)

	self:FlushMarks(var_3_0)
	Canvas.ForceUpdateCanvases()
	self:FlushIndex(var_3_0)

	return
end

function ValentineQtePage:ShowAwards()
	self:emit(ActivityMediator.ON_AWARD_WINDOW, self:GetDropList(), getProxy(MiniGameProxy):GetHubByHubId(ValentineQtePage.MINIGAME_HUB_ID).usedtime, {
		i18n("Valentine_minigame_label3"),
		i18n("Valentine_minigame_label2")
	})

	return
end

function ValentineQtePage:GetDropList()
	return pg.mini_game[ValentineQtePage.MINIGAME_ID].simple_config_data.drop_ids
end

function ValentineQtePage:FlushMarks(arg_9_1)
	local var_9_0 = arg_9_1.usedtime + arg_9_1.count

	for iter_9_0, iter_9_1 in ipairs(self.markTrs) do
		setActive(iter_9_1, iter_9_0 <= var_9_0)
		setActive(iter_9_1:Find("finish"), iter_9_0 <= arg_9_1.usedtime)
		setActive(iter_9_1:Find("finish/line"), arg_9_1.usedtime >= iter_9_0 + 1)
	end

	return
end

function ValentineQtePage:FlushIndex(arg_10_1)
	self.indexTxt.text = "<color=#753330>" .. arg_10_1.usedtime .. "</color><color=#605176>/7</color>"

	return
end

function ValentineQtePage:OnUpdateFlush()
	return
end

function ValentineQtePage:OnDestroy()
	return
end

return ValentineQtePage
