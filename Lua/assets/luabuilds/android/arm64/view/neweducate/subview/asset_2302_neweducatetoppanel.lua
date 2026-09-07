local NewEducateTopPanel = class("NewEducateTopPanel", import("view.base.BaseSubView"))

function NewEducateTopPanel:getUIName()
	return "NewEducateTopPanel"
end

function NewEducateTopPanel:OnLoaded()
	self.animCom = self._tf:GetComponent(typeof(Animation))
	self.progressPart = NewEducateTopProgress.New(self._tf:Find("progress"), self)
	self.resPart = NewEducateTopRes.New(self._tf:Find("res"), self)

	self.resPart:SetBgEnable(not self.contextData.hideBlurBg)

	self.toolbarTF = self._tf:Find("toolbar")

	setActive(self.toolbarTF:Find("btns/home"), not self.contextData.hideHome)
	setActive(self.toolbarTF:Find("btns/help/line"), not self.contextData.hideHome)

	local var_2_0 = pg.gameset.child2_rank_switch.key_value == 1 and self.contextData.char:GetPermanentData():IsTarotType()

	setActive(self.toolbarTF:Find("btns/rank"), var_2_0)
	setAnchoredPosition(self.resPart._tf, {
		x = var_2_0 and -697 or -565
	})

	return
end

function NewEducateTopPanel:OnInit()
	onButton(self, self.toolbarTF:Find("btns/rank"), function()
		self:emit(NewEducateBaseUI.GO_SUBLAYER, Context.New({
			mediator = NewEducateRankMediator,
			viewComponent = NewEducateRankLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.toolbarTF:Find("btns/collect"), function()
		self:emit(NewEducateBaseUI.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectEntranceMediator,
			viewComponent = NewEducateCollectEntranceLayer,
			data = {
				id = self.contextData.char.id
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.toolbarTF:Find("btns/refresh"), function()
		self:emit(NewEducateBaseUI.ON_BOX, {
			content = i18n("child_refresh_sure_tip"),
			onYes = function()
				pg.m02:sendNotification(GAME.NEW_EDUCATE_REFRESH, {
					id = self.contextData.char.id,
					difficulty = self.contextData.char.difficulty
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	NewEducateTopPanel.helps = {
		"child2_main_help",
		"child2_explorer_main_help"
	}

	onButton(self, self.toolbarTF:Find("btns/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n(NewEducateTopPanel.helps[self.contextData.char.id])
		})

		return
	end, SFX_PANEL)
	onButton(self, self.toolbarTF:Find("btns/home"), function()
		NewEducateHelper.TrackExitTime()
		self:emit(NewEducateBaseUI.ON_HOME)

		return
	end, SFX_PANEL)
	self:OverlayPanel(self._tf, {
		pbList = {
			self.resPart._tf
		}
	})
	self:Flush()

	return
end

function NewEducateTopPanel:Flush()
	self.progressPart:Update(self.contextData.char)
	self.resPart:Update(self.contextData.char)

	return
end

function NewEducateTopPanel:FlushRes()
	self.resPart:Update(self.contextData.char)

	return
end

function NewEducateTopPanel:FlushProgress(arg_12_1)
	self.progressPart:Update(self.contextData.char, arg_12_1)

	return
end

function NewEducateTopPanel:PlayShow()
	self.animCom:Play("anim_educate_topui_show")

	return
end

function NewEducateTopPanel:PlayHide()
	self.animCom:Play("anim_educate_topui_hide")

	return
end

function NewEducateTopPanel:OnDestroy()
	self.progressPart:Dispose()
	self.resPart:Dispose()
	self:UnOverlayPanel(self._tf)

	return
end

return NewEducateTopPanel
