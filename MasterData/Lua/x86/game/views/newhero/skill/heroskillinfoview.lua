local HeroSkillInfoView = class("HeroSkillInfoView", HeroPageBase)
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

function HeroSkillInfoView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.skillAdditionType = self.handler_.skillAdditionType

	self:Init()
end

function HeroSkillInfoView:Init()
	self:BindCfgUI()
	self:AddUIListener()
	self:CreateCostList()
	self:InitSkillAddition()

	self.upStateController_ = self.infoControllerexcollection_:GetController(var_0_1.infoShowEx.upState.name)
	self.skillAttributeItemList_ = {}
	self.describeCanvas = self.describeTrs_:GetComponent(typeof(Canvas))
end

function HeroSkillInfoView:CreateCostList()
	self.costItem = {}

	for iter_3_0 = 1, 2 do
		self.costItem[iter_3_0] = CommonItemView.New(self["costitem" .. iter_3_0 .. "Go_"])
	end
end

function HeroSkillInfoView:RefreshCost()
	self.costCfg = SkillCfg[self.level]["skill_cost" .. SkillTools.GetSkillIdIndex(self.skillId)]
	self.costEnough = true

	for iter_4_0 = 1, 2 do
		if self.costCfg and self.costCfg[iter_4_0] then
			self.costItem[iter_4_0].gameObject_:SetActive(true)

			local var_4_0 = ItemTools.getItemNum(self.costCfg[iter_4_0][1])

			if self.tempAddLevel and self.tempAddLevel > 0 then
				var_4_0 = var_4_0 - SkillTools.GetSkillUpCostNum(self.skillId, self.skillLevel, self.tempAddLevel)[self.costCfg[iter_4_0][1]]
			end

			if var_4_0 < self.costCfg[iter_4_0][2] then
				self.costEnough = false
			end

			local var_4_1 = clone(ItemTemplateData)

			var_4_1.id = self.costCfg[iter_4_0][1]

			function var_4_1:clickFun()
				ShowPopItem(POP_SOURCE_ITEM, {
					self.id,
					self.number
				})
			end

			self.costItem[iter_4_0]:SetData(var_4_1)
			self.costItem[iter_4_0]:RefreshBottomText({
				var_4_0,
				self.costCfg[iter_4_0][2]
			})
			self.costItem[iter_4_0]:RefreshBottomRightText(true)
		else
			self.costItem[iter_4_0].gameObject_:SetActive(false)
		end
	end
end

function HeroSkillInfoView:SetDescribeCanvasSort(arg_6_1)
	self.describeCanvas.overrideSorting = arg_6_1
end

function HeroSkillInfoView:OpenAddTipsView(arg_7_1, arg_7_2)
	self:SetDescribeCanvasSort(true)

	if not gameContext:IsOpenRoute("skillAddTip") then
		JumpTools.OpenPageByJump("skillAddTip", {
			heroId = self.heroId,
			showType = arg_7_1,
			showTextList = arg_7_2,
			dataType = self.heroViewDataProxy:GetViewDataType(),
			backBtnCallback = function()
				self:SetDescribeCanvasSort(false)
				self:ClearSkillAddSelect()
			end
		})
	else
		manager.notify:CallUpdateFunc(HERO_SKILL_ADD_VIEW_UPDATE, {
			heroId = self.heroId,
			showType = arg_7_1,
			showTextList = arg_7_2
		})
	end
end

function HeroSkillInfoView:GetAdditionValue(arg_9_1)
	local var_9_0, var_9_1 = self.heroViewDataProxy:GetAdditionShowTextByType(self.skillId, self.heroId, arg_9_1)

	return var_9_0, var_9_1
end

function HeroSkillInfoView:OnClickSkillAdditionItem(arg_10_1)
	self:ClearSkillAddSelect()
	self:OpenAddTipsView(arg_10_1, self.additionControDataList[arg_10_1].value)
	self.additionControDataList[arg_10_1].controller:SetSelectedState(var_0_1.additionEx.showState.select)

	self.selectAdditionIndex = arg_10_1
end

