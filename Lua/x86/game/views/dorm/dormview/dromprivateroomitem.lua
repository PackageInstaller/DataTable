local var_0_0 = class("DromPrivateRoomItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.publicHeroScroll = LuaList.New(handler(arg_2_0, arg_2_0.indexHeroItem), arg_2_0.uilistGo_, BackHomeNewHeroItem)
	arg_2_0.publicStateController = ControllerUtil.GetController(arg_2_0.transform_, "roomType")
	arg_2_0.visitController = ControllerUtil.GetController(arg_2_0.transform_, "tips")
	arg_2_0.emptyController = ControllerUtil.GetController(arg_2_0.uilistGo_.transform, "empty")
	arg_2_0.publicVisitController = ControllerUtil.GetController(arg_2_0.publicGo_.transform, "visit")
	arg_2_0.floorAniamtion = arg_2_0.dimianGo_:GetComponent("Animation")
	arg_2_0.edit = false
	arg_2_0.time = 2 / GameDisplayCfg.dorm_area_swap_speed.value[1]

	arg_2_0:InitPrivateRoomItemInfo()
	arg_2_0:RegisterEvents()
	arg_2_0:AddUIListener()
end

function var_0_0.InitPrivateRoomItemInfo(arg_3_0)
	arg_3_0.itemPosition = {}
	arg_3_0.item = {}

	for iter_3_0 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		arg_3_0.item[iter_3_0] = DormRoomItem.New(arg_3_0["item" .. iter_3_0 .. "Go_"])

		arg_3_0.item[iter_3_0]:SetPosAndRoomID(iter_3_0)
		arg_3_0:AddBtnCallBack(arg_3_0.item[iter_3_0])

		arg_3_0.itemPosition[iter_3_0] = {}
		arg_3_0.itemPosition[iter_3_0].has = true
		arg_3_0.itemPosition[iter_3_0].pos = Vector3.New(arg_3_0.item[iter_3_0].transform_.localPosition.x, arg_3_0.item[iter_3_0].transform_.localPosition.y, arg_3_0.item[iter_3_0].transform_.localPosition.z)
	end

	arg_3_0.itemPosition[1].slibing = 6
	arg_3_0.itemPosition[2].slibing = 2
	arg_3_0.itemPosition[3].slibing = 5
	arg_3_0.itemPosition[4].slibing = 7
	arg_3_0.itemPosition[5].slibing = 3
	arg_3_0.itemPosition[6].slibing = 1
	arg_3_0.itemPosition[7].slibing = 4
	arg_3_0.itemPosition[8].slibing = 8
	arg_3_0.itemPosition[9].slibing = 8
	arg_3_0.itemPosition[10].slibing = 8
	arg_3_0.itemPosition[11].slibing = 8

	for iter_3_1 = 1, DormConst.DORM_FIRST_FLOOR_ROOM_NUM do
		arg_3_0.item[iter_3_1].transform_:SetSiblingIndex(arg_3_0.itemPosition[iter_3_1].slibing)
	end
end

function var_0_0.OnBehind(arg_4_0)
	arg_4_0:SetItemCanvasSortOrder(true)
end

function var_0_0.SetItemCanvasSortOrder(arg_5_0, arg_5_1)
	if arg_5_0.item then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.item) do
			iter_5_1.bgCanvas.overrideSorting = arg_5_1
		end
	end
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.visitController:SetSelectedState(DormData:CanReceiveVisitReward() and "tips1" or "off")
end

function var_0_0.OnTop(arg_7_0)
	if arg_7_0.floor then
		arg_7_0:RefreshUI(arg_7_0.floor)
	end

	arg_7_0.visitController:SetSelectedState(DormData:CanReceiveVisitReward() and "tips1" or "off")
end

function var_0_0.OnUpdate(arg_8_0)
	return
end

