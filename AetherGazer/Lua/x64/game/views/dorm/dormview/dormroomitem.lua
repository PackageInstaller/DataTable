local var_0_0 = class("DormRoomItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.roomStateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.roomDetailController = ControllerUtil.GetController(arg_2_0.transform_, "detail")
	arg_2_0.heroIconController = ControllerUtil.GetController(arg_2_0.transform_, "hero")
	arg_2_0.visitController = ControllerUtil.GetController(arg_2_0.transform_, "visit")
	arg_2_0.move = false
	arg_2_0.animation = arg_2_0.gameObject_:GetComponent("Animation")
	arg_2_0.heroItem = BackHomeNewHeroItem.New(arg_2_0.heroItemGo_)

	arg_2_0.heroItem:SetItemFunction({
		showFatigue = true,
		showState = true
	})

	arg_2_0.textCanvas = arg_2_0.detailsGo_:GetComponent("Canvas")
	arg_2_0.bgCanvas = arg_2_0.bgGo_:GetComponent("Canvas")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddPressByTimeListener(arg_3_0.buttonBtn_.gameObject, GameDisplayCfg.dorm_area_swap_time.value[1], function()
		if arg_3_0.clickFunc then
			arg_3_0:clickFunc()
		end
	end, function(arg_5_0, arg_5_1, arg_5_2)
		if arg_3_0.startDrag then
			arg_3_0:startDrag()
		end
	end, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_3_0.endDrag then
			arg_3_0:endDrag()
		end
	end, arg_3_0.oriPos)
	arg_3_0:AddDragListener(arg_3_0.buttonBtn_.gameObject, function()
		return
	end, function()
		if arg_3_0.onDrag then
			arg_3_0:onDrag()
		end
	end, function()
		return
	end)
end

function var_0_0.SetPosAndRoomID(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.oriPos = arg_10_1
	arg_10_0.roomID = arg_10_2
	arg_10_0.curPos = arg_10_1
end

function var_0_0.RefreshItemState(arg_11_0, arg_11_1)
	arg_11_0.roomDetailController:SetSelectedState("false")
	arg_11_0.heroIconController:SetSelectedState("false")
	arg_11_0.visitController:SetSelectedState("false")

	if arg_11_0.roomID then
		local var_11_0 = DormRoomTools:GetPrivateDormRoomState(arg_11_0.roomID)

		if var_11_0 == DormEnum.DormRoomUseState.Lock then
			arg_11_0.roomStateController:SetSelectedState("lock")
		elseif var_11_0 == DormEnum.DormRoomUseState.Unlock then
			arg_11_0.roomStateController:SetSelectedState("unlock")

			if arg_11_1 then
				arg_11_0.animation:Play("DormEntranceUI_item_unlock")
			end
		elseif var_11_0 == DormEnum.DormRoomUseState.HadPlace then
			arg_11_0.roomStateController:SetSelectedState("normal")

			if arg_11_0.roomID == DormVisitTools:GetCurTemplateExhibit() then
				arg_11_0.visitController:SetSelectedState("true")
			end

			local var_11_1 = DormitoryData:GetDormSceneData(arg_11_0.roomID).archiveIDList

			if var_11_1 and #var_11_1 > 0 then
				arg_11_0.roomStateController:SetSelectedState("true")
				arg_11_0.roomDetailController:SetSelectedState("true")

				local var_11_2 = var_11_1[1]
				local var_11_3 = DormData:GetHeroInfoList()[var_11_2]

				arg_11_0.heroID = var_11_3.hero_id
				arg_11_0.comfortNum.text = DormitoryData:GetDormExp(arg_11_0.roomID)
				arg_11_0.levelNum.text = DormitoryData:GetDormLevel(arg_11_0.roomID)
				arg_11_0.heroName.text = HeroRecordCfg[var_11_2].name

				local var_11_4 = var_11_3:GetHeroState()

				arg_11_0.heroIconController:SetSelectedState("true")
				arg_11_0.heroItem:RefreshUI(arg_11_0.heroID)
			end
		end
	else
		arg_11_0.roomStateController:SetSelectedState("lock")
	end
end

function var_0_0.ClickItemCallBack(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0.clickFunc = arg_12_1
	end
end

function var_0_0.StartDrag(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.startDrag = arg_13_1
	end
end

function var_0_0.OnDrag(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.onDrag = arg_14_1
	end
end

function var_0_0.EndDrag(arg_15_0, arg_15_1)
	if arg_15_1 then
		arg_15_0.endDrag = arg_15_1
	end
end

function var_0_0.ChangePosition(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0.changePositionFunc = arg_16_1
	end
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	arg_17_0.heroItem:Dispose()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