function HeroSkillInfoView:ClearSkillAddSelect()
	if self.selectAdditionIndex then
		self.additionControDataList[self.selectAdditionIndex].controller:SetSelectedState(var_0_1.additionEx.showState.normal)
	end

	self.selectAdditionIndex = nil
end

function HeroSkillInfoView:InitSkillAddition()
	self.additionControDataList = {}

	for iter_12_0 = 1, 4 do
		self.additionControDataList[iter_12_0] = {}
		self.additionControDataList[iter_12_0].controller = self["addition" .. iter_12_0 .. "Controllerexcollection_"]:GetController(var_0_1.additionEx.showState.name)
		self.additionControDataList[iter_12_0].value = nil
		self.additionControDataList[iter_12_0].obj = self["addition" .. iter_12_0 .. "Btn_"].gameObject

		self:AddBtnListener(self["addition" .. iter_12_0 .. "Btn_"], nil, function()
			OperationRecorder.RecordButtonTouch(var_0_3[iter_12_0])
			self:OnClickSkillAdditionItem(iter_12_0)
		end)
	end
end

function HeroSkillInfoView:SendSkillUpgrade()
	if self.tempAddLevel and self.tempAddLevel > 0 then
		HeroAction.HeroSkillUpgrade(self.heroId, self.skillId, self.tempAddLevel)
	end
end

function HeroSkillInfoView:isCanUpSkill()
	if SkillTools.GetIsDodgeSkill(self.skillId) or self.level == HeroConst.MAX_SKILL_LEVEL then
		self:SendSkillUpgrade()

		return false
	end

	if SkillCfg[self.level]["skill_limit" .. SkillTools.GetSkillIdIndex(self.skillId)] > self.heroViewDataProxy:GetHeroData(self.heroId).break_level then
		self:SendSkillUpgrade()

		return false
	end

	if not self.costEnough then
		self:SendSkillUpgrade()
		ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")

		return false
	end

	self.tempAddLevel = (self.tempAddLevel or 0) + 1

	self:tempRefreshUi()

	return true
end

function HeroSkillInfoView:SetTempRefreshCallback(arg_16_1)
	self.tempRefreshCallback = arg_16_1
end

function HeroSkillInfoView:tempRefreshUi()
	self:RefreshUi()

	local var_17_0 = self:GetSkillLv()

	if self.tempRefreshCallback then
		self.tempRefreshCallback(self.skillId, self.tempAddLevel, (SkillTools.GetSkillUpCostNum(self.skillId, self.skillLevel, self.tempAddLevel)))
	end
end

function HeroSkillInfoView:AddUIListener()
	self:AddPressingByTimeListener(self.upbtnBtn_.gameObject, 1.4, 0.2, 0.1, function()
		return self:isCanUpSkill()
	end, handler(self, self.SendSkillUpgrade))
	self:AddBtnListener(self.recommendBtn_, nil, function()
		self:ChangeSkillDescState()
	end)
	self:AddBtnListener(self.breakUpBtn_, nil, function()
		if self.upStateController_:GetSelectedState() == var_0_1.infoShowEx.upState.notUp then
			JumpTools.OpenPageByJump("/heroUpgrade", {
				heroId = self.heroId,
				proxy = self.heroViewDataProxy
			})
		end
	end)
	self:AddBtnListener(self.oneKeyUpBtn_, nil, function()
		self:OnOneKeyUpBtn()
	end)
	TerminologyTools.AddTerminologyHandler(self, self.describetextText_, nil, nil)
end

function HeroSkillInfoView:OnOneKeyUpBtn()
	if SkillTools.GetSkillMaxUpLv(self.skillId, self.skillLevel) == self.skillLevel then
		ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")
	else
		JumpTools.OpenPageByJump("skillUpTip", {
			isAttr = false,
			proxy = self.heroViewDataProxy,
			heroId = self.heroId,
			skillId = self.skillId
		})
	end
end

function HeroSkillInfoView:OnHeroSkillUpgrade(arg_24_1, arg_24_2)
	if isSuccess(arg_24_1.result) then
		ShowTips("SKILL_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", self.level))
		self:PlayHeroTalk(self.heroId)
	else
		ShowTips(arg_24_1.result)
	end

	self.skillLevel = nil
	self.tempAddLevel = 0

	self:RefreshUi()
