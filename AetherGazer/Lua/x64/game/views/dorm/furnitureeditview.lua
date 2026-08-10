local var_0_0 = class("FurnitureEditView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/FurnitureEditorUI"
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

	arg_5_0.rotateController_ = ControllerUtil.GetController(arg_5_0.transform_, "rotate")
	arg_5_0.storageController_ = ControllerUtil.GetController(arg_5_0.transform_, "storage")
	arg_5_0.suitController = ControllerUtil.GetController(arg_5_0.transform_, "suit")
	arg_5_0.canResetController = ControllerUtil.GetController(arg_5_0.transform_, "canReset")
	arg_5_0.furDescController = ControllerUtil.GetController(arg_5_0.transform_, "descState")
end

function var_0_0.OnEnter(arg_6_0)
	if arg_6_0.params_.isBack == true then
		arg_6_0.gotoPreview_ = true
	end

	DormFurnitureTools:SetEditFurFlag(true)

	arg_6_0.roomID = DormData:GetCurrectSceneID()
	arg_6_0.itemID = arg_6_0.params_.itemId
	arg_6_0.furEntityID = arg_6_0.params_.furEntityID

	local var_6_0 = DormFurnitureManager.GetInstance()

	if arg_6_0.params_.type == "drag" then
		if not arg_6_0.params_.isBack then
			local var_6_1, var_6_2 = DormSuitData:CheckIsSuit(arg_6_0.itemID)

			if var_6_1 then
				local var_6_3 = DormSuitTools:GenerateFurSuit(arg_6_0.itemID)

				DormLuaBridge.ChangeFurnitureSuitState(var_6_3, DormFurnitureManager.FurnitureState.Editing, false)
				DormLuaBridge.AddFurnitureToWallDitherAlphaControl(var_6_3)
				DormLuaBridge.BeginDragFurniture(var_6_3)
				arg_6_0:EnterSuitEditMode(var_6_3, false)
			elseif DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_6_0.itemID) then
				DormLuaBridge.SetIsCanEditTag(false)
				DormSpecialFurnitureTools:ChangeDormSpeicalFur(arg_6_0.itemID)
			else
				local var_6_4 = var_6_0:Generate(arg_6_0.itemID)

				DormLuaBridge.ChangeFurnitureState(var_6_4, DormFurnitureManager.FurnitureState.Editing)
				DormLuaBridge.AddFurnitureToWallDitherAlphaControl(var_6_4)
				DormLuaBridge.BeginDragFurniture(var_6_4)

				arg_6_0.furEntityID = var_6_4
				arg_6_0.originalSelFurnitureEID = var_6_4

				arg_6_0:HightlightAllFurnitureInSuit(true)
			end
		end
	elseif arg_6_0.params_.type == "edit" then
		arg_6_0.originalSelFurnitureEID = arg_6_0.furEntityID

		arg_6_0:HightlightAllFurnitureInSuit(true)
	end

	arg_6_0:RefreshFurInfo()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0.gotoPreview_ = false

	if arg_7_0.cacheBlend then
		manager.ui.mainCamera:GetComponent("CinemachineBrain").m_DefaultBlend = arg_7_0.cacheBlend
	end

	arg_7_0.cacheBlend = manager.ui.mainCamera:GetComponent("CinemachineBrain").m_DefaultBlend

	arg_7_0:RegisterEvents()
end

function var_0_0.EnterSuitEditMode(arg_8_0, arg_8_1, arg_8_2)
	if DormLuaBridge.CheckSuitEditModeAvailabel(arg_8_1) then
		DormLuaBridge.EnterSuitEditMode(arg_8_1, arg_8_2)

		return true
	end

	return false
end

function var_0_0.RegisterEvents(arg_9_0)
	arg_9_0:RegistEventListener(DORM_ENTER_SUIT_EDIT_MODE, function(arg_10_0, arg_10_1, arg_10_2)
		arg_9_0:HightlightAllFurnitureInSuit(false)

		arg_9_0.itemID = arg_10_0
		arg_9_0.originalSelFurnitureEID = arg_9_0.furEntityID
		arg_9_0.furEntityID = arg_10_1
		arg_9_0.suitOriID = arg_10_2
		arg_9_0.params_.furSuitEid = nil

		arg_9_0:RefreshFurInfo()
	end)
	arg_9_0:RegistEventListener(DORM_EXIT_SUIT_EDIT_MODE, function(arg_11_0)
		arg_9_0.furEntityID = nil
	end)
end

