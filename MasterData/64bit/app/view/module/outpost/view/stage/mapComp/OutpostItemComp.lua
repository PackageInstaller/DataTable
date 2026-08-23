local var_0_0 = g.core.config.outpost_parameter_info
local var_0_1 = g.core.model.User.outpostData
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.const.ConstMgr.outpostConst
local OutpostItemComp = class("OutpostItemComp", require("app.fairyGUI.outpost.UI_OutpostItemComp"))

function OutpostItemComp:ctor()
	self._objType = var_0_3.EntityType.Drop
	self._virtualObj = nil
	self._mainCity = var_0_1:getBuildData():getBuild({
		type = var_0_3.BuildType.Main
	})
	self._limitLevel = var_0_0.get(var_0_3.WorldParam.OneKeyGetDrop).parameter

	self:addClickListener(handler(self, self._onClickGetDrop))
end

function OutpostItemComp:_onClickGetDrop()
	if self._virtualObj then
		if self._mainCity and self._mainCity:getLevel() >= self._limitLevel then
			g.core.network.GameNetProxy:send_C2S_Outpost_OneKeyClickDrop({})
		else
			g.core.network.GameNetProxy:send_C2S_Outpost_Map_ClickDrop({
				map_tp = self._virtualObj:getMapType(),
				seq = self._virtualObj.svrData.seq,
				target_x = self._virtualObj.svrData.pos_x,
				target_y = self._virtualObj.svrData.pos_y
			})
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_ItemPickUp)
	end
end

function OutpostItemComp:resetComp()
	self._virtualObj = nil

	self:setTouchable(true)
end

function OutpostItemComp:getEntityType()
	return self._objType
end

function OutpostItemComp:updateEntityShowParam(arg_5_1)
	self._virtualObj = arg_5_1
	self._objType = arg_5_1.entityType

	self.m_bgLoader:setURL(var_0_2:getOutpostItemQualityBg(arg_5_1.itemInfo.quality))
	self.m_itemIcon:setURL(var_0_2:getOutpostItemIcon(arg_5_1.itemInfo.icon, true))
end

function OutpostItemComp:playDropTran()
	self.m_dropTransition:play()
end

return OutpostItemComp
