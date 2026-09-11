local PolyhedronSetTerminalItem = class("PolyhedronSetTerminalItem", ReduxView)

function PolyhedronSetTerminalItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronSetTerminalItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronSetTerminalItem:InitUI()
	self:BindCfgUI()

	self.frameController = ControllerUtil.GetController(self.transform_, "frame")
end

function PolyhedronSetTerminalItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc then
			self.clickFunc(PolyhedronTerminalCfg[self.id].name, PolyhedronTerminalCfg[self.id].desc, self.transform_.position)
		end
	end)
end

function PolyhedronSetTerminalItem:SetData(arg_6_1)
	self.id = arg_6_1

	local var_6_0 = PolyhedronTerminalCfg[arg_6_1]
	local var_6_1 = (PolyhedronTerminalCfg[arg_6_1].classify or 1) - 1

	if var_6_0.hinge == 0 then
		self.frameController:SetSelectedIndex(var_6_1)
	else
		self.frameController:SetSelectedIndex(var_6_1 + 3)
	end

	self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. var_6_0.icon)
	self.m_name.text = GetI18NText(var_6_0.name)
end

function PolyhedronSetTerminalItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function PolyhedronSetTerminalItem:Dispose()
	PolyhedronSetTerminalItem.super.Dispose(self)
end

function PolyhedronSetTerminalItem:RegistCallBack(arg_9_1)
	self.clickFunc = arg_9_1
end

return PolyhedronSetTerminalItem
