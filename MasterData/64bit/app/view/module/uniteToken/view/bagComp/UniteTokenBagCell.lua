local var_0_0 = g.core.common.Path
local UniteTokenCommon = require("app.view.module.uniteToken.common.UniteTokenCommon")
local var_0_2 = g.core.config.unite_token_info
local UniteTokenBagCell = class("UniteTokenBagCell", require("app.fairyGUI.uniteToken.UI_UniteTokenBagCell"))

function UniteTokenBagCell:ctor()
	self._data = {}
	self._index = 0

	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)
	self:addClickListener(handler(self, self._onClick))
end

function UniteTokenBagCell:onLoad()
	if self._data and next(self._data) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				advId = self._data:getAdvanceId()
			}
		})
	end
end

function UniteTokenBagCell:updateCell(arg_3_1, arg_3_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = arg_3_1:getAdvanceId()
		}
	})

	self._data = arg_3_1
	self._index = arg_3_2

	self.m_bg:setURL(var_0_0:getBigQualityBgByQuality(self._data:getQuality()))
	self.m_nameText:setText(self._data:getName())
	self.m_iconLoader:setIcon(var_0_0:getUniteTokenCardImg(self._data:getAdvanceId()))
	self.m_skillBtn:updateIcon({
		skillId = self._data:getSkillId()
	})

	if self._data:isOwn() then
		self.m_levelTxt:setText((self._data:getLevel()))
		self.m_starComp:initStar({
			max = 5,
			index = 3,
			gap = 0,
			style = 2,
			num = self._data:getStarLevel()
		})

		if self._data:isLineup() then
			self.m_stateController:setSelectedIndex(0)
		else
			self.m_stateController:setSelectedIndex(1)
		end
	else
		local var_3_0, var_3_1 = self._data:getFragmentNum()

		self.m_curTxt:setText(var_3_0)
		self.m_needTxt:setText("/" .. var_3_1)

		if self._data:canCompose() then
			self.m_stateController:setSelectedIndex(2)
		else
			self.m_stateController:setSelectedIndex(3)
		end
	end
end

function UniteTokenBagCell:_onClick()
	if self._data:isOwn() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.UNITE_TOKEN_DEVELOP, {
			tabIndex = 3,
			severId = self._data:getServerId()
		})
	elseif self._data:canCompose() then
		g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
			num = 1,
			id = var_0_2.get(self._data:getBaseId()).fragment_id
		})
	else
		UniteTokenCommon.openUniteInfoPop(self._data)
	end
end

function UniteTokenBagCell:setReborn()
	self.m_lineUp:setVisible(false)
	self.m_process:setVisible(false)
	self.m_redPointComp:setVisible(false)
end

return UniteTokenBagCell
