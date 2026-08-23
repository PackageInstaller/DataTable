local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local CommonKnight = require("app.view.common.CommonKnight")
local GveBossComp = class("GveBossComp", require("app.fairyGUI.gve.UI_GveBossComp"))

function GveBossComp:ctor()
	var_0_1 = var_0_0:getGveData()

	self:setVisible(false)
end

function GveBossComp:setXy(arg_2_1, arg_2_2)
	self._x = arg_2_1
	self._y = arg_2_2
end

function GveBossComp:updateBoss()
	if not self._x or not self._y then
		self:setVisible(false)

		return
	end

	if var_0_1:isCurPosInFogCloud({
		x = self._x,
		y = self._y
	}) then
		self:setVisible(false)

		return
	end

	local var_3_0 = var_0_1:getPosNowBossCfg(self._x, self._y)

	if not var_3_0 then
		self.m_bossHolder:removeChildren()

		self._resId = nil

		self:setVisible(false)

		return
	end

	if var_3_0.show ~= 2 then
		self.m_typeController:setSelectedIndex(var_3_0.show - 1)
		self.m_bossHeadIcon:setURL(g.core.common.Path:getRoleHeadIcon(var_3_0.image))
	else
		self.m_typeController:setSelectedIndex(1)

		if self._resId and self._resId == var_3_0.image then
			return
		else
			self.m_bossHolder:removeChildren()
		end

		self._resId = var_3_0.image

		local var_3_2 = CommonKnight.new({
			isLoop = true,
			isReverse = true,
			resId = var_3_0.image,
			scale = (var_3_0.boss_type == 2 or nil) and 0.3
		})

		if var_3_0.boss_type == 2 then
			self.m_bossHolder:setPosition(cc.pAdd(self.m_bossHolder:getPosition(), cc.p(25, -25)))
		end

		self.m_bossHolder:addChild(var_3_2)
	end

	local var_3_3 = var_0_1:getBossData(var_3_0.id, var_3_0.x, var_3_0.y):getExpireTime()

	if var_3_3 > 0 then
		local var_3_4 = g.core.common.ServerTime:getDateObject(var_3_3)

		self.m_TimeTxt:setText((g.core.lang:get(309199, {
			month = var_3_4.month,
			day = var_3_4.day,
			hour = string.format("%02d", var_3_4.hour),
			min = string.format("%02d", var_3_4.min)
		})))
		self.m_isShowTimeController:setSelectedIndex(1)
	else
		self.m_TimeTxt:setText("")
		self.m_isShowTimeController:setSelectedIndex(0)
	end

	self:setVisible(true)
end

return GveBossComp
