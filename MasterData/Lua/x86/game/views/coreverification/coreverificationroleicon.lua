local CoreVerificationRoleIcon = class("CoreVerificationRoleIcon", ReduxView)

function CoreVerificationRoleIcon:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CoreVerificationRoleIcon:Init()
	self:BindCfgUI()

	self.emptyController_ = self.mainControllerEx_:GetController("empty")
end

function CoreVerificationRoleIcon:SetData(arg_3_1)
	if arg_3_1 then
		self.emptyController_:SetSelectedState("false")

		local var_3_0 = HeroTools.HeroUsingSkinInfo(arg_3_1).id

		if var_3_0 == 0 then
			var_3_0 = arg_3_1
		end

		self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. var_3_0)
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function CoreVerificationRoleIcon:Dispose()
	CoreVerificationRoleIcon.super.Dispose(self)
end

return CoreVerificationRoleIcon
