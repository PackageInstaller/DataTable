local BeatGameMapBase = class("BeatGameMapBase")

function BeatGameMapBase:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._data = arg_1_3
	self._trackDic = {}

	self:onInit()

	return
end

function BeatGameMapBase:addScore(arg_2_1)
	if arg_2_1 > 0 then
		self._event:emit(MusicBeatGameEvent.ADD_SCORE, {
			num = arg_2_1
		})
	end

	return
end

function BeatGameMapBase:startTrack(arg_3_1)
	self:onStartTrack(arg_3_1)

	return
end

function BeatGameMapBase:setGameVo(arg_4_1)
	self._gameVo = arg_4_1

	return
end

function BeatGameMapBase:setSelect(arg_5_1)
	self._selectFlag = arg_5_1

	setActive(self._tf, arg_5_1)
	self:onSelectChange()

	return
end

function BeatGameMapBase:clear()
	self._trackDic = {}

	self:onClear()

	return
end

function BeatGameMapBase:dispose()
	self:onDispose()

	self._tf = nil
	self._data = nil
	self._event = nil

	return
end

function BeatGameMapBase:step()
	self:onStep()

	return
end

function BeatGameMapBase:start()
	self:onStart()

	return
end

function BeatGameMapBase:stop()
	self:onStop()

	return
end

function BeatGameMapBase:resume()
	self:onResume()

	return
end

function BeatGameMapBase:onInit()
	return
end

function BeatGameMapBase:onStart()
	return
end

function BeatGameMapBase:onStop()
	return
end

function BeatGameMapBase:onResume()
	return
end

function BeatGameMapBase:onStartTrack(arg_16_1)
	return
end

function BeatGameMapBase:onSelectChange()
	return
end

function BeatGameMapBase:onClear()
	return
end

function BeatGameMapBase:onDispose()
	return
end

function BeatGameMapBase:onStep()
	return
end

return BeatGameMapBase
