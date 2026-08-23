local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local BagNewArtifactCell = class("BagNewArtifactCell", require("app.fairyGUI.bagNew.UI_BagNewArtifactCell"))

function BagNewArtifactCell:ctor(arg_1_1)
	self.m_selectTrans = self:getSharedTrans("enter", "CommonSelected", self.m_selectIcon)
	self._isCanStarUp = false

	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)

	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelfSelectChanged))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function BagNewArtifactCell:_onTouchBegin()
	self._oldSelectIndex = self.m_buttonController:getSelectedIndex()
end

function BagNewArtifactCell:_onSelfSelectChanged()
	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if var_3_0 == 1 and self._oldSelectIndex ~= var_3_0 then
		self.m_selectTrans:play()
	end
end

function BagNewArtifactCell:updateIconView(arg_4_1)
	if arg_4_1 then
		self._data = arg_4_1

		self:_updateCell()
	end
end

function BagNewArtifactCell:_updateCell()
	local var_5_0 = self._data:isLineup()
	local var_5_1 = self._data:isOwn()
	local var_5_2 = self._data:canStarUp()

	self._isCanStarUp = var_5_2

	self.m_isWearController:setSelectedIndex(var_5_0 and 0 or 1)
	self.m_isStarUpController:setSelectedIndex(var_5_2 and 1 or 0)
	self.m_starComp:initStar({
		gap = -60,
		style = 2,
		index = 3,
		max = self._data:getMaxStar(),
		num = self._data:getStar()
	})
	self.m_iconComp:updateIcon(self._data)

	if var_5_0 and self.m_knightIcon then
		self.m_knightIcon:setIcon((self._data:getWearKnightIconUrl()))
	end
end

return BagNewArtifactCell
