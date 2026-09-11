local AutoChessOpenCardBoxItem = class("AutoChessOpenCardBoxItem", ReduxView)

function AutoChessOpenCardBoxItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessOpenCardBoxItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessOpenCardBoxItem:InitUI()
	self.normalItem_ = AutoChessOpenCardBoxBaseItem.New(self.go_)
	self.URItem_ = AutoChessOpenCardBoxBaseItem.New(self.urGo_)
end

function AutoChessOpenCardBoxItem:AddListeners()
	return
end

function AutoChessOpenCardBoxItem:SetData(arg_5_1)
	self.item_ = nil

	if arg_5_1 then
		self.URItem_:SetActive(true)
		self.normalItem_:SetActive(false)

		self.item_ = self.URItem_
	else
		self.URItem_:SetActive(false)
		self.normalItem_:SetActive(true)

		self.item_ = self.normalItem_
	end
end

function AutoChessOpenCardBoxItem:SetGuideState(arg_6_1)
	if self.item_ then
		self.item_:SetGuideState(arg_6_1)
	end
end

function AutoChessOpenCardBoxItem:PlayAnim(arg_7_1)
	if self.item_ then
		self.item_:PlayAnim(arg_7_1)
	end
end

function AutoChessOpenCardBoxItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function AutoChessOpenCardBoxItem:SetLightState(arg_9_1)
	self.URItem_:SetLightState(arg_9_1)
	self.normalItem_:SetLightState(arg_9_1)
end

function AutoChessOpenCardBoxItem:OnExit()
	if self.item_ then
		self.item_:OnExit()
	end
end

function AutoChessOpenCardBoxItem:Dispose()
	self.normalItem_:Dispose()
	self.URItem_:Dispose()
	AutoChessOpenCardBoxItem.super.Dispose(self)
end

return AutoChessOpenCardBoxItem
