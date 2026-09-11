local IdolCompetitionSignView = class("IdolCompetitionSignView", ReduxView)

function IdolCompetitionSignView:UIName()
	return "Widget/BackHouseUI/Competition/IdolCompetitionSignupUI"
end

function IdolCompetitionSignView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolCompetitionSignView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolCompetitionSignView:InitUI()
	self:BindCfgUI()

	self.curSelectedHero_ = {}
	self.style1Data_ = {}
	self.style2Data_ = {}
	self.style3Data_ = {}
	self.selectPosController_ = {}

	local var_4_0 = Asset.Load("Effect/Scene/X104_Formation_HeroPos")

	for iter_4_0 = 1, 3 do
		local var_4_1 = GameObject.Find("WT_RK/WT_XR_Scene/WT_XR_Scene/X104_SceneSteps/X104_Formation_HeroPos_" .. iter_4_0)

		if var_4_1 then
			local var_4_2 = Object.Instantiate(var_4_0, var_4_1.transform)

			if var_4_2 then
				self.selectPosController_[iter_4_0] = var_4_2:GetComponent("ControllerExCollection"):GetController("state")
			end
		end
	end

	self.signSceneGo_ = GameObject.Find("WT_RK/WT_XR_Scene/WT_XR_Scene")
	self.curDraggingPos_ = 0
	self.curDraggingID_ = 0
	self.curDraggingEID_ = 0
	self.snap2DPosTrs_ = {}

	for iter_4_1 = 1, 3 do
		self.snap2DPosTrs_[iter_4_1] = self["click" .. iter_4_1 .. "Btn_"].gameObject:GetComponent("RectTransform")
	end

	self.snap3DPos_ = {}

	for iter_4_2 = 1, 3 do
		local var_4_3 = nullable(Dorm.storage:PickData("idol.camp.pos.competition" .. iter_4_2), "transform")

		self.snap3DPos_[iter_4_2] = {
			x = var_4_3.position.x,
			z = var_4_3.position.z
		}
	end

	self.coordinateX = {
		left = self.snap2DPosTrs_[2]:GetAnchoredPositionX(nil),
		right = self.snap2DPosTrs_[3]:GetAnchoredPositionX(nil)
	}
	self.style1UIList_ = LuaList.New(handler(self, self.IndexMiddleItem), self.style1UIList_, EnterBattleStyleListItem)
	self.style2UIList_ = LuaList.New(handler(self, self.IndexLeftItem), self.style2UIList_, EnterBattleStyleListItem)
	self.style3UIList_ = LuaList.New(handler(self, self.IndexRightItem), self.style3UIList_, EnterBattleStyleListItem)
	self.titleController_ = self.mainControllerEx_:GetController("title")
end

