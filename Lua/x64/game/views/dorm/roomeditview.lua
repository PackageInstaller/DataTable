local var_0_0 = class("RoomEditView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormEditstatusUI"
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

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, FurnitureItem)
	arg_5_0.choiceController = ControllerUtil.GetController(arg_5_0.screeningswitchTrs_, "choice")
	arg_5_0.switchController = ControllerUtil.GetController(arg_5_0.screeningswitchTrs_, "switch")
	arg_5_0.canPlaceController = ControllerUtil.GetController(arg_5_0.canPlace.transform, "name")
	arg_5_0.notPresentedController = ControllerUtil.GetController(arg_5_0.notPresented.transform, "name")
	arg_5_0.hadPlaceController = ControllerUtil.GetController(arg_5_0.hadPlace.transform, "name")
	arg_5_0.otherHadPlaceController = ControllerUtil.GetController(arg_5_0.otherHadPlace.transform, "name")
	arg_5_0.descController = ControllerUtil.GetController(arg_5_0.transform_, "desc")
	arg_5_0.descText.text = GetTips("DORM_FURNITURE_EDIT_INFO")
	arg_5_0.devController = ControllerUtil.GetController(arg_5_0.transform_, "devState")
	arg_5_0.suitController = ControllerUtil.GetController(arg_5_0.transform_, "suitPage")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.roomID = DormData:GetCurrectSceneID()
	arg_6_0.roomData = DormitoryData:GetDormSceneData(arg_6_0.roomID)

	DormLuaBridge.ChangeCameraMode(1, true)
	DormLuaBridge.SetIsCanEditTag(true)

	arg_6_0.selectIndex_ = arg_6_0.params_.index or DormConst.FLOOR_TYPE_NUM
	arg_6_0.params_.index = arg_6_0.selectIndex_
	arg_6_0.filterShow = false

	arg_6_0:RegisterEvents()
	arg_6_0:BindRedPoint()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshView(true)
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()
	arg_8_0:UnBindRedPoint()
end

function var_0_0.RegisterEvents(arg_9_0)
	arg_9_0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function()
		if arg_9_0.scrollHelper_ then
			arg_9_0:RefreshView(true)
		end
	end)
	arg_9_0:RegistEventListener(SDK_UPLOAD_IMG, function(arg_11_0)
		arg_9_0:UploadImageSuccess(arg_11_0)
	end)
end

function var_0_0.BindRedPoint(arg_12_0)
	for iter_12_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END - 1 do
		manager.redPoint:bindUIandKey(arg_12_0["item_" .. iter_12_0 .. "icon"], string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(iter_12_0)))
	end

	manager.redPoint:bindUIandKey(arg_12_0["item_" .. 28 .. "icon"], RedPointConst.DORM_SUIT)

	local var_12_0 = nullable(BackHomeCfg, arg_12_0.roomID, "type")

	if var_12_0 == DormConst.BACKHOME_TYPE.PublicDorm then
		manager.redPoint:bindUIandKey(arg_12_0.suitBtn1.transform, RedPointConst.DORM_FULL_PUBLIC_SUIT)
	elseif var_12_0 == DormConst.BACKHOME_TYPE.PrivateDorm then
		manager.redPoint:bindUIandKey(arg_12_0.suitBtn1.transform, RedPointConst.DORM_FULL_PRIVATE_SUIT)
	end

	manager.redPoint:bindUIandKey(arg_12_0.suitBtn2.transform, RedPointConst.DORM_PART_SUIT)
end

