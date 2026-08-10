local var_0_0 = class("QWorldMaxMapView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SandPlay/SandPlay_Map/SandPlay_MapUI"
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

	arg_4_0.mapCom = arg_4_0.m_map:GetComponent(typeof(QWorldMaxMapUI))

	local var_4_0 = QWorldMgr:GetMapId()
	local var_4_1 = SandPlayMapCfg[var_4_0]
	local var_4_2 = "QWWorld/MiniMap/" .. var_4_1.big_map_path
	local var_4_3 = Vector3.New(var_4_1.big_map_center[1], var_4_1.big_map_center[2], var_4_1.big_map_center[3])

	arg_4_0.mapCom:Init(var_4_2, var_4_1.big_map_size[1], var_4_1.big_map_size[2], var_4_1.small_map_rate, var_4_3, var_4_1.bag_map_initialscale, var_4_1.big_map_maxscale, var_4_1.big_map_minscale)

	arg_4_0.mapCom.OnMapUnitSelectAction = System.Action(arg_4_0.OnMapUnitSelectAction, arg_4_0)
	arg_4_0.infoList = LuaList.New(handler(arg_4_0, arg_4_0.IndexInfoItem), arg_4_0.m_infoList, QWorldMaxMapInfoItem)
	arg_4_0.selectList = LuaList.New(handler(arg_4_0, arg_4_0.IndexSelectItem), arg_4_0.m_selectList, QWorldMaxMapSelectItem)
	arg_4_0.selectController = arg_4_0.m_controller:GetController("select")
	arg_4_0.rightController = arg_4_0.m_controller:GetController("right")
	arg_4_0.selectClickHandler = handler(arg_4_0, arg_4_0.SelectClickCallBack)
	arg_4_0.infoClickHandler = handler(arg_4_0, arg_4_0.InfoClickCallBack)
	arg_4_0.condItems_ = {}
	arg_4_0.rewardList = LuaList.New(handler(arg_4_0, arg_4_0.IndexRewardItem), arg_4_0.m_rewardList, CommonItemView)
	arg_4_0.showRewardController = arg_4_0.m_detailController:GetController("showRewards")
	arg_4_0.showdetailController = arg_4_0.m_detailController:GetController("showdetails")
	arg_4_0.btnStateController = arg_4_0.m_detailController:GetController("btnState")
	arg_4_0.followBtnStateController = arg_4_0.m_followBtnController:GetController("btnstate")
	arg_4_0.IconTypeController = arg_4_0.m_iconController:GetController("type")
	arg_4_0.m_teleportLab.text = GetTips("SANDPLAY_TRANSMIT")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_selectMask, nil, function()
		arg_5_0.selectController:SetSelectedIndex(0)
		arg_5_0:SelectEntity(nil)
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_followBtn, nil, function()
		if arg_5_0.curBoardInfo == nil then
			return
		end

		local var_7_0 = QWorldMgr:GetQWorldEntityMgr()
		local var_7_1 = arg_5_0.curBoardInfo.inst.entityId

		if not var_7_0:IsTrack(var_7_1) then
			if QWorldEntityMiniMapTag.Task == arg_5_0.curBoardInfo.tag then
				local var_7_2 = arg_5_0.curBoardInfo:GetMainQuestId()

				QWorldQuestAction.UpdateTrackingMainQuestId(var_7_2, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(var_7_2, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
				end)
			else
				QWorldAction.SendUpdateThingTrackToSDK(var_7_1, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
				var_7_0:TrackId(var_7_1)
			end

			local var_7_3 = arg_5_0.curBoardInfo:GetTag()

			if not SandPlayTakePhotoTools.CheckIsPhotoTag(arg_5_0.curBoardInfo.param) and (QWorldEntityMiniMapTag.Thing == var_7_3 or QWorldEntityMiniMapTag.Hud == var_7_3 and arg_5_0.curBoardInfo:GetTeleportId() == 0) then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SANDPLAY_TELEPORT_NEARBY"),
					OkCallback = function()
						local var_9_0 = arg_5_0.curBoardInfo:GetTeleportId()

						if var_9_0 ~= 0 then
							arg_5_0:Back()
							QWorldTeleport(var_9_0)
						end

						if arg_5_0.curBoardInfo and arg_5_0.curBoardInfo.inst.entityId ~= 0 then
							local var_9_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_5_0.curBoardInfo.inst.entityId):GetPosition()

							arg_5_0:Back()
							QWorldTeleportToNearest(var_9_1)

							return
						end
					end
				})
			end
		else
			QWorldAction.SendUpdateThingTrackToSDK(var_7_1, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.UNTRACK)
			var_7_0:CancelTrack(var_7_1)
			arg_5_0.selectController:SetSelectedIndex(0)
			arg_5_0:SelectEntity(nil)
		end

		if QWorldMgr:GetQWorldEntityMgr():IsTrack(var_7_1) then
			arg_5_0.m_followLab.text = GetTips("SANDPLAY_TRACK_CANCEL")

			arg_5_0.followBtnStateController:SetSelectedState("cancel")
		else
			arg_5_0.m_followLab.text = GetTips("SANDPLAY_TRACK")

			arg_5_0.followBtnStateController:SetSelectedState("go")
		end

		arg_5_0:UpdateRight()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_teleportBtn, nil, function()
		if arg_5_0.curBoardInfo == nil then
			return
		end

		local var_10_0 = arg_5_0.curBoardInfo:GetTeleportId()

		if var_10_0 ~= 0 then
			QWorldUIShow()
			QWorldTeleport(var_10_0)
		end

		if arg_5_0.curBoardInfo and arg_5_0.curBoardInfo.inst.entityId ~= 0 then
			local var_10_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_5_0.curBoardInfo.inst.entityId):GetPosition()

			arg_5_0:Back()
			QWorldTeleportToNearest(var_10_1)

			return
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_playerBtn, nil, function()
		arg_5_0.mapCom:SelectPlayerInMaxMap()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_resetBtn, nil, function()
		ShowMessageBox({
			content = GetTips("SANDPLAY_STUCK_AND_DETACHED_REPEAT"),
			OkCallback = function()
				QWorldMgr:StartBlackFade(0.5, 0.5, 1, function()
					arg_5_0:Back()
					manager.notify:Invoke(QWORLD_TELEPORT, -1)
					QWorldLuaBridge.TeleportToStageOrigin()
				end)
			end
		})
	end)
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0:UpdateLeft()
	arg_16_0:UpdateRight(true)
	arg_16_0.selectController:SetSelectedIndex(0)

	if arg_16_0.params_.selectEntity then
		arg_16_0:SelectClickCallBack(arg_16_0.params_.selectEntity)

		arg_16_0.params_.selectEntity = nil
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:SelectEntity(nil)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.mapCom:Dispose()

	arg_18_0.mapCom = nil

	arg_18_0.selectList:Dispose()
	arg_18_0.infoList:Dispose()
	arg_18_0.rewardList:Dispose()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.condItems_) do
		iter_18_1:Dispose()
	end

	arg_18_0.condItems_ = {}

	var_0_0.super.Dispose(arg_18_0)
