local CrossRoadGameQue = class("CrossRoadGameQue")

function CrossRoadGameQue:Ctor()
	self.hh = 0
	self.tt = -1
	self._q = {}
	self._map = {}

	return
end

function CrossRoadGameQue:push(arg_2_1)
	if arg_2_1 == nil then
		return
	end

	if self._map[arg_2_1] == nil then
		self.tt = self.tt + 1
		self._q[self.tt] = arg_2_1
		self._map[arg_2_1] = true
	end

	return
end

function CrossRoadGameQue:head()
	if self:empty() then
		return nil
	end

	return self._q[self.hh]
end

function CrossRoadGameQue:pop()
	if self:empty() then
		return nil
	end

	local var_4_0 = self._q[self.hh]

	self._q[self.hh] = nil
	self.hh = self.hh + 1
	self._map[var_4_0] = nil

	return var_4_0
end

function CrossRoadGameQue:empty()
	return self.hh > self.tt
end

function CrossRoadGameQue:queryHasVal(arg_6_1)
	return self._map[arg_6_1]
end

function CrossRoadGameQue:clear()
	for iter_7_0 = self.hh, self.tt do
		self._q[iter_7_0] = nil
	end

	self.hh = 0
	self.tt = -1
	self._map = {}

	return
end

function CrossRoadGameQue:size()
	return self.tt - self.hh + 1
end

return CrossRoadGameQue
