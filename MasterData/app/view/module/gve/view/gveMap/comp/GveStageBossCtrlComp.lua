local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local GveStageBossCtrlComp = class("GveStageBossCtrlComp", require("app.fairyGUI.gve.UI_GveStageBossCtrlComp"))

function GveStageBossCtrlComp:ctor()
	var_0_1 = var_0_0:getGveData()

	self.m_detailBtn:addClickListener(handler(self, self.onDetailClick))
	self.m_shareBtn:addClickListener(handler(self, self.onCancelBtnClick))
end

function GveStageBossCtrlComp:updateBoss(arg_2_1, arg_2_2)
	self._bossCfg = arg_2_1

	self.m_posTxt:setText("W" .. arg_2_1.x .. ",E" .. arg_2_1.y)

	local var_2_0 = 0

	if arg_2_2 then
		self.m_nameTxt:setText(g.core.lang:get(309181, {
			name = arg_2_1.name
		}))
	else
		self.m_nameTxt:setText(arg_2_1.name)

		var_2_0 = var_0_1:getBossData(arg_2_1.id, arg_2_1.x, arg_2_1.y):getExpireTime()
	end

	if arg_2_1.range == 4 then
		self.m_buildStateController:setSelectedIndex(0)
	else
		self.m_buildStateController:setSelectedIndex(1)
	end

	if var_2_0 > 0 then
		local var_2_1 = g.core.common.ServerTime:getDateObject(var_2_0)

		self.m_TimeTxt:setText((g.core.lang:get(309199, {
			month = var_2_1.month,
			day = var_2_1.day,
			hour = string.format("%02d", var_2_1.hour),
			min = string.format("%02d", var_2_1.min)
		})))
	else
		self.m_TimeTxt:setText("")
	end
end

function GveStageBossCtrlComp:onCancelBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(309160),
		desc = g.core.lang:get(309161),
		onConfirm = handler(self, self._shareStagePosInfo)
	}))
end

function GveStageBossCtrlComp:onDetailClick()
	self:dispatchCompEvent("Stage_ctrl_ope_finish")

	if not self._bossCfg then
		return
	end

	if not var_0_1:isBossAlive(self._bossCfg.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(309182))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_BOSS_LAYER, {
		x = self._bossCfg.x,
		y = self._bossCfg.y,
		path = {},
		bossId = self._bossCfg.id
	})
end

function GveStageBossCtrlComp:_shareStagePosInfo()
	g.core.network.GameNetProxy:send_C2S_BulletScreenSend({
		look = 0,
		content = "",
		type = g.core.model.User.chatData:toSvrChatType(g.core.const.ConstMgr.ChatConst.ALLIANCE),
		param1 = self._bossCfg.x .. "_" .. self._bossCfg.y,
		share = {
			share_type = 15,
			id = g.core.model.User:getId()
		}
	})
	g.core.model.User.chatData:setLastSendConnectTime(g.core.const.ConstMgr.ChatConst.ALLIANCE)
	self:dispatchCompEvent("Stage_ctrl_ope_finish")
end

return GveStageBossCtrlComp
