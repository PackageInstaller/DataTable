-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/ugui/PhotoUtil.lua

module("logic.common.ugui.PhotoUtil", package.seeall)

local M = {}

M.LayerName = SceneLayer.UI3D
M.RoleShowRTWidth = 3040
M.RoleShowRTHight = 1500
M.RTWidth = 1624
M.RTHeight = 750
M.PartLargeRTWidth = 512
M.PartLargeRTHeight = 750
M.PartRTWidth = 512
M.PartRTHeight = 288
M.SmallRTWidth = 256
M.SmallRTHeight = 144
M.Depth = 0
M.usingDict = {}
M.MaterialEff = nil
M.Capacity = {
	[147456] = 4,
	[1218000] = 1,
	[384000] = 1,
	[4560000] = 1,
	[36864] = 8
}

function M.initPhotoSetting()
	M.setCullingLayer()
	M.setRTDepth()
	M.setRTCapacity()
end

function M.getEffMaterial()
	return Astral.PhotoProducerCache.Instance:GetPhotoMaterial()
end

function M.setCullingLayer(layerName)
	local _layerName = layerName or M.LayerName
	local layer = Astral.LayerUtil.NameToLayer(_layerName)

	Astral.PhotoProducerCache.Instance:SetCullingLayer(layer)
end

function M.setRTDepth(depth)
	local _depth = depth or M.Depth

	Astral.PhotoProducerCache.Instance:SetRenderTextureDepth(_depth)
end

function M.setRTCapacity(width, height)
	local _width = width or M.RTWidth
	local _height = height or M.RTHeight
	local _capacity = 1

	if _width and _height then
		local refCapacity = M.Capacity[_width * _height]

		if refCapacity then
			_capacity = refCapacity
		end
	end

	Astral.PhotoProducerCache.Instance:SetCapacity(_width, _height, _capacity)
end

M.MaxDiemensionLength = 20
M.CameraDistance = 50
M.Diemension1 = M.MaxDiemensionLength
M.Diemension2 = M.MaxDiemensionLength * M.MaxDiemensionLength
M.Diemension3 = M.MaxDiemensionLength * M.Diemension2

function M.GetPosition(counter)
	local x = counter % M.Diemension1
	local y = math.floor(counter / M.Diemension1) % M.Diemension1
	local z = math.floor(counter / M.Diemension2)
	local pos = Vector3.New(x, y, z) * M.CameraDistance

	return pos
end

return M
