local DromPrivateRoomItem = class("DromPrivateRoomItem", ReduxView)

function DromPrivateRoomItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DromPrivateRoomItem:InitUI()
	self:BindCfgUI()

	self.publicHeroScroll = LuaList.New(handler(self, self.indexHeroItem), self.uilistGo_, BackHomeNewHeroItem)
	self.publicStateController = ControllerUtil.GetController(self.transform_, "roomType")
	self.visitController = ControllerUtil.GetController(self.transform_, "tips")
	self.emptyController = ControllerUtil.GetController(self.uilistGo_.transform, "empty")
	self.publicVisitController = ControllerUtil.GetController(self.publicGo_.transform, "visit")
	self.floorAniamtion = self.dimianGo_:GetComponent("Animation")
	self.edit = false
	self.time = 2 / GameDisplayCfg.dorm_area_swap_speed.value[1]

	self:InitPrivateRoomItemInfo()
	self:RegisterEvents()
	self:AddUIListener()
end

function DromPrivateRoomItem:InitPrivateRoomItemInfo()
	self.itemPosition = {}
	self.item = {}

	for iter_3_0 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		self.item[iter_3_0] = DormRoomItem.New(self["item" .. iter_3_0 .. "Go_"])

		self.item[iter_3_0]:SetPosAndRoomID(iter_3_0)
		self:AddBtnCallBack(self.item[iter_3_0])

		self.itemPosition[iter_3_0] = {}
		self.itemPosition[iter_3_0].has = true
		self.itemPosition[iter_3_0].pos = Vector3.New(self.item[iter_3_0].transform_.localPosition.x, self.item[iter_3_0].transform_.localPosition.y, self.item[iter_3_0].transform_.localPosition.z)
	end

	self.itemPosition[1].slibing = 6
	self.itemPosition[2].slibing = 2
	self.itemPosition[3].slibing = 5
	self.itemPosition[4].slibing = 7
	self.itemPosition[5].slibing = 3
	self.itemPosition[6].slibing = 1
	self.itemPosition[7].slibing = 4
	self.itemPosition[8].slibing = 8
	self.itemPosition[9].slibing = 8
	self.itemPosition[10].slibing = 8
	self.itemPosition[11].slibing = 8

	for iter_3_1 = 1, DormConst.DORM_FIRST_FLOOR_ROOM_NUM do
		self.item[iter_3_1].transform_:SetSiblingIndex(self.itemPosition[iter_3_1].slibing)
	end
end

function DromPrivateRoomItem:OnBehind()
	self:SetItemCanvasSortOrder(true)
end

function DromPrivateRoomItem:SetItemCanvasSortOrder(arg_5_1)
	if self.item then
		for iter_5_0, iter_5_1 in ipairs(self.item) do
			iter_5_1.bgCanvas.overrideSorting = arg_5_1
		end
	end
end

function DromPrivateRoomItem:OnEnter()
	self.visitController:SetSelectedState(DormData:CanReceiveVisitReward() and "tips1" or "off")
end

function DromPrivateRoomItem:OnTop()
	if self.floor then
		self:RefreshUI(self.floor)
	end

	self.visitController:SetSelectedState(DormData:CanReceiveVisitReward() and "tips1" or "off")
end

function DromPrivateRoomItem:OnUpdate()
	return
end

function DromPrivateRoomItem:StartGuide()
	return
end

function DromPrivateRoomItem:OnExit()
	self:SetItemCanvasSortOrder(true)
end

function DromPrivateRoomItem:RefreshUI(arg_11_1)
	if not arg_11_1 then
		return
	end

	self.floor = arg_11_1

	if arg_11_1 == GameDisplayCfg.dorm_lobby_layer.value[1] then
		self.publicStateController:SetSelectedState("public")
		self:RefreshPublicRoomHeroList()
	else
		self.publicStateController:SetSelectedState("private")
	end

	self:InitRoomPos()

	for iter_11_0 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		self.item[iter_11_0]:RefreshItemState()
	end
end

function DromPrivateRoomItem:InitRoomPos()
	for iter_12_0 = 1, DormConst.DORM_FLOOR_ROOM_NUM do
		self.item[iter_12_0]:SetPosAndRoomID(self.item[iter_12_0].curPos, (DormitoryData:GetRoomIDByPosID(self:ChangItemPosToServerPosID(self.item[iter_12_0].curPos))))
	end
