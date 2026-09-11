local SnowBallInfinityMainView = class("SnowBallInfinityMainView", ReduxView)
local var_0_1 = 201061

local function var_0_2(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		var_1_0 = var_1_0 + 1
	end

	return var_1_0
end

function SnowBallInfinityMainView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballIceUI"
end

function SnowBallInfinityMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SnowBallInfinityMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SnowBallInfinityMainView:InitUI()
	self:BindCfgUI()
	self:AdaptScreen()

	self.itemViewList = {}
	self.list = LuaList.New(handler(self, self.SetItemData), self.listGo_, SnowBallInfinityItem)
	self.levelList = LuaList.New(handler(self, self.SetLevelItemData), self.levelGo_, SnowBallInfinityLevelItem)
	self.mainRewardItem = CommonItem.New(self.commonItemGo_)
	self.levelControllerList = {}
end

function SnowBallInfinityMainView:SetItemData(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.poolID, arg_6_1, self.phase, handler(self, self.UpdateLevelList), self.maskGo_)
end

function SnowBallInfinityMainView:SetLevelItemData(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.poolID, arg_7_1, self.activityID, self.phase, handler(self, self.SelectListener))

	self.levelControllerList[arg_7_1] = arg_7_2:GetController()

	SetActive(arg_7_2.redGo_, self:ShowRedPoint(arg_7_1))
end

function SnowBallInfinityMainView:AddUIListener()
	local function var_8_0()
		OsirisAction.ResetPool(self.poolID, function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				self:UpdateView()
			else
				ShowTips(arg_10_0.result)
			end
		end)
	end

	local function var_8_1()
		if var_0_2(self.poolData.openBoxList) == self.count then
			ShowTips("ACTIVITY_SNOWBALL_ICE_CANTGET")

			return
		end

		local var_11_0 = ActivityInfinityPoolCfg[self.poolID].cost_item
		local var_11_1 = ItemTools.getItemNum(ActivityInfinityPoolCfg[self.poolID].cost_item[1])

		if var_11_1 < ActivityInfinityPoolCfg[self.poolID].cost_item[2] then
			ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_COST_FAILED"), ItemTools.getItemName(var_11_0[1])))

			return
		end

		local var_11_2 = {}

		for iter_11_0 = 1, self.count do
			if var_11_1 >= var_11_0[2] and self.poolData.openBoxList[iter_11_0] == nil then
				table.insert(var_11_2, iter_11_0)

				var_11_1 = var_11_1 - var_11_0[2]
			end
		end

		local var_11_3 = self.poolData.isOpenCoreItem

		OsirisAction.OpenPoolBox(self.poolID, var_11_2, function(arg_12_0)
			if isSuccess(arg_12_0.result) then
				local var_12_0 = {}

				for iter_12_0, iter_12_1 in ipairs(arg_12_0.box_list) do
					var_12_0[iter_12_0] = {
						iter_12_1.item.id,
						iter_12_1.item.num
					}
				end

				manager.audio:PlayEffect("minigame_activity_2_6_snowball", "minigame_activity_2_6_snowball_icebreak", "")

				local var_12_1 = {}

				for iter_12_2, iter_12_3 in ipairs(var_11_2) do
					for iter_12_4, iter_12_5 in ipairs(self.list:GetItemList()) do
						if iter_12_3 == iter_12_5.index then
							table.insert(var_12_1, iter_12_5)
						end
					end
				end

				local var_12_2 = 1

				SetActive(self.maskGo_, true)
				SetActive(var_12_1[1].hammerGo_, true)

				local var_12_3 = var_12_1[1].hammerAnimator_:GetCurrentAnimatorClipInfo(0)[0].clip.length

				self.time = 0

				for iter_12_6, iter_12_7 in ipairs(var_12_1) do
					SetActive(iter_12_7.hammerGo_, true)

					iter_12_7.iceImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00953")
				end

				self.isGet = false
				self.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
					self.time = self.time + Time.deltaTime

					if self.time > var_12_3 * var_12_2 and var_12_2 <= var_11_0[2] then
						var_12_2 = var_12_2 + 1

						for iter_13_0, iter_13_1 in ipairs(var_12_1) do
							SetActive(iter_13_1.hammerGo_, false)
							SetActive(iter_13_1.hammerGo_, true)
						end
					end

					if var_12_2 == var_11_0[2] + 1 then
						for iter_13_2, iter_13_3 in ipairs(var_12_1) do
							iter_13_3.animator_.enabled = true
						end

						local var_13_0 = var_12_1[1].animator_:GetCurrentAnimatorClipInfo(0)[0].clip.length

						if self.time > var_12_3 * var_11_0[2] + var_13_0 then
							if self.isGet ~= true then
								self.isGet = true

								SetActive(self.maskGo_, false)
								sortMergeGetReward(var_12_0, nil, nil, nil, true)
								self:UpdateView()
								self:UpdateLevelList()

								if var_11_3 == false and self.poolData.isOpenCoreItem == true then
									ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_GETREAWARD"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(ActivityInfinityPoolCfg[self.poolID].activity_id))))
								end
							elseif self.time > var_12_3 * var_11_0[2] + var_13_0 + tonumber(GameSetting.activity_snowball_ice_action_delay.value[1]) then
								manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE)
								self:RemoveCaptionTimer()
							end
						end
					end
				end, -1, true)
			else
				ShowTips(arg_12_0.result)
			end
		end)
	end

	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("SnowBallInfinityRewardView", {
			poolID = self.poolID
		})
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		if self.phase == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID] and var_0_2(self.poolData.openBoxList) == self.count then
			ShowMessageBox({
				isTop = true,
				content = GetTips("ACTIVITY_SNOWBALL_ICE_RESET_TIPS"),
				OkCallback = var_8_0
			})
		else
			var_8_1()
		end
	end)
	self:AddBtnListener(self.modelBtn_, nil, function()
		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)
		manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_MODEL)
	end)
