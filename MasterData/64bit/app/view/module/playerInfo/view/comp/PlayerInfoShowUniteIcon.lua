local UniteTokenCommon = require("app.view.module.uniteToken.common.UniteTokenCommon")
local var_0_1 = g.core.model.User
local var_0_2 = g.core.common.Path
local PlayerInfoShowUniteIcon = class("PlayerInfoShowUniteIcon", require("app.fairyGUI.playerInfo.UI_PlayerInfoShowUniteIcon"))

function PlayerInfoShowUniteIcon:ctor()
	self._skillInfo = {}
	self._tokenData = {}
	self._isSelf = false

	self:addListener()
	self.m_starComp:initStar({
		gap = 0,
		index = 3,
		style = 2,
		num = 0,
		max = 5
	})
end

function PlayerInfoShowUniteIcon:addListener()
	self:addClickListener(handler(self, self._onClickIcon))
end

function PlayerInfoShowUniteIcon:_onClickIcon()
	if not self._tokenData or not next(self._tokenData) then
		return
	end

	UniteTokenCommon.openUniteInfoPop(self._tokenData)
end

function PlayerInfoShowUniteIcon:updateUniteIcon(arg_4_1, arg_4_2)
	self._isSelf = arg_4_2 == true

	if arg_4_1 == nil or not next(arg_4_1) then
		self.m_qualityBg:setURL(var_0_2:getPlayerInfoUniteQualityBg(0))
		self.m_isEmptyController:setSelectedIndex(1)
		self:setOpaque(false)
		self:setTouchable(false)
	else
		self.m_qualityBg:setURL(var_0_2:getPlayerInfoUniteQualityBg(arg_4_1:getQuality()))
		self.m_isEmptyController:setSelectedIndex(0)

		self._skillInfo = var_0_1.uniteTokenData:getTokenBaseInfo(arg_4_1:getSkillId()).skillInfo
		self._tokenData = arg_4_1

		self:setOpaque(true)
		self:setTouchable(true)
		self:setIcon(var_0_2:getUniteTokenMidCardImg(arg_4_1:getCfg().res_id))
		self.m_starComp:setStarNum(arg_4_1:getStarLevel())
	end
end

return PlayerInfoShowUniteIcon
