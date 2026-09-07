local ValentineQte2Page = class("ValentineQte2Page", import("view.base.BaseActivityPage"))

ValentineQte2Page.MINIGAME_HUB_ID = 63
ValentineQte2Page.MINIGAME_ID = 50

function ValentineQte2Page:OnInit()
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

function ValentineQte2Page:OnDataSetting()
	return
end

function ValentineQte2Page:OnFirstFlush()
	onButton(self, self.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, ValentineQte2Page.MINIGAME_ID)

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

	local var_3_0 = getProxy(MiniGameProxy):GetHubByHubId(ValentineQte2Page.MINIGAME_HUB_ID)

	self:FlushMarks(var_3_0)
	Canvas.ForceUpdateCanvases()
	self:FlushIndex(var_3_0)

	return
end

function ValentineQte2Page:ShowAwards()
	self:emit(ActivityMediator.ON_AWARD_WINDOW, self:GetDropList(), getProxy(MiniGameProxy):GetHubByHubId(ValentineQte2Page.MINIGAME_HUB_ID).usedtime, {
		i18n("Valentine_minigame_label3"),
		i18n("Valentine_minigame_label2")
	})

	return
end

function ValentineQte2Page:GetDropList()
	return pg.mini_game[ValentineQte2Page.MINIGAME_ID].simple_config_data.drop_ids
end

function ValentineQte2Page:FlushMarks(arg_9_1)
	local var_9_0 = arg_9_1.usedtime + arg_9_1.count

	for iter_9_0, iter_9_1 in ipairs(self.markTrs) do
		setActive(iter_9_1, iter_9_0 <= var_9_0)
		setActive(iter_9_1:Find("finish"), iter_9_0 <= arg_9_1.usedtime)
		setActive(iter_9_1:Find("finish/line"), arg_9_1.usedtime >= iter_9_0 + 1)
	end

	return
end

function ValentineQte2Page:FlushIndex(arg_10_1)
	self.indexTxt.text = "<color=#e68f72>" .. arg_10_1.usedtime .. "</color><color=#5a4141>/7</color>"

	return
end

function ValentineQte2Page:OnUpdateFlush()
	return
end

function ValentineQte2Page:OnDestroy()
	return
end

return ValentineQte2Page