end

function SnowBallInfinityMainView:SelectListener(arg_17_1)
	if self.phase == arg_17_1 then
		return
	end

	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)

	for iter_17_0 = 1, OsirisInfinityPoolData:GetOpenPhase(self.activityID) do
		self.levelControllerList[iter_17_0]:SetSelectedState(iter_17_0 == arg_17_1 and "select" or "normal")
	end

	self.phase = arg_17_1

	self:UpdateView()
end

function SnowBallInfinityMainView:UpdateView()
	self.poolID = ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID][self.phase]
	self.poolData = OsirisInfinityPoolData:GetPoolData(self.poolID)
	self.count = #self.poolData.itemList
	self.count = self.count + (self.poolData.coreItem == nil and 0 or 1)

	self.list:StartScroll(self.count)

	self.nameTxt_.text = string.format(GetTips("ACTIVITY_SNOWBALL_ICE_LEVEL"), self.phase)

	self:RefreshMainReward(self.poolData.coreItem)

	self.resetTxt_.text = GetTips(self:IsShowReset() and "ACTIVITY_SNOWBALL_ICE_RESET" or "ACTIVITY_SNOWBALL_ICE_AUTOGET")

	SetActive(self.redPointGo_, self:ShowRedPoint(self.phase))

	for iter_18_0, iter_18_1 in pairs(self.levelList:GetItemList()) do
		SetActive(iter_18_1.redGo_, self:ShowRedPoint(iter_18_1.index))
	end
end

function SnowBallInfinityMainView:ShowRedPoint(arg_19_1)
	local var_19_0 = ActivityInfinityPoolCfg[self.poolID].cost_item
	local var_19_1 = ItemTools.getItemNum(ActivityInfinityPoolCfg[self.poolID].cost_item[1])

	if arg_19_1 > OsirisInfinityPoolData:GetOpenPhase(self.activityID) then
		return false
	end

	local var_19_2 = OsirisInfinityPoolData:GetPoolData(ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID][arg_19_1])

	return var_0_2(var_19_2.openBoxList) ~= #var_19_2.itemList + (var_19_2.coreItem == nil and 0 or 1) and var_19_1 >= var_19_0[2]