end

function DromPrivateRoomItem:AddBtnCallBack(arg_13_1)
	arg_13_1:ClickItemCallBack(function(arg_14_0)
		self:ClickRoom(arg_14_0.roomID, arg_14_0.oriPos)
	end)
	arg_13_1:StartDrag(function(arg_15_0)
		self:StartDrag(arg_15_0)
	end)
	arg_13_1:OnDrag(function(arg_16_0)
		self:OnDrag(arg_16_0)
	end)
	arg_13_1:EndDrag(function(arg_17_0)
		self:EndDrag(arg_17_0)
	end)
end

function DromPrivateRoomItem:ClickRoom(arg_18_1, arg_18_2)
	if not self.edit then
		self.selPos = arg_18_2

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
			if self.unLockRoomID then
				return
			end

			self.unLockRoomID = DormRoomTools:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1

			if self.unLockRoomID then
				if BackHomeCfg[self.unLockRoomID].unlock_cost[1] then
					ShowMessageBox({
						title = GetTips("PROMPT"),
						content = string.format(GetTips("TIP_ITEM_COST"), ItemTools.getItemName(BackHomeCfg[self.unLockRoomID].unlock_cost[1][1]), BackHomeCfg[self.unLockRoomID].unlock_cost[1][2], GetTips("DORM_UNLOCK_COST_TIPS2")),
						OkCallback = function()
							self:PopCostCallBack()
						end,
						CancelCallback = function()
							self.unLockRoomID = nil
						end
					})
				else
					DormAction:UnLockDormArchitecture(self.unLockRoomID, (self:ChangItemPosToServerPosID(arg_18_2)))

					self.unLockRoomID = nil
				end
			end
		end
	end
end

local function var_0_1(arg_21_0, arg_21_1)
	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_21_1, arg_21_0, DromPrivateRoomItem.GetUICam())
end

function DromPrivateRoomItem:OnDrag(arg_22_1)
	if arg_22_1.heroID and self.edit then
		local var_22_0 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
		local var_22_1, var_22_2 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.fatherTrs, var_22_0, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

		arg_22_1.transform_.localPosition = var_22_2

		local var_22_3 = self:FindHoverOnItem(arg_22_1, var_22_0)

		if var_22_3 then
			self:MoveItemToEmptyPos(var_22_3)
			arg_22_1.transform_:SetAsLastSibling()
		end
	end
end

function DromPrivateRoomItem:FindHoverOnItem(arg_23_1, arg_23_2)
	for iter_23_0 = 1, (self.floor == 1 or nil) and (DormConst.DORM_FIRST_FLOOR_ROOM_NUM or DormConst.DORM_FLOOR_ROOM_NUM) do
		if self.item[iter_23_0] ~= arg_23_1 and var_0_1(arg_23_2, self.item[iter_23_0].buttonBtn_.transform) then
			return self.item[iter_23_0]
		end
	end
end

function DromPrivateRoomItem:MoveItemToEmptyPos(arg_24_1)
	if self.edit and self.dragPos ~= arg_24_1.oriPos and not arg_24_1.move then
		for iter_24_0, iter_24_1 in pairs(self.itemPosition) do
			if not iter_24_1.has then
				arg_24_1.move = true
				self.itemPosition[arg_24_1.curPos].has = false
				iter_24_1.has = true
				self.tweenValue_ = LeanTween.value(0, 1, self.time):setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_24_1.transform_.localPosition = Vector3.Lerp(arg_24_1.transform_.localPosition, self.itemPosition[iter_24_0].pos, arg_25_0)
				end)):setOnComplete(LuaHelper.VoidAction(function()
					arg_24_1.curPos = iter_24_0

					if iter_24_0 > DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
						arg_24_1.transform_:SetParent(self.centerTrs, false)
					else
						arg_24_1.transform_:SetParent(self.fatherTrs, false)
					end

					arg_24_1.move = false

					arg_24_1.transform_:SetSiblingIndex(self.itemPosition[iter_24_0].slibing)
				end)):setEase(LeanTweenType.easeOutQuad)

				return
			end
		end
	end
end

