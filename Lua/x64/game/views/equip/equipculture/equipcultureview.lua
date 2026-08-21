local var_0_0 = class("EquipCultureView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/EquipCultureUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.selectIndex_ = -1

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.group = {
		arg_4_0.btn_detail,
		arg_4_0.btn_levelup,
		arg_4_0.btn_upgrade,
		arg_4_0.btn_enchant,
		arg_4_0.btn_reset,
		arg_4_0.btn_inherit
	}
	arg_4_0.SetBarInSelfView = {
		nil,
		true,
		true,
		nil,
		true,
		true
	}
	arg_4_0.class_ = {
		EquipDetailView,
		EquipLevelUpView,
		EquipUpgradeView,
		EquipEnchantView,
		EquipResetView,
		EquipInheritView
	}
	arg_4_0.prefabPath_ = {
		"Widget/System/Hero_equip/Develop/EquipDetailUI",
		"Widget/System/Hero_equip/Develop/EquipLevelUpUI",
		"Widget/System/Hero_equip/Develop/EquipUpgradeUI",
		"Widget/System/Hero_equip/Develop/EquipEnchantUI",
		"Widget/System/Hero_equip/Develop/EquipResetUI",
		"Widget/System/Hero_equip/Develop/EquipInheritUI"
	}
	arg_4_0.equipTgl_ = {}
	arg_4_0.posIcon_ = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.equipTgl_[iter_4_0] = arg_4_0["equipBtn_" .. iter_4_0]
		arg_4_0.posIcon_[iter_4_0] = arg_4_0["posIcon_" .. iter_4_0]
	end

	arg_4_0.heroEquipController_ = arg_4_0.cultureCon_:GetController("equipped")
	arg_4_0.popController_ = arg_4_0.cultureCon_:GetController("pop")
	arg_4_0.equipPosController_ = arg_4_0.equipPos_:GetController("pos")
	arg_4_0.equipInfo_ = EquipInfoView.New(arg_4_0.equipInfoGo_)
	arg_4_0.skillInfo_ = EquipNewSkillInfoView.New(arg_4_0.skillInfoGo_)
	arg_4_0.equipDisc_ = EquipDisc.New(arg_4_0.discGo_)
	arg_4_0.pages_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0.sidebarCon_ = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0.group) do
		arg_5_0:AddBtnListener(iter_5_1, nil, function()
			arg_5_0:GoToTarget(iter_5_0)
		end)

		arg_5_0.sidebarCon_[iter_5_0] = iter_5_1.gameObject:GetComponent("ControllerExCollection"):GetController("btnController")
	end

	for iter_5_2 = 1, 6 do
		arg_5_0:AddBtnListener(arg_5_0.equipTgl_[iter_5_2], nil, function()
			if arg_5_0.equipList_[iter_5_2].equip_id ~= 0 and arg_5_0.index_ ~= iter_5_2 then
				manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")
				arg_5_0:RefreshDisc(iter_5_2)
				arg_5_0:RefreshPosBtn(iter_5_2)
				arg_5_0:RefreshSideBar(arg_5_0.equipList_[iter_5_2].equip_id)
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.btnHidePop_, nil, function()
		arg_5_0:ClearSkillSelect()
		arg_5_0.popController_:SetSelectedState("hide")
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.heroViewProxy_ = arg_9_0.params_.proxy
	arg_9_0.equipId_ = arg_9_0.params_.equipId
	arg_9_0.equip = arg_9_0.equipId_ and EquipData:GetEquipData(arg_9_0.equipId_) or EquipStruct.New(0, arg_9_0.params_.prefabId)

	arg_9_0.equipDisc_:OnEnter()

	local var_9_0 = EquipCfg[arg_9_0.equip.prefab_id]

	arg_9_0.index_ = var_9_0.pos
	arg_9_0.oldIndex_ = arg_9_0.params_.rotateAnim and 5 or var_9_0.pos

	arg_9_0.equipDisc_:Rotate(arg_9_0.oldIndex_, arg_9_0.index_)

	if not arg_9_0.params_.rotateAnim then
		arg_9_0.discAnim_:Play("EquipCultureUI")
	end

	arg_9_0:RefreshView()
	arg_9_0:RefreshSideBar(arg_9_0.equipId_)
	arg_9_0:RegistEventListener(EQUIP_UPGRADE_SUCCESS, handler(arg_9_0, arg_9_0.OnEquipUpgradeSuccess))
end

function var_0_0.ChangeBar(arg_10_0)
	if arg_10_0.SetBarInSelfView[arg_10_0.curPageIndex_] then
		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.CameraEnter(arg_11_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		1,
		true
	})
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:ChangeBar()

	if arg_12_0.pages_[arg_12_0.curPageIndex_] then
		arg_12_0.pages_[arg_12_0.curPageIndex_]:OnTop()
	end

	local var_12_0 = GameSetting.equip_culture_describe and GameSetting.equip_culture_describe.value or {}

	manager.windowBar:RegistInfoCallBack(function()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = var_12_0
		})
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back(1, {
			translationAnim = true,
			suitPos = arg_12_0.index_
		})
	end)
