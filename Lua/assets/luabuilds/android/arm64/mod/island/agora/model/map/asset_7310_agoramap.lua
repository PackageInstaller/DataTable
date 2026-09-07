local AgoraMap = class("AgoraMap")

function AgoraMap:Ctor(arg_1_1)
	self.map = self:GenMap(arg_1_1)

	return
end

function AgoraMap:GenMap(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs((AgoraCalc.GetArea(Vector2.zero, arg_2_1))) do
		var_2_0[iter_2_1.x] = var_2_0[iter_2_1.x] or {}
		var_2_0[iter_2_1.x][iter_2_1.y] = true
	end

	return var_2_0
end

function AgoraMap:UpdateSize(arg_3_1)
	local var_3_0 = self:GenMap(arg_3_1)

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if self.map[iter_3_0] ~= nil and self.map[iter_3_0][iter_3_2] ~= nil then
				var_3_0[iter_3_0][iter_3_2] = self.map[iter_3_0][iter_3_2]
			end
		end
	end

	self.map = var_3_0

	return
end

function AgoraMap:UpdateMapState(arg_4_1, arg_4_2, arg_4_3)
	assert(self.map[arg_4_1], " position x is illegal " .. arg_4_1)

	self.map[arg_4_1][arg_4_2] = arg_4_3

	return
end

function AgoraMap:GetMapState(arg_5_1, arg_5_2)
	return self.map[arg_5_1][arg_5_2]
end

function AgoraMap:IsEmptyPoint(arg_6_1)
	return self.map[arg_6_1.x] and self.map[arg_6_1.x][arg_6_1.y] == true
end

return AgoraMap
