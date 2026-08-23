local RoleSkinStageTalentTip = class("RoleSkinStageTalentTip", require("app.fairyGUI.tip.UI_RoleSkinStageTalentTip"), function()
	return fgui.GComponent:create({
		resName = "RoleSkinStageTalentTip",
		pkgPath = "ui/tip/tip",
		pkgName = "tip"
	})
end)

function RoleSkinStageTalentTip:ctor(arg_2_1)
	self:showAtCenter()

	self._struct = arg_2_1
	self._talentList = {}

	self.m_talentList:setVirtual()
	self.m_talentList:setItemRenderer(handler(self, self._onRenderTalentList))
end

function RoleSkinStageTalentTip:onLoad()
	self:updateComp()
end

function RoleSkinStageTalentTip:updateComp()
	self._talentList = self._struct:getStageTalentArr()

	self.m_talentList:setNumItems(#self._talentList)
end

function RoleSkinStageTalentTip:_onRenderTalentList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._talentList[arg_5_1 + 1], self._talentList[arg_5_1 + 1].stage <= self._struct:getStage(), true)
end

return RoleSkinStageTalentTip
