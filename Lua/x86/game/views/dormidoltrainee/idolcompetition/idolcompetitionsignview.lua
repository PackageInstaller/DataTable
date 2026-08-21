local var_0_0 = class("IdolCompetitionSignView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Competition/IdolCompetitionSignupUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curSelectedHero_ = {}
	arg_4_0.style1Data_ = {}
	arg_4_0.style2Data_ = {}
	arg_4_0.style3Data_ = {}
	arg_4_0.selectPosController_ = {}

	local var_4_0 = Asset.Load("Effect/Scene/X104_Formation_HeroPos")

	for iter_4_0 = 1, 3 do
		local var_4_1 = GameObject.Find("WT_RK/WT_XR_Scene/WT_XR_Scene/X104_SceneSteps/X104_Formation_HeroPos_" .. iter_4_0)

		if var_4_1 then
			local var_4_2 = Object.Instantiate(var_4_0, var_4_1.transform)

			if var_4_2 then
				arg_4_0.selectPosController_[iter_4_0] = var_4_2:GetComponent("ControllerExCollection"):GetController("state")
			end
		end
	end

	arg_4_0.signSceneGo_ = GameObject.Find("WT_RK/WT_XR_Scene/WT_XR_Scene")
	arg_4_0.curDraggingPos_ = 0
	arg_4_0.curDraggingID_ = 0
	arg_4_0.curDraggingEID_ = 0
	arg_4_0.snap2DPosTrs_ = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.snap2DPosTrs_[iter_4_1] = arg_4_0["click" .. iter_4_1 .. "Btn_"].gameObject:GetComponent("RectTransform")
	end

	arg_4_0.snap3DPos_ = {}

	for iter_4_2 = 1, 3 do
		local var_4_3 = nullable(Dorm.storage:PickData("idol.camp.pos.competition" .. iter_4_2), "transform")

		arg_4_0.snap3DPos_[iter_4_2] = {
			x = var_4_3.position.x,
			z = var_4_3.position.z
		}
	end

	arg_4_0.coordinateX = {
		left = arg_4_0.snap2DPosTrs_[2]:GetAnchoredPositionX(nil),
		right = arg_4_0.snap2DPosTrs_[3]:GetAnchoredPositionX(nil)
	}
	arg_4_0.style1UIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexMiddleItem), arg_4_0.style1UIList_, EnterBattleStyleListItem)
	arg_4_0.style2UIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexLeftItem), arg_4_0.style2UIList_, EnterBattleStyleListItem)
	arg_4_0.style3UIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexRightItem), arg_4_0.style3UIList_, EnterBattleStyleListItem)
	arg_4_0.titleController_ = arg_4_0.mainControllerEx_:GetController("title")
end

