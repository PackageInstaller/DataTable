ys = ys or {}

local ISeqNode = class("ISeqNode")

ys.ISeqNode = ISeqNode
ISeqNode.Finish = false
ISeqNode._init = false
ISeqNode._data = nil
ISeqNode._cfg = nil

function ISeqNode:Ctor(arg_1_1, arg_1_2)
	self._data = arg_1_1
	self._cfg = arg_1_2

	return
end

function ISeqNode:UpdateNode()
	if self.Finish then
		return
	end

	if not self._init then
		self._init = true

		self:Init()
	end

	if self.Finish then
		return
	end

	self:Update()

	return
end

function ISeqNode:Init()
	return
end

function ISeqNode:Update()
	return
end

function ISeqNode:Dispose()
	self.Finish = true

	self:Clear()

	return
end

function ISeqNode:Clear()
	return
end

return