end

function HeroSkillInfoView:PlayHeroTalk(arg_25_1)
	if self.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(arg_25_1, "skillup")

	self.isTalkCD_ = true
	self.talkCDTimer_ = Timer.New(function()
		self.isTalkCD_ = false
	end, HeroConst.SKILL_UPGRADE_VOICE_CD, 1)

	self.talkCDTimer_:Start()
end

function HeroSkillInfoView:UpdateSkillData(arg_27_1, arg_27_2)
	self.skillId = arg_27_1.id
	self.heroId = arg_27_1.heroId
	self.realSkillId = self.heroViewDataProxy:GetRealSkillId(arg_27_1.heroId, arg_27_1.id)
	self.addSkillLv = arg_27_1.addSkillLv
	self.addEquipSkillLv = arg_27_1.addEquipSkillLv or 0
	self.tempAddLevel = 0
	self.skillLevel = 0

	self:RefreshUi()
	self:RefreshAddition()

	if arg_27_2 then
		self.rootAnimator_:Play("Fx_Common_right_cx", -1, 0)
	end
end

function HeroSkillInfoView:RefreshUi()
	local var_28_0 = HeroSkillCfg[self.realSkillId]

	self.skillnameText_.text = HeroSkillCfg[self.realSkillId].name
	self.subnameText_.text = HeroCfg[self.heroId].skill_subhead[SkillTools.GetSkillIdIndex(self.skillId)]
	self.level = self:GetSkillLv()
	self.lvText_.text = (self.addEquipSkillLv > 0 or self.addSkillLv > 0) and string.format("%d <color=#E78300>+ %d</color>", self.level, self.addEquipSkillLv + self.addSkillLv) or string.format("%d", self.level)

	self:UpdateUpStateController()
	self:RefreshCost()
	self:UpdateElemShow(var_28_0)
	self:UpdateSkillDescShow()
end

function HeroSkillInfoView:OnEnter(arg_29_1)
	self.heroViewDataProxy = arg_29_1
	self.descType_ = var_0_2.NORMAL
	self.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")

	self:SetDescribeCanvasSort(false)
end

function HeroSkillInfoView:UpdateUpStateController()
	if not self.heroViewDataProxy:CheckIsSelf() or SkillTools.GetIsDodgeSkill(self.skillId) then
		self.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.none)

		return
	end

	if self:RefreshCondition() then
		self.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.notUp)
	elseif self.level >= HeroConst.MAX_SKILL_LEVEL then
		self.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.max)
	else
		self.upStateController_:SetSelectedState(var_0_1.infoShowEx.upState.up)
	end
end

function HeroSkillInfoView:UpdateElemShow(arg_31_1)
	self.cdvalueText_.text = arg_31_1.cd == 0 and " - " or arg_31_1.cd / 1000 .. "s"

	self.costGo_:SetActive(false)
	self.skilltypeGo_:SetActive(false)
	self:UpdateAttribute(arg_31_1)

	local var_31_0 = 2

	if arg_31_1.EnergyChange < 0 then
		self.costvalueText_.text = math.abs(arg_31_1.EnergyChange) .. " " .. GetTips("NOTE_ENERGYTYPE_" .. CharactorParamCfg[self.heroId].EnergyType)

		self.costGo_:SetActive(true)

		var_31_0 = var_31_0 + 1
	end

	local var_31_1 = PublicSkillCfg[self.skillId].skill_sub_type

	if PublicSkillCfg[self.skillId].skill_sub_type == nil then
		var_31_1 = 0
	end

	if var_31_1 ~= 0 then
		self.skilltypevalueText_.text = GetI18NText(SkillSubTypeCfg[SkillSubTypeCfg.get_id_list_by_value[var_31_1][1]].annotation)

		self.skilltypeGo_:SetActive(true)

		var_31_0 = var_31_0 + 1
	end

	local var_31_2 = -187

	if var_31_0 == 3 then
		var_31_2 = -237
	elseif var_31_0 == 4 then
		var_31_2 = -287
	end

	self.descviewTrs_.sizeDelta = Vector2(self.descviewTrs_.sizeDelta.x, self.infonodeTrs_.rect.height + var_31_2)
end