function var_0_0.UnBindRedPoint(arg_13_0)
	for iter_13_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END - 1 do
		manager.redPoint:unbindUIandKey(arg_13_0["item_" .. iter_13_0 .. "icon"], string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(iter_13_0)))
	end

	manager.redPoint:unbindUIandKey(arg_13_0["item_" .. 28 .. "icon"], RedPointConst.DORM_SUIT)

	local var_13_0 = BackHomeCfg[arg_13_0.roomID].type

	if var_13_0 == DormConst.BACKHOME_TYPE.PublicDorm then
		manager.redPoint:unbindUIandKey(arg_13_0.suitBtn1.transform, RedPointConst.DORM_FULL_PUBLIC_SUIT)
	elseif var_13_0 == DormConst.BACKHOME_TYPE.PrivateDorm then
		manager.redPoint:unbindUIandKey(arg_13_0.suitBtn1.transform, RedPointConst.DORM_FULL_PRIVATE_SUIT)
	end

	manager.redPoint:unbindUIandKey(arg_13_0.suitBtn2.gameObject.transform, RedPointConst.DORM_PART_SUIT)

	if arg_13_0.scrollHelper_ then
		local var_13_1 = arg_13_0.scrollHelper_:GetItemList()

		for iter_13_1, iter_13_2 in pairs(var_13_1) do
			manager.redPoint:unbindUIandKey(iter_13_2.transform_)
		end
	end
end

function var_0_0.RefreshView(arg_14_0, arg_14_1)
	arg_14_0:InitRoomCanUseFurList()
	arg_14_0:OnGroupSelect(arg_14_0.selectIndex_, arg_14_1)
	arg_14_0:UpdataHasPlaceFurNum()
	arg_14_0:RefreshEditTypeSwichBar()
	arg_14_0:RefreshDevInfo()
end

