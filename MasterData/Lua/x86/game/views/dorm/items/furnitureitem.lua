local FurnitureItem = class("FurnitureItem", ReduxView)

function FurnitureItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.startController = ControllerUtil.GetController(self.transform_, "itembglevel")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.interactController = ControllerUtil.GetController(self.transform_, "interact")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.limitController = ControllerUtil.GetController(self.transform_, "upperlimit")
	self.furNumController = ControllerUtil.GetController(self.transform_, "furNum")
	self.screenController = ControllerUtil.GetController(self.transform_, "screening")
	self.infoController = ControllerUtil.GetController(self.transform_, "info")

	self:InitUI()
end

function FurnitureItem:InitUI()
	self:BindCfgUI()

	self.onClickCom_ = self:FindCom("OnClickDownListener")

	self.onClickCom_.onValueChanged:AddListener(function()
		if self.downFunc and not self.canClick then
			self.downFunc(self.id, self.index, self.furType, self.suitState)
		end
	end)
	self:AddBtnListener(self.clickBtn, nil, function()
		if self.click and not self.canClick then
			self.click(self.id, self.index, self.furType, self.suitState, self.giftNum)
		end
	end)
	self:AddBtnListener(self.grayBtn, nil, function()
		if self.grayBtnFunc then
			self.grayBtnFunc(self.id, self.index, self.furType, self.suitState, self.giftNum)
		end
	end)
	self:AddBtnListener(self.infoBtn, nil, function()
		if self.itemInfoFunc then
			self.itemInfoFunc(self.id)
		end
	end)
end

