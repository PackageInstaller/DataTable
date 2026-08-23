local WarriorsConst = require("app.view.module.warriorsOfFate.const.WarriorsConst")
local WarriorsGeneralCell = class("WarriorsGeneralCell", require("app.fairyGUI.warriorsOfFate.UI_WarriorsGeneralCell"))

function WarriorsGeneralCell:ctor(arg_1_1)
	self._type = nil
	self._content = nil
	self._goods = nil
	self._state = 0
	self._effectNode = nil
	self._active = false
	self._canActive = false
	self._completeActivate = true
	self._isResEnough = false

	self:addClickListener(handler(self, self._onClickScroll))
end

function WarriorsGeneralCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SCROLL_ACTIVATE, handler(self, self._onScrollActive), self)
end

function WarriorsGeneralCell:_onActivate()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.MEMORY_ACTIVE)
	g.core.network.GameNetProxy:send_C2S_Scroll_Activate({
		id = self._content.id,
		type = self._content.tab_type
	})
end

function WarriorsGeneralCell:_onClickScroll(arg_4_1)
	if not self._completeActivate then
		return
	end

	if self._state == 1 then
		self._active = true
		self._completeActivate = false

		self:_onActivate()
	elseif self._state == 2 then
		if self._isResEnough then
			g.core.module.ModuleManager:tip(g.core.lang:get(105028))
		else
			local var_4_0 = {
				type = self._goods.type,
				value = self._goods.value,
				size = self._goods.curItemNum
			}

			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_4_0.type,
				value = var_4_0.value,
				size = var_4_0.size
			})
		end
	elseif self._state == 0 then
		-- block empty
	end
end

function WarriorsGeneralCell:_onScrollActive(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if not self._active then
		return
	end

	self._active = false
	self._canActive = false
	self._state = self.m_activeStateController:getSelectedIndex() - 1

	self.m_activeStateController:setSelectedIndex(self._state)

	if self._effectNode then
		self._effectNode:removeFromParent()
	end

	self._effectNode = nil

	self:_addDisplayData()
	self:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(0.5),
		fgui.FCallFunc:create(function()
			self._completeActivate = true

			self:dispatchCompEvent("WarriorsScroll_Activate", {
				content = arg_5_4
			})
		end)
	})))
end

function WarriorsGeneralCell:_addDisplayData()
	if not self._content.id then
		return
	end

	local var_7_0 = g.core.model.User.warriorsOfFateData:isKnightUp(self._content.id)
	local var_7_1 = g.core.model.User.warriorsOfFateData:getChapterById(self._content.id)
	local var_7_2 = {}

	table.insert(var_7_2, {
		isTitle = true,
		icon = "ui://text/jihuochenggong",
		offsetPos = cc.p(50, 0)
	})

	local var_7_3 = {
		txt = var_7_1.name,
		strValue = var_7_1.value
	}

	if var_7_0 or g.core.model.User.warriorsOfFateData:isKnightUpStar(self._content.id) or g.core.model.User.warriorsOfFateData:isActiveAttr(self._content.id) then
		var_7_3.delay = 0.4
	end

	table.insert(var_7_2, var_7_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = g.core.const.ConstMgr.BaseShowTypeConst.WARRIORS_ACTIVE_SUCCESS
		}
	})
end

function WarriorsGeneralCell:updateInfo(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	self._type = arg_8_4
	self._state = arg_8_2
	self._content = arg_8_1 or {}
	self._canActive = arg_8_3
	self._index = arg_8_5
	self._isResEnough = arg_8_6
	self._name = g.core.model.User.warriorsOfFateData:getChapterTable(self._type).get(arg_8_1.chapter_id).name

	self.m_nameText:setText(self._name)
	self.m_activeStateController:setSelectedIndex(arg_8_2)

	if arg_8_2 == WarriorsConst.activeSate.CAN_ACTIVE then
		g.core.utils.Action.playBlinkAction(self.m_activeImage)
	end

	if arg_8_1.stage_id ~= 0 then
		self.m_describeStageText:setText(g.core.lang:get(105013))
		self.m_describeStageNode:setText(arg_8_1.district_directions)
		self.m_isStageController:setSelectedIndex(1)
	else
		self.m_atrrText:setText(arg_8_1.district_directions)
		self.m_isStageController:setSelectedIndex(0)
	end

	self.m_numText:setText(arg_8_1.cost_size)

	if arg_8_2 == WarriorsConst.activeSate.CAN_ACTIVE then
		if not self._effectNode then
			self:_createSpineEffect()
		end
	else
		if self._effectNode then
			self._effectNode:removeFromParent()
		end

		self._effectNode = nil
	end

	self.m_kightImage:setURL(g.core.common.Path:getKnightPicRes(self._content.res))

	self._goods = g.core.common.Goods:convert({
		type = arg_8_1.cost_type,
		value = arg_8_1.cost_value,
		size = arg_8_1.cost_size
	})
	self._goods.curItemNum = g.core.model.User.bagData:getOwnNum(arg_8_1.cost_type, arg_8_1.cost_value)

	self.m_typeLoader:setURL(self._goods.icon_mini)
end

function WarriorsGeneralCell:_createSpineEffect(arg_9_1, arg_9_2)
	return
end

return WarriorsGeneralCell
