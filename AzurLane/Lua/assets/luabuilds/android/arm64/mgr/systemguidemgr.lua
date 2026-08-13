pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SystemGuideMgr = var_0_10001("SystemGuideMgr")
pg = var_0

local var_0_1 = var_0.SystemGuideMgr
local var_0_2

function var_0_1.Init(arg_1_0, arg_1_1)
	require = var_1_10002
	var_0_2 = var_1_10002("GameCfg.guide.newguide.SSG001")

	arg_1_1()

	return
end

local function var_0_3(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	if var_1_10001(var_1_10003) then
		pg = var_1_10002

		local var_2_0 = var_1_10002.NewStoryMgr.GetInstance()

		return var_2.IsPlayed(var_2_0, arg_2_0)
	end

	return false
end

local function var_0_4(arg_3_0)
	if arg_3_0 then
		arg_3_0()
	end

	return
end

local function var_0_5(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	pg = var_1_10004

	local var_4_0 = var_1_10004.SeriesGuideMgr.GetInstance()

	if var_4.isRunning(var_4_0) then
		var_0_4(arg_4_2)

		return
	end

	if var_0_3(arg_4_0) then
		var_0_4(arg_4_2)

		return
	end

	pg = var_4

	local var_4_1 = var_4.NewGuideMgr.GetInstance()

	if not var_4.CanPlay(var_4_1) then
		var_0_4(arg_4_2)

		return
	end

	local var_4_3

	if arg_4_0 == "SYG001" then
		pg = var_4_3

		local var_4_2 = var_4_3.TrackerMgr.GetInstance()

		var_4_3 = var_4_3.Tracking
		TRACKING_TUTORIAL_COMPLETE_2 = var_1_10007

		var_4_3(var_4_2, var_1_10007)
	elseif arg_4_0 == "SYG003" then
		pg = var_4_3

		local var_4_4 = var_4_3.TrackerMgr.GetInstance()

		var_4_3 = var_4_3.Tracking
		TRACKING_TUTORIAL_COMPLETE_3 = var_1_10007

		var_4_3(var_4_4, var_1_10007)
	elseif arg_4_0 == "SYG006" then
		pg = var_4_3

		local var_4_5 = var_4_3.TrackerMgr.GetInstance()

		var_4_3 = var_4_3.Tracking
		TRACKING_TUTORIAL_COMPLETE_4 = var_1_10007

		var_4_3(var_4_5, var_1_10007)
	end

	if arg_4_3 then
		pg = var_4_3

		local var_4_6 = var_4_3.NewGuideMgr.GetInstance()

		var_4_3.Play(var_4_6, arg_4_0, arg_4_1, function()
			pg = var_2_10000

			local var_5_0 = var_2_10000.m02
			local var_5_1 = var_0.sendNotification

			GAME = var_2_10003

			var_5_1(var_5_0, var_2_10003.STORY_UPDATE, {
				storyId = arg_4_0
			})

			existCall = var_5_1

			var_5_1(arg_4_2)

			return
		end)
	else
		pg = var_4_3

		local var_4_7 = var_4_3.m02
		local var_4_8 = var_4.sendNotification

		GAME = var_1_10007

		var_4_8(var_4_7, var_1_10007.STORY_UPDATE, {
			storyId = arg_4_0
		})

		pg = var_4_8

		local var_4_9 = var_4_8.NewGuideMgr.GetInstance()

		var_4.Play(var_4_9, arg_4_0, arg_4_1, arg_4_2)
	end

	return
end

function var_0_1.Play(arg_6_0, arg_6_1, arg_6_2)
	IsUnityEditor = var_1_10003

	if var_1_10003 then
		ENABLE_GUIDE = var_1_10003

		if not var_1_10003 then
			if arg_6_2 then
				arg_6_2()
			end

			return
		end
	end

	if arg_6_1.exited then
		return
	end

	if not var_0_2[arg_6_1.__cname] then
		var_0_4(arg_6_2)

		return
	end

	_ = var_4

	if not var_4.detect(var_3, function(arg_7_0)
		local var_7_0 = arg_7_0.id
		local var_7_1 = arg_7_0.condition

		return not var_0_3(var_7_0) and var_7_1(arg_6_1)
	end) then
		var_0_4(arg_6_2)

		return
	end

	local var_6_0 = var_4.id
	local var_6_1 = var_4.args(arg_6_1)

	var_0_5(var_6_0, var_6_1, arg_6_2)

	return
end

function var_0_1.PlayChapter(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1.id == 1160002 then
		arg_8_0:PlayByGuideId("NG0011", nil, arg_8_2)
	elseif arg_8_1:isTypeDefence() then
		arg_8_0:PlayByGuideId("NG0016", nil, arg_8_2)
	else
		existCall = var_3

		var_3(arg_8_2)
	end

	return
end

function var_0_1.PlayByGuideId(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	var_0_5(arg_9_1, arg_9_2, arg_9_3, arg_9_4)

	return
end

function var_0_1.FixGuide(arg_10_0, arg_10_1)
	if not var_0_3("FixGuide") then
		var_0_5("FixGuide")
		arg_10_1()
	end

	return
end

function var_0_1.PlayDailyLevel(arg_11_0, arg_11_1)
	if not var_0_3("NG0015") then
		pg = var_2

		local var_11_0 = var_2.m02
		local var_11_1 = var_2.sendNotification

		GAME = var_1_10005

		var_11_1(var_11_0, var_1_10005.STORY_UPDATE, {
			storyId = "NG0015"
		})
		arg_11_1()
	end

	return
end

function var_0_1.PlayCommander(arg_12_0)
	local var_12_0 = {
		"ZHIHUIMIAO2",
		"NG006",
		"NG007",
		"ZHIHUIMIAO3",
		"NG008",
		"ZHIHUIMIAO4",
		"NG009"
	}

	LOCK_CATTERY = var_1_10002

	if not var_1_10002 then
		table = var_1_10002

		var_1_10002.insert(var_12_0, "NG0029")
	end

	_ = var_1_10002

	local var_12_1 = var_1_10002.select(var_12_0, function(arg_13_0)
		return not var_0_3(arg_13_0)
	end)
	local var_12_2 = {}
	local var_12_3

	ipairs = var_5

	for iter_12_0, iter_12_1 in var_5(var_12_1) do
		table = var_1_10010

		var_1_10010.insert(var_12_2, function(arg_14_0)
			if iter_12_1 == "NG006" then
				table = var_14_0

				local var_14_0 = var_14_0.getCount

				getProxy = var_2_10003
				CommanderProxy = var_2_10005
				var_2_10005 = var_2_10003(var_2_10005)
				var_14_0 = var_14_0(var_2_10003.getData(var_2_10005))

				if not (1 <= var_14_0) then
					if iter_12_1 == "NG007" then
						getProxy = var_14_0
						BagProxy = var_2_10003
						var_2_10003 = var_14_0(var_2_10003)

						if not (var_14_0.getItemCountById(var_2_10003, 20012) < 1) then
							if iter_12_1 == "NG008" then
								getProxy = var_14_0
								CommanderProxy = var_2_10003
								var_2_10003 = var_14_0(var_2_10003)
								var_2_10003 = var_14_0.getBoxes(var_2_10003)[1]
								var_14_0 = var_14_0.getState(var_2_10003)
								CommanderBox = var_2_10002

								if var_14_0 == var_2_10002.STATE_FINISHED then
									if iter_12_1 == "NG009" then
										table = var_14_0
										var_14_0 = var_14_0.getCount
										getProxy = var_2_10003
										CommanderProxy = var_2_10005

										local var_14_1 = var_2_10003(var_2_10005)

										if var_14_0(var_3.getData(var_14_1)) ~= 1 then
											pg = var_14_0

											local var_14_2 = var_14_0.m02
											local var_14_3 = var_1.sendNotification

											GAME = var_2_10004

											var_14_3(var_14_2, var_2_10004.STORY_UPDATE, {
												storyId = iter_12_1
											})
											arg_14_0()

											goto label_14_0
										end
									end

									if iter_12_1 == "ZHIHUIMIAO2" or iter_12_1 == "ZHIHUIMIAO3" or iter_12_1 == "ZHIHUIMIAO4" then
										pg = var_1

										local var_14_4 = var_1.NewStoryMgr.GetInstance()

										var_1.Play(var_14_4, iter_12_1, arg_14_0, true)
									elseif iter_12_1 == "NG0029" then
										if var_12_3 == "NG009" then
											var_0_5(iter_12_1, {
												1
											}, arg_14_0)
										else
											var_0_5(iter_12_1, {
												2
											}, arg_14_0)
										end
									else
										var_12_3 = iter_12_1

										var_0_5(iter_12_1, {}, arg_14_0)
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

	seriesAsync = var_5

	var_5(var_12_2)

	return
end

function var_0_1.PlayGuildAssaultFleet(arg_15_0, arg_15_1)
	arg_15_0:PlayByGuideId("GNG001", {}, arg_15_1)

	return
end

return
