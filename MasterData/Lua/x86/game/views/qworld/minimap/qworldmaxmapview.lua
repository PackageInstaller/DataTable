local QWorldMaxMapView = class("QWorldMaxMapView", ReduxView)

function QWorldMaxMapView:UIName()
	return "Widget/System/SandPlay/SandPlay_Map/SandPlay_MapUI"
end

function QWorldMaxMapView:UIParent()
	return manager.ui.uiMain.transform
end

function QWorldMaxMapView:Init()
	self:InitUI()
	self:AddUIListener()
end

function QWorldMaxMapView:InitUI()
	self:BindCfgUI()

	self.mapCom = self.m_map:GetComponent(typeof(QWorldMaxMapUI))

	local var_4_0 = SandPlayMapCfg[QWorldMgr:GetMapId()]

	self.mapCom:Init("QWWorld/MiniMap/" .. var_4_0.big_map_path, var_4_0.big_map_size[1], var_4_0.big_map_size[2], var_4_0.small_map_rate, Vector3.New(var_4_0.big_map_center[1], var_4_0.big_map_center[2], var_4_0.big_map_center[3]), var_4_0.bag_map_initialscale, var_4_0.big_map_maxscale, var_4_0.big_map_minscale)

	self.mapCom.OnMapUnitSelectAction = System.Action(self.OnMapUnitSelectAction, self)
	self.infoList = LuaList.New(handler(self, self.IndexInfoItem), self.m_infoList, QWorldMaxMapInfoItem)
	self.selectList = LuaList.New(handler(self, self.IndexSelectItem), self.m_selectList, QWorldMaxMapSelectItem)
	self.selectController = self.m_controller:GetController("select")
	self.rightController = self.m_controller:GetController("right")
	self.selectClickHandler = handler(self, self.SelectClickCallBack)
	self.infoClickHandler = handler(self, self.InfoClickCallBack)
	self.condItems_ = {}
	self.rewardList = LuaList.New(handler(self, self.IndexRewardItem), self.m_rewardList, CommonItemView)
	self.showRewardController = self.m_detailController:GetController("showRewards")
	self.showdetailController = self.m_detailController:GetController("showdetails")
	self.btnStateController = self.m_detailController:GetController("btnState")
	self.followBtnStateController = self.m_followBtnController:GetController("btnstate")
	self.IconTypeController = self.m_iconController:GetController("type")
	self.m_teleportLab.text = GetTips("SANDPLAY_TRANSMIT")
end