function var_0_0.UpdataHasPlaceFurNum(arg_15_0)
	local var_15_0 = DormFurnitureTools:GetHasPlaceFurNumInfoInMap(arg_15_0.roomID)
	local var_15_1 = DormFurEditStateData:GetCacheFurTotalNum()

	arg_15_0.curNum.text = var_15_0 + var_15_1 + DormConst.DORM_SPECIAL_FURNITURE_NUM

	local var_15_2 = 0

	if BackHomeCfg[arg_15_0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		var_15_2 = GameSetting.dorm_lobby_furniture_limited.value[1]
	elseif BackHomeCfg[arg_15_0.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_15_3 = DormitoryData:GetDormLevel(arg_15_0.roomID)

		var_15_2 = BackHomeDormLevel[var_15_3].furniture_max
	end

	arg_15_0.totalNum.text = "/" .. var_15_2
end

function var_0_0.InitRoomCanUseFurList(arg_16_0)
	arg_16_0.furList = {}

	local var_16_0 = DormFurnitureTools:GetFurEditFlag()

	if var_16_0.canPlaceFlag then
		arg_16_0.canPlaceList = DormFurnitureTools:GetRoomCanPlaceFurList(arg_16_0.roomID)

		for iter_16_0, iter_16_1 in ipairs(arg_16_0.canPlaceList) do
			local var_16_1 = {
				furID = iter_16_1,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace
			}

			table.insert(arg_16_0.furList, var_16_1)
		end
	end

	if var_16_0.notPresentedFlag then
		arg_16_0.notPresentedList = DormFurnitureTools:GetNotPresentedFurInRoom(arg_16_0.roomID)

		for iter_16_2, iter_16_3 in ipairs(arg_16_0.notPresentedList) do
			local var_16_2 = {
				furID = iter_16_3,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented
			}

			table.insert(arg_16_0.furList, var_16_2)
		end
	end

	if var_16_0.hadPlaceFlag then
		arg_16_0.hadPlaceFurList = DormFurEditStateData:GetHadPlaceFurNumInRoom(arg_16_0.roomID)

		for iter_16_4, iter_16_5 in ipairs(arg_16_0.hadPlaceFurList) do
			local var_16_3 = {
				furID = iter_16_5,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace
			}

			table.insert(arg_16_0.furList, var_16_3)
		end
	end

	if var_16_0.otherHadPlaceFlag then
		arg_16_0.otherHadPlaceFurList = DormFurnitureTools:GetHadPlaceFlagFurInRoom(arg_16_0.roomID)

		for iter_16_6, iter_16_7 in ipairs(arg_16_0.otherHadPlaceFurList) do
			local var_16_4 = {
				furID = iter_16_7,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace
			}

			table.insert(arg_16_0.furList, var_16_4)
		end
	end
end

function var_0_0.RefreshEditTypeSwichBar(arg_17_0)
	if arg_17_0.filterShow then
		arg_17_0.switchController:SetSelectedState("on")
		arg_17_0:RefreshFurEditTypeController()
	else
		arg_17_0.switchController:SetSelectedState("off")
	end

	local var_17_0 = DormFurnitureTools:GetFurEditFlag()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if not var_17_0[iter_17_0] then
			arg_17_0.dropText_.text = GetTips("ROLE_FILTERING")

			arg_17_0.choiceController:SetSelectedState("single")

			return
		end
	end

	arg_17_0.dropText_.text = GetTips("ALL")

	arg_17_0.choiceController:SetSelectedState("all")
end

function var_0_0.OnGroupSelect(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.selectIndex_ == arg_18_1 and not arg_18_2 then
		return
	end

	arg_18_0:ClickCurSuitListRedPoint()
	arg_18_0.descController:SetSelectedState("false")

	arg_18_0.selectIndex_ = arg_18_1
	arg_18_0.params_.index = arg_18_0.selectIndex_
	arg_18_0["item_" .. arg_18_0.selectIndex_ .. "Tgl_"].isOn = true
	arg_18_0.dataList_ = {}

	if arg_18_0.selectIndex_ == DormConst.DORM_SUIT_TYPE then
		arg_18_0.suitController:SetSelectedState("true")
		arg_18_0:SelectEditSuitSetType(arg_18_0.suitTypeIndex or 1)
	else
		arg_18_0.selItem_ = nil

		arg_18_0.suitController:SetSelectedState("false")

		if arg_18_0.furList then
			for iter_18_0, iter_18_1 in ipairs(arg_18_0.furList) do
				if BackHomeFurniture[iter_18_1.furID].type == arg_18_1 then
					table.insert(arg_18_0.dataList_, iter_18_1)
				end
			end
		end

		arg_18_0.scrollHelper_:StartScroll(#arg_18_0.dataList_)

		if arg_18_0.selIndex then
			arg_18_0.scrollHelper_:ScrollToIndex(arg_18_0.selIndex, true, false)
		end

		arg_18_0.redPointList = {}

		for iter_18_2, iter_18_3 in ipairs(arg_18_0.dataList_) do
			if iter_18_3.type == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
				table.insert(arg_18_0.redPointList, iter_18_3)
			end
		end

		DormRedPointTools:CloseDormFurRedPoint(arg_18_0.roomID, arg_18_0.selectIndex_, arg_18_0.redPointList)
	end
end

function var_0_0.indexItem(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0.selectIndex_ == DormConst.DORM_SUIT_TYPE then
		arg_19_2:RefreshUI(arg_19_0.dataList_[arg_19_1], arg_19_0.selItem_, DormEnum.FurItemType.SuitEdit, nil, arg_19_1, arg_19_0.suitTypeIndex)
	else
		arg_19_2:RefreshUI(arg_19_0.dataList_[arg_19_1], arg_19_0.selItem_, DormEnum.FurItemType.Edit, nil, arg_19_1)
	end

	arg_19_2:OnPointerDown(function(arg_20_0, arg_20_1, arg_20_2)
		arg_19_0.furType = arg_20_2

		if arg_20_2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace or DormSuitData:CheckIsSuit(arg_20_0) then
			arg_19_0.selItem_ = arg_20_0
			arg_19_0.selIndex = arg_20_1

			arg_19_0.scrollHelper_:Refresh()
			arg_19_0.descController:SetSelectedState("true")
		end

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_20_0) and arg_20_2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			JumpTools.OpenPageByJump("/furnitureEdit", {
				type = "drag",
				itemId = arg_20_0,
				itemType = arg_19_0.selItemType
			})
		else
			local var_20_0, var_20_1 = DormSuitData:CheckIsSuit(arg_20_0)

			if var_20_0 then
				DormRedPointTools:ClickSuitIconRedPoint(arg_20_0)

				if var_20_1 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
					DormSuitEditData:EnterFullSuitEditMode()
					DormFurnitureTools:SetEditFurFlag(true)
					DormSuitTools:GenerateFullSetFurSuit(arg_20_0)
					JumpTools.OpenPageByJump("/dormSuitFurInfoView", {
						suitID = arg_20_0
					})
				end
			end
		end
	end)
	arg_19_2:GrayCallBack(function(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
		local var_21_0, var_21_1 = DormSuitData:CheckIsSuit(arg_21_0)

		if var_21_0 then
			arg_19_0.selItem_ = arg_21_0

			arg_19_0.scrollHelper_:Refresh()

			if var_21_1 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
				DormSuitEditData:EnterFullSuitEditMode()
				DormSuitTools:GenerateFullSetFurSuit(arg_21_0)
				JumpTools.OpenPageByJump("/dormSuitFurInfoView", {
					suitID = arg_21_0
				})
			elseif var_21_1 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
				JumpTools.OpenPageByJump("dormPartSuitInfoPopView", {
					suitID = arg_21_0
				})
			end

			DormRedPointTools:ClickSuitIconRedPoint(arg_21_0)
		else
			local var_21_2 = BackHomeCfg[arg_19_0.roomID].type

			arg_19_0.selIndex = arg_21_1
			arg_19_0.params_.index = arg_19_0.selectIndex_

			if var_21_2 == DormConst.BACKHOME_TYPE.PublicDorm then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "gift",
					furID = arg_21_0
				})
			elseif var_21_2 == DormConst.BACKHOME_TYPE.PrivateDorm then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "gift",
					furID = arg_21_0
				})
			end
		end
	end)
	arg_19_2:ItemInfoCallBack(function(arg_22_0)
		arg_19_0.selItem_ = arg_22_0

		arg_19_0.scrollHelper_:Refresh()
		JumpTools.OpenPageByJump("dormPartSuitInfoPopView", {
			suitID = arg_22_0
		})
	end)
end

function var_0_0.AddUIListener(arg_23_0)
	arg_23_0:AddBtnListenerScale(arg_23_0.saveBtn_, nil, function()
		if DormData:GetDevModelFlag() then
			local function var_24_0(arg_25_0)
				if not string.isNullOrEmpty(arg_25_0) then
					DormSuitData:SetSuitSerializeData(arg_25_0)
					arg_23_0:SaveFurEditList()
				end
			end

			JumpTools.OpenPageByJump("dormChangeTemplateNameView", {
				showText = "",
				callBack = var_24_0
			})
		elseif SDKTools.IsSDK() then
			arg_23_0:PreSaveShot()
		else
			arg_23_0:SaveFurEditList()
		end
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.resetBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_EDIT_CLEAN"),
			OkCallback = function()
				DormFurnitureTools:SetEditFurFlag(true)
				DormFurEditStateData:RestoreRoomAllFurniture()
				DormFurnitureManager.GetInstance():ClearAndGenByFurList()
				arg_23_0:RefreshView(true)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.cancelBtn_, nil, function()
		if DormFurnitureTools:GetEditFurFlag() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_EDIT_CANCEL"),
				OkCallback = function()
					DormFurnitureTools:GenerateFurnitureWhenEnterScene()
					arg_23_0:BackToDormHomeView()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			arg_23_0:BackToDormHomeView()
		end
	end)

	for iter_23_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		arg_23_0:AddToggleListener(arg_23_0["item_" .. iter_23_0 .. "Tgl_"], function(arg_32_0)
			if arg_32_0 then
				arg_23_0:OnGroupSelect(iter_23_0)
			end
		end)
	end

	arg_23_0.uilistSrex_.ExitScrollArea:AddListener(function()
		if arg_23_0.selItem_ then
			if not DormFurnitureTools:GetIsOverLoad(arg_23_0.roomID) then
				ShowTips(GetTips("DORM_FURNITURE_SET_MAX"))

				return
			end

			local var_33_0 = false

			if DormSuitData:CheckIsSuit(arg_23_0.selItem_) then
				if DormSuitData:CheckSuitCanUseInRoom(arg_23_0.selItem_, arg_23_0.roomID) then
					var_33_0 = true
				end
			elseif arg_23_0.furType == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
				var_33_0 = true
			end

			if var_33_0 then
				JumpTools.OpenPageByJump("/furnitureEdit", {
					type = "drag",
					itemId = arg_23_0.selItem_,
					itemType = arg_23_0.selItemType
				})
				DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.PlaceFur)
			end
		end
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.filterbtn_, nil, function()
		if not arg_23_0.filterShow then
			arg_23_0.filterShow = true
		else
			arg_23_0.filterShow = false
		end

		arg_23_0:RefreshEditTypeSwichBar()
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.canPlacebtn_, nil, function()
		local var_35_0 = DormFurnitureTools:GetFurEditFlag()

		if var_35_0.canPlaceFlag then
			var_35_0.canPlaceFlag = false
		else
			var_35_0.canPlaceFlag = true
		end

		arg_23_0.selIndex = nil

		arg_23_0:RefreshView(true)
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.hadPlacebtn_, nil, function()
		local var_36_0 = DormFurnitureTools:GetFurEditFlag()

		if var_36_0.hadPlaceFlag then
			var_36_0.hadPlaceFlag = false
		else
			var_36_0.hadPlaceFlag = true
		end

		arg_23_0.selIndex = nil

		arg_23_0:RefreshView(true)
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.otherHadPlacebtn_, nil, function()
		local var_37_0 = DormFurnitureTools:GetFurEditFlag()

		if var_37_0.otherHadPlaceFlag then
			var_37_0.otherHadPlaceFlag = false
		else
			var_37_0.otherHadPlaceFlag = true
		end

		arg_23_0.selIndex = nil

		arg_23_0:RefreshView(true)
	end)
	arg_23_0:AddBtnListenerScale(arg_23_0.notPresentedbtn_, nil, function()
		local var_38_0 = DormFurnitureTools:GetFurEditFlag()

		if var_38_0.notPresentedFlag then
			var_38_0.notPresentedFlag = false
		else
			var_38_0.notPresentedFlag = true
		end

		arg_23_0.selIndex = nil

		arg_23_0:RefreshView(true)
	end)

	for iter_23_1 = 1, 2 do
		arg_23_0:AddToggleListener(arg_23_0["suitBtn" .. iter_23_1], function(arg_39_0)
			if arg_39_0 then
				arg_23_0:SelectEditSuitSetType(iter_23_1)
			end
		end)
	end

	for iter_23_2 = 1, 2 do
		arg_23_0:AddToggleListener(arg_23_0["stateBtn" .. iter_23_2], function(arg_40_0)
			if arg_40_0 then
				arg_23_0:OnSuitSetType(iter_23_2)
			end
		end)
	end
