local AnniversaryEightJpReturnAwardPage = class("AnniversaryEightJpReturnAwardPage", import("view.activity.CorePage.CoreActivityPage"))

AnniversaryEightJpReturnAwardPage.INVITER = 1
AnniversaryEightJpReturnAwardPage.RETURNER = 2

function AnniversaryEightJpReturnAwardPage:OnFirstFlush()
	local var_1_0 = {
		CoreInviterPage,
		CoreReturnerPage
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

function AnniversaryEightJpReturnAwardPage:OnUpdateFlush()
	assert(self.page)
	self.page:Update(self.activity)

	return
end

function AnniversaryEightJpReturnAwardPage:OnDestroy()
	assert(self.page)
	self.page:Dispose()

	return
end

function AnniversaryEightJpReturnAwardPage:UseSecondPage(arg_5_1)
	return arg_5_1.data1 > 1
end

return AnniversaryEightJpReturnAwardPage
