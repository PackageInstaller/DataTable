local OathLvInfo = class("OathLvInfo", ReduxView)

function OathLvInfo:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function OathLvInfo:InitUI()
	self:BindCfgUI()

	self.lvStateController_ = self.controller_:GetController("lvState")
end

function OathLvInfo:SetData(arg_3_1)
	self.heroID = arg_3_1

	self:RegistEventListener(OATH_HERO_LV_UPDATE, handler(self, self.OnLvChange))
	self:RefreshUI()
end

function OathLvInfo:OnLvChange()
	self:RefreshUI()
end

function OathLvInfo:RefreshUI()
	local var_5_0 = OathCollectionContentData:GetOathLevel(self.heroID)

	self.lvText_.text = OathTools.GetOathLvShowTips(var_5_0) or var_5_0

	local var_5_1, var_5_2 = OathAssignmentData:GetOathAssignmentHeroLevelProgress(self.heroID, var_5_0)

	self.progressImg_.fillAmount = var_5_1 / var_5_2

	if var_5_0 >= OathConst.OATH_MAX_LV then
		self.lvStateController_:SetSelectedState("max")
	else
		self.lvStateController_:SetSelectedState("normal")
	end
end

function OathLvInfo:OnExit()
	self:RemoveAllEventListener()
end

function OathLvInfo:Dispose()
	OathLvInfo.super.Dispose(self)
end

return OathLvInfo
