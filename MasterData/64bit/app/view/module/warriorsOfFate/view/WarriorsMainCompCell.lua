local var_0_0 = {
	{
		x = 1,
		y = 7
	},
	{
		x = 2,
		y = 0
	},
	{
		x = 2,
		y = -3
	},
	{
		x = 11,
		y = 0
	},
	{
		x = 6,
		y = 12
	}
}
local ShowFactory = require("app.view.module.show.ShowFactory")
local WarriorsConst = require("app.view.module.warriorsOfFate.const.WarriorsConst")
local WarriorsMainCompCell = class("WarriorsMainCompCell", require("app.fairyGUI.warriorsOfFate.UI_WarriorsMainCompCell"))

function WarriorsMainCompCell:ctor(arg_1_1)
	self._type = nil
	self._content = nil
	self._goods = nil
	self._state = 0
	self._hasActiveEffectNode = nil
	self._activateEffectNode = nil
	self._active = false
	self._canActive = false
	self._completeActivate = true
	self._isUpQualityOrStar = false
	self._isResEnough = false

	self:addClickListener(handler(self, self._onClickScroll))

	self.m_bgLoader = self:getChild("bg")
	self.bgImageInitialPos = self.m_bgLoader:getPosition()
	self._isPlayedEnter = false
	self.m_enterTransition = self:getTransition("enter")

	self.m_enterTransition:setHook("script_play", handler(self, self._onCellShowEnd))

	self.m_switchLeftTrans = self:getTransition("switch_left")
	self.m_switchRightTrans = self:getTransition("switch_right")
	self.m_activeTransition = self:getTransition("active")
end

function WarriorsMainCompCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SCROLL_ACTIVATE, handler(self, self._onScrollActive), self)

	if not self._isPlayedEnter then
		self._isPlayedEnter = true

		self.m_enterTransition:play()
	end
end

function WarriorsMainCompCell:_onCellShowEnd()
	local var_3_0 = self:getChild("eff_activeText")

	if self._state == 1 and var_3_0 then
		var_3_0:addNode((require("app.view.common.SpineBase").new({
			isLoop = false,
			anim = "play",
			resId = "",
			path = g.core.common.Path:getEffSpine("eff_ui_warriorsOfFate_script")
		})))
	end
end

function WarriorsMainCompCell:_onActivate()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RELIC_ACTIVE)
	g.core.network.GameNetProxy:send_C2S_Scroll_Activate({
		id = self._content.id,
		type = self._content.tab_type
	})
end

function WarriorsMainCompCell:_onClickScroll(arg_5_1)
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
			local var_5_0 = {
				type = self._goods.type,
				value = self._goods.value,
				size = self._goods.curItemNum
			}

			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_5_0.type,
				value = var_5_0.value,
				size = var_5_0.size
			})
		end
	elseif self._state == 0 then
		-- block empty
	end
end

function WarriorsMainCompCell:_onScrollActive(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if not self._active then
		return
	end

	self._active = false
	self._canActive = false
	self._state = self.m_activeStateController:getSelectedIndex() - 1

	self.m_activeStateController:setSelectedIndex(self._state)
	self:_createActiveSpineEffect()
	self:_addDisplayData()

	local var_6_0 = arg_6_4.awards or {}

	if #var_6_0 > 0 then
		g.core.module.ModuleManager:awardSummary(var_6_0)
	end

	local var_6_1 = self._isUpQualityOrStar

	self:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(0.1),
		fgui.FCallFunc:create(function()
			self._completeActivate = true

			self:dispatchCompEvent("WarriorsScroll_Activate", {
				content = arg_6_4,
				isUpQualityOrStar = var_6_1
			})
		end)
	})))
end

