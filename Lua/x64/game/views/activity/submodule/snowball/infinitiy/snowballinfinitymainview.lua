local var_0_0 = class("SnowBallInfinityMainView", ReduxView)
local var_0_1 = 201061

local function var_0_2(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		var_1_0 = var_1_0 + 1
	end

	return var_1_0
end

function var_0_0.UIName(arg_2_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballIceUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:AdaptScreen()

	arg_5_0.itemViewList = {}
	arg_5_0.list = LuaList.New(handler(arg_5_0, arg_5_0.SetItemData), arg_5_0.listGo_, SnowBallInfinityItem)
	arg_5_0.levelList = LuaList.New(handler(arg_5_0, arg_5_0.SetLevelItemData), arg_5_0.levelGo_, SnowBallInfinityLevelItem)
	arg_5_0.mainRewardItem = CommonItem.New(arg_5_0.commonItemGo_)
	arg_5_0.levelControllerList = {}
end

function var_0_0.SetItemData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.poolID, arg_6_1, arg_6_0.phase, handler(arg_6_0, arg_6_0.UpdateLevelList), arg_6_0.maskGo_)
end

function var_0_0.SetLevelItemData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.poolID, arg_7_1, arg_7_0.activityID, arg_7_0.phase, handler(arg_7_0, arg_7_0.SelectListener))

	arg_7_0.levelControllerList[arg_7_1] = arg_7_2:GetController()

	SetActive(arg_7_2.redGo_, arg_7_0:ShowRedPoint(arg_7_1))
end

function var_0_0.AddUIListener(arg_8_0)
	local function var_8_0()
		OsirisAction.ResetPool(arg_8_0.poolID, function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				arg_8_0:UpdateView()
			else
				ShowTips(arg_10_0.result)
			end
		end)
	end

	local function var_8_1()
		if var_0_2(arg_8_0.poolData.openBoxList) == arg_8_0.count then
			ShowTips("ACTIVITY_SNOWBALL_ICE_CANTGET")

			return
		end

		local var_11_0 = ActivityInfinityPoolCfg[arg_8_0.poolID].cost_item
		local var_11_1 = ItemTools.getItemNum(var_11_0[1])

		if var_11_1 < var_11_0[2] then
			ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_COST_FAILED"), ItemTools.getItemName(var_11_0[1])))

			return
		end

		local var_11_2 = {}

		for iter_11_0 = 1, arg_8_0.count do
			if var_11_1 >= var_11_0[2] and arg_8_0.poolData.openBoxList[iter_11_0] == nil then
				table.insert(var_11_2, iter_11_0)

				var_11_1 = var_11_1 - var_11_0[2]
			end
		end

		local var_11_3 = arg_8_0.poolData.isOpenCoreItem

		OsirisAction.OpenPoolBox(arg_8_0.poolID, var_11_2, function(arg_12_0)
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
					for iter_12_4, iter_12_5 in ipairs(arg_8_0.list:GetItemList()) do
						if iter_12_3 == iter_12_5.index then
							table.insert(var_12_1, iter_12_5)
						end
					end
				end

				local var_12_2 = 1

				SetActive(arg_8_0.maskGo_, true)
				SetActive(var_12_1[1].hammerGo_, true)

				local var_12_3 = var_12_1[1].hammerAnimator_:GetCurrentAnimatorClipInfo(0)[0].clip.length

				arg_8_0.time = 0

				for iter_12_6, iter_12_7 in ipairs(var_12_1) do
					SetActive(iter_12_7.hammerGo_, true)

					iter_12_7.iceImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00953")
				end

				arg_8_0.isGet = false
				arg_8_0.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
					arg_8_0.time = arg_8_0.time + Time.deltaTime

					if arg_8_0.time > var_12_3 * var_12_2 and var_12_2 <= var_11_0[2] then
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

						if arg_8_0.time > var_12_3 * var_11_0[2] + var_13_0 then
							local var_13_1 = tonumber(GameSetting.activity_snowball_ice_action_delay.value[1])

							if arg_8_0.isGet ~= true then
								arg_8_0.isGet = true

								SetActive(arg_8_0.maskGo_, false)
								sortMergeGetReward(var_12_0, nil, nil, nil, true)
								arg_8_0:UpdateView()
								arg_8_0:UpdateLevelList()

								if var_11_3 == false and arg_8_0.poolData.isOpenCoreItem == true then
									local var_13_2 = ActivityInfinityPoolCfg[arg_8_0.poolID].activity_id

									ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_GETREAWARD"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(var_13_2))))
								end
							elseif arg_8_0.time > var_12_3 * var_11_0[2] + var_13_0 + var_13_1 then
								manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE)
								arg_8_0:RemoveCaptionTimer()
							end
						end
					end
				end, -1, true)
			else
				ShowTips(arg_12_0.result)
			end
		end)
	end

	arg_8_0:AddBtnListener(arg_8_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("SnowBallInfinityRewardView", {
			poolID = arg_8_0.poolID
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.resetBtn_, nil, function()
		if arg_8_0.phase == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_8_0.activityID] and var_0_2(arg_8_0.poolData.openBoxList) == arg_8_0.count then
			ShowMessageBox({
				isTop = true,
				content = GetTips("ACTIVITY_SNOWBALL_ICE_RESET_TIPS"),
				OkCallback = var_8_0
			})
		else
			var_8_1()
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.modelBtn_, nil, function()
		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)
		manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_MODEL)
	end)
