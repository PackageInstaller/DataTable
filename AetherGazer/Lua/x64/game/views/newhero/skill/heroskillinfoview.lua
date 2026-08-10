local var_0_0 = class("HeroSkillInfoView", HeroPageBase)
local var_0_1 = {
	additionEx = {
		showState = {
			select = "select",
			name = "showState",
			lock = "lock",
			normal = "normal"
		}
	},
	infoShowEx = {
		upState = {
			none = "none",
			name = "upState",
			up = "up",
			notUp = "notup",
			max = "max"
		}
	}
}
local var_0_2 = {
	NORMAL = 1,
	DETAIL = 2
}
local var_0_3 = {
	"hero_skill_skill_lv_up_spirit",
	"hero_skill_skill_lv_up_module",
	"hero_skill_skill_lv_up_astrolabe",
	"hero_skill_skill_lv_up_attribute"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.skillAdditionType = arg_1_0.handler_.skillAdditionType

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
	arg_2_0:CreateCostList()
	arg_2_0:InitSkillAddition()

	arg_2_0.upStateController_ = arg_2_0.infoControllerexcollection_:GetController(var_0_1.infoShowEx.upState.name)
	arg_2_0.skillAttributeItemList_ = {}
	arg_2_0.describeCanvas = arg_2_0.describeTrs_:GetComponent(typeof(Canvas))
end

function var_0_0.CreateCostList(arg_3_0)
	arg_3_0.costItem = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = arg_3_0["costitem" .. iter_3_0 .. "Go_"]

		arg_3_0.costItem[iter_3_0] = CommonItemView.New(var_3_0)
	end
end

function var_0_0.RefreshCost(arg_4_0)
	local var_4_0 = SkillTools.GetSkillIdIndex(arg_4_0.skillId)

	arg_4_0.costCfg = SkillCfg[arg_4_0.level]["skill_cost" .. var_4_0]
	arg_4_0.costEnough = true

	for iter_4_0 = 1, 2 do
		if arg_4_0.costCfg and arg_4_0.costCfg[iter_4_0] then
			arg_4_0.costItem[iter_4_0].gameObject_:SetActive(true)

			local var_4_1 = arg_4_0.costCfg[iter_4_0][1]
			local var_4_2 = arg_4_0.costCfg[iter_4_0][2]
			local var_4_3 = ItemTools.getItemNum(var_4_1)

			if arg_4_0.tempAddLevel and arg_4_0.tempAddLevel > 0 then
				var_4_3 = var_4_3 - SkillTools.GetSkillUpCostNum(arg_4_0.skillId, arg_4_0.skillLevel, arg_4_0.tempAddLevel)[var_4_1]
			end

			if var_4_3 < var_4_2 then
				arg_4_0.costEnough = false
			end

			local var_4_4 = clone(ItemTemplateData)

			var_4_4.id = var_4_1

			function var_4_4.clickFun(arg_5_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_5_0.id,
					arg_5_0.number
				})
			end

			arg_4_0.costItem[iter_4_0]:SetData(var_4_4)
			arg_4_0.costItem[iter_4_0]:RefreshBottomText({
				var_4_3,
				var_4_2
			})
			arg_4_0.costItem[iter_4_0]:RefreshBottomRightText(true)
		else
			arg_4_0.costItem[iter_4_0].gameObject_:SetActive(false)
		end
	end
end

function var_0_0.SetDescribeCanvasSort(arg_6_0, arg_6_1)
	arg_6_0.describeCanvas.overrideSorting = arg_6_1
end

