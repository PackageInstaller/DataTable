local MythicFinalTeamViewItem = class("MythicFinalTeamViewItem", ReduxView)

function MythicFinalTeamViewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function MythicFinalTeamViewItem:Init()
	self:InitUI()
	self:AddListeners()
end

function MythicFinalTeamViewItem:InitUI()
	self:BindCfgUI()

	self.teamSwapController_ = ControllerUtil.GetController(self.transform_, "place")
	self.teamChangeController_ = ControllerUtil.GetController(self.transform_, "change")
	self.godUpController_ = ControllerUtil.GetController(self.godupBtn_.transform, "name")
	self.aoyiController_ = ControllerUtil.GetController(self.aoyiBtn_.transform, "name")
	self.heroHead_ = {}
	self.heroHeadCon_ = {}

	for iter_3_0 = 1, 3 do
		self.heroHead_[iter_3_0] = TeamHeroShortHead.New(self["newherohead" .. iter_3_0 .. "Btn_"].gameObject)

		self.heroHead_[iter_3_0]:SetProxy(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT))
		self.heroHead_[iter_3_0]:SetRedPointEnable(false)

		self.heroHeadCon_[iter_3_0] = ControllerUtil.GetController(self["newherohead" .. iter_3_0 .. "Btn_"].transform, "switch")
	end

	self.chipPanelController_ = self.chipPanelConEx_:GetController("chipPanel")
	self.riseController_ = self.charChipConEx_:GetController("rise")
end

function MythicFinalTeamViewItem:AddListeners()
	self:AddBtnListener(self.chipbtnBtn_, nil, function()
		if not MythicData:GetIsBattleIng() then
			self:Go("/mythicSectionSelectHero", {
				section = self.stageID_,
				sectionType = self.stageType_,
				activityID = self.activityID_,
				reserveParams = self.cachedReserveParams_,
				stageType = self.stageType_,
				stageID = self.stageID_,
				teamLength = self.teamLength_,
				teamID = self.teamID_
			})
		end
	end)

	for iter_4_0 = 1, 3 do
		self:AddBtnListener(self["newherohead" .. iter_4_0 .. "Btn_"], nil, function()
			if not MythicData:GetIsBattleIng() then
				self:Go("/mythicSectionSelectHero", {
					section = self.stageID_,
					sectionType = self.stageType_,
					activityID = self.activityID_,
					reserveParams = self.cachedReserveParams_,
					stageType = self.stageType_,
					stageID = self.stageID_,
					teamLength = self.teamLength_,
					teamID = self.teamID_
				})
			end
		end)
	end

	self:AddBtnListener(self.godupBtn_, nil, function()
		local var_7_0, var_7_1, var_7_2 = BattleTools.GetMaxRaceData(self.heroList_)

		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = var_7_0,
			sameCamp = var_7_2
		})
	end)
	self:AddBtnListener(self.aoyiBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionComboSelect", {
			stageType = self.stageType_,
			stageID = self.stageID_,
			heroList = self.heroList_,
			trialList = {
				0,
				0,
				0
			},
			comboSkillID = self.comboSkillID_,
			targetSectionProxy = self.sectionProxy_
		})
	end)
	self:AddBtnListener(self.changebtn_, nil, function()
		if not MythicData:GetIsBattleIng() and self.changefunc_ then
			self.changefunc_(self.teamID_)
		end
	end)
	self:AddBtnListener(self.confirmbtn_, nil, function()
		if not MythicData:GetIsBattleIng() and self.confirmfunc_ then
			self.confirmfunc_(self.teamID_)
		end
	end)
end