function DromPrivateRoomItem:StartDrag(arg_27_1)
	if not self.edit and arg_27_1.heroID and DormRoomTools:GetPrivateDormRoomState(arg_27_1.roomID) == DormEnum.DormRoomUseState.HadPlace then
		self.edit = true
		self.dragPos = arg_27_1.curPos

		arg_27_1.roomStateController:SetSelectedState("select")
		arg_27_1.transform_:SetParent(self.fatherTrs, false)
		arg_27_1.transform_:SetAsLastSibling()

		self.itemPosition[arg_27_1.oriPos].has = false
		arg_27_1.bgCanvas.overrideSorting = false
	end
end

function DromPrivateRoomItem:EndDrag(arg_28_1)
	if self.edit and arg_28_1.heroID then
		arg_28_1.roomStateController:SetSelectedState("normal")

		for iter_28_0, iter_28_1 in pairs(self.itemPosition) do
			if not iter_28_1.has then
				iter_28_1.has = true
				self.tweenValue_ = LeanTween.value(0, 1, self.time):setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_28_1.transform_.localPosition = Vector3.Lerp(arg_28_1.transform_.localPosition, self.itemPosition[iter_28_0].pos, arg_29_0)
				end)):setOnComplete(LuaHelper.VoidAction(function()
					arg_28_1.curPos = iter_28_0

					if iter_28_0 > DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
						arg_28_1.transform_:SetParent(self.centerTrs, false)
					else
						arg_28_1.transform_:SetParent(self.fatherTrs, false)
					end

					arg_28_1.transform_:SetSiblingIndex(self.itemPosition[iter_28_0].slibing)
					self.centerTrs:SetAsFirstSibling()

					self.edit = false
					self.dragPos = nil

					self:RevisePrivateDormPos()

					arg_28_1.bgCanvas.overrideSorting = true
				end)):setEase(LeanTweenType.easeOutQuad)

				return
			end
		end
	end
end

