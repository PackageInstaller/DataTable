local BloodCardBuildSmallCardItem = class("BloodCardBuildSmallCardItem", ReduxView)

function BloodCardBuildSmallCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BloodCardBuildSmallCardItem:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.stateController_ = self.controller_:GetController("state")
	self.goldController_ = self.controller_:GetController("gold")
end

function BloodCardBuildSmallCardItem:AddUIListener()
	return
end

function BloodCardBuildSmallCardItem:RefreshUI()
	self.goldController_:SetSelectedState(tostring(self.cfg_.kind == BloodCardConst.CARD_KIND.GOLD))
end

function BloodCardBuildSmallCardItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2
	self.cfg_ = BloodCardGameCardCfg[arg_5_2]
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_Com/CORGUI_3_10_BloodCardUI/" .. self.cfg_.illustration)

	self:RefreshUI()
end

function BloodCardBuildSmallCardItem:SetClickCallBack(arg_6_1)
	self.clickCallBack = arg_6_1
end

function BloodCardBuildSmallCardItem:SetState(arg_7_1, arg_7_2)
	self.stateController_:SetSelectedState(arg_7_1)

	self.numberText_.text = "+" .. arg_7_2
end

function BloodCardBuildSmallCardItem:Dispose()
	BloodCardBuildSmallCardItem.super.Dispose(self)
end

return BloodCardBuildSmallCardItem
