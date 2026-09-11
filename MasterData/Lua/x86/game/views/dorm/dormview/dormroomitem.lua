local DormRoomItem = class("DormRoomItem", ReduxView)

function DormRoomItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function DormRoomItem:InitUI()
	self:BindCfgUI()

	self.roomStateController = ControllerUtil.GetController(self.transform_, "state")
	self.roomDetailController = ControllerUtil.GetController(self.transform_, "detail")
	self.heroIconController = ControllerUtil.GetController(self.transform_, "hero")
	self.visitController = ControllerUtil.GetController(self.transform_, "visit")
	self.move = false
	self.animation = self.gameObject_:GetComponent("Animation")
	self.heroItem = BackHomeNewHeroItem.New(self.heroItemGo_)

	self.heroItem:SetItemFunction({
		showFatigue = true,
		showState = true
	})

	self.textCanvas = self.detailsGo_:GetComponent("Canvas")
	self.bgCanvas = self.bgGo_:GetComponent("Canvas")
end

function DormRoomItem:AddUIListener()
	self:AddPressByTimeListener(self.buttonBtn_.gameObject, GameDisplayCfg.dorm_area_swap_time.value[1], function()
		if self.clickFunc then
			self:clickFunc()
		end
	end, function(arg_5_0, arg_5_1, arg_5_2)
		if self.startDrag then
			self:startDrag()
		end
	end, function(arg_6_0, arg_6_1, arg_6_2)
		if self.endDrag then
			self:endDrag()
		end
	end, self.oriPos)
	self:AddDragListener(self.buttonBtn_.gameObject, function()
		return
	end, function()
		if self.onDrag then
			self:onDrag()
		end
	end, function()
		return
	end)
end

function DormRoomItem:SetPosAndRoomID(arg_10_1, arg_10_2)
	self.oriPos = arg_10_1
	self.roomID = arg_10_2
	self.curPos = arg_10_1
end

function DormRoomItem:RefreshItemState(arg_11_1)
	self.roomDetailController:SetSelectedState("false")
	self.heroIconController:SetSelectedState("false")
	self.visitController:SetSelectedState("false")

	if self.roomID then
		local var_11_0 = DormRoomTools:GetPrivateDormRoomState(self.roomID)

		if var_11_0 == DormEnum.DormRoomUseState.Lock then
			self.roomStateController:SetSelectedState("lock")
		elseif var_11_0 == DormEnum.DormRoomUseState.Unlock then
			self.roomStateController:SetSelectedState("unlock")

			if arg_11_1 then
				self.animation:Play("DormEntranceUI_item_unlock")
			end
		elseif var_11_0 == DormEnum.DormRoomUseState.HadPlace then
			self.roomStateController:SetSelectedState("normal")

			if self.roomID == DormVisitTools:GetCurTemplateExhibit() then
				self.visitController:SetSelectedState("true")
			end

			local var_11_1 = DormitoryData:GetDormSceneData(self.roomID).archiveIDList

			if var_11_1 and #var_11_1 > 0 then
				self.roomStateController:SetSelectedState("true")
				self.roomDetailController:SetSelectedState("true")

				local var_11_2 = DormData:GetHeroInfoList()[var_11_1[1]]

				self.heroID = var_11_2.hero_id
				self.comfortNum.text = DormitoryData:GetDormExp(self.roomID)
				self.levelNum.text = DormitoryData:GetDormLevel(self.roomID)
				self.heroName.text = HeroRecordCfg[var_11_1[1]].name

				local var_11_3 = var_11_2:GetHeroState()

				self.heroIconController:SetSelectedState("true")
				self.heroItem:RefreshUI(self.heroID)
			end
		end
	else
		self.roomStateController:SetSelectedState("lock")
	end
end

function DormRoomItem:ClickItemCallBack(arg_12_1)
	if arg_12_1 then
		self.clickFunc = arg_12_1
	end
end

function DormRoomItem:StartDrag(arg_13_1)
	if arg_13_1 then
		self.startDrag = arg_13_1
	end
end

function DormRoomItem:OnDrag(arg_14_1)
	if arg_14_1 then
		self.onDrag = arg_14_1
	end
end

function DormRoomItem:EndDrag(arg_15_1)
	if arg_15_1 then
		self.endDrag = arg_15_1
	end
end

function DormRoomItem:ChangePosition(arg_16_1)
	if arg_16_1 then
		self.changePositionFunc = arg_16_1
	end
end

function DormRoomItem:Dispose()
	self:RemoveAllListeners()
	self.heroItem:Dispose()
	DormRoomItem.super.Dispose(self)
end

return DormRoomItem
