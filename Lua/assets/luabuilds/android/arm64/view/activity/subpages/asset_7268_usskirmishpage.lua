local USSkirmishPage = class("USSkirmishPage", import("...base.BaseActivityPage"))

function USSkirmishPage:OnInit()
	self:initUI()
	self:initData()
	self:addListener()

	return
end

function USSkirmishPage:OnFirstFlush()
	return
end

function USSkirmishPage:OnUpdateFlush()
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

function USSkirmishPage:initUI()
	self.bg = self._tf:Find("AD")
	self.progress = self._tf:Find("Progress")
	self.helpBtn = self._tf:Find("HelpBtn")
	self.battleBtn = self._tf:Find("BattleBtn")

	return
end

function USSkirmishPage:initData()
	self.taskGroup = Clone(pg.activity_template[ActivityConst.ACTIVITY_ID_US_SKIRMISH].config_data)
	self.taskCount = #self.taskGroup
	self.skirmishProxy = getProxy(SkirmishProxy)

	self.skirmishProxy:UpdateSkirmishProgress()

	self.taskVOList = Clone(self.skirmishProxy.data)

	return
end

function USSkirmishPage:addListener()
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

return USSkirmishPage
