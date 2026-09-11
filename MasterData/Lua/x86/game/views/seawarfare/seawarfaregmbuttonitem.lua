local SeaWarfareGmButtomItem = class("SeaWarfareGmButtomItem", ReduxView)

function SeaWarfareGmButtomItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SeaWarfareGmButtomItem:Init()
	self:InitUI()
	self:AddListeners()
end

function SeaWarfareGmButtomItem:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.controllerEx_:GetController("select")
end

function SeaWarfareGmButtomItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.clickCallback(self.id_)
	end)
end

function SeaWarfareGmButtomItem:SetData(arg_6_1)
	self.id_ = arg_6_1
	self.title_.text = arg_6_1
end

function SeaWarfareGmButtomItem:SetSelect(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "on" or "off")
end

function SeaWarfareGmButtomItem:SetClickCallBack(arg_8_1)
	self.clickCallback = arg_8_1
end

function SeaWarfareGmButtomItem:GetID()
	return self.id_
end

return SeaWarfareGmButtomItem
