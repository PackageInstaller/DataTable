local var_0_0 = class("HeroEquipPage", HeroPageBase)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
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

	arg_3_0.detailController_ = arg_3_0.controller_:GetController("detail")
	arg_3_0.isSelfController_ = arg_3_0.controller_:GetController("isSelf")
	arg_3_0.skillPopController_ = arg_3_0.controller_:GetController("skill")
	arg_3_0.equipDisc_ = EquipDisc.New(arg_3_0.discGo_)

	arg_3_0.equipDisc_:RegistItemButton(handler(arg_3_0, arg_3_0.OnClickItem))

	arg_3_0.equipInfo_ = EquipInfoView.New(arg_3_0.equipInfoGo_)

	arg_3_0.equipInfo_:RegisterSkillClick(handler(arg_3_0, arg_3_0.SkillClick))
	arg_3_0.equipInfo_:RegistHeroButton(handler(arg_3_0, arg_3_0.GoEquipBag), handler(arg_3_0, arg_3_0.GoEquipCulture))

	arg_3_0.equipOverrall_ = EquipOverall.New(arg_3_0.rightGo_)

	arg_3_0.equipOverrall_:RegistSkillClick(handler(arg_3_0, arg_3_0.SkillClick))

	arg_3_0.equipSkillPop_ = EquipNewSkillInfoView.New(arg_3_0.equipSkillGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btnPopMask_, nil, function()
		arg_4_0:HideMaskMessage()
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnUnload_, nil, function()
		local var_6_0 = false
		local var_6_1 = arg_4_0.heroViewProxy_:GetEquipInfoList(arg_4_0.heroInfo_.id)

		for iter_6_0, iter_6_1 in ipairs(var_6_1 or {}) do
			if iter_6_1.equip_id ~= 0 then
				var_6_0 = true

				break
			end
		end

		if not var_6_0 then
			ShowTips("ERROR_EQUIP_NOT")

			return
		end

		local var_6_2 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipUninstallEquipTip and var_6_2.uninstall_equip_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_ONE_CLICK_UNINSTALL_WARNING"),
				OkCallback = function()
					_G.SkipTip.SkipUninstallEquipTip = arg_4_0.SkipUninstallEquipTip

					HeroAction.EquipUnloadAll(arg_4_0.heroInfo_.id)
				end,
				ToggleCallback = function(arg_8_0)
					arg_4_0.SkipUninstallEquipTip = arg_8_0
				end
			})
		else
			HeroAction.EquipUnloadAll(arg_4_0.heroInfo_.id)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.btnOption_, nil, function()
		arg_4_0.isGoSubPanel = true

		arg_4_0:Go("/EquipProposal", {
			heroID = arg_4_0.heroInfo_.id,
			proxy = arg_4_0.heroViewProxy_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.mask_, nil, function()
		arg_4_0.detailController_:SetSelectedState("false")
		arg_4_0.equipDisc_:Reset()
	end)
end

function var_0_0.CheckLocked(arg_11_0)
	arg_11_0.equipInfo_:CheckLocked()
end

function var_0_0.SetHeroInfo(arg_12_0, arg_12_1)
	arg_12_0.heroInfo_ = arg_12_1

	arg_12_0.detailController_:SetSelectedState("false")
	arg_12_0.equipDisc_:Reset()
end

function var_0_0.UpdateView(arg_13_0)
	arg_13_0:RefreshEquipDisc()
	arg_13_0.equipOverrall_:RefreshHeroInfo(arg_13_0.heroInfo_)

	local var_13_0 = arg_13_0.equipDataList_[arg_13_0.enterIndex_]
	local var_13_1 = var_13_0 and var_13_0.equip_id or 0

	arg_13_0.equipInfo_:RefreshData(arg_13_0, var_13_0, nil, arg_13_0.heroInfo_.id, var_13_1)
	arg_13_0:PlayAnim()
end

function var_0_0.OnClickItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.enterIndex_ = arg_14_2

	if arg_14_1 and arg_14_1.equip_id ~= 0 then
		arg_14_0.equipInfo_:RefreshData(arg_14_0, arg_14_1, nil, arg_14_0.heroInfo_.id, arg_14_1.equip_id)
		arg_14_0.detailController_:SetSelectedState("true")
	else
		if not arg_14_0.heroViewProxy_.isSelf then
			return
		end

		arg_14_0:GoEquipBag()
	end
end

function var_0_0.SkillClick(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.detailController_:GetSelectedState() == "false"

	arg_15_0.equipSkillPop_:RefreshData(arg_15_0, arg_15_2, var_15_0)
	arg_15_0.skillPopController_:SetSelectedState("show")
end

function var_0_0.RefreshEquipDisc(arg_16_0)
	if arg_16_0.heroInfo_ then
		arg_16_0.heroEquipList_ = arg_16_0.heroViewProxy_:GetEquipInfoList(arg_16_0.heroInfo_.id)
		arg_16_0.equipDataList_ = arg_16_0.heroViewProxy_:GetEquipDataList(arg_16_0.heroInfo_.id)

		arg_16_0.equipDisc_:RefreshItem(arg_16_0.equipDataList_)
	end
end

function var_0_0.GoEquipBag(arg_17_0)
	arg_17_0.isGoSubPanel = true

	arg_17_0:Go("/heroEquipBag", {
		isOpenInfo = false,
		heroId = arg_17_0.heroInfo_.id,
		suitPos = arg_17_0.enterIndex_,
		proxy = arg_17_0.heroViewProxy_
	})
end

function var_0_0.GoEquipCulture(arg_18_0)
	local var_18_0 = arg_18_0.heroEquipList_[arg_18_0.enterIndex_]

	if var_18_0 and var_18_0.equip_id ~= 0 then
		arg_18_0.isGoSubPanel = true

		arg_18_0:Go("/equipCultureView", {
			pageIndex = 2,
			rotateAnim = true,
			equipId = var_18_0.equip_id,
			proxy = arg_18_0.heroViewProxy_
		})
	else
		ShowTips("NO_EQUIP")
	end
end

function var_0_0.HideMaskMessage(arg_19_0)
	arg_19_0.skillPopController_:SetSelectedState("hide")
	arg_19_0.equipOverrall_:DeSelect()
	arg_19_0.equipInfo_:DeSelect()
end

function var_0_0.CameraEnter(arg_20_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function var_0_0.OnEnter(arg_21_0, arg_21_1)
	arg_21_0:HideMaskMessage()

	arg_21_0.heroViewProxy_ = arg_21_1

	arg_21_0.equipOverrall_:OnEnter(arg_21_1)
	arg_21_0.equipInfo_:OnEnter(arg_21_1)
	arg_21_0.equipDisc_:OnEnter({
		isShowDetail = true
	})
	arg_21_0.isSelfController_:SetSelectedState(tostring(arg_21_0.heroViewProxy_.isSelf))
	arg_21_0:RegistEventListener(HERO_DATA_MODIFY, handler(arg_21_0, arg_21_0.UpdateView))
	arg_21_0:CheckLocked()

	arg_21_0.enterIndex_ = arg_21_0.enterIndex_ or 1
end

function var_0_0.Show(arg_22_0)
	var_0_0.super.Show(arg_22_0)
	SetActive(arg_22_0.gameObject_, true)
	arg_22_0:UpdateView()
end

function var_0_0.PlayAnim(arg_23_0)
	arg_23_0.equipDisc_:PlayAnim(arg_23_0.isGoSubPanel)

	arg_23_0.isGoSubPanel = false
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0:RemoveAllEventListener()
	arg_24_0.equipOverrall_:OnExit()
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0.equipSkillPop_:Dispose()
	arg_25_0.equipInfo_:Dispose()
	arg_25_0.equipDisc_:Dispose()
	arg_25_0.equipOverrall_:Dispose()
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
