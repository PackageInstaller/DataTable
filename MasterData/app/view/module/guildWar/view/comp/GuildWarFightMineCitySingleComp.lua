local var_0_0 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local var_0_1 = g.core.const.ConstMgr.GuildWarConst.BUILD_TYPE
local var_0_2 = g.core.const.ConstMgr.BASE_CONST.DRAG_TAG.GUILD_WAR
local var_0_3 = g.core.model.User.guildWarData
local GuildWarFightMineCitySingleComp = class("GuildWarFightMineCitySingleComp", require("app.fairyGUI.guildWar.UI_GuildWarFightMineCitySingleComp"))

function GuildWarFightMineCitySingleComp:ctor()
	self._initPosition = false
	self.isFirstEnter = true

	self:setVisible(false)

	self._curDragComp = nil
	self._guildStruct = nil
	self._positionComp = {}
end

function GuildWarFightMineCitySingleComp:onLoad()
	if not self._initPosition then
		self._initPosition = true

		local var_2_0 = {}

		for iter_2_0 = 1, 6 do
			self["m_frontPos" .. iter_2_0]:setDragCallBack(handler(self, self.onDragStart))
			table.insert(var_2_0, self["m_frontPos" .. iter_2_0])
		end

		self._positionComp[var_0_1.FRONT] = var_2_0

		local var_2_1 = {}

		for iter_2_1 = 1, 3 do
			self["m_strategicPoint" .. iter_2_1]:setDragCallBack(handler(self, self.onDragStart))
			table.insert(var_2_1, self["m_strategicPoint" .. iter_2_1])
		end

		self._positionComp[var_0_1.STRATEGIC] = var_2_1

		self.m_commandPoint:setDragCallBack(handler(self, self.onDragStart))

		self._positionComp[var_0_1.COMMAND] = {
			self.m_commandPoint
		}

		self:initView()
	end

	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragMove, handler(self, self._onDragMove), var_0_2)
	fgui.DragDropManager:getInstance():getAgent():addEventListener(fgui.UIEventType.DragEnd, handler(self, self._onTouchEnd), var_0_2)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_GETFORMATION, self._onRvcFormationInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_FASTFORMAT, self._onQuickFormation, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_NOTIFYFASTFORMAT, self._onQuickFormationNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_SWAPUSERBUILD, self._onSwapBuilding, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_NOTIFYSWAPUSERBUILD, self._onSwapBuildingNotify, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_NOTIFY, self._onRevNotify, self)
end

function GuildWarFightMineCitySingleComp:setGuildId(arg_3_1, arg_3_2)
	self._guildId = arg_3_1
	self._cityPos = arg_3_2
	self._guildStruct = var_0_3:getGuildWarGuildStruct(arg_3_1)

	self.m_typeController:setSelectedIndex(arg_3_2)
end

function GuildWarFightMineCitySingleComp:initView()
	for iter_4_0, iter_4_1 in ipairs(self._positionComp) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			iter_4_3:updateByCfg(var_0_3:getBuildCfgByType(iter_4_0)[iter_4_2], self._cityPos)
		end
	end
end

function GuildWarFightMineCitySingleComp:onDragStart(arg_5_1)
	if not self._guildStruct:isMyGuild() or not var_0_3:isLeader() or var_0_3:getFightStageType() ~= var_0_0.DEPLOY then
		arg_5_1:preventDefault()

		return
	end

	arg_5_1:preventDefault()

	self._curDragComp = arg_5_1:getSender()

	if self._curDragComp:getUserData() then
		if self._curDragComp:getUserData():getUser() then
			self._curDragComp:setInDrag(true)

			local var_5_0 = arg_5_1:getInput()
			local var_5_1 = fgui.DragDropManager:getInstance()

			var_5_1.startDrag(var_5_0, "", nil, (var_5_0:getTouchId()))

			local var_5_2 = fgui.UIPackage:createObject("base_new", "BaseUserIcon")

			var_5_2:updateAsUser(self._curDragComp:getUserData():getUser())
			var_5_1:getAgent():displayObject():addChild(var_5_2:popDisplayObject())

			goto label_5_0
		end
	end

	self._curDragComp = nil

	::label_5_0::
