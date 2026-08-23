local ChatSettingPop = class("ChatSettingPop", require("app.fairyGUI.chat.UI_ChatSettingPop"), function()
	return fgui.GComponent:create({
		resName = "ChatSettingPop",
		pkgPath = "ui/chat/chat",
		pkgName = "chat"
	})
end)
local ChatMainPopCfg = require("app.view.module.chat.common.ChatMainPopCfg")

function ChatSettingPop:ctor()
	self._chatSetInfo = nil
	self._chatSetDesc = nil

	self:_initComp()
end

function ChatSettingPop:onLoad()
	self:_addNetWorkListener()
end

function ChatSettingPop:_initComp()
	self:_initData()
	self:_initUI()
end

function ChatSettingPop:_initData()
	self._chatSetInfo = clone(g.core.model.User.chatData:getChatSetInfo())
	self._chatSetData = {}

	for iter_5_0, iter_5_1 in pairs(ChatMainPopCfg.settingCfg) do
		self._chatSetData[iter_5_0] = {
			index = iter_5_1.index,
			desc = g.core.lang:get(iter_5_1.desc)
		}
	end

	self._chatTypeSet = {
		g.core.const.ConstMgr.ChatConst.SINGLE,
		g.core.const.ConstMgr.ChatConst.SYSTEM,
		g.core.const.ConstMgr.ChatConst.WORLD,
		g.core.const.ConstMgr.ChatConst.ARMY,
		g.core.const.ConstMgr.ChatConst.AREA
	}
end

function ChatSettingPop:_initUI()
	self.m_checkList:setIniter()
	self.m_checkList:setItemRenderer(handler(self, self._onCheckListRenderer))
	self.m_checkList:setNumItems(#self._chatSetInfo)
	self:getView():center(true)
end

function ChatSettingPop:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SET_USER_CONFIG, handler(self, self._onRecvSet), self)
end

function ChatSettingPop:_onCheckListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._chatSetData[arg_8_1 + 1].index, self._chatSetInfo[self._chatSetData[arg_8_1 + 1].index], self._chatSetData[arg_8_1 + 1].desc)
end

function ChatSettingPop:receiveCompEvent(arg_9_1)
	local var_9_0 = {
		...
	}

	if arg_9_1 == "CompSettingCell_clickCheck" then
		self._chatSetInfo[var_9_0[1][2]] = var_9_0[1][1]

		local var_9_1 = self._chatTypeSet[var_9_0[1][2]] or 0

		if var_9_1 ~= 0 then
			g.core.model.User.chatData:setChannelFlag(var_9_1, false)
		end

		g.core.network.GameNetProxy:send_C2S_SetUserConfig({
			tp = 1,
			config = {
				chat = self._chatSetInfo
			}
		})
	end
end

function ChatSettingPop:_onRecvSet()
	g.core.model.User.chatData:updateSetInfo(self._chatSetInfo)
end

return ChatSettingPop
