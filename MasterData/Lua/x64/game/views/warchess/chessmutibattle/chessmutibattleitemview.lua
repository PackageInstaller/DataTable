local ChessMutiBattleItemView = class("ChessMutiBattleItemView", ReduxView)

function ChessMutiBattleItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ChessMutiBattleItemView:Init()
	self:InitUI()
	self:AddListeners()
end

function ChessMutiBattleItemView:InitUI()
	self:BindCfgUI()

	self.changefunc_ = nil
	self.confirmfunc_ = nil
	self.changeController_ = ControllerUtil.GetController(self.transform_, "place")
	self.typeController_ = ControllerUtil.GetController(self.transform_, "name")
	self.godUpController_ = ControllerUtil.GetController(self.godupBtn_.transform, "name")
	self.aoyiController_ = ControllerUtil.GetController(self.aoyiBtn_.transform, "name")
	self.heroHead_ = {}
	self.heroHeadCon_ = {}

	for iter_3_0 = 1, 3 do
		self.heroHead_[iter_3_0] = TeamHeroShortHead.New(self["newherohead" .. iter_3_0 .. "Btn_"].gameObject)
		self.heroHeadCon_[iter_3_0] = ControllerUtil.GetController(self["newherohead" .. iter_3_0 .. "Btn_"].transform, "switch")
	end

	self.chipPanelController_ = self.chipPanelConEx_:GetController("chipPanel")
	self.riseController_ = self.charChipConEx_:GetController("rise")
end

function ChessMutiBattleItemView:AddListeners()
	self:AddBtnListener(self.chipbtnBtn_, nil, function()
		self:Go("/adminSelectChip", {
			isMimir = true,
			isFroming = true,
			selectID = self.sectionProxy_:GetMimirID(),
			stageType = self.stageType_,
			stageID = self.stageID_,
			sectionProxy = self.sectionProxy_
		})
	end)

	for iter_4_0 = 1, 3 do
		self:AddBtnListener(self["newherohead" .. iter_4_0 .. "Btn_"], nil, function()
			self:Go("/heroTeamInfoChessView", {
				isEnter = false,
				selectHeroPos = iter_4_0,
				stageID = self.stageID_,
				activityID = self.activityID_,
				stageType = self.stageType_,
				reserveParams = self.reserveParams_,
				teamLength = self.teamLength_,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
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
		if self.changefunc_ then
			self.changefunc_(self.teamID_)
		end
	end)
	self:AddBtnListener(self.confirmbtn_, nil, function()
		if self.confirmfunc_ then
			self.confirmfunc_(self.teamID_)
		end
	end)
end

function ChessMutiBattleItemView:RefreshUI(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self.teamLength_ = arg_11_5
	self.teamID_ = arg_11_1
	self.stageID_ = arg_11_2
	self.activityID_ = arg_11_4
	self.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
	self.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.MULTI_CHESS, arg_11_4, self.teamID_, {
		stageType = self.stageType_,
		stageID = self.stageID_
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

	self.heroList_ = ReserveTools.GetHeroList(self.reserveParams_)

	local var_11_0, var_11_1 = ReserveTools.GetMimirData(self.reserveParams_)

	self.comboSkillID_ = ReserveTools.GetComboSkillID(self.reserveParams_)

	local var_11_2 = ReserveTools.GetCharChipBaseID(self.reserveParams_)
	local var_11_3 = self:GetRaceEffect()

	for iter_11_0 = 1, 3 do
		if self.heroList_[iter_11_0] ~= 0 then
			self.heroHead_[iter_11_0]:SetProxy(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT))
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

	self.typeController_:SetSelectedState(arg_11_3 or 2)
end

function ChessMutiBattleItemView:GetRaceEffect()
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

function ChessMutiBattleItemView:OnChangeRefreshStatus(arg_13_1)
	if arg_13_1 == self.teamID_ then
		self.changeController_:SetSelectedState("select")
	else
		self.changeController_:SetSelectedState("change")
	end
end

function ChessMutiBattleItemView:ResetState()
	self.changeController_:SetSelectedState("off")
end

function ChessMutiBattleItemView:RegionHandler(arg_15_1, arg_15_2)
	self.changefunc_ = arg_15_1
	self.confirmfunc_ = arg_15_2
end

function ChessMutiBattleItemView:Dispose()
	for iter_16_0 = 1, 3 do
		self.heroHead_[iter_16_0]:Dispose()
	end

	self.changefunc_ = nil
	self.confirmfunc_ = nil

	ChessMutiBattleItemView.super.Dispose(self)
end

return ChessMutiBattleItemView
