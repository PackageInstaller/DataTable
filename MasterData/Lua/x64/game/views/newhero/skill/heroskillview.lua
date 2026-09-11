local HeroSkillView = class("HeroSkillView", ReduxView)

HeroSkillView.skillAdditionType = {
	astrolabe = 3,
	weaponModule = 2,
	attribute = 4,
	weaponServant = 1
}

local var_0_1 = {
	PROPERTY = 2,
	SKILL = 1
}
local var_0_2 = {
	[var_0_1.SKILL] = "skill",
	[var_0_1.PROPERTY] = "property"
}
local var_0_3 = 6
local var_0_4 = 1.2
local var_0_5 = 0.333

function HeroSkillView:OnCtor(arg_1_1, arg_1_2)
	self.parent = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroSkillView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroSkillView:InitUI()
	self:BindCfgUI()

	self.skillItemList = {}

	for iter_3_0 = 1, var_0_3 do
		self.skillItemList[iter_3_0] = HeroSkillViewItem.New(self, self["skillitem" .. iter_3_0 .. "Go_"])
	end

	self.heroSkillInfo_ = HeroSkillInfoView.New(self, self.skillnodeGo_)
	self.heroSkillProperty_ = HeroSkillPropertyView.New(self, self.propertynodeGo_)
	self.showStateController_ = self.controllerexcollection_:GetController("showState")
	self.previewController_ = self.controllerexcollection_:GetController("preview")
end

function HeroSkillView:AddUIListener()
	for iter_4_0 = 1, var_0_3 do
		self.skillItemList[iter_4_0]:RegistCallBack(function(arg_5_0)
			self:OnClickSkillItem(iter_4_0, arg_5_0)
		end)
	end

	self:AddBtnListener(self.comboskillBtn_, nil, function()
		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = self.heroInfo.id
		})
	end)
end

function HeroSkillView:OnClickSkillItem(arg_7_1, arg_7_2)
	if self.selectSkillId == arg_7_2.id then
		return
	end

	self.selectSkillId = arg_7_2.id
	self.selectIndex = arg_7_1
	self.params.skillId = self.selectSkillId

	self:RefreshSelectSkill(arg_7_2.id, true)
end

function HeroSkillView:UpdateRedState()
	if not self:CheckIsSelf() then
		manager.redPoint:setRedPoint({
			display = self.parent.skillBtn_.transform
		}, false)
		manager.redPoint:setRedPoint({
			display = self.parent.propertyBtn_.transform
		}, false)

		return
	end

	local var_8_0 = self.skillList[self.selectIndex]
	local var_8_1

	if self.skillList[self.selectIndex] then
		var_8_1 = var_8_0.isCanStarUp or false

		local var_8_2

		if var_8_0 then
			var_8_2 = var_8_0.isCanAttrUp or false
		end
	end

	manager.redPoint:setRedPoint({
		display = self.parent.skillBtn_.transform
	}, var_8_1)
	manager.redPoint:setRedPoint({
		display = self.parent.propertyBtn_.transform
	}, var_8_2)
end

function HeroSkillView:CheckIsSelf()
	self.heroViewDataProxy = self.params.proxy

	if self.heroViewDataProxy and self.heroViewDataProxy:CheckIsSelf() then
		return true
	end

	return false
end

function HeroSkillView:RefreshSelectSkill(arg_10_1, arg_10_2)
	self.parent:NotHaveAttrShow(self:isNotHaveAttrSkill(arg_10_1))
	self:RefreshSkillList()
	self:RefreshSkillInfo(arg_10_2)
	self:RefreshPropertyInfo(arg_10_2)
end

function HeroSkillView:isNotHaveAttrSkill(arg_11_1)
	local var_11_0 = SkillTools.GetSkillAttrCfg(self.heroId, SkillTools.GetSkillIdIndex(arg_11_1), 2)

	if not var_11_0 or not next(var_11_0) or not next(var_11_0.attr) then
		return true
	end

	return false
end

