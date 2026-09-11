local FurnitureEditView = class("FurnitureEditView", ReduxView)

function FurnitureEditView:UIName()
	return "Widget/BackHouseUI/Dorm/FurnitureEditorUI"
end

function FurnitureEditView:UIParent()
	return manager.ui.uiMain.transform
end

function FurnitureEditView:OnCtor()
	return
end

function FurnitureEditView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FurnitureEditView:InitUI()
	self:BindCfgUI()

	self.rotateController_ = ControllerUtil.GetController(self.transform_, "rotate")
	self.storageController_ = ControllerUtil.GetController(self.transform_, "storage")
	self.suitController = ControllerUtil.GetController(self.transform_, "suit")
	self.canResetController = ControllerUtil.GetController(self.transform_, "canReset")
	self.furDescController = ControllerUtil.GetController(self.transform_, "descState")
end

function FurnitureEditView:OnEnter()
	if self.params_.isBack == true then
		self.gotoPreview_ = true
	end

	DormFurnitureTools:SetEditFurFlag(true)

	self.roomID = DormData:GetCurrectSceneID()
	self.itemID = self.params_.itemId
	self.furEntityID = self.params_.furEntityID

	if self.params_.type == "drag" then
		if not self.params_.isBack then
			local var_6_0, var_6_1 = DormSuitData:CheckIsSuit(self.itemID)

			if var_6_0 then
				local var_6_2 = DormSuitTools:GenerateFurSuit(self.itemID)

				DormLuaBridge.ChangeFurnitureSuitState(var_6_2, DormFurnitureManager.FurnitureState.Editing, false)
				DormLuaBridge.AddFurnitureToWallDitherAlphaControl(var_6_2)
				DormLuaBridge.BeginDragFurniture(var_6_2)
				self:EnterSuitEditMode(var_6_2, false)
			elseif DormSpecialFurnitureTools:JudgeFurIsSpecialType(self.itemID) then
				DormLuaBridge.SetIsCanEditTag(false)
				DormSpecialFurnitureTools:ChangeDormSpeicalFur(self.itemID)
			else
				local var_6_3 = DormFurnitureManager.GetInstance():Generate(self.itemID)

				DormLuaBridge.ChangeFurnitureState(var_6_3, DormFurnitureManager.FurnitureState.Editing)
				DormLuaBridge.AddFurnitureToWallDitherAlphaControl(var_6_3)
				DormLuaBridge.BeginDragFurniture(var_6_3)

				self.furEntityID = var_6_3
				self.originalSelFurnitureEID = var_6_3

				self:HightlightAllFurnitureInSuit(true)
			end
		end
	elseif self.params_.type == "edit" then
		self.originalSelFurnitureEID = self.furEntityID

		self:HightlightAllFurnitureInSuit(true)
	end

	self:RefreshFurInfo()
end

function FurnitureEditView:OnTop()
	self.gotoPreview_ = false

	if self.cacheBlend then
		manager.ui.mainCamera:GetComponent("CinemachineBrain").m_DefaultBlend = self.cacheBlend
	end

	self.cacheBlend = manager.ui.mainCamera:GetComponent("CinemachineBrain").m_DefaultBlend

	self:RegisterEvents()
end

function FurnitureEditView:EnterSuitEditMode(arg_8_1, arg_8_2)
	if DormLuaBridge.CheckSuitEditModeAvailabel(arg_8_1) then
		DormLuaBridge.EnterSuitEditMode(arg_8_1, arg_8_2)

		return true
	end

	return false
end

function FurnitureEditView:RegisterEvents()
	self:RegistEventListener(DORM_ENTER_SUIT_EDIT_MODE, function(arg_10_0, arg_10_1, arg_10_2)
		self:HightlightAllFurnitureInSuit(false)

		self.itemID = arg_10_0
		self.originalSelFurnitureEID = self.furEntityID
		self.furEntityID = arg_10_1
		self.suitOriID = arg_10_2
		self.params_.furSuitEid = nil

		self:RefreshFurInfo()
	end)
	self:RegistEventListener(DORM_EXIT_SUIT_EDIT_MODE, function(arg_11_0)
		self.furEntityID = nil
	end)
end

function FurnitureEditView:RefreshFurInfo()
	local var_12_0, var_12_1 = DormSuitData:CheckIsSuit(self.itemID)

	if var_12_0 then
		self.furDescController:SetSelectedState("suit")

		self.furnameText_.text = GetTips("DORM_EDIT_TIPS_2")
	else
		self.furDescController:SetSelectedState("single")

		if ItemCfg[self.itemID] then
			self.furnameText_.text = ItemTools.getItemName(self.itemID)
		end
	end

	self:ShowCanUseButton()
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

