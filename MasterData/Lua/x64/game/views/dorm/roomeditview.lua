local RoomEditView = class("RoomEditView", ReduxView)

function RoomEditView:UIName()
	return "Widget/BackHouseUI/Dorm/DormEditstatusUI"
end

function RoomEditView:UIParent()
	return manager.ui.uiMain.transform
end

function RoomEditView:OnCtor()
	return
end

function RoomEditView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RoomEditView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FurnitureItem)
	self.choiceController = ControllerUtil.GetController(self.screeningswitchTrs_, "choice")
	self.switchController = ControllerUtil.GetController(self.screeningswitchTrs_, "switch")
	self.canPlaceController = ControllerUtil.GetController(self.canPlace.transform, "name")
	self.notPresentedController = ControllerUtil.GetController(self.notPresented.transform, "name")
	self.hadPlaceController = ControllerUtil.GetController(self.hadPlace.transform, "name")
	self.otherHadPlaceController = ControllerUtil.GetController(self.otherHadPlace.transform, "name")
	self.descController = ControllerUtil.GetController(self.transform_, "desc")
	self.descText.text = GetTips("DORM_FURNITURE_EDIT_INFO")
	self.devController = ControllerUtil.GetController(self.transform_, "devState")
	self.suitController = ControllerUtil.GetController(self.transform_, "suitPage")
end

function RoomEditView:OnEnter()
	self.roomID = DormData:GetCurrectSceneID()
	self.roomData = DormitoryData:GetDormSceneData(self.roomID)

	DormLuaBridge.ChangeCameraMode(1, true)
	DormLuaBridge.SetIsCanEditTag(true)

	self.selectIndex_ = self.params_.index or DormConst.FLOOR_TYPE_NUM
	self.params_.index = self.selectIndex_
	self.filterShow = false

	self:RegisterEvents()
	self:BindRedPoint()
end

function RoomEditView:OnTop()
	self:RefreshView(true)
end

function RoomEditView:OnExit()
	self:RemoveAllEventListener()
	self:UnBindRedPoint()
end

function RoomEditView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function()
		if self.scrollHelper_ then
			self:RefreshView(true)
		end
	end)
	self:RegistEventListener(SDK_UPLOAD_IMG, function(arg_11_0)
		self:UploadImageSuccess(arg_11_0)
	end)
end

function RoomEditView:BindRedPoint()
	for iter_12_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END - 1 do
		manager.redPoint:bindUIandKey(self["item_" .. iter_12_0 .. "icon"], string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(iter_12_0)))
	end

	manager.redPoint:bindUIandKey(self["item_" .. 28 .. "icon"], RedPointConst.DORM_SUIT)

	local var_12_0 = nullable(BackHomeCfg, self.roomID, "type")

	if var_12_0 == DormConst.BACKHOME_TYPE.PublicDorm then
		manager.redPoint:bindUIandKey(self.suitBtn1.transform, RedPointConst.DORM_FULL_PUBLIC_SUIT)
	elseif var_12_0 == DormConst.BACKHOME_TYPE.PrivateDorm then
		manager.redPoint:bindUIandKey(self.suitBtn1.transform, RedPointConst.DORM_FULL_PRIVATE_SUIT)
	end

	manager.redPoint:bindUIandKey(self.suitBtn2.transform, RedPointConst.DORM_PART_SUIT)
end

function RoomEditView:UnBindRedPoint()
	for iter_13_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END - 1 do
		manager.redPoint:unbindUIandKey(self["item_" .. iter_13_0 .. "icon"], string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(iter_13_0)))
	end

	manager.redPoint:unbindUIandKey(self["item_" .. 28 .. "icon"], RedPointConst.DORM_SUIT)

	if BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		manager.redPoint:unbindUIandKey(self.suitBtn1.transform, RedPointConst.DORM_FULL_PUBLIC_SUIT)
	elseif BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		manager.redPoint:unbindUIandKey(self.suitBtn1.transform, RedPointConst.DORM_FULL_PRIVATE_SUIT)
	end

	manager.redPoint:unbindUIandKey(self.suitBtn2.gameObject.transform, RedPointConst.DORM_PART_SUIT)

	if self.scrollHelper_ then
		for iter_13_1, iter_13_2 in pairs((self.scrollHelper_:GetItemList())) do
			manager.redPoint:unbindUIandKey(iter_13_2.transform_)
		end
	end
end

function RoomEditView:RefreshView(arg_14_1)
	self:InitRoomCanUseFurList()
	self:OnGroupSelect(self.selectIndex_, arg_14_1)
	self:UpdataHasPlaceFurNum()
	self:RefreshEditTypeSwichBar()
	self:RefreshDevInfo()
end

