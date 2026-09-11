local ReversePacmanMapControl = class("ReversePacmanMapControl")

function ReversePacmanMapControl:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1
	self._tf = arg_1_2
	self._tpls = self._tf:Find("tpls")
	self.container = self._tf:Find("map/grids")
	self.buffContainer = self._tf:Find("map/buffs")
	self.routeGraph = ReversePacmanRouteGraph.New()

	return
end

function ReversePacmanMapControl:SetUp(arg_2_1)
	local var_2_0 = require("view.activity.ReversePacman.Maps." .. pg.activity_chasing_level[arg_2_1].map_json)

	self.mapId = var_2_0.id
	self.duration = var_2_0.duration
	self.skillSlotCount = var_2_0.skillSlotCount
	self.ratingThresholds = var_2_0.ratingThresholds
	self.width = var_2_0.width
	self.height = var_2_0.height
	self.grids = var_2_0.grid
	self.tags = var_2_0.tags
	self.spawnPoints = var_2_0.spawnPoints
	self.deployPoints = var_2_0.deployPoints
	self.canPickBuffs = {}

	self.routeGraph:Build(var_2_0)
	self:BuildMapUI()
	self:AddListener()

	return
end

function ReversePacmanMapControl:BuildMapUI(arg_3_1)
	removeAllChildren(self.container)

	self.gridViews = {}

	setSizeDelta(self.container, self.routeGraph:GetMapSize())

	for iter_3_0 = 1, self.height do
		for iter_3_1 = 1, self.width do
			local var_3_0 = cloneTplTo((self:IsWalkable(iter_3_1, iter_3_0) or nil) and (self._tpls:Find("grid_road") or self._tpls:Find("grid_block")), self.container, iter_3_1 .. "_" .. iter_3_0)

			self.gridViews[#self.gridViews + 1] = var_3_0

			setLocalPosition(var_3_0, self:GetLocalPosInMap(iter_3_1, iter_3_0))
		end
	end

	return
end

function ReversePacmanMapControl:AddListener()
	self.binder:bind(ReversePacmanConst.EVENT.CAST, function(arg_5_0, arg_5_1)
		self:AddBuffGrid(arg_5_1.buffId, arg_5_1.cell)

		return
	end)
	self.binder:bind(ReversePacmanConst.EVENT.PICK, function(arg_6_0, arg_6_1)
		self:RemoveBuffGrid(arg_6_1.buff)

		return
	end)

	return
end

function ReversePacmanMapControl:AddBuffGrid(arg_7_1, arg_7_2)
	local var_7_0 = cloneTplTo(self._tpls:Find("buff_" .. arg_7_1), self.buffContainer, arg_7_2.x .. "_" .. arg_7_2.y)
	local var_7_1 = self:GetLocalPosInMap(arg_7_2.x, arg_7_2.y)

	setLocalPosition(var_7_0, var_7_1)

	if arg_7_1 == ReversePacmanConst.BUFF.BLOCK then
		self.routeGraph:AddBlockNode(arg_7_2.x, arg_7_2.y)
		self.binder:emit(ReversePacmanConst.EVENT.GRAPH_CHANGED, {
			cell = arg_7_2
		})
	else
		table.insert(self.canPickBuffs, {
			id = arg_7_1,
			cell = arg_7_2,
			x = var_7_1.x,
			y = var_7_1.y,
			tf = var_7_0
		})
	end

	return
end

function ReversePacmanMapControl:RemoveBuffGrid(arg_8_1)
	setActive(arg_8_1.tf, false)
	table.removebyvalue(self.canPickBuffs, arg_8_1)

	return
end

function ReversePacmanMapControl:GetCanPickBuffs()
	return self.canPickBuffs
end

function ReversePacmanMapControl:GetTag(arg_10_1, arg_10_2)
	return (self.tags[arg_10_2] or nil) and (self.tags[arg_10_2][arg_10_1] or "")
end

function ReversePacmanMapControl:IsWalkable(arg_11_1, arg_11_2)
	local var_11_0

	if self.grids[arg_11_2] then
		var_11_0 = self.grids[arg_11_2][arg_11_1] or nil
	end

	return var_11_0 ~= nil and var_11_0 ~= ReversePacmanConst.GRID.BLOCK and not self.routeGraph:IsBuffBlock(arg_11_1, arg_11_2)
end

function ReversePacmanMapControl:GetDuration()
	return self.duration
end

function ReversePacmanMapControl:GetSpawnPoints()
	return self.spawnPoints
end

function ReversePacmanMapControl:GetDeployPoints()
	return self.deployPoints
end

function ReversePacmanMapControl:GetRatingThresholds()
	return self.ratingThresholds
end

function ReversePacmanMapControl:GetRouteGraph()
	return self.routeGraph
end

function ReversePacmanMapControl:GetLocalPosInMap(arg_17_1, arg_17_2)
	return self.routeGraph:GetLocalPosInMap(arg_17_1, arg_17_2)
end

function ReversePacmanMapControl:GetNodeIdByPos(arg_18_1, arg_18_2)
	local var_18_0 = self.routeGraph:GetNodeByPos(arg_18_1, arg_18_2)

	return (var_18_0 or nil) and (var_18_0.id or nil)
end

function ReversePacmanMapControl:GetNodeIdByLocalPos(arg_19_1)
	return self.routeGraph:GetNodeIdByLocalPos(arg_19_1)
end

function ReversePacmanMapControl:GetCellByLocalPos(arg_20_1)
	return self.routeGraph:GetCellByLocalPos(arg_20_1)
end

function ReversePacmanMapControl:GetCenterCell()
	return {
		x = math.ceil(self.width / 2),
		y = math.ceil(self.height / 2)
	}
end

function ReversePacmanMapControl:Update(arg_22_1)
	return
end

function ReversePacmanMapControl:Dispose()
	return
end

return ReversePacmanMapControl