function HeroSkillView:OnEnter(arg_12_1)
	SetActive(self.gameObject_, true)

	self.params = arg_12_1
	self.isGoHeroMain = false
	self.skillAni_.enabled = true

	self:InitData()
	self:InitViewCallback()
	self.heroSkillInfo_:OnEnter(self.params.proxy)
	self.heroSkillProperty_:OnEnter(self.params.proxy)

	for iter_12_0 = 1, 6 do
		self.skillItemList[iter_12_0]:SetProxy(self.params.proxy)
		self.skillItemList[iter_12_0]:SetShowAdd(true)
	end

	self:RefreshSelectSkill(self.selectSkillId)
	self.previewController_:SetSelectedState(tostring(self.heroViewDataProxy:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))
	self:RefreshComboSkillBtn()
end

function HeroSkillView:InitData()
	self.selectSkillId = self.selectSkillId or self.params.skillId
	self.heroInfo = self.params.heroInfo

	if self.heroInfo then
		self.heroId = self.heroInfo.id or nil
	end

	self.aniEndPos = self.params.aniEndPos
	self.heroViewDataProxy = self.params.proxy
	self.skillList = self.heroViewDataProxy:GetHeroSkillInfo(self.heroId)
	self.selectIndex = 1

	for iter_13_0, iter_13_1 in pairs(self.skillList) do
		if iter_13_1.id == self.selectSkillId then
			self.selectIndex = iter_13_0

			break
		end
	end

	for iter_13_2 = 1, var_0_3 do
		self.skillItemList[iter_13_2]:SetProxy(self.heroViewDataProxy)
	end
end

function HeroSkillView:InitViewCallback()
	self.heroSkillInfo_:SetTempRefreshCallback(function(arg_15_0, arg_15_1, arg_15_2)
		self:TempSkillUpgrade(arg_15_0, arg_15_1, arg_15_2)
	end)
end

function HeroSkillView:RefreshComboSkillBtn()
	local var_16_0 = ComboSkillTools.GetHeroComboSkill(self.heroId)

	if var_16_0 and #var_16_0 > 0 then
		SetActive(self.comboskillBtn_.gameObject, true)
	else
		SetActive(self.comboskillBtn_.gameObject, false)
	end
end

function HeroSkillView:ChangeTabShow(arg_17_1)
	self.showStateController_:SetSelectedState(var_0_2[arg_17_1])
	self:RefreshSkillList()
end

function HeroSkillView:OnHeroSkillAttrUpgradeInView(arg_18_1, arg_18_2)
	self:RefreshSkillData()
	self.heroSkillProperty_:OnHeroSkillAttrUpgradeInView(arg_18_1, arg_18_2)
	self.heroSkillInfo_:UpdateTargetCondition(4)
end

function HeroSkillView:OnHeroSkillUpgrade(arg_19_1, arg_19_2)
	self:RefreshSkillData()
	self.heroSkillInfo_:OnHeroSkillUpgrade(arg_19_1, arg_19_2)
	self.heroSkillProperty_:RefreshUi()
end

function HeroSkillView:TempSkillUpgrade(arg_20_1, arg_20_2, arg_20_3)
	for iter_20_0, iter_20_1 in pairs(self.skillList) do
		if arg_20_1 == iter_20_1.id then
			self.skillList[iter_20_0].tempAddLevel = arg_20_2
		end

		iter_20_1.isCanStarUp = SkillTools.GetIsCanUp(iter_20_1.id, iter_20_1.lv + (iter_20_1.tempAddLevel or 0), arg_20_3)
	end

	self:RefreshSkillList()

	for iter_20_2, iter_20_3 in pairs(self.skillList) do
		if arg_20_1 == iter_20_3.id then
			self.skillList[iter_20_2].tempAddLevel = 0
		end
	end
end

function HeroSkillView:RefreshSkillData()
	self.skillList = self.heroViewDataProxy:GetHeroSkillInfo(self.heroId)

	self:RefreshSkillList()
end

