local MatrixShopItemView = class("MatrixShopItemView", ReduxView)

function MatrixShopItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MatrixShopItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MatrixShopItemView:InitUI()
	self:BindCfgUI()

	self.qualityController_ = ControllerUtil.GetController(self.gameObject_.transform, "quality")
	self.starController_ = ControllerUtil.GetController(self.gameObject_.transform, "star")
	self.canvasGroup_ = self.nonullGo_:GetComponent(typeof(CanvasGroup))
end

function MatrixShopItemView:AddUIListener()
	self:AddBtnListener(nil, nil, "OnClick")
end

function MatrixShopItemView:OnClick()
	if self.clickFunc then
		self.clickFunc(self.terminalId_)
	end
end

function MatrixShopItemView:RegistCallBack(arg_6_1)
	self.clickFunc = arg_6_1
end

function MatrixShopItemView:SetData(arg_7_1)
	self.terminalId_ = arg_7_1
	self.matrixItem_ = MatrixItemCfg[arg_7_1]
	self.terminalCfg_ = MatrixTerminalCfg[arg_7_1]

	self:UpdateView()
end

function MatrixShopItemView:UpdateView()
	self.nameText_.text = string.format("%s x%d", GetI18NText(self.terminalCfg_.name), 1)

	self.icon_:SetNativeSize()
end

function MatrixShopItemView:OnEnter()
	return
end

function MatrixShopItemView:OnExit()
	return
end

function MatrixShopItemView:GetItemInfo()
	return self.data_
end

function MatrixShopItemView:Dispose()
	self.clickFunc = nil

	MatrixShopItemView.super.Dispose(self)
end

return MatrixShopItemView
