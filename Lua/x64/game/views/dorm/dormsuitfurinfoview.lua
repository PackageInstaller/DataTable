local var_0_0 = class("DormSuitFurInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormSuitPreviewUI"
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
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.suitID = arg_6_0.params_.suitID
	arg_6_0.templateID = arg_6_0.params_.templateID

	arg_6_0:RefreshView()
	arg_6_0:RegisterEvents()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListenerScale(arg_8_0.useBtn_, nil, function()
		if arg_8_0.suitID then
			arg_8_0:UseSuit()
		elseif arg_8_0.templateID then
			arg_8_0:UseTemplate()
		end

		arg_8_0.params_.suitID = nil
		arg_8_0.params_.templateID = nil
	end)
	arg_8_0:AddBtnListenerScale(arg_8_0.cancelBtn_, nil, function()
		if arg_8_0.suitID then
			DormSuitEditData:RecoverSceneBeforeEdit()
		elseif arg_8_0.templateID then
			local var_10_0 = DormData:GetCurrectSceneID()

			DormFurnitureTemplateData:CancelPreviewDormSceneTemplate(var_10_0)
		end

		JumpTools.Back()

		arg_8_0.params_.suitID = nil
		arg_8_0.params_.templateID = nil
	end)
end

function var_0_0.UseSuit(arg_11_0)
	local var_11_0 = DormData:GetCurrectSceneID()

	if DormSuitData:CheckSuitCanUseInRoom(arg_11_0.suitID, var_11_0) then
		local var_11_1 = DormData:GetCurrectSceneID()
		local var_11_2 = DormSuitData:GetSuitFurInfo(arg_11_0.suitID)
		local var_11_3 = {
			furInfoList = var_11_2.furList,
			specialInfo = var_11_2.specialFur
		}

		if SDKTools.IsSDK() then
			local var_11_4 = {
				isSuit = true,
				curRoomID = var_11_1,
				data = var_11_3,
				suitID = arg_11_0.suitID
			}

			arg_11_0:PreSaveShot(var_11_4)
		else
			arg_11_0:SaveFurSuit(var_11_1, var_11_3, arg_11_0.suitID)
		end
	else
		ShowTips("DORM_SUIT_FURNTTURE_NUM_LACK")
	end
end

function var_0_0.UseTemplate(arg_12_0)
	local var_12_0 = DormData:GetCurrectSceneID()
	local var_12_1, var_12_2 = DormFurnitureTemplateData:CheckFurNumSuitTemplate(arg_12_0.templateID, var_12_0)

	if not var_12_1 then
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_MOULD_NOT_ENOUGH"),
			OkCallback = function()
				local var_13_0, var_13_1 = DormFurnitureTemplateData:ReduceTemplateLackFurInfoS(arg_12_0.templateID, var_12_2)

				DormFurnitureTools:GenFurListInCurRoom(var_13_0)
				DormSpecialFurnitureTools:ChangeDormFloorOrWallData(var_13_1)

				local var_13_2 = {
					furInfoList = var_13_0,
					specialInfo = var_13_1
				}

				if SDKTools.IsSDK() then
					local var_13_3 = {
						isSuit = false,
						templateID = arg_12_0.templateID,
						curRoomID = var_12_0,
						flag = var_12_1,
						furInfo = var_13_2
					}

					arg_12_0:PreSaveShot(var_13_3)
				else
					arg_12_0:SaveFurTemplet(arg_12_0.templateID, var_12_0, var_12_1, var_13_2)
				end
			end,
			CancelCallback = function()
				return
			end
		})
	elseif SDKTools.IsSDK() then
		local var_12_3 = {
			isSuit = false,
			templateID = arg_12_0.templateID,
			curRoomID = var_12_0,
			flag = var_12_1
		}

		arg_12_0:PreSaveShot(var_12_3)
	else
		arg_12_0:SaveFurTemplet(arg_12_0.templateID, var_12_0, var_12_1)
	end
end

function var_0_0.RefreshView(arg_15_0)
	arg_15_0:RefreshFurInfoList()

	if arg_15_0.params_.fromShop then
		SetActive(arg_15_0.useBtn_.gameObject, false)
	else
		SetActive(arg_15_0.useBtn_.gameObject, true)
	end
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0.scrollHelper_:Refresh()
end

function var_0_0.RegisterEvents(arg_17_0)
	arg_17_0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function(arg_18_0)
		if arg_17_0.selIndex then
			local var_18_0 = arg_17_0.scrollHelper_:GetItemByIndex(arg_17_0.selIndex)

			if var_18_0 == nil then
				return
			end

			if arg_17_0.suitID then
				var_18_0:RefreshUI(arg_17_0.furInfoList[arg_17_0.selIndex], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_17_0.selIndex)
			elseif arg_17_0.templateID then
				var_18_0:RefreshUI(arg_17_0.furInfoList[arg_17_0.selIndex], nil, DormEnum.FurItemType.TemplateShow, nil, arg_17_0.selIndex)
			end
		end
	end)
	arg_17_0:RegistEventListener(SDK_UPLOAD_IMG, function(arg_19_0)
		arg_17_0:UploadImageSuccess(arg_19_0)
	end)
end

