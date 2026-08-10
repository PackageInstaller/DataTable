local var_0_0 = class("HeroEquipBagView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/HeroEquipSwitchUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.equipBag_ = EquipBagView.New(arg_5_0, arg_5_0.equipBagGo_, {
		suitPos = arg_5_0.params_.suitPos
	})

	arg_5_0.equipBag_:RegisterItemClick(handler(arg_5_0, arg_5_0.ClickBagItem))

	arg_5_0.equipInfoViewRight_ = EquipInfoView.New(arg_5_0.rightInfo_)
	arg_5_0.equipInfoViewMiddle_ = EquipInfoView.New(arg_5_0.middleInfo_)
	arg_5_0.middleTransAnchor_ = arg_5_0.equipInfoViewMiddle_.transform_.anchoredPosition

	arg_5_0.equipInfoViewRight_:RegisterSkillClick(handler(arg_5_0, arg_5_0.SkillClick), false)
	arg_5_0.equipInfoViewMiddle_:RegisterSkillClick(handler(arg_5_0, arg_5_0.SkillClick), true)
	arg_5_0.equipInfoViewRight_:RegisterChange(function(arg_6_0)
		arg_5_0.equipInfoViewMiddle_:ChangeSelect(arg_6_0)

		arg_5_0.rightInfoType = arg_6_0
	end)
	arg_5_0.equipInfoViewMiddle_:RegisterChange(function(arg_7_0)
		if arg_7_0 == "suit" and arg_5_0.popController_:GetSelectedState() ~= "onlyEquip" then
			arg_5_0.popController_:SetSelectedState("onlyEquip")
		end

		arg_5_0.equipInfoViewRight_:ChangeSelect(arg_7_0)

		arg_5_0.rightInfoType = arg_7_0
	end)

	arg_5_0.equipSkillView_ = EquipNewSkillInfoView.New(arg_5_0.skillInfo_)
	arg_5_0.popController_ = arg_5_0.popCon_:GetController("popState")
	arg_5_0.rightEmptyController_ = arg_5_0.rightCon_:GetController("empty")

	arg_5_0:InitEquipDiscNextFrame()

	arg_5_0.leftPopTrans_ = arg_5_0.swapGo_.transform
	arg_5_0.rightRootTrans_ = arg_5_0.rightCon_.transform
end

