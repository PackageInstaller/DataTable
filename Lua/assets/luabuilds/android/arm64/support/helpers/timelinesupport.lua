TimelineSupport = {}

local var_0_0 = TimelineSupport

function TimelineSupport.InitTimeline(arg_1_0)
	var_0_0.DynamicBinding(arg_1_0)
	var_0_0.InitHXGroup(arg_1_0)

	return
end

function TimelineSupport.EachDirector(arg_2_0, arg_2_1)
	arg_2_1(arg_2_0)
	eachChild(arg_2_0, function(arg_3_0)
		local var_3_0 = arg_3_0:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

		if var_3_0 then
			var_0_0.EachDirector(var_3_0, arg_2_1)
		end

		return
	end)

	return
end

function TimelineSupport.EachTrack(arg_4_0, arg_4_1)
	table.IpairsCArray(TimelineHelper.GetTimelineTracks(arg_4_0), function(arg_5_0, arg_5_1)
		arg_4_1(arg_5_0, arg_5_1)

		return
	end)

	return
end

function TimelineSupport.EachGroupTrack(arg_6_0, arg_6_1)
	table.IpairsCArray(TimelineHelper.GetGroupTracks(arg_6_0), function(arg_7_0, arg_7_1)
		arg_6_1(arg_7_0, arg_7_1)

		return
	end)

	return
end

function TimelineSupport.DynamicBinding(arg_8_0)
	local var_8_0 = _.reduce(pg.dorm3d_timeline_dynamic_binding.all, {}, function(arg_9_0, arg_9_1)
		if pg.dorm3d_timeline_dynamic_binding[arg_9_1].track_name then
			arg_9_0[pg.dorm3d_timeline_dynamic_binding[arg_9_1].track_name] = pg.dorm3d_timeline_dynamic_binding[arg_9_1].object_name
		end

		return arg_9_0
	end)

	var_0_0.EachDirector(arg_8_0, function(arg_10_0)
		var_0_0.EachTrack(arg_10_0, function(arg_11_0, arg_11_1)
			if var_8_0[arg_11_1.name] then
				local var_11_0 = GameObject.Find(var_8_0[arg_11_1.name])

				if var_11_0 then
					TimelineHelper.SetAutoBinding(arg_10_0, arg_11_1, var_11_0)
				else
					warning(string.format("轨道%s需要绑定的物体%s不存在", arg_11_1.name, var_8_0[arg_11_1.name]))
				end
			end

			return
		end)

		return
	end)

	return
end

function TimelineSupport.InitSubtitle(arg_12_0, arg_12_1)
	local var_12_0 = GameObject.Find("[subtitle]")

	if var_12_0 then
		pg.ViewUtils.SetLayer(var_12_0.transform, Layer.UI)

		var_12_0:GetComponent(typeof(Canvas)).worldCamera = pg.UIMgr.GetInstance().overlayCameraComp
	end

	function BLHXTimeline.SubtitleMixer.func(arg_13_0)
		local var_13_0 = tonumber(arg_13_0)

		if not var_13_0 then
			return arg_13_0
		end

		return (HXSet.hxLan(string.gsub(pg.dorm3d_subtitle[var_13_0].subtitle, "$dorm3d", arg_12_1)))
	end

	return
end

function TimelineSupport.DisablePlayOnAwake(arg_14_0)
	var_0_0.EachDirector(arg_14_0, function(arg_15_0)
		arg_15_0.playOnAwake = false

		return
	end)

	return
end

function TimelineSupport.InitHXGroup(arg_16_0)
	var_0_0.EachDirector(arg_16_0, function(arg_17_0)
		local var_17_0 = false

		var_0_0.EachGroupTrack(arg_17_0, function(arg_18_0, arg_18_1)
			if arg_18_1.name == "HXGroup" and arg_18_1.muted ~= not HXSet.isHx() then
				arg_18_1.muted = not HXSet.isHx()
				var_17_0 = true
			end

			return
		end)

		if false then
			arg_17_0:RebuildGraph()
		end

		return
	end)

	return
end

return