function var_0_0.OpenAddTipsView(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = gameContext:IsOpenRoute("skillAddTip")

	arg_7_0:SetDescribeCanvasSort(true)

	if not var_7_0 then
		JumpTools.OpenPageByJump("skillAddTip", {
			heroId = arg_7_0.heroId,
			showType = arg_7_1,
			showTextList = arg_7_2,
			dataType = arg_7_0.heroViewDataProxy:GetViewDataType(),
			backBtnCallback = function()
				arg_7_0:SetDescribeCanvasSort(false)
				arg_7_0:ClearSkillAddSelect()
			end
		})
	else
		local var_7_1 = {
			heroId = arg_7_0.heroId,
			showType = arg_7_1,
			showTextList = arg_7_2
		}

		manager.notify:CallUpdateFunc(HERO_SKILL_ADD_VIEW_UPDATE, var_7_1)
	end
end

function var_0_0.GetAdditionValue(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = arg_9_0.heroViewDataProxy:GetAdditionShowTextByType(arg_9_0.skillId, arg_9_0.heroId, arg_9_1)

	return var_9_0, var_9_1
end

function var_0_0.OnClickSkillAdditionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.additionControDataList[arg_10_1].value

	arg_10_0:ClearSkillAddSelect()
	arg_10_0:OpenAddTipsView(arg_10_1, var_10_0)
	arg_10_0.additionControDataList[arg_10_1].controller:SetSelectedState(var_0_1.additionEx.showState.select)

	arg_10_0.selectAdditionIndex = arg_10_1
end

function var_0_0.ClearSkillAddSelect(arg_11_0)
	if arg_11_0.selectAdditionIndex then
		arg_11_0.additionControDataList[arg_11_0.selectAdditionIndex].controller:SetSelectedState(var_0_1.additionEx.showState.normal)
	end

	arg_11_0.selectAdditionIndex = nil
end

function var_0_0.InitSkillAddition(arg_12_0)
	arg_12_0.additionControDataList = {}

	for iter_12_0 = 1, 4 do
		local var_12_0 = arg_12_0["addition" .. iter_12_0 .. "Btn_"]
		local var_12_1 = arg_12_0["addition" .. iter_12_0 .. "Controllerexcollection_"]:GetController(var_0_1.additionEx.showState.name)

		arg_12_0.additionControDataList[iter_12_0] = {}
		arg_12_0.additionControDataList[iter_12_0].controller = var_12_1
		arg_12_0.additionControDataList[iter_12_0].value = nil
		arg_12_0.additionControDataList[iter_12_0].obj = var_12_0.gameObject

		arg_12_0:AddBtnListener(var_12_0, nil, function()
			OperationRecorder.RecordButtonTouch(var_0_3[iter_12_0])
			arg_12_0:OnClickSkillAdditionItem(iter_12_0)
		end)
	end
end

function var_0_0.SendSkillUpgrade(arg_14_0)
	if arg_14_0.tempAddLevel and arg_14_0.tempAddLevel > 0 then
		HeroAction.HeroSkillUpgrade(arg_14_0.heroId, arg_14_0.skillId, arg_14_0.tempAddLevel)
	end
end

function var_0_0.isCanUpSkill(arg_15_0)
	if SkillTools.GetIsDodgeSkill(arg_15_0.skillId) or arg_15_0.level == HeroConst.MAX_SKILL_LEVEL then
		arg_15_0:SendSkillUpgrade()

		return false
	end

	local var_15_0 = SkillTools.GetSkillIdIndex(arg_15_0.skillId)

	if SkillCfg[arg_15_0.level]["skill_limit" .. var_15_0] > arg_15_0.heroViewDataProxy:GetHeroData(arg_15_0.heroId).break_level then
		arg_15_0:SendSkillUpgrade()

		return false
	end

	if not arg_15_0.costEnough then
		arg_15_0:SendSkillUpgrade()
		ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")

		return false
	end

	arg_15_0.tempAddLevel = (arg_15_0.tempAddLevel or 0) + 1

	arg_15_0:tempRefreshUi()

	return true
end

function var_0_0.SetTempRefreshCallback(arg_16_0, arg_16_1)
	arg_16_0.tempRefreshCallback = arg_16_1
end

function var_0_0.tempRefreshUi(arg_17_0)
	arg_17_0:RefreshUi()

	local var_17_0 = arg_17_0:GetSkillLv()
	local var_17_1 = SkillTools.GetSkillUpCostNum(arg_17_0.skillId, arg_17_0.skillLevel, arg_17_0.tempAddLevel)

	if arg_17_0.tempRefreshCallback then
		arg_17_0.tempRefreshCallback(arg_17_0.skillId, arg_17_0.tempAddLevel, var_17_1)
	end
end

function var_0_0.AddUIListener(arg_18_0)
	arg_18_0:AddPressingByTimeListener(arg_18_0.upbtnBtn_.gameObject, 1.4, 0.2, 0.1, function()
		return arg_18_0:isCanUpSkill()
	end, handler(arg_18_0, arg_18_0.SendSkillUpgrade))
	arg_18_0:AddBtnListener(arg_18_0.recommendBtn_, nil, function()
		arg_18_0:ChangeSkillDescState()
	end)
	arg_18_0:AddBtnListener(arg_18_0.breakUpBtn_, nil, function()
		if arg_18_0.upStateController_:GetSelectedState() == var_0_1.infoShowEx.upState.notUp then
			JumpTools.OpenPageByJump("/heroUpgrade", {
				heroId = arg_18_0.heroId,
				proxy = arg_18_0.heroViewDataProxy
			})
		end
	end)
	arg_18_0:AddBtnListener(arg_18_0.oneKeyUpBtn_, nil, function()
		arg_18_0:OnOneKeyUpBtn()
	end)
	TerminologyTools.AddTerminologyHandler(arg_18_0, arg_18_0.describetextText_, nil, nil)
end

function var_0_0.OnOneKeyUpBtn(arg_23_0)
	if SkillTools.GetSkillMaxUpLv(arg_23_0.skillId, arg_23_0.skillLevel) == arg_23_0.skillLevel then
		ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")
	else
		JumpTools.OpenPageByJump("skillUpTip", {
			isAttr = false,
			proxy = arg_23_0.heroViewDataProxy,
			heroId = arg_23_0.heroId,
			skillId = arg_23_0.skillId
		})
	end
end

function var_0_0.OnHeroSkillUpgrade(arg_24_0, arg_24_1, arg_24_2)
	if isSuccess(arg_24_1.result) then
		ShowTips("SKILL_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", arg_24_0.level))
		arg_24_0:PlayHeroTalk(arg_24_0.heroId)
	else
		ShowTips(arg_24_1.result)
	end

	arg_24_0.skillLevel = nil
	arg_24_0.tempAddLevel = 0

	arg_24_0:RefreshUi()
end

function var_0_0.PlayHeroTalk(arg_25_0, arg_25_1)
	if arg_25_0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(arg_25_1, "skillup")

	arg_25_0.isTalkCD_ = true
	arg_25_0.talkCDTimer_ = Timer.New(function()
		arg_25_0.isTalkCD_ = false
	end, HeroConst.SKILL_UPGRADE_VOICE_CD, 1)

	arg_25_0.talkCDTimer_:Start()
end

function var_0_0.UpdateSkillData(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1.id
	local var_27_1 = arg_27_1.heroId
	local var_27_2 = arg_27_0.heroViewDataProxy:GetRealSkillId(var_27_1, var_27_0)

	arg_27_0.skillId = var_27_0
	arg_27_0.heroId = var_27_1
	arg_27_0.realSkillId = var_27_2
	arg_27_0.addSkillLv = arg_27_1.addSkillLv
	arg_27_0.addEquipSkillLv = arg_27_1.addEquipSkillLv or 0
	arg_27_0.tempAddLevel = 0
	arg_27_0.skillLevel = 0

	arg_27_0:RefreshUi()
	arg_27_0:RefreshAddition()

	if arg_27_2 then
		arg_27_0.rootAnimator_:Play("Fx_Common_right_cx", -1, 0)
	end
end

function var_0_0.RefreshUi(arg_28_0)
	local var_28_0 = HeroSkillCfg[arg_28_0.realSkillId]
	local var_28_1 = HeroCfg[arg_28_0.heroId]
	local var_28_2 = SkillTools.GetSkillIdIndex(arg_28_0.skillId)

	arg_28_0.skillnameText_.text = var_28_0.name
	arg_28_0.subnameText_.text = var_28_1.skill_subhead[var_28_2]
	arg_28_0.level = arg_28_0:GetSkillLv()

	local var_28_3 = arg_28_0.level

	if arg_28_0.addEquipSkillLv > 0 or arg_28_0.addSkillLv > 0 then
		arg_28_0.lvText_.text = string.format("%d <color=#E78300>+ %d</color>", var_28_3, arg_28_0.addEquipSkillLv + arg_28_0.addSkillLv)
	else
		arg_28_0.lvText_.text = string.format("%d", var_28_3)
	end

	arg_28_0:UpdateUpStateController()
	arg_28_0:RefreshCost()
	arg_28_0:UpdateElemShow(var_28_0)
	arg_28_0:UpdateSkillDescShow()
end

function var_0_0.OnEnter(arg_29_0, arg_29_1)
	arg_29_0.heroViewDataProxy = arg_29_1
	arg_29_0.descType_ = var_0_2.NORMAL
	arg_29_0.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")

	arg_29_0:SetDescribeCanvasSort(false)
end

function var_0_0.UpdateUpStateController(arg_30_0)
	if not arg_30_0.heroViewDataProxy:CheckIsSelf() or SkillTools.GetIsDodgeSkill(arg_30_0.skillId) then
		arg_30_0.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.none)

		return
	end

	if arg_30_0:RefreshCondition() then
		arg_30_0.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.notUp)
	elseif arg_30_0.level >= HeroConst.MAX_SKILL_LEVEL then
		arg_30_0.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.max)
	else
		arg_30_0.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.up)
	end
