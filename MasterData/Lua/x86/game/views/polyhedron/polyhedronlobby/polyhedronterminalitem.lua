local PolyhedronTerminalItem = class("PolyhedronTerminalItem", ReduxView)

function PolyhedronTerminalItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.id = arg_1_2

	self:Init()
end

function PolyhedronTerminalItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronTerminalItem:InitUI()
	self:BindCfgUI()

	self.frameController = ControllerUtil.GetController(self.transform_, "frame")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")

	local var_3_0 = PolyhedronTerminalCfg[self.id]
	local var_3_1 = (PolyhedronTerminalCfg[self.id].classify or 1) - 1

	if var_3_0.hinge == 0 then
		self.frameController:SetSelectedIndex(var_3_1)
	else
		self.frameController:SetSelectedIndex(var_3_1 + 3)
	end

	self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. var_3_0.icon)
end

function PolyhedronTerminalItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id, self)
		end
	end)
end

function PolyhedronTerminalItem:SetData(arg_6_1, arg_6_2)
	self.stateController:SetSelectedIndex(arg_6_2)
end

function PolyhedronTerminalItem:SetChoice(arg_7_1)
	self.selectController:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function PolyhedronTerminalItem:GetId()
	return self.id
end

function PolyhedronTerminalItem:RegistCallBack(arg_9_1)
	self.clickFunc = arg_9_1
end

function PolyhedronTerminalItem:Dispose()
	PolyhedronTerminalItem.super.Dispose(self)
end

return PolyhedronTerminalItem
