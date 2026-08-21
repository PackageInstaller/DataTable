local var_0_0 = class("IdolTraineeCampDeployCharacterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeCampDeployCharaView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.selHeroID = nil
	arg_3_0.dataList = nil
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.characterScroll = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.heroList_, IdolTraineeCampCharacterItem)
	arg_4_0.targets = {}

	for iter_4_0 = 1, arg_4_0.targets_.childCount do
		local var_4_0 = arg_4_0.targets_:GetChild(iter_4_0 - 1)
		local var_4_1 = {}

		arg_4_0:BindCfgUI(var_4_0.gameObject, var_4_1)

		var_4_1.stateController = var_4_1.controllers_:GetController("state")

		table.insert(arg_4_0.targets, {
			trs = var_4_0,
			com = var_4_1
		})
	end

	arg_4_0:RegisterEvents()
	arg_4_0:UpdateCurHeroNum()

	function arg_4_0.selectCharaFunc(arg_5_0)
		local var_5_0 = IdolTraineeCampCharacterItem.curGrabbing

		arg_4_0.selHeroID = var_5_0 and IdolTraineeCampBridge.GetCharacterHeroID(var_5_0) or arg_5_0

		arg_4_0.characterScroll:Refresh()
	end

	arg_4_0.recallHeroFunc = handler(arg_4_0, arg_4_0.RecallHero)

	arg_4_0:AddBtnListenerScale(arg_4_0.backBtn_, nil, function()
		local var_6_0 = {}
		local var_6_1 = IdolTraineeCampBridge.charaAtPos

		for iter_6_0, iter_6_1 in pairs(var_6_1) do
			local var_6_2 = IdolTraineeCampBridge.GetCharacterHeroID(iter_6_1)

			table.insert(var_6_0, {
				hero_id = var_6_2,
				pos = iter_6_0
			})
		end

		IdolTraineeAction.RequestSetHeroPos(var_6_0, function()
			JumpTools.Back()
		end)
	end)
	arg_4_0:AddBtnListenerScale(arg_4_0.quickRecall_, nil, function()
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
			local var_8_1 = IdolTraineeCampBridge.GetCharacterHeroID(iter_8_1)

			if DormData:GetHeroFatigue(var_8_1) < GameSetting.canteen_hero_fatigue_max.value[1] then
				table.insert(var_8_0, {
					hero_id = var_8_1,
					pos = iter_8_0
				})
			end
		end

		IdolTraineeAction.RequestSetHeroPos(var_8_0, function()
			IdolTraineeCampBridge.RefreshCharacterAtPos(false)
			arg_4_0:UpdateCurHeroNum()
			arg_4_0.characterScroll:Refresh()
		end)
	end)
end

