local ReturnAwardPage = class("ReturnAwardPage", import("...base.BaseActivityPage"))

ReturnAwardPage.INVITER = 1
ReturnAwardPage.RETURNER = 2

function ReturnAwardPage:OnFirstFlush()
	local var_1_0 = {
		InviterPage,
		ReturnerPage
	}

	assert(var_1_0[self.activity.data1], self.activity.data1)

	self.page = var_1_0[self.activity.data1].New(self._tf, self.event)

	onButton(self, self.page.help, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.returner_help.tip
		})

		return
	end)

	return
end

function ReturnAwardPage:OnUpdateFlush()
	assert(self.page)
	self.page:Update(self.activity)

	return
end

function ReturnAwardPage:OnDestroy()
	assert(self.page)
	self.page:Dispose()

	return
end

function ReturnAwardPage:UseSecondPage(arg_5_1)
	return arg_5_1.data1 > 1
end

return ReturnAwardPage
