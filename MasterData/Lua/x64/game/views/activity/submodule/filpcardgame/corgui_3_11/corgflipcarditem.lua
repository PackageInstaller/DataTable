local CORGFlipCardItem = class("CORGFlipCardItem", ReduxView)

function CORGFlipCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CORGFlipCardItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.typeController_ = self.controller_:GetController("type")
end

function CORGFlipCardItem:AddUIListener()
	return
end

function CORGFlipCardItem:RefreshUI()
	local var_4_0 = FlipCardCfg[XH3rdFlipCardData:GetActivityID()]

	if var_4_0.atlas_name ~= "" and var_4_0.normal_front_back_icon ~= "" and var_4_0.special_front_back_icon ~= "" then
		self.normalBg_.sprite = getSprite(var_4_0.atlas_name, var_4_0.normal_front_back_icon)
		self.specialBg_.sprite = getSprite(var_4_0.atlas_name, var_4_0.special_front_back_icon)
	else
		self.normalBg_.spriteAsync = var_4_0.normal_front_back_icon
		self.specialBg_.spriteAsync = var_4_0.special_front_back_icon
	end

	if var_4_0.icon_path ~= "" then
		self.icon_.spriteAsync = var_4_0.icon_path .. "_" .. self.id_
	end
end

function CORGFlipCardItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2

	self:RefreshUI()
end

function CORGFlipCardItem:Dispose()
	CORGFlipCardItem.super.Dispose(self)
end

return CORGFlipCardItem