function var_0_0.RefreshFurInfo(arg_12_0)
	local var_12_0 = ItemCfg[arg_12_0.itemID]
	local var_12_1, var_12_2 = DormSuitData:CheckIsSuit(arg_12_0.itemID)

	if var_12_1 then
		arg_12_0.furDescController:SetSelectedState("suit")

		arg_12_0.furnameText_.text = GetTips("DORM_EDIT_TIPS_2")
	else
		arg_12_0.furDescController:SetSelectedState("single")

		if var_12_0 then
			arg_12_0.furnameText_.text = ItemTools.getItemName(arg_12_0.itemID)
		end
	end

	arg_12_0:ShowCanUseButton()
end

local function var_0_1(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = DormLuaBridge.CheckFurnitureBelongSuit(arg_13_0, nil)

	for iter_13_0, iter_13_1 in pairs(DormFurnitureManager.GetInstance():GetAllFurniture()) do
		if arg_13_0 ~= iter_13_1 then
			local var_13_2, var_13_3 = DormLuaBridge.CheckFurnitureBelongSuit(iter_13_1, nil)

			if var_13_0 then
				if var_13_2 and var_13_1 == var_13_3 then
					local var_13_4 = arg_13_2 or DormEnum.HighlightLayer.Suit

					var_13_4 = arg_13_1 and var_13_4 or DormEnum.HighlightLayer.Available

					Dorm.DormEntityManager.SetHighlighted(iter_13_1, arg_13_1, var_13_4)
				end
			else
				Dorm.DormEntityManager.SetHighlighted(iter_13_1, false)
			end
		end
	end
end

function var_0_0.OnExit(arg_14_0)
	if not arg_14_0.gotoPreview_ then
		arg_14_0:HightlightAllFurnitureInSuit(false)

		arg_14_0.params_.type = nil
		arg_14_0.suitOriID = nil
		arg_14_0.cacheCustomFur = nil
		arg_14_0.originalSelFurnitureEID = nil

		DormLuaBridge.ClearEditingFurniture()
	end

	arg_14_0.gotoPreview_ = false

	arg_14_0:RemoveAllEventListener()
end

function var_0_0.HightlightAllFurnitureInSuit(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.originalSelFurnitureEID then
		var_0_1(arg_15_0.originalSelFurnitureEID, arg_15_1, arg_15_2)
	end
end

function var_0_0.AddUIListener(arg_16_0)
	arg_16_0:AddBtnListenerScale(arg_16_0.cancelBtn_, nil, function()
		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_16_0.itemID) then
			local var_17_0 = BackHomeFurniture[arg_16_0.itemID]
			local var_17_1 = DormData:GetCurrectSceneID()
			local var_17_2 = DormFurEditStateData:GetCacheWallAndFloorInfo(var_17_0.type) or DormSpecialFurnitureTools:GetSpecialFurIDByRoom(var_17_1, var_17_0.type)

			DormSpecialFurnitureTools:ChangeDormSpeicalFur(var_17_2)
		else
			local var_17_3, var_17_4 = DormSuitData:CheckIsSuit(arg_16_0.itemID)
			local var_17_5
			local var_17_6

			if var_17_3 then
				var_17_5, var_17_6 = DormLuaBridge.CancelSuitChange(nil)
			else
				var_17_5, var_17_6 = DormLuaBridge.CancelChange(nil)
			end

			if var_17_5 then
				if var_17_3 then
					arg_16_0:RemoveFurnitureSuit(var_17_6)
				else
					DormUtils.GetEntityData(var_17_6).noOccupy = true

					arg_16_0:RemoveFurniture(var_17_6)
				end
			elseif arg_16_0.params_.type == "edit" and not var_17_3 and arg_16_0.itemID then
				DormLuaBridge.RecoverRoomFurnitureOccupyByLua(arg_16_0.furEntityID)
			end
		end

		JumpTools.Back()
	end)
	arg_16_0:AddBtnListenerScale(arg_16_0.rotateBtn_, nil, function()
		local var_18_0, var_18_1 = DormSuitData:CheckIsSuit(arg_16_0.itemID)

		if var_18_0 then
			DormLuaBridge.RotateSuitFurniture()
		else
			DormLuaBridge.RotateFurniture()
		end
	end)
	arg_16_0:AddBtnListenerScale(arg_16_0.saveBtn_, nil, function()
		if not arg_16_0:CheckFurOccurpy() then
			ShowTips(GetTips("DORM_FUR_VOLUME_MAX"))

			return
		end

		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_16_0.itemID) then
			local var_19_0, var_19_1 = DormSuitData:CheckIsSuit(arg_16_0.itemID)
			local var_19_2

			if var_19_0 then
				var_19_2 = DormLuaBridge.SaveSuitChange()
			else
				var_19_2 = DormLuaBridge.SaveChange()
			end

			if var_19_2 then
				if arg_16_0.params_.type == "drag" then
					if var_19_0 then
						DormFurEditStateData:ReveseFurSuitNumInEidtRoom(arg_16_0.itemID, 1)
					else
						DormFurEditStateData:ReviseFurNumInEditRoom(arg_16_0.itemID, 1)
					end
				end

				JumpTools.Back()
			else
				ShowTips("DORM_FURNITURE_CANNOT_SET")
			end
		else
			if arg_16_0.params_.type == "drag" then
				local var_19_3 = BackHomeFurniture[arg_16_0.itemID]
				local var_19_4 = DormFurEditStateData:GetCacheWallAndFloorInfo(var_19_3.type) or DormSpecialFurnitureTools:GetSpecialFurIDByRoom(arg_16_0.roomID, var_19_3.type)

				DormFurEditStateData:ReviseFurNumInEditRoom(arg_16_0.itemID, 1)
				DormFurEditStateData:ReviseFurNumInEditRoom(var_19_4, -1)
			end

			JumpTools.Back()
		end
	end)
	arg_16_0:AddBtnListenerScale(arg_16_0.storageBtn_, nil, function()
		local var_20_0
		local var_20_1
		local var_20_2, var_20_3 = DormSuitData:CheckIsSuit(arg_16_0.itemID)

		if not var_20_2 and arg_16_0.params_.furSuitEid then
			ShowMessageBox({
				content = GetTips("DORM_STORAGE_CANT_SUIT"),
				OkCallback = function()
					var_20_0 = DormLuaBridge.StorageFurniture()

					DormSuitTools:RelieveSuit(arg_16_0.params_.furSuitEid)

					if var_20_0 ~= Dorm.DormEntityManager.INVALID_ENTITY_ID then
						DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(var_20_0)

						DormUtils.GetEntityData(var_20_0).noOccupy = true

						arg_16_0:RemoveFurniture(var_20_0)
					end

					if arg_16_0.params_.type == "edit" then
						DormFurEditStateData:ReviseFurNumInEditRoom(arg_16_0.itemID, -1)
					end

					arg_16_0.params_.furSuitEid = nil

					JumpTools.Back()
				end,
				CancelCallback = function()
					return
				end
			})
		elseif var_20_2 then
			ShowMessageBox({
				content = GetTips("DORM_STORAGE_SUIT"),
				OkCallback = function()
					var_20_0 = DormLuaBridge.StorageSuitFurniture(nil)

					arg_16_0:RemoveFurnitureSuit(var_20_0, arg_16_0.params_.type == "edit")
					JumpTools.Back()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			var_20_0 = DormLuaBridge.StorageFurniture()

			if var_20_0 >= 0 then
				DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(var_20_0)

				DormUtils.GetEntityData(var_20_0).noOccupy = true

				arg_16_0:RemoveFurniture(var_20_0)
			end

			if arg_16_0.params_.type == "edit" then
				DormFurEditStateData:ReviseFurNumInEditRoom(arg_16_0.itemID, -1)

				arg_16_0.cacheCustomFur = arg_16_0.itemID
			end

			JumpTools.Back()
		end
	end)
	arg_16_0:AddBtnListener(arg_16_0.infoBtn_, nil, function()
		if arg_16_0.itemID and arg_16_0.itemID > 0 and ItemCfg[arg_16_0.itemID] then
			arg_16_0.gotoPreview_ = true

			ShowPopItem(POP_ITEM, {
				arg_16_0.itemID
			})
		end
	end)
	arg_16_0:AddBtnListener(arg_16_0.enterSuit, nil, function()
		if arg_16_0:EnterSuitEditMode(arg_16_0.furEntityID, true) then
			arg_16_0:HightlightAllFurnitureInSuit(true, DormEnum.HighlightLayer.Available)
		else
			ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
		end
	end)
	arg_16_0:AddBtnListener(arg_16_0.relievesuitBtn_, nil, function()
		if arg_16_0.furEntityID then
			if DormLuaBridge.GetSuitOrFurnitureCanPlace(arg_16_0.furEntityID) then
				ShowMessageBox({
					content = GetTips("DORM_FURNITURE_SUIT_EDIT_INFO"),
					OkCallback = function()
						DormSuitTools:RelieveSuit(arg_16_0.furEntityID)
						JumpTools.Back()
					end,
					CancelCallback = function()
						return
					end
				})
			else
				ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
			end
		end
	end)
	arg_16_0:AddBtnListener(arg_16_0.resetsuitBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("DORM_SUTI_RESET"),
			OkCallback = function()
				DormSuitEditData:ResetSuitPosition(arg_16_0.furEntityID, arg_16_0.itemID)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_16_0:AddBtnListener(arg_16_0.customsuitBtn_, nil, function()
		if DormLuaBridge.CheckSuitEditModeAvailabel(arg_16_0.furEntityID) then
			DormLuaBridge.EnterCustomeEditMode(arg_16_0.furEntityID)
		else
			ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
		end
	end)
end

function var_0_0.RemoveFurniture(arg_34_0, arg_34_1)
	if arg_34_0.originalSelFurnitureEID == arg_34_1 then
		arg_34_0:HightlightAllFurnitureInSuit(false)

		arg_34_0.originalSelFurnitureEID = nil
	end

	DormFurnitureManager.GetInstance().FindAndRemove(arg_34_1)
end

function var_0_0.RemoveFurnitureSuit(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_0.originalSelFurnitureEID then
		local var_35_0, var_35_1 = DormLuaBridge.CheckFurnitureBelongSuit(arg_35_0.originalSelFurnitureEID, nil)

		if var_35_1 == arg_35_1 then
			arg_35_0:HightlightAllFurnitureInSuit(false)

			arg_35_0.originalSelFurnitureEID = nil
		end
	end

	DormSuitTools:DestoryFurSuitObject(arg_35_1, true, arg_35_2)
end

function var_0_0.CheckFurOccurpy(arg_36_0)
	local var_36_0 = DormRoomTools:GetDormFurOccupy(arg_36_0.roomID)
	local var_36_1 = BackHomeCfg[arg_36_0.roomID].type
	local var_36_2 = 0

	if var_36_1 == DormConst.BACKHOME_TYPE.PublicDorm then
		var_36_2 = GameDisplayCfg.lobby_volume_max.value[1]
	elseif var_36_1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_36_2 = GameDisplayCfg.dorm_volume_max.value[1]
	end

	if var_36_2 < var_36_0 then
		return false
	end

	return true
end

function var_0_0.ShowCanUseButton(arg_37_0)
	local var_37_0, var_37_1 = DormSuitData:CheckIsSuit(arg_37_0.itemID)

	arg_37_0.canResetController:SetSelectedState("false")

	if var_37_0 then
		if var_37_1 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
			if arg_37_0.params_.type == "drag" then
				arg_37_0.suitController:SetSelectedState("false")
			else
				arg_37_0.suitController:SetSelectedState("partSuit")
			end
		else
			arg_37_0.suitController:SetSelectedState("custom")
		end

		if arg_37_0.suitOriID and arg_37_0.suitOriID ~= 0 then
			arg_37_0.canResetController:SetSelectedState("true")
		else
			arg_37_0.canResetController:SetSelectedState("false")
		end

		arg_37_0.storageController_:SetSelectedState("true")
		arg_37_0.rotateController_:SetSelectedState("true")
	else
		local var_37_2 = BackHomeCfg[arg_37_0.roomID].type
		local var_37_3 = BackHomeFurniture[arg_37_0.itemID].is_rotate
		local var_37_4 = true

		for iter_37_0, iter_37_1 in ipairs(var_37_3) do
			if var_37_2 == iter_37_1 then
				arg_37_0.rotateController_:SetSelectedState("false")

				var_37_4 = false

				break
			end
		end

		if var_37_4 then
			arg_37_0.rotateController_:SetSelectedState("true")
		end

		local var_37_5 = BackHomeFurniture[arg_37_0.itemID].is_storage
		local var_37_6 = true

		for iter_37_2, iter_37_3 in ipairs(var_37_5) do
			if var_37_2 == iter_37_3 then
				arg_37_0.storageController_:SetSelectedState("false")

				var_37_6 = false

				break
			end
		end

		if var_37_6 then
			arg_37_0.storageController_:SetSelectedState("true")
		end

		if arg_37_0.params_.type == "edit" then
			if arg_37_0.params_.furSuitEid then
				arg_37_0.suitController:SetSelectedState("true")
			elseif arg_37_0:CheckFurCanEnterCustomeSuitMode(arg_37_0.itemID) then
				arg_37_0.suitController:SetSelectedState("establish")
			else
				arg_37_0.suitController:SetSelectedState("false")
			end
		else
			arg_37_0.suitController:SetSelectedState("false")
		end
	end
end

function var_0_0.CheckFurCanEnterCustomeSuitMode(arg_38_0, arg_38_1)
	local var_38_0 = BackHomeFurniture[arg_38_1]

	if var_38_0 and var_38_0.display_type == 0 then
		return true
	end

	return false
end

function var_0_0.Dispose(arg_39_0)
	var_0_0.super.Dispose(arg_39_0)
end

return var_0_0
