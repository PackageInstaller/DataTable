local EducateTopPanel = class("EducateTopPanel", import("...base.BaseSubView"))

function EducateTopPanel:getUIName()
	return "EducateTopPanel"
end

function EducateTopPanel:OnInit()
	self.helpBtn = self._tf:Find("content/btns/help")
	self.homeBtn = self._tf:Find("content/btns/home")

	setActive(self.homeBtn, not (self.contextData and self.contextData.hideBack))

	self.refresh = self._tf:Find("content/btns/refresh")

	self:addListener()

	return
end

function EducateTopPanel:addListener()
	onButton(self, self.refresh, function()
		self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_refresh_sure_tip"),
			onYes = function()
				pg.m02:sendNotification(GAME.EDUCATE_REFRESH)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.child_main_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:emit(EducateBaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

function EducateTopPanel:OnDestroy()
	return
end

return EducateTopPanel