end

function var_0_0.UpdateRight(arg_19_0, arg_19_1)
	arg_19_0.miniMapBoardList = QWorldMgr:GetQWorldEntityMgr():GetMiniMapBoardList()

	if arg_19_1 then
		arg_19_0.infoList:StartScroll(#arg_19_0.miniMapBoardList)
	else
		local var_19_0 = arg_19_0.infoList:GetScrolledPosition()

		arg_19_0.infoList:StartScrollWithoutAnimator(#arg_19_0.miniMapBoardList, false)
	end

	arg_19_0.rightController:SetSelectedState(tostring(QWorldMgr:GetMapId() == 1031001))
end

function var_0_0.UpdateLeft(arg_20_0)
	arg_20_0:RefreshCollectProgress()
end

function var_0_0.InfoClickCallBack(arg_21_0, arg_21_1)
	SetActive(arg_21_0.m_selectList.gameObject, false)
	arg_21_0.selectController:SetSelectedIndex(1)
	arg_21_0.mapCom:SelectInMaxMap(arg_21_1.inst.entityId)
	arg_21_0:SelectEntity(arg_21_1)
end

function var_0_0.OnMapUnitSelectAction(arg_22_0)
	local var_22_0 = arg_22_0.mapCom:GetSelectEntityEntityIds()

	arg_22_0.selectEntityIdList = {}

	local var_22_1 = var_22_0.Length - 1

	for iter_22_0 = 0, var_22_1 do
		table.insert(arg_22_0.selectEntityIdList, var_22_0[iter_22_0])
	end

	local var_22_2 = #arg_22_0.selectEntityIdList

	if var_22_2 >= 2 then
		SetActive(arg_22_0.m_selectList.gameObject, true)
		arg_22_0.selectList:StartScroll(#arg_22_0.selectEntityIdList)
	else
		SetActive(arg_22_0.m_selectList.gameObject, false)
	end

	if var_22_2 == 0 then
		arg_22_0.selectController:SetSelectedIndex(0)
		arg_22_0:SelectEntity(nil)
	else
		arg_22_0:SelectClickCallBack(arg_22_0.selectEntityIdList[1])
	end
end

function var_0_0.SelectClickCallBack(arg_23_0, arg_23_1)
	local var_23_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_23_1)

	if var_23_0 and var_23_0.miniMapUnit then
		local var_23_1 = var_23_0.miniMapUnit:GetDefaultBoard()

		arg_23_0.selectController:SetSelectedIndex(1)
		arg_23_0:SelectEntity(var_23_1)
	end

	arg_23_0.mapCom:SelectInMaxMap(arg_23_1)
end

function var_0_0.SelectEntity(arg_24_0, arg_24_1)
	if arg_24_1 ~= arg_24_0.curBoardInfo then
		if arg_24_0.curBoardInfo and arg_24_0.curBoardInfo.inst.miniMapUnit then
			arg_24_0.curBoardInfo.inst.miniMapUnit:SetSelect(false)
		end

		if arg_24_1 then
			arg_24_1.inst.miniMapUnit:SetSelect(true)
		end

		arg_24_0.m_rightAnim:Play("UI_nodeDetailPanel", 0, 0)
	end

	arg_24_0.curBoardInfo = arg_24_1

	if arg_24_1 then
		local var_24_0 = arg_24_1.inst.entityId
		local var_24_1, var_24_2 = arg_24_1:GetName()

		arg_24_0.m_title.text = var_24_1
		arg_24_0.m_desc.text = var_24_2
		arg_24_0.rewards = arg_24_1:GetRewards()

		local var_24_3 = #arg_24_0.rewards

		if var_24_3 > 0 then
			arg_24_0.rewards = formatRewardCfgList(arg_24_0.rewards)
			arg_24_0.rewards = sortReward(arg_24_0.rewards)

			arg_24_0.rewardList:StartScroll(var_24_3)
			arg_24_0.showRewardController:SetSelectedIndex(0)
		else
			arg_24_0.showRewardController:SetSelectedIndex(1)
		end

		arg_24_0:RefreshTask(arg_24_1)

		local var_24_4 = arg_24_1:GetTag()
		local var_24_5 = SandPlayTakePhotoTools.CheckIsPhotoTag(arg_24_1.param)

		if QWorldEntityMiniMapTag.Task == var_24_4 or var_24_5 then
			arg_24_0.btnStateController:SetSelectedState("both")

			if QWorldMgr:GetQWorldEntityMgr():IsTrack(var_24_0) then
				arg_24_0.m_followLab.text = GetTips("SANDPLAY_TRACK_CANCEL")

				arg_24_0.followBtnStateController:SetSelectedState("cancel")
			else
				arg_24_0.m_followLab.text = GetTips("SANDPLAY_TRACK")

				arg_24_0.followBtnStateController:SetSelectedState("go")
			end
		elseif QWorldEntityMiniMapTag.Hud == var_24_4 and arg_24_0.curBoardInfo:GetTeleportId() ~= 0 then
			arg_24_0.btnStateController:SetSelectedState("teleport")
		elseif QWorldEntityMiniMapTag.Thing == var_24_4 or QWorldEntityMiniMapTag.Hud == var_24_4 and arg_24_0.curBoardInfo:GetTeleportId() == 0 then
			arg_24_0.btnStateController:SetSelectedState("follow")

			if QWorldMgr:GetQWorldEntityMgr():IsTrack(var_24_0) then
				arg_24_0.m_followLab.text = GetTips("SANDPLAY_TRACK_CANCEL")

				arg_24_0.followBtnStateController:SetSelectedState("cancel")
			else
				arg_24_0.m_followLab.text = GetTips("SANDPLAY_TRACK")

				arg_24_0.followBtnStateController:SetSelectedState("go")
			end
		else
			arg_24_0.btnStateController:SetSelectedState("null")
		end

		local var_24_6, var_24_7 = arg_24_1:GetIcon()

		arg_24_0.m_icon.sprite = pureGetSpriteWithoutAtlas(var_24_6)

		arg_24_0.IconTypeController:SetSelectedIndex(var_24_7)

		local var_24_8 = false

		if arg_24_1.tag == QWorldEntityMiniMapTag.Hud then
			local var_24_9 = nullable(SandplayTagCfg, arg_24_1.param, "activityId")

			if var_24_9 then
				var_24_8 = manager.redPoint:getTipBoolean(ActivityTools.GetRedPointKey(var_24_9) .. var_24_9)
			end
		end

		manager.redPoint:SetRedPointIndependent(arg_24_0.m_teleportBtn.transform, var_24_8)
	end
end

function var_0_0.RefreshTask(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1:GetTag()

	if QWorldEntityMiniMapTag.Task == var_25_0 then
		local var_25_1 = arg_25_1:GetMainQuestId()

		arg_25_0.questIdList_ = QWorldQuestTool.GetLoadedQuestIdList(var_25_1)

		local var_25_2 = #arg_25_0.questIdList_

		for iter_25_0, iter_25_1 in ipairs(arg_25_0.condItems_) do
			SetActive(iter_25_1.gameObject_, iter_25_0 <= var_25_2)
		end

		for iter_25_2 = 1, var_25_2 do
			local var_25_3 = arg_25_0.condItems_[iter_25_2]

			if not var_25_3 then
				local var_25_4 = Object.Instantiate(arg_25_0.m_detailItem, arg_25_0.m_detailContent)

				SetActive(var_25_4, true)

				var_25_3 = QWorldMaxMapTaskDetailItem.New(var_25_4)
				arg_25_0.condItems_[iter_25_2] = var_25_3
			end

			var_25_3:SetData(arg_25_0.questIdList_[iter_25_2])
		end

		arg_25_0.showdetailController:SetSelectedIndex(0)
	else
		arg_25_0.showdetailController:SetSelectedIndex(1)
	end
end

function var_0_0.IndexInfoItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.miniMapBoardList[arg_26_1]

	arg_26_2:SetData(arg_26_1, var_26_0)
	arg_26_2:RegistCallBack(arg_26_0.infoClickHandler)
end

function var_0_0.IndexSelectItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.selectEntityIdList[arg_27_1]
	local var_27_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(var_27_0)

	if var_27_1 and var_27_1.miniMapUnit then
		local var_27_2 = var_27_1.miniMapUnit:GetDefaultBoard()

		arg_27_2:SetData(var_27_0, var_27_2)
	end

	arg_27_2:RegistCallBack(arg_27_0.selectClickHandler)
end

function var_0_0.IndexRewardItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.rewards[arg_28_1]
	local var_28_1 = clone(ItemTemplateData)

	var_28_1.id = var_28_0.id
	var_28_1.number = var_28_0.num
	var_28_1.race = var_28_0.race

	function var_28_1.clickFun(arg_29_0)
		ShowPopItem(POP_ITEM, {
			arg_29_0.id,
			arg_29_0.number
		})
	end

	arg_28_2:SetData(var_28_1)
end

function var_0_0.RefreshCollectProgress(arg_30_0)
	local var_30_0 = SandplayTaskMainCfg.get_id_list_by_hide_task[2]
	local var_30_1 = SandplayTaskMainCfg.get_id_list_by_hide_task[3]
	local var_30_2, var_30_3 = arg_30_0:CheckCollectQuest(var_30_0)
	local var_30_4, var_30_5 = arg_30_0:CheckCollectQuest(var_30_1)

	arg_30_0.m_boxCollectText.text = string.format("%s/%s", var_30_2, var_30_3)
	arg_30_0.m_yahahaCollectText.text = string.format("%s/%s", var_30_4, var_30_5)
end

function var_0_0.CheckCollectQuest(arg_31_0, arg_31_1)
	local var_31_0 = 0
	local var_31_1 = 0

	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		if QWorldQuestTool.IsCurMapMainQuest(iter_31_1) then
			var_31_1 = var_31_1 + 1

			if QWorldQuestTool.IsMainQuestFinish(iter_31_1) then
				var_31_0 = var_31_0 + 1
			end
		end
	end

	return var_31_0, var_31_1
end

return var_0_0
