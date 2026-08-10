local var_0_0 = class("HeroSkillView", ReduxView)

var_0_0.skillAdditionType = {
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

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skillItemList = {}

	for iter_3_0 = 1, var_0_3 do
		local var_3_0 = arg_3_0["skillitem" .. iter_3_0 .. "Go_"]

		arg_3_0.skillItemList[iter_3_0] = HeroSkillViewItem.New(arg_3_0, var_3_0)
	end

	arg_3_0.heroSkillInfo_ = HeroSkillInfoView.New(arg_3_0, arg_3_0.skillnodeGo_)
	arg_3_0.heroSkillProperty_ = HeroSkillPropertyView.New(arg_3_0, arg_3_0.propertynodeGo_)
	arg_3_0.showStateController_ = arg_3_0.controllerexcollection_:GetController("showState")
	arg_3_0.previewController_ = arg_3_0.controllerexcollection_:GetController("preview")
end

function var_0_0.AddUIListener(arg_4_0)
	for iter_4_0 = 1, var_0_3 do
		arg_4_0.skillItemList[iter_4_0]:RegistCallBack(function(arg_5_0)
			arg_4_0:OnClickSkillItem(iter_4_0, arg_5_0)
		end)
	end

	arg_4_0:AddBtnListener(arg_4_0.comboskillBtn_, nil, function()
		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = arg_4_0.heroInfo.id
		})
	end)
end

