local BlazingArenaEmbryoIconComp = class("BlazingArenaEmbryoIconComp", require("app.fairyGUI.blazingArena.UI_BlazingArenaEmbryoIconComp"))

function BlazingArenaEmbryoIconComp:ctor()
	self._compName = ""
	self._iconComp = nil

	self:addClickListener(handler(self, self.onClick))
end

function BlazingArenaEmbryoIconComp:_checkAndGetComp(arg_2_1)
	local var_2_1 = g.core.common.Goods.TYPE_KNIGHT == arg_2_1 and "BlazingArenaEmbryoKnightIcon" or "BlazingArenaEmbryoOtherIcon"

	if self._compName == (g.core.common.Goods.TYPE_KNIGHT == arg_2_1 and "BlazingArenaEmbryoKnightIcon" or "BlazingArenaEmbryoOtherIcon") then
		return
	end

	self.m_iconHoldComp:removeChildren()

	self._compName = var_2_1
	self._iconComp = fgui.UIPackage:createObject("blazingArena", self._compName)

	self.m_iconHoldComp:addChild(self._iconComp)
end

function BlazingArenaEmbryoIconComp:updateIconComp(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:_checkAndGetComp(arg_3_1)
	self._iconComp:updateIconComp(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
end

function BlazingArenaEmbryoIconComp:updateIcon(arg_4_1)
	if not arg_4_1 or arg_4_1.empty then
		return
	end

	local var_4_0 = g.core.common.Goods.TYPE_KNIGHT
	local var_4_2

	arg_4_1, var_4_2 = self:_checkAndFixParams(arg_4_1)

	if not var_4_2 then
		self:updateIconComp(var_4_0, arg_4_1.value, arg_4_1.level, arg_4_1.advanceStage)
	else
		self:updateIconCompWithStruct(var_4_0, var_4_2)
	end
end

function BlazingArenaEmbryoIconComp:_checkAndFixParams(arg_5_1)
	local var_5_0 = arg_5_1.struct

	self._info = nil

	local var_5_1 = arg_5_1.baseId
	local var_5_2 = arg_5_1.info

	if arg_5_1.info then
		var_5_1 = var_5_2.id
	end

	if arg_5_1.sid then
		var_5_0 = g.core.model.User.knightsData:getKnight({
			id = arg_5_1.sid
		})
	elseif arg_5_1.advanceId then
		var_5_0 = g.core.model.User.knightsData:getKnight({
			advance_id = arg_5_1.advanceId
		})
	elseif var_5_1 then
		var_5_0 = g.core.model.User.knightsData:getKnight({
			base_id = var_5_1
		})
	end

	var_5_2 = var_5_2 or var_5_0:getBaseInfo()
	arg_5_1.value = arg_5_1.value or var_5_2.id

	return arg_5_1, var_5_0
end

function BlazingArenaEmbryoIconComp:setShowInfoEnable()
	return
end

function BlazingArenaEmbryoIconComp:updateIconCompWithStruct(arg_7_1, arg_7_2)
	self:_checkAndGetComp(arg_7_1)
	self._iconComp:updateIconCompWithStruct(arg_7_1, arg_7_2)
end

function BlazingArenaEmbryoIconComp:onClick()
	self._iconComp:showDetailPop()
end

function BlazingArenaEmbryoIconComp:setLevel(arg_9_1)
	if self._iconComp then
		self._iconComp:setLevel(arg_9_1)
	end
end

return BlazingArenaEmbryoIconComp
