local var_0_0 = g.core.model.User.outpostData
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostDoorComp = class("OutpostDoorComp", require("app.fairyGUI.outpost.UI_OutpostDoorComp"))

function OutpostDoorComp:ctor()
	self._objType = var_0_1.EntityType.Door
	self._basePos = self.m_buildIcon:getPosition()
	self._virtualObj = nil

	self:addClickListener(handler(self, self.onClickUnlock))
	self:getChild("n1"):addClickListener(handler(self, self.onClickGuideUnlock))
end

function OutpostDoorComp:getEntityType()
	return self._objType
end

function OutpostDoorComp:isDoor()
	return true
end

function OutpostDoorComp:updateEntityShowParam(arg_4_1)
	self.m_buildIcon:setScaleX(1)

	self._virtualObj = arg_4_1
	self._objType = arg_4_1.entityType

	local var_4_0 = arg_4_1:getDoorMapCfg()

	self:setName("DOOR_" .. var_4_0.map_type)

	if var_4_0.res == "190" then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end
end

function OutpostDoorComp:onClickUnlock()
	if not self._virtualObj then
		return
	end

	local var_5_0 = self._virtualObj:getDoorMapCfg()

	if var_0_0:checkIsCondAccept(var_5_0) then
		g.core.network.GameNetProxy:send_C2S_Outpost_Map_Unlock({
			map_tp = var_5_0.map_type
		})
		g.core.module.ModuleManager:tip(g.core.lang:get(432611))
	else
		g.core.module.ModuleManager:tip((var_0_0:getArenaUnlockTipStr(var_5_0)))
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Select_Explore_Gain)
end

function OutpostDoorComp:onClickGuideUnlock()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self:onClickUnlock()
	end
end

return OutpostDoorComp