end

function var_0_0.RefreshView(arg_15_0)
	arg_15_0.equipPos_ = {}
	arg_15_0.heroId_ = HeroData:GetEquipMap()[arg_15_0.equipId_]

	local var_15_0 = arg_15_0.heroId_ and arg_15_0.heroId_ ~= 0

	arg_15_0.heroEquipController_:SetSelectedState(tostring(var_15_0))

	if var_15_0 then
		arg_15_0.equipList_ = HeroTools.GetHeroEquipS(arg_15_0.heroId_)
		arg_15_0.equipDataList_ = EquipTools.GetEquipDataList(arg_15_0.equipList_)

		arg_15_0.equipDisc_:RefreshItem(arg_15_0.equipDataList_)
		arg_15_0:RefreshHero(arg_15_0.heroId_)
		arg_15_0:RefreshPosBtn(arg_15_0.index_)
	else
		arg_15_0.equipDisc_:HideItems()
		arg_15_0.equipDisc_:RefreshItemByIndex(arg_15_0.index_, arg_15_0.equip)
	end
end

function var_0_0.RefreshHero(arg_16_0, arg_16_1)
	local var_16_0 = HeroCfg[arg_16_1]
	local var_16_1 = HeroTools.HeroUsingSkinInfo(arg_16_1).id

	arg_16_0.heroIcon_.sprite = SpritePathCfg.HeroMediumIcon.path .. var_16_1

	local var_16_2 = string.format("com_white_icon_group_%s_c", var_16_0.race)

	arg_16_0.heroGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_16_2)
end

function var_0_0.RefreshPosBtn(arg_17_0, arg_17_1)
	arg_17_0.equipPosController_:SetSelectedState(arg_17_0.index_)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.equipList_) do
		local var_17_0 = iter_17_1.equip_id ~= 0

		arg_17_0.equipTgl_[iter_17_0].interactable = var_17_0
		arg_17_0.posIcon_[iter_17_0].color = var_17_0 and Color.New(0.4235294117647059, 0.4980392156862745, 0.5647058823529412, 1) or Color.New(0.49019607843137253, 0.5411764705882353, 0.596078431372549, 0.5019607843137255)
	end
end

function var_0_0.RefreshDisc(arg_18_0, arg_18_1)
	arg_18_0.oldIndex_ = arg_18_0.index_
	arg_18_0.index_ = arg_18_1 or arg_18_0.index_

	arg_18_0.equipDisc_:RotateServant(arg_18_0.oldIndex_, arg_18_0.index_)
end

function var_0_0.GoToTarget(arg_19_0, arg_19_1)
	if arg_19_0.curPageIndex_ == arg_19_1 then
		return
	end

	local var_19_0 = arg_19_0.pages_[arg_19_0.curPageIndex_]

	if var_19_0 then
		var_19_0:Hide()
	end

	if arg_19_0.curPageIndex_ then
		arg_19_0.sidebarCon_[arg_19_0.curPageIndex_]:SetSelectedState("false")
	end

	arg_19_0.sidebarCon_[arg_19_1]:SetSelectedState("true")

	arg_19_0.curPageIndex_ = arg_19_1
	arg_19_0.params_.pageIndex = arg_19_1

	local var_19_1 = {
		equipId = arg_19_0.equipId_,
		heroId = arg_19_0.heroId_,
		prefabId = arg_19_0.params_.prefabId,
		proxy = arg_19_0.heroViewProxy_
	}

	if not arg_19_0.pages_[arg_19_1] then
		local var_19_2 = arg_19_0.class_[arg_19_1]
		local var_19_3 = arg_19_0.prefabPath_[arg_19_1]

		if var_19_3 and var_19_2 then
			local var_19_4 = Asset.Load(var_19_3)
			local var_19_5 = Object.Instantiate(var_19_4, arg_19_0.pageContainer_)

			arg_19_0.pages_[arg_19_1] = var_19_2.New(arg_19_0, var_19_5, var_19_1)

			arg_19_0.pages_[arg_19_1]:Show(var_19_1)
		end
	else
		arg_19_0.pages_[arg_19_1]:Show(var_19_1)
	end

	if arg_19_1 == 5 and arg_19_0.equip.race_preview ~= 0 then
		JumpTools.OpenPageByJump("/equipRaceConfirmView", var_19_1)
	end

	arg_19_0:ChangeBar()
end

