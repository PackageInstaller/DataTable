local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST.ADVANCE_COMMON_CONVERT_ITEM_ID
local var_0_1 = g.core.common.Goods
local KnightShortcutBlitzPop = class("KnightShortcutBlitzPop", require("app.fairyGUI.knight.UI_KnightShortcutBlitzPop"), function()
	return fgui.GComponent:create({
		resName = "KnightShortcutBlitzPop",
		pkgPath = "ui/knight/knight",
		pkgName = "knight"
	})
end)

function KnightShortcutBlitzPop:ctor(arg_2_1)
	if arg_2_1 then
		self._matId = arg_2_1.matId or 0
	end

	if arg_2_1 then
		self._needNum = arg_2_1.needNum or 0
	end

	self._stage = arg_2_1 and arg_2_1.stage
	self._isShowConvert = arg_2_1 and arg_2_1.isShowConvert
	self._costSize = arg_2_1 and arg_2_1.cost
	self._guildIndex = nil

	self:getView():center(true)
	self:_initList()
end

function KnightShortcutBlitzPop:_initList()
	self.m_dungeonList:setVirtual(self)
	self.m_dungeonList:setItemRenderer(handler(self, self._onDungeonItemRenderer))
	self.m_convertBtn:addClickListener(handler(self, self._onConvertBtnClick))
	self.m_isShowConvertController:setSelectedIndex(self._isShowConvert and 1 or 0)
end

function KnightShortcutBlitzPop:_onDungeonItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell({
		data = self._routeData[arg_4_1 + 1],
		matId = self._matId,
		needNum = self._needNum
	})
	self:checkSpeGuide(arg_4_1, arg_4_2)
end

function KnightShortcutBlitzPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DUNGEON_FASTCHALLENGESTAGE, handler(self, self._onRcvDungeonBlitz), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MATERIAL_EXCHANGE, handler(self, self._onS2CMaterialExchange), self)
	self:_updateDungeonList()
end

function KnightShortcutBlitzPop:_onRcvDungeonBlitz()
	self:removeSelf()
end

function KnightShortcutBlitzPop:_updateDungeonList()
	self._routeData = g.view.entrance.ModuleGotoProxy:getSrcRoute({
		type = g.core.common.Goods.TYPE_KNIGHT_ADVANCE,
		value = self._matId
	}).routes

	table.sort(self._routeData, function(arg_8_0, arg_8_1)
		local var_8_0 = g.core.model.User.dungeonData:isStageUnlocked(arg_8_0.chapterId)
		local var_8_1 = g.core.model.User.dungeonData:isStageUnlocked(arg_8_1.chapterId)

		if var_8_0 ~= var_8_1 then
			return var_8_0
		end

		if not var_8_0 and not var_8_1 then
			if arg_8_0.chapterId ~= arg_8_1.chapterId then
				return arg_8_0.chapterId < arg_8_1.chapterId
			end
		elseif arg_8_0.chapterId ~= arg_8_1.chapterId then
			return arg_8_0.chapterId > arg_8_1.chapterId
		end
	end)
	self:calcGuideIndex()
	self.m_dungeonList:setNumItems(#self._routeData)
	self:_updateConvertView()
end

function KnightShortcutBlitzPop:_updateConvertView()
	local var_9_0 = g.core.model.User.bagData:getCountById(var_0_1.TYPE_ITEM, var_0_0)
	local var_9_1 = self._costSize - g.core.model.User.bagData:getCountById(var_0_1.TYPE_KNIGHT_ADVANCE, self._matId)

	self.m_convertItemIcon:updateIcon({
		type = var_0_1.TYPE_ITEM,
		value = var_0_0,
		size = var_9_0
	})
	self.m_convertItemIcon:setGrayed(var_9_0 == 0)
	self.m_targetItemIcon:updateIcon({
		type = var_0_1.TYPE_KNIGHT_ADVANCE,
		value = self._matId
	})
	self.m_maxNumTxt:setText("/" .. math.min(var_9_1, var_9_0))

	local var_9_2 = math.min(var_9_1, var_9_0)

	self._addCount = var_9_0 > 0 and 1 or 0

	self.m_curNumTxt:setText(self._addCount)
	self.m_addNumComp:initMinMaxNum({
		min = var_9_0 > 0 and 1 or 0,
		max = var_9_2,
		cur = var_9_2,
		callback = handler(self, self._refreshAddNum)
	})
end

function KnightShortcutBlitzPop:_refreshAddNum(arg_10_1)
	self._addCount = arg_10_1

	self.m_curNumTxt:setText(self._addCount)
end

function KnightShortcutBlitzPop:_onConvertBtnClick()
	if self._addCount == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(201109))

		return
	end

	if g.core.model.User.bagData:getCountById(var_0_1.TYPE_ITEM, var_0_0) > 0 and self._addCount > 0 then
		g.core.network.GameNetProxy:send_C2S_Material_Exchange({
			id = self._matId,
			num = self._addCount
		})
	end
end

function KnightShortcutBlitzPop:_onS2CMaterialExchange(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	g.core.module.ModuleManager:awardSummary({
		{
			type = var_0_1.TYPE_KNIGHT_ADVANCE,
			value = arg_12_4.id,
			size = arg_12_4.num
		}
	})

	local var_12_0 = math.max(self._costSize - g.core.model.User.bagData:getCountById(var_0_1.TYPE_KNIGHT_ADVANCE, arg_12_4.id), 0)

	if var_12_0 > 0 then
		self._needNum = var_12_0

		self:_updateConvertView()
		self:_updateDungeonList()
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function KnightShortcutBlitzPop:calcGuideIndex()
	for iter_13_0, iter_13_1 in ipairs(self._routeData) do
		local var_13_0 = g.core.config.source_route_info.get(iter_13_1.route.route_id)
		local var_13_1 = var_13_0.route_value_1

		self._stageId = var_13_0.route_value_1

		if var_13_0.route_type == 102 then
			if var_13_1 == 0 then
				var_13_1 = g.core.model.User.dungeonData:getLastUnlockStageId()
			end

			if g.core.model.User.dungeonData:isStagePassed(var_13_1) then
				self._guildIndex = iter_13_0

				return
			end
		end
	end
end

function KnightShortcutBlitzPop:checkSpeGuide(arg_14_1, arg_14_2)
	if not self._guildIndex then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

		return
	end

	if arg_14_1 == self._guildIndex - 1 and self._stage then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

		if self._stage < 2 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
				key = "GUILD_CHECK_KNIGHT_ADVANCE_2",
				targetBtn = arg_14_2.m_blitzBtn
			})
		end
	end
end

function KnightShortcutBlitzPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return KnightShortcutBlitzPop