function var_0_0.StartGuide(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:SetItemCanvasSortOrder(true)
end

function var_0_0.RefreshUI(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	arg_11_0.floor = arg_11_1

	if arg_11_1 == GameDisplayCfg.dorm_lobby_layer.value[1] then
		arg_11_0.publicStateController:SetSelectedState("public")
		arg_11_0:RefreshPublicRoomHeroList()
	else
		arg_11_0.publicStateController:SetSelectedState("private")
	end

	arg_11_0:InitRoomPos()

	for iter_11_0 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		arg_11_0.item[iter_11_0]:RefreshItemState()
	end
end

function var_0_0.InitRoomPos(arg_12_0)
	for iter_12_0 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		local var_12_0 = arg_12_0.item[iter_12_0].curPos
		local var_12_1 = DormitoryData:GetRoomIDByPosID(arg_12_0:ChangItemPosToServerPosID(var_12_0))

		arg_12_0.item[iter_12_0]:SetPosAndRoomID(var_12_0, var_12_1)
	end
end

function var_0_0.AddBtnCallBack(arg_13_0, arg_13_1)
	arg_13_1:ClickItemCallBack(function(arg_14_0)
		arg_13_0:ClickRoom(arg_14_0.roomID, arg_14_0.oriPos)
	end)
	arg_13_1:StartDrag(function(arg_15_0)
		arg_13_0:StartDrag(arg_15_0)
	end)
	arg_13_1:OnDrag(function(arg_16_0)
		arg_13_0:OnDrag(arg_16_0)
	end)
	arg_13_1:EndDrag(function(arg_17_0)
		arg_13_0:EndDrag(arg_17_0)
	end)
end

function var_0_0.ClickRoom(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0.edit then
		arg_18_0.selPos = arg_18_2

		if arg_18_1 then
			if DormData:GetCurrectSceneID() == arg_18_1 then
				JumpTools.OpenPageByJump("/dorm")
				DormHeroTools:ShowVisitTalk()

				return
			end

			if BackHomeCfg[arg_18_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				BackHomeTools:GotoBackHomeRoom(arg_18_1)
			elseif BackHomeCfg[arg_18_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				local var_18_0 = DormRoomTools:GetPrivateDormRoomState(arg_18_1)

				if var_18_0 == DormEnum.DormRoomUseState.Unlock then
					JumpTools.OpenPageByJump("dormUnLockRoomConfirmView", {
						roomID = arg_18_1
					})
				elseif var_18_0 == DormEnum.DormRoomUseState.HadPlace then
					BackHomeTools:GotoBackHomeRoom(arg_18_1)
				end
			end
		else
			if arg_18_0.unLockRoomID then
				return
			end

			arg_18_0.unLockRoomID = DormRoomTools:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1

			local var_18_1 = arg_18_0:ChangItemPosToServerPosID(arg_18_2)
			local var_18_2 = BackHomeCfg[arg_18_0.unLockRoomID].unlock_cost[1]

			if arg_18_0.unLockRoomID then
				if var_18_2 then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(var_18_2[1]), var_18_2[2], GetTips("DORM_UNLOCK_COST_TIPS2")),
						OkCallback = function()
							arg_18_0:PopCostCallBack()
						end,
						CancelCallback = function()
							arg_18_0.unLockRoomID = nil
						end
					})
				else
					DormAction:UnLockDormArchitecture(arg_18_0.unLockRoomID, var_18_1)

					arg_18_0.unLockRoomID = nil
				end
			end
		end
	end
end

local function var_0_1(arg_21_0, arg_21_1)
	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_21_1, arg_21_0, var_0_0.GetUICam())
end

function var_0_0.OnDrag(arg_22_0, arg_22_1)
	if arg_22_1.heroID and arg_22_0.edit then
		local var_22_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
		local var_22_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
		local var_22_2 = {}
		local var_22_3, var_22_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_22_0.fatherTrs, var_22_0, var_22_1, var_22_2)

		arg_22_1.transform_.localPosition = var_22_4

		local var_22_5 = arg_22_0:FindHoverOnItem(arg_22_1, var_22_0)

		if var_22_5 then
			arg_22_0:MoveItemToEmptyPos(var_22_5)
			arg_22_1.transform_:SetAsLastSibling()
		end
	end
end

function var_0_0.FindHoverOnItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.floor == 1 and DormConst.DORM_FIRST_FLOOR_ROOM_NUM or DormConst.DORM_FLOOR_ROOM_NUM

	for iter_23_0 = 1, var_23_0 do
		local var_23_1 = arg_23_0.item[iter_23_0]

		if var_23_1 ~= arg_23_1 and var_0_1(arg_23_2, var_23_1.buttonBtn_.transform) then
			return var_23_1
		end
	end
end

function var_0_0.MoveItemToEmptyPos(arg_24_0, arg_24_1)
	if arg_24_0.edit and arg_24_0.dragPos ~= arg_24_1.oriPos and not arg_24_1.move then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.itemPosition) do
			if not iter_24_1.has then
				local var_24_0 = arg_24_1.curPos

				arg_24_1.move = true
				arg_24_0.itemPosition[var_24_0].has = false
				iter_24_1.has = true
				arg_24_0.tweenValue_ = LeanTween.value(0, 1, arg_24_0.time):setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					local var_25_0 = Vector3.Lerp(arg_24_1.transform_.localPosition, arg_24_0.itemPosition[iter_24_0].pos, arg_25_0)

					arg_24_1.transform_.localPosition = var_25_0
				end)):setOnComplete(LuaHelper.VoidAction(function()
					arg_24_1.curPos = iter_24_0

					if iter_24_0 > DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
						arg_24_1.transform_:SetParent(arg_24_0.centerTrs, false)
					else
						arg_24_1.transform_:SetParent(arg_24_0.fatherTrs, false)
					end

					arg_24_1.move = false

					arg_24_1.transform_:SetSiblingIndex(arg_24_0.itemPosition[iter_24_0].slibing)
				end)):setEase(LeanTweenType.easeOutQuad)

				return
			end
		end
	end
