local GuideUIFloatCollector = class("GuideUIFloatCollector")

function GuideUIFloatCollector:Ctor(arg_1_1)
	self.root = arg_1_1
	self.caches = {}

	return
end

function GuideUIFloatCollector:SetFloat(arg_2_1)
	setParent(arg_2_1, self.root, true)

	arg_2_1.localPosition = Vector3.New(arg_2_1.localPosition.x, arg_2_1.localPosition.y, 0)

	table.insert(self.caches, {
		parent = arg_2_1.parent,
		tr = arg_2_1
	})

	return
end

function GuideUIFloatCollector:Clear()
	for iter_3_0, iter_3_1 in ipairs(self.caches) do
		setParent(iter_3_1.tr, iter_3_1.parent, true)

		iter_3_1.tr.localPosition = Vector3.New(iter_3_1.tr.localPosition.x, iter_3_1.tr.localPosition.y, 0)
	end

	self.caches = {}

	return
end

return GuideUIFloatCollector
