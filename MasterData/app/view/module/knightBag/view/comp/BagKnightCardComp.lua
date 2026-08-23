local BagKnightCardComp = class("BagKnightCardComp", require("app.fairyGUI.knightBag.UI_BaseKnightCardComp"))
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = {
	lineUp = 1,
	canCompose = 2,
	isAwaking = 4,
	null = 0,
	canStarUp = 3
}

function BagKnightCardComp:ctor(arg_1_1)
	self._caCompose = false
	self._state = 0
	self._showBlink = true
	self._group = nil

	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)
	self:addClickListener(handler(self, self._onClick), 1)
end

function BagKnightCardComp:updateCell(arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_1 then
		return
	end

	self._knight = arg_2_1
	self._baseInfo = arg_2_1:getBaseInfo()
	self._group = arg_2_3

	self.m_picComp:updatePic(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, true, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = self._knight:getAdvanceId()
		}
	})
	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(self._baseInfo.classical))
	self.m_leaderLoader:setVisible(arg_2_1:isElementLeader())

	local var_2_0 = arg_2_1:isMain() and g.core.model.User:getName() or self._baseInfo.name

	self.m_stateController:setSelectedIndex(var_0_4.null)

	if arg_2_1:isOwn() then
		self.m_isOwnController:setSelectedIndex(1)

		if arg_2_1:canStarUp() then
			self.m_stateController:setSelectedIndex(var_0_4.canStarUp)
		elseif arg_2_1:isLineup() then
			self.m_stateController:setSelectedIndex(var_0_4.lineUp)
		end

		self.m_nameText:setText(var_2_0)
		self.m_starComp:initStar({
			index = 3,
			style = 2,
			gap = -5,
			num = self._baseInfo.star
		})
		self.m_levelText:setText(arg_2_1:getInfo().level)

		local var_2_1, var_2_2 = var_0_1:getAdvStageAndLevelById(self._baseInfo.id)

		if var_2_1 > 0 then
			self.m_hasAdvanceController:setSelectedIndex(1)
			self.m_advLevelText:setText("+" .. var_2_1)
		else
			self.m_hasAdvanceController:setSelectedIndex(0)
			self.m_advLevelText:setText("")
		end

		self.m_weddingFrameComp:updateCompByKnight(arg_2_1)
	else
		self.m_isOwnController:setSelectedIndex(0)
		self.m_nameText2:setText(var_2_0)

		local var_2_3, var_2_4, var_2_5 = arg_2_1:canCompose()

		self._caCompose = var_2_3

		if var_2_3 then
			self.m_stateController:setSelectedIndex(var_0_4.canCompose)
			self.m_fragNumText:setText(g.core.lang:get(201018, {
				num = var_2_4,
				maxNum = var_2_5
			}))
		else
			self.m_fragNumText:setText(g.core.lang:get(201017, {
				num = var_2_4,
				maxNum = var_2_5
			}))
		end
	end

	if arg_2_2 then
		self.m_stateController:setSelectedIndex(arg_2_2)
	end
end

function BagKnightCardComp:_onClick()
	if not self._knight then
		return
	end

	local var_3_0 = self.m_stateController:getSelectedIndex()

	if var_3_0 == var_0_4.canCompose then
		g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
			num = 1,
			id = self._baseInfo.fragment_id
		})
	elseif var_3_0 == var_0_4.canStarUp and var_0_2:isModuleUnlock(var_0_3.FUNCTION_TYPE.KNIGHT_STAR_UP) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_DEVELOP, {
			index = 2,
			knightSid = self._knight:getServerId(),
			group = self._group
		})
	elseif var_3_0 == var_0_4.isAwaking then
		-- block empty
	elseif self._knight:isOwn() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.KNIGHT_DEVELOP, {
			knightSid = self._knight:getServerId(),
			group = self._group
		})
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.knight.view.infoPop.KnightInfoPop").new({
			knightAdvId = self._knight:getAdvanceId()
		}), {
			withoutAni = true
		})
	end
end

function BagKnightCardComp:setReborn()
	self.m_redPointComp:setVisible(false)
end

return BagKnightCardComp
