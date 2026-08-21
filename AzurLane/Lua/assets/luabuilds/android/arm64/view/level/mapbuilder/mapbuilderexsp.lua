local var_0_0 = class("MapBuilderEXSP", import(".MapBuilderSPSeriesFull"))

function var_0_0.GetType(arg_1_0)
	return MapBuilder.TYPEATELIERYUMIA
end

function var_0_0.getUIName(arg_2_0)
	return "LevelSelectEXSPUI"
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)

	arg_3_0.personalBtn = arg_3_0._tf:Find("Story/PersonalCard")
	arg_3_0.personalPage = SecretsAbyssPersonalPage.New(arg_3_0._tf, arg_3_0, {})

	onButton(arg_3_0, arg_3_0.personalBtn, function()
		arg_3_0.personalPage:ExecuteAction("Show")

		return
	end)

	return
end

function var_0_0.UpdateMapVO(arg_5_0, arg_5_1)
	var_0_0.super.UpdateMapVO(arg_5_0, arg_5_1)

	if arg_5_0.activity:getConfig("config_client").roll_task then
		arg_5_0.personalPage:RegisterRandomCallback(function()
			arg_5_0.sceneParent:emit(LevelMediator2.ON_UPDATE_LOWPRIORITY_TASK, arg_5_0.activity:getConfig("config_client").roll_task)

			return
		end)
	end

	return
end

function var_0_0.SetDisplayMode(arg_7_0, arg_7_1)
	var_0_0.super.SetDisplayMode(arg_7_0, arg_7_1)

	if arg_7_0.contextData.displayMode == var_0_0.DISPLAY.BATTLE then
		quickPlayAnimation(arg_7_0._tf, "Anim_LevelSelectAtelierYumia_Battle_In")
	else
		quickPlayAnimation(arg_7_0._tf, "Anim_LevelSelectAtelierYumia_In")
	end

	return
end

function var_0_0.PlayerLevelTplAnimation(arg_8_0, arg_8_1, arg_8_2)
	quickPlayAnimation(arg_8_1, switch(arg_8_2.status, {
		Lock = function()
			return "Anim_LevelSelectAtelierYumia_LevelTplLock_In"
		end,
		Normal = function()
			return "Anim_LevelSelectAtelierYumia_LevelTpNormal_In"
		end,
		Hard = function()
			return "Anim_LevelSelectAtelierYumia_LevelTpHard_In"
		end
	}))

	return
end