function IdolCompetitionSignView:AddUIListener()
	for iter_5_0 = 1, 3 do
		self["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_6_0, arg_6_1)
			if arg_6_1.dragging then
				return
			end

			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs(self.curSelectedHero_) do
				if iter_6_1.heroID ~= 0 then
					var_6_0[iter_6_1.heroID] = true
				end
			end

			JumpTools.OpenPageByJump("/idolCompetitionSignSelect", {
				info = self.curSelectedHero_[iter_5_0],
				selected = var_6_0,
				onClick = function(arg_7_0)
					for iter_7_0, iter_7_1 in ipairs(self.curSelectedHero_) do
						if iter_7_1.heroID == arg_7_0 then
							iter_7_1.heroID = 0
						end
					end

					self.curSelectedHero_[iter_5_0].heroID = arg_7_0

					self:UpdateHeroModel()
				end
			})
		end))
		self["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
			if self.curSelectedHero_[iter_5_0].heroID ~= 0 then
				self.curDraggingPos_ = iter_5_0
				self.curDraggingID_ = self.curSelectedHero_[self.curDraggingPos_].heroID
				self.curSelectedHero_[self.curDraggingPos_].heroID = 0

				local var_8_0 = IdolTraineeCampBridge.GenCharacter(self.curDraggingID_)

				if var_8_0 then
					self.curDraggingEID_ = var_8_0
				end

				self:UpdateHeroModel()
			else
				self.curDraggingPos_ = 0
			end
		end))
		self["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
			local var_9_0 = self:CanDrop(arg_9_1)

			if var_9_0 then
				self.curSelectedHero_[self.curDraggingPos_].heroID = self.curSelectedHero_[var_9_0].heroID
				self.curSelectedHero_[var_9_0].heroID = 0
				self.curDraggingPos_ = var_9_0

				self:UpdateHeroModel()
			end
		end))
		self["click" .. iter_5_0 .. "Btn_"]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_10_0, arg_10_1)
			self.curSelectedHero_[self.curDraggingPos_].heroID = self.curDraggingID_

			self:UpdateHeroModel()

			self.curDraggingPos_ = 0
			self.curDraggingID_ = 0

			if self.curDraggingEID_ ~= 0 then
				IdolTraineeCampBridge.RemoveEntity(self.curDraggingEID_)

				self.curDraggingEID_ = 0
			end
		end))
	end

	self:AddBtnListener(self.signBtn_, nil, function()
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(self.curSelectedHero_) do
			if iter_11_1.heroID == 0 then
				ShowTips("IDOL_COMPETITION_SIGN_FAIL")

				return
			end

			table.insert(var_11_0, {
				stage_id = iter_11_1.stageID,
				hero_id = iter_11_1.heroID
			})
		end

		IdolCompetitionAction.RequestSignUpForRace(self.raceActivityID_, var_11_0, function()
			self:Back()
		end)
	end)
end

function IdolCompetitionSignView:CanDrop(arg_13_1)
	if self.curDraggingPos_ ~= 0 and self.curDraggingID_ ~= 0 and self.curDraggingEID_ ~= 0 then
		local var_13_0 = math.min(math.max((LuaHelper.ScreenToLocal(self.midTrs_, arg_13_1.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera).x - self.coordinateX.left) / (self.coordinateX.right - self.coordinateX.left), 0), 1)
		local var_13_1

		if var_13_0 < 0.2 then
			if self.curDraggingPos_ ~= 2 then
				var_13_1 = 2
			end
		elseif var_13_0 >= 0.3 and var_13_0 < 0.7 then
			if self.curDraggingPos_ ~= 1 then
				var_13_1 = 1
			end
		elseif var_13_0 >= 0.8 and self.curDraggingPos_ ~= 3 then
			var_13_1 = 3
		end

		local var_13_2

		if var_13_0 > 0.5 then
			var_13_0 = (var_13_0 - 0.5) * 2
			var_13_2 = Vector3.New(self.snap3DPos_[3].x * var_13_0 + self.snap3DPos_[1].x * (1 - var_13_0), 0, self.snap3DPos_[3].z * var_13_0 + self.snap3DPos_[1].z * (1 - var_13_0))
		else
			var_13_2 = Vector3.New(self.snap3DPos_[1].x * (var_13_0 * 2) + self.snap3DPos_[2].x * (1 - var_13_0 * 2), 0, self.snap3DPos_[1].z * (var_13_0 * 2) + self.snap3DPos_[2].z * (1 - var_13_0 * 2))
		end

		Dorm.DormEntityManager.PutEntityAt(self.curDraggingEID_, var_13_2)

		return var_13_1
	end
end

function IdolCompetitionSignView:BeginDragHero()
	if self.curSelectedHero_[self.curDraggingPos_].heroID ~= 0 then
		self.curDraggingID_ = self.curSelectedHero_[self.curDraggingPos_].heroID
		self.curSelectedHero_[self.curDraggingPos_].heroID = 0

		local var_14_0 = IdolTraineeCampBridge.GenCharacter(heroID)

		if var_14_0 then
			self.curDraggingEID_ = var_14_0
		end

		self:UpdateHeroModel()
	end
end

