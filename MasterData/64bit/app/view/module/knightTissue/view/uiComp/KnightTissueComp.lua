local KnightTissueComp = class("KnightTissueComp", require("app.fairyGUI.knightTissue.UI_KnightTissueComp"))
local var_0_1 = g.core.model.User.knightTissueData
local var_0_2 = g.core.common.Path

function KnightTissueComp:ctor()
	self._collectNum = 0
	self._tissueInfo = nil

	self:_registerListener()
end

function KnightTissueComp:_registerListener()
	self:addClickListener(handler(self, self._onClick))
end

function KnightTissueComp:updateView(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._tissueInfo = arg_3_1
	self._collectNum = var_0_1:getTissueCollectCountById(arg_3_1.id)

	self.m_tissueNameTxt:setText(arg_3_1.name)
	self.m_curNumTxt:setText(tostring(self._collectNum))
	self.m_totalNumTxt:setText(g.core.lang:get(111903, {
		num = arg_3_1.num
	}))
	self.m_tissueLoader:setURL(var_0_2:getKnightTissuePic(arg_3_1.icon))
	self.m_areaController:setSelectedIndex(tonumber(arg_3_1.icon_bg))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			id = self._tissueInfo.id
		}
	})
end

function KnightTissueComp:_onClick(arg_4_1)
	arg_4_1:stopPropagation()
	self:addPopup(require("app.view.module.knightTissue.view.tissuePop.KnightTissueDetailsPop").new({
		info = self._tissueInfo
	}), {
		touchDisappear = true,
		hideContinue = true
	})
end

return KnightTissueComp
