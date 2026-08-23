local var_0_0 = 16
local var_0_1 = 5
local var_0_2 = g.core.model.User.outpostData
local var_0_3 = g.core.const.ConstMgr.outpostConst
local OutpostChangeFormationLayer = class("OutpostChangeFormationLayer", require("app.fairyGUI.outpost.UI_OutpostChangeFormationLayer"), function()
	return fgui.GComponent:create({
		resName = "OutpostChangeFormationLayer",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = true,
		pkgName = "outpost"
	}, ...)
end)

function OutpostChangeFormationLayer:ctor()
	self:addBg("bg/outpost/pic_hxsz_jiaoyisuobg.jpg")

	self._selClassical = -1

	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightRenderer))
	self.m_knightList:doFairyBatching(false)

	self._curShowKnights = {}
	self._cacheSortIndex = {}
	self._quickUpAdvIds = {}

	for iter_2_0 = 1, var_0_1 do
		self["m_tab" .. iter_2_0]:setIcon(g.core.common.Path:getKnightElementIcon(iter_2_0))
	end

	self.m_selIndexController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStateChange))
	self.m_quickUpBtn:addClickListener(handler(self, self.onClickQuickUp))
	self:updateFormationKnights()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function OutpostChangeFormationLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_ENTRANCE, self._onKnightLineUp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_EXIT, self._onKnightLineDown, self)
	self:updateMainCityInfo()
	self.m_enterTransition:play()
end

function OutpostChangeFormationLayer:onClickQuickUp()
	local var_5_0 = var_0_2:getKnightsData():getAllLineUpFightValueKnights()

	if not next(var_5_0.up) and not next(var_5_0.down) then
		g.core.module.ModuleManager:tip(g.core.lang:get(432645))

		return
	end

	if next(var_5_0.down) then
		local var_5_1 = {}

		for iter_5_0, iter_5_1 in ipairs(var_5_0.down) do
			table.insert(var_5_1, iter_5_1:toProtoOutpostKnight())
		end

		g.core.network.GameNetProxy:send_C2S_Outpost_Knight_Exit({
			knights = var_5_1
		})
	end

	if next(var_5_0.up) then
		local var_5_2 = {}

		for iter_5_2, iter_5_3 in ipairs(var_5_0.up) do
			table.insert(var_5_2, iter_5_3:getCfg().advance_id)
		end

		if not next(var_5_0.down) then
			g.core.network.GameNetProxy:send_C2S_Outpost_Knight_Entrance({
				advance_ids = var_0_2:getLineupAdvanceIdPosMap(var_5_2)
			})
		else
			self._quickUpAdvIds = var_5_2
		end
	end

	g.core.module.ModuleManager:tip(g.core.lang:get(432627))
end

function OutpostChangeFormationLayer:_onKnightLineUp()
	self:updateMainCityInfo()
	self:updateFormationKnights()
end

function OutpostChangeFormationLayer:_onKnightLineDown()
	self:updateMainCityInfo()
	self:updateFormationKnights()

	if #self._quickUpAdvIds > 0 then
		g.core.network.GameNetProxy:send_C2S_Outpost_Knight_Entrance({
			advance_ids = var_0_2:getLineupAdvanceIdPosMap(self._quickUpAdvIds)
		})

		self._quickUpAdvIds = {}
	end
end

function OutpostChangeFormationLayer:updateMainCityInfo()
	self.m_fightValueTxt:setText(var_0_2:getFightValue())

	local var_8_0 = var_0_2:getBuildData():getBuild({
		type = var_0_3.BuildType.Main
	})

	if var_8_0 then
		self._maxUpNum = var_8_0:getMaxRoleNum()

		self.m_allNumTxt:setText("/" .. self._maxUpNum)
	end

	self:updatePositionState()
end

function OutpostChangeFormationLayer:updatePositionState()
	for iter_9_0 = 1, var_0_0 do
		self["m_knightPos" .. iter_9_0]:updateWithPosStation(self._maxUpNum, iter_9_0)
	end
end

function OutpostChangeFormationLayer:_onKnightRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateKnight(self._curShowKnights[arg_10_1 + 1])
end

function OutpostChangeFormationLayer:_onButtonStateChange()
	local var_11_0 = self.m_selIndexController:getSelectedIndex()

	if var_11_0 == 0 then
		self:updateFormationKnights(-1)
	else
		self:updateFormationKnights(var_11_0)
	end
end

function OutpostChangeFormationLayer:updateFormationKnights(arg_12_1)
	self._selClassical = arg_12_1 or self._selClassical

	if not self._cacheSortIndex[self._selClassical] then
		self._curShowKnights = var_0_2:getKnightsData():getAllKnights(self._selClassical)
		self._cacheSortIndex[self._selClassical] = self._curShowKnights
	else
		self._curShowKnights = self._cacheSortIndex[self._selClassical]
	end

	local var_12_0 = #self._curShowKnights

	self.m_emptyController:setSelectedIndex(#self._curShowKnights == 0 and 1 or 0)
	self.m_lineUpNumTxt:setText(#var_0_2:getKnightsData():getAllLineUpKnights())

	if self._maxUpNum then
		self.m_allNumTxt:setText("/" .. self._maxUpNum)
	end

	self.m_knightList:setNumItems(var_12_0)
end

return OutpostChangeFormationLayer