function QWorldMaxMapView:AddUIListener()
	self:AddBtnListener(self.m_selectMask, nil, function()
		self.selectController:SetSelectedIndex(0)
		self:SelectEntity(nil)
	end)
	self:AddBtnListener(self.m_followBtn, nil, function()
		if self.curBoardInfo == nil then
			return
		end

		local var_7_0 = QWorldMgr:GetQWorldEntityMgr()
		local var_7_1 = self.curBoardInfo.inst.entityId

		if not var_7_0:IsTrack(self.curBoardInfo.inst.entityId) then
			if QWorldEntityMiniMapTag.Task == self.curBoardInfo.tag then
				local var_7_2 = self.curBoardInfo:GetMainQuestId()

				QWorldQuestAction.UpdateTrackingMainQuestId(var_7_2, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(var_7_2, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
				end)
			else
				QWorldAction.SendUpdateThingTrackToSDK(var_7_1, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.TRACK)
				var_7_0:TrackId(var_7_1)
			end

			local var_7_3 = self.curBoardInfo:GetTag()

			if not SandPlayTakePhotoTools.CheckIsPhotoTag(self.curBoardInfo.param) and (QWorldEntityMiniMapTag.Thing == var_7_3 or QWorldEntityMiniMapTag.Hud == var_7_3 and self.curBoardInfo:GetTeleportId() == 0) then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SANDPLAY_TELEPORT_NEARBY"),
					OkCallback = function()
						local var_9_0 = self.curBoardInfo:GetTeleportId()

						if var_9_0 ~= 0 then
							self:Back()
							QWorldTeleport(var_9_0)
						end

						if self.curBoardInfo and self.curBoardInfo.inst.entityId ~= 0 then
							self:Back()
							QWorldTeleportToNearest((QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(self.curBoardInfo.inst.entityId):GetPosition()))

							return
						end
					end
				})
			end
		else
			QWorldAction.SendUpdateThingTrackToSDK(var_7_1, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.UNTRACK)
			var_7_0:CancelTrack(var_7_1)
			self.selectController:SetSelectedIndex(0)
			self:SelectEntity(nil)
		end

		if QWorldMgr:GetQWorldEntityMgr():IsTrack(var_7_1) then
			self.m_followLab.text = GetTips("SANDPLAY_TRACK_CANCEL")

			self.followBtnStateController:SetSelectedState("cancel")
		else
			self.m_followLab.text = GetTips("SANDPLAY_TRACK")

			self.followBtnStateController:SetSelectedState("go")
		end

		self:UpdateRight()
	end)
	self:AddBtnListener(self.m_teleportBtn, nil, function()
		if self.curBoardInfo == nil then
			return
		end

		local var_10_0 = self.curBoardInfo:GetTeleportId()

		if var_10_0 ~= 0 then
			QWorldUIShow()
			QWorldTeleport(var_10_0)
		end

		if self.curBoardInfo and self.curBoardInfo.inst.entityId ~= 0 then
			self:Back()
			QWorldTeleportToNearest((QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(self.curBoardInfo.inst.entityId):GetPosition()))

			return
		end
	end)
	self:AddBtnListener(self.m_playerBtn, nil, function()
		self.mapCom:SelectPlayerInMaxMap()
	end)
	self:AddBtnListener(self.m_resetBtn, nil, function()
		ShowMessageBox({
			content = GetTips("SANDPLAY_STUCK_AND_DETACHED_REPEAT"),
			OkCallback = function()
				QWorldMgr:StartBlackFade(0.5, 0.5, 1, function()
					self:Back()
					manager.notify:Invoke(QWORLD_TELEPORT, -1)
					QWorldLuaBridge.TeleportToStageOrigin()
				end)
			end
		})
	end)
end

function QWorldMaxMapView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function QWorldMaxMapView:OnEnter()
	self:UpdateLeft()
	self:UpdateRight(true)
	self.selectController:SetSelectedIndex(0)

	if self.params_.selectEntity then
		self:SelectClickCallBack(self.params_.selectEntity)

		self.params_.selectEntity = nil
	end
end

function QWorldMaxMapView:OnExit()
	self:SelectEntity(nil)
	manager.windowBar:HideBar()
end

function QWorldMaxMapView:Dispose()
	self.mapCom:Dispose()

	self.mapCom = nil

	self.selectList:Dispose()
	self.infoList:Dispose()
	self.rewardList:Dispose()

	for iter_18_0, iter_18_1 in ipairs(self.condItems_) do
		iter_18_1:Dispose()
	end

	self.condItems_ = {}

	QWorldMaxMapView.super.Dispose(self)
end

