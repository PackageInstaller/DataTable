local DormSuitFurInfoView = class("DormSuitFurInfoView", ReduxView)

function DormSuitFurInfoView:UIName()
	return "Widget/BackHouseUI/Dorm/DormSuitPreviewUI"
end

function DormSuitFurInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function DormSuitFurInfoView:OnCtor()
	return
end

function DormSuitFurInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormSuitFurInfoView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, FurnitureItem)
end

function DormSuitFurInfoView:OnEnter()
	self.suitID = self.params_.suitID
	self.templateID = self.params_.templateID

	self:RefreshView()
	self:RegisterEvents()
end

function DormSuitFurInfoView:OnExit()
	self:RemoveAllEventListener()
end

function DormSuitFurInfoView:AddUIListener()
	self:AddBtnListenerScale(self.useBtn_, nil, function()
		if self.suitID then
			self:UseSuit()
		elseif self.templateID then
			self:UseTemplate()
		end

		self.params_.suitID = nil
		self.params_.templateID = nil
	end)
	self:AddBtnListenerScale(self.cancelBtn_, nil, function()
		if self.suitID then
			DormSuitEditData:RecoverSceneBeforeEdit()
		elseif self.templateID then
			DormFurnitureTemplateData:CancelPreviewDormSceneTemplate((DormData:GetCurrectSceneID()))
		end

		JumpTools.Back()

		self.params_.suitID = nil
		self.params_.templateID = nil
	end)
end

function DormSuitFurInfoView:UseSuit()
	if DormSuitData:CheckSuitCanUseInRoom(self.suitID, (DormData:GetCurrectSceneID())) then
		local var_11_0 = DormData:GetCurrectSceneID()
		local var_11_1 = DormSuitData:GetSuitFurInfo(self.suitID)
		local var_11_2 = {
			furInfoList = var_11_1.furList,
			specialInfo = var_11_1.specialFur
		}

		if SDKTools.IsSDK() then
			self:PreSaveShot({
				isSuit = true,
				curRoomID = var_11_0,
				data = var_11_2,
				suitID = self.suitID
			})
		else
			self:SaveFurSuit(var_11_0, var_11_2, self.suitID)
		end
	else
		ShowTips("DORM_SUIT_FURNTTURE_NUM_LACK")
	end
end

function DormSuitFurInfoView:UseTemplate()
	local var_12_0 = DormData:GetCurrectSceneID()
	local var_12_1, var_12_2 = DormFurnitureTemplateData:CheckFurNumSuitTemplate(self.templateID, var_12_0)

	if not var_12_1 then
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_MOULD_NOT_ENOUGH"),
			OkCallback = function()
				local var_13_0, var_13_1 = DormFurnitureTemplateData:ReduceTemplateLackFurInfoS(self.templateID, var_12_2)

				DormFurnitureTools:GenFurListInCurRoom(var_13_0)
				DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_13_1)

				local var_13_2 = {
					furInfoList = var_13_0,
					specialInfo = var_13_1
				}

				if SDKTools.IsSDK() then
					self:PreSaveShot({
						isSuit = false,
						templateID = self.templateID,
						curRoomID = var_12_0,
						flag = var_12_1,
						furInfo = var_13_2
					})
				else
					self:SaveFurTemplet(self.templateID, var_12_0, var_12_1, var_13_2)
				end
			end,
			CancelCallback = function()
				return
			end
		})
	elseif SDKTools.IsSDK() then
		self:PreSaveShot({
			isSuit = false,
			templateID = self.templateID,
			curRoomID = var_12_0,
			flag = var_12_1
		})
	else
		self:SaveFurTemplet(self.templateID, var_12_0, var_12_1)
	end
end

function DormSuitFurInfoView:RefreshView()
	self:RefreshFurInfoList()

	if self.params_.fromShop then
		SetActive(self.useBtn_.gameObject, false)
	else
		SetActive(self.useBtn_.gameObject, true)
	end
end

function DormSuitFurInfoView:OnTop()
	self.scrollHelper_:Refresh()
end

function DormSuitFurInfoView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function(arg_18_0)
		if self.selIndex then
			local var_18_0 = self.scrollHelper_:GetItemByIndex(self.selIndex)

			if var_18_0 == nil then
				return
			end

			if self.suitID then
				var_18_0:RefreshUI(self.furInfoList[self.selIndex], nil, DormEnum.FurItemType.SuitFurShow, nil, self.selIndex)
			elseif self.templateID then
				var_18_0:RefreshUI(self.furInfoList[self.selIndex], nil, DormEnum.FurItemType.TemplateShow, nil, self.selIndex)
			end
		end
	end)
	self:RegistEventListener(SDK_UPLOAD_IMG, function(arg_19_0)
		self:UploadImageSuccess(arg_19_0)
	end)
end