end

function var_0_0.UpdateElemShow(arg_31_0, arg_31_1)
	if arg_31_1.cd == 0 then
		arg_31_0.cdvalueText_.text = " - "
	else
		arg_31_0.cdvalueText_.text = arg_31_1.cd / 1000 .. "s"
	end

	arg_31_0.costGo_:SetActive(false)
	arg_31_0.skilltypeGo_:SetActive(false)
	arg_31_0:UpdateAttribute(arg_31_1)

	local var_31_0 = 2

	if arg_31_1.EnergyChange < 0 then
		arg_31_0.costvalueText_.text = math.abs(arg_31_1.EnergyChange) .. " " .. GetTips("NOTE_ENERGYTYPE_" .. CharactorParamCfg[arg_31_0.heroId].EnergyType)

		arg_31_0.costGo_:SetActive(true)

		var_31_0 = var_31_0 + 1
	end

	local var_31_1 = PublicSkillCfg[arg_31_0.skillId].skill_sub_type

	if var_31_1 == nil then
		var_31_1 = 0
	end

	if var_31_1 ~= 0 then
		local var_31_2 = SkillSubTypeCfg.get_id_list_by_value[var_31_1]

		arg_31_0.skilltypevalueText_.text = GetI18NText(SkillSubTypeCfg[var_31_2[1]].annotation)

		arg_31_0.skilltypeGo_:SetActive(true)

		var_31_0 = var_31_0 + 1
	end

	local var_31_3 = -187

	if var_31_0 == 3 then
		var_31_3 = -237
	elseif var_31_0 == 4 then
		var_31_3 = -287
	end

	arg_31_0.descviewTrs_.sizeDelta = Vector2(arg_31_0.descviewTrs_.sizeDelta.x, arg_31_0.infonodeTrs_.rect.height + var_31_3)
