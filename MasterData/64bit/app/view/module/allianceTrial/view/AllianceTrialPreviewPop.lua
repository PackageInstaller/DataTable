local var_0_0 = g.core.model.User.allianceTrialData
local AllianceTrialPreviewPop = class("AllianceTrialPreviewPop", require("app.fairyGUI.allianceTrial.UI_AllianceTrialPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceTrialPreviewPop",
		pkgPath = "ui/allianceTrial/allianceTrial",
		pkgName = "allianceTrial"
	}, ...)
end)

function AllianceTrialPreviewPop:ctor(arg_2_1)
	self._level = arg_2_1.level
	self._awardList = {}

	self:showAtCenter()
	self:initView()
end

function AllianceTrialPreviewPop:initView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function AllianceTrialPreviewPop:_onRenderAwardList(arg_4_1, arg_4_2)
	arg_4_2:updatePreviewCell(self._awardList[arg_4_1 + 1])
end

function AllianceTrialPreviewPop:onLoad()
	self:updateView()
end

function AllianceTrialPreviewPop:updateView()
	self._awardList = var_0_0:getBoxInfoData(self._level).boxAwardList

	table.sort(self._awardList, function(arg_7_0, arg_7_1)
		if arg_7_0.box_type ~= arg_7_1.box_type then
			return arg_7_0.box_type < arg_7_1.box_type
		end

		return arg_7_0.sort < arg_7_1.sort
	end)
	self.m_awardList:setNumItems(#self._awardList)
end

return AllianceTrialPreviewPop
