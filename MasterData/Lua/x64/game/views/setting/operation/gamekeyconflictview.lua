local GameKeyConflictView = class("GameKeyConflictView", ReduxView)

function GameKeyConflictView:UIName()
	return "Widget/System/Setting/SettingHandl02UI"
end

function GameKeyConflictView:UIParent()
	return manager.ui.uiPop.transform
end

function GameKeyConflictView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameKeyConflictView:InitUI()
	self:BindCfgUI()

	self.styleController_ = self.keyConEx_:GetController("style")
end

function GameKeyConflictView:AddUIListener()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:InvokeCallback(true)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:InvokeCallback(false)
	end)
end

function GameKeyConflictView:OnEnter()
	self.opName_ = self.params_.opName
	self.key_ = self.params_.key
	self.keyName_ = self.params_.keyName
	self.conflictOpName_ = self.params_.conflictOpName
	self.gamepadType_ = self.params_.gamepadType

	self:RefreshUI()
end

function GameKeyConflictView:OnExit()
	return
end

function GameKeyConflictView:RefreshUI()
	local var_10_0 = LuaForGamepad.GetKeyIcon(self.keyName_, self.gamepadType_)

	if var_10_0 then
		self.styleController_:SetSelectedState(LuaForGamepad.IsGamepadKey(self.key_) and "gamepad" or "keyboard")

		self.keyImage_.sprite = var_10_0

		self.keyImage_:SetNativeSize()
	else
		self.styleController_:SetSelectedState("text")

		self.keyText_.text = GetKeyCodeMappedName(self.keyName_)
	end

	self.conflictText_.text = string.format(GetTips("INPUT_KEY_CONFLICT_TIPS"), (LuaHidTools.GetOpName(self.conflictOpName_)))
end

function GameKeyConflictView:InvokeCallback(arg_11_1)
	self:Back()

	if self.params_.listenCallback then
		self.params_.listenCallback(arg_11_1)
	end
end

function GameKeyConflictView:Dispose()
	GameKeyConflictView.super.Dispose(self)
end

return GameKeyConflictView