function var_0_0.UpdateStory(arg_12_0)
	local var_12_1 = pg.NewStoryMgr.GetInstance()
	local var_12_2 = 0
	local var_12_3 = 0
	local var_12_4 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.storyNodesDict) do
		local var_12_5 = arg_12_0.storyHolder:Find(tostring(iter_12_1.id))
		local var_12_6 = iter_12_1:IsActive(arg_12_0.activity, arg_12_0.ptActivity)
		local var_12_7 = iter_12_1:IsReaded()

		if not _G.isActive(var_12_5) and var_12_6 then
			setActive(var_12_5, var_12_6)
			quickPlayAnimation(var_12_5, switch(iter_12_1:GetType(), {
				[BossRushStoryNode.NODE_TYPE.NORMAL] = function()
					return "Anim_LevelSelectAtelierYumia_storytpl_In"
				end,
				[BossRushStoryNode.NODE_TYPE.BATTLE] = function()
					return "Anim_LevelSelectAtelierYumia_bettletpl_In"
				end,
				[BossRushStoryNode.NODE_TYPE.LOCATION] = function()
					return "Anim_LevelSelectAtelierYumia_Item_Lock_In"
				end
			}, function()
				assert(false)

				return
			end))
		else
			setActive(var_12_5, var_12_6)
		end

		if iter_12_1:GetType() ~= BossRushStoryNode.NODE_TYPE.LOCATION then
			var_12_2 = var_12_2 + (var_12_7 and 1 or 0)
			var_12_3 = var_12_3 + 1

			if var_12_7 then
				table.insert(var_12_4, iter_12_1)
			end
		end

		if var_12_6 then
			local var_12_9 = iter_12_1:GetParams("item_lock")
			local var_12_10 = var_12_9 and Drop.Create(var_12_9[2]) or nil
			local var_12_11 = var_12_10 and var_12_10.count > var_12_10:getOwnedCount() and "item_lock" or switch(iter_12_1:GetType(), {
				[BossRushStoryNode.NODE_TYPE.NORMAL] = function()
					return "story"
				end,
				[BossRushStoryNode.NODE_TYPE.BATTLE] = function()
					return "battle"
				end,
				[BossRushStoryNode.NODE_TYPE.LOCATION] = function()
					return "location"
				end
			})

			eachChild(var_12_5, function(arg_20_0, arg_20_1)
				setActive(arg_20_0, arg_20_0.name == var_12_11)

				return
			end)
			switch(var_12_11, {
				story = function(arg_21_0)
					setText(arg_21_0:Find("name/Text"), iter_12_1:GetName())
					onButton(arg_12_0, arg_21_0, function()
						if var_12_7 then
							return
						end

						arg_12_0:PlayStory(iter_12_1:GetStory(), function()
							arg_12_0:UpdateView()
							arg_12_0:CheckAutoShowPersonal()

							return
						end)

						return
					end)

					return
				end,
				battle = function(arg_24_0)
					setText(arg_24_0:Find("name/Text"), iter_12_1:GetName())
					onButton(arg_12_0, arg_24_0, function()
						if var_12_7 then
							return
						end

						arg_12_0:PlayStory(iter_12_1:GetStory(), function()
							arg_12_0:UpdateView()
							arg_12_0:CheckAutoShowPersonal()

							return
						end)

						return
					end)

					return
				end,
				location = function(arg_27_0)
					setText(arg_27_0:Find("name/Text"), iter_12_1:GetName())

					if PLATFORM_CODE ~= PLATFORM_US then
						setActive(arg_27_0:Find("en"), true)
						setText(arg_27_0:Find("en"), iter_12_1:getConfig("en_name"))
					end

					return
				end
			}, function()
				warning("error state without any display:", var_12_11)

				return
			end, var_12_5:Find(var_12_11))
		end
	end

	setText(arg_12_0.progressText, var_12_2 .. "/" .. var_12_3)
	setActive(arg_12_0.storyAward, tobool(arg_12_0.storyTask))

	if arg_12_0.storyTask then
		updateDrop(arg_12_0.storyAward:GetChild(0), (Drop.Create(arg_12_0.storyTask:getConfig("award_display")[1])))

		local var_12_12 = arg_12_0.storyTask:getTaskStatus()

		setActive(arg_12_0.storyAward:Find("get"), var_12_12 == 1)
		setActive(arg_12_0.storyAward:Find("got"), var_12_12 == 2)
		onButton(arg_12_0, arg_12_0.storyAward, function()
			arg_12_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)
	end

	table.sort(var_12_4, function(arg_30_0, arg_30_1)
		return arg_30_0:getConfig("id") < arg_30_1:getConfig("id")
	end)

	local var_12_13 = var_12_4[#var_12_4]
	local var_12_14
	local var_12_15 = #var_12_4 - 1

	while var_12_15 > 0 do
		if #arg_12_0.personalPage:GetActivitySingleEventOption(var_12_4[var_12_15]) > 0 then
			var_12_14 = var_12_4[var_12_15]

			break
		end

		var_12_15 = var_12_15 - 1
	end

	if var_12_13 and #arg_12_0.personalPage:GetActivitySingleEventOption(var_12_13) > 0 or var_12_14 and #arg_12_0.personalPage:GetActivitySingleEventOption(var_12_14) > 0 then
		setActive(arg_12_0.personalBtn, true)
	else
		setActive(arg_12_0.personalBtn, false)
	end

	var_12_14 = var_12_14 and var_12_14 or var_12_13

	arg_12_0.personalPage:SetBossRushNode(var_12_13, var_12_14)

	if var_12_2 == var_12_3 then
		arg_12_0.personalPage:UnlockRandom()
	end

	if arg_12_0.activity:getConfig("config_client").first_story then
		pg.NewStoryMgr.GetInstance():Play(arg_12_0.activity:getConfig("config_client").first_story)
	end

	return
end

function var_0_0.CheckAutoShowPersonal(arg_31_0)
	if #arg_31_0.personalPage:GetActivitySingleEventOption(arg_31_0.personalPage:GetCurrentEvent()) > 0 then
		arg_31_0.personalPage:SetUpgrade()
		arg_31_0.personalPage:ExecuteAction("Show")
		arg_31_0.personalPage:ExecuteAction("UpdateView")
	end

	return
end

var_0_0.presonalRandomData = nil

return var_0_0