end

function var_0_0.StartDrag(arg_27_0, arg_27_1)
	if not arg_27_0.edit and arg_27_1.heroID and DormRoomTools:GetPrivateDormRoomState(arg_27_1.roomID) == DormEnum.DormRoomUseState.HadPlace then
		arg_27_0.edit = true
		arg_27_0.dragPos = arg_27_1.curPos

		arg_27_1.roomStateController:SetSelectedState("select")
		arg_27_1.transform_:SetParent(arg_27_0.fatherTrs, false)
		arg_27_1.transform_:SetAsLastSibling()

		arg_27_0.itemPosition[arg_27_1.oriPos].has = false
		arg_27_1.bgCanvas.overrideSorting = false
	end
end

function var_0_0.EndDrag(arg_28_0, arg_28_1)
	if arg_28_0.edit and arg_28_1.heroID then
		arg_28_1.roomStateController:SetSelectedState("normal")

		for iter_28_0, iter_28_1 in pairs(arg_28_0.itemPosition) do
			if not iter_28_1.has then
				iter_28_1.has = true
				arg_28_0.tweenValue_ = LeanTween.value(0, 1, arg_28_0.time):setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					local var_29_0 = Vector3.Lerp(arg_28_1.transform_.localPosition, arg_28_0.itemPosition[iter_28_0].pos, arg_29_0)

					arg_28_1.transform_.localPosition = var_29_0
				end)):setOnComplete(LuaHelper.VoidAction(function()
					arg_28_1.curPos = iter_28_0

					if iter_28_0 > DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
						arg_28_1.transform_:SetParent(arg_28_0.centerTrs, false)
					else
						arg_28_1.transform_:SetParent(arg_28_0.fatherTrs, false)
					end

					arg_28_1.transform_:SetSiblingIndex(arg_28_0.itemPosition[iter_28_0].slibing)
					arg_28_0.centerTrs:SetAsFirstSibling()

					arg_28_0.edit = false
					arg_28_0.dragPos = nil

					arg_28_0:RevisePrivateDormPos()

					arg_28_1.bgCanvas.overrideSorting = true
				end)):setEase(LeanTweenType.easeOutQuad)

				return
			end
		end
	end
end

