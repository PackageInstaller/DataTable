ys = ys or {}

local Sequence = class("Sequence")

ys.Sequence = Sequence
Sequence.Name = ""
Sequence._list = nil
Sequence.Center = nil
Sequence._wait = false

function Sequence:Ctor(arg_1_1, arg_1_2)
	self.Name = arg_1_1
	self._list = ys.LinkList.New()
	self.Center = arg_1_2

	arg_1_2:AddSeq(self)

	return
end

function Sequence:Dispose()
	for iter_2_0 = 1, self._list.Count do
		self._list.Head.Data:Dispose()
	end

	self._list:Clear()

	return
end

function Sequence:Add(arg_3_1)
	self._list:AddLast(arg_3_1)

	return
end

function Sequence:Wait()
	self._wait = true

	return
end

function Sequence:Resume()
	self._wait = false

	return
end

function Sequence:Update()
	if self._wait then
		return false
	end

	while self._list.Count > 0 do
		if not self._list.Head.Data.Finish then
			self._list.Head.Data:UpdateNode()

			if not self._list.Head.Data.Finish then
				return false
			else
				self._list:RemoveFirst()
			end
		else
			self._list:RemoveFirst()
		end
	end

	return true
end

function Sequence:IsFinish()
	for iter_7_0 = 1, self._list.Count do
		if not self._list.Head.Data.Finish then
			return false
		end
	end

	return true
end

return