function var_0_0.AddUIListener(arg_5_0)
	for iter_5_0 = 1, 3 do
		arg_5_0["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
			if arg_6_1.dragging then
				return
			end

			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs(arg_5_0.curSelectedHero_) do
				if iter_6_1.heroID ~= 0 then
					var_6_0[iter_6_1.heroID] = true
				end
			end

			JumpTools.OpenPageByJump("/idolCompetitionSignSelect", {
				info = arg_5_0.curSelectedHero_[iter_5_0],
				selected = var_6_0,
				onClick = function(arg_7_0)
					for iter_7_0, iter_7_1 in ipairs(arg_5_0.curSelectedHero_) do
						if iter_7_1.heroID == arg_7_0 then
							iter_7_1.heroID = 0
						end
					end

					arg_5_0.curSelectedHero_[iter_5_0].heroID = arg_7_0

					arg_5_0:UpdateHeroModel()
				end
			})
		end))
		arg_5_0["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
			if arg_5_0.curSelectedHero_[iter_5_0].heroID ~= 0 then
				arg_5_0.curDraggingPos_ = iter_5_0
				arg_5_0.curDraggingID_ = arg_5_0.curSelectedHero_[arg_5_0.curDraggingPos_].heroID
				arg_5_0.curSelectedHero_[arg_5_0.curDraggingPos_].heroID = 0

				local var_8_0 = IdolTraineeCampBridge.GenCharacter(arg_5_0.curDraggingID_)

				if var_8_0 then
					arg_5_0.curDraggingEID_ = var_8_0
				end

				arg_5_0:UpdateHeroModel()
			else
				arg_5_0.curDraggingPos_ = 0
			end
		end))
		arg_5_0["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
			local var_9_0 = arg_5_0:CanDrop(arg_9_1)

			if var_9_0 then
				arg_5_0.curSelectedHero_[arg_5_0.curDraggingPos_].heroID = arg_5_0.curSelectedHero_[var_9_0].heroID
				arg_5_0.curSelectedHero_[var_9_0].heroID = 0
				arg_5_0.curDraggingPos_ = var_9_0

				arg_5_0:UpdateHeroModel()
			end
		end))
		arg_5_0["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
			arg_5_0.curSelectedHero_[arg_5_0.curDraggingPos_].heroID = arg_5_0.curDraggingID_

			arg_5_0:UpdateHeroModel()

			arg_5_0.curDraggingPos_ = 0
			arg_5_0.curDraggingID_ = 0

			if arg_5_0.curDraggingEID_ ~= 0 then
				IdolTraineeCampBridge.RemoveEntity(arg_5_0.curDraggingEID_)

				arg_5_0.curDraggingEID_ = 0
			end
		end))
	end

	arg_5_0:AddBtnListener(arg_5_0.signBtn_, nil, function()
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(arg_5_0.curSelectedHero_) do
			if iter_11_1.heroID == 0 then
				ShowTips("IDOL_COMPETITION_SIGN_FAIL")

				return
			end

			table.insert(var_11_0, {
				stage_id = iter_11_1.stageID,
				hero_id = iter_11_1.heroID
			})
		end

		IdolCompetitionAction.RequestSignUpForRace(arg_5_0.raceActivityID_, var_11_0, function()
			arg_5_0:Back()
		end)
	end)
end

function var_0_0.CanDrop(arg_13_0, arg_13_1)
	if arg_13_0.curDraggingPos_ ~= 0 and arg_13_0.curDraggingID_ ~= 0 and arg_13_0.curDraggingEID_ ~= 0 then
		local var_13_0 = arg_13_1.position
		local var_13_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
		local var_13_2 = LuaHelper.ScreenToLocal(arg_13_0.midTrs_, var_13_0, var_13_1)
		local var_13_3 = math.min(math.max((var_13_2.x - arg_13_0.coordinateX.left) / (arg_13_0.coordinateX.right - arg_13_0.coordinateX.left), 0), 1)
		local var_13_4

		if var_13_3 < 0.2 then
			if arg_13_0.curDraggingPos_ ~= 2 then
				var_13_4 = 2
			end
		elseif var_13_3 >= 0.3 and var_13_3 < 0.7 then
			if arg_13_0.curDraggingPos_ ~= 1 then
				var_13_4 = 1
			end
		elseif var_13_3 >= 0.8 and arg_13_0.curDraggingPos_ ~= 3 then
			var_13_4 = 3
		end

		local var_13_5

		if var_13_3 > 0.5 then
			var_13_3 = (var_13_3 - 0.5) * 2
			var_13_5 = Vector3.New(arg_13_0.snap3DPos_[3].x * var_13_3 + arg_13_0.snap3DPos_[1].x * (1 - var_13_3), 0, arg_13_0.snap3DPos_[3].z * var_13_3 + arg_13_0.snap3DPos_[1].z * (1 - var_13_3))
		else
			local var_13_6 = var_13_3 * 2

			var_13_5 = Vector3.New(arg_13_0.snap3DPos_[1].x * var_13_6 + arg_13_0.snap3DPos_[2].x * (1 - var_13_6), 0, arg_13_0.snap3DPos_[1].z * var_13_6 + arg_13_0.snap3DPos_[2].z * (1 - var_13_6))
		end

		Dorm.DormEntityManager.PutEntityAt(arg_13_0.curDraggingEID_, var_13_5)

		return var_13_4
	end
end

function var_0_0.BeginDragHero(arg_14_0)
	if arg_14_0.curSelectedHero_[arg_14_0.curDraggingPos_].heroID ~= 0 then
		arg_14_0.curDraggingID_ = arg_14_0.curSelectedHero_[arg_14_0.curDraggingPos_].heroID
		arg_14_0.curSelectedHero_[arg_14_0.curDraggingPos_].heroID = 0

		local var_14_0 = IdolTraineeCampBridge.GenCharacter(heroID)

		if var_14_0 then
			arg_14_0.curDraggingEID_ = var_14_0
		end

		arg_14_0:UpdateHeroModel()
	end