end

function SnowBallInfinityMainView:IsShowReset()
	return self.phase == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID] and var_0_2(self.poolData.openBoxList) == self.count
end

function SnowBallInfinityMainView:RefreshMainReward(arg_21_1)
	if arg_21_1 == nil or arg_21_1[1] == 0 then
		SetActive(self.mainRewardGo_, false)

		return
	end

	SetActive(self.mainRewardGo_, true)
	self.mainRewardItem:RefreshData({
		id = arg_21_1[1],
		number = arg_21_1[2]
	})
	self.mainRewardItem:RegistCallBack(function(arg_22_0)
		ShowPopItem(POP_ITEM, {
			arg_22_0.id,
			arg_22_0.num
		})
	end)
end

function SnowBallInfinityMainView:UpdateLevelList()
	self.levelList:StartScroll(#ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID])

	self.poolID = ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID][self.phase]
	self.poolData = OsirisInfinityPoolData:GetPoolData(self.poolID)
	self.resetTxt_.text = GetTips(self:IsShowReset() and "ACTIVITY_SNOWBALL_ICE_RESET" or "ACTIVITY_SNOWBALL_ICE_AUTOGET")

	SetActive(self.redPointGo_, self:ShowRedPoint(self.phase))
end

function SnowBallInfinityMainView:OnEnter()
	self.activityID = var_0_1
	self.phase = self.phase or OsirisInfinityPoolData:GetOpenPhase(self.activityID)

	SetActive(self.maskGo_, false)
	self:UpdateLevelList()
	self:AddTimer()
	self:UpdateView()
	self:LoadModel()
end

function SnowBallInfinityMainView:LoadModel()
	self.snowBallModelId = SnowballGameMgr.GetInstance():GetPlayerCfgID()

	SnowballGameMgr.GetInstance():SetPlayer(GameSetting.activity_snowball_ice_show.value[1])
	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)
end

function SnowBallInfinityMainView:UnloadModel()
	SnowballGameMgr.GetInstance():SetPlayer(self.snowBallModelId)
end

function SnowBallInfinityMainView:AddTimer()
	self.stopTime = ActivityData:GetActivityData(self.activityID).stopTime

	if manager.time:GetServerTime() >= self.stopTime then
		self.remainTxt_.text = GetTips("TIME_OVER")

		return
	end

	self.remainTxt_.text = manager.time:GetLostTimeStr(self.stopTime)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime then
			if self.timer_ then
				self.timer_:Stop()

				self.timer_ = nil
			end

			self.remainTxt_.text = GetTips("TIME_OVER")

			return
		end

		self.remainTxt_.text = manager.time:GetLostTimeStr(self.stopTime)
	end, 1, -1)

	self.timer_:Start()
end

function SnowBallInfinityMainView:RemoveCaptionTimer()
	if self.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(self.captionTimer)

		self.captionTimer = nil
	end
end

function SnowBallInfinityMainView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self:UnloadModel()

	for iter_30_0, iter_30_1 in ipairs(self.list:GetItemList()) do
		iter_30_1:OnExit()
	end

	self:RemoveCaptionTimer()
	manager.windowBar:HideBar()
end

function SnowBallInfinityMainView:OnTop()
	manager.windowBar:SetGameHelpKey("ACTIVITY_SNOWBALL_DESC2")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ActivityInfinityPoolCfg[ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID][1]].cost_item[1]
	})
	manager.windowBar:SetBarCanAdd(ActivityInfinityPoolCfg[ActivityInfinityPoolCfg.get_id_list_by_activity_id[self.activityID][1]].cost_item[1], true)
end

function SnowBallInfinityMainView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	if self.levelList then
		self.levelList:Dispose()

		self.levelList = nil
	end

	self.mainRewardItem:Dispose()
	SnowBallInfinityMainView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SnowBallInfinityMainView