end

function var_0_0.BackToDormHomeView(arg_41_0)
	DormLuaBridge.ChangeCameraMode(0, true)
	gameContext:Go("/dorm")

	arg_41_0.selIndex = nil
	arg_41_0.suitTypeIndex = nil

	DormLuaBridge.SetIsCanEditTag(false)
	DormHeroTools:GenerateHeroWhenEnterScene()
	DormFurEditStateData:ExitEditState()
	DormFurnitureTools:SetEditFurFlag(nil)
	arg_41_0:ClickCurSuitListRedPoint()
end

function var_0_0.PreSaveShot(arg_42_0)
	SetForceShowQuanquan(true)

	arg_42_0.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_42_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_42_0) then
		var_42_0:CaptureSnapshot(arg_42_0.snapShot)
	end

	local var_42_1 = FrameTimer.New(function()
		local var_43_0 = manager.share:SaveRenderTextureByModule("room_edit", arg_42_0.snapShot)

		arg_42_0.snapShot:Release()

		arg_42_0.snapShot = nil

		SDKUploadImage("room_edit", var_43_0)
	end, 1, 1):Start()
end

function var_0_0.UploadImageSuccess(arg_44_0, arg_44_1)
	if arg_44_1.code == 1 then
		arg_44_0:SaveFurEditList(arg_44_1.url)
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function var_0_0.SaveFurEditList(arg_45_0, arg_45_1)
	local var_45_0, var_45_1, var_45_2 = DormFurEditStateData:GetHadPlaceFurInfoList()
	local var_45_3 = {
		furInfoList = var_45_0,
		specialInfo = var_45_1,
		suitInfo = var_45_2
	}

	DormAction:SetFurListInMap(arg_45_0.roomID, nil, var_45_3, arg_45_1)
	arg_45_0:BackToDormHomeView()
