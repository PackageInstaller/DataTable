local GameHelpProItem = class("GameHelpProItem", ReduxView)

function GameHelpProItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GameHelpProItem:Init()
	self:BindCfgUI()

	self.showTextureController_ = self.m_controller:GetController("showTexture")
end

function GameHelpProItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	if self.curPath_ == arg_3_2 then
		return
	end

	self.curPath_ = arg_3_2

	self:DestroyGo()

	if arg_3_3 then
		self.showTextureController_:SetSelectedState("false")

		self.prefabGo_ = Object.Instantiate(Asset.Load(arg_3_2), self.transform_)
	else
		self.showTextureController_:SetSelectedState("true")
		SetSpriteWithoutAtlasAsync(self.m_icon, arg_3_2)
	end
end

function GameHelpProItem:DestroyGo()
	if self.prefabGo_ then
		Object.Destroy(self.prefabGo_)

		self.prefabGo_ = nil
	end
end

function GameHelpProItem:Dispose()
	GameHelpProItem.super.Dispose(self)
	self:DestroyGo()
end

return GameHelpProItem
