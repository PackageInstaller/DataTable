local WushBuffChoosePop = class("WushBuffChoosePop", require("app.fairyGUI.wush.UI_WushBuffChoosePop"), function()
	return fgui.GComponent:create({
		resName = "WushBuffChoosePop",
		pkgPath = "ui/wush/wush",
		isFullScreen = true,
		pkgName = "wush"
	})
end)

function WushBuffChoosePop:ctor(arg_2_1)
	if arg_2_1 then
		self._buff = arg_2_1.buff or {}
	end

	if arg_2_1 then
		self._floorId = arg_2_1.floorId or 1
	end

	self._isSending = false

	self.m_bgLoader:setURL("bg/wush/bg_shuxingjiachengdiwen.png")
	self.m_costLoader:setURL(g.core.common.Path:getItemIconById(10036, true))
	self.m_touchGraph:addClickListener(handler(self, self._onClickClose))
end

function WushBuffChoosePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DEAD_BATTLE_PICKBUFF, handler(self, self._onRcvPickBuff), self)
	self:_updateBuffComp()
	self.m_enterTransition:play()
	self.m_starTxt:setText(g.core.lang:get(303016, {
		star = g.core.model.User.wushData:getCurLeftStar()
	}))
end

function WushBuffChoosePop:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "buff_choose_cell" and not self._isSending then
		self._isSending = true

		g.core.network.GameNetProxy:send_C2S_DeadBattle_PickBuff({
			id = arg_4_2.buffId
		})
	end
end

function WushBuffChoosePop:_updateBuffComp()
	for iter_5_0 = 1, 3 do
		if self["m_buffComp" .. iter_5_0] then
			self["m_buffComp" .. iter_5_0]:update({
				index = iter_5_0,
				buffId = self._buff[iter_5_0],
				floorId = self._floorId
			})
		end
	end
end

function WushBuffChoosePop:_onClickClose()
	g.core.module.ModuleManager:tip(g.core.lang:get(303017))
end

function WushBuffChoosePop:_onRcvPickBuff()
	self:dispatchCompEvent("BUFF_CHOOSE_END")
	g.core.module.ModuleManager:popComponent()
end

function WushBuffChoosePop:doAutoAction()
	for iter_8_0 = 3, 1, -1 do
		if self["m_buffComp" .. iter_8_0]:doAutoAction() then
			return
		end
	end
end

return WushBuffChoosePop
