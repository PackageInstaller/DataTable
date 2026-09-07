local USSkirmishRePage = class("USSkirmishRePage", import("...base.BaseActivityPage"))

function USSkirmishRePage:OnInit()
	self:initUI()
	self:initData()
	self:addListener()

	return
end

function USSkirmishRePage:OnFirstFlush()
	return
end

function USSkirmishRePage:OnUpdateFlush()
	for iter_3_0, iter_3_1 in ipairs(self.taskVOList) do
		local var_3_0 = self.progress:GetChild(iter_3_0 - 1)
		local var_3_1 = var_3_0:Find("Empty")
		local var_3_2 = var_3_0:Find("Full")

		if iter_3_1.state < SkirmishVO.StateClear then
			setActive(var_3_1, true)
			setActive(var_3_2, false)
		else
			setActive(var_3_1, false)
			setActive(var_3_2, true)
		end
	end

	return
end

function USSkirmishRePage:initUI()
	self.bg = self._tf:Find("AD")
	self.progress = self._tf:Find("Progress")
	self.helpBtn = self._tf:Find("HelpBtn")
	self.battleBtn = self._tf:Find("BattleBtn")

	return
end

function USSkirmishRePage:initData()
	self.taskGroup = Clone(pg.activity_template[ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE].config_data)
	self.taskCount = #self.taskGroup
	self.skirmishProxy = getProxy(SkirmishProxy)

	self.skirmishProxy:UpdateSkirmishProgress()

	self.taskVOList = Clone(self.skirmishProxy.data)

	return
end

function USSkirmishRePage:addListener()
	onButton(self, self.helpBtn, function()
		if pg.gametip.help_tempesteve then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.help_tempesteve.tip
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.battleBtn, function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL, {
			mapIdx = SkirmishProxy.SkirmishMap
		})

		return
	end, SFX_PANEL)

	return
end

return USSkirmishRePage
