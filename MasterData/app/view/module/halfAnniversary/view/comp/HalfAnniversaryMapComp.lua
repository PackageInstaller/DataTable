local var_0_0 = g.core.model.User.halfAnniversaryData
local var_0_1 = g.core.const.ConstMgr.HalfAnniversaryConst
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.common.Goods
local Route = require("app.core.common.Route")
local HalfAnniversaryMapComp = class("HalfAnniversaryMapComp", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryMapComp"))

function HalfAnniversaryMapComp:ctor()
	self:_initMapPointCfg()
	self:_initEnterMapRolePos()
end

function HalfAnniversaryMapComp:_initMapPointCfg()
	self._allPointPos = {}

	for iter_2_0 = 1, var_0_1.POINT_MAIN do
		for iter_2_1 = 1, var_0_1.POINT_SUB do
			if self["m_pos" .. iter_2_0 .. iter_2_1] then
				table.insert(self._allPointPos, {
					pos = self["m_pos" .. iter_2_0 .. iter_2_1]:getPosition(),
					mainPos = iter_2_0,
					subPos = iter_2_1,
					isAwardPos = checkbool(iter_2_1 == 1)
				})
			end
		end
	end
end

function HalfAnniversaryMapComp:_initEnterMapRolePos()
	self._activityCfg = var_0_0:getHalfYearActivityCfg()

	self.m_bgLoader:setURL("bg/activity/" .. self._activityCfg.bg .. ".jpg")

	local var_3_0, var_3_1 = var_0_0:getEnterMapStartPos()

	self.m_roleComp:setPosition((self["m_pos" .. var_3_0 .. var_3_1]:getPosition()))

	local var_3_2 = self:getRoleRouteIndex()

	if var_3_2 > 0 and self._allPointPos[var_3_2].isAwardPos then
		self.m_roleComp:playAwardPosEffect()
	end
end

function HalfAnniversaryMapComp:updatePointView()
	local var_4_0 = var_0_0:getMapPointAwardsCfg()

	for iter_4_0 = 1, #var_4_0 do
		self["m_pointComp" .. iter_4_0]:updatePointComp(var_4_0[iter_4_0], iter_4_0)
		self["m_pointComp" .. iter_4_0]:setVisible(true)
	end

	local var_4_1 = self:getRoleRouteIndex()

	if var_4_1 > 0 then
		if self._allPointPos[var_4_1].isAwardPos then
			self["m_pointComp" .. self._allPointPos[var_4_1].mainPos]:setVisible(false)
		end
	end
end

function HalfAnniversaryMapComp:_getPointInRouteIndex(arg_5_1, arg_5_2)
	local var_5_0 = self["m_pos" .. arg_5_1 .. arg_5_2]:getPosition()
	local var_5_1 = 1

	for iter_5_0, iter_5_1 in ipairs(self._allPointPos) do
		if iter_5_1.pos.x == var_5_0.x and iter_5_1.pos.y == var_5_0.y then
			var_5_1 = iter_5_0
		end
	end

	return var_5_1
end

function HalfAnniversaryMapComp:getRoleRouteIndex()
	local var_6_0 = self.m_roleComp:getPosition()
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(self._allPointPos) do
		if iter_6_1.pos.x == var_6_0.x and iter_6_1.pos.y == var_6_0.y then
			var_6_1 = iter_6_0
		end
	end

	return var_6_1
end

function HalfAnniversaryMapComp:queryKnightCanMove()
	local var_7_0, var_7_1 = var_0_0:getMovePosByScore((var_0_2:getCountById(var_0_3.TYPE_ITEM, self._activityCfg.item_id)))
	local var_7_2 = self:createMoveRouteArrays(var_7_0, var_7_1)

	if var_7_2 and next(var_7_2) then
		self.m_roleComp:removeAllEffect()
		Route.new(self.m_roleComp, var_7_2):moveContinue({
			speed = 1.4,
			isAnim = true,
			finishFunc = handler(self, function()
				self:checkCanGetAwards()
				self:updatePointView()
			end)
		})
	end
end

function HalfAnniversaryMapComp:createMoveRouteArrays(arg_9_1, arg_9_2)
	local var_9_0 = self:getRoleRouteIndex()

	if var_9_0 == 0 then
		return
	end

	local var_9_1 = self:_getPointInRouteIndex(self._allPointPos[var_9_0].mainPos, self._allPointPos[var_9_0].subPos)
	local var_9_2 = self:_getPointInRouteIndex(arg_9_1, arg_9_2)

	if var_9_1 == var_9_2 or var_9_2 < var_9_1 then
		return
	end

	local var_9_3 = {}

	for iter_9_0 = var_9_1, var_9_2 do
		table.insert(var_9_3, {
			x = self._allPointPos[iter_9_0].pos.x,
			y = self._allPointPos[iter_9_0].pos.y
		})

		if var_9_1 < iter_9_0 and self._allPointPos[iter_9_0].isAwardPos then
			break
		end
	end

	return var_9_3
end

function HalfAnniversaryMapComp:checkCanGetAwards()
	if g.core.module.ModuleManager:getCurModule().module ~= g.view.entrance.HALF_ANNIVERSARY then
		return
	end

	local var_10_1 = self:getRoleRouteIndex()

	if var_10_1 == 0 then
		return
	end

	if g.core.model.User.storyData:isInStory() then
		return
	end

	local var_10_2 = self._allPointPos[var_10_1]

	self._curawardInfo = var_0_0:getMapPointAwardsCfg()[self._allPointPos[var_10_1].mainPos]

	if var_10_2.isAwardPos then
		self._avgId = self._curawardInfo.avg_id

		if not var_0_0:isGetScoreAward(self._curawardInfo.id) then
			if self._avgId > 0 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
					id = self._avgId
				})
			else
				self:_getScoreAward()
			end
		else
			self:queryKnightCanMove()
		end
	else
		self:queryKnightCanMove()
	end
end

function HalfAnniversaryMapComp:updateByStoryEnd(arg_11_1)
	if arg_11_1.trigger_type == "EVENT_STORY_FORCE_START" and arg_11_1.trigger_data and arg_11_1.trigger_data.id == self._avgId then
		self:_getScoreAward()
	end
end

function HalfAnniversaryMapComp:_getScoreAward()
	self.m_roleComp:playAwardPosEffect()
	self.m_roleComp:playGetAwardEffect(handler(self, self._getAwards))
end

function HalfAnniversaryMapComp:_getAwards()
	if var_0_2:getCountById(var_0_3.TYPE_ITEM, self._activityCfg.item_id) >= self._curawardInfo.need_point and not var_0_0:isGetScoreAward(self._curawardInfo.id) then
		g.core.network.GameNetProxy:send_C2S_Welfarefund_GetScoreAward({
			id = self._curawardInfo.id
		})
	end
end

return HalfAnniversaryMapComp
