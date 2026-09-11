local MoleItem = class("MoleItem", ReduxView)

function MoleItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
	self:AddListeners()
end

function MoleItem:InitUI()
	self:BindCfgUI()
end

function MoleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.clickCallback_(self.index_)
	end)
end

function MoleItem:RegisterClick(arg_5_1)
	self.clickCallback_ = arg_5_1
end

function MoleItem:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.whackMoleID_ = arg_6_2

	local var_6_0 = self:GetSprite()

	if var_6_0 then
		self.icon_.sprite = var_6_0
	end
end

function MoleItem:GetSprite()
	return pureGetSpriteWithoutAtlas(ActivityMoleCfg[self.whackMoleID_].pitcture_path)
end

return MoleItem
