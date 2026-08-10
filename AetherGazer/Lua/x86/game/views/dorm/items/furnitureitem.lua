local var_0_0 = class("FurnitureItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.startController = ControllerUtil.GetController(arg_1_0.transform_, "itembglevel")
	arg_1_0.selectController = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.interactController = ControllerUtil.GetController(arg_1_0.transform_, "interact")
	arg_1_0.stateController = ControllerUtil.GetController(arg_1_0.transform_, "state")
	arg_1_0.limitController = ControllerUtil.GetController(arg_1_0.transform_, "upperlimit")
	arg_1_0.furNumController = ControllerUtil.GetController(arg_1_0.transform_, "furNum")
	arg_1_0.screenController = ControllerUtil.GetController(arg_1_0.transform_, "screening")
	arg_1_0.infoController = ControllerUtil.GetController(arg_1_0.transform_, "info")

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.onClickCom_ = arg_2_0:FindCom("OnClickDownListener")

	arg_2_0.onClickCom_.onValueChanged:AddListener(function()
		if arg_2_0.downFunc and not arg_2_0.canClick then
			arg_2_0.downFunc(arg_2_0.id, arg_2_0.index, arg_2_0.furType, arg_2_0.suitState)
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.clickBtn, nil, function()
		if arg_2_0.click and not arg_2_0.canClick then
			arg_2_0.click(arg_2_0.id, arg_2_0.index, arg_2_0.furType, arg_2_0.suitState, arg_2_0.giftNum)
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.grayBtn, nil, function()
		if arg_2_0.grayBtnFunc then
			arg_2_0.grayBtnFunc(arg_2_0.id, arg_2_0.index, arg_2_0.furType, arg_2_0.suitState, arg_2_0.giftNum)
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.infoBtn, nil, function()
		if arg_2_0.itemInfoFunc then
			arg_2_0.itemInfoFunc(arg_2_0.id)
		end
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	manager.redPoint:SetRedPointIndependent(arg_7_0.transform_, false)

	if arg_7_3 == DormEnum.FurItemType.Edit then
		arg_7_0.id = arg_7_1.furID
		arg_7_0.furType = arg_7_1.type

		arg_7_0:RefreshFurInfo(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.Gift then
		arg_7_0.id = arg_7_1

		arg_7_0:RefreshGiftInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	elseif arg_7_3 == DormEnum.FurItemType.SuitEdit then
		arg_7_0.id = arg_7_1.furID

		arg_7_0:RefreshSuitInfo(arg_7_1, arg_7_2, arg_7_6)
	elseif arg_7_3 == DormEnum.FurItemType.SuitFurShow then
		arg_7_0.id = arg_7_1.furID

		arg_7_0:RefreshSuitFurInfoList(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.StorageFurShow then
		arg_7_0.id = arg_7_1.furID

		arg_7_0:RefreshStorageFurShow(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.TemplateShow then
		arg_7_0.id = arg_7_1.furID

		arg_7_0:RefreshTemplateShow(arg_7_1, arg_7_2)
	elseif arg_7_3 == DormEnum.FurItemType.Illu then
		arg_7_0.id = arg_7_1.furID

		arg_7_0:RefreshIlluShow(arg_7_1)
	end

	arg_7_0.cfg = ItemCfg[arg_7_0.id]

	if arg_7_0.cfg then
		arg_7_0.furName.text = ItemTools.getItemName(arg_7_0.id)
		arg_7_0.level = ItemCfg[arg_7_0.id].rare
		arg_7_0.iconImg_.sprite = ItemTools.getItemSprite(arg_7_0.id)

		arg_7_0.startController:SetSelectedState(arg_7_0.level)

		arg_7_0.index = arg_7_5
	else
		print("家具" .. arg_7_0.id .. "在item表内未找到")

		return
	end
end

function var_0_0.RefreshGiftInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if BackHomeFurniture[arg_8_0.id].interact_max and BackHomeFurniture[arg_8_0.id].interact_max > 0 then
		arg_8_0.interactController:SetSelectedState("true")
	else
		arg_8_0.interactController:SetSelectedState("false")
	end

	arg_8_0.selectController:SetSelectedState("normal")
	arg_8_0.stateController:SetSelectedState("gift")
	arg_8_0.infoController:SetSelectedState("false")
	arg_8_0.furNumController:SetSelectedState("one")

	arg_8_0.comfortNum.text = BackHomeFurniture[arg_8_0.id].dorm_exp or 0

	local var_8_0 = DormRoomTools:GetDormIDViaArchive(arg_8_4)
	local var_8_1 = DormData:GetDormSceneData(var_8_0)
	local var_8_2 = DormData:GetHeroInfo(arg_8_4)

	if not var_8_1.give_furnitures[arg_8_0.id] then
		var_8_1.give_furnitures[arg_8_0.id] = 0
	end

	local var_8_3 = DormData:GetFurNumInfo(arg_8_0.id)

	arg_8_0.totalNum.text = var_8_3.num - var_8_3.give_num

	if var_8_2:GetCanGiftNum(arg_8_0.id) <= 0 then
		arg_8_0.limitController:SetSelectedState("gray")

		return
	else
		arg_8_0.limitController:SetSelectedState("normal")
	end

	if arg_8_2 then
		arg_8_0.selID = arg_8_2

		if arg_8_0.id == arg_8_0.selID then
			arg_8_0.selectController:SetSelectedState("select")
			arg_8_0.furNumController:SetSelectedState("two")

			arg_8_0.placeNum.text = var_8_1.give_furnitures[arg_8_0.id]
			arg_8_0.total2Num.text = var_8_3.num - var_8_3.give_num
		else
			arg_8_0.selectController:SetSelectedState("normal")
		end
	end
end

function var_0_0.RefreshFurInfo(arg_9_0, arg_9_1, arg_9_2)
	if BackHomeFurniture[arg_9_0.id].interact_max and BackHomeFurniture[arg_9_0.id].interact_max > 0 then
		arg_9_0.interactController:SetSelectedState("true")
	else
		arg_9_0.interactController:SetSelectedState("false")
	end

	arg_9_0.selectController:SetSelectedState("normal")
	arg_9_0.infoController:SetSelectedState("false")

	local var_9_0 = arg_9_1.type

	arg_9_0.stateController:SetSelectedState("edit")

	local var_9_1 = DormData:GetCurrectSceneID()

	if DormSpecialFurnitureTools:JudgeFurIsSpecialType(arg_9_0.id) then
		arg_9_0.furNumController:SetSelectedState("false")

		if var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			arg_9_0.screenController:SetSelectedState("CanPlace")
		elseif var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
			arg_9_0.screenController:SetSelectedState("HadPlace")
		elseif var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
			arg_9_0.screenController:SetSelectedState("OtherHadPlace")
		elseif var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
			arg_9_0.screenController:SetSelectedState("NotPresented")
		end
	else
		arg_9_0.furNumController:SetSelectedState("one")

		if var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			local var_9_2 = DormFurEditStateData:GetCanUseFurNumInRoom(var_9_1, arg_9_0.id)

			arg_9_0.totalNum.text = var_9_2

			arg_9_0.limitController:SetSelectedState("normal")
			arg_9_0.screenController:SetSelectedState("CanPlace")
			arg_9_0:ShowSelect(arg_9_2)
		elseif var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
			local var_9_3 = DormFurnitureTools:GetRoomCanPlaceFurMaxNum(var_9_1, arg_9_0.id)
			local var_9_4 = DormFurEditStateData:GetCanUseFurNumInRoom(var_9_1, arg_9_0.id)
			local var_9_5 = DormRoomTools:GetHasPlaceFurInfoByRoom(var_9_1, arg_9_0.id)
			local var_9_6 = DormFurEditStateData:GetCacheFurNum(arg_9_0.id)

			arg_9_0.totalNum.text = var_9_3 - var_9_4 - var_9_5 - var_9_6

			arg_9_0.screenController:SetSelectedState("OtherHadPlace")
		elseif var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
			local var_9_7 = DormRoomTools:GetHasPlaceFurInfoByRoom(var_9_1, arg_9_0.id)
			local var_9_8 = DormFurEditStateData:GetCacheFurNum(arg_9_0.id)

			arg_9_0.totalNum.text = var_9_7 + var_9_8

			arg_9_0.screenController:SetSelectedState("HadPlace")
		elseif var_9_0 == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
			local var_9_9 = DormData:GetFurNumInfo(arg_9_0.id)

			if BackHomeCfg[var_9_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				arg_9_0.totalNum.text = var_9_9.num - var_9_9.give_num
			elseif BackHomeCfg[var_9_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				local var_9_10 = DormitoryData:GetArchiveIDViaRoomID(var_9_1)[1]
				local var_9_11 = DormData:GetHeroInfo(var_9_10)

				arg_9_0.totalNum.text = var_9_11:GetCanGiftNum(arg_9_0.id)
			end

			arg_9_0.screenController:SetSelectedState("NotPresented")
		end
	end
end

function var_0_0.RefreshSuitFurInfoList(arg_10_0, arg_10_1, arg_10_2)
	if BackHomeFurniture[arg_10_0.id].interact_max and BackHomeFurniture[arg_10_0.id].interact_max > 0 then
		arg_10_0.interactController:SetSelectedState("true")
	else
		arg_10_0.interactController:SetSelectedState("false")
	end

	arg_10_0.limitController:SetSelectedState("normal")
	arg_10_0.stateController:SetSelectedState("edit")
	arg_10_0.furNumController:SetSelectedState("two")
	arg_10_0.infoController:SetSelectedState("false")

	local var_10_0 = DormData:GetCurrectSceneID()
	local var_10_1 = arg_10_1.suitID
	local var_10_2 = DormSuitData:GetFurNeedNumBySuitID(var_10_1, arg_10_0.id)
	local var_10_3 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(var_10_0, arg_10_0.id), var_10_2)

	arg_10_0:ShowSelect(arg_10_2)
	arg_10_0.screenController:SetSelectedState("CanPlace")

	arg_10_0.suitState = "enough"

	if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(arg_10_0.id) then
		if var_10_3 < var_10_2 then
			arg_10_0.placeNum.text = string.format("<color=#FA7577>%s</color>", tostring(var_10_3))
		else
			arg_10_0.placeNum.text = var_10_3
		end

		arg_10_0.total2Num.text = tostring(var_10_2)

		if var_10_3 < var_10_2 then
			if BackHomeFurniture[arg_10_0.id].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				local var_10_4 = DormRoomTools:GetCanGiftNumByRoomIDAndFurID(var_10_0, arg_10_0.id)
				local var_10_5 = DormRoomTools:GetCanGiftFurMaxNum(var_10_0, arg_10_0.id)

				if var_10_4 > 0 then
					arg_10_0.screenController:SetSelectedState("NotPresented")

					arg_10_0.suitState = "canGift"
					arg_10_0.giftNum = math.min(var_10_2 - var_10_3, var_10_4)
				else
					arg_10_0.limitController:SetSelectedState("gray")

					arg_10_0.suitState = "noEnough"
					arg_10_0.giftNum = math.min(var_10_2 - var_10_3, var_10_5)
				end
			else
				arg_10_0.limitController:SetSelectedState("gray")

				arg_10_0.suitState = "noEnough"
				arg_10_0.giftNum = var_10_2 - var_10_3
			end
		end
	else
		arg_10_0.placeNum.text = tostring(var_10_2)
		arg_10_0.total2Num.text = tostring(var_10_2)
	end
end

function var_0_0.RefreshSuitInfo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.screenController:SetSelectedState("CanPlace")
	arg_11_0.limitController:SetSelectedState("normal")
	arg_11_0.stateController:SetSelectedState("edit")
	arg_11_0.interactController:SetSelectedState("false")
	arg_11_0.furNumController:SetSelectedState("two")

	local var_11_0, var_11_1 = DormSuitData:CheckIsSuit(arg_11_0.id)

	if var_11_1 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		arg_11_0.infoController:SetSelectedState("false")
	else
		arg_11_0.infoController:SetSelectedState("true")
	end

	local var_11_2 = DormData:GetCurrectSceneID()
	local var_11_3 = DormSuitData:GetSuitNeedTotalFurNumList(arg_11_0.id)
	local var_11_4 = DormSuitData:GetTotalCanUseFurNumBySuitInRoom(arg_11_0.id, var_11_2)

	if var_11_4 < var_11_3 then
		arg_11_0.placeNum.text = string.format("<color=#FA7577>%s</color>", tostring(var_11_4))
	else
		arg_11_0.placeNum.text = var_11_4
	end

	arg_11_0.total2Num.text = tostring(var_11_3)

	if var_11_4 < var_11_3 then
		arg_11_0.screenController:SetSelectedState("suitNoFull")
	end

	arg_11_0:ShowSelect(arg_11_2)

	local var_11_5
	local var_11_6 = DormData:GetCurrectSceneID()

	if arg_11_3 == 1 then
		local var_11_7 = BackHomeCfg[var_11_6].type

		if var_11_7 == DormConst.BACKHOME_TYPE.PublicDorm then
			var_11_5 = string.format("%s_%s", RedPointConst.DORM_FULL_PUBLIC_SUIT, tostring(arg_11_0.id))
		elseif var_11_7 == DormConst.BACKHOME_TYPE.PrivateDorm then
			var_11_5 = string.format("%s_%s", RedPointConst.DORM_FULL_PRIVATE_SUIT, tostring(arg_11_0.id))
		end
	else
		var_11_5 = string.format("%s_%s", RedPointConst.DORM_PART_SUIT, tostring(arg_11_0.id))
	end

	if manager.redPoint:getTipBoolean(var_11_5) then
		manager.redPoint:SetRedPointIndependent(arg_11_0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_11_0.transform_, false)
	end
end

function var_0_0.RefreshStorageFurShow(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.screenController:SetSelectedState("CanPlace")
	arg_12_0.limitController:SetSelectedState("normal")
	arg_12_0.stateController:SetSelectedState("edit")
	arg_12_0.interactController:SetSelectedState("false")
	arg_12_0.furNumController:SetSelectedState("one")
	arg_12_0.infoController:SetSelectedState("false")

	arg_12_0.totalNum.text = arg_12_1.canStorageNum
end

function var_0_0.RefreshTemplateShow(arg_13_0, arg_13_1, arg_13_2)
	if BackHomeFurniture[arg_13_0.id].interact_max and BackHomeFurniture[arg_13_0.id].interact_max > 0 then
		arg_13_0.interactController:SetSelectedState("true")
	else
		arg_13_0.interactController:SetSelectedState("false")
	end

	arg_13_0.limitController:SetSelectedState("normal")
	arg_13_0.stateController:SetSelectedState("edit")
	arg_13_0.furNumController:SetSelectedState("two")
	arg_13_0.infoController:SetSelectedState("false")

	local var_13_0 = arg_13_1.needNum
	local var_13_1 = DormData:GetCurrectSceneID()
	local var_13_2 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(var_13_1, arg_13_0.id), var_13_0)

	arg_13_0:ShowSelect(arg_13_2)
	arg_13_0.screenController:SetSelectedState("CanPlace")

	arg_13_0.suitState = "enough"

	local var_13_3 = DormData:GetCurrectSceneID()

	if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(arg_13_0.id) then
		if var_13_2 < var_13_0 then
			arg_13_0.placeNum.text = string.format("<color=#FA7577>%s</color>", tostring(var_13_2))
		else
			arg_13_0.placeNum.text = var_13_2
		end

		arg_13_0.total2Num.text = tostring(var_13_0)

		if var_13_2 < var_13_0 then
			if BackHomeFurniture[arg_13_0.id].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				if var_13_0 <= DormRoomTools:GetCanGiftNumByRoomIDAndFurID(var_13_3, arg_13_0.id) + var_13_2 then
					arg_13_0.screenController:SetSelectedState("NotPresented")

					arg_13_0.suitState = "canGift"
					arg_13_0.giftNum = var_13_0 - var_13_2
				else
					arg_13_0.limitController:SetSelectedState("gray")

					arg_13_0.suitState = "noEnough"
					arg_13_0.giftNum = var_13_0 - var_13_2
				end
			else
				arg_13_0.limitController:SetSelectedState("gray")

				arg_13_0.suitState = "noEnough"
				arg_13_0.giftNum = var_13_0 - var_13_2
			end
		end
	else
		arg_13_0.placeNum.text = tostring(var_13_0)
		arg_13_0.total2Num.text = tostring(var_13_0)
	end
end

function var_0_0.RefreshIlluShow(arg_14_0, arg_14_1)
	if BackHomeFurniture[arg_14_0.id].interact_max and BackHomeFurniture[arg_14_0.id].interact_max > 0 then
		arg_14_0.interactController:SetSelectedState("true")
	else
		arg_14_0.interactController:SetSelectedState("false")
	end

	if arg_14_1.num > 0 then
		arg_14_0.limitController:SetSelectedState("normal")
	else
		arg_14_0.limitController:SetSelectedState("gray")
	end
end

function var_0_0.ShowSelect(arg_15_0, arg_15_1)
	if arg_15_1 and not arg_15_0.showSel then
		if arg_15_0.id == arg_15_1 then
			arg_15_0.selectController:SetSelectedState("select")
		else
			arg_15_0.selectController:SetSelectedState("normal")
		end
	else
		arg_15_0.selectController:SetSelectedState("normal")
	end
end

function var_0_0.SetItemShow(arg_16_0, arg_16_1)
	arg_16_0.canClick = arg_16_1.canClick
	arg_16_0.showSel = arg_16_1.showSel
end

function var_0_0.OnPointerDown(arg_17_0, arg_17_1)
	arg_17_0.downFunc = arg_17_1
end

function var_0_0.OnClickBtn(arg_18_0, arg_18_1)
	arg_18_0.click = arg_18_1
end

function var_0_0.GrayCallBack(arg_19_0, arg_19_1)
	arg_19_0.grayBtnFunc = arg_19_1
end

function var_0_0.ItemInfoCallBack(arg_20_0, arg_20_1)
	arg_20_0.itemInfoFunc = arg_20_1
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:RemoveAllListeners()
	arg_21_0.onClickCom_.onValueChanged:RemoveAllListeners()
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
