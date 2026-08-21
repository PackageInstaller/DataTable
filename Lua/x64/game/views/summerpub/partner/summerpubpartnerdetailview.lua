local var_0_0 = class("SummerPubPartnerDetailView", ReduxView)

DETAIL_PATH = "TextureConfig/Character/Icon/"
TOKEN_PATH = "TextureConfig/Activity_SummerPub/token/"
QPATH = "TextureConfig/BackHouseUI/RoleHead/"

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Partner/Activity_SummerPub_PartnerDetailsPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.sealController_ = arg_4_0.controllerexcollection_:GetController("seal")
	arg_4_0.paneldecController_ = arg_4_0.controllerexcollection_:GetController("paneldec")
	arg_4_0.hideHero2DController_ = arg_4_0.controllerexcollection_:GetController("hideHero2D")
	arg_4_0.hideNextBtnController_ = arg_4_0.controllerexcollection_:GetController("hideNextBtn")
	arg_4_0.hideCloseTipsController_ = arg_4_0.controllerexcollection_:GetController("hideCloseTips")

	arg_4_0.hideHero2DController_:SetSelectedState("true")
	arg_4_0.hideCloseTipsController_:SetSelectedState("true")

	arg_4_0.isMask_ = false
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnLook_, nil, function()
		JumpTools.OpenPopUp("summerPubPartnerShowView", {
			id = arg_5_0.id_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.leftBtn_, nil, function()
		local var_7_0 = SummerPubData:getFindPartner()
		local var_7_1 = table.indexof(var_7_0, arg_5_0.id_)
		local var_7_2

		if var_7_1 <= 1 then
			var_7_2 = var_7_0[#var_7_0]
		else
			var_7_2 = var_7_0[var_7_1 - 1]
		end

		JumpTools.OpenPopUp("summerPubPartnerDetailView", {
			id = var_7_2
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rightBtn_, nil, function()
		local var_8_0 = SummerPubData:getFindPartner()
		local var_8_1 = table.indexof(var_8_0, arg_5_0.id_)
		local var_8_2

		if var_8_1 == #var_8_0 then
			var_8_2 = var_8_0[1]
		else
			var_8_2 = var_8_0[var_8_1 + 1]
		end

		JumpTools.OpenPopUp("summerPubPartnerDetailView", {
			id = var_8_2
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		if arg_5_0.isAnim then
			if arg_5_0.isMask_ then
				arg_5_0.isAnim = false
				arg_5_0.playableTimeLine_.enabled = false

				JumpTools.OpenPageByJump("/summerPubEnterView")
			end
		else
			arg_5_0:Back()
		end
	end)
end

function var_0_0.OnTop(arg_10_0)
	arg_10_0.hideNextBtnController_:SetSelectedState("false")
	arg_10_0:RefreshUI()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.hideNextBtnController_:SetSelectedState("false")
	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.isAnim = arg_12_0.params_.isAnim or false

	if arg_12_0.isAnim then
		if arg_12_0.isMask_ then
			arg_12_0.playableTimeLine_.enabled = false
		else
			arg_12_0.playableTimeLine_.enabled = true

			local var_12_0 = arg_12_0.playableTimeLine_

			TimelineTools.PlayTimelineWithCallback(var_12_0, var_12_0.playableAsset, function()
				var_12_0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
				var_12_0.time = var_12_0.duration

				var_12_0:Evaluate()

				arg_12_0.isMask_ = true

				arg_12_0.hideCloseTipsController_:SetSelectedState("false")

				arg_12_0.playableTimeLine_.enabled = false
			end)
		end

		arg_12_0.hideNextBtnController_:SetSelectedState("true")

		arg_12_0.closeText_.text = GetTips("CLICK_CONTINUE")
	else
		arg_12_0.closeText_.text = GetTips("CLICK_CLOSE")

		arg_12_0.hideCloseTipsController_:SetSelectedState("false")
	end

	arg_12_0.id_ = arg_12_0.params_.id

	local var_12_1 = SummerPubHeroCfg[arg_12_0.id_]

	arg_12_0.heroName_.text = GetI18NText(var_12_1.hero_name)
	arg_12_0.heroDesc_.text = GetI18NText(var_12_1.profile_desc)
	arg_12_0.heroIcon_.sprite = pureGetSpriteWithoutAtlas(DETAIL_PATH .. var_12_1.profile_icon_head)
	arg_12_0.heroHobby_.text = GetI18NText(var_12_1.food_id)

	if var_12_1.type == SummerPubConst.PARTNER_TYPE.SPECIAL then
		arg_12_0.paneldecController_:SetSelectedState("content02")

		if SummerPubData:GetClearNumByStageID(SummerPubConst.LAST_LEVEL_ID, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
			SetActive(arg_12_0.tokenImg_.gameObject, true)
		else
			SetActive(arg_12_0.tokenImg_.gameObject, false)
		end
	else
		arg_12_0.paneldecController_:SetSelectedState("content01")
		SetActive(arg_12_0.tokenImg_.gameObject, true)

		local var_12_2 = var_12_1.base_attribute

		arg_12_0.attackNum_.text = var_12_2[1]
		arg_12_0.hpNum_.text = var_12_2[2]
		arg_12_0.speedNum_.text = var_12_2[3]

		local var_12_3 = var_12_1.skill

		if var_12_3 ~= 0 then
			local var_12_4 = SummerPubPinBallSkillCfg[var_12_3]

			arg_12_0.skillDesc_.text = GetI18NText(var_12_4.skill_desc)
		end
	end

	arg_12_0.tokenImg_.sprite = pureGetSpriteWithoutAtlas(TOKEN_PATH .. var_12_1.id)
	arg_12_0.tipsText_.text = GetI18NText(var_12_1.possession_name) .. "\n" .. GetI18NText(var_12_1.possession_desc)

	arg_12_0.sealController_:SetSelectedState("on")
end

function var_0_0.OnExitInput(arg_14_0)
	arg_14_0:Back()

	return true
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0.super.OnExit(arg_15_0)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.super.Dispose(arg_16_0)
end

return var_0_0