function FurnitureEditView:OnExit()
	if not self.gotoPreview_ then
		self:HightlightAllFurnitureInSuit(false)

		self.params_.type = nil
		self.suitOriID = nil
		self.cacheCustomFur = nil
		self.originalSelFurnitureEID = nil

		DormLuaBridge.ClearEditingFurniture()
	end

	self.gotoPreview_ = false

	self:RemoveAllEventListener()
end

function FurnitureEditView:HightlightAllFurnitureInSuit(arg_15_1, arg_15_2)
	if self.originalSelFurnitureEID then
		var_0_1(self.originalSelFurnitureEID, arg_15_1, arg_15_2)
	end
end

function FurnitureEditView:AddUIListener()
	self:AddBtnListenerScale(self.cancelBtn_, nil, function()
		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(self.itemID) then
			DormSpecialFurnitureTools:ChangeDormSpeicalFur(DormFurEditStateData:GetCacheWallAndFloorInfo(BackHomeFurniture[self.itemID].type) or DormSpecialFurnitureTools:GetSpecialFurIDByRoom(DormData:GetCurrectSceneID(), BackHomeFurniture[self.itemID].type))
		else
			local var_17_0, var_17_1 = DormSuitData:CheckIsSuit(self.itemID)
			local var_17_2
			local var_17_3

			if var_17_0 then
				var_17_2, var_17_3 = DormLuaBridge.CancelSuitChange(nil)
			else
				var_17_2, var_17_3 = DormLuaBridge.CancelChange(nil)
			end

			if var_17_2 then
				if var_17_0 then
					self:RemoveFurnitureSuit(var_17_3)
				else
					DormUtils.GetEntityData(var_17_3).noOccupy = true

					self:RemoveFurniture(var_17_3)
				end
			elseif self.params_.type == "edit" and not var_17_0 and self.itemID then
				DormLuaBridge.RecoverRoomFurnitureOccupyByLua(self.furEntityID)
			end
		end

		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.rotateBtn_, nil, function()
		local var_18_0, var_18_1 = DormSuitData:CheckIsSuit(self.itemID)

		if var_18_0 then
			DormLuaBridge.RotateSuitFurniture()
		else
			DormLuaBridge.RotateFurniture()
		end
	end)
	self:AddBtnListenerScale(self.saveBtn_, nil, function()
		if not self:CheckFurOccurpy() then
			ShowTips(GetTips("DORM_FUR_VOLUME_MAX"))

			return
		end

		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(self.itemID) then
			local var_19_0, var_19_1 = DormSuitData:CheckIsSuit(self.itemID)

			if var_19_0 and DormLuaBridge.SaveSuitChange() or DormLuaBridge.SaveChange() then
				if self.params_.type == "drag" then
					if var_19_0 then
						DormFurEditStateData:ReveseFurSuitNumInEidtRoom(self.itemID, 1)
					else
						DormFurEditStateData:ReviseFurNumInEditRoom(self.itemID, 1)
					end
				end

				JumpTools.Back()
			else
				ShowTips("DORM_FURNITURE_CANNOT_SET")
			end
		else
			if self.params_.type == "drag" then
				local var_19_3 = DormFurEditStateData:GetCacheWallAndFloorInfo(BackHomeFurniture[self.itemID].type) or DormSpecialFurnitureTools:GetSpecialFurIDByRoom(self.roomID, BackHomeFurniture[self.itemID].type)

				DormFurEditStateData:ReviseFurNumInEditRoom(self.itemID, 1)
				DormFurEditStateData:ReviseFurNumInEditRoom(var_19_3, -1)
			end

			JumpTools.Back()
		end
	end)
	self:AddBtnListenerScale(self.storageBtn_, nil, function()
		local var_20_0
		local var_20_2, var_20_3 = DormSuitData:CheckIsSuit(self.itemID)

		if not var_20_2 and self.params_.furSuitEid then
			ShowMessageBox({
				content = GetTips("DORM_STORAGE_CANT_SUIT"),
				OkCallback = function()
					var_20_0 = DormLuaBridge.StorageFurniture()

					DormSuitTools:RelieveSuit(self.params_.furSuitEid)

					if var_20_0 ~= Dorm.DormEntityManager.INVALID_ENTITY_ID then
						DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(var_20_0)

						DormUtils.GetEntityData(var_20_0).noOccupy = true

						self:RemoveFurniture(var_20_0)
					end

					if self.params_.type == "edit" then
						DormFurEditStateData:ReviseFurNumInEditRoom(self.itemID, -1)
					end

					self.params_.furSuitEid = nil

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

					self:RemoveFurnitureSuit(var_20_0, self.params_.type == "edit")
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

				self:RemoveFurniture(var_20_0)
			end

			if self.params_.type == "edit" then
				DormFurEditStateData:ReviseFurNumInEditRoom(self.itemID, -1)

				self.cacheCustomFur = self.itemID
			end

			JumpTools.Back()
		end
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		if self.itemID and self.itemID > 0 and ItemCfg[self.itemID] then
			self.gotoPreview_ = true

			ShowPopItem(POP_ITEM, {
				self.itemID
			})
		end
	end)
	self:AddBtnListener(self.enterSuit, nil, function()
		if self:EnterSuitEditMode(self.furEntityID, true) then
			self:HightlightAllFurnitureInSuit(true, DormEnum.HighlightLayer.Available)
		else
			ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
		end
	end)
	self:AddBtnListener(self.relievesuitBtn_, nil, function()
		if self.furEntityID then
			if DormLuaBridge.GetSuitOrFurnitureCanPlace(self.furEntityID) then
				ShowMessageBox({
					content = GetTips("DORM_FURNITURE_SUIT_EDIT_INFO"),
					OkCallback = function()
						DormSuitTools:RelieveSuit(self.furEntityID)
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
	self:AddBtnListener(self.resetsuitBtn_, nil, function()
		ShowMessageBox({
			content = GetTips("DORM_SUTI_RESET"),
			OkCallback = function()
				DormSuitEditData:ResetSuitPosition(self.furEntityID, self.itemID)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.customsuitBtn_, nil, function()
		if DormLuaBridge.CheckSuitEditModeAvailabel(self.furEntityID) then
			DormLuaBridge.EnterCustomeEditMode(self.furEntityID)
		else
			ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
		end
	end)
end

function FurnitureEditView:RemoveFurniture(arg_34_1)
	if self.originalSelFurnitureEID == arg_34_1 then
		self:HightlightAllFurnitureInSuit(false)

		self.originalSelFurnitureEID = nil
	end

	DormFurnitureManager.GetInstance().FindAndRemove(arg_34_1)
end

function FurnitureEditView:RemoveFurnitureSuit(arg_35_1, arg_35_2)
	if self.originalSelFurnitureEID then
		local var_35_0, var_35_1 = DormLuaBridge.CheckFurnitureBelongSuit(self.originalSelFurnitureEID, nil)

		if var_35_1 == arg_35_1 then
			self:HightlightAllFurnitureInSuit(false)

			self.originalSelFurnitureEID = nil
		end
	end

	DormSuitTools:DestoryFurSuitObject(arg_35_1, true, arg_35_2)
end

function FurnitureEditView:CheckFurOccurpy()
	local var_36_0 = 0

	if BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		var_36_0 = GameDisplayCfg.lobby_volume_max.value[1]
	elseif BackHomeCfg[self.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		var_36_0 = GameDisplayCfg.dorm_volume_max.value[1]
	end

	if var_36_0 < DormRoomTools:GetDormFurOccupy(self.roomID) then
		return false
	end

	return true
end

function FurnitureEditView:ShowCanUseButton()
	local var_37_0, var_37_1 = DormSuitData:CheckIsSuit(self.itemID)

	self.canResetController:SetSelectedState("false")

	if var_37_0 then
		if var_37_1 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
			if self.params_.type == "drag" then
				self.suitController:SetSelectedState("false")
			else
				self.suitController:SetSelectedState("partSuit")
			end
		else
			self.suitController:SetSelectedState("custom")
		end

		if self.suitOriID and self.suitOriID ~= 0 then
			self.canResetController:SetSelectedState("true")
		else
			self.canResetController:SetSelectedState("false")
		end

		self.storageController_:SetSelectedState("true")
		self.rotateController_:SetSelectedState("true")
	else
		local var_37_2 = BackHomeCfg[self.roomID].type
		local var_37_3 = true

		for iter_37_0, iter_37_1 in ipairs(BackHomeFurniture[self.itemID].is_rotate) do
			if var_37_2 == iter_37_1 then
				self.rotateController_:SetSelectedState("false")

				var_37_3 = false

				break
			end
		end

		local var_37_4

		if var_37_3 then
			self.rotateController_:SetSelectedState("true")

			var_37_4 = true
		end

		for iter_37_2, iter_37_3 in ipairs(BackHomeFurniture[self.itemID].is_storage) do
			if var_37_2 == iter_37_3 then
				self.storageController_:SetSelectedState("false")

				var_37_4 = false

				break
			end
		end

		if var_37_4 then
			self.storageController_:SetSelectedState("true")
		end

		if self.params_.type == "edit" then
			if self.params_.furSuitEid then
				self.suitController:SetSelectedState("true")
			elseif self:CheckFurCanEnterCustomeSuitMode(self.itemID) then
				self.suitController:SetSelectedState("establish")
			else
				self.suitController:SetSelectedState("false")
			end
		else
			self.suitController:SetSelectedState("false")
		end
	end
end

function FurnitureEditView:CheckFurCanEnterCustomeSuitMode(arg_38_1)
	if BackHomeFurniture[arg_38_1] and BackHomeFurniture[arg_38_1].display_type == 0 then
		return true
	end

	return false
end

function FurnitureEditView:Dispose()
	FurnitureEditView.super.Dispose(self)
end

return FurnitureEditView
