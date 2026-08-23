local AncientsFinalBattleTurnCell = class("AncientsFinalBattleTurnCell", require("app.fairyGUI.ancients.UI_AncientsFinalBattleTurnCell"))

function var_0_0:ctor()
	self.m_Btn_video:addClickListener(handler(self, self._onClickBtnVideo))
end

function var_0_0:updateCell(arg_2_1)
	self._turn = arg_2_1.turn or {}

	local var_2_1 = arg_2_1.index

	self.m_is_winController:setSelectedIndex(self._turn.is_win and 1 or 0)
	self.m_Txt_index:setText(var_2_1 + 1)
	self.m_showBgController:setSelectedIndex(var_2_1 % 2 == 0 and 1 or 0)

	local var_2_2 = g.core.utils.Tools.ancientsFunc.getSnapshot(self._turn.atk_uid)
	local var_2_3 = g.core.utils.Tools.ancientsFunc.getSnapshot(self._turn.def_uid)

	if var_2_2 then
		self.m_Txt_atk_name:setText(var_2_2.name)
	end

	if var_2_3 then
		self.m_Txt_def_name:setText(var_2_3.name)
	end
end

function var_0_0:_onClickBtnVideo()
	if self._turn.uri and self._turn.uri ~= "" then
		g.core.network.GameHttpProxy:sendHttpRequest(g.core.model.User:getBattleVideoUrl() .. self._turn.uri, "GET", {
			success = handler(self, self._onRequestSuccess),
			fail = handler(self, self._onRequestError),
			cancel = handler(self, self._onRequestError)
		}, self)
	end
end

function var_0_0:_onRequestError()
	g.core.log:error("request error uri=" .. self._turn.uri)
end

function var_0_0._onRequestSuccess(arg_5_0, arg_5_1)
	g.core.battle.BattleProxy:playVidioBattle((require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleVideo", arg_5_1)))
end

return var_0_0