function IdolCompetitionSignView:RemoveDragHero()
	if self.curDraggingEID_ ~= 0 then
		IdolTraineeCampBridge.RemoveEntity(self.curDraggingEID_)

		self.curDraggingID_ = 0
		self.curDraggingEID_ = 0
	end
end

function IdolCompetitionSignView:IndexMiddleItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(self.style1Data_[arg_16_1])
end

function IdolCompetitionSignView:IndexLeftItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.style2Data_[arg_17_1])
end

function IdolCompetitionSignView:IndexRightItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(self.style3Data_[arg_18_1])
end

function IdolCompetitionSignView:OnEnter()
	saveData("IdolCompetition", "click_time", _G.gameTimer:GetNextDayFreshTime())
	manager.redPoint:setTip(RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN, 0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self.curSelectedHero_ = {}

		self:Back()
	end)
	manager.windowBar:SetGameHelpKey("IDOL_COMPETITION_SIGN_DESC")
	SetActive(self.signSceneGo_, true)

	self.raceActivityID_ = self.params_.activity

	if #self.curSelectedHero_ == 0 then
		self.curSelectedHero_ = IdolCompetitionData:GetSignUpInfo(self.raceActivityID_)

		self:UpdateHeroModel()
	end

	self.titleController_:SetSelectedState(tostring(self.params_.index or 1))
	self:UpdateView()
end

function IdolCompetitionSignView:OnExit()
	manager.windowBar:HideBar()
	SetActive(self.signSceneGo_, false)
end

function IdolCompetitionSignView:UpdateHeroModel()
	IdolTraineeCampBridge.RemoveCompetitionCharacter()

	for iter_22_0 = 1, 3 do
		if self.curSelectedHero_[iter_22_0].heroID ~= 0 then
			IdolTraineeCampBridge.SetCompetitionCharacter(self.curSelectedHero_[iter_22_0].heroID, iter_22_0)

			if self.selectPosController_[iter_22_0] then
				self.selectPosController_[iter_22_0]:SetSelectedState("selected")
			end
		elseif self.selectPosController_[iter_22_0] then
			self.selectPosController_[iter_22_0]:SetSelectedState("empty")
		end
	end
end

function IdolCompetitionSignView:UpdateView()
	for iter_23_0, iter_23_1 in ipairs(self.curSelectedHero_) do
		if IdolTraineePvpBattleCfg[iter_23_1.stageID] then
			if IdolStageSceneCfg[IdolTraineePvpBattleCfg[iter_23_1.stageID].scene_id] then
				self["scene" .. iter_23_0 .. "Img_"].spriteAsync = SpritePathCfg.IdolStageIcon.path .. IdolStageSceneCfg[IdolTraineePvpBattleCfg[iter_23_1.stageID].scene_id].stage_picture
				self["name" .. iter_23_0 .. "Text_"].text = IdolStageSceneCfg[IdolTraineePvpBattleCfg[iter_23_1.stageID].scene_id].scene_show_name
				self["style" .. iter_23_0 .. "Data_"] = {}

				for iter_23_2, iter_23_3 in ipairs(IdolTraineePvpBattleCfg[iter_23_1.stageID].peculiarity_rate) do
					if iter_23_3 > 100 then
						table.insert(self["style" .. iter_23_0 .. "Data_"], iter_23_2)
					end
				end

				self["style" .. iter_23_0 .. "UIList_"]:StartScroll(#self["style" .. iter_23_0 .. "Data_"])
			end
		end
	end
end

function IdolCompetitionSignView:Dispose()
	IdolCompetitionSignView.super.Dispose(self)

	if self.style1UIList_ then
		self.style1UIList_:Dispose()

		self.style1UIList_ = nil
	end

	if self.style2UIList_ then
		self.style2UIList_:Dispose()

		self.style2UIList_ = nil
	end

	if self.style3UIList_ then
		self.style3UIList_:Dispose()

		self.style3UIList_ = nil
	end
end

return IdolCompetitionSignView
