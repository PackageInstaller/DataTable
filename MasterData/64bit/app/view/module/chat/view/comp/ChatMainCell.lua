local ChatMainCell = class("ChatMainCell", require("app.fairyGUI.chat.UI_ChatMainCell"))
local ChatCommon = require("app.view.module.chat.common.ChatCommon")

function ChatMainCell:ctor()
	self.m_viewNameLoader:addClickListener(handler(self, self._onViewNameClick))
end

function ChatMainCell:updateCell(arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.data

	if not (arg_2_1 and arg_2_1.data) then
		return
	end

	local var_2_1 = var_2_0.content

	if var_2_0.channel and var_2_0.channel == 2 then
		-- block empty
	else
		var_2_1 = pcall(function()
			g.core.utils.Black:filterBlack(var_2_1)
		end) and g.core.utils.Black:filterBlack(var_2_1) or ""
	end

	self._viewUid = nil
	self._cfgId = nil

	if var_2_1 then
		var_2_1 = g.core.utils.String.splitString(var_2_1)

		self.m_chatText:setText(var_2_1)
	elseif var_2_0.viewUser then
		self._viewUid = var_2_0.viewUser.id
		var_2_1 = g.core.lang:get(109068, {
			name = var_2_0.viewUser.name
		})

		self.m_chatText:setText(var_2_1)
		self.m_viewNameText:setText(var_2_0.viewUser.name)
	elseif var_2_0.special_id and var_2_0.special_id > 0 then
		var_2_1 = ChatCommon:getSpecialContent(var_2_0)

		self.m_chatText:setText(var_2_1, true)
	elseif var_2_0.user then
		var_2_1 = var_2_0.user.name or ""

		self.m_chatText:setText(var_2_1, true, true)
		self.m_viewNameText:setText(var_2_1, false, true)

		if self.m_viewNameText:getWidth() > 366 then
			self.m_viewNameText:setWidth(366)
			self.m_viewNameText:setAutoSize(2)
		end

		self._viewUid = var_2_0.user.uid
		self._cfgId = var_2_0.user.cfgId
	end
end

function ChatMainCell:_onViewNameClick()
	if g.core.guide.GuideProxy:isGuideRunning() or g.core.battle.BattleProxy:isInBattle() or g.core.model.User.storyData:isInStory() or g.core.utils.Tools.checkSilentFull() ~= 0 then
		return
	end

	if self._viewUid and self._viewUid > 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			uid = self._viewUid
		})
	elseif self._cfgId then
		local var_4_0 = g.core.config.notice_info.get(self._cfgId)

		if var_4_0.jump and var_4_0.jump > 0 then
			g.view.entrance.ModuleGotoProxy:gotoModule(var_4_0.jump)
		end
	end
end

return ChatMainCell
