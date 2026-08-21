local var_0_0 = class("ChessMutiBattleItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.changefunc_ = nil
	arg_3_0.confirmfunc_ = nil
	arg_3_0.changeController_ = ControllerUtil.GetController(arg_3_0.transform_, "place")
	arg_3_0.typeController_ = ControllerUtil.GetController(arg_3_0.transform_, "name")
	arg_3_0.godUpController_ = ControllerUtil.GetController(arg_3_0.godupBtn_.transform, "name")
	arg_3_0.aoyiController_ = ControllerUtil.GetController(arg_3_0.aoyiBtn_.transform, "name")
	arg_3_0.heroHead_ = {}
	arg_3_0.heroHeadCon_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.heroHead_[iter_3_0] = TeamHeroShortHead.New(arg_3_0["newherohead" .. iter_3_0 .. "Btn_"].gameObject)
		arg_3_0.heroHeadCon_[iter_3_0] = ControllerUtil.GetController(arg_3_0["newherohead" .. iter_3_0 .. "Btn_"].transform, "switch")
	end

	arg_3_0.chipPanelController_ = arg_3_0.chipPanelConEx_:GetController("chipPanel")
	arg_3_0.riseController_ = arg_3_0.charChipConEx_:GetController("rise")
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.chipbtnBtn_, nil, function()
		arg_4_0:Go("/adminSelectChip", {
			isMimir = true,
			isFroming = true,
			selectID = arg_4_0.sectionProxy_:GetMimirID(),
			stageType = arg_4_0.stageType_,
			stageID = arg_4_0.stageID_,
			sectionProxy = arg_4_0.sectionProxy_
		})
	end)

	for iter_4_0 = 1, 3 do
		arg_4_0:AddBtnListener(arg_4_0["newherohead" .. iter_4_0 .. "Btn_"], nil, function()
			arg_4_0:Go("/heroTeamInfoChessView", {
				isEnter = false,
				selectHeroPos = iter_4_0,
				stageID = arg_4_0.stageID_,
				activityID = arg_4_0.activityID_,
				stageType = arg_4_0.stageType_,
				reserveParams = arg_4_0.reserveParams_,
				teamLength = arg_4_0.teamLength_,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT
			})
		end)
	end

	arg_4_0:AddBtnListener(arg_4_0.godupBtn_, nil, function()
		local var_7_0, var_7_1, var_7_2 = BattleTools.GetMaxRaceData(arg_4_0.heroList_)

		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = var_7_0,
			sameCamp = var_7_2
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.aoyiBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionComboSelect", {
			stageType = arg_4_0.stageType_,
			stageID = arg_4_0.stageID_,
			heroList = arg_4_0.heroList_,
			trialList = {
				0,
				0,
				0
			},
			comboSkillID = arg_4_0.comboSkillID_,
			targetSectionProxy = arg_4_0.sectionProxy_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.changebtn_, nil, function()
		if arg_4_0.changefunc_ then
			arg_4_0.changefunc_(arg_4_0.teamID_)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.confirmbtn_, nil, function()
		if arg_4_0.confirmfunc_ then
			arg_4_0.confirmfunc_(arg_4_0.teamID_)
		end
	end)
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.teamLength_ = arg_11_5
	arg_11_0.teamID_ = arg_11_1
	arg_11_0.stageID_ = arg_11_2
	arg_11_0.activityID_ = arg_11_4
	arg_11_0.stageType_ = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
	arg_11_0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.MULTI_CHESS, arg_11_4, arg_11_0.teamID_, {
		stageType = arg_11_0.stageType_,
		stageID = arg_11_0.stageID_
	})

	if not arg_11_0.sectionProxy_ then
		arg_11_0.sectionProxy_ = SectionSelectHeroTools.GetProxy({
			stageType = arg_11_0.stageType_,
			stageID = arg_11_0.stageID_
		}, arg_11_0.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	else
		arg_11_0.sectionProxy_:Init({
			stageType = arg_11_0.stageType_,
			stageID = arg_11_0.stageID_
		}, arg_11_0.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	arg_11_0.heroList_ = ReserveTools.GetHeroList(arg_11_0.reserveParams_)

	local var_11_0, var_11_1 = ReserveTools.GetMimirData(arg_11_0.reserveParams_)

	arg_11_0.comboSkillID_ = ReserveTools.GetComboSkillID(arg_11_0.reserveParams_)

	local var_11_2 = ReserveTools.GetCharChipBaseID(arg_11_0.reserveParams_)
	local var_11_3 = arg_11_0:GetRaceEffect()

	for iter_11_0 = 1, 3 do
		if arg_11_0.heroList_[iter_11_0] ~= 0 then
			arg_11_0.heroHead_[iter_11_0]:SetProxy(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT))
			arg_11_0.heroHead_[iter_11_0]:SetHeroId(arg_11_0.heroList_[iter_11_0])
			arg_11_0.heroHeadCon_[iter_11_0]:SetSelectedState("1")
		else
			arg_11_0.heroHeadCon_[iter_11_0]:SetSelectedState("0")
		end
	end

	if var_11_0 ~= 0 then
		arg_11_0.chipPanelController_:SetSelectedState("ManageMeowChips")
	elseif var_11_2 ~= 0 then
		arg_11_0.chipPanelController_:SetSelectedState("CorrectorChip")
	else
		arg_11_0.chipPanelController_:SetSelectedState("EmptyChips")
	end

	if var_11_0 == 0 then
		SetActive(arg_11_0.subchip1Img_.gameObject, false)
		SetActive(arg_11_0.subchip2Img_.gameObject, false)
	else
		local var_11_4 = ChipCfg[var_11_0]

		arg_11_0.chipiconImg_.sprite = ChipTools.GetChipManagerIcon(var_11_0)

		for iter_11_1 = 1, 2 do
			if var_11_1[iter_11_1] then
				SetActive(arg_11_0["subchip" .. iter_11_1 .. "Img_"].gameObject, true)

				local var_11_5 = var_11_1[iter_11_1]

				arg_11_0["subchip" .. iter_11_1 .. "Img_"].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[var_11_5].picture_id)
			else
				SetActive(arg_11_0["subchip" .. iter_11_1 .. "Img_"].gameObject, false)
			end
		end
	end

	if var_11_2 ~= 0 then
		local var_11_6 = ReserveTools.GetCharChipExtraIDList(arg_11_0.reserveParams_)

		arg_11_0.charChipImg_.sprite = ChipTools.GetCharChipIcon(var_11_2, true)

		arg_11_0.riseController_:SetSelectedState(tostring(#var_11_6 + 1))
	end

	arg_11_0.godUpController_:SetSelectedState(var_11_3 == 0 and "off" or "on")
	arg_11_0.aoyiController_:SetSelectedState(arg_11_0.comboSkillID_ == 0 and "off" or "on")

	arg_11_0.bianduiText_.text = GetTips("TEAM_" .. arg_11_1)

	arg_11_0.typeController_:SetSelectedState(arg_11_3 or 2)
end

function var_0_0.GetRaceEffect(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = 0
	local var_12_2 = false
	local var_12_3 = ReserveTools.GetHeroList(arg_12_0.reserveParams_)

	for iter_12_0, iter_12_1 in pairs(var_12_3) do
		if iter_12_1 ~= 0 then
			local var_12_4 = HeroCfg[iter_12_1].race

			var_12_0[var_12_4] = (var_12_0[var_12_4] or 0) + 1

			if var_12_0[var_12_4] == 2 then
				var_12_1 = var_12_4
			elseif var_12_0[var_12_4] == 3 then
				var_12_2 = true
			end
		end
	end

	return var_12_1, var_12_2, var_12_0[var_12_1] or 1
end

function var_0_0.OnChangeRefreshStatus(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0.teamID_ then
		arg_13_0.changeController_:SetSelectedState("select")
	else
		arg_13_0.changeController_:SetSelectedState("change")
	end
end

function var_0_0.ResetState(arg_14_0)
	arg_14_0.changeController_:SetSelectedState("off")
end

function var_0_0.RegionHandler(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.changefunc_ = arg_15_1
	arg_15_0.confirmfunc_ = arg_15_2
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0 = 1, 3 do
		arg_16_0.heroHead_[iter_16_0]:Dispose()
	end

	arg_16_0.changefunc_ = nil
	arg_16_0.confirmfunc_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
