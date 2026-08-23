local var_0_0 = g.core.common.Path
local NewSlgEmbryoLineUpCell = class("NewSlgEmbryoLineUpCell", require("app.fairyGUI.newSlg.UI_NewSlgEmbryoLineUpCell"))

function NewSlgEmbryoLineUpCell:ctor()
	self._struct = nil

	self:addClickListener(handler(self, self._onClickBtnLineUp))
end

function NewSlgEmbryoLineUpCell:updateCell(arg_2_1)
	if not arg_2_1.struct then
		return
	end

	self._struct = arg_2_1.struct

	self.m_authorityNum:setText("+" .. self._struct:getAuthorityNum())
	self.m_nameTxt:setText(self._struct:getName())
	self.m_isLineupController:setSelectedIndex(self._struct:isLineUp() and 0 or 1)
	self.m_qualityBg:setURL(var_0_0:getUserIconQualityStarBg((self._struct:getQuality())))
	self.m_starComp:initStar({
		gap = 0,
		index = 3,
		style = 1,
		num = self._struct:getStar(),
		max = self._struct:getMaxStarLevel()
	})
	self.m_embryoIcon:setIcon(self._struct:getHeadIcon())
end

function NewSlgEmbryoLineUpCell:_onClickBtnLineUp()
	if g.core.model.User.newSlgData:getSName() == "S2" then
		g.core.module.ModuleManager:tip(g.core.lang:get(429741))

		return
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_hero_xuanze)

	if self._struct:isLineUp() then
		g.core.network.GameNetProxy:send_C2S_NewSlg_StationMainCity({
			pos = 0,
			tp = self._struct:getType(),
			id = self._struct:getSid()
		})

		return
	end

	self:dispatchCompEvent("EXCHANGE_LINE_UP_EMBRYO", {
		tp = self._struct:getType(),
		id = self._struct:getSid()
	})
end

return NewSlgEmbryoLineUpCell
