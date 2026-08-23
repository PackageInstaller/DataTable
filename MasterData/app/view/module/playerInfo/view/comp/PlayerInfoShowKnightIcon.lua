local PlayerInfoShowKnightIcon = class("PlayerInfoShowKnightIcon", require("app.fairyGUI.playerInfo.UI_PlayerInfoShowKnightIcon"))

function PlayerInfoShowKnightIcon:ctor()
	self._knight = nil
	self._matchInfos = nil
	self._isSelf = false

	self:addListener()
end

function PlayerInfoShowKnightIcon:addListener()
	self:addClickListener(handler(self, self._onClickIcon))
end

function PlayerInfoShowKnightIcon:_onClickIcon()
	if self._knight == nil then
		return
	end

	if self._isSelf then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightAdvId = self._knight:getAdvanceId()
		}), {
			withoutAni = true
		})
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightStruct = self._knight,
			matchInfos = self._matchInfos,
			isOthers = not self._isSelf,
			knightPos = self._knightPos
		}), {
			withoutAni = true
		})
	end
end

function PlayerInfoShowKnightIcon:updateKnightIcon(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self._isSelf = arg_4_4 == true

	if not self._isSelf then
		self._knightPos = g.core.model.User.friendData:getPlayerInfo().formation.position[arg_4_3]
	end

	if arg_4_1 == nil then
		self.m_isEmptyController:setSelectedIndex(0)
		self:setOpaque(false)
	else
		self._knight = arg_4_1
		self._matchInfos = arg_4_2 and arg_4_2[arg_4_3]

		self.m_isEmptyController:setSelectedIndex(1)
		self.m_knightIcon:updateIcon({
			struct = arg_4_1,
			mustShowWedding = arg_4_5,
			isNeedShowWedding = arg_4_4
		})
		self:setOpaque(true)
	end
end

return PlayerInfoShowKnightIcon
