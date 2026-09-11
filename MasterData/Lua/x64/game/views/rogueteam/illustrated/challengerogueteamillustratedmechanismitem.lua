local ChallengeRogueTeamIllustratedMechanismItem = class("ChallengeRogueTeamIllustratedMechanismItem", ReduxView)

function ChallengeRogueTeamIllustratedMechanismItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controller_:GetController("select")
	self.lockController_ = self.controller_:GetController("empty")
end

function ChallengeRogueTeamIllustratedMechanismItem:Dispose()
	ChallengeRogueTeamIllustratedMechanismItem.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedMechanismItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callBack_ then
			self.callBack_(self.id_)
		end
	end)
end

function ChallengeRogueTeamIllustratedMechanismItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2

	local var_5_0 = RogueTeamItemCfg[self.id_]

	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_5_2))

	local var_5_1 = not ChallengeRogueTeamData:IsIllustratedObtained(ChallengeRogueTeamData:GetCacheTemplateID(), ChallengeRogueTeamConst.COLLECTION_TYPE.SEASON, arg_5_2)

	self.name_.text = var_5_1 and "???" or var_5_0.name

	self.lockController_:SetSelectedState(tostring(var_5_1))
end

function ChallengeRogueTeamIllustratedMechanismItem:SetClickCallBack(arg_6_1)
	self.callBack_ = arg_6_1
end

function ChallengeRogueTeamIllustratedMechanismItem:RefreshSelect(arg_7_1)
	self.selectController_:SetSelectedState(tostring(self.id_ == arg_7_1))
end

return ChallengeRogueTeamIllustratedMechanismItem
