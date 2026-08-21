ys = ys or {}
ys.Story.StorySleepNode = class("StorySleepNode", ys.ISeqNode)

pg.NodeMgr.RigisterNode("StorySleep", ys.Story.StorySleepNode)

function ys.Story.StorySleepNode.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._time = arg_1_2[2]

	return
end

function ys.Story.StorySleepNode.Init(arg_2_0)
	arg_2_0._end = os.time() + arg_2_0._time

	return
end

function ys.Story.StorySleepNode.Update(arg_3_0)
	if os.time() >= arg_3_0._end then
		arg_3_0:Dispose()
	end

	return
end

return