end

function var_0_0.UpdateAttribute(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.element_type

	if type(var_32_0) ~= "table" then
		var_32_0 = {}
	end

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_1 = arg_32_0.skillAttributeItemList_[iter_32_0]

		if not var_32_1 then
			local var_32_2 = GameObject.Instantiate(arg_32_0.skillAttributeItemGo_, arg_32_0.skillAttributePanelTrans_)

			var_32_1 = HeroSkillAttributeItem.New(var_32_2)
			arg_32_0.skillAttributeItemList_[iter_32_0] = var_32_1
		end

		var_32_1:SetData(iter_32_1)
		var_32_1:Show(true)
	end

	for iter_32_2 = #var_32_0 + 1, #arg_32_0.skillAttributeItemList_ do
		arg_32_0.skillAttributeItemList_[iter_32_2]:Show(false)
	end
end

function var_0_0.RefreshAddition(arg_33_0)
	for iter_33_0 = 1, 4 do
		local var_33_0 = arg_33_0:UpdateTargetCondition(iter_33_0)

		if var_33_0 then
			isShowNode = var_33_0
		end
	end
end

function var_0_0.RefreshCondition(arg_34_0)
	local var_34_0 = SkillTools.GetSkillIdIndex(arg_34_0.skillId)
	local var_34_1 = SkillCfg[arg_34_0.level]["skill_limit" .. var_34_0]
	local var_34_2 = arg_34_0.heroViewDataProxy:GetHeroData(arg_34_0.heroId)
	local var_34_3 = false

	if arg_34_0.level and var_34_1 and arg_34_0.level < HeroConst.MAX_SKILL_LEVEL and var_34_1 > var_34_2.break_level then
		arg_34_0.conditiondescireText_.text = string.format(GetTips("NOTE_SKILL_LIMIT"), var_34_1)
		arg_34_0.conditionvalueText_.text = string.format("%s/%s", var_34_2.break_level, var_34_1)
		var_34_3 = true
	end

	return var_34_3
end

function var_0_0.UpdateTargetCondition(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.additionControDataList[arg_35_1].controller
	local var_35_1, var_35_2 = arg_35_0:GetAdditionValue(arg_35_1)

	SetActive(arg_35_0.additionControDataList[arg_35_1].obj, var_35_2)

	if var_35_1 then
		var_35_0:SetSelectedState(var_0_1.additionEx.showState.normal)
	else
		var_35_0:SetSelectedState(var_0_1.additionEx.showState.lock)
	end

	arg_35_0.additionControDataList[arg_35_1].value = var_35_1

	return var_35_2
end

function var_0_0.GetSkillLv(arg_36_0)
	if not arg_36_0.skillLevel or arg_36_0.skillLevel == 0 then
		arg_36_0.skillLevel = arg_36_0.heroViewDataProxy:GetSkillLv(arg_36_0.heroId, arg_36_0.skillId)
	end

	return arg_36_0.skillLevel + (arg_36_0.tempAddLevel or 0)
end

function var_0_0.ChangeSkillDescState(arg_37_0, arg_37_1)
	if arg_37_1 then
		arg_37_0.descType_ = arg_37_1
	elseif arg_37_0.descType_ == var_0_2.NORMAL then
		arg_37_0.descType_ = var_0_2.DETAIL
		arg_37_0.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	else
		arg_37_0.descType_ = var_0_2.NORMAL
		arg_37_0.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	end

	arg_37_0:UpdateSkillDescShow()
end

function var_0_0.UpdateSkillDescShow(arg_38_0)
	local var_38_0 = ""

	if arg_38_0.descType_ == var_0_2.NORMAL then
		var_38_0 = HeroSkillCfg[arg_38_0.realSkillId].simpleDesc
	else
		local var_38_1 = SkillTools.GetIsDodgeSkill(arg_38_0.skillId)

		var_38_0 = arg_38_0.heroViewDataProxy:GetSkillDesc(arg_38_0.realSkillId, arg_38_0.level + arg_38_0.addSkillLv + arg_38_0.addEquipSkillLv, var_38_1)
	end

	arg_38_0.describetextText_.text = string.format("%s%s", var_38_0, "\n")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_0.describetextText_.transform)
end

function var_0_0.Dispose(arg_39_0)
	if arg_39_0.talkCDTimer_ then
		arg_39_0.talkCDTimer_:Stop()

		arg_39_0.talkCDTimer_ = nil
	end

	for iter_39_0, iter_39_1 in pairs(arg_39_0.costItem or {}) do
		if iter_39_1 then
			iter_39_1:Dispose()
		end
	end

	for iter_39_2, iter_39_3 in pairs(arg_39_0.skillAttributeItemList_ or {}) do
		if iter_39_3 then
			iter_39_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_39_0)
end

return var_0_0
