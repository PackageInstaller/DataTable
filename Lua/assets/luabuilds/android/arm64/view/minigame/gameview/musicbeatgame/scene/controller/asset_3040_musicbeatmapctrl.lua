local MusicBeatMapCtrl = class("MusicBeatMapCtrl")

function MusicBeatMapCtrl:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2

	self._event:bind(MusicBeatGameEvent.TRACK_TRIGGER, function(arg_2_0, arg_2_1, arg_2_2)
		self.selectScene:startTrack(arg_2_1)

		return
	end)
	self._event:bind(MusicBeatGameEvent.TRACK_REMOVE, function(arg_3_0, arg_3_1, arg_3_2)
		return
	end)

	return
end

function MusicBeatMapCtrl:setGameVo(arg_4_1)
	self._gameVo = arg_4_1

	return
end

function MusicBeatMapCtrl:readyStart()
	self:clear()

	self.mapData = self._gameVo:getMapData()

	self:loadMapScene(self.mapData.map_scene)
	self:setSelectScene(1)

	for iter_5_0 = 1, #self.mapScenes do
		self.mapScenes[iter_5_0]:start()
	end

	return
end

function MusicBeatMapCtrl:start()
	return
end

function MusicBeatMapCtrl:step(arg_7_1)
	for iter_7_0 = 1, #self.mapScenes do
		self.mapScenes[iter_7_0]:step()
	end

	return
end

function MusicBeatMapCtrl:clear()
	self:clearMapScene()

	self.curMapScene = nil

	return
end

function MusicBeatMapCtrl:stop()
	for iter_9_0 = 1, #self.mapScenes do
		self.mapScenes[iter_9_0]:stop()
	end

	return
end

function MusicBeatMapCtrl:resume()
	for iter_10_0 = 1, #self.mapScenes do
		self.mapScenes[iter_10_0]:resume()
	end

	return
end

function MusicBeatMapCtrl:dispose()
	for iter_11_0 = 1, #self.mapScenes do
		self.mapScenes[iter_11_0]:dispose()
	end

	return
end

function MusicBeatMapCtrl:loadMapScene(arg_12_1)
	self:clearMapScene()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0

		if iter_12_1.type == MusicBeatGameConst.map_type_plane then
			var_12_0 = BeatGameMapPlane.New(findTF(self._tf, iter_12_1.name), self._event, iter_12_1)
		end

		if var_12_0 then
			var_12_0:setGameVo(self._gameVo)
			table.insert(self.mapScenes, var_12_0)
		end
	end

	return
end

function MusicBeatMapCtrl:clearMapScene()
	if self.mapScenes then
		for iter_13_0, iter_13_1 in ipairs(self.mapScenes) do
			if iter_13_1 then
				iter_13_1:clear()
			end
		end
	end

	self.mapScenes = {}

	return
end

function MusicBeatMapCtrl:setSelectScene(arg_14_1)
	if self.selectScene then
		self.selectScene:setSelect(false)
	end

	self.selectScene = self.mapScenes[arg_14_1]

	self.selectScene:setSelect(true)

	return
end

return MusicBeatMapCtrl
