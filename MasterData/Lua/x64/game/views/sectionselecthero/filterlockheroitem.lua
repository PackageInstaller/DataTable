local ActivityTaskBaseItem = class("ActivityTaskBaseItem", ReduxView)

function ActivityTaskBaseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
end

function ActivityTaskBaseItem:SetData(arg_2_1)
	self.headIcon_.sprite = HeroTools.GetHeadSprite(arg_2_1)

	self.headIcon_:SetNativeSize()
end

return ActivityTaskBaseItem
