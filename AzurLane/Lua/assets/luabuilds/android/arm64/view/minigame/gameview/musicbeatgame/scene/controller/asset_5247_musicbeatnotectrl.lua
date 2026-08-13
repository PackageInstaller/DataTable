class = var_0_10000

local var_0_0 = var_0_10000("MusicBeatNoteCtrl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._content = arg_1_1
	arg_1_0._event = arg_1_2

	local var_1_0 = arg_1_0._event
	local var_1_1 = var_3.bind

	MusicBeatGameEvent = var_1_10006

	var_1_1(var_1_0, var_1_10006.TRACK_EVENT_MATCH, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_1 then
			local var_2_0 = arg_2_1.id

			for iter_2_0 = 1, #arg_1_0.prepareTracks do
				if arg_1_0.prepareTracks[iter_2_0].id == var_2_0 then
					local var_2_1 = arg_1_0.prepareTracks[iter_2_0]
					local var_2_2 = arg_1_0
					local var_2_3, var_2_4 = var_9.matchTrack(var_2_2, var_2_1)

					print = var_2_2

					local var_2_5 = "match is "

					tostring = var_2_10014

					var_2_2(var_2_5 .. var_2_10014(var_2_3) .. " subtime is " .. var_2_4)

					if arg_2_2 then
						arg_2_2(var_2_3, var_2_4)
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

	local var_4_0 = arg_4_0._gameVo

	arg_4_0.mapData = var_1.getMapData(var_4_0)

	local var_4_1 = arg_4_0._gameVo

	arg_4_0.nodeData = var_1.getNodeData(var_4_1)
	MusicBeatGameConst = var_1
	arg_4_0.beatOffset = var_1.beat_offset

	arg_4_0:createTrackList()

	return
end

function var_0_0.start(arg_5_0)
	return
end

function var_0_0.step(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._gameVo

	if var_2.isBgmPlaying(var_6_0) then
		if arg_6_0.trackData == nil and #arg_6_0.trackList > 0 then
			table = var_2
			arg_6_0.trackData = var_2.remove(arg_6_0.trackList, 1)
		end

		if arg_6_0.trackData then
			local var_6_1 = arg_6_0._gameVo
			local var_6_2 = var_2.getCriInfoTime(var_6_1)
			local var_6_3 = arg_6_0.trackData.begin_time - var_6_2

			if 0 <= var_6_3 then
				MusicBeatGameConst = var_4

				if var_6_3 <= var_4.beat_prepare then
					local var_6_4 = arg_6_0._event
					local var_6_5 = var_4.emit

					MusicBeatGameEvent = var_1_10007

					var_6_5(var_6_4, var_1_10007.TRACK_TRIGGER, {
						track = arg_6_0.trackData,
						final = #arg_6_0.trackList <= 0
					})

					table = var_6_5

					var_6_5.insert(arg_6_0.prepareTracks, arg_6_0.trackData)

					arg_6_0.trackData = nil

					goto label_6_0
				end
			end

			if var_6_3 <= 0 and arg_6_0.trackData.begin_time == arg_6_0.trackData.end_time then
				math = var_4

				if var_4.abs(var_6_3) >= arg_6_0.beatOffset then
					local var_6_6 = arg_6_0._event
					local var_6_7 = var_4.emit

					MusicBeatGameEvent = var_1_10007

					var_6_7(var_6_6, var_1_10007.TRACK_REMOVE, arg_6_0.trackData)

					arg_6_0.trackData = nil
				end
			end
		end
	end

	::label_6_0::

	if #arg_6_0.prepareTracks > 0 then
		local var_6_8 = arg_6_0._gameVo
		local var_6_9 = var_2.getCriInfoTime(var_6_8)

		for iter_6_0 = #arg_6_0.prepareTracks, 1, -1 do
			if var_6_9 - arg_6_0.prepareTracks[iter_6_0].end_time >= arg_6_0.beatOffset then
				table = var_8

				local var_6_10 = var_8.remove(arg_6_0.prepareTracks, iter_6_0)
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
	local var_11_0 = arg_11_0._gameVo

	if var_2.getCriInfoTime(var_11_0) > 0 then
		local var_11_1
		local var_11_2

		if arg_11_1.begin_time == arg_11_1.end_time then
			local var_11_3 = arg_11_1.begin_time

			math = var_5

			if var_5.abs(var_11_3 - var_2) <= arg_11_0.beatOffset then
				return true, var_11_2
			end
		elseif arg_11_1.data.begin_time ~= arg_11_1.data.end_time then
			local var_11_4 = arg_11_1.matchBegin and arg_11_1.data.end_time or arg_11_1.data.begin_time

			math = var_5

			if var_5.abs(var_11_4 - var_2) <= arg_11_0.beatOffset then
				if not arg_11_1.matchBegin then
					arg_11_1.matchBegin = true
				end

				return true, var_11_2
			end
		end

		return false, var_11_2
	end

	return false, nil
end

function var_0_0.createTrackList(arg_12_0)
	Clone = var_1_10001

	local var_12_0 = var_1_10001(arg_12_0.nodeData.touch_track)

	arg_12_0.trackList = {}
	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(var_12_0) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_12_1 = arg_12_0.trackList
		local var_12_2 = {
			key_flag = iter_12_1.key_flag,
			key_index = iter_12_1.key_index
		}

		math = var_11

		local var_12_3 = var_11.floor

		tonumber = var_1_10013
		var_12_2.begin_time = var_12_3(var_1_10013(iter_12_1.begin_time) * 1000)
		math = var_11

		local var_12_4 = var_11.floor

		tonumber = var_1_10013
		var_12_2.end_time = var_12_4(var_1_10013(iter_12_1.end_time) * 1000)
		var_12_2.id = iter_12_0

		var_1_10007(var_12_1, var_12_2)
	end

	return
end

return var_0_0
