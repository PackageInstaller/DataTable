local NewSlgSkillTreePointLastComp = class("NewSlgSkillTreePointLastComp", require("app.fairyGUI.newSlg.UI_NewSlgSkillTreePointLastComp"))

function NewSlgSkillTreePointLastComp:ctor()
	self:updateExPoint()
	self.m_loaderBtn:addClickListener(handler(self, self._onPointInfoClick))
end

function NewSlgSkillTreePointLastComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYACTIVATE, self.updateExPoint, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYRESET, self.updateExPoint, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYACTIVATEONEKEY, self.updateExPoint, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYUPDATE, self.updateExPoint, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, self.updateExPoint, self)
end

function NewSlgSkillTreePointLastComp:updateExPoint()
	self.m_pointTxt:setText((g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_RESOURCE, g.core.const.ConstMgr.NewSlgConst.TECHNOLOGY_POINT_VALUE)))
end

function NewSlgSkillTreePointLastComp:_onPointInfoClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.skillTree.NewSlgSkillTreeTalentPointPop").new({
		type = 1
	}))
end

return NewSlgSkillTreePointLastComp
