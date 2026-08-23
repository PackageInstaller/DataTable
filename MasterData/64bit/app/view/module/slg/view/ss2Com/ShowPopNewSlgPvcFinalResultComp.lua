local ShowPopNewSlgPvcFinalResultComp = class("ShowPopNewSlgPvcFinalResultComp")

function ShowPopNewSlgPvcFinalResultComp:ctor()
	self._txtLeaderName = self:getChild("Txt_leaderName")
	self._compBuildingInfo = self:getChild("Comp_buildingInfo")
	self._listAward = self:getChild("List_award")

	self._listAward:setVirtual(self)
	self._listAward:setItemRenderer(handler(self, self._onRenderListAwardCell))

	self._txtAllianceName = self:getChild("Txt_allianceName")
	self._txtDesc = self:getChild("Txt_desc")
end

function ShowPopNewSlgPvcFinalResultComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, handler(self, self.onUpdateAlliSnapShot), self)
end

function ShowPopNewSlgPvcFinalResultComp:update(arg_3_1)
	self._params = arg_3_1 or self._params

	local var_3_0 = arg_3_1.result
	local var_3_1 = arg_3_1.result.city_battle_result

	self._compBuildingInfo:updateView((g.core.model.User.newSlgData:getCityComponentById(arg_3_1.result.city_battle_result.city_id)))

	local var_3_2 = var_3_1.final_alli_rank or 0

	if var_3_2 == 1 then
		self._txtDesc:setText(g.core.lang:get(429015))
	else
		self._txtDesc:setText(g.core.lang:get(429016, {
			rank = var_3_2
		}))
	end

	self._awards = var_3_0.awards or {}

	self._listAward:setNumItems(#self._awards)

	local var_3_3 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_3_1.final_winner_alliance_id)

	if var_3_3 then
		self._txtAllianceName:setText(var_3_3.name)
		self._txtLeaderName:setText(var_3_3.leader_name)
	end
end

function ShowPopNewSlgPvcFinalResultComp:onUpdateAlliSnapShot()
	self:update(self._params)
end

function ShowPopNewSlgPvcFinalResultComp:_onRenderListAwardCell(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._awards[arg_5_1 + 1])
end

return ShowPopNewSlgPvcFinalResultComp