function HeroSkillInfoView:UpdateAttribute(arg_32_1)
	local var_32_0 = arg_32_1.element_type

	if type(arg_32_1.element_type) ~= "table" then
		var_32_0 = {}
	end

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_1 = self.skillAttributeItemList_[iter_32_0]

		if not self.skillAttributeItemList_[iter_32_0] then
			var_32_1 = HeroSkillAttributeItem.New((GameObject.Instantiate(self.skillAttributeItemGo_, self.skillAttributePanelTrans_)))
			self.skillAttributeItemList_[iter_32_0] = var_32_1
		end

		var_32_1:SetData(iter_32_1)
		var_32_1:Show(true)
	end

	for iter_32_2 = #var_32_0 + 1, #self.skillAttributeItemList_ do
		self.skillAttributeItemList_[iter_32_2]:Show(false)
	end
end

function HeroSkillInfoView:RefreshAddition()
	for iter_33_0 = 1, 4 do
		local var_33_0 = self:UpdateTargetCondition(iter_33_0)

		if var_33_0 then
			isShowNode = var_33_0
		end
	end
end

function HeroSkillInfoView:RefreshCondition()
	local var_34_0 = SkillCfg[self.level]["skill_limit" .. SkillTools.GetSkillIdIndex(self.skillId)]
	local var_34_1 = self.heroViewDataProxy:GetHeroData(self.heroId)
	local var_34_2 = false

	if self.level and var_34_0 and self.level < HeroConst.MAX_SKILL_LEVEL and var_34_0 > var_34_1.break_level then
		self.conditiondescireText_.text = string.format(GetTips("NOTE_SKILL_LIMIT"), var_34_0)
		self.conditionvalueText_.text = string.format("%s/%s", var_34_1.break_level, var_34_0)
		var_34_2 = true
	end

	return var_34_2
end

function HeroSkillInfoView:UpdateTargetCondition(arg_35_1)
	local var_35_0, var_35_1 = self:GetAdditionValue(arg_35_1)

	SetActive(self.additionControDataList[arg_35_1].obj, var_35_1)

	if var_35_0 then
		self.additionControDataList[arg_35_1].controller:SetSelectedState(var_0_1.additionEx.showState.normal)
	else
		self.additionControDataList[arg_35_1].controller:SetSelectedState(var_0_1.additionEx.showState.lock)
	end

	self.additionControDataList[arg_35_1].value = var_35_0

	return var_35_1
end

function HeroSkillInfoView:GetSkillLv()
	if not self.skillLevel or self.skillLevel == 0 then
		self.skillLevel = self.heroViewDataProxy:GetSkillLv(self.heroId, self.skillId)
	end

	return self.skillLevel + (self.tempAddLevel or 0)
end

function HeroSkillInfoView:ChangeSkillDescState(arg_37_1)
	if arg_37_1 then
		self.descType_ = arg_37_1
	elseif self.descType_ == var_0_2.NORMAL then
		self.descType_ = var_0_2.DETAIL
		self.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	else
		self.descType_ = var_0_2.NORMAL
		self.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	end

	self:UpdateSkillDescShow()
end

function HeroSkillInfoView:UpdateSkillDescShow()
	self.describetextText_.text = string.format("%s%s", self.descType_ == var_0_2.NORMAL and HeroSkillCfg[self.realSkillId].simpleDesc or self.heroViewDataProxy:GetSkillDesc(self.realSkillId, self.level + self.addSkillLv + self.addEquipSkillLv, (SkillTools.GetIsDodgeSkill(self.skillId))), "\n")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.describetextText_.transform)
end

function HeroSkillInfoView:Dispose()
	if self.talkCDTimer_ then
		self.talkCDTimer_:Stop()

		self.talkCDTimer_ = nil
	end

	for iter_39_0, iter_39_1 in pairs(self.costItem or {}) do
		if iter_39_1 then
			iter_39_1:Dispose()
		end
	end

	for iter_39_2, iter_39_3 in pairs(self.skillAttributeItemList_ or {}) do
		if iter_39_3 then
			iter_39_3:Dispose()
		end
	end

	HeroSkillInfoView.super.Dispose(self)
end

return HeroSkillInfoView