function var_0_0.OnClickSkillItem(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.selectSkillId == arg_7_2.id then
		return
	end

	arg_7_0.selectSkillId = arg_7_2.id
	arg_7_0.selectIndex = arg_7_1
	arg_7_0.params.skillId = arg_7_0.selectSkillId

	arg_7_0:RefreshSelectSkill(arg_7_2.id, true)
end

function var_0_0.UpdateRedState(arg_8_0)
	if not arg_8_0:CheckIsSelf() then
		manager.redPoint:setRedPoint({
			display = arg_8_0.parent.skillBtn_.transform
		}, false)
		manager.redPoint:setRedPoint({
			display = arg_8_0.parent.propertyBtn_.transform
		}, false)

		return
	end

	local var_8_0 = arg_8_0.skillList[arg_8_0.selectIndex]
	local var_8_1 = var_8_0 and var_8_0.isCanStarUp or false
	local var_8_2 = var_8_0 and var_8_0.isCanAttrUp or false

	manager.redPoint:setRedPoint({
		display = arg_8_0.parent.skillBtn_.transform
	}, var_8_1)
	manager.redPoint:setRedPoint({
		display = arg_8_0.parent.propertyBtn_.transform
	}, var_8_2)
end

function var_0_0.CheckIsSelf(arg_9_0)
	arg_9_0.heroViewDataProxy = arg_9_0.params.proxy

	if arg_9_0.heroViewDataProxy and arg_9_0.heroViewDataProxy:CheckIsSelf() then
		return true
	end

	return false
end

function var_0_0.RefreshSelectSkill(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.parent:NotHaveAttrShow(arg_10_0:isNotHaveAttrSkill(arg_10_1))
	arg_10_0:RefreshSkillList()
	arg_10_0:RefreshSkillInfo(arg_10_2)
	arg_10_0:RefreshPropertyInfo(arg_10_2)
end

function var_0_0.isNotHaveAttrSkill(arg_11_0, arg_11_1)
	local var_11_0 = SkillTools.GetSkillIdIndex(arg_11_1)
	local var_11_1 = SkillTools.GetSkillAttrCfg(arg_11_0.heroId, var_11_0, 2)

	if not var_11_1 or not next(var_11_1) or not next(var_11_1.attr) then
		return true
	end

	return false
end

function var_0_0.OnEnter(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, true)

	arg_12_0.params = arg_12_1
	arg_12_0.isGoHeroMain = false
	arg_12_0.skillAni_.enabled = true

	arg_12_0:InitData()
	arg_12_0:InitViewCallback()
	arg_12_0.heroSkillInfo_:OnEnter(arg_12_0.params.proxy)
	arg_12_0.heroSkillProperty_:OnEnter(arg_12_0.params.proxy)

	for iter_12_0 = 1, 6 do
		arg_12_0.skillItemList[iter_12_0]:SetProxy(arg_12_0.params.proxy)
		arg_12_0.skillItemList[iter_12_0]:SetShowAdd(true)
	end

	arg_12_0:RefreshSelectSkill(arg_12_0.selectSkillId)
	arg_12_0.previewController_:SetSelectedState(tostring(arg_12_0.heroViewDataProxy:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))
	arg_12_0:RefreshComboSkillBtn()
end

function var_0_0.InitData(arg_13_0)
	arg_13_0.selectSkillId = arg_13_0.selectSkillId or arg_13_0.params.skillId
	arg_13_0.heroInfo = arg_13_0.params.heroInfo
	arg_13_0.heroId = arg_13_0.heroInfo and arg_13_0.heroInfo.id or nil
	arg_13_0.aniEndPos = arg_13_0.params.aniEndPos
	arg_13_0.heroViewDataProxy = arg_13_0.params.proxy
	arg_13_0.skillList = arg_13_0.heroViewDataProxy:GetHeroSkillInfo(arg_13_0.heroId)
	arg_13_0.selectIndex = 1

	for iter_13_0, iter_13_1 in pairs(arg_13_0.skillList) do
		if iter_13_1.id == arg_13_0.selectSkillId then
			arg_13_0.selectIndex = iter_13_0

			break
		end
	end

	for iter_13_2 = 1, var_0_3 do
		arg_13_0.skillItemList[iter_13_2]:SetProxy(arg_13_0.heroViewDataProxy)
	end
end

function var_0_0.InitViewCallback(arg_14_0)
	arg_14_0.heroSkillInfo_:SetTempRefreshCallback(function(arg_15_0, arg_15_1, arg_15_2)
		arg_14_0:TempSkillUpgrade(arg_15_0, arg_15_1, arg_15_2)
	end)
end

function var_0_0.RefreshComboSkillBtn(arg_16_0)
	local var_16_0 = ComboSkillTools.GetHeroComboSkill(arg_16_0.heroId)

	if var_16_0 and #var_16_0 > 0 then
		SetActive(arg_16_0.comboskillBtn_.gameObject, true)
	else
		SetActive(arg_16_0.comboskillBtn_.gameObject, false)
	end
end

function var_0_0.ChangeTabShow(arg_17_0, arg_17_1)
	arg_17_0.showStateController_:SetSelectedState(var_0_2[arg_17_1])
	arg_17_0:RefreshSkillList()
end

function var_0_0.OnHeroSkillAttrUpgradeInView(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:RefreshSkillData()
	arg_18_0.heroSkillProperty_:OnHeroSkillAttrUpgradeInView(arg_18_1, arg_18_2)
	arg_18_0.heroSkillInfo_:UpdateTargetCondition(4)
end

function var_0_0.OnHeroSkillUpgrade(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:RefreshSkillData()
	arg_19_0.heroSkillInfo_:OnHeroSkillUpgrade(arg_19_1, arg_19_2)
	arg_19_0.heroSkillProperty_:RefreshUi()
end

function var_0_0.TempSkillUpgrade(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.skillList) do
		if arg_20_1 == iter_20_1.id then
			arg_20_0.skillList[iter_20_0].tempAddLevel = arg_20_2
		end

		iter_20_1.isCanStarUp = SkillTools.GetIsCanUp(iter_20_1.id, iter_20_1.lv + (iter_20_1.tempAddLevel or 0), arg_20_3)
	end

	arg_20_0:RefreshSkillList()

	for iter_20_2, iter_20_3 in pairs(arg_20_0.skillList) do
		if arg_20_1 == iter_20_3.id then
			arg_20_0.skillList[iter_20_2].tempAddLevel = 0
		end
	end
end

function var_0_0.RefreshSkillData(arg_21_0)
	arg_21_0.skillList = arg_21_0.heroViewDataProxy:GetHeroSkillInfo(arg_21_0.heroId)

	arg_21_0:RefreshSkillList()
end

function var_0_0.RefreshSkillList(arg_22_0)
	if arg_22_0.skillList then
		for iter_22_0 = 1, var_0_3 do
			arg_22_0.skillItemList[iter_22_0]:RefreshData(arg_22_0.skillList[iter_22_0], arg_22_0.parent:GetSelectTabType())
		end
	end

	arg_22_0:UpdateRedState()
end

function var_0_0.RefreshSkillInfo(arg_23_0, arg_23_1)
	arg_23_0.heroSkillInfo_:UpdateSkillData(arg_23_0.skillList[arg_23_0.selectIndex], arg_23_1)
end

function var_0_0.RefreshPropertyInfo(arg_24_0, arg_24_1)
	arg_24_0.heroSkillProperty_:UpdatePropertyData(arg_24_0.skillList[arg_24_0.selectIndex], arg_24_1)
end

function var_0_0.GetPlayBackwardsAnimator(arg_25_0)
	if not arg_25_0.isGoHeroMain then
		return {}, nil
	end

	local var_25_0

	if arg_25_0.parent:isPropertyView() then
		var_25_0 = {
			{
				arg_25_0.propertynodeAni_,
				"Fx_Common_right_cx_out 1",
				false
			}
		}
	else
		var_25_0 = {
			{
				arg_25_0.skillnodeAni_,
				"Fx_Common_right_cx_out 1",
				false
			}
		}
	end

	return var_25_0, handler(arg_25_0, arg_25_0.PlayBackwardsAnimatorFun)
end

function var_0_0.PlayBackwardsAnimatorFun(arg_26_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		0
	}, false)
	arg_26_0:PlayBackAniEffect()
	arg_26_0.skillItemList[arg_26_0.selectIndex]:UpdateSelectState(false)
end

function var_0_0.OnExit(arg_27_0)
	arg_27_0.selectSkillId = nil

	SetActive(arg_27_0.gameObject_, false)
end

function var_0_0.OnTop(arg_28_0)
	manager.windowBar:RegistBackCallBack(function()
		arg_28_0.isGoHeroMain = true

		JumpTools.Back(nil, {
			isSkillReturn = true
		})
	end)
end

function var_0_0.Dispose(arg_30_0)
	if arg_30_0.exitTimer then
		arg_30_0.exitTimer:Stop()

		arg_30_0.exitTimer = nil
	end

	if arg_30_0.skillCxTimer then
		arg_30_0.skillCxTimer:Stop()

		arg_30_0.skillCxTimer = nil
	end

	if arg_30_0.backTween then
		LeanTween.cancel(arg_30_0.backTween.id)

		arg_30_0.backTween = nil
	end

	for iter_30_0 = 1, var_0_3 do
		arg_30_0.skillItemList[iter_30_0]:Dispose()
	end

	arg_30_0.heroSkillInfo_:Dispose()
	arg_30_0.heroSkillProperty_:Dispose()
	var_0_0.super.Dispose(arg_30_0)
end

function var_0_0.PlaySkillCxAnim(arg_31_0)
	if arg_31_0.skillCxTimer then
		arg_31_0.skillCxTimer:Stop()

		arg_31_0.skillCxTimer = nil
	end

	arg_31_0.skillCxTimer = Timer.New(function()
		arg_31_0.skillAni_:Play("Fx_skill_cx", 0, 0)
	end, 0.5)

	arg_31_0.skillCxTimer:Start()
end

function var_0_0.SetEffectState(arg_33_0, arg_33_1)
	if arg_33_1 then
		arg_33_0:PlayBackAniEffect()

		local var_33_0 = arg_33_0.skillnodeAni_:GetCurrentAnimatorClipInfo(0)

		if arg_33_0.skillnodeAni_:GetCurrentAnimatorClipInfoCount(0) > 0 then
			arg_33_0.skillnodeAni_:SetFloat("speed", -var_0_4)
			arg_33_0.skillnodeAni_:Play("Fx_Common_right_cx", 0, var_33_0[0].clip.length)
		end

		local var_33_1 = arg_33_0.propertynodeAni_:GetCurrentAnimatorClipInfo(0)

		if arg_33_0.propertynodeAni_:GetCurrentAnimatorClipInfoCount(0) > 0 then
			arg_33_0.propertynodeAni_:SetFloat("speed", -var_0_4)
			arg_33_0.propertynodeAni_:Play("Fx_Common_right_cx", 0, var_33_1[0].clip.length)
		end
	end
end

function var_0_0.PlayBackAniEffect(arg_34_0)
	local var_34_0 = arg_34_0.skillTrs_.position

	arg_34_0.skillAni_.enabled = false
	arg_34_0.backTween = LeanTween.value(0, 1, var_0_5 / var_0_4):setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
		arg_34_0.skillTrs_.position = Vector3.Lerp(var_34_0, arg_34_0.aniEndPos, arg_35_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if arg_34_0.backTween then
			arg_34_0.backTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			arg_34_0.backTween = nil
		end
	end)):setEase(LeanTweenType.easeOutQuad)
end

return var_0_0
