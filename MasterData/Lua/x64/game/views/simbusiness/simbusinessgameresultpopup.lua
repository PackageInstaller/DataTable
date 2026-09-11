local SimBusinessGameResultPopup = class("SimBusinessGameResultPopup", ReduxView)

SimBusinessConst = import("game.const.SimBusinessConst")

function SimBusinessGameResultPopup:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SimBusinessResultPopUI"
end

function SimBusinessGameResultPopup:UIParent()
	return manager.ui.uiPop.transform
end

function SimBusinessGameResultPopup:OnCtor()
	return
end

function SimBusinessGameResultPopup:Init()
	self:BindCfgUI()

	self.resultController = self.controllerCollectionEx_:GetController("result")
	self.guestInfoList = LuaList.New(handler(self, self.RenderGuestItem), self.guestList_.gameObject, SimBusinessGuestInfoItem)

	self:AddUIListener()
end

function SimBusinessGameResultPopup:Dispose()
	self.guestInfoList:Dispose()
	SimBusinessGameResultPopup.super.Dispose(self)
end

function SimBusinessGameResultPopup:OnEnter()
	local var_6_1 = self.params_.isClear

	self.callback = self.params_.callback
	self.guestStatus = self.params_.guest

	self.resultController:SetSelectedState(var_6_1 and "succeed" or "fail")

	if var_6_1 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo")
	else
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error")
		manager.audio:PlayEffect("minigame_activity_3_3", "minigame_activity_3_3_chess_gridui_losecoin")
	end

	self.guestInfoList:StartScroll(#self.guestStatus)
end

function SimBusinessGameResultPopup:OnExit()
	return
end

function SimBusinessGameResultPopup:OnTop()
	manager.windowBar:HideBar()
end

function SimBusinessGameResultPopup:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()

		if self.callback then
			self.callback()
		end
	end)
end

function SimBusinessGameResultPopup:RenderGuestItem(arg_11_1, arg_11_2)
	arg_11_2:HideIfHpBarEmpty(true)
	arg_11_2:RefreshData(self.guestStatus[arg_11_1], arg_11_1, false, true, false)
end

return SimBusinessGameResultPopup