function DormSuitFurInfoView:RefreshFurInfoList()
	local var_20_0 = DormData:GetCurrectSceneID()

	self.furInfoList = {}

	if self.suitID then
		for iter_20_0, iter_20_1 in ipairs(BackHomeSuitCfg[self.suitID].suit_num) do
			table.insert(self.furInfoList, {
				furID = iter_20_1[1],
				suitID = self.suitID
			})
		end

		self.scrollHelper_:StartScroll(#self.furInfoList)

		self.suitName.text = ItemCfg[self.suitID].name or ""
	elseif self.templateID then
		local var_20_1 = DormFurnitureTemplateData:GetDormTemplateInfo(self.templateID)
		local var_20_2 = {}

		for iter_20_2 = 0, var_20_1.furnitureInfoS.Length - 1 do
			var_20_2[var_20_1.furnitureInfoS[iter_20_2].id] = var_20_2[var_20_1.furnitureInfoS[iter_20_2].id] or 0
			var_20_2[var_20_1.furnitureInfoS[iter_20_2].id] = var_20_2[var_20_1.furnitureInfoS[iter_20_2].id] + 1
		end

		for iter_20_3, iter_20_4 in pairs(var_20_1.specialFur) do
			var_20_2[iter_20_4] = var_20_2[iter_20_4] or 0
			var_20_2[iter_20_4] = var_20_2[iter_20_4] + 1
		end

		for iter_20_5, iter_20_6 in pairs(var_20_2) do
			table.insert(self.furInfoList, {
				furID = iter_20_5,
				needNum = iter_20_6
			})
		end

		self.scrollHelper_:StartScroll(#self.furInfoList)

		self.suitName.text = var_20_1:GetTemplateName() or ""
	end
end

function DormSuitFurInfoView:indexItem(arg_21_1, arg_21_2)
	if self.suitID then
		arg_21_2:RefreshUI(self.furInfoList[arg_21_1], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_21_1)
	elseif self.templateID then
		arg_21_2:RefreshUI(self.furInfoList[arg_21_1], nil, DormEnum.FurItemType.TemplateShow, nil, arg_21_1)
	end

	arg_21_2:OnClickBtn(function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		local var_22_0 = DormData:GetFurNumInfo(arg_22_0)

		self.selIndex = arg_22_1

		local var_22_1 = 0

		if arg_22_3 == "enough" then
			if var_22_0 then
				var_22_1 = var_22_0.num
			end

			ShowPopItem(POP_ITEM, {
				arg_22_0,
				var_22_1
			})
		elseif arg_22_3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = arg_22_0,
				needNum = arg_22_4,
				defaultNum = arg_22_4
			})
		elseif arg_22_3 == "noEnough" then
			local var_22_2 = {}

			for iter_22_0, iter_22_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_22_1].display_group == ShopListCfg[ShopConst.SHOP_ID.FURNITURE_SHOP].display_group then
					table.insert(var_22_2, iter_22_1)
				end
			end

			local var_22_3 = false

			for iter_22_2, iter_22_3 in ipairs((getGoodListByGiveID(arg_22_0))) do
				for iter_22_4, iter_22_5 in ipairs(var_22_2) do
					if ShopTools.IsGoodCanBuy(iter_22_5, iter_22_3) then
						var_22_3 = true

						break
					end
				end
			end

			if var_22_3 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = arg_22_0,
					needNum = arg_22_4,
					defaultNum = arg_22_4
				})
			else
				ShowPopItem(POP_ITEM, {
					arg_22_0,
					var_22_1
				})
			end
		end
	end)
	arg_21_2:GrayCallBack(function(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		self.selIndex = arg_23_1

		JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
			state = "gift",
			furID = arg_23_0,
			needNum = arg_23_4,
			defaultNum = arg_23_4
		})
	end)
end

function DormSuitFurInfoView:SaveFurTemplet(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	DormFurnitureTemplateData:ConfirmUseTemplateInRoom(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	JumpTools.OpenPageByJump("/dorm")
	DormFurEditStateData:ExitEditState()
	DormSuitEditData:ExitFullSuitEditMode()
	DormHeroTools:GenerateHeroWhenEnterScene()
	ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
end

function DormSuitFurInfoView:SaveFurSuit(arg_25_1, arg_25_2, arg_25_3)
	DormAction:SetFurListInMap(arg_25_1, nil, arg_25_2)
	DormLuaBridge.ChangeCameraMode(0, true)
	DormFurEditStateData:ExitEditState()
	DormSuitEditData:ExitFullSuitEditMode()
	DormHeroTools:GenerateHeroWhenEnterScene()
	JumpTools.OpenPageByJump("/dorm")
	SDKTools.SendMessageToSDK("backhome_dorm_edit", {
		suit_list = {
			arg_25_3
		}
	})
	ShowTips("DORM_SUIT_USE_SUCCEED")
end

function DormSuitFurInfoView:PreSaveShot(arg_26_1)
	SetForceShowQuanquan(true)

	self.tempShotCtx = arg_26_1
	self.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_26_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_26_0) then
		var_26_0:CaptureSnapshot(self.snapShot)
	end

	local var_26_1 = FrameTimer.New(function()
		self.snapShot:Release()

		self.snapShot = nil

		SDKUploadImage("room_edit", (manager.share:SaveRenderTextureByModule("room_edit", self.snapShot)))
	end, 1, 1):Start()
end

function DormSuitFurInfoView:UploadImageSuccess(arg_28_1)
	if arg_28_1.code == 1 then
		if self.tempShotCtx.isSuit then
			self:SaveFurSuit(self.tempShotCtx.curRoomID, self.tempShotCtx.data, self.tempShotCtx.suitID)
		else
			self:SaveFurTemplet(self.tempShotCtx.templateID, self.tempShotCtx.curRoomID, self.tempShotCtx.flag, self.tempShotCtx.furInfo, arg_28_1.url)
		end

		self.tempShotCtx = nil
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function DormSuitFurInfoView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()
	end

	DormSuitFurInfoView.super.Dispose(self)
end

return DormSuitFurInfoView