function DromPrivateRoomItem:RegisterEvents()
	self:RegistEventListener(BACKHOME_VISIT_INFO_UPDATE, function()
		self.visitController:SetSelectedState(DormData:CanReceiveVisitReward() and "tips1" or "off")
	end)
	self:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		self:RefreshUI(self.floor)
	end)
	self:RegistEventListener(DORM_PRIVATE_DORM_CHANGE, function(arg_34_0)
		local var_34_0 = DormitoryData:GetDormSceneData(arg_34_0).pos_id
		local var_34_1 = var_34_0 - DormConst.DORM_POS_ID_OFFSET
		local var_34_2 = self:ChangServerPosIDToItemPos(var_34_0)
		local var_34_3
		local var_34_5

		if self.floor == 1 then
			var_34_3 = DormConst.DORM_FIRST_FLOOR_ROOM_NUM
			var_34_5 = 1
		else
			var_34_3 = DormConst.DORM_FIRST_FLOOR_ROOM_NUM + (self.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM
			var_34_5 = DormConst.DORM_FIRST_FLOOR_ROOM_NUM + (self.floor - 1) * DormConst.DORM_FLOOR_ROOM_NUM - DormConst.DORM_FLOOR_ROOM_NUM + 1
		end

		if var_34_5 <= var_34_1 and var_34_1 <= var_34_3 then
			local var_34_6 = self:GetItemByCurPos(var_34_2)

			if var_34_6 then
				var_34_6.roomID = arg_34_0

				if BackHomeCfg[arg_34_0].type == DormConst.BACKHOME_TYPE.PublicDorm and self.floor == 1 then
					self:RefreshPublicRoomHeroList()
				elseif BackHomeCfg[arg_34_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
					self:GetItemByCurPos(var_34_2):RefreshItemState(true)
				end
			end
		end
	end)
end

function DromPrivateRoomItem:AddUIListener()
	self:AddBtnListener(self.publicBtn_, nil, function()
		self:ClickRoom(DormConst.PUBLIC_DORM_ID)
	end)
end

function DromPrivateRoomItem:GetItemByCurPos(arg_37_1)
	if self.item then
		for iter_37_0, iter_37_1 in pairs(self.item) do
			if iter_37_1.oriPos == arg_37_1 then
				return iter_37_1
			end
		end

		print("未找到对应item")
	end
end

function DromPrivateRoomItem:RevisePrivateDormPos()
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(self.item) do
		if iter_38_1.oriPos ~= iter_38_1.curPos then
			iter_38_1.oriPos = iter_38_1.curPos

			local var_38_1 = self:ChangItemPosToServerPosID(iter_38_1.curPos)

			if iter_38_1.roomID then
				if DormRoomTools:CheckRoomPosSameLevel(DormitoryData:GetDormSceneData(iter_38_1.roomID).pos_id, var_38_1) then
					table.insert(var_38_0, {
						roomID = iter_38_1.roomID,
						posID = var_38_1
					})
				end
			end
		end
	end

	if #var_38_0 > 0 then
		DormAction:RevisePrivateDormPos(var_38_0)
	end
end

function DromPrivateRoomItem:PopCostCallBack()
	if self.unLockRoomID then
		self.unLockRoomID = nil

		if ItemTools.getItemNum(BackHomeCfg[self.unLockRoomID].unlock_cost[1][1]) < BackHomeCfg[self.unLockRoomID].unlock_cost[1][2] then
			ShowTips(GetTips("DORM_UNLOCK_ITEM_NOT_ENOUGH"))

			return
		end

		DormAction:UnLockDormArchitecture(DormRoomTools:GetUnlockRoomNum() + DormConst.PUBLIC_DORM_ID + 1, (self:ChangItemPosToServerPosID(self.selPos)))
	end
end

function DromPrivateRoomItem:ChangItemPosToServerPosID(arg_40_1)
	if arg_40_1 then
		local var_40_0 = DormConst.DORM_POS_ID_OFFSET

		var_40_0 = self.floor <= 1 and var_40_0 + arg_40_1 or var_40_0 + DormConst.DORM_FIRST_FLOOR_ROOM_NUM + (self.floor - 2) * DormConst.DORM_FLOOR_ROOM_NUM + arg_40_1

		return var_40_0
	end
end

function DromPrivateRoomItem:ChangServerPosIDToItemPos(arg_41_1)
	if arg_41_1 then
		local var_41_0 = DormConst.DORM_POS_ID_OFFSET

		var_41_0 = self.floor <= 1 and arg_41_1 - var_41_0 or arg_41_1 - DormConst.DORM_FIRST_FLOOR_ROOM_NUM - (self.floor - 2) * DormConst.DORM_FLOOR_ROOM_NUM - var_41_0

		return var_41_0
	end
end

function DromPrivateRoomItem:indexHeroItem(arg_42_1, arg_42_2)
	arg_42_2:SetItemFunction({
		showFatigue = true,
		showJobState = true
	})
	arg_42_2:RefreshUI(self.heroList[arg_42_1])
end

function DromPrivateRoomItem:RefreshPublicRoomHeroList()
	self.heroList = {}

	for iter_43_0, iter_43_1 in ipairs(DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList) do
		table.insert(self.heroList, (DormData:GetHeroInfo(iter_43_1):GetHeroId()))
	end

	self.publicHeroScroll:StartScroll(#self.heroList)

	if #self.heroList == 0 then
		self.emptyController:SetSelectedState("false")
	end

	self.publicNum.text = string.format("%s/%s", #self.heroList, GameSetting.dorm_lobby_hero_max.value[1])

	if DormVisitTools:GetCurTemplateExhibit() == DormConst.PUBLIC_DORM_ID then
		self.publicVisitController:SetSelectedState("true")
	else
		self.publicVisitController:SetSelectedState("false")
	end
end

function DromPrivateRoomItem:PlayFloorAnimation()
	for iter_44_0, iter_44_1 in ipairs(self.item) do
		if iter_44_1.curPos <= DormConst.DORM_FIRST_FLOOR_ROOM_NUM then
			iter_44_1.animation:Play("DormEntranceUI_item_cx", 0)
		elseif self.floor ~= GameDisplayCfg.dorm_lobby_layer.value[1] then
			iter_44_1.animation:Play("DormEntranceUI_item_cx", 0)
		end
	end
end

function DromPrivateRoomItem:Dispose()
	self:RemoveAllEventListener()

	if self.publicHeroScroll then
		self.publicHeroScroll:Dispose()
	end

	if self.item then
		for iter_45_0, iter_45_1 in pairs(self.item) do
			iter_45_1:Dispose()
		end
	end

	DromPrivateRoomItem.super.Dispose(self)
end

return DromPrivateRoomItem
