local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.const.ConstMgr.EasterEggConst
local ResourceLoader = require("app.core.resource.ResourceLoader")
local var_0_3 = g.core.model.User.dungeonData
local var_0_4 = g.core.model.User.easterEggData
local DungeonEasterEggComp = class("DungeonEasterEggComp", require("app.fairyGUI.dungeon.UI_DungeonEasterEggComp"))
local var_0_6 = 5

function DungeonEasterEggComp:ctor()
	self._dataParam = nil
	self._eggEffect = nil
	self._hgithEffect = nil
	self._eggId = 0
	self._clickCount = 0
	self._touchSize = nil
	self._isCanClick = false
	self._needClickCount = 0
	self._lastClickTime = 0

	self.m_effectNode:setPivot(0.5, 0.5)

	self._isEditor = var_0_3:getDebugEditor()

	if self._isEditor then
		self.m_imageSize:setOpacity(76.5)
		self.m_imageSize:setVisible(true)
		self.m_touchNodeDebug:setVisible(true)
	else
		self.m_imageSize:setVisible(false)
		self.m_touchNodeDebug:setVisible(false)
	end

	self:initParams()
end

function DungeonEasterEggComp:initParams()
	local var_2_0 = self:getCustomData() or {}

	if var_2_0.img_param then
		self.m_imgeLoader:setVisible(true)
		self.m_imgeLoader:setURL(ResourceLoader:getPlatformResource(var_2_0.img_param))

		if var_2_0.pivot then
			self.m_imgeLoader:setPivot(var_2_0.pivot.x, var_2_0.pivot.y)
		end
	elseif var_2_0.spine_param then
		self.m_effectNode:setVisible(true)

		self._eggEffect = self.m_effectNode:addEffectSpine({
			name = var_2_0.spine_param
		})
	end

	if var_2_0.contentSize then
		self._touchSize = var_2_0.contentSize

		self.m_touchNode:setSize(self._touchSize.width, self._touchSize.height)

		if self._isEditor then
			self.m_touchNodeDebug:setSize(self._touchSize.width, self._touchSize.height)
		end
	end

	self._dataParam = var_2_0
end

function DungeonEasterEggComp:setData(arg_3_1, arg_3_2)
	self._eggId = tonumber(arg_3_1)
	self._eggInfo = arg_3_2

	if self._eggInfo then
		if g.core.utils.Quality.needUseStaticMap() then
			self.m_touchNode:setPosition(self._eggInfo.pos_x_1, self._eggInfo.pos_y_1)

			if self._isEditor then
				self.m_touchNodeDebug:setPosition(self._eggInfo.pos_x_1, self._eggInfo.pos_y_1)
			end
		else
			self.m_touchNode:setPosition(self._eggInfo.pos_x, self._eggInfo.pos_y)

			if self._isEditor then
				self.m_touchNodeDebug:setPosition(self._eggInfo.pos_x, self._eggInfo.pos_y)
			end
		end

		self._needClickCount = self._eggInfo.clicktime
	end

	self:updateClickState(false)
end

function DungeonEasterEggComp:getTouchSize()
	return self._touchSize
end

function DungeonEasterEggComp:setHightLight()
	if var_0_4:checkEggIsGet(self._eggInfo) then
		if self._hgithEffect ~= nil then
			self._hgithEffect:setVisible(false)
		end

		return false
	end

	self:updateClickState(true)

	if self._eggInfo and self._touchSize then
		if self._hgithEffect == nil then
			self._hgithEffect = self.m_touchNode:addEffectSpine({
				name = "eff_ui_egg_common_light01",
				anim = "eff_ui_egg_common_light01",
				isLoop = true
			})

			self._hgithEffect:setPosition(self._touchSize.width / 2, self._touchSize.height / 2)
		end

		self._hgithEffect:setVisible(true)
	end

	return true
end

function DungeonEasterEggComp:resetNormal()
	self:updateClickState(false)

	if self._eggInfo and self._hgithEffect ~= nil then
		self._hgithEffect:setVisible(false)
	end
end

function DungeonEasterEggComp:checkIsClick(arg_7_1, arg_7_2)
	if self._touchSize == nil or self._eggInfo == nil then
		return false
	end

	if var_0_4:checkEggIsGet(self._eggInfo) then
		return false
	end

	local var_7_0 = self.m_touchNode:displayObject():convertToWorldSpace(cc.p(0, 0))

	if var_7_0.x < arg_7_1.x and arg_7_1.x < var_7_0.x + self._touchSize.width and var_7_0.y < arg_7_1.y and arg_7_1.y < var_7_0.y + self._touchSize.height then
		if self._isCanClick then
			local var_7_1 = g.core.common.ServerTime:getTime()

			self._clickCount = var_7_1 - self._lastClickTime >= var_0_6 and 1 or self._clickCount + 1
			self._lastClickTime = var_7_1

			if self._clickCount >= self._needClickCount then
				self._clickCount = 1

				self:onOpenPop()
			end

			return true
		else
			return false
		end
	end
end

function DungeonEasterEggComp:onOpenPop()
	if self._eggInfo.open_type == var_0_1.OPEN_TYPE.PASSWORD and self._eggInfo.password > 0 then
		var_0_0:pushPopup(require("app.view.module.easterEgg.view.EasterEggLockPop").new({
			eggId = self._eggId,
			interactionId = self._eggInfo.interaction_id
		}), {
			hideContinue = true,
			touchDisappear = true
		})
	else
		local var_8_0 = require("app.view.module.easterEgg.view.EasterEggTipPop").new

		g.core.module.ModuleManager:pushPopup(require("app.view.module.easterEgg.view.EasterEggTipPop").new({
			callBack = handler(self, self._openEasterEggLayer)
		}), {
			touchDisappear = false,
			ignoreTouch = true,
			blackOpacity = 0
		})
	end
end

function DungeonEasterEggComp:_openEasterEggLayer()
	if self._eggInfo and self._eggId then
		g.core.module.ModuleManager:pushModule(g.view.entrance.EASTEREGG_LAYER, {
			eggId = self._eggId,
			interactionId = self._eggInfo.interaction_id
		})
	end
end

function DungeonEasterEggComp:updateClickState(arg_10_1)
	self._isCanClick = self._eggInfo and self._eggInfo.type ~= var_0_1.EGG_TYPE.MOVE_POS_TYPE and true or arg_10_1
end

return DungeonEasterEggComp