end

function var_0_0.SelectListener(arg_17_0, arg_17_1)
	if arg_17_0.phase == arg_17_1 then
		return
	end

	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)

	local var_17_0 = OsirisInfinityPoolData:GetOpenPhase(arg_17_0.activityID)

	for iter_17_0 = 1, var_17_0 do
		arg_17_0.levelControllerList[iter_17_0]:SetSelectedState(iter_17_0 == arg_17_1 and "select" or "normal")
	end

	arg_17_0.phase = arg_17_1

	arg_17_0:UpdateView()
end

function var_0_0.UpdateView(arg_18_0)
	arg_18_0.poolID = ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_18_0.activityID][arg_18_0.phase]
	arg_18_0.poolData = OsirisInfinityPoolData:GetPoolData(arg_18_0.poolID)
	arg_18_0.count = #arg_18_0.poolData.itemList
	arg_18_0.count = arg_18_0.count + (arg_18_0.poolData.coreItem == nil and 0 or 1)

	arg_18_0.list:StartScroll(arg_18_0.count)

	arg_18_0.nameTxt_.text = string.format(GetTips("ACTIVITY_SNOWBALL_ICE_LEVEL"), arg_18_0.phase)

	arg_18_0:RefreshMainReward(arg_18_0.poolData.coreItem)

	arg_18_0.resetTxt_.text = GetTips(arg_18_0:IsShowReset() and "ACTIVITY_SNOWBALL_ICE_RESET" or "ACTIVITY_SNOWBALL_ICE_AUTOGET")

	SetActive(arg_18_0.redPointGo_, arg_18_0:ShowRedPoint(arg_18_0.phase))

	for iter_18_0, iter_18_1 in pairs(arg_18_0.levelList:GetItemList()) do
		SetActive(iter_18_1.redGo_, arg_18_0:ShowRedPoint(iter_18_1.index))
	end
end

function var_0_0.ShowRedPoint(arg_19_0, arg_19_1)
	local var_19_0 = ActivityInfinityPoolCfg[arg_19_0.poolID].cost_item
	local var_19_1 = ItemTools.getItemNum(var_19_0[1])

	if arg_19_1 > OsirisInfinityPoolData:GetOpenPhase(arg_19_0.activityID) then
		return false
	end

	local var_19_2 = ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_19_0.activityID][arg_19_1]
	local var_19_3 = OsirisInfinityPoolData:GetPoolData(var_19_2)
	local var_19_4 = #var_19_3.itemList + (var_19_3.coreItem == nil and 0 or 1)

	return var_0_2(var_19_3.openBoxList) ~= var_19_4 and var_19_1 >= var_19_0[2]
end

function var_0_0.IsShowReset(arg_20_0)
	return arg_20_0.phase == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_20_0.activityID] and var_0_2(arg_20_0.poolData.openBoxList) == arg_20_0.count
end

function var_0_0.RefreshMainReward(arg_21_0, arg_21_1)
	if arg_21_1 == nil or arg_21_1[1] == 0 then
		SetActive(arg_21_0.mainRewardGo_, false)

		return
	end

	SetActive(arg_21_0.mainRewardGo_, true)
	arg_21_0.mainRewardItem:RefreshData({
		id = arg_21_1[1],
		number = arg_21_1[2]
	})
	arg_21_0.mainRewardItem:RegistCallBack(function(arg_22_0)
		ShowPopItem(POP_ITEM, {
			arg_22_0.id,
			arg_22_0.num
		})
	end)
