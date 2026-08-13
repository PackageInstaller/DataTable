local var_0_0 = {}

TimelineSupport = TimelineSupport

function var_0.InitTimeline(arg_1_0)
	var_0.DynamicBinding(arg_1_0)
	var_0.InitHXGroup(arg_1_0)

	return
end

function var_0.EachDirector(arg_2_0, arg_2_1)
	arg_2_1(arg_2_0)

	eachChild = var_2

	var_2(arg_2_0, function(arg_3_0)
		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.GetComponent

		typeof = var_2_10004
		UnityEngine = var_2_10006

		if var_3_1(var_3_0, var_2_10004(var_2_10006.Playables.PlayableDirector)) then
			var_0.EachDirector(var_1, arg_2_1)
		end

		return
	end)

	return
end

function var_0.EachTrack(arg_4_0, arg_4_1)
	table = var_1_10002

	local var_4_0 = var_1_10002.IpairsCArray

	TimelineHelper = var_1_10004

	var_4_0(var_1_10004.GetTimelineTracks(arg_4_0), function(arg_5_0, arg_5_1)
		arg_4_1(arg_5_0, arg_5_1)

		return
	end)

	return
end

function var_0.EachGroupTrack(arg_6_0, arg_6_1)
	table = var_1_10002

	local var_6_0 = var_1_10002.IpairsCArray

	TimelineHelper = var_1_10004

	var_6_0(var_1_10004.GetGroupTracks(arg_6_0), function(arg_7_0, arg_7_1)
		arg_6_1(arg_7_0, arg_7_1)

		return
	end)

	return
end

function var_0.DynamicBinding(arg_8_0)
	_ = var_1_10001

	local var_8_0 = var_1_10001.reduce

	pg = var_1_10003

	local var_8_1 = var_8_0(var_1_10003.dorm3d_timeline_dynamic_binding.all, {}, function(arg_9_0, arg_9_1)
		pg = var_2_10002

		if var_2_10002.dorm3d_timeline_dynamic_binding[arg_9_1].track_name then
			arg_9_0[var_2.track_name] = var_2.object_name
		end

		return arg_9_0
	end)

	var_0.EachDirector(arg_8_0, function(arg_10_0)
		var_0.EachTrack(arg_10_0, function(arg_11_0, arg_11_1)
			if var_8_1[arg_11_1.name] then
				GameObject = var_2

				if var_2.Find(var_8_1[arg_11_1.name]) then
					TimelineHelper = var_3

					var_3.SetAutoBinding(arg_10_0, arg_11_1, var_2)
				else
					warning = var_3
					string = var_5

					var_3(var_5.format("轨道%s需要绑定的物体%s不存在", arg_11_1.name, var_8_1[arg_11_1.name]))
				end
			end

			return
		end)

		return
	end)

	return
end

function var_0.InitSubtitle(arg_12_0, arg_12_1)
	GameObject = var_1_10002

	if var_1_10002.Find("[subtitle]") then
		pg = var_1_10003

		local var_12_0 = var_1_10003.ViewUtils.SetLayer
		local var_12_1 = var_2.transform

		Layer = var_1_10006

		var_12_0(var_12_1, var_1_10006.UI)

		local var_12_2 = var_2
		local var_12_3 = var_2.GetComponent

		typeof = var_6
		Canvas = var_1_10008

		local var_12_4 = var_12_3(var_12_2, var_6(var_1_10008))

		pg = var_4
		var_12_4.worldCamera = var_4.UIMgr.GetInstance().overlayCameraComp
	end

	local function var_12_5(arg_13_0)
		tonumber = var_2_10001

		if not var_2_10001(arg_13_0) then
			return arg_13_0
		end

		pg = var_2_10002

		local var_13_0 = var_2_10002.dorm3d_subtitle[var_1].subtitle

		HXSet = var_3

		local var_13_1 = var_3.hxLan

		string = var_2_10005

		return (var_13_1(var_2_10005.gsub(var_13_0, "$dorm3d", arg_12_1)))
	end

	BLHXTimeline = var_4
	var_4.SubtitleMixer.func = var_12_5

	return
end

function var_0.DisablePlayOnAwake(arg_14_0)
	var_0.EachDirector(arg_14_0, function(arg_15_0)
		arg_15_0.playOnAwake = false

		return
	end)

	return
end

function var_0.InitHXGroup(arg_16_0)
	var_0.EachDirector(arg_16_0, function(arg_17_0)
		local var_17_0 = false

		var_0.EachGroupTrack(arg_17_0, function(arg_18_0, arg_18_1)
			if arg_18_1.name == "HXGroup" then
				local var_18_0 = arg_18_1.muted

				HXSet = var_3_10003

				if var_18_0 ~= not var_3_10003.isHx() then
					HXSet = var_18_0
					arg_18_1.muted = not var_18_0.isHx()
					var_17_0 = true
				end
			end

			return
		end)

		if var_17_0 then
			arg_17_0:RebuildGraph()
		end

		return
	end)

	return
end

return
