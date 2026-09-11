local IndiaNianMainView = class("IndiaNianMainView", ReduxView)

function IndiaNianMainView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianMainUI"
end

function IndiaNianMainView:UIParent()
	return manager.ui.uiMain.transform
end

function IndiaNianMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IndiaNianMainView:InitUI()
	self:BindCfgUI()

	self.stageItemList_ = {}

	for iter_4_0 = 1, 8 do
		table.insert(self.stageItemList_, (IndiaNianStageItem.New(self["stageGo_" .. iter_4_0])))
	end

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function IndiaNianMainView:AddUIListener()
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityShopCfg[self.activityID_].activity_theme]) do
			local var_6_1 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[iter_6_1].shop_id].activity_id)

			if var_6_1 and var_6_1:IsActivitying() then
				table.insert(var_6_0, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		local var_6_2, var_6_3 = ShopTools.IsShopOpen(ActivityShopCfg[self.activityID_].shop_id)

		if var_6_2 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = ActivityShopCfg[self.activityID_].shop_id,
				showShops = var_6_0
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_6_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_6_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("indiaNianReward")
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bossStageBtn_, nil, function()
		IndiaNianData:SetMainSelectedIndex(0)
		self:SetSelectedData(self.bossCfg_)
	end)
	self:AddBtnListener(self.tokenBtn_, nil, function()
		ShowPopItem(POP_ITEM, {
			IndiaNianData:GetSelectedStageCost()[1]
		})
	end)
	self:AddBtnListener(self.playBtn_, nil, function()
		IndiaNianData:SetMainSelectedIndex(0)
		self:SetSelectedData(self.bossCfg_)
		self:Go("indiaNianStageInfo", {
			section = IndiaNianData:GetSelectedStageID(),
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN,
			callback = function()
				self.stateController_:SetSelectedState("main")
				IndiaNianData:SetMainSelectedIndex(-1)
				self:RefreshUI()
			end
		})

		self.ani_.enabled = false

		self.stateController_:SetSelectedState("detail")
	end)
	self:AddBtnListener(self.detailBtn_, nil, function()
		JumpTools.OpenPageByJump("/indiaNianDetail")

		if IndiaNianData:GetHasUnlockBuff() then
			saveData("ActivityIndiaNian" .. self.activityID_ .. PlayerData:GetPlayerInfo().userID, "buffNum", IndiaNianData:GetClearBuffNum())
			manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK, 0)
		end
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_INDIA_NIAN_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_INDIA_NIAN_DESC")
		})
	end)
end

function IndiaNianMainView:OnTaskListChange()
	self:RefreshUI()
end

function IndiaNianMainView:OnDataUpdate()
	self:RefreshData()
	self:RefreshUI()
end

function IndiaNianMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = IndiaNianData:GetActivityID()
	self.isInited = false

	self:RefreshData()
	self:RefreshUI()
	self:AddTimer()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, handler(self, self.RefreshUI))
	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_REWARD)
	manager.redPoint:bindUIandKey(self.detailBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK)
end

function IndiaNianMainView:SetSelectedData(arg_18_1)
	IndiaNianData:SetSelectedStage(arg_18_1.stage_id)
	IndiaNianData:SetSelectedStageCost(arg_18_1.extra_cost)
	IndiaNianData:SetSelectedDestID(arg_18_1.id)
	self:RefreshStageUI()
end

