local var_0_0 = 6
local var_0_1 = g.core.config.arena_robot_info
local var_0_2 = g.core.config.knight_info
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local ArenaChallengeConfirmPop = class("ArenaChallengeConfirmPop", require("app.fairyGUI.arena.UI_ArenaChallengeConfirmPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/arena/arena",
		resName = "ArenaChallengeConfirmPop",
		pkgName = "arena"
	})
end)

function ArenaChallengeConfirmPop:ctor(arg_2_1)
	self._challengeData = arg_2_1
	self._knightStructArr = self:_getLineUpKnights(arg_2_1.user)

	self.m_zs1Loader:setURL("pic/base_new/arena/pic_zhuangshi1.png")
	self.m_zs2Loader:setURL("pic/base_new/arena/pic_zhuangshi2.png")
	self.m_fightBtn:addClickListener(handler(self, self._onFight))
	self:addClickListener(handler(self, self._onClickBlankSpace))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._waitState = true

	self.m_lineUpList:setVirtual()
	self.m_lineUpList:setItemRenderer(handler(self, self._onRenderLineUpList))
end

function ArenaChallengeConfirmPop:_getLineUpKnights(arg_3_1)
	local var_3_0 = {}

	if arg_3_1.robot_type and arg_3_1.robot_type > 0 then
		local var_3_1 = var_0_1.get(arg_3_1.base_id)

		for iter_3_0 = 1, var_0_0 do
			if var_0_1.hasKey("knight_id_" .. iter_3_0) and var_3_1["knight_id_" .. iter_3_0] > 0 then
				table.insert(var_3_0, var_3_1["knight_id_" .. iter_3_0])
			end
		end
	else
		var_3_0 = arg_3_1.knights or {}
	end

	local var_3_2 = {}

	for iter_3_1 = 1, var_0_0 do
		if var_3_0[iter_3_1] and var_3_0[iter_3_1] > 0 then
			local var_3_3 = var_0_2.get(var_3_0[iter_3_1])
			local var_3_4 = KnightStruct.new(var_3_3.advance_id)

			var_3_4:addCfgInfo(var_3_3)

			var_3_2[iter_3_1] = var_3_4
		end
	end

	return var_3_2
end

function ArenaChallengeConfirmPop:_onRenderLineUpList(arg_4_1, arg_4_2)
	if self._knightStructArr[arg_4_1 + 1] then
		arg_4_2:updateComp(arg_4_1 + 1, {
			struct = self._knightStructArr[arg_4_1 + 1]
		}, true)
	else
		arg_4_2:updateComp(arg_4_1 + 1, nil, true)
	end
end

function ArenaChallengeConfirmPop:onLoad()
	self.m_nameTxt:setText((g.core.utils.String.transRobotName(self._challengeData.user)))
	self.m_powerTxt:setText(self._challengeData.user.fight_value)
	self.m_rankTxt:setText(self._challengeData.rank)
	self.m_knightPicComp:updateKnight({
		snapshot = self._challengeData.user
	})
	self.m_lineUpList:setNumItems(var_0_0)
	self:setTouchable(false)
	self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
end

function ArenaChallengeConfirmPop:_onEnterAnimEnd()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end

	self:setTouchable(true)
end

function ArenaChallengeConfirmPop:_onFight()
	if not self._challengeData then
		return
	end

	local var_7_0 = self._challengeData.rank

	g.core.model.User.arenaData:setChallengeRank(self._challengeData.rank)
	g.core.network.GameNetProxy:send_C2S_Arena_ChallengeBegin({
		rank = var_7_0
	})
	self:_onClickBlankSpace()
end

function ArenaChallengeConfirmPop:_onClickBlankSpace()
	self:setTouchable(false)
	self.m_backTransition:play(function()
		self:removeSelf()
	end)
end

function ArenaChallengeConfirmPop:onUnload()
	if self._waitState then
		self._waitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

return ArenaChallengeConfirmPop
