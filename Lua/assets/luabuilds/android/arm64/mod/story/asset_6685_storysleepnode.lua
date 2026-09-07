ys = ys or {}
ys.Story.StorySleepNode = class("StorySleepNode", ys.ISeqNode)

pg.NodeMgr.RigisterNode("StorySleep", ys.Story.StorySleepNode)

function ys.Story.StorySleepNode.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._time = arg_1_2[2]

	return
end

function ys.Story.StorySleepNode:Init()
	self._end = os.time() + self._time

	return
end

function ys.Story.StorySleepNode:Update()
	if os.time() >= self._end then
		self:Dispose()
	end

	return
end

return
