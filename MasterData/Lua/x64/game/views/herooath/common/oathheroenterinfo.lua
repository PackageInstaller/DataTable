local OathHeroEnterInfo = class("OathHeroEnterInfo", ReduxView)

function OathHeroEnterInfo:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:InitUI()
end

function OathHeroEnterInfo:InitUI()
	self:BindCfgUI()

	self.lvStateController_ = self.controller_:GetController("oathLv")
	self.oathStateController_ = self.controller_:GetController("oathState")
	self.showStateController_ = self.controller_:GetController("show")

	self:AddListeners()
end

function OathHeroEnterInfo:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_homepage_touch",
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
			source = OathConst.OATH_SOURCE_ID.HERO
		})
		OathTools.JumpToOathView(self.heroID)
	end)
end

function OathHeroEnterInfo:SetData(arg_5_1, arg_5_2)
	self.heroID = arg_5_1
	self.heroProxy = arg_5_2

	self:RefreshUI()
end

function OathHeroEnterInfo:RefreshUI()
	if OathTools.GetIsOpenOath() and OathTools.GetIsCanOathHero(self.heroID) and OathTools.IsCanShowInHeroInfoView() then
		self.showStateController_:SetSelectedState("show")

		local var_6_0 = OathCollectionContentData:GetOathLevel(self.heroID)

		self.lvText_.text = OathTools.GetOathLvShowTips(var_6_0) or var_6_0

		if var_6_0 == 0 then
			self.lvStateController_:SetSelectedState("begin")
		elseif var_6_0 >= OathConst.OATH_MAX_LV then
			self.lvStateController_:SetSelectedState("max")
		else
			self.lvStateController_:SetSelectedState("normal")
		end

		if OathTools.IsOath(self.heroID) then
			self.oathStateController_:SetSelectedState("finishOath")
		else
			self.oathStateController_:SetSelectedState("noOath")
		end

		self.roleImg_.sprite = OathTools.GetOathCharacterEnterSprite(self.heroID)

		local var_6_1 = manager.redPoint:getTipBoolean(RedPointConst.OATH_HERO .. self.heroID)

		manager.redPoint:SetRedPointIndependent(self.btn_.transform, var_6_1, nil, (var_6_1 and manager.redPoint:getTipBoolean(RedPointConst.OATH_NEW_HERO .. self.heroID) or nil) and RedPointStyle.SHOW_NEW_TAG)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
		self.showStateController_:SetSelectedState("hide")
	end
end

function OathHeroEnterInfo:OnExit()
	return
end

function OathHeroEnterInfo:Dispose()
	self:RemoveAllListeners()
	OathHeroEnterInfo.super.Dispose(self)
end

return OathHeroEnterInfo