function WarriorsMainCompCell:_addDisplayData()
	if not self._content.id then
		return
	end

	local var_8_0 = g.core.model.User.warriorsOfFateData:isKnightUp(self._content.id)
	local var_8_1 = g.core.model.User.warriorsOfFateData:isKnightUpStar(self._content.id)
	local var_8_2 = g.core.model.User.warriorsOfFateData:getChapterById(self._content.id)
	local var_8_3 = {}

	table.insert(var_8_3, {
		icon = "ui://text/jihuochenggong",
		isTitle = true,
		offsetPos = cc.p(50, 0)
	})

	local var_8_4 = {
		txt = var_8_2.name,
		strValue = var_8_2.value
	}

	if var_8_0 or var_8_1 or g.core.model.User.warriorsOfFateData:isActiveAttr(self._content.id) then
		var_8_4.delay = 0.5
	end

	table.insert(var_8_3, var_8_4)

	if var_8_0 then
		local var_8_5 = g.core.model.User.knightsData:getMainKnight():getInfo()
		local var_8_6 = {
			isMain = true,
			base_id = var_8_5.base_id,
			id = var_8_5.id
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "MainKnightQualityUp",
					func = function()
						return ShowFactory:showKingdomUp(var_8_6)
					end
				}
			}
		})
	end

	if var_8_1 then
		local var_8_7 = g.core.model.User.knightsData:getMainKnight():getInfo()
		local var_8_8 = {
			isMain = true,
			base_id = var_8_7.base_id,
			id = var_8_7.id
		}

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "MainKnightStarUp",
					func = function()
						return ShowFactory:showKnightUpStar(var_8_8)
					end
				}
			}
		})
	end

	self._isUpQualityOrStar = not not (var_8_0 or var_8_1)

	if not var_8_1 and not var_8_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			showMoment = true,
			baseShowPop = {
				type = g.core.const.ConstMgr.BaseShowTypeConst.WARRIORS_ACTIVE_SUCCESS
			}
		})
	end
end

function WarriorsMainCompCell:updateInfo(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	self._type = arg_11_4
	self._state = arg_11_2
	self._content = arg_11_1 or {}
	self._canActive = arg_11_3
	self._index = arg_11_5
	self._isResEnough = arg_11_6
	self._name = g.core.model.User.warriorsOfFateData:getChapterTable(self._type).get(arg_11_1.chapter_id).name

	self.m_nameText:setText(self._name)
	self.m_activeStateController:setSelectedIndex(arg_11_2)

	if arg_11_1.pic_id then
		self.m_bgLoader:setURL((g.core.common.Path:getWarriorsMainChapterPic(arg_11_1.pic_id)))
		self.m_bgLoader:setPosition(self.bgImageInitialPos.x + var_0_0[self._index + 1].x, self.bgImageInitialPos.y + var_0_0[self._index + 1].y)
	end

	if arg_11_2 == WarriorsConst.activeSate.CAN_ACTIVE then
		-- block empty
	end

	if arg_11_1.stage_id ~= 0 then
		if self._type == WarriorsConst.MAIN then
			self.m_describeStageText:setText(g.core.config.scroll_stage_growth_info.get(arg_11_1.stage_id).seen_directions)
		end

		self.m_describeStageNode:setText(arg_11_1.district_directions)
		self.m_isStageController:setSelectedIndex(1)
	else
		self.m_atrrText:setText(arg_11_1.district_directions)
		self.m_isStageController:setSelectedIndex(0)
	end

	self.m_numText:setText(arg_11_1.cost_size)

	local var_11_0

	if arg_11_2 == WarriorsConst.activeSate.HAS_ACTIVE then
		if not self._hasActiveEffectNode then
			self:_createHasActiveSpineEffect()
		end
	else
		if self._hasActiveEffectNode then
			self._hasActiveEffectNode:removeFromParent()
		end

		self._hasActiveEffectNode = nil
		var_11_0 = {}
	end

	var_11_0.type = arg_11_1.cost_type
	var_11_0.value = arg_11_1.cost_value
	var_11_0.size = arg_11_1.cost_size
	self._goods = g.core.common.Goods:convert(var_11_0)
	self._goods.curItemNum = g.core.model.User.bagData:getOwnNum(arg_11_1.cost_type, arg_11_1.cost_value)

	self.m_typeLoader:setURL(self._goods.icon_mini)
end

function WarriorsMainCompCell:_createHasActiveSpineEffect()
	self._hasActiveEffectNode = self:getChild("eff_border"):addEffectSpine({
		name = "eff_ui_warriorsOfFate_border",
		y = 0,
		x = 0,
		isLoop = true,
		anim = "play" .. tostring(self._index + 1)
	})
end

function WarriorsMainCompCell:_createActiveSpineEffect()
	self._activateEffectNode = self._activateEffectNode or self:getChild("eff_activate")

	self._activateEffectNode:addEffectSpine({
		name = "eff_ui_warriorsOfFate_activate",
		y = 0,
		x = 0,
		remove = true,
		isLoop = false,
		anim = "play" .. tostring(self._index + 1)
	})
end

return WarriorsMainCompCell
