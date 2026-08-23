local PlotReplayMainCell = class("PlotReplayMainCell", require("app.fairyGUI.plotReplay.UI_PlotReplayMainCell"))
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.PlotReplayConst

function PlotReplayMainCell:ctor()
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)

	self._iconStateControl = self.m_infoLabel:getController("type")
end

function PlotReplayMainCell:updateView(arg_2_1)
	if arg_2_1.info.openStageNum == 0 and not (g.core.common.Storage:load("ignorePlotReview.json", false) or {}).open then
		self.m_lockController:setSelectedIndex(0)

		return
	else
		self.m_lockController:setSelectedIndex(1)
	end

	local var_2_1 = arg_2_1.allNum or 0

	self.m_typeController:setSelectedIndex(arg_2_1.type - 1)

	local var_2_2 = g.core.model.User.plotReplayReviewData:getGrowthInfoByTypeAndChapter(arg_2_1.type, arg_2_1.info.info.id)

	self.m_infoLabel:setTitle(arg_2_1.info.info.name .. " " .. arg_2_1.curNum .. "/" .. var_2_1)
	self.m_infoLabel:setIcon("")

	if not var_2_2 then
		return
	end

	if arg_2_1.type == var_0_2.MAIN then
		self._iconStateControl:setSelectedIndex(0)
		self.m_infoLabel:setIcon(var_0_1:getStoryReplayCellPic(var_2_2.res))
	elseif arg_2_1.type == var_0_2.THEME then
		self._iconStateControl:setSelectedIndex(0)
		self.m_infoLabel:setIcon(var_0_1:getThemeReplayCellPic(var_2_2.res))
	elseif arg_2_1.type == var_0_2.THEME_BIO then
		self._iconStateControl:setSelectedIndex(0)
		self.m_infoLabel:setIcon(var_0_1:getThemeReplayCellPic(var_2_2.res))
	else
		self._iconStateControl:setSelectedIndex(1)
		self.m_infoLabel:setIcon(var_0_1:getMiddleKnightPicById(var_2_2.res))
	end
end

return PlotReplayMainCell
