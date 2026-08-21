-- chunkname: @IQIGame\\Common\\ResourceManager.lua

local ResourceManager = {
	resourceList = {}
}

function ResourceManager:New()
	local view = Clone(ResourceManager)

	return view
end

function ResourceManager:AddResource(resource)
	table.insert(self.resourceList, resource)
end

function ResourceManager:ReleaseAll()
	for i, resource in pairs(self.resourceList) do
		resource:Release()
	end
end

local Resource = {}

function Resource:New(ReleaseFunc)
	local view = Clone(Resource)

	view.ReleaseFunc = ReleaseFunc

	return view
end

function Resource:Release()
	self:ReleaseFunc()
end
