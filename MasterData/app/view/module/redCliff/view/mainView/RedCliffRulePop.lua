local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.chibi_guide_info
local RedCliffRulePop = class("RedCliffRulePop", require("app.fairyGUI.redCliff.UI_RedCliffRulePop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffRulePop",
		pkgPath = "ui/redCliff/redCliff",
		pkgName = "redCliff"
	}, ...)
end)

function RedCliffRulePop:ctor()
	self:showAtCenter()

	self._curIdx = 1
	self._maxSize = var_0_1.getLength()

	self.m_leftArrow:setVisible(false)
	self.m_leftArrow:addClickListener(handler(self, self._onClickLeftArrow))
	self.m_rightArrow:addClickListener(handler(self, self._onClickRightArrow))
	self:_updateView()
end

function RedCliffRulePop:_onClickLeftArrow()
	self._curIdx = self._curIdx - 1

	self:_updateView()
end

function RedCliffRulePop:_onClickRightArrow()
	self._curIdx = self._curIdx + 1

	self:_updateView()
end

function RedCliffRulePop:_updateView()
	local var_5_0 = var_0_1.fetch(self._curIdx)

	if var_5_0 then
		self.m_descPic:setURL(var_0_0:getRedCliffExplainPic(var_5_0.pic))
		self.m_title:setText(var_5_0.title)
		self.m_desc:setTitle(var_5_0.text)
	end

	self.m_leftArrow:setVisible(self._curIdx > 1)
	self.m_rightArrow:setVisible(self._curIdx < self._maxSize)
end

function RedCliffRulePop:onUnload()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RED_CLIFF_APPLY_GUIDE) then
		if g.core.model.User.redCliffData:isApply() then
			g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.RED_CLIFF_APPLY_GUIDE)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.RED_CLIFF_APPLY_GUIDE)
		end
	end
end

return RedCliffRulePop
