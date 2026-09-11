local CooperationSearchRoomView = class("CooperationSearchRoomView", ReduxView)

function CooperationSearchRoomView:UIName()
	return "Widget/System/Formation/Cooperation/CooperationSearchRoomUI"
end

function CooperationSearchRoomView:UIParent()
	return manager.ui.uiPop.transform
end

function CooperationSearchRoomView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CooperationSearchRoomView:InitUI()
	self:BindCfgUI()
	self.inputFieldNick_.textComponent:RegisterDirtyVerticesCallback(function()
		local var_5_0 = string.match(self.inputFieldNick_.text, "%d+")

		if var_5_0 and #var_5_0 > 19 then
			var_5_0 = string.sub(var_5_0, 1, 19)
		end

		self.inputFieldNick_.text = var_5_0
		self.inputFieldNick_.textComponent.text = var_5_0
	end)
end

function CooperationSearchRoomView:AddUIListener()
	self:AddBtnListener(self.buttonOk_, nil, function()
		if self.inputFieldNick_.text == nil then
			ShowTips("ACTIVITY_STRONGHOLD_ROOM_NUM_TIPS")

			return
		end

		CooperationAction.JoinRoom(self.inputFieldNick_.text, nil, CooperationConst.JOIN_ROOM_SOURCE.ROOM_ID)
	end)
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnPut_, nil, function()
		self.inputFieldNick_.text = UnityEngine.GUIUtility.systemCopyBuffer
	end)
end

function CooperationSearchRoomView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CooperationSearchRoomView:OnEnter()
	return
end

function CooperationSearchRoomView:OnExit()
	manager.windowBar:HideBar()
end

function CooperationSearchRoomView:Dispose()
	CooperationSearchRoomView.super.Dispose(self)
end

return CooperationSearchRoomView
