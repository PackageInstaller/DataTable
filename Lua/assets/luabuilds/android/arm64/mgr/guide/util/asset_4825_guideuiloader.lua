local GuideUILoader = class("GuideUILoader")

function GuideUILoader:Ctor(arg_1_1)
	self.root = arg_1_1
	self.caches = {}

	return
end

function GuideUILoader:Load(arg_2_1, arg_2_2)
	self:LoadRes(arg_2_1, arg_2_2)

	return
end

function GuideUILoader:LoadHighLightArea(arg_3_1)
	self:Load(arg_3_1.name, function(arg_4_0)
		if not arg_3_1 then
			return
		end

		arg_4_0.localPosition = arg_3_1.position + Vector3(arg_4_0.pivot.x * arg_3_1.size.x, arg_4_0.pivot.y * arg_3_1.size.y, 0)
		arg_4_0.anchorMin = Vector2(0.5, 0.5)
		arg_4_0.anchorMax = Vector2(0.5, 0.5)
		arg_4_0.sizeDelta = arg_3_1.size + Vector2.one * arg_3_1.length * 2

		return
	end)

	return
end

function GuideUILoader:LoadRes(arg_5_1, arg_5_2)
	LoadAnyAsync("guideitem/" .. arg_5_1, "", nil, function(arg_6_0)
		if IsNil(arg_6_0) then
			return
		end

		local var_6_0 = Object.Instantiate(arg_6_0, self.root).transform

		table.insert(self.caches, var_6_0)

		if arg_5_2 then
			arg_5_2(var_6_0)
		end

		return
	end)

	return
end

function GuideUILoader:Clear()
	if self.caches and #self.caches > 0 then
		for iter_7_0, iter_7_1 in ipairs(self.caches) do
			Object.Destroy(iter_7_1.gameObject)
		end

		self.caches = {}
	end

	return
end

return GuideUILoader
