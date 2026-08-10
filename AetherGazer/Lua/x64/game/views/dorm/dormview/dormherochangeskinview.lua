local var_0_0 = class("DormHeroChangeSkinView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/ChangeClothesUI"
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

	arg_4_0.skinScroll = LuaList.New(handler(arg_4_0, arg_4_0.indexSkinList), arg_4_0.skinListUilist_, DormHeroSkinItem)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.subtitleBubbleView = SubtitleBubbleView.MuteBubbleSubView.GetInstance()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.heroID = arg_6_0.params_.heroID
	arg_6_0.heroEID = arg_6_0.params_.heroEID
	arg_6_0.archiveID = DormData:GetHeroArchiveID(arg_6_0.heroID)
	arg_6_0.heroInfo = DormData:GetHeroTemplateInfo(arg_6_0.heroID)
	arg_6_0.skinID = arg_6_0.heroInfo:GetHeroCurSkinID(arg_6_0.heroID)

	arg_6_0:RegisterEvent()
	arg_6_0:RefreshDeriveHero()
	arg_6_0.subtitleBubbleView:OnEnter()
	arg_6_0:RefreshView()
end

function var_0_0.RefreshView(arg_7_0)
	arg_7_0:RefreshSkinView()
	arg_7_0:UpdataHeroItemState()
end

function var_0_0.RegisterEvent(arg_8_0)
	arg_8_0:RegistEventListener(DORM_HERO_SKIN_CHANGE, function(arg_9_0)
		arg_8_0.skinID = arg_9_0

		arg_8_0.skinScroll:Refresh()
		arg_8_0:UpdataHeroItemState()
		arg_8_0:ChangeHeroPrefab(arg_9_0)
	end)
	arg_8_0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		ShowTips("DORM_CHANGE_DERIVE_SUCCESS")
		arg_8_0:RefreshView()

		arg_8_0.skinID = arg_8_0.heroInfo:GetHeroCurSkinID(arg_8_0.heroID)

		arg_8_0:ChangeHeroPrefab(arg_8_0.skinID)
	end)
end

