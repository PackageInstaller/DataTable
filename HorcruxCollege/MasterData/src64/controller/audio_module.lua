local var_0_0 = {
	__index = {
		setVolume = function(self, arg_1_1)
			if not self._source then
				return
			end

			self._source:setVolume(arg_1_1)

			self._vol = arg_1_1
		end,
		getVolume = function(self)
			return self._vol
		end,
		play2d = function(self, arg_3_1, arg_3_2)
			if not self._source then
				return
			end

			self._source:play2d(arg_3_1, arg_3_2)
		end,
		resume = function(self)
			if not self._source then
				return
			end

			self._source:resume()
		end,
		stop = function(self)
			if not self._source then
				return
			end

			self._source:stop()
		end,
		pause = function(self)
			if not self._source then
				return
			end

			self._source:pause()
		end,
		getStat = function(self)
			if not self._source then
				return
			end

			return self._source:getStat()
		end,
		getSourceType = function(self)
			return self._sourcetype
		end,
		__gc = function(self)
			self._source:__gc()

			self._source = nil
		end,
		setRawVolume = function(arg_10_0, arg_10_1)
			arg_10_0._rawvol = arg_10_1
		end,
		getRawVolume = function(self)
			return self._rawvol
		end,
		isFinished = function(self)
			return self._source == nil
		end,
		setSpeed = function(self, arg_13_1)
			if not self._source then
				return
			end

			self._source:setSpeed(arg_13_1)
		end
	}
}

return {
	new = function(arg_14_0, arg_14_1, arg_14_2)
		return setmetatable({
			_source = Rapid2D_CAudio.newSource(arg_14_1),
			_rawvol = arg_14_0,
			_vol = arg_14_0,
			_sourcetype = arg_14_2
		}, var_0_0)
	end
}
