local QWorldMainMenuItemContainer = class("QWorldMainMenuItemContainer", ReduxView)

function QWorldMainMenuItemContainer:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
end

function QWorldMainMenuItemContainer:Render(arg_2_1, arg_2_2)
	self.mainView = arg_2_1
	self.systemId = arg_2_2

	self:Init()
end

function QWorldMainMenuItemContainer:Init()
	if self.entity then
		self.entity:Dispose()

		self.entity = nil
	end

	if QWorldMainMenuConst[self.systemId] then
		self.entity = import("game.views.qworld.main." .. QWorldMainMenuConst[self.systemId]).New(self.gameObject_, self.mainView, self.systemId)

		self.entity:Render()
	else
		Debug.LogError("错误,未实现的主界面系统Id:" .. (self.systemId or "nil"))
	end

	self:BindKeyMapValue()
end

function QWorldMainMenuItemContainer:BindKeyMapValue()
	local var_4_0 = self.transform_:GetComponent(typeof(P08.Gamepad.HIDInputPage))

	if var_4_0 then
		var_4_0:ReplaceButtonTypeIndex(SandPlaySystemCfg[self.systemId].button_type)
		var_4_0:RefreshActionUI()
	end
end

function QWorldMainMenuItemContainer:Dispose()
	if self.entity then
		self.entity:Dispose()

		self.entity = nil
	end

	QWorldMainMenuItemContainer.super.Dispose(self)
end

return QWorldMainMenuItemContainer
