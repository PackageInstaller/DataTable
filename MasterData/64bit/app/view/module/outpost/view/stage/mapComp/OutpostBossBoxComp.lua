local var_0_0 = g.core.common.ServerTime
local var_0_4 = g.core.const.ConstMgr.outpostConst
local OutpostBossBoxComp = class("OutpostBossBoxComp", require("app.fairyGUI.outpost.UI_OutpostBossBoxComp"))

function OutpostBossBoxComp:ctor()
	self._objType = var_0_4.EntityType.BossBox
	self._virtualObj = nil

	self:addClickListener(handler(self, self._onClickGetBossBox))
end

function OutpostBossBoxComp:_onClickGetBossBox()
	if self._virtualObj then
		self:setTouchable(false)
		g.core.network.GameNetProxy:send_C2S_Outpost_GetBossBox({
			box_id = self._virtualObj.svrData.id,
			area = self._virtualObj:getMapType()
		})
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ItemPickUp)
	end
end

function OutpostBossBoxComp:resetComp()
	self._virtualObj = nil

	self:setTouchable(true)
end

function OutpostBossBoxComp:getEntityType()
	return self._objType
end

function OutpostBossBoxComp:updateEntityShowParam(arg_5_1)
	self._virtualObj = arg_5_1
	self._objType = arg_5_1.entityType

	self:setTouchable(true)
	self.m_name:setText(arg_5_1.monsterInfo.name)
	self.m_isFirstController:setSelectedIndex(arg_5_1:getDropId() > 0 and 1 or 0)
	self:updateBoxTime()
end

function OutpostBossBoxComp:updateBoxTime()
	if not self._virtualObj then
		return
	end

	self.m_destroyTime:setText(var_0_0:getLeftMSFormat(self._virtualObj:getDestroyTime(), true))

	if not self.m_dropTransition:isPlaying() then
		self:playBossBoxShakeTran()
	end
end

function OutpostBossBoxComp:playBossBoxDropTran()
	self.m_dropTransition:play(handler(self, self.playBossBoxShakeTran))
end

function OutpostBossBoxComp:playBossBoxShakeTran()
	if not self.m_shakeTransition:isPlaying() then
		self.m_shakeTransition:play()
	end
end

return OutpostBossBoxComp