function IndiaNianMainView:RefreshData()
	self.bossCfgIDList_ = IndiaNianCfg.get_id_list_by_activity_id[self.activityID_]
	self.round = IndiaNianData:GetRound()

	SetActive(self.maskBtn_.transform.gameObject, false)

	local var_19_0 = {}
	local var_19_1 = IndiaNianData:GetRound()

	for iter_19_0, iter_19_1 in ipairs(self.bossCfgIDList_) do
		if IndiaNianCfg[iter_19_1].group_id == 100 and var_19_1 >= IndiaNianCfg[iter_19_1].round and IndiaNianCfg[iter_19_1].stage_type == 0 then
			self.bossCfg_ = IndiaNianCfg[iter_19_1]
		elseif IndiaNianCfg[iter_19_1].group_id ~= 100 and not var_19_0[IndiaNianCfg[iter_19_1].group_id] then
			self.stageItemList_[1]:SetData(1, IndiaNianCfg[iter_19_1])
			self.stageItemList_[1]:SetCallBack(function(arg_20_0)
				IndiaNianData:SetMainSelectedIndex(arg_20_0)
				self:RefreshStageUI()
				self:Go("indiaNianStageInfo", {
					section = IndiaNianData:GetSelectedStageID(),
					sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN,
					callback = function()
						self.stateController_:SetSelectedState("main")
						IndiaNianData:SetMainSelectedIndex(-1)
						self:RefreshUI()
					end
				})

				self.ani_.enabled = false

				self.stateController_:SetSelectedState("detail")
			end)

			var_19_0[IndiaNianCfg[iter_19_1].group_id] = true
		end
	end

	if self.bossCfg_.stage_type == 0 and self.bossCfg_.round < IndiaNianData:GetRound() or self.bossCfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(self.bossCfg_.id) == 0 then
		for iter_19_2, iter_19_3 in ipairs(IndiaNianCfg.get_id_list_by_group_id[self.bossCfg_.group_id]) do
			if IndiaNianCfg[iter_19_3].activity_id == self.bossCfg_.activity_id and IndiaNianCfg[iter_19_3].stage_type == 1 then
				self.bossCfg_ = IndiaNianCfg[iter_19_3]
			end
		end
	end

	if not self.isInited then
		if var_19_1 == self.bossCfg_.round then
			self:SetSelectedData(self.bossCfg_)
		else
			for iter_19_4, iter_19_5 in ipairs(self.stageItemList_) do
				if iter_19_5.cfg_.round == var_19_1 then
					IndiaNianData:SetSelectedStage(iter_19_5.cfg_.stage_id)
					IndiaNianData:SetSelectedStageCost(iter_19_5.cfg_.extra_cost)

					if iter_19_5.cfg_.round < IndiaNianData:GetRound() or iter_19_5.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(iter_19_5.cfg_.id) == 0 then
						for iter_19_6, iter_19_7 in ipairs(IndiaNianCfg.get_id_list_by_group_id[iter_19_5.cfg_.group_id]) do
							if IndiaNianCfg[iter_19_7].activity_id == iter_19_5.cfg_.activity_id and IndiaNianCfg[iter_19_7].stage_type == 1 then
								IndiaNianData:SetSelectedDestID(iter_19_7)
							end
						end

						break
					end

					IndiaNianData:SetSelectedDestID(iter_19_5.cfg_.id)

					break
				end
			end
		end

		self.isInited = true
	end
end

function IndiaNianMainView:RefreshStageUI()
	local var_22_0 = not IndiaNianData:IsBossRound(IndiaNianData:GetRound())

	self.selectController_:SetSelectedState(tostring(IndiaNianData:GetMainSelectedIndex() == 0 and not var_22_0))

	for iter_22_0, iter_22_1 in ipairs(self.stageItemList_) do
		iter_22_1:RefreshUI()
	end

	self.lockController_:SetSelectedState(tostring(var_22_0))
end

function IndiaNianMainView:RefreshUI()
	self:RefreshSliderBar()
	self:RefreshStageUI()

	self.tokenImg_.sprite = ItemTools.getItemSprite(IndiaNianData.GetSelectedStageCost()[1])
	self.tokenNumText_.text = ItemTools.getItemNum(IndiaNianData.GetSelectedStageCost()[1]) .. "/" .. 15
end

function IndiaNianMainView:RefreshSliderBar()
	local var_24_0 = IndiaNianData:GetCurrentHpByID(self.bossCfg_.id) / IndiaNianData:GetTotalHp()

	if var_24_0 < 0.01 and IndiaNianData:GetCurrentHpByID(self.bossCfg_.id) ~= 0 then
		var_24_0 = 0.01
	end

	self.percentText_.text = math.ceil(var_24_0 * 100) .. "%"
	self.barFilImg_.fillAmount = var_24_0
	self.barLineTrs_.localPosition = Vector3(self.barBgTrs_.rect.width * var_24_0 - self.barBgTrs_.rect.width / 2, 0, 0)
end

function IndiaNianMainView:AddTimer()
	local var_25_0 = ActivityData:GetActivityData(self.activityID_).stopTime

	self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_25_0, nil, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_25_0 then
			JumpTools.OpenPageByJump("/springFestivalMainV2")

			return
		end

		self.leftTimeText_.text = manager.time:GetLostTimeStr2(var_25_0, nil, true)
	end, 1, -1)

	self.timer_:Start()
end

function IndiaNianMainView:OnExit()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_REWARD)
	manager.redPoint:unbindUIandKey(self.detailBtn_.transform, RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK)
	manager.windowBar:HideBar()
	self.stateController_:SetSelectedState("main")

	self.ani_.enabled = true

	self.timer_:Stop()

	self.timer_ = nil
end

function IndiaNianMainView:Dispose()
	IndiaNianMainView.super.Dispose(self)

	if self.stageItemList_ then
		for iter_28_0, iter_28_1 in ipairs(self.stageItemList_) do
			iter_28_1:Dispose()
		end

		self.stageItemList_ = nil
	end
end

return IndiaNianMainView