function var_0_0.RecallHero(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(IdolTraineeCampBridge.charaAtPos) do
		local var_10_1 = IdolTraineeCampBridge.GetCharacterHeroID(iter_10_1)

		if arg_10_1 ~= var_10_1 then
			table.insert(var_10_0, {
				hero_id = var_10_1,
				pos = iter_10_0
			})
		end
	end

	IdolTraineeAction.RequestSetHeroPos(var_10_0, function()
		IdolTraineeCampBridge.RefreshCharacterAtPos(false)
		arg_10_0:UpdateCurHeroNum()
		arg_10_0.characterScroll:Refresh()
	end)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.dataList[arg_12_1]

	arg_12_2:RefreshUI(arg_12_0, var_12_0)
	arg_12_2:SetOnPointerDown(arg_12_0.selectCharaFunc)
	arg_12_2:RecallHero(arg_12_0.recallHeroFunc)
end

function var_0_0.IndexOf(arg_13_0, arg_13_1)
	return table.indexof(arg_13_0.dataList, arg_13_0.heroID)
end

function var_0_0.RefreshDormHeroList(arg_14_0)
	arg_14_0.dataList = IdolTraineeData:GetIdolHeroList()

	arg_14_0:SortHeroList()
	arg_14_0.characterScroll:StartScroll(#arg_14_0.dataList)
end

function var_0_0.SortHeroList(arg_15_0)
	local var_15_0 = {
		[DormEnum.DormHeroState.InCanteenJob] = "canteen",
		[DormEnum.DormHeroState.InCanteenEntrust] = "task",
		[DormEnum.DormHeroState.InPublicDorm] = "lobby",
		[DormEnum.DormHeroState.InIdolTraineeCamp] = "idolCamp"
	}
	local var_15_1 = {
		[DormEnum.DormHeroState.InCanteenJob] = true,
		[DormEnum.DormHeroState.InCanteenEntrust] = true,
		[DormEnum.DormHeroState.InPublicDorm] = true,
		[DormEnum.DormHeroState.InPrivateDorm] = true,
		[DormEnum.DormHeroState.InIdolTraineeCamp] = true
	}

	CommonTools.UniversalSortEx(arg_15_0.dataList, {
		map = function(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = DormData:GetHeroTemplateInfo(arg_16_0):GetHeroState()
			local var_16_2 = nullable(var_15_0, var_16_1) or "dorm"

			if not nullable(var_15_1, var_16_1) then
				return 1
			end

			if var_16_2 == "idolCamp" then
				return 2
			end

			return 0
		end
	}, {
		map = function(arg_17_0)
			return (DormData:GetHeroArchiveID(arg_17_0))
		end
	}, {
		map = function(arg_18_0)
			return -arg_18_0
		end
	})
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0:RefreshDormHeroList()
	arg_19_0:UpdateCurHeroNum()
end

function var_0_0.OnExit(arg_20_0)
	arg_20_0.selHeroID = nil
end

function var_0_0.OnTop(arg_21_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_22_0)
	IdolTraineeCampCharacterItem.curDragging = nil

	arg_22_0.characterScroll:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.RegisterEvents(arg_23_0)
	arg_23_0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function()
		arg_23_0.characterScroll:Refresh()
		arg_23_0:UpdateCurHeroNum()
	end)
	arg_23_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		arg_23_0.characterScroll:Refresh()
	end)
end

function var_0_0.UpdateCurHeroNum(arg_26_0)
	arg_26_0.curnumText_.text = IdolTraineeCampBridge.entityManager:EntityNum()
end

function var_0_0.SetCharacterAtPos(arg_27_0, arg_27_1, arg_27_2)
	IdolTraineeCampBridge.SetPosOfCharacter(arg_27_1, arg_27_2, true)
end

function var_0_0.SnapCharacterOnTarget(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = nullable(Dorm.storage:PickData("idol.camp.pos." .. arg_28_2), "transform")

	if var_28_0 then
		Dorm.DormEntityManager.PutEntityAt(arg_28_1, var_28_0)

		return true
	end
end

function var_0_0.NotDragOutYet(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.position
	local var_29_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_29_0.dragOutRect_, var_29_0, var_29_1)
end

function var_0_0.BeginDragHeroList(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.heroList_:OnBeginDrag(arg_30_1)

	arg_30_0.isDraggingHeroList = true

	if arg_30_2 and arg_30_2:IsDragBlocked() then
		return
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0.targets) do
		iter_30_1.com.stateController:SetSelectedState("show")
	end
end

function var_0_0.DragHeroList(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.heroList_:OnDrag(arg_31_1)
end

function var_0_0.EndDragHeroList(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0.isDraggingHeroList then
		arg_32_0.heroList_:OnEndDrag(arg_32_1)

		for iter_32_0, iter_32_1 in pairs(arg_32_0.targets) do
			iter_32_1.com.stateController:SetSelectedState("hide")
		end
	end
end

function var_0_0.HoverHightDragOnTarget(arg_33_0, arg_33_1, arg_33_2)
	for iter_33_0 = 1, #arg_33_0.targets do
		arg_33_0.targets[iter_33_0].com.stateController:SetSelectedState(iter_33_0 == arg_33_2 and "highlight" or "show")
	end
end

return var_0_0