function var_0_0.RefreshSkinView(arg_11_0)
	arg_11_0.skinList = {}
	arg_11_0.skinList = DormHeroTools.GetCanUseDormHeroSkinList(arg_11_0.heroID)

	arg_11_0.skinScroll:StartScroll(#arg_11_0.skinList)
end

function var_0_0.RefreshDeriveHero(arg_12_0)
	if not arg_12_0.heroItemList then
		local var_12_0 = DormHeroTools:GetAllCanUseHeroIDInDorm(arg_12_0.archiveID, true)

		arg_12_0.heroItemList = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_1 = arg_12_0.heroInfo:GetHeroCurSkinID(iter_12_1)
			local var_12_2 = Object.Instantiate(arg_12_0.herohead1Go_, arg_12_0.heroitembgTrs_)

			arg_12_0.heroItemList[iter_12_0] = DormCircleHeroItem.New(var_12_2)

			arg_12_0.heroItemList[iter_12_0]:RefreshUI(iter_12_1, arg_12_0.heroID)
			arg_12_0.heroItemList[iter_12_0]:SetClickCallBack(handler(arg_12_0, arg_12_0.ClickHeroItem))
		end
	end
end

function var_0_0.RecordHeroPosInfo(arg_13_0)
	local var_13_0 = arg_13_0.heroEID

	if Dorm.DormEntityManager.IsValidEntityID(var_13_0) then
		return {
			pos = Dorm.DormEntityManager.QueryPosition(var_13_0),
			forward = Dorm.DormEntityManager.QueryForwardDir(var_13_0)
		}
	end
end

function var_0_0.ClickHeroItem(arg_14_0, arg_14_1)
	if not HeroTools.GetHeroIsUnlock(arg_14_1) then
		ShowTips("DORM_HERO_LOCK")

		return
	end

	if arg_14_0.heroID == arg_14_1 then
		return
	end

	arg_14_0.recordPosInfo = arg_14_0:RecordHeroPosInfo()
	arg_14_0.heroID = arg_14_1

	local var_14_0 = DormData:GetCurrectSceneID()
	local var_14_1 = DormitoryData:GetDormHerosByArchitecture(var_14_0)
	local var_14_2 = {}
	local var_14_3 = DormData:GetHeroArchiveID(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if DormData:GetHeroArchiveID(iter_14_1) ~= var_14_3 then
			table.insert(var_14_2, iter_14_1)
		end
	end

	table.insert(var_14_2, arg_14_1)
	DormAction:DeployHeroInRoom(var_14_0, var_14_2, DormEnum.DormDeployType.Place)
end

function var_0_0.UpdataHeroItemState(arg_15_0)
	if arg_15_0.heroItemList then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.heroItemList) do
			iter_15_1:RefreshUI(iter_15_1.heroID, arg_15_0.heroID)
		end
	end
end

function var_0_0.AddUIListener(arg_16_0)
	arg_16_0:AddBtnListener(arg_16_0.closeBtn, nil, function()
		JumpTools.Back(1, {
			heroEID = arg_16_0.heroEID
		})
		Dorm.DormEntityManager.StopAllCmd(arg_16_0.heroEID)
	end)
end

function var_0_0.indexSkinList(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:RegisterClickCallBack(function(arg_19_0)
		if arg_18_0.skinID == arg_19_0 then
			return
		end

		DormAction:SetHeroSkin(arg_19_0, DormConst.DORM_CHANGESKIN_TYPE.view)
	end)
	arg_18_2:RefreshUI(arg_18_0.skinList[arg_18_1], arg_18_0.heroID, arg_18_0.skinID)
end

function var_0_0.ChangeHeroPrefab(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.heroEID
	local var_20_1 = var_20_0 and Dorm.DormEntityManager.IsValidEntityID(var_20_0)
	local var_20_2

	if var_20_1 and DormUtils.GetEntityData(var_20_0).cfgID == arg_20_1 then
		var_20_2 = var_20_0
	else
		var_20_2 = DormCharacterManager.GetInstance():GetEntityID(arg_20_1)

		if not (var_20_2 and Dorm.DormEntityManager.IsValidEntityID(var_20_2)) then
			var_20_2 = DormCharacterManager.GetInstance():Generate(arg_20_1, true)

			Dorm.DormEntityManager.PutEntityAt(var_20_2, var_20_0, "root")

			if var_20_1 then
				DormCharacterManager.FindAndRemove(var_20_0)
			end
		end

		arg_20_0.heroEID = var_20_2
	end

	Dorm.DormEntityManager.StopAllCmd(arg_20_0.heroEID)

	if arg_20_0.recordPosInfo then
		Dorm.DormEntityManager.PutEntityLookToDir(var_20_2, arg_20_0.recordPosInfo.pos, arg_20_0.recordPosInfo.forward)

		arg_20_0.recordPosInfo = nil
	end

	DormHeroAI:SwitchControl(var_20_2, DormEnum.ControlType.Player)
	Dorm.DormEntityManager.SetPlayerEntityFaceToCam(var_20_2, true)
	Dorm.DormEntityManager.SendInteractToEntityCMD(var_20_2, var_20_2, false)

	local var_20_3 = DormCharacterInteractBehaviour.MakeCtxForInternalAction(var_20_2, var_20_2, "change_skin_self")

	DormUtils.SetEntityInteractContext(var_20_2, var_20_3)
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:RemoveAllEventListener()
	arg_21_0.subtitleBubbleView:OnExit()

	if arg_21_0.heroItemList then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.heroItemList) do
			iter_21_1:Dispose()
		end

		arg_21_0.heroItemList = nil
	end
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.skinScroll then
		arg_22_0.skinScroll:Dispose()

		arg_22_0.skinScroll = nil
	end

	if arg_22_0.heroItemList then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.heroItemList) do
			iter_22_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