function var_0_0.RefreshSideBar(arg_20_0, arg_20_1)
	arg_20_0.equipId_ = arg_20_1
	arg_20_0.params_.equipId = arg_20_1
	arg_20_0.equip = EquipData:GetEquipData(arg_20_0.equipId_)

	if arg_20_0.equip then
		local var_20_0 = arg_20_0.params_.pageIndex
		local var_20_1 = EquipCfg[arg_20_0.equip.prefab_id]
		local var_20_2 = arg_20_0.equip.now_break_level + 1
		local var_20_3 = arg_20_0.equip:GetMaxLv() <= arg_20_0.equip:GetLevel() and arg_20_0.equip.now_break_level < var_20_1.break_times_max
		local var_20_4 = not var_20_3
		local var_20_5 = var_20_1.starlevel >= 4
		local var_20_6 = var_20_1.starlevel >= 5 and (arg_20_0.equip.race == 0 or table.keyof(RaceEffectCfg.all, arg_20_0.equip.race) ~= nil)
		local var_20_7 = var_20_1.starlevel >= 5 and arg_20_0.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, arg_20_0.equip.race) == nil

		SetActive(arg_20_0.gameObject_levelup, var_20_4)
		SetActive(arg_20_0.gameObject_upgrade, var_20_3)
		SetActive(arg_20_0.gameObject_enchant, var_20_5)
		SetActive(arg_20_0.gameObject_reset, var_20_6)
		SetActive(arg_20_0.gameObject_inherit, var_20_7)

		if var_20_0 == 2 and var_20_3 then
			var_20_0 = 3
		elseif var_20_0 == 3 and var_20_4 then
			var_20_0 = 2
		elseif var_20_0 == 4 and not var_20_5 or var_20_0 == 5 and not var_20_6 or var_20_0 == 6 and not var_20_7 then
			var_20_0 = 1
		end

		arg_20_0:GoToTarget(var_20_0)
		arg_20_0.pages_[var_20_0]:OnEquipChange(arg_20_0.equipId_)

		if var_20_0 == arg_20_0.params_.pageIndex then
			arg_20_0.equipDisc_:RefreshItemByIndex(arg_20_0.index_, arg_20_0.equip)
		end

		return var_20_0
	else
		arg_20_0:GoToTarget(1)
		SetActive(arg_20_0.gameObject_levelup, false)
		SetActive(arg_20_0.gameObject_upgrade, false)
		SetActive(arg_20_0.gameObject_enchant, false)
		SetActive(arg_20_0.gameObject_reset, false)
		SetActive(arg_20_0.gameObject_inherit, false)

		return 0
	end
end

function var_0_0.RefreshEquipInfo(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0.equipCommonItem_ = arg_21_2

	arg_21_0.equipInfo_:RefreshData(arg_21_0, arg_21_1, arg_21_3, arg_21_0.heroId_, arg_21_0.equipId_)
	arg_21_0.popController_:SetSelectedState("equip")
end

function var_0_0.RefreshSkillInfo(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.skillItem_ = arg_22_1

	arg_22_0.skillInfo_:RefreshData(arg_22_0, arg_22_2)
	arg_22_0.popController_:SetSelectedState("skill")
end

function var_0_0.HidePop(arg_23_0)
	arg_23_0:ClearEquipSelect()
	arg_23_0:ClearSkillSelect()
	arg_23_0.popController_:SetSelectedState("hide")
end

function var_0_0.ClearEquipSelect(arg_24_0)
	if arg_24_0.equipCommonItem_ then
		arg_24_0.equipCommonItem_:RefreshSelectState(false)

		arg_24_0.equipCommonItem_ = nil
	end
end

function var_0_0.ClearSkillSelect(arg_25_0)
	if arg_25_0.skillItem_ then
		arg_25_0.skillItem_:ShowSelect(false)

		arg_25_0.skillItem_ = nil
	end
end

function var_0_0.OnEquipUpgradeSuccess(arg_26_0, arg_26_1)
	arg_26_0:RefreshSideBar(arg_26_1.equipId)
	JumpTools.OpenPageByJump("equipCulturePopView", arg_26_1)
end

function var_0_0.OnEquipInherit(arg_27_0)
	arg_27_0.equip = EquipData:GetEquipData(arg_27_0.equipId_)

	arg_27_0.equipDisc_:RefreshItemByIndex(arg_27_0.index_, arg_27_0.equip)
	arg_27_0.pages_[6]:ResetInherit()
end

function var_0_0.GetEquipId(arg_28_0)
	return arg_28_0.equipId_
end

function var_0_0.GetCulturePage(arg_29_0)
	return arg_29_0.curPageIndex_
end

function var_0_0.OnExit(arg_30_0)
	manager.windowBar:HideBar()
	arg_30_0:HidePop()

	if arg_30_0.curPageIndex_ ~= nil then
		local var_30_0 = arg_30_0.sidebarCon_[arg_30_0.curPageIndex_]
		local var_30_1 = arg_30_0.pages_[arg_30_0.curPageIndex_]

		if var_30_0 then
			var_30_0:SetSelectedState("false")
		end

		if var_30_1 then
			arg_30_0.pages_[arg_30_0.curPageIndex_]:Hide()
		end

		arg_30_0.curPageIndex_ = nil
	end
end

function var_0_0.Dispose(arg_31_0)
	arg_31_0:RemoveAllListeners()

	for iter_31_0, iter_31_1 in pairs(arg_31_0.pages_) do
		iter_31_1:Dispose()
	end

	arg_31_0.pages_ = nil

	arg_31_0.equipInfo_:Dispose()
	arg_31_0.skillInfo_:Dispose()
	arg_31_0.equipDisc_:Dispose()
	var_0_0.super.Dispose(arg_31_0)
end

return var_0_0