function MythicFinalTeamViewItem:RefreshUI(arg_11_1, arg_11_2, arg_11_3)
	self.teamLength_ = arg_11_3
	self.teamID_ = arg_11_1
	self.stageID_ = arg_11_2
	self.stageType_ = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
	self.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, self.teamID_, {
		stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
		stageID = arg_11_2
	})
	self.cachedReserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL_CACHE, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, self.teamID_, {
		stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
		stageID = arg_11_2
	})

	if not self.sectionProxy_ then
		self.sectionProxy_ = SectionSelectHeroTools.GetProxy({
			stageType = self.stageType_,
			stageID = self.stageID_
		}, self.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	else
		self.sectionProxy_:Init({
			stageType = self.stageType_,
			stageID = self.stageID_
		}, self.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	self.heroList_, _, _, self.heroTrialList_ = ReserveTools.GetHeroList(self.reserveParams_)

	local var_11_0, var_11_1 = ReserveTools.GetMimirData(self.reserveParams_)

	self.comboSkillID_ = ReserveTools.GetComboSkillID(self.reserveParams_)

	local var_11_2 = ReserveTools.GetCharChipBaseID(self.reserveParams_)

	ReserveTools.SetTeam(self.cachedReserveParams_, self.heroList_, self.heroTrialList_ or {}, self.comboSkillID_, var_11_0, var_11_1, var_11_2)

	local var_11_3 = self:GetRaceEffect()

	for iter_11_0 = 1, 3 do
		if self.heroList_[iter_11_0] ~= 0 then
			self.heroHead_[iter_11_0]:SetHeroId(self.heroList_[iter_11_0])
			self.heroHeadCon_[iter_11_0]:SetSelectedState("1")
		else
			self.heroHeadCon_[iter_11_0]:SetSelectedState("0")
		end
	end

	if var_11_0 ~= 0 then
		self.chipPanelController_:SetSelectedState("ManageMeowChips")
	elseif var_11_2 ~= 0 then
		self.chipPanelController_:SetSelectedState("CorrectorChip")
	else
		self.chipPanelController_:SetSelectedState("EmptyChips")
	end

	if var_11_0 == 0 then
		SetActive(self.subchip1Img_.gameObject, false)
		SetActive(self.subchip2Img_.gameObject, false)
	else
		self.chipiconImg_.sprite = ChipTools.GetChipManagerIcon(var_11_0)

		for iter_11_1 = 1, 2 do
			if var_11_1[iter_11_1] then
				SetActive(self["subchip" .. iter_11_1 .. "Img_"].gameObject, true)

				self["subchip" .. iter_11_1 .. "Img_"].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_11_1[iter_11_1]].picture_id)
			else
				SetActive(self["subchip" .. iter_11_1 .. "Img_"].gameObject, false)
			end
		end
	end

	if var_11_2 ~= 0 then
		self.charChipImg_.sprite = ChipTools.GetCharChipIcon(var_11_2, true)

		self.riseController_:SetSelectedState(tostring(#ReserveTools.GetCharChipExtraIDList(self.reserveParams_) + 1))
	end

	self.godUpController_:SetSelectedState(var_11_3 == 0 and "off" or "on")
	self.aoyiController_:SetSelectedState(self.comboSkillID_ == 0 and "off" or "on")

	self.bianduiText_.text = GetTips("TEAM_" .. arg_11_1)

	if MythicData:GetIsBattleIng() then
		self.teamChangeController_:SetSelectedState("false")
	else
		self.teamChangeController_:SetSelectedState("true")
	end
end

function MythicFinalTeamViewItem:GetRaceEffect()
	local var_12_0 = {}
	local var_12_1 = 0
	local var_12_2 = false

	for iter_12_0, iter_12_1 in pairs((ReserveTools.GetHeroList(self.reserveParams_))) do
		if iter_12_1 ~= 0 then
			var_12_0[HeroCfg[iter_12_1].race] = (var_12_0[HeroCfg[iter_12_1].race] or 0) + 1

			if var_12_0[HeroCfg[iter_12_1].race] == 2 then
				var_12_1 = HeroCfg[iter_12_1].race
			elseif var_12_0[HeroCfg[iter_12_1].race] == 3 then
				var_12_2 = true
			end
		end
	end

	return var_12_1, var_12_2, var_12_0[var_12_1] or 1
end

function MythicFinalTeamViewItem:OnChangeRefreshStatus(arg_13_1)
	if arg_13_1 == self.teamID_ then
		self.teamSwapController_:SetSelectedState("select")
	else
		self.teamSwapController_:SetSelectedState("change")
	end
end

function MythicFinalTeamViewItem:ResetState()
	self.teamSwapController_:SetSelectedState("off")
end

function MythicFinalTeamViewItem:RegionHandler(arg_15_1, arg_15_2)
	self.changefunc_ = arg_15_1
	self.confirmfunc_ = arg_15_2
end

function MythicFinalTeamViewItem:Dispose()
	for iter_16_0 = 1, 3 do
		self.heroHead_[iter_16_0]:Dispose()
	end

	self.changefunc_ = nil
	self.confirmfunc_ = nil

	MythicFinalTeamViewItem.super.Dispose(self)
end

return MythicFinalTeamViewItem