function RoomEditView:UpdataHasPlaceFurNum()
	self.curNum.text = DormFurnitureTools:GetHasPlaceFurNumInfoInMap(self.roomID) + DormFurEditStateData:GetCacheFurTotalNum() + DormConst.DORM_SPECIAL_FURNITURE_NUM

	local var_15_0 = 0

	if BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		var_15_0 = GameSetting.dorm_lobby_furniture_limited.value[1]
	elseif BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_15_0 = BackHomeDormLevel[DormitoryData:GetDormLevel(self.roomID)].furniture_max
	end

	self.totalNum.text = "/" .. var_15_0
end

function RoomEditView:InitRoomCanUseFurList()
	self.furList = {}

	local var_16_0 = DormFurnitureTools:GetFurEditFlag()

	if var_16_0.canPlaceFlag then
		self.canPlaceList = DormFurnitureTools:GetRoomCanPlaceFurList(self.roomID)

		for iter_16_0, iter_16_1 in ipairs(self.canPlaceList) do
			table.insert(self.furList, {
				furID = iter_16_1,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace
			})
		end
	end

	if var_16_0.notPresentedFlag then
		self.notPresentedList = DormFurnitureTools:GetNotPresentedFurInRoom(self.roomID)

		for iter_16_2, iter_16_3 in ipairs(self.notPresentedList) do
			table.insert(self.furList, {
				furID = iter_16_3,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented
			})
		end
	end

	if var_16_0.hadPlaceFlag then
		self.hadPlaceFurList = DormFurEditStateData:GetHadPlaceFurNumInRoom(self.roomID)

		for iter_16_4, iter_16_5 in ipairs(self.hadPlaceFurList) do
			table.insert(self.furList, {
				furID = iter_16_5,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace
			})
		end
	end

	if var_16_0.otherHadPlaceFlag then
		self.otherHadPlaceFurList = DormFurnitureTools:GetHadPlaceFlagFurInRoom(self.roomID)

		for iter_16_6, iter_16_7 in ipairs(self.otherHadPlaceFurList) do
			table.insert(self.furList, {
				furID = iter_16_7,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace
			})
		end
	end
end

function RoomEditView:RefreshEditTypeSwichBar()
	if self.filterShow then
		self.switchController:SetSelectedState("on")
		self:RefreshFurEditTypeController()
	else
		self.switchController:SetSelectedState("off")
	end

	local var_17_0 = DormFurnitureTools:GetFurEditFlag()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if not var_17_0[iter_17_0] then
			self.dropText_.text = GetTips("ROLE_FILTERING")

			self.choiceController:SetSelectedState("single")

			return
		end
	end

	self.dropText_.text = GetTips("ALL")

	self.choiceController:SetSelectedState("all")
end

