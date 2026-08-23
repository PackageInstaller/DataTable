local BinaryHeap = class("BinaryHeap")

function BinaryHeap:ctor(arg_1_1)
	self._content = {}
	self._funcScore = arg_1_1 or {}
end

function BinaryHeap:push(arg_2_1)
	table.insert(self._content, arg_2_1)
	self:_sinkDown(#self._content)
end

function BinaryHeap:pop()
	if #self._content == 0 then
		return nil
	end

	local var_3_0 = self._content[1]

	if #self._content > 0 then
		self._content[1] = table.remove(self._content)

		self:_bubbleUp(1)
	end

	return var_3_0
end

function BinaryHeap:remove(arg_4_1)
	if not self:_hasFScore() then
		return
	end

	local var_4_0 = table.indexof(self._content, arg_4_1)

	if var_4_0 == false then
		return
	end

	local var_4_1 = table.remove(self._content)

	if var_4_1 and var_4_0 ~= #self._content then
		self._content[var_4_0] = var_4_1

		if self._funcScore[var_4_1] < self._funcScore[arg_4_1] then
			self:_sinkDown(var_4_0)
		else
			self:_bubbleUp(var_4_0)
		end
	end
end

function BinaryHeap:size()
	return #self._content
end

function BinaryHeap:rescoreElement(arg_6_1)
	local var_6_0 = table.indexof(self._content, arg_6_1)

	if var_6_0 then
		self:_sinkDown(var_6_0)
	end
end

function BinaryHeap:_bubbleUp(arg_7_1)
	if not self:_hasFScore() then
		return
	end

	local var_7_0 = #self._content

	while true do
		local var_7_1
		local var_7_2

		if arg_7_1 * 2 + 1 - 1 < var_7_0 then
			var_7_2 = self._funcScore[self._content[arg_7_1 * 2 + 1 - 1]]

			if self._funcScore[self._content[arg_7_1 * 2 + 1 - 1]] < self._funcScore[self._content[arg_7_1]] then
				var_7_1 = arg_7_1 * 2 + 1 - 1
			end
		end

		if arg_7_1 * 2 + 1 < var_7_0 and self._funcScore[self._content[arg_7_1 * 2 + 1]] < (var_7_2 or self._funcScore[self._content[arg_7_1]]) then
			var_7_1 = arg_7_1 * 2 + 1
		end

		if var_7_1 then
			self._content[arg_7_1] = self._content[var_7_1]
			self._content[var_7_1] = self._content[arg_7_1]
			arg_7_1 = var_7_1
		else
			break
		end
	end
end

function BinaryHeap:_sinkDown(arg_8_1)
	if not self:_hasFScore() then
		return
	end

	local var_8_0 = self._content[arg_8_1]

	while arg_8_1 > 1 do
		local var_8_1 = math.floor(arg_8_1 / 2)

		if self._funcScore[var_8_0] < self._funcScore[self._content[var_8_1]] then
			self._content[var_8_1] = var_8_0
			self._content[arg_8_1] = self._content[var_8_1]
			arg_8_1 = var_8_1
		else
			break
		end
	end
end

function BinaryHeap:_hasFScore()
	return true
end

return BinaryHeap
