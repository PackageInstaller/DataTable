ys = ys or {}
ys.Story = ys.Story or {}
ys.Story.NodeData = class("NodeData")

function ys.Story.NodeData.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._data = arg_1_1 or {}
	arg_1_0._allSeq = {
		arg_1_2
	}

	return
end

function ys.Story.NodeData.AddSeq(arg_2_0, arg_2_1)
	table.insert(arg_2_0._allSeq, arg_2_1)

	return
end

function ys.Story.NodeData.GetAllSeq(arg_3_0)
	return arg_3_0._allSeq
end

return