function RoomEditView:OnGroupSelect(arg_18_1, arg_18_2)
	if self.selectIndex_ == arg_18_1 and not arg_18_2 then
		return
	end

	self:ClickCurSuitListRedPoint()
	self.descController:SetSelectedState("false")

	self.selectIndex_ = arg_18_1
	self.params_.index = self.selectIndex_
	self["item_" .. self.selectIndex_ .. "Tgl_"].isOn = true
	self.dataList_ = {}

	if self.selectIndex_ == DormConst.DORM_SUIT_TYPE then
		self.suitController:SetSelectedState("true")
		self:SelectEditSuitSetType(self.suitTypeIndex or 1)
	else
		self.selItem_ = nil

		self.suitController:SetSelectedState("false")

		if self.furList then
			for iter_18_0, iter_18_1 in ipairs(self.furList) do
				if BackHomeFurniture[iter_18_1.furID].type == arg_18_1 then
					table.insert(self.dataList_, iter_18_1)
				end
			end
		end

		self.scrollHelper_:StartScroll(#self.dataList_)

		if self.selIndex then
			self.scrollHelper_:ScrollToIndex(self.selIndex, true, false)
		end

		self.redPointList = {}

		for iter_18_2, iter_18_3 in ipairs(self.dataList_) do
			if iter_18_3.type == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
				table.insert(self.redPointList, iter_18_3)
			end
		end

		DormRedPointTools:CloseDormFurRedPoint(self.roomID, self.selectIndex_, self.redPointList)
	end
end

function RoomEditView:indexItem(arg_19_1, arg_19_2)
	if self.selectIndex_ == DormConst.DORM_SUIT_TYPE then
		arg_19_2:RefreshUI(self.dataList_[arg_19_1], self.selItem_, DormEnum.FurItemType.SuitEdit, nil, arg_19_1, self.suitTypeIndex)
	else
		arg_19_2:RefreshUI(self.dataList_[arg_19_1], self.selItem_, DormEnum.FurItemType.Edit, nil, arg_19_1)
	end

	arg_19_2:OnPointerDown(function(arg_20_0, arg_20_1, arg_20_2)
		self.furType = arg_20_2

		if arg_20_2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace or DormSuitData:CheckIsSuit(arg_20_0) then
			self.selItem_ = arg_20_0
			self.selIndex = arg_20_1

			self.scrollHelper_:Refresh()
			self.descController:SetSelectedState("true")
		end

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_20_0) and arg_20_2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			JumpTools.OpenPageByJump("/furnitureEdit", {
				type = "drag",
				itemId = arg_20_0,
				itemType = self.selItemType
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
			self.selItem_ = arg_21_0

			self.scrollHelper_:Refresh()

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
			local var_21_2 = BackHomeCfg[self.roomID].type

			self.selIndex = arg_21_1
			self.params_.index = self.selectIndex_

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
		self.selItem_ = arg_22_0

		self.scrollHelper_:Refresh()
		JumpTools.OpenPageByJump("dormPartSuitInfoPopView", {
			suitID = arg_22_0
		})
	end)
end

function RoomEditView:AddUIListener()
	self:AddBtnListenerScale(self.saveBtn_, nil, function()
		if DormData:GetDevModelFlag() then
			JumpTools.OpenPageByJump("dormChangeTemplateNameView", {
				showText = "",
				callBack = function(arg_25_0)
					if not string.isNullOrEmpty(arg_25_0) then
						DormSuitData:SetSuitSerializeData(arg_25_0)
						self:SaveFurEditList()
					end
				end
			})
		elseif SDKTools.IsSDK() then
			self:PreSaveShot()
		else
			self:SaveFurEditList()
		end
	end)
	self:AddBtnListenerScale(self.resetBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_EDIT_CLEAN"),
			OkCallback = function()
				DormFurnitureTools:SetEditFurFlag(true)
				DormFurEditStateData:RestoreRoomAllFurniture()
				DormFurnitureManager.GetInstance():ClearAndGenByFurList()
				self:RefreshView(true)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListenerScale(self.cancelBtn_, nil, function()
		if DormFurnitureTools:GetEditFurFlag() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_EDIT_CANCEL"),
				OkCallback = function()
					DormFurnitureTools:GenerateFurnitureWhenEnterScene()
					self:BackToDormHomeView()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			self:BackToDormHomeView()
		end
	end)

	for iter_23_0 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		self:AddToggleListener(self["item_" .. iter_23_0 .. "Tgl_"], function(arg_32_0)
			if arg_32_0 then
				self:OnGroupSelect(iter_23_0)
			end
		end)
	end

	self.uilistSrex_.ExitScrollArea:AddListener(function()
		if self.selItem_ then
			if not DormFurnitureTools:GetIsOverLoad(self.roomID) then
				ShowTips(GetTips("DORM_FURNITURE_SET_MAX"))

				return
			end

			local var_33_0 = false

			if DormSuitData:CheckIsSuit(self.selItem_) then
				if DormSuitData:CheckSuitCanUseInRoom(self.selItem_, self.roomID) then
					var_33_0 = true
				end
			elseif self.furType == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
				var_33_0 = true
			end

			if var_33_0 then
				JumpTools.OpenPageByJump("/furnitureEdit", {
					type = "drag",
					itemId = self.selItem_,
					itemType = self.selItemType
				})
				DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.PlaceFur)
			end
		end
	end)
	self:AddBtnListenerScale(self.filterbtn_, nil, function()
		self.filterShow = not self.filterShow

		self:RefreshEditTypeSwichBar()
	end)
	self:AddBtnListenerScale(self.canPlacebtn_, nil, function()
		local var_35_0 = DormFurnitureTools:GetFurEditFlag()

		var_35_0.canPlaceFlag = not var_35_0.canPlaceFlag
		self.selIndex = nil

		self:RefreshView(true)
	end)
	self:AddBtnListenerScale(self.hadPlacebtn_, nil, function()
		local var_36_0 = DormFurnitureTools:GetFurEditFlag()

		var_36_0.hadPlaceFlag = not var_36_0.hadPlaceFlag
		self.selIndex = nil

		self:RefreshView(true)
	end)
	self:AddBtnListenerScale(self.otherHadPlacebtn_, nil, function()
		local var_37_0 = DormFurnitureTools:GetFurEditFlag()

		var_37_0.otherHadPlaceFlag = not var_37_0.otherHadPlaceFlag
		self.selIndex = nil

		self:RefreshView(true)
	end)
	self:AddBtnListenerScale(self.notPresentedbtn_, nil, function()
		local var_38_0 = DormFurnitureTools:GetFurEditFlag()

		var_38_0.notPresentedFlag = not var_38_0.notPresentedFlag
		self.selIndex = nil

		self:RefreshView(true)
	end)

	for iter_23_1 = 1, 2 do
		self:AddToggleListener(self["suitBtn" .. iter_23_1], function(arg_39_0)
			if arg_39_0 then
				self:SelectEditSuitSetType(iter_23_1)
			end
		end)
	end

	for iter_23_2 = 1, 2 do
		self:AddToggleListener(self["stateBtn" .. iter_23_2], function(arg_40_0)
			if arg_40_0 then
				self:OnSuitSetType(iter_23_2)
			end
		end)
	end
end

function RoomEditView:BackToDormHomeView()
	DormLuaBridge.ChangeCameraMode(0, true)
	gameContext:Go("/dorm")

	self.selIndex = nil
	self.suitTypeIndex = nil

	DormLuaBridge.SetIsCanEditTag(false)
	DormHeroTools:GenerateHeroWhenEnterScene()
	DormFurEditStateData:ExitEditState()
	DormFurnitureTools:SetEditFurFlag(nil)
	self:ClickCurSuitListRedPoint()
end

function RoomEditView:PreSaveShot()
	SetForceShowQuanquan(true)

	self.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_42_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_42_0) then
		var_42_0:CaptureSnapshot(self.snapShot)
	end

	local var_42_1 = FrameTimer.New(function()
		self.snapShot:Release()

		self.snapShot = nil

		SDKUploadImage("room_edit", (manager.share:SaveRenderTextureByModule("room_edit", self.snapShot)))
	end, 1, 1):Start()
end

function RoomEditView:UploadImageSuccess(arg_44_1)
	if arg_44_1.code == 1 then
		self:SaveFurEditList(arg_44_1.url)
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function RoomEditView:SaveFurEditList(arg_45_1)
	local var_45_0, var_45_1, var_45_2 = DormFurEditStateData:GetHadPlaceFurInfoList()

	DormAction:SetFurListInMap(self.roomID, nil, {
		furInfoList = var_45_0,
		specialInfo = var_45_1,
		suitInfo = var_45_2
	}, arg_45_1)
	self:BackToDormHomeView()
end

function RoomEditView:SelectEditSuitSetType(arg_46_1)
	self:ClickCurSuitListRedPoint()

	self["suitBtn" .. arg_46_1].isOn = true
	self.suitTypeIndex = arg_46_1
	self.dataList_ = {}

	for iter_46_0, iter_46_1 in ipairs((DormSuitData:GetCanUseFurSuitIDList(self.roomID, arg_46_1))) do
		table.insert(self.dataList_, {
			type = DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace,
			furID = iter_46_1
		})
	end

	self.scrollHelper_:StartScroll(#self.dataList_)

	if self.selIndex then
		self.scrollHelper_:ScrollToIndex(self.selIndex, false, false)
	end
end

function RoomEditView:ClickCurSuitListRedPoint()
	if self.selectIndex_ == DormConst.DORM_SUIT_TYPE and self.dataList_ then
		for iter_47_0, iter_47_1 in ipairs(self.dataList_) do
			DormRedPointTools:ClickSuitIconRedPoint(iter_47_1.furID)
		end
	end
end

function RoomEditView:RefreshFurEditTypeController()
	local var_48_0 = DormFurnitureTools:GetFurEditFlag()

	if var_48_0.otherHadPlaceFlag then
		self.otherHadPlaceController:SetSelectedState("on")
	else
		self.otherHadPlaceController:SetSelectedState("off")
	end

	if var_48_0.hadPlaceFlag then
		self.hadPlaceController:SetSelectedState("on")
	else
		self.hadPlaceController:SetSelectedState("off")
	end

	if var_48_0.canPlaceFlag then
		self.canPlaceController:SetSelectedState("on")
	else
		self.canPlaceController:SetSelectedState("off")
	end

	if var_48_0.notPresentedFlag then
		self.notPresentedController:SetSelectedState("on")
	else
		self.notPresentedController:SetSelectedState("off")
	end
end

function RoomEditView:CheckFurNum()
	local var_49_0 = BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm and GameSetting.dorm_lobby_furniture_limited.value[1] or BackHomeCfg[self.roomID].load_max[DormitoryData:GetDormLevel(self.roomID)]

	if var_49_0 then
		if var_49_0 <= DormFurnitureTools:GetHasPlaceFurNumInfoInMap(self.roomID) + DormFurEditStateData:GetCacheFurTotalNum() + DormConst.DORM_SPECIAL_FURNITURE_NUM then
			return false
		else
			return true
		end
	end
end

function RoomEditView:RefreshDevInfo()
	if DormData:GetDevModelFlag() then
		self.devController:SetSelectedState("edit")
		self:OnSuitSetType((DormSuitData:GetSuitType()))
	else
		self.devController:SetSelectedState("player")
	end
end

function RoomEditView:OnSuitSetType(arg_51_1)
	self["stateBtn" .. arg_51_1].isOn = true

	DormSuitData:SetSuitType(arg_51_1)
end

function RoomEditView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()
	end

	self.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	RoomEditView.super.Dispose(self)
end

return RoomEditView
