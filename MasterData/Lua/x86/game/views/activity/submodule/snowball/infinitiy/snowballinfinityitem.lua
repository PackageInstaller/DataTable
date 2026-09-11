local SnowBallInfinityItem = class("SnowBallInfinityItem", ReduxView)

function SnowBallInfinityItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function SnowBallInfinityItem:Init()
	self:InitUI()
end

function SnowBallInfinityItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.rewardItem = CommonItem.New(self.CommonItemGo_)

	self:AddUIListener()
end

function SnowBallInfinityItem:AddUIListener()
	self:AddBtnListener(self.knockBtn_, nil, function()
		if self.poolData.openBoxList[self.index] then
			return
		end

		local var_5_0 = ActivityInfinityPoolCfg[self.poolID].cost_item

		if ItemTools.getItemNum(ActivityInfinityPoolCfg[self.poolID].cost_item[1]) < ActivityInfinityPoolCfg[self.poolID].cost_item[2] then
			ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_COST_FAILED02"), ItemTools.getItemName(var_5_0[1])))

			return
		end

		local var_5_1 = self.poolData.isOpenCoreItem

		OsirisAction.OpenPoolBox(self.poolID, {
			self.index
		}, function(arg_6_0)
			if isSuccess(arg_6_0.result) then
				SetActive(self.maskGo_, true)
				SetActive(self.hammerGo_, true)
				manager.audio:PlayEffect("minigame_activity_2_6_snowball", "minigame_activity_2_6_snowball_icebreak", "")

				local var_6_0 = self.hammerAnimator_:GetCurrentAnimatorClipInfo(0)[0].clip.length

				self.time = 0

				local var_6_1 = 1

				self.iceImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00953")
				self.isGet = false
				self.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
					self.time = self.time + Time.deltaTime

					if self.time > var_6_0 * var_6_1 and var_6_1 <= var_5_0[2] then
						var_6_1 = var_6_1 + 1

						SetActive(self.hammerGo_, false)
						SetActive(self.hammerGo_, true)
					end

					if var_6_1 == var_5_0[2] + 1 then
						self.animator_.enabled = true

						local var_7_0 = self.animator_:GetCurrentAnimatorClipInfo(0)[0].clip.length

						if self.time > var_6_0 * var_5_0[2] + var_7_0 then
							if self.isGet ~= true then
								self.isGet = true

								SetActive(self.maskGo_, false)
								getReward({
									{
										id = arg_6_0.box_list[1].item.id,
										num = arg_6_0.box_list[1].item.num
									}
								}, nil, nil, nil, true)
								self:UpdateView()
								self.register()

								if var_5_1 == false and self.poolData.isOpenCoreItem == true then
									ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_GETREAWARD"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(ActivityInfinityPoolCfg[self.poolID].activity_id))))
								end
							elseif self.time > var_6_0 * var_5_0[2] + var_7_0 + tonumber(GameSetting.activity_snowball_ice_action_delay.value[1]) then
								manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE)
								self:RemoveCaptionTimer()
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

function SnowBallInfinityItem:RemoveCaptionTimer()
	if self.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(self.captionTimer)

		self.captionTimer = nil
	end
end

function SnowBallInfinityItem:SetData(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	self.poolID = arg_9_1
	self.index = arg_9_2
	self.phase = arg_9_3
	self.poolData = OsirisInfinityPoolData:GetPoolData(self.poolID)
	self.register = arg_9_4
	self.maskGo_ = arg_9_5

	self:UpdateView()
end

function SnowBallInfinityItem:UpdateView()
	local var_10_0 = self.poolData.openBoxList[self.index]

	if self.poolData.openBoxList[self.index] then
		self.rewardItem:RefreshData({
			id = var_10_0[1],
			number = var_10_0[2]
		})
		self.rewardItem:RegistCallBack(function(arg_11_0)
			ShowPopItem(POP_ITEM, {
				arg_11_0.id,
				arg_11_0.num
			})
		end)
	else
		self.animator_.enabled = true

		self.animator_:Play("IceUI_item", 0, 0)
		self.animator_:Update(0)

		self.animator_.enabled = false

		SetActive(self.hammerGo_, false)
	end

	self.iceImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00952")

	self.stateController:SetSelectedState(var_10_0 and "Knocked" or "Knock")
end

function SnowBallInfinityItem:OnExit()
	self:RemoveCaptionTimer()
end

function SnowBallInfinityItem:Dispose()
	self.rewardItem:Dispose()
	SnowBallInfinityItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SnowBallInfinityItem
