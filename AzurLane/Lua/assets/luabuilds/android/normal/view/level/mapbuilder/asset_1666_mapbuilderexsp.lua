class = var_0_10000

local var_0_0 = "MapBuilderEXSP"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MapBuilderSPSeriesFull"))

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPEATELIERYUMIA
end

function var_0_1.getUIName(arg_2_0)
	return "LevelSelectEXSPUI"
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	local var_3_0 = arg_3_0._tf

	arg_3_0.personalBtn = var_1.Find(var_3_0, "Story/PersonalCard")
	SecretsAbyssPersonalPage = var_1
	arg_3_0.personalPage = var_1.New(arg_3_0._tf, arg_3_0, {})
	onButton = var_1

	var_1(arg_3_0, arg_3_0.personalBtn, function()
		local var_4_0 = arg_3_0.personalPage

		var_0.ExecuteAction(var_4_0, "Show")

		return
	end)

	return
end

function var_0_1.UpdateMapVO(arg_5_0, arg_5_1)
	var_0_1.super.UpdateMapVO(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_0.activity

	if var_2.getConfig(var_5_0, "config_client").roll_task then
		local var_5_1 = arg_5_0.personalPage

		var_2.RegisterRandomCallback(var_5_1, function()
			local var_6_0 = arg_5_0.sceneParent
			local var_6_1 = var_0.emit

			LevelMediator2 = var_2_10002

			local var_6_2 = var_2_10002.ON_UPDATE_LOWPRIORITY_TASK
			local var_6_3 = arg_5_0.activity

			var_6_1(var_6_0, var_6_2, var_3.getConfig(var_6_3, "config_client").roll_task)

			return
		end)
	end

	return
end

function var_0_1.SetDisplayMode(arg_7_0, arg_7_1)
	var_0_1.super.SetDisplayMode(arg_7_0, arg_7_1)

	if arg_7_0.contextData.displayMode == var_0_1.DISPLAY.BATTLE then
		quickPlayAnimation = var_3

		var_3(arg_7_0._tf, "Anim_LevelSelectAtelierYumia_Battle_In")
	else
		quickPlayAnimation = var_3

		var_3(arg_7_0._tf, "Anim_LevelSelectAtelierYumia_In")
	end

	return
end

function var_0_1.PlayerLevelTplAnimation(arg_8_0, arg_8_1, arg_8_2)
	quickPlayAnimation = var_1_10003

	local var_8_0 = arg_8_1

	switch = var_1_10005

	var_1_10003(var_8_0, var_1_10005(arg_8_2.status, {
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

function var_0_1.UpdateStory(arg_12_0)
	local var_12_0 = {}

	pg = var_1_10002

	local var_12_1 = var_1_10002.NewStoryMgr.GetInstance()
	local var_12_2 = 0
	local var_12_3 = 0
	local var_12_4 = {}

	pairs = var_1_10006

	for iter_12_0, iter_12_1 in var_1_10006(arg_12_0.storyNodesDict) do
		local var_12_5 = arg_12_0.storyHolder
		local var_12_6 = var_11.Find

		tostring = var_1_10013

		local var_12_7 = var_12_6(var_12_5, var_1_10013(iter_12_1.id))

		var_1_10013 = iter_12_1

		local var_12_8 = iter_12_1.IsActive(var_1_10013, arg_12_0.activity, arg_12_0.ptActivity)
		local var_12_9 = iter_12_1

		var_1_10013 = iter_12_1.IsReaded(var_12_9)
		_G = var_12_9

		if not var_12_9.isActive(var_12_7) and var_12_8 then
			setActive = var_14

			var_14(var_12_7, var_12_8)

			quickPlayAnimation = var_14

			local var_12_10 = var_12_7

			switch = var_16

			local var_12_11 = iter_12_1:GetType()
			local var_12_12 = {}

			BossRushStoryNode = var_1_10019
			var_12_12[var_1_10019.NODE_TYPE.NORMAL] = function()
				return "Anim_LevelSelectAtelierYumia_storytpl_In"
			end
			BossRushStoryNode = var_1_10019
			var_12_12[var_1_10019.NODE_TYPE.BATTLE] = function()
				return "Anim_LevelSelectAtelierYumia_bettletpl_In"
			end
			BossRushStoryNode = var_1_10019
			var_12_12[var_1_10019.NODE_TYPE.LOCATION] = function()
				return "Anim_LevelSelectAtelierYumia_Item_Lock_In"
			end

			var_14(var_12_10, var_16(var_12_11, var_12_12, function()
				assert = var_2_10000

				var_2_10000(false)

				return
			end))
		else
			setActive = var_14

			var_14(var_12_7, var_12_8)
		end

		local var_12_13 = iter_12_1
		local var_12_14 = iter_12_1.GetType(var_12_13)

		BossRushStoryNode = var_12_13

		if var_12_14 ~= var_12_13.NODE_TYPE.LOCATION then
			var_12_2 = var_12_2 + (var_1_10013 and 1 or 0)
			var_12_3 = var_12_3 + 1

			if var_1_10013 then
				table = var_14

				var_14.insert(var_12_4, iter_12_1)
			end
		end

		if var_12_8 then
			local var_12_15
			local var_12_16 = iter_12_1

			if iter_12_1.GetParams(var_12_16, "item_lock") then
				Drop = var_12_16

				local var_12_17

				if not var_12_16.Create(var_15[2]) then
					var_12_17 = nil
				end

				local var_12_18

				if var_12_17 then
					var_12_18 = var_12_17.count
					var_1_10019 = var_12_17

					if var_12_18 > var_12_17.getOwnedCount(var_1_10019) then
						var_12_15 = "item_lock"

						goto label_12_0
					end
				end

				switch = var_12_18
				var_1_10019 = iter_12_1

				do
					local var_12_19 = iter_12_1.GetType(var_1_10019)

					var_1_10019 = {}
					BossRushStoryNode = var_1_10020
					var_1_10019[var_1_10020.NODE_TYPE.NORMAL] = function()
						return "story"
					end
					BossRushStoryNode = var_1_10020
					var_1_10019[var_1_10020.NODE_TYPE.BATTLE] = function()
						return "battle"
					end
					BossRushStoryNode = var_1_10020
					var_1_10019[var_1_10020.NODE_TYPE.LOCATION] = function()
						return "location"
					end
					var_12_15 = var_12_18(var_12_19, var_1_10019)
				end

				::label_12_0::

				eachChild = var_12_18

				var_12_18(var_12_7, function(arg_20_0, arg_20_1)
					setActive = var_2_10002

					var_2_10002(arg_20_0, arg_20_0.name == var_12_15)

					return
				end)

				switch = var_12_18

				var_12_18(var_12_15, {
					story = function(arg_21_0)
						setText = var_2_10001

						local var_21_0 = arg_21_0:Find("name/Text")
						local var_21_1 = iter_12_1

						var_2_10001(var_21_0, var_3.GetName(var_21_1))

						onButton = var_2_10001

						var_2_10001(arg_12_0, arg_21_0, function()
							if var_1_10013 then
								return
							end

							local var_22_0 = iter_12_1
							local var_22_1 = var_0.GetStory(var_22_0)
							local var_22_2 = arg_12_0

							var_1.PlayStory(var_22_2, var_22_1, function()
								local var_23_0 = arg_12_0

								var_0.UpdateView(var_23_0)

								local var_23_1 = arg_12_0

								var_0.CheckAutoShowPersonal(var_23_1)

								return
							end)

							return
						end)

						return
					end,
					battle = function(arg_24_0)
						setText = var_2_10001

						local var_24_0 = arg_24_0:Find("name/Text")
						local var_24_1 = iter_12_1

						var_2_10001(var_24_0, var_3.GetName(var_24_1))

						onButton = var_2_10001

						var_2_10001(arg_12_0, arg_24_0, function()
							if var_1_10013 then
								return
							end

							local var_25_0 = iter_12_1
							local var_25_1 = var_0.GetStory(var_25_0)
							local var_25_2 = arg_12_0

							var_1.PlayStory(var_25_2, var_25_1, function()
								local var_26_0 = arg_12_0

								var_0.UpdateView(var_26_0)

								local var_26_1 = arg_12_0

								var_0.CheckAutoShowPersonal(var_26_1)

								return
							end)

							return
						end)

						return
					end,
					location = function(arg_27_0)
						setText = var_2_10001

						local var_27_0 = arg_27_0:Find("name/Text")
						local var_27_1 = iter_12_1

						var_2_10001(var_27_0, var_3.GetName(var_27_1))

						PLATFORM_CODE = var_2_10001
						PLATFORM_US = var_27_0

						if var_2_10001 ~= var_27_0 then
							setActive = var_2_10001

							var_2_10001(arg_27_0:Find("en"), true)

							setText = var_2_10001

							local var_27_2 = arg_27_0:Find("en")
							local var_27_3 = iter_12_1

							var_2_10001(var_27_2, var_3.getConfig(var_27_3, "en_name"))
						end

						return
					end
				}, function()
					warning = var_2_10000

					var_2_10000("error state without any display:", var_12_15)

					return
				end, var_12_7:Find(var_12_15))
			end
		end
	end

	setText = var_6

	var_6(arg_12_0.progressText, var_12_2 .. "/" .. var_12_3)

	setActive = var_6

	local var_12_20 = arg_12_0.storyAward

	tobool = var_8

	var_6(var_12_20, var_8(arg_12_0.storyTask))

	local var_12_22

	if arg_12_0.storyTask then
		local var_12_21 = arg_12_0.storyTask

		var_12_22 = var_12_22.getConfig(var_12_21, "award_display")
		Drop = var_12_21

		local var_12_23 = var_12_21.Create(var_12_22[1])

		updateDrop = var_8

		local var_12_24 = arg_12_0.storyAward

		var_8(var_9.GetChild(var_12_24, 0), var_12_23)

		local var_12_25 = arg_12_0.storyTask
		local var_12_26 = var_8.getTaskStatus(var_12_25)

		setActive = var_12_25

		local var_12_27 = arg_12_0.storyAward

		var_12_25(var_10.Find(var_12_27, "get"), var_12_26 == 1)

		setActive = var_12_25

		local var_12_28 = arg_12_0.storyAward

		var_12_25(var_10.Find(var_12_28, "got"), var_12_26 == 2)

		onButton = var_12_25

		var_12_25(arg_12_0, arg_12_0.storyAward, function()
			local var_29_0 = arg_12_0
			local var_29_1 = var_0.emit

			BaseUI = var_2_10002

			var_29_1(var_29_0, var_2_10002.ON_DROP, var_12_23)

			return
		end)
	end

	table = var_12_22

	var_12_22.sort(var_12_4, function(arg_30_0, arg_30_1)
		return arg_30_0:getConfig("id") < arg_30_1:getConfig("id")
	end)

	local var_12_29 = var_12_4[#var_12_4]
	local var_12_30
	local var_12_31 = #var_12_4 - 1

	while 0 < var_12_31 do
		local var_12_32 = arg_12_0.personalPage

		if #var_9.GetActivitySingleEventOption(var_12_32, var_12_4[var_12_31]) > 0 then
			var_12_30 = var_12_4[var_12_31]

			break
		end

		var_12_31 = var_12_31 - 1
	end

	if var_12_29 then
		local var_12_33 = arg_12_0.personalPage

		if not (#var_9.GetActivitySingleEventOption(var_12_33, var_12_29) > 0) then
			if var_12_30 then
				local var_12_34 = arg_12_0.personalPage

				if #var_9.GetActivitySingleEventOption(var_12_34, var_12_30) > 0 then
					setActive = var_9

					var_9(arg_12_0.personalBtn, true)

					goto label_12_1
				end
			end

			setActive = var_9

			var_9(arg_12_0.personalBtn, false)

			::label_12_1::

			var_12_30 = var_12_30 and var_12_30 or var_12_29

			local var_12_35 = arg_12_0.personalPage

			var_9.SetBossRushNode(var_12_35, var_12_29, var_12_30)

			if var_12_2 == var_12_3 then
				local var_12_36 = arg_12_0.personalPage

				var_9.UnlockRandom(var_12_36)
			end

			local var_12_37 = arg_12_0.activity

			if var_9.getConfig(var_12_37, "config_client").first_story then
				pg = var_9

				local var_12_38 = var_9.NewStoryMgr.GetInstance()
				local var_12_39 = var_9.Play
				local var_12_40 = arg_12_0.activity

				var_12_39(var_12_38, var_11.getConfig(var_12_40, "config_client").first_story)
			end

			return
		end
	end
end

function var_0_1.CheckAutoShowPersonal(arg_31_0)
	local var_31_0 = arg_31_0.personalPage
	local var_31_1 = var_1.GetActivitySingleEventOption
	local var_31_2 = arg_31_0.personalPage

	if #var_31_1(var_31_0, var_3.GetCurrentEvent(var_31_2)) > 0 then
		local var_31_3 = arg_31_0.personalPage

		var_2.SetUpgrade(var_31_3)

		local var_31_4 = arg_31_0.personalPage

		var_2.ExecuteAction(var_31_4, "Show")

		local var_31_5 = arg_31_0.personalPage

		var_2.ExecuteAction(var_31_5, "UpdateView")
	end

	return
end

var_0_1.presonalRandomData = nil

return var_0_1
