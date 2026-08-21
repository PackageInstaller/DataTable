pg = pg or {}
pg.SystemGuideMgr = singletonClass("SystemGuideMgr")

local var_0_0

function pg.SystemGuideMgr.Init(arg_1_0, arg_1_1)
	var_0_0 = require("GameCfg.guide.newguide.SSG001")

	arg_1_1()

	return
end

local function var_0_1(arg_2_0)
	if getProxy(PlayerProxy) then
		return pg.NewStoryMgr.GetInstance():IsPlayed(arg_2_0)
	end

	return false
end

local function var_0_2(arg_3_0)
	if arg_3_0 then
		arg_3_0()
	end

	return
end

local function var_0_3(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if pg.SeriesGuideMgr.GetInstance():isRunning() then
		var_0_2(arg_4_2)

		return
	end

	if var_0_1(arg_4_0) then
		var_0_2(arg_4_2)

		return
	end

	local var_4_0 = pg.NewGuideMgr.GetInstance()

	if not var_4_0:CanPlay() then
		var_0_2(arg_4_2)

		return
	end

	if arg_4_0 == "SYG001" then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_TUTORIAL_COMPLETE_2)
	elseif arg_4_0 == "SYG003" then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_TUTORIAL_COMPLETE_3)
	elseif arg_4_0 == "SYG006" then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_TUTORIAL_COMPLETE_4)
	end

	if arg_4_3 then
		pg.NewGuideMgr.GetInstance():Play(arg_4_0, arg_4_1, function()
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = arg_4_0
			})
			existCall(arg_4_2)

			return
		end)
	else
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_4_0
		})
		pg.NewGuideMgr.GetInstance():Play(arg_4_0, arg_4_1, arg_4_2)
	end

	return
end

function pg.SystemGuideMgr.Play(arg_6_0, arg_6_1, arg_6_2)
	if IsUnityEditor and not ENABLE_GUIDE then
		if arg_6_2 then
			arg_6_2()
		end

		return
	end

	if arg_6_1.exited then
		return
	end

	local var_6_0 = var_0_0[arg_6_1.__cname]

	if not var_0_0[arg_6_1.__cname] then
		var_0_2(arg_6_2)

		return
	end

	local var_6_1 = _.detect(var_6_0, function(arg_7_0)
		return not var_0_1(arg_7_0.id) and var_7_0(arg_6_1)
	end)

	if not var_6_1 then
		var_0_2(arg_6_2)

		return
	end

	var_0_3(var_6_1.id, var_6_1.args(arg_6_1), arg_6_2)

	return
end

function pg.SystemGuideMgr.PlayChapter(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1.id == 1160002 then
		arg_8_0:PlayByGuideId("NG0011", nil, arg_8_2)
	elseif arg_8_1:isTypeDefence() then
		arg_8_0:PlayByGuideId("NG0016", nil, arg_8_2)
	else
		existCall(arg_8_2)
	end

	return
end

function pg.SystemGuideMgr.PlayByGuideId(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_3(arg_9_1, arg_9_2, arg_9_3, arg_9_4)

	return
end

function pg.SystemGuideMgr.FixGuide(arg_10_0, arg_10_1)
	if not var_0_1("FixGuide") then
		var_0_3("FixGuide")
		arg_10_1()
	end

	return
end

function pg.SystemGuideMgr.PlayDailyLevel(arg_11_0, arg_11_1)
	if not var_0_1("NG0015") then
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = "NG0015"
		})
		arg_11_1()
	end

	return
end

function pg.SystemGuideMgr.PlayCommander(arg_12_0)
	local var_12_0

	if not LOCK_CATTERY then
		table.insert({
			"ZHIHUIMIAO2",
			"NG006",
			"NG007",
			"ZHIHUIMIAO3",
			"NG008",
			"ZHIHUIMIAO4",
			"NG009"
		}, "NG0029")

		var_12_0 = nil
	end

	for iter_12_0, iter_12_1 in ipairs((_.select({
		"ZHIHUIMIAO2",
		"NG006",
		"NG007",
		"ZHIHUIMIAO3",
		"NG008",
		"ZHIHUIMIAO4",
		"NG009"
	}, function(arg_13_0)
		return not var_0_1(arg_13_0)
	end))) do
		table.insert({}, function(arg_14_0)
			if iter_12_1 == "NG006" then
				if table.getCount(getProxy(CommanderProxy):getData()) < 1 then
					if iter_12_1 == "NG007" then
						if getProxy(BagProxy):getItemCountById(20012) >= 1 then
							if iter_12_1 == "NG008" then
								if getProxy(CommanderProxy):getBoxes()[1]:getState() == CommanderBox.STATE_FINISHED then
									if iter_12_1 == "NG009" then
										if table.getCount(getProxy(CommanderProxy):getData()) ~= 1 then
											pg.m02:sendNotification(GAME.STORY_UPDATE, {
												storyId = iter_12_1
											})
											arg_14_0()

											goto label_14_0
										end
									end

									if iter_12_1 == "ZHIHUIMIAO2" or iter_12_1 == "ZHIHUIMIAO3" or iter_12_1 == "ZHIHUIMIAO4" then
										pg.NewStoryMgr.GetInstance():Play(iter_12_1, arg_14_0, true)
									elseif iter_12_1 == "NG0029" then
										if var_12_0 == "NG009" then
											var_0_3(iter_12_1, {
												1
											}, arg_14_0)
										else
											var_0_3(iter_12_1, {
												2
											}, arg_14_0)
										end
									else
										var_12_0 = iter_12_1

										var_0_3(iter_12_1, {}, arg_14_0)
									end

									::label_14_0::

									return
								end
							end
						end
					end
				end
			end
		end)
	end

	seriesAsync({})

	return
end

function pg.SystemGuideMgr.PlayGuildAssaultFleet(arg_15_0, arg_15_1)
	arg_15_0:PlayByGuideId("GNG001", {}, arg_15_1)

	return
end

return
