local var_0_0 = class("SnowBallInfinityItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
	arg_3_0.rewardItem = CommonItem.New(arg_3_0.CommonItemGo_)

	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.knockBtn_, nil, function()
		if arg_4_0.poolData.openBoxList[arg_4_0.index] then
			return
		end

		local var_5_0 = ActivityInfinityPoolCfg[arg_4_0.poolID].cost_item

		if ItemTools.getItemNum(var_5_0[1]) < var_5_0[2] then
			ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_COST_FAILED02"), ItemTools.getItemName(var_5_0[1])))

			return
		end

		local var_5_1 = arg_4_0.poolData.isOpenCoreItem

		OsirisAction.OpenPoolBox(arg_4_0.poolID, {
			arg_4_0.index
		}, function(arg_6_0)
			if isSuccess(arg_6_0.result) then
				SetActive(arg_4_0.maskGo_, true)
				SetActive(arg_4_0.hammerGo_, true)
				manager.audio:PlayEffect("minigame_activity_2_6_snowball", "minigame_activity_2_6_snowball_icebreak", "")

				local var_6_0 = arg_4_0.hammerAnimator_:GetCurrentAnimatorClipInfo(0)[0].clip.length

				arg_4_0.time = 0

				local var_6_1 = 1

				arg_4_0.iceImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00953")
				arg_4_0.isGet = false
				arg_4_0.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
					arg_4_0.time = arg_4_0.time + Time.deltaTime

					if arg_4_0.time > var_6_0 * var_6_1 and var_6_1 <= var_5_0[2] then
						var_6_1 = var_6_1 + 1

						SetActive(arg_4_0.hammerGo_, false)
						SetActive(arg_4_0.hammerGo_, true)
					end

					if var_6_1 == var_5_0[2] + 1 then
						arg_4_0.animator_.enabled = true

						local var_7_0 = arg_4_0.animator_:GetCurrentAnimatorClipInfo(0)[0].clip.length

						if arg_4_0.time > var_6_0 * var_5_0[2] + var_7_0 then
							local var_7_1 = tonumber(GameSetting.activity_snowball_ice_action_delay.value[1])

							if arg_4_0.isGet ~= true then
								arg_4_0.isGet = true

								SetActive(arg_4_0.maskGo_, false)
								getReward({
									{
										id = arg_6_0.box_list[1].item.id,
										num = arg_6_0.box_list[1].item.num
									}
								}, nil, nil, nil, true)
								arg_4_0:UpdateView()
								arg_4_0.register()

								if var_5_1 == false and arg_4_0.poolData.isOpenCoreItem == true then
									local var_7_2 = ActivityInfinityPoolCfg[arg_4_0.poolID].activity_id

									ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_GETREAWARD"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(var_7_2))))
								end
							elseif arg_4_0.time > var_6_0 * var_5_0[2] + var_7_0 + var_7_1 then
								manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE)
								arg_4_0:RemoveCaptionTimer()
							end
						end
					end
				end, -1, true)
			else
				ShowTips(arg_6_0.result)
			end
		end)
	end)
end

function var_0_0.RemoveCaptionTimer(arg_8_0)
	if arg_8_0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_8_0.captionTimer)

		arg_8_0.captionTimer = nil
	end
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0.poolID = arg_9_1
	arg_9_0.index = arg_9_2
	arg_9_0.phase = arg_9_3
	arg_9_0.poolData = OsirisInfinityPoolData:GetPoolData(arg_9_0.poolID)
	arg_9_0.register = arg_9_4
	arg_9_0.maskGo_ = arg_9_5

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = arg_10_0.poolData.openBoxList[arg_10_0.index]

	if var_10_0 then
		arg_10_0.rewardItem:RefreshData({
			id = var_10_0[1],
			number = var_10_0[2]
		})
		arg_10_0.rewardItem:RegistCallBack(function(arg_11_0)
			ShowPopItem(POP_ITEM, {
				arg_11_0.id,
				arg_11_0.num
			})
		end)
	else
		arg_10_0.animator_.enabled = true

		arg_10_0.animator_:Play("IceUI_item", 0, 0)
		arg_10_0.animator_:Update(0)

		arg_10_0.animator_.enabled = false

		SetActive(arg_10_0.hammerGo_, false)
	end

	arg_10_0.iceImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00952")

	arg_10_0.stateController:SetSelectedState(var_10_0 and "Knocked" or "Knock")
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveCaptionTimer()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.rewardItem:Dispose()
	var_0_0.super.Dispose(arg_13_0)
	Object.Destroy(arg_13_0.gameObject_)
end

return var_0_0
