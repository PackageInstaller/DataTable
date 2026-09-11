local CoreVerificationTeamInfoItem = class("CoreVerificationTeamInfoItem", ReduxView)

function CoreVerificationTeamInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()

	self.heroHeadItem_ = {}
end

function CoreVerificationTeamInfoItem:Init()
	self:InitUI()
end

function CoreVerificationTeamInfoItem:InitUI()
	self:BindCfgUI()
end

function CoreVerificationTeamInfoItem:SetData(arg_4_1)
	SetActive(self.icon_.gameObject, arg_4_1 and true or false)

	if arg_4_1 then
		local var_4_0 = HeroTools.HeroUsingSkinInfo(arg_4_1).id

		if var_4_0 == 0 then
			var_4_0 = arg_4_1
		end

		self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. var_4_0)
	end
end

function CoreVerificationTeamInfoItem:Dispose()
	for iter_5_0 = 1, 6 do
		if self.heroHeadItem_[iter_5_0] then
			self.heroHeadItem_[iter_5_0]:Dispose()

			self.heroHeadItem_[iter_5_0] = nil
		end
	end

	CoreVerificationTeamInfoItem.super.Dispose(self)
end

return CoreVerificationTeamInfoItem
