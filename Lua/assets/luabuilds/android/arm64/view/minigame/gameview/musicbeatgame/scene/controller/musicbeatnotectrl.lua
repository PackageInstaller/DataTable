local var_0_0 = class("MusicBeatNoteCtrl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2

	arg_1_0._event:bind(MusicBeatGameEvent.TRACK_EVENT_MATCH, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_1 then
			for iter_2_0 = 1, #arg_1_0.prepareTracks do
				if arg_1_0.prepareTracks[iter_2_0].id == arg_2_1.id then
					local var_2_0, var_2_1 = arg_1_0:matchTrack(arg_1_0.prepareTracks[iter_2_0])

					print("match is " .. tostring(var_2_0) .. " subtime is " .. var_2_1)

					if arg_2_2 then
						arg_2_2(var_2_0, var_2_1)
					end

					return
				end
			end
		end

		return
	end)

	return
end

function var_0_0.setGameVo(arg_3_0, arg_3_1)
	arg_3_0._gameVo = arg_3_1

	return
end

function var_0_0.readyStart(arg_4_0)
	arg_4_0:clear()

	arg_4_0.mapData = arg_4_0._gameVo:getMapData()
	arg_4_0.nodeData = arg_4_0._gameVo:getNodeData()
	arg_4_0.beatOffset = MusicBeatGameConst.beat_offset

	arg_4_0:createTrackList()

	return
end

function var_0_0.start(arg_5_0)
	return
end

function var_0_0.step(arg_6_0, arg_6_1)
	if arg_6_0._gameVo:isBgmPlaying() then
		if arg_6_0.trackData == nil and #arg_6_0.trackList > 0 then
			arg_6_0.trackData = table.remove(arg_6_0.trackList, 1)
		end

		if arg_6_0.trackData then
			local var_6_0 = arg_6_0.trackData.begin_time - arg_6_0._gameVo:getCriInfoTime()

			if var_6_0 >= 0 and var_6_0 <= MusicBeatGameConst.beat_prepare then
				arg_6_0._event:emit(MusicBeatGameEvent.TRACK_TRIGGER, {
					track = arg_6_0.trackData,
					final = #arg_6_0.trackList <= 0
				})
				table.insert(arg_6_0.prepareTracks, arg_6_0.trackData)

				arg_6_0.trackData = nil
			elseif var_6_0 <= 0 and arg_6_0.trackData.begin_time == arg_6_0.trackData.end_time and math.abs(var_6_0) >= arg_6_0.beatOffset then
				arg_6_0._event:emit(MusicBeatGameEvent.TRACK_REMOVE, arg_6_0.trackData)

				arg_6_0.trackData = nil
			end
		end
	end

	if #arg_6_0.prepareTracks > 0 then
		local var_6_1 = arg_6_0._gameVo:getCriInfoTime()

		for iter_6_0 = #arg_6_0.prepareTracks, 1, -1 do
			if var_6_1 - arg_6_0.prepareTracks[iter_6_0].end_time >= arg_6_0.beatOffset then
				local var_6_2 = table.remove(arg_6_0.prepareTracks, iter_6_0)
			end
		end
	end

	return
end

function var_0_0.clear(arg_7_0)
	arg_7_0.trackData = nil
	arg_7_0.trackIndex = 0
	arg_7_0.prepareTracks = {}

	return
end

function var_0_0.stop(arg_8_0)
	return
end

function var_0_0.resume(arg_9_0)
	return
end

function var_0_0.dispose(arg_10_0)
	return
end

function var_0_0.matchTrack(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._gameVo:getCriInfoTime()

	if var_11_0 > 0 then
		local var_11_2

		if arg_11_1.begin_time == arg_11_1.end_time then
			var_11_2 = math.abs(arg_11_1.begin_time - var_11_0)

			if var_11_2 <= arg_11_0.beatOffset then
				return true, var_11_2
			end
		elseif arg_11_1.data.begin_time ~= arg_11_1.data.end_time then
			var_11_2 = math.abs((arg_11_1.matchBegin and arg_11_1.data.end_time or arg_11_1.data.begin_time) - var_11_0)

			if var_11_2 <= arg_11_0.beatOffset then
				arg_11_1.matchBegin = arg_11_1.matchBegin or true

				return true, var_11_2
			end
		end

		return false, var_11_2
	end

	return false, nil
end

function var_0_0.createTrackList(arg_12_0)
	arg_12_0.trackList = {}

	for iter_12_0, iter_12_1 in ipairs((Clone(arg_12_0.nodeData.touch_track))) do
		table.insert(arg_12_0.trackList, {
			key_flag = iter_12_1.key_flag,
			key_index = iter_12_1.key_index,
			begin_time = math.floor(tonumber(iter_12_1.begin_time) * 1000),
			end_time = math.floor(tonumber(iter_12_1.end_time) * 1000),
			id = iter_12_0
		})
	end

	return
end

return var_0_0