end

function GuildWarFightMineCitySingleComp:_onDragMove(arg_6_1)
	if self._curDragComp then
		-- block empty
	end
end

function GuildWarFightMineCitySingleComp:_onTouchEnd(arg_7_1)
	if self._curDragComp then
		local var_7_0 = arg_7_1:getInput():getTouch()

		if not var_7_0 then
			return
		end

		local var_7_1 = var_7_0:getLocation()

		var_7_1.y = var_7_1.y

		local var_7_2

		for iter_7_0 = 1, 6 do
			var_7_2 = self["m_frontPos" .. iter_7_0]:checkTarget(var_7_1)

			if var_7_2 then
				break
			end
		end

		if not var_7_2 then
			for iter_7_1 = 1, 3 do
				var_7_2 = self["m_strategicPoint" .. iter_7_1]:checkTarget(var_7_1)

				if var_7_2 then
					break
				end
			end
		end

		var_7_2 = var_7_2 or self.m_commandPoint:checkTarget(var_7_1)

		if var_7_2 then
			self:checkAndChangePos(self._curDragComp, var_7_2)
		end

		self._curDragComp:setInDrag(false)

		self._curDragComp = nil
	end
end

function GuildWarFightMineCitySingleComp:_onRevNotify(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3.guild_id ~= var_0_3:getCurWatchGuildId() then
		return
	end

	self:updateView()
end

function GuildWarFightMineCitySingleComp:updateView()
	local var_9_0 = var_0_3:getSelfGuildFormation()

	for iter_9_0, iter_9_1 in pairs(var_0_1) do
		for iter_9_2, iter_9_3 in ipairs((var_0_3:getBuildCfgByType(iter_9_1))) do
			if self._positionComp[iter_9_1] and self._positionComp[iter_9_1][iter_9_2] then
				(self._positionComp[iter_9_1] and self._positionComp[iter_9_1][iter_9_2]):updatePosition((var_9_0:getBuildById(iter_9_3.id)))
			end
		end
	end
end

function GuildWarFightMineCitySingleComp:checkAndChangePos(arg_10_1, arg_10_2)
	if not arg_10_1 or not arg_10_2 then
		return
	end

	if arg_10_1 == arg_10_2 then
		return
	end

	local var_10_0, var_10_1 = arg_10_1:getPosAndBuildId()
	local var_10_2, var_10_3 = arg_10_2:getPosAndBuildId()

	g.core.network.GameNetProxy:send_C2S_GuildWar_SwapUserBuild({
		build_id = var_10_1,
		build_pos = var_10_0,
		swap_build_id = var_10_3,
		swap_build_pos = var_10_2
	})
end

function GuildWarFightMineCitySingleComp:_onRvcFormationInfo(arg_11_1, arg_11_2, arg_11_3)
	self:updateView()

	if self.isFirstEnter then
		self.isFirstEnter = false

		self.m_enterTransition:play()
		self:setVisible(true)
	end
end

function GuildWarFightMineCitySingleComp:_onQuickFormation(arg_12_1, arg_12_2, arg_12_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(308648))
	self:updateView()
end

function GuildWarFightMineCitySingleComp:_onQuickFormationNotify(arg_13_1, arg_13_2, arg_13_3)
	self:updateView()
end

function GuildWarFightMineCitySingleComp:_onSwapBuilding(arg_14_1, arg_14_2, arg_14_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(308649))
	self:updateView()
end

function GuildWarFightMineCitySingleComp:_onSwapBuildingNotify(arg_15_1, arg_15_2, arg_15_3)
	self:updateView()
end

function GuildWarFightMineCitySingleComp:onUnload()
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragMove, var_0_2)
	fgui.DragDropManager:getInstance():getAgent():removeEventListener(fgui.UIEventType.DragEnd, var_0_2)
end

return GuildWarFightMineCitySingleComp
