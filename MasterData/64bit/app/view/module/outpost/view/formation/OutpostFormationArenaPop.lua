local var_0_0 = g.core.model.User.outpostData
local OutpostFormationArenaPop = class("OutpostFormationArenaPop", require("app.fairyGUI.outpost.UI_OutpostFormationArenaPop"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostFormationArenaPop",
		pkgName = "outpost"
	}, ...)
end)

function OutpostFormationArenaPop:ctor()
	self._selArena = nil
	self._arenaInfo = {}
	self._selKnight = {}

	self:showAtCenter()
	self:initArenaInfo()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function OutpostFormationArenaPop:onLoad()
	self:updateKnightArena()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHTCHANGEMAP, self.changeKnightMap, self)
end

function OutpostFormationArenaPop:initArenaInfo()
	self._arenaInfo = var_0_0:getAllArenaInfo()

	for iter_5_0, iter_5_1 in ipairs(self._arenaInfo) do
		self["m_arenBtn" .. iter_5_0]:setTitle(iter_5_1.name)
		self["m_area" .. iter_5_0]:updateArenaInfo(iter_5_1)
		self["m_arenBtn" .. iter_5_0]:addClickListener(handler(self, self["_clickArena" .. iter_5_0]))
	end
end

function OutpostFormationArenaPop:_clickArena1()
	self:changeAllKnight2Arena(1)
end

function OutpostFormationArenaPop:_clickArena2()
	if self._arenaInfo[2].isOpen then
		self:changeAllKnight2Arena(2)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432612))
	end
end

function OutpostFormationArenaPop:_clickArena3()
	if self._arenaInfo[3].isOpen then
		self:changeAllKnight2Arena(3)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432612))
	end
end

function OutpostFormationArenaPop:_clickArena4()
	if self._arenaInfo[4].isOpen then
		self:changeAllKnight2Arena(4)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432612))
	end
end

function OutpostFormationArenaPop:changeAllKnight2Arena(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs((var_0_0:getKnightsData():getKnightAllArena())) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			if iter_10_0 ~= arg_10_1 then
				table.insert(var_10_0, iter_10_3:getServerId())
			end
		end
	end

	if #var_10_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_Outpost_KnightChangeMap({
			pos = var_0_0:getKnightsPositions(var_10_0),
			map_tp = arg_10_1
		})
	end
end

function OutpostFormationArenaPop:changeKnightMap()
	self._selArena = nil
	self._selKnight = {}

	self:updateKnightArena(true)
	g.core.module.ModuleManager:tip(g.core.lang:get(432661))
end

function OutpostFormationArenaPop:updateKnightArena(arg_12_1)
	local var_12_0 = var_0_0:getKnightsData():getKnightAllArena()

	for iter_12_0, iter_12_1 in ipairs(self._arenaInfo) do
		self["m_area" .. iter_12_0]:updateArenaState(var_12_0[iter_12_0] or {}, self._selArena, arg_12_1)
	end
end

function OutpostFormationArenaPop:receiveCompEvent(arg_13_1)
	local var_13_0 = ...

	if arg_13_1 == "OutpostFormationArenaComp_sel_knight" then
		if var_13_0.sel or nil then
			self._selKnight[var_13_0.id] = var_13_0.knight or nil
		end

		self._selArena = next(self._selKnight) and var_13_0.arena or nil

		self:updateKnightArena()
	elseif arg_13_1 == "OutpostFormationArenaComp_changeArena" then
		local var_13_2 = {}

		for iter_13_0, iter_13_1 in pairs(self._selKnight) do
			table.insert(var_13_2, iter_13_1:getServerId())
		end

		if #var_13_2 > 0 then
			g.core.network.GameNetProxy:send_C2S_Outpost_KnightChangeMap({
				pos = var_0_0:getKnightsPositions(var_13_2),
				map_tp = var_13_0.arena
			})
		end
	end
end

return OutpostFormationArenaPop