function var_0_0.RegisterEvents(arg_31_0)
	arg_31_0:RegistEventListener(BACKHOME_VISIT_INFO_UPDATE, function()
		arg_31_0.visitController:SetSelectedState(DormData:CanReceiveVisitReward() and "tips1" or "off")
	end)
	arg_31_0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		arg_31_0:RefreshUI(arg_31_0.floor)
	end)
	arg_31_0:RegistEventListener(DORM_PRIVATE_DORM_CHANGE, function(arg_34_0)
		local var_34_0 = DormitoryData:GetDormSceneData(arg_34_0).pos_id
		local var_34_1 = var_34_0 - DormConst.DORM_POS_ID_OFFSET
		local var_34_2 = arg_31_0:ChangServerPosIDToItemPos(var_34_0)
		local var_34_3
		local var_34_4
		local var_34_5

		if arg_31_0.floor == 1 then
			var_34_3 = DormConst.DORM_FIRST_FLOOR_ROOM_NUM
			var_34_5 = 1
		else
			var_34_3 = DormConst.DORM_FIRST_FLOOR_ROOM_NUM + (arg_31_0.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM
			var_34_5 = var_34_3 - DormConst.DORM_FLOOR_ROOM_NUM + 1
		end

		if var_34_5 <= var_34_1 and var_34_1 <= var_34_3 then
			local var_34_6 = arg_31_0:GetItemByCurPos(var_34_2)

			if var_34_6 then
				var_34_6.roomID = arg_34_0

				if BackHomeCfg[arg_34_0].type == DormConst.BACKHOME_TYPE.PublicDorm and arg_31_0.floor == 1 then
					arg_31_0:RefreshPublicRoomHeroList()
				elseif BackHomeCfg[arg_34_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
					arg_31_0:GetItemByCurPos(var_34_2):RefreshItemState(true)
				end
			end
		end
	end)
end

function var_0_0.AddUIListener(arg_35_0)
	arg_35_0:AddBtnListener(arg_35_0.publicBtn_, nil, function()
		arg_35_0:ClickRoom(DormConst.PUBLIC_DORM_ID)
	end)
end

function var_0_0.GetItemByCurPos(arg_37_0, arg_37_1)
	if arg_37_0.item then
		for iter_37_0, iter_37_1 in pairs(arg_37_0.item) do
			if iter_37_1.oriPos == arg_37_1 then
				return iter_37_1
			end
		end

		print("未找到对应item")
	end
end

function var_0_0.RevisePrivateDormPos(arg_38_0)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(arg_38_0.item) do
		if iter_38_1.oriPos ~= iter_38_1.curPos then
			iter_38_1.oriPos = iter_38_1.curPos

			local var_38_1 = arg_38_0:ChangItemPosToServerPosID(iter_38_1.curPos)

			if iter_38_1.roomID then
				local var_38_2 = {
					roomID = iter_38_1.roomID,
					posID = var_38_1
				}
				local var_38_3 = DormitoryData:GetDormSceneData(iter_38_1.roomID)

				if DormRoomTools:CheckRoomPosSameLevel(var_38_3.pos_id, var_38_1) then
					table.insert(var_38_0, var_38_2)
				end
			end
		end
	end

	if #var_38_0 > 0 then
		DormAction:RevisePrivateDormPos(var_38_0)
	end
end

function var_0_0.PopCostCallBack(arg_39_0)
	if arg_39_0.unLockRoomID then
		local var_39_0 = BackHomeCfg[arg_39_0.unLockRoomID].unlock_cost[1]
		local var_39_1 = ItemTools.getItemNum(var_39_0[1])

		arg_39_0.unLockRoomID = nil

		if var_39_1 < var_39_0[2] then
			ShowTips(GetTips("DORM_UNLOCK_ITEM_NOT_ENOUGH"))

			return
		end

		local var_39_2 = DormRoomTools:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1
		local var_39_3 = arg_39_0:ChangItemPosToServerPosID(arg_39_0.selPos)

		DormAction:UnLockDormArchitecture(var_39_2, var_39_3)
	end
end

function var_0_0.ChangItemPosToServerPosID(arg_40_0, arg_40_1)
	if arg_40_1 then
		local var_40_0 = DormConst.DORM_POS_ID_OFFSET

		if arg_40_0.floor <= 1 then
			var_40_0 = var_40_0 + arg_40_1
		else
			var_40_0 = var_40_0 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM + (arg_40_0.floor - 2) * DormConst.DORM_FLOOR_ROOM_NUM + arg_40_1
		end

		return var_40_0
	end
end

function var_0_0.ChangServerPosIDToItemPos(arg_41_0, arg_41_1)
	if arg_41_1 then
		local var_41_0 = DormConst.DORM_POS_ID_OFFSET

		if arg_41_0.floor <= 1 then
			var_41_0 = arg_41_1 - var_41_0
		else
			var_41_0 = arg_41_1 - DormConst.DORM_FIRST_FLOOR_ROOM_NUM - (arg_41_0.floor - 2) * DormConst.DORM_FLOOR_ROOM_NUM - var_41_0
		end

		return var_41_0
	end
end

function var_0_0.indexHeroItem(arg_42_0, arg_42_1, arg_42_2)
	arg_42_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_42_2:RefreshUI(arg_42_0.heroList[arg_42_1])
end

function var_0_0.RefreshPublicRoomHeroList(arg_43_0)
	local var_43_0 = DormConst.PUBLIC_DORM_ID
	local var_43_1 = DormitoryData:GetDormSceneData(var_43_0).archiveIDList

	arg_43_0.heroList = {}

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		local var_43_2 = DormData:GetHeroInfo(iter_43_1):GetHeroId()

		table.insert(arg_43_0.heroList, var_43_2)
	end

	arg_43_0.publicHeroScroll:StartScroll(#arg_43_0.heroList)

	if #arg_43_0.heroList == 0 then
		arg_43_0.emptyController:SetSelectedState("false")
	end

	arg_43_0.publicNum.text = string.format("%s/%s", #arg_43_0.heroList, GameSetting.dorm_lobby_hero_max.value[1])

	if DormVisitTools:GetCurTemplateExhibit() == var_43_0 then
		arg_43_0.publicVisitController:SetSelectedState("true")
	else
		arg_43_0.publicVisitController:SetSelectedState("false")
	end
end

function var_0_0.PlayFloorAnimation(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(arg_44_0.item) do
		if iter_44_1.curPos <= DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
			iter_44_1.animation:Play("DormEntranceUI_item_cx", 0)
		elseif arg_44_0.floor ~= GameDisplayCfg.dorm_lobby_layer.value[1] then
			iter_44_1.animation:Play("DormEntranceUI_item_cx", 0)
		end
	end
end

function var_0_0.Dispose(arg_45_0)
	arg_45_0:RemoveAllEventListener()

	if arg_45_0.publicHeroScroll then
		arg_45_0.publicHeroScroll:Dispose()
	end

	if arg_45_0.item then
		for iter_45_0, iter_45_1 in pairs(arg_45_0.item) do
			iter_45_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_45_0)
end

return var_0_0
