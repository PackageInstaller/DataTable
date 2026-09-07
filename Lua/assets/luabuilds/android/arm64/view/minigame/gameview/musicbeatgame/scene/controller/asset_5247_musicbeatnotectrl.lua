local MusicBeatNoteCtrl = class("MusicBeatNoteCtrl")

function MusicBeatNoteCtrl:Ctor(arg_1_1, arg_1_2)
	self._content = arg_1_1
	self._event = arg_1_2

	self._event:bind(MusicBeatGameEvent.TRACK_EVENT_MATCH, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_1 then
			for iter_2_0 = 1, #self.prepareTracks do
				if self.prepareTracks[iter_2_0].id == arg_2_1.id then
					local var_2_0, var_2_1 = self:matchTrack(self.prepareTracks[iter_2_0])

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

function MusicBeatNoteCtrl:setGameVo(arg_3_1)
	self._gameVo = arg_3_1

	return
end

function MusicBeatNoteCtrl:readyStart()
	self:clear()

	self.mapData = self._gameVo:getMapData()
	self.nodeData = self._gameVo:getNodeData()
	self.beatOffset = MusicBeatGameConst.beat_offset

	self:createTrackList()

	return
end

function MusicBeatNoteCtrl:start()
	return
end

function MusicBeatNoteCtrl:step(arg_6_1)
	if self._gameVo:isBgmPlaying() then
		if self.trackData == nil and #self.trackList > 0 then
			self.trackData = table.remove(self.trackList, 1)
		end

		if self.trackData then
			local var_6_0 = self.trackData.begin_time - self._gameVo:getCriInfoTime()

			if var_6_0 >= 0 and var_6_0 <= MusicBeatGameConst.beat_prepare then
				self._event:emit(MusicBeatGameEvent.TRACK_TRIGGER, {
					track = self.trackData,
					final = #self.trackList <= 0
				})
				table.insert(self.prepareTracks, self.trackData)

				self.trackData = nil
			elseif var_6_0 <= 0 and self.trackData.begin_time == self.trackData.end_time and math.abs(var_6_0) >= self.beatOffset then
				self._event:emit(MusicBeatGameEvent.TRACK_REMOVE, self.trackData)

				self.trackData = nil
			end
		end
	end

	if #self.prepareTracks > 0 then
		local var_6_1 = self._gameVo:getCriInfoTime()

		for iter_6_0 = #self.prepareTracks, 1, -1 do
			if var_6_1 - self.prepareTracks[iter_6_0].end_time >= self.beatOffset then
				local var_6_2 = table.remove(self.prepareTracks, iter_6_0)
			end
		end
	end

	return
end

function MusicBeatNoteCtrl:clear()
	self.trackData = nil
	self.trackIndex = 0
	self.prepareTracks = {}

	return
end

function MusicBeatNoteCtrl:stop()
	return
end

function MusicBeatNoteCtrl:resume()
	return
end

function MusicBeatNoteCtrl:dispose()
	return
end

function MusicBeatNoteCtrl:matchTrack(arg_11_1)
	local var_11_0 = self._gameVo:getCriInfoTime()

	if var_11_0 > 0 then
		local var_11_2

		if arg_11_1.begin_time == arg_11_1.end_time then
			var_11_2 = math.abs(arg_11_1.begin_time - var_11_0)

			if var_11_2 <= self.beatOffset then
				return true, var_11_2
			end
		elseif arg_11_1.data.begin_time ~= arg_11_1.data.end_time then
			var_11_2 = math.abs((arg_11_1.matchBegin and arg_11_1.data.end_time or arg_11_1.data.begin_time) - var_11_0)

			if var_11_2 <= self.beatOffset then
				arg_11_1.matchBegin = arg_11_1.matchBegin or true

				return true, var_11_2
			end
		end

		return false, var_11_2
	end

	return false, nil
end

function MusicBeatNoteCtrl:createTrackList()
	self.trackList = {}

	for iter_12_0, iter_12_1 in ipairs((Clone(self.nodeData.touch_track))) do
		table.insert(self.trackList, {
			key_flag = iter_12_1.key_flag,
			key_index = iter_12_1.key_index,
			begin_time = math.floor(tonumber(iter_12_1.begin_time) * 1000),
			end_time = math.floor(tonumber(iter_12_1.end_time) * 1000),
			id = iter_12_0
		})
	end

	return
end

return MusicBeatNoteCtrl