function var_0_0.InitEquipDiscNextFrame(arg_8_0)
	local var_8_0

	var_8_0 = FrameTimer.New(function()
		var_8_0:Stop()

		arg_8_0.equipDiscGo_ = Object.Instantiate(Asset.Load("Widget/System/Hero_equip/EquipDisc"), arg_8_0.discParent_, false)
		arg_8_0.equipDiscGo_.transform.localScale = Vector3(1.2, 1.2, 1.2)
		arg_8_0.equipDisc_ = EquipDisc.New(arg_8_0.equipDiscGo_)

		arg_8_0.equipDisc_:OnEnter()
		arg_8_0.equipDisc_:Rotate(5, arg_8_0.selectPos_)
		arg_8_0.equipDisc_:RefreshItem(arg_8_0.equipDataList)
	end, 1, 1)

	var_8_0:Start()
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListenerScale(arg_10_0.btnUnloadAll_, nil, function()
		local var_11_0 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipUninstallEquipTip and var_11_0.uninstall_equip_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_ONE_CLICK_UNINSTALL_WARNING"),
				OkCallback = function()
					_G.SkipTip.SkipUninstallEquipTip = arg_10_0.SkipUninstallEquipTip

					HeroAction.EquipUnloadAll(arg_10_0.params_.heroId)
				end,
				ToggleCallback = function(arg_13_0)
					arg_10_0.SkipUninstallEquipTip = arg_13_0
				end
			})
		else
			HeroAction.EquipUnloadAll(arg_10_0.params_.heroId)
		end
	end)
	arg_10_0:AddBtnListenerScale(arg_10_0.btnScheme_, nil, function()
		arg_10_0:Go("/EquipProposal", {
			heroID = arg_10_0.params_.heroId,
			proxy = arg_10_0.params_.proxy
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.btnMask1_, nil, function()
		arg_10_0:HidePopView()
	end)
	arg_10_0:AddBtnListener(arg_10_0.btnDecompose_, nil, function()
		JumpTools.GoToSystem("/equipDecompose")
	end)
end

function var_0_0.CameraEnter(arg_17_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0,
		true
	})
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.equipList_ = {}
	arg_18_0.rightInfoType = "suit"
	arg_18_0.heroInfo_ = HeroData:GetHeroData(arg_18_0.params_.heroId)
	arg_18_0.heroViewDataProxy_ = arg_18_0.params_.proxy

	arg_18_0.equipInfoViewRight_:OnEnter(arg_18_0.heroViewDataProxy_)
	arg_18_0.equipInfoViewMiddle_:OnEnter(arg_18_0.heroViewDataProxy_)

	local var_18_0 = arg_18_0.selectPos_ or arg_18_0.params_.suitPos

	arg_18_0.selectPos_ = var_18_0

	if arg_18_0.equipDisc_ then
		arg_18_0.equipDisc_:OnEnter()

		if arg_18_0.params_.translationAnim then
			arg_18_0.equipDisc_:Rotate(arg_18_0.selectPos_, arg_18_0.selectPos_)
		else
			arg_18_0.equipDisc_:Rotate(5, arg_18_0.selectPos_)
		end
	end

	arg_18_0.lastPos_ = var_18_0

	arg_18_0.enterAnim_:Play("Fx_Equip_change", -1, 0)
	arg_18_0.enterAnim_:Update(0)
	arg_18_0.equipBag_:OnEnter({
		heroId = arg_18_0.params_.heroId,
		suitPos = arg_18_0.selectPos_
	})
	arg_18_0:RefreshHeroEquipS()
end

function var_0_0.OnTop(arg_19_0)
	arg_19_0:UpdateBar()

	if arg_19_0.params_.needRefresh then
		arg_19_0.equipBag_:RefreshData(arg_19_0, {
			heroId = arg_19_0.params_.heroId,
			suitPos = arg_19_0.params_.suitPos,
			suit = arg_19_0.params_.suit
		})
	end

	arg_19_0.params_.suit = nil
	arg_19_0.params_.needRefresh = nil
end

function var_0_0.RefreshHeroEquipS(arg_20_0, arg_20_1)
	arg_20_0.equipBag_:Render()

	local var_20_0 = arg_20_0.heroViewDataProxy_:GetEquipInfoList(arg_20_0.params_.heroId)

	arg_20_0.equipDataList = arg_20_0.heroViewDataProxy_:GetEquipDataList(arg_20_0.params_.heroId)

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		arg_20_0.equipList_[iter_20_1.pos] = iter_20_1.equip_id
	end

	arg_20_0:RefreshRightEquipInfo()

	if arg_20_0.equipDisc_ then
		if arg_20_1 and arg_20_1.isShow then
			arg_20_0.equipDisc_:ShowAnim(arg_20_1.pos)
		end

		arg_20_0.equipDisc_:RefreshItem(arg_20_0.equipDataList)
	end
end

function var_0_0.RefreshRightEquipInfo(arg_21_0)
	arg_21_0.equipId_ = arg_21_0.equipList_[arg_21_0.selectPos_]
	arg_21_0.equip_ = arg_21_0.equipId_ ~= 0 and EquipData:GetEquipData(arg_21_0.equipId_) or nil

	if arg_21_0.equip_ then
		arg_21_0.rightEmptyController_:SetSelectedState("notEmpty")

		local var_21_0 = HeroCfg[arg_21_0.params_.heroId].race

		arg_21_0.equipInfoViewRight_:RefreshData(arg_21_0, arg_21_0.equip_, handler(arg_21_0, arg_21_0.RefreshEquipLock), arg_21_0.params_.heroId, arg_21_0.equip_.equip_id)
		arg_21_0.equipInfoViewRight_:ShowRaceAdd(arg_21_0.equip_.race == var_21_0 or arg_21_0.equip_.race == arg_21_0.params_.heroId)
	else
		arg_21_0.rightEmptyController_:SetSelectedState("empty")
	end
end

function var_0_0.RefreshPos(arg_22_0, arg_22_1)
	arg_22_0:HidePopView()

	arg_22_0.lastPos_ = arg_22_0.selectPos_
	arg_22_0.selectPos_ = arg_22_1 or arg_22_0.selectPos_

	arg_22_0.equipDisc_:RotateServant(arg_22_0.lastPos_, arg_22_0.selectPos_)
	arg_22_0:RefreshRightEquipInfo()
end

function var_0_0.ClickBagItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1.equip_info
	local var_23_1 = EquipCfg[var_23_0.prefab_id].pos
	local var_23_2 = arg_23_0.heroInfo_.equip[var_23_1].equip_id
	local var_23_3 = HeroCfg[arg_23_0.params_.heroId].race

	arg_23_0.equipInfoViewMiddle_.transform_.anchoredPosition = Vector2.New(arg_23_0.middleTransAnchor_.x + arg_23_0.leftTrans_.anchoredPosition.x, arg_23_0.middleTransAnchor_.y)

	arg_23_0.equipInfoViewMiddle_:RefreshData(arg_23_0, var_23_0, handler(arg_23_0, arg_23_0.RefreshEquipLock), arg_23_0.params_.heroId, var_23_2)
	arg_23_0.equipInfoViewMiddle_:ShowRaceAdd(var_23_0.race == var_23_3 or var_23_0.race == arg_23_0.params_.heroId)

	arg_23_0.bagSelectItem_ = arg_23_2

	if arg_23_0.selectSkillItem_ then
		arg_23_0.selectSkillItem_:ShowSelect(false)
	end

	arg_23_0.popController_:SetSelectedState("onlyEquip")
end

function var_0_0.SkillClick(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0.equipSkillView_:RefreshData(arg_24_0, arg_24_2)

	arg_24_0.selectSkillItem_ = arg_24_1

	if arg_24_0.bagSelectItem_ then
		arg_24_0.bagSelectItem_:RefreshSelectState2(false)
	end

	local var_24_0 = arg_24_3 and 0 or -48 - arg_24_0.rightTrans_.anchoredPosition.x

	arg_24_0.skillInfo_.transform.anchorMin = arg_24_3 and Vector2.New(0, 0) or Vector2.New(1, 0)
	arg_24_0.skillInfo_.transform.anchorMax = arg_24_3 and Vector2.New(0, 1) or Vector2.New(1, 1)

	local var_24_1 = arg_24_3 and arg_24_0.leftPopTrans_ or arg_24_0.rightRootTrans_

	arg_24_0.skillInfo_.transform.pivot = var_24_1.pivot

	local var_24_2 = arg_24_3 and var_24_1.anchoredPosition.x + 576 or var_24_1.anchoredPosition.x - 550
	local var_24_3 = var_24_1.anchoredPosition.y

	arg_24_0.skillInfo_.transform.anchoredPosition = Vector3.New(var_24_2 - var_24_0, var_24_3, 0)

	arg_24_0.popController_:SetSelectedState(arg_24_3 and "equipAndSkill" or "onlySkill")
end

function var_0_0.RefreshEquipLock(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.equipBag_:RefreshEquipLock(arg_25_1, arg_25_2)
end

function var_0_0.OnEquipSwap(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.heroInfo_ = HeroData:GetHeroData(arg_26_0.params_.heroId)

	local var_26_0 = {
		pos = arg_26_2.pos,
		isShow = arg_26_2.equip_id ~= 0
	}

	if isSuccess(arg_26_1.result) then
		if arg_26_2.equip_id == 0 then
			ShowTips("EQUIP_UNBIND")
		else
			ShowTips("EQUIP_BIND")
		end

		arg_26_0.equipBag_:ClearSelect()
		arg_26_0:RefreshHeroEquipS(var_26_0)
		arg_26_0.popController_:SetSelectedState("hide")
	else
		ShowTips(arg_26_1.result)
	end
end

function var_0_0.OnEquipUnloadAll(arg_27_0, arg_27_1, arg_27_2)
	if isSuccess(arg_27_1.result) then
		ShowTips("EQUIP_UNBIND")
		arg_27_0:RefreshHeroEquipS()
	else
		ShowTips(arg_27_1.result)
	end
end

function var_0_0.KeepFilter(arg_28_0)
	arg_28_0.keepFilter_ = true
end

function var_0_0.HidePopView(arg_29_0)
	arg_29_0.equipBag_:ClearSelect()
	arg_29_0.popController_:SetSelectedState("hide")
	arg_29_0.equipInfoViewRight_:DeSelect()
	arg_29_0.equipInfoViewMiddle_:DeSelect()

	if arg_29_0.selectSkillItem_ then
		arg_29_0.selectSkillItem_:ShowSelect(false)

		arg_29_0.selectSkillItem_ = nil
	end

	if arg_29_0.bagSelectItem_ then
		arg_29_0.bagSelectItem_:RefreshSelectState2(false)

		arg_29_0.bagSelectItem_ = nil
	end
end

function var_0_0.UpdateBar(arg_30_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_EQUIP")
end

function var_0_0.OnExit(arg_31_0)
	manager.windowBar:HideBar()

	if not arg_31_0.keepFilter_ then
		arg_31_0.equipBag_:OnExit()
	else
		arg_31_0.keepFilter_ = false
	end

	arg_31_0.selectPos_ = nil
	arg_31_0.lastPos_ = nil

	arg_31_0:HidePopView()
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.equipBag_ then
		arg_32_0.equipBag_:Dispose()

		arg_32_0.equipBag_ = nil
	end

	if arg_32_0.equipInfoViewRight_ then
		arg_32_0.equipInfoViewRight_:Dispose()

		arg_32_0.equipInfoViewRight_ = nil
	end

	if arg_32_0.equipInfoViewMiddle_ then
		arg_32_0.equipInfoViewMiddle_:Dispose()

		arg_32_0.equipInfoViewMiddle_ = nil
	end

	if arg_32_0.equipSkillView_ then
		arg_32_0.equipSkillView_:Dispose()

		arg_32_0.equipSkillView_ = nil
	end

	if arg_32_0.equipDisc_ then
		arg_32_0.equipDisc_:Dispose()

		arg_32_0.equipDisc_ = nil
	end

	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
