local SummerPubPartnerDetailView = class("SummerPubPartnerDetailView", ReduxView)

DETAIL_PATH = "TextureConfig/Character/Icon/"
TOKEN_PATH = "TextureConfig/Activity_SummerPub/token/"
QPATH = "TextureConfig/BackHouseUI/RoleHead/"

function SummerPubPartnerDetailView:UIName()
	return "Widget/System/Activity_SummerPub/MainPub/Partner/Activity_SummerPub_PartnerDetailsPopUI"
end

function SummerPubPartnerDetailView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerPubPartnerDetailView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SummerPubPartnerDetailView:InitUI()
	self:BindCfgUI()

	self.sealController_ = self.controllerexcollection_:GetController("seal")
	self.paneldecController_ = self.controllerexcollection_:GetController("paneldec")
	self.hideHero2DController_ = self.controllerexcollection_:GetController("hideHero2D")
	self.hideNextBtnController_ = self.controllerexcollection_:GetController("hideNextBtn")
	self.hideCloseTipsController_ = self.controllerexcollection_:GetController("hideCloseTips")

	self.hideHero2DController_:SetSelectedState("true")
	self.hideCloseTipsController_:SetSelectedState("true")

	self.isMask_ = false
end

function SummerPubPartnerDetailView:AddUIListeners()
	self:AddBtnListener(self.btnLook_, nil, function()
		JumpTools.OpenPopUp("summerPubPartnerShowView", {
			id = self.id_
		})
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		local var_7_0 = SummerPubData:getFindPartner()
		local var_7_1 = table.indexof(var_7_0, self.id_)
		local var_7_2 = var_7_1 <= 1 and var_7_0[#var_7_0] or var_7_0[var_7_1 - 1]

		JumpTools.OpenPopUp("summerPubPartnerDetailView", {
			id = var_7_2
		})
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		local var_8_0 = SummerPubData:getFindPartner()
		local var_8_1 = table.indexof(var_8_0, self.id_)
		local var_8_2 = var_8_1 == #var_8_0 and var_8_0[1] or var_8_0[var_8_1 + 1]

		JumpTools.OpenPopUp("summerPubPartnerDetailView", {
			id = var_8_2
		})
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.isAnim then
			if self.isMask_ then
				self.isAnim = false
				self.playableTimeLine_.enabled = false

				JumpTools.OpenPageByJump("/summerPubEnterView")
			end
		else
			self:Back()
		end
	end)
end

function SummerPubPartnerDetailView:OnTop()
	self.hideNextBtnController_:SetSelectedState("false")
	self:RefreshUI()
end

function SummerPubPartnerDetailView:OnEnter()
	self.hideNextBtnController_:SetSelectedState("false")
	self:RefreshUI()
end

function SummerPubPartnerDetailView:RefreshUI()
	self.isAnim = self.params_.isAnim or false

	if self.isAnim then
		if self.isMask_ then
			self.playableTimeLine_.enabled = false
		else
			self.playableTimeLine_.enabled = true

			local var_12_0 = self.playableTimeLine_

			TimelineTools.PlayTimelineWithCallback(self.playableTimeLine_, self.playableTimeLine_.playableAsset, function()
				var_12_0.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Hold
				var_12_0.time = var_12_0.duration

				var_12_0:Evaluate()

				self.isMask_ = true

				self.hideCloseTipsController_:SetSelectedState("false")

				self.playableTimeLine_.enabled = false
			end)
		end

		self.hideNextBtnController_:SetSelectedState("true")

		self.closeText_.text = GetTips("CLICK_CONTINUE")
	else
		self.closeText_.text = GetTips("CLICK_CLOSE")

		self.hideCloseTipsController_:SetSelectedState("false")
	end

	self.id_ = self.params_.id

	local var_12_1 = SummerPubHeroCfg[self.id_]

	self.heroName_.text = GetI18NText(SummerPubHeroCfg[self.id_].hero_name)
	self.heroDesc_.text = GetI18NText(var_12_1.profile_desc)
	self.heroIcon_.sprite = pureGetSpriteWithoutAtlas(DETAIL_PATH .. var_12_1.profile_icon_head)
	self.heroHobby_.text = GetI18NText(var_12_1.food_id)

	if var_12_1.type == SummerPubConst.PARTNER_TYPE.SPECIAL then
		self.paneldecController_:SetSelectedState("content02")

		if SummerPubData:GetClearNumByStageID(SummerPubConst.LAST_LEVEL_ID, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
			SetActive(self.tokenImg_.gameObject, true)
		else
			SetActive(self.tokenImg_.gameObject, false)
		end
	else
		self.paneldecController_:SetSelectedState("content01")
		SetActive(self.tokenImg_.gameObject, true)

		self.attackNum_.text = var_12_1.base_attribute[1]
		self.hpNum_.text = var_12_1.base_attribute[2]
		self.speedNum_.text = var_12_1.base_attribute[3]

		if var_12_1.skill ~= 0 then
			self.skillDesc_.text = GetI18NText(SummerPubPinBallSkillCfg[var_12_1.skill].skill_desc)
		end
	end

	self.tokenImg_.sprite = pureGetSpriteWithoutAtlas(TOKEN_PATH .. var_12_1.id)
	self.tipsText_.text = GetI18NText(var_12_1.possession_name) .. "\n" .. GetI18NText(var_12_1.possession_desc)

	self.sealController_:SetSelectedState("on")
end

function SummerPubPartnerDetailView:OnExitInput()
	self:Back()

	return true
end

function SummerPubPartnerDetailView:OnExit()
	self.super.OnExit(self)
end

function SummerPubPartnerDetailView:Dispose()
	self.super.Dispose(self)
end

return SummerPubPartnerDetailView
