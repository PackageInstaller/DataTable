local CourtYardPoolMgr = class("CourtYardPoolMgr")

function CourtYardPoolMgr:Init(arg_1_1, arg_1_2)
	self.pools = {}
	self.root = arg_1_1
	self.goList = {}

	parallelAsync(self:GenPool(arg_1_1), arg_1_2)

	return
end

function CourtYardPoolMgr:GenPool(arg_2_1)
	local var_2_0 = {
		{
			10,
			15
		},
		{
			4,
			8
		},
		{
			1,
			3
		},
		{
			2,
			8
		}
	}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs({
		"CourtYardFurniture",
		"CourtYardGrid",
		"CourtYardShip",
		"CourtYardWallGrid"
	}) do
		table.insert(var_2_1, function(arg_3_0)
			ResourceMgr.Inst:getAssetAsync("ui/" .. iter_2_1, "", typeof(Object), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_4_0)
				if self.exited then
					return
				end

				self.pools[iter_2_1] = CourtYardPool.New(arg_2_1, Object.Instantiate(arg_4_0), unpack(var_2_0[iter_2_0]))

				arg_3_0()

				return
			end), true, true)

			return
		end)
	end

	for iter_2_2, iter_2_3 in ipairs({
		"Heart"
	}) do
		table.insert(var_2_1, function(arg_5_0)
			ResourceMgr.Inst:getAssetAsync("Effect/" .. iter_2_3, "", typeof(Object), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_6_0)
				if self.exited then
					return
				end

				self.pools[iter_2_3] = CourtYardEffectPool.New(arg_2_1, Object.Instantiate(arg_6_0), 0, 3)

				arg_5_0()

				return
			end), true, true)

			return
		end)
	end

	return var_2_1
end

function CourtYardPoolMgr:LoadAsset(arg_7_1, arg_7_2)
	return
end

function CourtYardPoolMgr:GetFurniturePool()
	return self.pools.CourtYardFurniture
end

function CourtYardPoolMgr:GetShipPool()
	return self.pools.CourtYardShip
end

function CourtYardPoolMgr:GetGridPool()
	return self.pools.CourtYardGrid
end

function CourtYardPoolMgr:GetWallGridPool()
	return self.pools.CourtYardWallGrid
end

function CourtYardPoolMgr:GetHeartPool()
	return self.pools.Heart
end

function CourtYardPoolMgr:GetAiXinPool()
	return self.pools.chengbao_aixin
end

function CourtYardPoolMgr:GetXinXinPool()
	return self.pools.chengbao_xinxin
end

function CourtYardPoolMgr:GetYinFuPool()
	return self.pools.chengbao_yinfu
end

function CourtYardPoolMgr:GetZzzPool()
	return self.pools.chengbao_ZZZ
end

function CourtYardPoolMgr:Dispose()
	for iter_17_0, iter_17_1 in pairs(self.pools or {}) do
		iter_17_1:Dispose()
	end

	self.pools = nil
	self.goList = nil
	self.exited = true

	return
end

return CourtYardPoolMgr
