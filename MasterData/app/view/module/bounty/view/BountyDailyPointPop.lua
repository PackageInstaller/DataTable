local BountyDailyPointPop = class("BountyDailyPointPop", require("app.fairyGUI.bounty.UI_BountyDailyPointPop"), function()
	return fgui.GComponent:create({
		resName = "BountyDailyPointPop",
		pkgName = "bounty"
	})
end)

function BountyDailyPointPop:ctor(arg_2_1)
	self:showAtCenter()

	self._playerList = {}
	self._checkUserMap = {}

	self:_initBtn()
	self:_initListView()
	self:updateListView()
end

function BountyDailyPointPop:_addCustomListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_GETUSERDAILYSCORE, handler(self, self.updateListView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BOUNTY_DAILYSCOREAWARD, handler(self, self._onDailyAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self.updateListView), self)
end

function BountyDailyPointPop:onLoad()
	self:_addCustomListener()
	g.core.network.GameNetProxy:send_C2S_Bounty_GetUserDailyScore({})
end

function BountyDailyPointPop:_initBtn()
	self.m_getAwardBtn:addClickListener(handler(self, self._onAwardClick))
end

function BountyDailyPointPop:_initListView()
	self.m_playerList:setVirtual(self)
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
end

function BountyDailyPointPop:_onRenderPlayerList(arg_7_1, arg_7_2)
	arg_7_2:updatePlayerCell(self._playerList[arg_7_1 + 1], arg_7_1 + 1)
end

function BountyDailyPointPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "clickAward" then
		self:_getScoreAward({
			arg_8_2.info.uid
		})

		return true
	end
end

function BountyDailyPointPop:updateListView()
	self._playerList = g.core.model.User.bountyData:getDailyRankInfoList()

	self.m_playerList:setNumItems(#self._playerList)
	self.m_isEmptyController:setSelectedIndex(#self._playerList > 0 and 0 or 1)
	self:_checkOneBtnState()
end

function BountyDailyPointPop:_checkOneBtnState()
	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(self._playerList) do
		if not g.core.model.User.bountyData:isGetDailyReward(iter_10_1.uid) and math.floor(iter_10_1.cfg.value / 1000 * iter_10_1.score) > 0 and iter_10_0 <= 5 then
			var_10_0 = true

			break
		end
	end

	self.m_oneBtnStateController:setSelectedIndex(var_10_0 and 0 or 1)
end

function BountyDailyPointPop:_onAwardClick()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self._playerList) do
		if iter_11_1.uid ~= 0 and not g.core.model.User.bountyData:isGetDailyReward(iter_11_1.uid) and math.floor(iter_11_1.cfg.value / 1000 * iter_11_1.score) > 0 and iter_11_0 <= 5 then
			table.insert(var_11_0, iter_11_1.uid)
		end
	end

	if #var_11_0 > 0 then
		self:_getScoreAward(var_11_0)
	end
end

function BountyDailyPointPop:_getScoreAward(arg_12_1)
	g.core.network.GameNetProxy:send_C2S_Bounty_DailyScoreAward({
		user_id = arg_12_1
	})
end

function BountyDailyPointPop:_onDailyAward(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = {
		showNow = true
	}
	local var_13_1 = {}

	var_13_1.awards = arg_13_4.awards or {}
	var_13_0.award = var_13_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_13_0)
	self:updateListView()
end

return BountyDailyPointPop