end

function var_0_0.SelectEditSuitSetType(arg_46_0, arg_46_1)
	arg_46_0:ClickCurSuitListRedPoint()

	arg_46_0["suitBtn" .. arg_46_1].isOn = true
	arg_46_0.suitTypeIndex = arg_46_1

	local var_46_0 = DormSuitData:GetCanUseFurSuitIDList(arg_46_0.roomID, arg_46_1)

	arg_46_0.dataList_ = {}

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		local var_46_1 = {
			type = DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace,
			furID = iter_46_1
		}

		table.insert(arg_46_0.dataList_, var_46_1)
	end

	arg_46_0.scrollHelper_:StartScroll(#arg_46_0.dataList_)

	if arg_46_0.selIndex then
		arg_46_0.scrollHelper_:ScrollToIndex(arg_46_0.selIndex, false, false)
	end
end

function var_0_0.ClickCurSuitListRedPoint(arg_47_0)
	if arg_47_0.selectIndex_ == DormConst.DORM_SUIT_TYPE and arg_47_0.dataList_ then
		for iter_47_0, iter_47_1 in ipairs(arg_47_0.dataList_) do
			DormRedPointTools:ClickSuitIconRedPoint(iter_47_1.furID)
		end
	end
end

function var_0_0.RefreshFurEditTypeController(arg_48_0)
	local var_48_0 = DormFurnitureTools:GetFurEditFlag()

	if var_48_0.otherHadPlaceFlag then
		arg_48_0.otherHadPlaceController:SetSelectedState("on")
	else
		arg_48_0.otherHadPlaceController:SetSelectedState("off")
	end

	if var_48_0.hadPlaceFlag then
		arg_48_0.hadPlaceController:SetSelectedState("on")
	else
		arg_48_0.hadPlaceController:SetSelectedState("off")
	end

	if var_48_0.canPlaceFlag then
		arg_48_0.canPlaceController:SetSelectedState("on")
	else
		arg_48_0.canPlaceController:SetSelectedState("off")
	end

	if var_48_0.notPresentedFlag then
		arg_48_0.notPresentedController:SetSelectedState("on")
	else
		arg_48_0.notPresentedController:SetSelectedState("off")
	end
end

function var_0_0.CheckFurNum(arg_49_0)
	local var_49_0

	if BackHomeCfg[arg_49_0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		var_49_0 = GameSetting.dorm_lobby_furniture_limited.value[1]
	else
		local var_49_1 = DormitoryData:GetDormLevel(arg_49_0.roomID)

		var_49_0 = BackHomeCfg[arg_49_0.roomID].load_max[var_49_1]
	end

	local var_49_2 = DormFurnitureTools:GetHasPlaceFurNumInfoInMap(arg_49_0.roomID) + DormFurEditStateData:GetCacheFurTotalNum() + DormConst.DORM_SPECIAL_FURNITURE_NUM

	if var_49_0 then
		if var_49_0 <= var_49_2 then
			return false
		else
			return true
		end
	end
end

function var_0_0.RefreshDevInfo(arg_50_0)
	if DormData:GetDevModelFlag() then
		arg_50_0.devController:SetSelectedState("edit")

		local var_50_0 = DormSuitData:GetSuitType()

		arg_50_0:OnSuitSetType(var_50_0)
	else
		arg_50_0.devController:SetSelectedState("player")
	end
end

function var_0_0.OnSuitSetType(arg_51_0, arg_51_1)
	arg_51_0["stateBtn" .. arg_51_1].isOn = true

	DormSuitData:SetSuitType(arg_51_1)
end

function var_0_0.Dispose(arg_52_0)
	if arg_52_0.scrollHelper_ then
		arg_52_0.scrollHelper_:Dispose()
	end

	arg_52_0.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	var_0_0.super.Dispose(arg_52_0)
end

return var_0_0