function QWorldMaxMapView:UpdateRight(arg_19_1)
	self.miniMapBoardList = QWorldMgr:GetQWorldEntityMgr():GetMiniMapBoardList()

	if arg_19_1 then
		self.infoList:StartScroll(#self.miniMapBoardList)
	else
		local var_19_0 = self.infoList:GetScrolledPosition()

		self.infoList:StartScrollWithoutAnimator(#self.miniMapBoardList, false)
	end

	self.rightController:SetSelectedState(tostring(QWorldMgr:GetMapId() == 1031001))
end

function QWorldMaxMapView:UpdateLeft()
	self:RefreshCollectProgress()
end

function QWorldMaxMapView:InfoClickCallBack(arg_21_1)
	SetActive(self.m_selectList.gameObject, false)
	self.selectController:SetSelectedIndex(1)
	self.mapCom:SelectInMaxMap(arg_21_1.inst.entityId)
	self:SelectEntity(arg_21_1)
end

function QWorldMaxMapView:OnMapUnitSelectAction()
	local var_22_0 = self.mapCom:GetSelectEntityEntityIds()

	self.selectEntityIdList = {}

	for iter_22_0 = 0, var_22_0.Length - 1 do
		table.insert(self.selectEntityIdList, var_22_0[iter_22_0])
	end

	local var_22_1 = #self.selectEntityIdList

	if #self.selectEntityIdList >= 2 then
		SetActive(self.m_selectList.gameObject, true)
		self.selectList:StartScroll(#self.selectEntityIdList)
	else
		SetActive(self.m_selectList.gameObject, false)
	end

	if var_22_1 == 0 then
		self.selectController:SetSelectedIndex(0)
		self:SelectEntity(nil)
	else
		self:SelectClickCallBack(self.selectEntityIdList[1])
	end
end

function QWorldMaxMapView:SelectClickCallBack(arg_23_1)
	local var_23_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_23_1)

	if var_23_0 and var_23_0.miniMapUnit then
		self.selectController:SetSelectedIndex(1)
		self:SelectEntity((var_23_0.miniMapUnit:GetDefaultBoard()))
	end

	self.mapCom:SelectInMaxMap(arg_23_1)
end

function QWorldMaxMapView:SelectEntity(arg_24_1)
	if arg_24_1 ~= self.curBoardInfo then
		if self.curBoardInfo and self.curBoardInfo.inst.miniMapUnit then
			self.curBoardInfo.inst.miniMapUnit:SetSelect(false)
		end

		if arg_24_1 then
			arg_24_1.inst.miniMapUnit:SetSelect(true)
		end

		self.m_rightAnim:Play("UI_nodeDetailPanel", 0, 0)
	end

	self.curBoardInfo = arg_24_1

	if arg_24_1 then
		local var_24_0 = arg_24_1.inst.entityId
		local var_24_1, var_24_2 = arg_24_1:GetName()

		self.m_title.text = var_24_1
		self.m_desc.text = var_24_2
		self.rewards = arg_24_1:GetRewards()

		if #self.rewards > 0 then
			self.rewards = formatRewardCfgList(self.rewards)
			self.rewards = sortReward(self.rewards)

			self.rewardList:StartScroll(#self.rewards)
			self.showRewardController:SetSelectedIndex(0)
		else
			self.showRewardController:SetSelectedIndex(1)
		end

		self:RefreshTask(arg_24_1)

		local var_24_3 = arg_24_1:GetTag()

		if QWorldEntityMiniMapTag.Task == var_24_3 or SandPlayTakePhotoTools.CheckIsPhotoTag(arg_24_1.param) then
			self.btnStateController:SetSelectedState("both")

			if QWorldMgr:GetQWorldEntityMgr():IsTrack(var_24_0) then
				self.m_followLab.text = GetTips("SANDPLAY_TRACK_CANCEL")

				self.followBtnStateController:SetSelectedState("cancel")
			else
				self.m_followLab.text = GetTips("SANDPLAY_TRACK")

				self.followBtnStateController:SetSelectedState("go")
			end
		elseif QWorldEntityMiniMapTag.Hud == var_24_3 and self.curBoardInfo:GetTeleportId() ~= 0 then
			self.btnStateController:SetSelectedState("teleport")
		elseif QWorldEntityMiniMapTag.Thing == var_24_3 or QWorldEntityMiniMapTag.Hud == var_24_3 and self.curBoardInfo:GetTeleportId() == 0 then
			self.btnStateController:SetSelectedState("follow")

			if QWorldMgr:GetQWorldEntityMgr():IsTrack(var_24_0) then
				self.m_followLab.text = GetTips("SANDPLAY_TRACK_CANCEL")

				self.followBtnStateController:SetSelectedState("cancel")
			else
				self.m_followLab.text = GetTips("SANDPLAY_TRACK")

				self.followBtnStateController:SetSelectedState("go")
			end
		else
			self.btnStateController:SetSelectedState("null")
		end

		local var_24_4, var_24_5 = arg_24_1:GetIcon()

		self.m_icon.sprite = pureGetSpriteWithoutAtlas(var_24_4)

		self.IconTypeController:SetSelectedIndex(var_24_5)

		local var_24_6 = false

		if arg_24_1.tag == QWorldEntityMiniMapTag.Hud then
			local var_24_7 = nullable(SandplayTagCfg, arg_24_1.param, "activityId")

			if var_24_7 then
				var_24_6 = manager.redPoint:getTipBoolean(ActivityTools.GetRedPointKey(var_24_7) .. var_24_7)
			end
		end

		manager.redPoint:SetRedPointIndependent(self.m_teleportBtn.transform, var_24_6)
	end
end

function QWorldMaxMapView:RefreshTask(arg_25_1)
	if QWorldEntityMiniMapTag.Task == arg_25_1:GetTag() then
		self.questIdList_ = QWorldQuestTool.GetLoadedQuestIdList((arg_25_1:GetMainQuestId()))

		local var_25_0 = #self.questIdList_

		for iter_25_0, iter_25_1 in ipairs(self.condItems_) do
			SetActive(iter_25_1.gameObject_, iter_25_0 <= var_25_0)
		end

		for iter_25_2 = 1, var_25_0 do
			local var_25_1 = self.condItems_[iter_25_2]

			if not self.condItems_[iter_25_2] then
				local var_25_2 = Object.Instantiate(self.m_detailItem, self.m_detailContent)

				SetActive(var_25_2, true)

				var_25_1 = QWorldMaxMapTaskDetailItem.New(var_25_2)
				self.condItems_[iter_25_2] = var_25_1
			end

			var_25_1:SetData(self.questIdList_[iter_25_2])
		end

		self.showdetailController:SetSelectedIndex(0)
	else
		self.showdetailController:SetSelectedIndex(1)
	end
end

function QWorldMaxMapView:IndexInfoItem(arg_26_1, arg_26_2)
	arg_26_2:SetData(arg_26_1, self.miniMapBoardList[arg_26_1])
	arg_26_2:RegistCallBack(self.infoClickHandler)
end

function QWorldMaxMapView:IndexSelectItem(arg_27_1, arg_27_2)
	local var_27_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(self.selectEntityIdList[arg_27_1])

	if var_27_0 and var_27_0.miniMapUnit then
		arg_27_2:SetData(self.selectEntityIdList[arg_27_1], (var_27_0.miniMapUnit:GetDefaultBoard()))
	end

	arg_27_2:RegistCallBack(self.selectClickHandler)
end

function QWorldMaxMapView:IndexRewardItem(arg_28_1, arg_28_2)
	local var_28_0 = clone(ItemTemplateData)

	var_28_0.id = self.rewards[arg_28_1].id
	var_28_0.number = self.rewards[arg_28_1].num
	var_28_0.race = self.rewards[arg_28_1].race

	function var_28_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id,
			self.number
		})
	end

	arg_28_2:SetData(var_28_0)
end

function QWorldMaxMapView:RefreshCollectProgress()
	local var_30_0, var_30_1 = self:CheckCollectQuest(SandplayTaskMainCfg.get_id_list_by_hide_task[2])
	local var_30_2, var_30_3 = self:CheckCollectQuest(SandplayTaskMainCfg.get_id_list_by_hide_task[3])

	self.m_boxCollectText.text = string.format("%s/%s", var_30_0, var_30_1)
	self.m_yahahaCollectText.text = string.format("%s/%s", var_30_2, var_30_3)
end

function QWorldMaxMapView:CheckCollectQuest(arg_31_1)
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

return QWorldMaxMapView