function FurnitureItem:RefreshUI(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	manager.redPoint:SetRedPointIndependent(self.transform_, false)

	if arg_7_3 == DormEnum.FurItemType.Edit then
		self.id = arg_7_1.furID
		self.furType = arg_7_1.type

		self:RefreshFurInfo(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.Gift then
		self.id = arg_7_1

		self:RefreshGiftInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	elseif arg_7_3 == DormEnum.FurItemType.SuitEdit then
		self.id = arg_7_1.furID

		self:RefreshSuitInfo(arg_7_1, arg_7_2, arg_7_6)
	elseif arg_7_3 == DormEnum.FurItemType.SuitFurShow then
		self.id = arg_7_1.furID

		self:RefreshSuitFurInfoList(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.StorageFurShow then
		self.id = arg_7_1.furID

		self:RefreshStorageFurShow(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.TemplateShow then
		self.id = arg_7_1.furID

		self:RefreshTemplateShow(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.Illu then
		self.id = arg_7_1.furID

		self:RefreshIlluShow(arg_7_1)
	end

	self.cfg = ItemCfg[self.id]

	if self.cfg then
		self.furName.text = ItemTools.getItemName(self.id)
		self.level = ItemCfg[self.id].rare
		self.iconImg_.sprite = ItemTools.getItemSprite(self.id)

		self.startController:SetSelectedState(self.level)

		self.index = arg_7_5
	else
		print("家具" .. self.id .. "在item表内未找到")

		return
	end
end

function FurnitureItem:RefreshGiftInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if BackHomeFurniture[self.id].interact_max and BackHomeFurniture[self.id].interact_max > 0 then
		self.interactController:SetSelectedState("true")
	else
		self.interactController:SetSelectedState("false")
	end

	self.selectController:SetSelectedState("normal")
	self.stateController:SetSelectedState("gift")
	self.infoController:SetSelectedState("false")
	self.furNumController:SetSelectedState("one")

	self.comfortNum.text = BackHomeFurniture[self.id].dorm_exp or 0

	local var_8_0 = DormData:GetDormSceneData((DormRoomTools:GetDormIDViaArchive(arg_8_4)))

	var_8_0.give_furnitures[self.id] = var_8_0.give_furnitures[self.id] or 0

	local var_8_1 = DormData:GetFurNumInfo(self.id)

	self.totalNum.text = var_8_1.num - var_8_1.give_num

	if DormData:GetHeroInfo(arg_8_4):GetCanGiftNum(self.id) <= 0 then
		self.limitController:SetSelectedState("gray")

		return
	else
		self.limitController:SetSelectedState("normal")
	end

	if arg_8_2 then
		self.selID = arg_8_2

		if self.id == self.selID then
			self.selectController:SetSelectedState("select")
			self.furNumController:SetSelectedState("two")

			self.placeNum.text = var_8_0.give_furnitures[self.id]
			self.total2Num.text = var_8_1.num - var_8_1.give_num
		else
			self.selectController:SetSelectedState("normal")
		end
	end
end

function FurnitureItem:RefreshFurInfo(arg_9_1, arg_9_2)
	if BackHomeFurniture[self.id].interact_max and BackHomeFurniture[self.id].interact_max > 0 then
		self.interactController:SetSelectedState("true")
	else
		self.interactController:SetSelectedState("false")
	end

	self.selectController:SetSelectedState("normal")
	self.infoController:SetSelectedState("false")
	self.stateController:SetSelectedState("edit")

	local var_9_0 = DormData:GetCurrectSceneID()

	if DormSpecialFurnitureTools:JudgeFurIsSpecialType(self.id) then
		self.furNumController:SetSelectedState("false")

		if arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			self.screenController:SetSelectedState("CanPlace")
		elseif arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
			self.screenController:SetSelectedState("HadPlace")
		elseif arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
			self.screenController:SetSelectedState("OtherHadPlace")
		elseif arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
			self.screenController:SetSelectedState("NotPresented")
		end
	else
		self.furNumController:SetSelectedState("one")

		if arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			self.totalNum.text = DormFurEditStateData:GetCanUseFurNumInRoom(var_9_0, self.id)

			self.limitController:SetSelectedState("normal")
			self.screenController:SetSelectedState("CanPlace")
			self:ShowSelect(arg_9_2)
		elseif arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
			self.totalNum.text = DormFurnitureTools:GetRoomCanPlaceFurMaxNum(var_9_0, self.id) - DormFurEditStateData:GetCanUseFurNumInRoom(var_9_0, self.id) - DormRoomTools:GetHasPlaceFurInfoByRoom(var_9_0, self.id) - DormFurEditStateData:GetCacheFurNum(self.id)

			self.screenController:SetSelectedState("OtherHadPlace")
		elseif arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
			self.totalNum.text = DormRoomTools:GetHasPlaceFurInfoByRoom(var_9_0, self.id) + DormFurEditStateData:GetCacheFurNum(self.id)

			self.screenController:SetSelectedState("HadPlace")
		elseif arg_9_1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
			local var_9_1 = DormData:GetFurNumInfo(self.id)

			if BackHomeCfg[var_9_0].type == DormConst.BACKHOME_TYPE.PublicDorm then
				self.totalNum.text = var_9_1.num - var_9_1.give_num
			elseif BackHomeCfg[var_9_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				self.totalNum.text = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(var_9_0)[1]):GetCanGiftNum(self.id)
			end

			self.screenController:SetSelectedState("NotPresented")
		end
	end
end

function FurnitureItem:RefreshSuitFurInfoList(arg_10_1, arg_10_2)
	if BackHomeFurniture[self.id].interact_max and BackHomeFurniture[self.id].interact_max > 0 then
		self.interactController:SetSelectedState("true")
	else
		self.interactController:SetSelectedState("false")
	end

	self.limitController:SetSelectedState("normal")
	self.stateController:SetSelectedState("edit")
	self.furNumController:SetSelectedState("two")
	self.infoController:SetSelectedState("false")

	local var_10_0 = DormData:GetCurrectSceneID()
	local var_10_1 = DormSuitData:GetFurNeedNumBySuitID(arg_10_1.suitID, self.id)
	local var_10_2 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(var_10_0, self.id), var_10_1)

	self:ShowSelect(arg_10_2)
	self.screenController:SetSelectedState("CanPlace")

	self.suitState = "enough"

	if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(self.id) then
		self.placeNum.text = var_10_2 < var_10_1 and string.format("<color=#FA7577>%s</color>", tostring(var_10_2)) or var_10_2
		self.total2Num.text = tostring(var_10_1)

		if var_10_2 < var_10_1 then
			if BackHomeFurniture[self.id].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				local var_10_3 = DormRoomTools:GetCanGiftNumByRoomIDAndFurID(var_10_0, self.id)

				if var_10_3 > 0 then
					self.screenController:SetSelectedState("NotPresented")

					self.suitState = "canGift"
					self.giftNum = math.min(var_10_1 - var_10_2, var_10_3)
				else
					self.limitController:SetSelectedState("gray")

					self.suitState = "noEnough"
					self.giftNum = math.min(var_10_1 - var_10_2, (DormRoomTools:GetCanGiftFurMaxNum(var_10_0, self.id)))
				end
			else
				self.limitController:SetSelectedState("gray")

				self.suitState = "noEnough"
				self.giftNum = var_10_1 - var_10_2
			end
		end
	else
		self.placeNum.text = tostring(var_10_1)
		self.total2Num.text = tostring(var_10_1)
	end
end

function FurnitureItem:RefreshSuitInfo(arg_11_1, arg_11_2, arg_11_3)
	self.screenController:SetSelectedState("CanPlace")
	self.limitController:SetSelectedState("normal")
	self.stateController:SetSelectedState("edit")
	self.interactController:SetSelectedState("false")
	self.furNumController:SetSelectedState("two")

	local var_11_0, var_11_1 = DormSuitData:CheckIsSuit(self.id)

	if var_11_1 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		self.infoController:SetSelectedState("false")
	end

	local var_11_2

	do
		self.infoController:SetSelectedState("true")

		var_11_2 = DormSuitData:GetSuitNeedTotalFurNumList(self.id)
	end

	local var_11_3 = DormSuitData:GetTotalCanUseFurNumBySuitInRoom(self.id, (DormData:GetCurrectSceneID()))

	self.placeNum.text = var_11_3 < var_11_2 and string.format("<color=#FA7577>%s</color>", tostring(var_11_3)) or var_11_3
	self.total2Num.text = tostring(var_11_2)

	if var_11_3 < var_11_2 then
		self.screenController:SetSelectedState("suitNoFull")
	end

	self:ShowSelect(arg_11_2)

	local var_11_4

	if arg_11_3 == 1 then
		if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PublicDorm then
			var_11_4 = string.format("%s_%s", RedPointConst.DORM_FULL_PUBLIC_SUIT, tostring(self.id))
		elseif BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			var_11_4 = string.format("%s_%s", RedPointConst.DORM_FULL_PRIVATE_SUIT, tostring(self.id))
		end
	else
		var_11_4 = string.format("%s_%s", RedPointConst.DORM_PART_SUIT, tostring(self.id))
	end

	if manager.redPoint:getTipBoolean(var_11_4) then
		manager.redPoint:SetRedPointIndependent(self.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(self.transform_, false)
	end
end

function FurnitureItem:RefreshStorageFurShow(arg_12_1, arg_12_2)
	self.screenController:SetSelectedState("CanPlace")
	self.limitController:SetSelectedState("normal")
	self.stateController:SetSelectedState("edit")
	self.interactController:SetSelectedState("false")
	self.furNumController:SetSelectedState("one")
	self.infoController:SetSelectedState("false")

	self.totalNum.text = arg_12_1.canStorageNum
end

function FurnitureItem:RefreshTemplateShow(arg_13_1, arg_13_2)
	if BackHomeFurniture[self.id].interact_max and BackHomeFurniture[self.id].interact_max > 0 then
		self.interactController:SetSelectedState("true")
	else
		self.interactController:SetSelectedState("false")
	end

	self.limitController:SetSelectedState("normal")
	self.stateController:SetSelectedState("edit")
	self.furNumController:SetSelectedState("two")
	self.infoController:SetSelectedState("false")

	local var_13_0 = arg_13_1.needNum
	local var_13_1 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(DormData:GetCurrectSceneID(), self.id), arg_13_1.needNum)

	self:ShowSelect(arg_13_2)
	self.screenController:SetSelectedState("CanPlace")

	self.suitState = "enough"

	if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(self.id) then
		self.placeNum.text = var_13_1 < var_13_0 and string.format("<color=#FA7577>%s</color>", tostring(var_13_1)) or var_13_1
		self.total2Num.text = tostring(var_13_0)

		if var_13_1 < var_13_0 then
			if BackHomeFurniture[self.id].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				if var_13_0 <= DormRoomTools:GetCanGiftNumByRoomIDAndFurID(DormData:GetCurrectSceneID(), self.id) + var_13_1 then
					self.screenController:SetSelectedState("NotPresented")

					self.suitState = "canGift"
					self.giftNum = var_13_0 - var_13_1
				else
					self.limitController:SetSelectedState("gray")

					self.suitState = "noEnough"
					self.giftNum = var_13_0 - var_13_1
				end
			else
				self.limitController:SetSelectedState("gray")

				self.suitState = "noEnough"
				self.giftNum = var_13_0 - var_13_1
			end
		end
	else
		self.placeNum.text = tostring(var_13_0)
		self.total2Num.text = tostring(var_13_0)
	end
end

function FurnitureItem:RefreshIlluShow(arg_14_1)
	if BackHomeFurniture[self.id].interact_max and BackHomeFurniture[self.id].interact_max > 0 then
		self.interactController:SetSelectedState("true")
	else
		self.interactController:SetSelectedState("false")
	end

	if arg_14_1.num > 0 then
		self.limitController:SetSelectedState("normal")
	else
		self.limitController:SetSelectedState("gray")
	end
end

function FurnitureItem:ShowSelect(arg_15_1)
	if arg_15_1 and not self.showSel then
		if self.id == arg_15_1 then
			self.selectController:SetSelectedState("select")
		else
			self.selectController:SetSelectedState("normal")
		end
	else
		self.selectController:SetSelectedState("normal")
	end
end

function FurnitureItem:SetItemShow(arg_16_1)
	self.canClick = arg_16_1.canClick
	self.showSel = arg_16_1.showSel
end

function FurnitureItem:OnPointerDown(arg_17_1)
	self.downFunc = arg_17_1
end

function FurnitureItem:OnClickBtn(arg_18_1)
	self.click = arg_18_1
end

function FurnitureItem:GrayCallBack(arg_19_1)
	self.grayBtnFunc = arg_19_1
end

function FurnitureItem:ItemInfoCallBack(arg_20_1)
	self.itemInfoFunc = arg_20_1
end

function FurnitureItem:Dispose()
	self:RemoveAllListeners()
	self.onClickCom_.onValueChanged:RemoveAllListeners()
	FurnitureItem.super.Dispose(self)
end

return FurnitureItem