function HeroSkillView:RefreshSkillList()
	if self.skillList then
		for iter_22_0 = 1, var_0_3 do
			self.skillItemList[iter_22_0]:RefreshData(self.skillList[iter_22_0], self.parent:GetSelectTabType())
		end
	end

	self:UpdateRedState()
end

function HeroSkillView:RefreshSkillInfo(arg_23_1)
	self.heroSkillInfo_:UpdateSkillData(self.skillList[self.selectIndex], arg_23_1)
end

function HeroSkillView:RefreshPropertyInfo(arg_24_1)
	self.heroSkillProperty_:UpdatePropertyData(self.skillList[self.selectIndex], arg_24_1)
end

function HeroSkillView:GetPlayBackwardsAnimator()
	if not self.isGoHeroMain then
		return {}, nil
	end

	return self.parent:isPropertyView() and {
		{
			self.propertynodeAni_,
			"Fx_Common_right_cx_out 1",
			false
		}
	} or {
		{
			self.skillnodeAni_,
			"Fx_Common_right_cx_out 1",
			false
		}
	}, handler(self, self.PlayBackwardsAnimatorFun)
end

function HeroSkillView:PlayBackwardsAnimatorFun()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		0
	}, false)
	self:PlayBackAniEffect()
	self.skillItemList[self.selectIndex]:UpdateSelectState(false)
end

function HeroSkillView:OnExit()
	self.selectSkillId = nil

	SetActive(self.gameObject_, false)
end

function HeroSkillView:OnTop()
	manager.windowBar:RegistBackCallBack(function()
		self.isGoHeroMain = true

		JumpTools.Back(nil, {
			isSkillReturn = true
		})
	end)
end

function HeroSkillView:Dispose()
	if self.exitTimer then
		self.exitTimer:Stop()

		self.exitTimer = nil
	end

	if self.skillCxTimer then
		self.skillCxTimer:Stop()

		self.skillCxTimer = nil
	end

	if self.backTween then
		LeanTween.cancel(self.backTween.id)

		self.backTween = nil
	end

	for iter_30_0 = 1, var_0_3 do
		self.skillItemList[iter_30_0]:Dispose()
	end

	self.heroSkillInfo_:Dispose()
	self.heroSkillProperty_:Dispose()
	HeroSkillView.super.Dispose(self)
end

function HeroSkillView:PlaySkillCxAnim()
	if self.skillCxTimer then
		self.skillCxTimer:Stop()

		self.skillCxTimer = nil
	end

	self.skillCxTimer = Timer.New(function()
		self.skillAni_:Play("Fx_skill_cx", 0, 0)
	end, 0.5)

	self.skillCxTimer:Start()
end

function HeroSkillView:SetEffectState(arg_33_1)
	if arg_33_1 then
		self:PlayBackAniEffect()

		if self.skillnodeAni_:GetCurrentAnimatorClipInfoCount(0) > 0 then
			self.skillnodeAni_:SetFloat("speed", -var_0_4)
			self.skillnodeAni_:Play("Fx_Common_right_cx", 0, self.skillnodeAni_:GetCurrentAnimatorClipInfo(0)[0].clip.length)
		end

		if self.propertynodeAni_:GetCurrentAnimatorClipInfoCount(0) > 0 then
			self.propertynodeAni_:SetFloat("speed", -var_0_4)
			self.propertynodeAni_:Play("Fx_Common_right_cx", 0, self.propertynodeAni_:GetCurrentAnimatorClipInfo(0)[0].clip.length)
		end
	end
end

function HeroSkillView:PlayBackAniEffect()
	local var_34_0 = self.skillTrs_.position

	self.skillAni_.enabled = false
	self.backTween = LeanTween.value(0, 1, var_0_5 / var_0_4):setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
		self.skillTrs_.position = Vector3.Lerp(var_34_0, self.aniEndPos, arg_35_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if self.backTween then
			self.backTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			self.backTween = nil
		end
	end)):setEase(LeanTweenType.easeOutQuad)
end

return HeroSkillView