end

function var_0_0.UpdateLevelList(arg_23_0)
	arg_23_0.levelList:StartScroll(#ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_23_0.activityID])

	arg_23_0.poolID = ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_23_0.activityID][arg_23_0.phase]
	arg_23_0.poolData = OsirisInfinityPoolData:GetPoolData(arg_23_0.poolID)
	arg_23_0.resetTxt_.text = GetTips(arg_23_0:IsShowReset() and "ACTIVITY_SNOWBALL_ICE_RESET" or "ACTIVITY_SNOWBALL_ICE_AUTOGET")

	SetActive(arg_23_0.redPointGo_, arg_23_0:ShowRedPoint(arg_23_0.phase))
end

function var_0_0.OnEnter(arg_24_0)
	arg_24_0.activityID = var_0_1
	arg_24_0.phase = arg_24_0.phase or OsirisInfinityPoolData:GetOpenPhase(arg_24_0.activityID)

	SetActive(arg_24_0.maskGo_, false)
	arg_24_0:UpdateLevelList()
	arg_24_0:AddTimer()
	arg_24_0:UpdateView()
	arg_24_0:LoadModel()
end

function var_0_0.LoadModel(arg_25_0)
	arg_25_0.snowBallModelId = SnowballGameMgr.GetInstance():GetPlayerCfgID()

	SnowballGameMgr.GetInstance():SetPlayer(GameSetting.activity_snowball_ice_show.value[1])
	manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, SnowballGameMgr.GetInstance():GetPlayerEID(), GetTips("ACTIVITY_SNOWBALL_ICE_TALK" .. math.random(1, 4)), true)
end

function var_0_0.UnloadModel(arg_26_0)
	SnowballGameMgr.GetInstance():SetPlayer(arg_26_0.snowBallModelId)
end

function var_0_0.AddTimer(arg_27_0)
	arg_27_0.stopTime = ActivityData:GetActivityData(arg_27_0.activityID).stopTime

	if manager.time:GetServerTime() >= arg_27_0.stopTime then
		arg_27_0.remainTxt_.text = GetTips("TIME_OVER")

		return
	end

	arg_27_0.remainTxt_.text = manager.time:GetLostTimeStr(arg_27_0.stopTime)
	arg_27_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_27_0.stopTime then
			if arg_27_0.timer_ then
				arg_27_0.timer_:Stop()

				arg_27_0.timer_ = nil
			end

			arg_27_0.remainTxt_.text = GetTips("TIME_OVER")

			return
		end

		arg_27_0.remainTxt_.text = manager.time:GetLostTimeStr(arg_27_0.stopTime)
	end, 1, -1)

	arg_27_0.timer_:Start()
end

function var_0_0.RemoveCaptionTimer(arg_29_0)
	if arg_29_0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_29_0.captionTimer)

		arg_29_0.captionTimer = nil
	end
end

function var_0_0.OnExit(arg_30_0)
	if arg_30_0.timer_ then
		arg_30_0.timer_:Stop()

		arg_30_0.timer_ = nil
	end

	arg_30_0:UnloadModel()

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.list:GetItemList()) do
		iter_30_1:OnExit()
	end

	arg_30_0:RemoveCaptionTimer()
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_31_0)
	local var_31_0 = ActivityInfinityPoolCfg.get_id_list_by_activity_id[arg_31_0.activityID][1]
	local var_31_1 = ActivityInfinityPoolCfg[var_31_0].cost_item

	manager.windowBar:SetGameHelpKey("ACTIVITY_SNOWBALL_DESC2")
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		var_31_1[1]
	})
	manager.windowBar:SetBarCanAdd(var_31_1[1], true)
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.list then
		arg_32_0.list:Dispose()

		arg_32_0.list = nil
	end

	if arg_32_0.levelList then
		arg_32_0.levelList:Dispose()

		arg_32_0.levelList = nil
	end

	arg_32_0.mainRewardItem:Dispose()
	var_0_0.super.Dispose(arg_32_0)
	Object.Destroy(arg_32_0.gameObject_)
end

return var_0_0
