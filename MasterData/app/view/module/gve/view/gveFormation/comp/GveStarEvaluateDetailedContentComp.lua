local var_0_0 = g.core.model.User.gveDataMgr
local GveStarEvaluateDetailedContentComp = class("GveStarEvaluateDetailedContentComp", require("app.fairyGUI.gve.UI_GveStarEvaluateDetailedContentComp"))
local var_0_2 = 3

function GveStarEvaluateDetailedContentComp:ctor()
	self._infoList = {}
	self._descList = {}

	self.m_starList:setIniter()
	self.m_starList:setItemRenderer(handler(self, self._onRendererStarList))
	self.m_descList:setIniter()
	self.m_descList:setItemRenderer(handler(self, self._onRendererDescList))
end

function GveStarEvaluateDetailedContentComp:_onRendererStarList(arg_2_1, arg_2_2)
	arg_2_2:setTitle(self._infoList[arg_2_1 + 1].name)
	arg_2_2:getController("isActive"):setSelectedIndex(1)
end

function GveStarEvaluateDetailedContentComp:_onRendererDescList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(arg_3_1 + 1, self._descList[arg_3_1 + 1])
end

function GveStarEvaluateDetailedContentComp:initComp(arg_4_1)
	self._infoList = arg_4_1 or {}

	self.m_starList:setNumItems(#self._infoList)
	self.m_starList:resizeToFit(#self._infoList)

	self._descList[1] = g.core.lang:get(309011, {
		num = var_0_0:getGveBaseCfg().action_cost
	})
	self._descList[2] = g.core.lang:get(309012, {
		num = var_0_0:getGveBaseCfg().rating_action_recover
	})
	self._descList[3] = g.core.lang:get(309013)

	self.m_descList:setNumItems(var_0_2)
	self.m_descList:resizeToFit(var_0_2)
end

return GveStarEvaluateDetailedContentComp
