local var_0_0 = class("SandPlayIlluView", ReduxView)
local var_0_1 = "QWWorld/Illu/Illu_background_01"
local var_0_2 = "QWWorld/Illu/Illu_background_02"

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_Book/SandPlay_Com_BookUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
	arg_3_0:InitData()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.itemList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiListGo_, SandPlayIlluItem)
	arg_4_0.tabList_ = {}

	arg_4_0:BindController()
end

function var_0_0.BindController(arg_5_0)
	arg_5_0.btnStateController_ = arg_5_0.mainControllerEx_:GetController("btn")
	arg_5_0.tabController_ = arg_5_0.mainControllerEx_:GetController("tab")
	arg_5_0.modelController_ = arg_5_0.modelControllerEx_:GetController("lock")
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.curGroupIndex_ = 0
	arg_6_0.curItemID_ = 0
	arg_6_0.curItemIDList_ = {}
	arg_6_0.curGroupList_ = {}
	arg_6_0.curModel_ = nil
	arg_6_0.bg_ = nil
	arg_6_0.board_ = nil
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		local var_8_0 = arg_7_0.curGroupList_[arg_7_0.curGroupIndex_]

		if not SandplayIlluGroupCfg[var_8_0] then
			return
		end

		SandplayIlluAction.GetReward(arg_7_0.curItemID_)
	end)
	arg_7_0:AddDragListener(arg_7_0.backGo_, function()
		if arg_7_0.curModel_ then
			arg_7_0.startRot_ = arg_7_0.curModel_.transform.localEulerAngles
		else
			arg_7_0.startRot_ = Vector3.zero
		end

		arg_7_0.lastRotateY_ = nil
		arg_7_0.lastDeltaX_ = 0
	end, function(arg_10_0, arg_10_1)
		if arg_7_0.curModel_ then
			local var_10_0 = arg_7_0.lastRotateY_ or arg_7_0.curModel_.transform.localEulerAngles.y
			local var_10_1 = var_10_0 + (arg_10_0 - (arg_7_0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - var_10_0
			local var_10_2 = var_10_1

			if var_10_1 < -HeroConst.MAX_RORATE_ANGLE then
				var_10_2 = -HeroConst.MAX_RORATE_ANGLE
			elseif var_10_1 > HeroConst.MAX_RORATE_ANGLE then
				var_10_2 = HeroConst.MAX_RORATE_ANGLE
			end

			arg_7_0.lastRotateY_ = var_10_0 + var_10_2
			arg_7_0.lastDeltaX_ = arg_10_0
			arg_7_0.curModel_.transform.localRotation = Quaternion.RotateTowards(arg_7_0.curModel_.transform.localRotation, Quaternion.Euler(arg_7_0.startRot_.x, var_10_0 + var_10_2, arg_7_0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, arg_11_0.curItemIDList_[arg_11_1], function(arg_12_0, arg_12_1)
		arg_11_0:ChangeItemID(arg_12_0, arg_12_1)
	end)
	arg_11_2:SetSelectedState(arg_11_0.curItemID_)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:LoadBg()
	arg_13_0:RefreshData(false)

	local var_13_0 = QWorldData:GetCurSceneName()

	arg_13_0.sceneSetting_ = manager.ui:GetSceneSettingBySceneName(var_13_0)
	arg_13_0.sceneSetting_.enabled = false

	SandPlayIlluTool.OnEnterSandPlayIllu()
end

function var_0_0.RefreshData(arg_14_0, arg_14_1)
	arg_14_0:RefreshGroupList()

	if arg_14_0.params_.itemID then
		local var_14_0 = SandplayIlluCfg[arg_14_0.params_.itemID]

		if var_14_0 and var_14_0.type then
			arg_14_0:ChangeGroupIndex(var_14_0.type, arg_14_0.params_.itemID, arg_14_1)

			return
		end
	end

	arg_14_0:ChangeGroupIndex(1, nil, arg_14_1)
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnBehind(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.ChangeGroupIndex(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0.curGroupIndex_ == arg_17_1 and not arg_17_3 then
		return
	end

	arg_17_0.curGroupIndex_ = arg_17_1

	arg_17_0:RefreshChooseGroupState(arg_17_1)
	arg_17_0:RefreshItemList()

	if arg_17_2 then
		local var_17_0 = -1

		for iter_17_0, iter_17_1 in ipairs(arg_17_0.curItemIDList_) do
			if iter_17_1 == arg_17_2 then
				arg_17_0:ChangeItemID(arg_17_2, iter_17_0)

				return
			end
		end
	end

	arg_17_0:ChangeItemID(arg_17_0.curItemIDList_[1], 1)
end

function var_0_0.ChangeItemID(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 or arg_18_0.curItemID_ == arg_18_1 then
		return
	end

	arg_18_0.curItemID_ = arg_18_1

	if SandplayIlluData:IsUnlock(arg_18_1) and not SandplayIlluData:IsSaw(arg_18_0.curItemID_) then
		local var_18_0 = arg_18_0.curGroupList_[arg_18_0.curGroupIndex_]

		if SandplayIlluGroupCfg[var_18_0] then
			SandplayIlluAction.ViewItem(arg_18_0.curItemID_)
		end
	end

	arg_18_0:RefreshButtonState()
	arg_18_0:RefreshChooseItemState(arg_18_1)
	arg_18_0:RefreshItemView()
end

function var_0_0.RefreshGroupList(arg_19_0)
	local var_19_0 = SandplayIlluData:GetGroupNum()

	arg_19_0.curGroupList_ = SandplayIlluGroupCfg.all

	if var_19_0 <= 1 then
		arg_19_0.tabController_:SetSelectedState("hide")

		return
	end

	arg_19_0.tabController_:SetSelectedState("show")

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.curGroupList_) do
		if not arg_19_0.tabList_[iter_19_0] then
			local var_19_1 = Object.Instantiate(arg_19_0.tabItemGo_, arg_19_0.tabTrans_)

			arg_19_0.tabList_[iter_19_0] = SandPlayIlluTabItem.New(var_19_1)
		end

		arg_19_0.tabList_[iter_19_0]:SetData(iter_19_0, iter_19_1, function(arg_20_0)
			arg_19_0:ChangeGroupIndex(arg_20_0)
		end)
		arg_19_0.tabList_[iter_19_0]:Show(true)
	end

	for iter_19_2 = var_19_0 + 1, #arg_19_0.tabList_ do
		arg_19_0.tabList_[iter_19_2]:Show(false)
	end
end

function var_0_0.RefreshItemList(arg_21_0)
	local var_21_0 = arg_21_0.curGroupList_[arg_21_0.curGroupIndex_]
	local var_21_1 = SandplayIlluCfg.get_id_list_by_type[var_21_0]

	if not var_21_1 then
		return
	end

	CommonTools.UniversalSortEx(var_21_1, {
		map = function(arg_22_0)
			if SandplayIlluData:IsUnlock(arg_22_0) and not SandplayIlluData:IsSaw(arg_22_0) then
				return 2
			elseif SandplayIlluData:IsUnlock(arg_22_0) then
				return 1
			else
				return 0
			end
		end
	}, {
		map = function(arg_23_0)
			return -arg_23_0
		end
	})

	arg_21_0.curItemIDList_ = var_21_1

	arg_21_0.itemList_:StartScroll(#arg_21_0.curItemIDList_)

	local var_21_2 = SandplayIlluGroupCfg[var_21_0]

	if var_21_2 then
		arg_21_0.groupText_.text = var_21_2.name
	end

	local var_21_3 = SandplayIlluData:GetItemNum(var_21_0)
	local var_21_4 = #arg_21_0.curItemIDList_

	arg_21_0.progressText_.text = var_21_3 .. "/" .. var_21_4
end

function var_0_0.RefreshButtonState(arg_24_0)
	local var_24_0 = SandplayIlluCfg[arg_24_0.curItemID_]

	if not SandplayIlluData:IsUnlock(arg_24_0.curItemID_) then
		arg_24_0.btnStateController_:SetSelectedState("lock")
	elseif SandplayIlluData:IsReceive(arg_24_0.curItemID_) then
		arg_24_0.btnStateController_:SetSelectedState("rewarded")
	else
		arg_24_0.btnStateController_:SetSelectedState("complete")
	end
end

function var_0_0.RefreshChooseGroupState(arg_25_0, arg_25_1)
	if #arg_25_0.tabList_ < 1 then
		return
	end

	for iter_25_0, iter_25_1 in pairs(arg_25_0.tabList_) do
		iter_25_1:SetSelectedState(arg_25_1)
	end
end

function var_0_0.RefreshChooseItemState(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.itemList_:GetItemList()

	for iter_26_0, iter_26_1 in pairs(var_26_0) do
		iter_26_1:SetSelectedState(arg_26_1)
	end
end

function var_0_0.RefreshItemView(arg_27_0)
	local var_27_0 = SandplayIlluCfg[arg_27_0.curItemID_]

	arg_27_0:OnRefreshItem()

	arg_27_0.titleText_.text = var_27_0.name
	arg_27_0.descText_.text = var_27_0.desc
	arg_27_0.lockDescText_.text = var_27_0.simple_desc
	arg_27_0.scroll_.verticalNormalizedPosition = 1

	arg_27_0.textAnimator_:Play("itemDetails", 0, 0)
	manager.redPoint:bindUIandKey(arg_27_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, arg_27_0.curItemID_))
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0.curGroupIndex_ = 0
	arg_28_0.curItemID_ = 0
	arg_28_0.curItemIDList_ = {}
	arg_28_0.curGroupList_ = {}

	arg_28_0:UnBindRedPoint()
	arg_28_0:UnloadBg()
	arg_28_0:UnloadModel()
	SandPlayIlluTool.ExitSandPlayIllu()

	if arg_28_0.sceneSetting_ then
		arg_28_0.sceneSetting_.enabled = true
	end
end

function var_0_0.OnSandPlayIlluItemDataChange(arg_29_0, arg_29_1)
	if arg_29_1 then
		arg_29_0:RefreshData(true)
	else
		arg_29_0:RefreshButtonState()
	end
end

function var_0_0.OnRefreshItem(arg_30_0)
	arg_30_0:UnloadModel()

	if not SandplayIlluData:IsUnlock(arg_30_0.curItemID_) then
		arg_30_0.modelController_:SetSelectedState("true")

		return
	end

	arg_30_0.modelController_:SetSelectedState("false")
	arg_30_0:LoadModel()
end

function var_0_0.LoadBg(arg_31_0)
	arg_31_0:UnloadBg()

	local var_31_0 = Vector3.New(SandPlayIlluConst.CAMERA_POS[1], SandPlayIlluConst.CAMERA_POS[2], SandPlayIlluConst.CAMERA_POS[3])
	local var_31_1 = manager.ui.mainCamera.transform

	arg_31_0.bg_ = Asset.Instantiate(var_0_1)
	arg_31_0.bg_.transform.localPosition = Vector3.New(SandPlayIlluConst.BG_POS[1], SandPlayIlluConst.BG_POS[2], SandPlayIlluConst.BG_POS[3]) + var_31_0
	arg_31_0.board_ = Asset.Instantiate(var_0_2)

	arg_31_0:AdaptBg()
end

function var_0_0.UnloadBg(arg_32_0)
	if arg_32_0.bg_ then
		Object.Destroy(arg_32_0.bg_)
	end

	arg_32_0.bg_ = nil

	if arg_32_0.board_ then
		Object.Destroy(arg_32_0.board_)
	end

	arg_32_0.board_ = nil
end

function var_0_0.LoadModel(arg_33_0)
	if arg_33_0.curModel_ ~= nil then
		arg_33_0:UnloadModel()
	end

	local var_33_0 = SandplayIlluCfg[arg_33_0.curItemID_]

	if var_33_0 then
		local var_33_1 = var_33_0.model_path

		arg_33_0.curModel_ = Asset.Instantiate(var_33_1)
	end
end

function var_0_0.UnloadModel(arg_34_0)
	if arg_34_0.curModel_ == nil then
		return
	end

	Object.Destroy(arg_34_0.curModel_)

	if isNil(arg_34_0.curModel_) then
		arg_34_0.curModel_ = nil
	end
end

function var_0_0.UnBindRedPoint(arg_35_0)
	manager.redPoint:bindUIandKey(arg_35_0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SANDPLAY_ILLU_ITEM, arg_35_0.curItemID_))
end

function var_0_0.AdaptBg(arg_36_0)
	local var_36_0 = arg_36_0.bg_.transform:GetComponentInChildren(typeof(SpriteRenderer))

	if var_36_0 then
		local var_36_1 = Vector3.New(SandPlayIlluConst.CAMERA_POS[1], SandPlayIlluConst.CAMERA_POS[2], SandPlayIlluConst.CAMERA_POS[3])
		local var_36_2 = (arg_36_0.bg_.transform.localPosition - var_36_1).z
		local var_36_3 = manager.ui.mainCameraCom_
		local var_36_4 = 2 * var_36_2 * Mathf.Tan(var_36_3.fieldOfView * 0.5 * Mathf.Deg2Rad)
		local var_36_5 = var_36_4 * var_36_3.aspect
		local var_36_6 = var_36_0.sprite.bounds.size.x
		local var_36_7 = var_36_0.sprite.bounds.size.y
		local var_36_8 = var_36_5 / var_36_6
		local var_36_9 = var_36_4 / var_36_7
		local var_36_10 = var_36_9 < var_36_8 and var_36_8 or var_36_9

		arg_36_0.bg_.transform.localScale = Vector3.New(var_36_10, var_36_10, var_36_10)

		local var_36_11 = Screen.width / 1920
		local var_36_12 = Screen.height / 1080
		local var_36_13 = math.min((var_36_11 + var_36_12) / 2, 1)
		local var_36_14 = SandPlayIlluConst.BOARD_SCALE

		arg_36_0.board_.transform.localScale = Vector3.New(var_36_14, var_36_14, var_36_14)

		local var_36_15 = Screen.width / Screen.height / 1.7777777777777777
		local var_36_16 = math.min(1, var_36_15)

		arg_36_0.board_.transform.localPosition = Vector3.New(SandPlayIlluConst.BOARD_POS[1] * var_36_16, SandPlayIlluConst.BOARD_POS[2], SandPlayIlluConst.BOARD_POS[3]) + var_36_1
	end
end

function var_0_0.Dispose(arg_37_0)
	if arg_37_0.itemList_ then
		arg_37_0.itemList_:Dispose()

		arg_37_0.itemList_ = nil
	end

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.tabList_) do
		if iter_37_1 and iter_37_1.Dispose then
			iter_37_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_37_0)
end

return var_0_0
