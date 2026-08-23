local var_0_0 = g.core.const.ConstMgr.PetConst
local PetInfoPopAssctComp = class("PetInfoPopAssctComp", require("app.fairyGUI.pet.UI_PetInfoPopAssctComp"))

function PetInfoPopAssctComp:ctor()
	self._linkKnightData = nil
	self._petAdvId = nil

	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync1(handler(self, self._onDescItemRenderer), nil, true)
end

function PetInfoPopAssctComp:updateShow(arg_2_1)
	self._petAdvId = arg_2_1:getAdvanceId()
	self._linkKnightData = arg_2_1:getLinkKnightData()

	local var_2_0 = 0

	if self._linkKnightData[1].isActivated and arg_2_1:isOwn() then
		var_2_0 = 1
	end

	self.m_starComp:initStar({
		index = 1,
		style = 2,
		num = var_2_0,
		max = var_0_0.MAX_LINK_NUM
	})
	self.m_starComp:addStarEffect(var_2_0, {
		name = "eff_ui_lineup_bind",
		scale = 1,
		isLoop = true
	})
	self.m_descList:setNumItems(var_0_0.MAX_LINK_NUM)
end

function PetInfoPopAssctComp:_onDescItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateComp({
		petAdvId = self._petAdvId,
		assData = self._linkKnightData[arg_3_1 + 1]
	})
end

return PetInfoPopAssctComp