end

function var_0_0.RemoveDragHero(arg_15_0)
	if arg_15_0.curDraggingEID_ ~= 0 then
		IdolTraineeCampBridge.RemoveEntity(arg_15_0.curDraggingEID_)

		arg_15_0.curDraggingID_ = 0
		arg_15_0.curDraggingEID_ = 0
	end
end

function var_0_0.IndexMiddleItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_0.style1Data_[arg_16_1])
end

function var_0_0.IndexLeftItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:SetData(arg_17_0.style2Data_[arg_17_1])
end

function var_0_0.IndexRightItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2:SetData(arg_18_0.style3Data_[arg_18_1])
end

function var_0_0.OnEnter(arg_19_0)
	saveData("IdolCompetition", "click_time", _G.gameTimer:GetNextDayFreshTime())
	manager.redPoint:setTip(RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN, 0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_19_0.curSelectedHero_ = {}

		arg_19_0:Back()
	end)
	manager.windowBar:SetGameHelpKey("IDOL_COMPETITION_SIGN_DESC")
	SetActive(arg_19_0.signSceneGo_, true)

	arg_19_0.raceActivityID_ = arg_19_0.params_.activity

	if #arg_19_0.curSelectedHero_ == 0 then
		arg_19_0.curSelectedHero_ = IdolCompetitionData:GetSignUpInfo(arg_19_0.raceActivityID_)

		arg_19_0:UpdateHeroModel()
	end

	arg_19_0.titleController_:SetSelectedState(tostring(arg_19_0.params_.index or 1))
	arg_19_0:UpdateView()
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	SetActive(arg_21_0.signSceneGo_, false)
end

function var_0_0.UpdateHeroModel(arg_22_0)
	IdolTraineeCampBridge.RemoveCompetitionCharacter()

	for iter_22_0 = 1, 3 do
		if arg_22_0.curSelectedHero_[iter_22_0].heroID ~= 0 then
			IdolTraineeCampBridge.SetCompetitionCharacter(arg_22_0.curSelectedHero_[iter_22_0].heroID, iter_22_0)

			if arg_22_0.selectPosController_[iter_22_0] then
				arg_22_0.selectPosController_[iter_22_0]:SetSelectedState("selected")
			end
		elseif arg_22_0.selectPosController_[iter_22_0] then
			arg_22_0.selectPosController_[iter_22_0]:SetSelectedState("empty")
		end
	end
end

function var_0_0.UpdateView(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.curSelectedHero_) do
		local var_23_0 = IdolTraineePvpBattleCfg[iter_23_1.stageID]

		if var_23_0 then
			local var_23_1 = IdolStageSceneCfg[var_23_0.scene_id]

			if var_23_1 then
				arg_23_0["scene" .. iter_23_0 .. "Img_"].spriteAsync = SpritePathCfg.IdolStageIcon.path .. var_23_1.stage_picture
				arg_23_0["name" .. iter_23_0 .. "Text_"].text = var_23_1.scene_show_name
				arg_23_0["style" .. iter_23_0 .. "Data_"] = {}

				for iter_23_2, iter_23_3 in ipairs(var_23_0.peculiarity_rate) do
					if iter_23_3 > 100 then
						table.insert(arg_23_0["style" .. iter_23_0 .. "Data_"], iter_23_2)
					end
				end

				arg_23_0["style" .. iter_23_0 .. "UIList_"]:StartScroll(#arg_23_0["style" .. iter_23_0 .. "Data_"])
			end
		end
	end
end

function var_0_0.Dispose(arg_24_0)
	var_0_0.super.Dispose(arg_24_0)

	if arg_24_0.style1UIList_ then
		arg_24_0.style1UIList_:Dispose()

		arg_24_0.style1UIList_ = nil
	end

	if arg_24_0.style2UIList_ then
		arg_24_0.style2UIList_:Dispose()

		arg_24_0.style2UIList_ = nil
	end

	if arg_24_0.style3UIList_ then
		arg_24_0.style3UIList_:Dispose()

		arg_24_0.style3UIList_ = nil
	end
end

return var_0_0