function var_0_0.RefreshFurInfoList(arg_20_0)
	local var_20_0 = DormData:GetCurrectSceneID()

	arg_20_0.furInfoList = {}

	if arg_20_0.suitID then
		local var_20_1 = BackHomeSuitCfg[arg_20_0.suitID].suit_num

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			local var_20_2 = {
				furID = iter_20_1[1],
				suitID = arg_20_0.suitID
			}

			table.insert(arg_20_0.furInfoList, var_20_2)
		end

		arg_20_0.scrollHelper_:StartScroll(#arg_20_0.furInfoList)

		arg_20_0.suitName.text = ItemCfg[arg_20_0.suitID].name or ""
	elseif arg_20_0.templateID then
		local var_20_3 = DormFurnitureTemplateData:GetDormTemplateInfo(arg_20_0.templateID)
		local var_20_4 = var_20_3.furnitureInfoS
		local var_20_5 = {}

		for iter_20_2 = 0, var_20_4.Length - 1 do
			var_20_5[var_20_4[iter_20_2].id] = var_20_5[var_20_4[iter_20_2].id] or 0
			var_20_5[var_20_4[iter_20_2].id] = var_20_5[var_20_4[iter_20_2].id] + 1
		end

		local var_20_6 = var_20_3.specialFur

		for iter_20_3, iter_20_4 in pairs(var_20_6) do
			var_20_5[iter_20_4] = var_20_5[iter_20_4] or 0
			var_20_5[iter_20_4] = var_20_5[iter_20_4] + 1
		end

		for iter_20_5, iter_20_6 in pairs(var_20_5) do
			local var_20_7 = {
				furID = iter_20_5,
				needNum = iter_20_6
			}

			table.insert(arg_20_0.furInfoList, var_20_7)
		end

		arg_20_0.scrollHelper_:StartScroll(#arg_20_0.furInfoList)

		arg_20_0.suitName.text = var_20_3:GetTemplateName() or ""
	end
end

function var_0_0.indexItem(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.suitID then
		arg_21_2:RefreshUI(arg_21_0.furInfoList[arg_21_1], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_21_1)
	elseif arg_21_0.templateID then
		arg_21_2:RefreshUI(arg_21_0.furInfoList[arg_21_1], nil, DormEnum.FurItemType.TemplateShow, nil, arg_21_1)
	end

	arg_21_2:OnClickBtn(function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		local var_22_0 = DormData:GetFurNumInfo(arg_22_0)

		arg_21_0.selIndex = arg_22_1

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
			local var_22_3 = ShopListCfg[ShopConst.SHOP_ID.FURNITURE_SHOP].display_group

			for iter_22_0, iter_22_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_22_1].display_group == var_22_3 then
					table.insert(var_22_2, iter_22_1)
				end
			end

			local var_22_4 = getGoodListByGiveID(arg_22_0)
			local var_22_5 = false
			local var_22_6

			for iter_22_2, iter_22_3 in ipairs(var_22_4) do
				for iter_22_4, iter_22_5 in ipairs(var_22_2) do
					if ShopTools.IsGoodCanBuy(iter_22_5, iter_22_3) then
						var_22_5 = true

						local var_22_7 = iter_22_3

						break
					end
				end
			end

			if var_22_5 then
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
		arg_21_0.selIndex = arg_23_1

		JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
			state = "gift",
			furID = arg_23_0,
			needNum = arg_23_4,
			defaultNum = arg_23_4
		})
	end)
end

function var_0_0.SaveFurTemplet(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	DormFurnitureTemplateData:ConfirmUseTemplateInRoom(arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	JumpTools.OpenPageByJump("/dorm")
	DormFurEditStateData:ExitEditState()
	DormSuitEditData:ExitFullSuitEditMode()
	DormHeroTools:GenerateHeroWhenEnterScene()
	ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
end

function var_0_0.SaveFurSuit(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
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

function var_0_0.PreSaveShot(arg_26_0, arg_26_1)
	SetForceShowQuanquan(true)

	arg_26_0.tempShotCtx = arg_26_1
	arg_26_0.snapShot = UnityEngine.RenderTexture.New(math.floor(Screen.width / 4), math.floor(Screen.height / 4), 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_26_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

	if not isNil(var_26_0) then
		var_26_0:CaptureSnapshot(arg_26_0.snapShot)
	end

	local var_26_1 = FrameTimer.New(function()
		local var_27_0 = manager.share:SaveRenderTextureByModule("room_edit", arg_26_0.snapShot)

		arg_26_0.snapShot:Release()

		arg_26_0.snapShot = nil

		SDKUploadImage("room_edit", var_27_0)
	end, 1, 1):Start()
end

function var_0_0.UploadImageSuccess(arg_28_0, arg_28_1)
	if arg_28_1.code == 1 then
		if arg_28_0.tempShotCtx.isSuit then
			arg_28_0:SaveFurSuit(arg_28_0.tempShotCtx.curRoomID, arg_28_0.tempShotCtx.data, arg_28_0.tempShotCtx.suitID)
		else
			arg_28_0:SaveFurTemplet(arg_28_0.tempShotCtx.templateID, arg_28_0.tempShotCtx.curRoomID, arg_28_0.tempShotCtx.flag, arg_28_0.tempShotCtx.furInfo, arg_28_1.url)
		end

		arg_28_0.tempShotCtx = nil
	else
		ShowTips("IMAGE_UPLOAD_FAIL")
	end

	SetForceShowQuanquan(false)
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.scrollHelper_ then
		arg_29_0.scrollHelper_:Dispose()
	end

	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
