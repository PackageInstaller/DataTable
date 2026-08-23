local CommonTalentPop = class("CommonTalentPop", require("app.fairyGUI.tip.UI_CommonTalentPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/tip/tip",
		resName = "CommonTalentPop",
		pkgName = "tip"
	})
end)

function CommonTalentPop:ctor(arg_2_1)
	self._talentData = arg_2_1 or {}
	self._talentList = self._talentData.talentList or {}

	self:showAtCenter()
	self:_initListView()
end

function CommonTalentPop:onLoad()
	self:updateView()
end

function CommonTalentPop:_initListView()
	self.m_talentList:setIniter()
	self.m_talentList:setItemRenderer(handler(self, self._onItemRenderer))
end

function CommonTalentPop:updateView()
	if self._talentData.title then
		self.m_bgPanel:setTitle(self._talentData.title)
	end

	self.m_talentList:setNumItems(#self._talentList)
end

function CommonTalentPop:_onItemRenderer(arg_6_1, arg_6_2)
	if self._talentList[arg_6_1 + 1] then
		arg_6_2:updateTalentCell(self._talentList[arg_6_1 + 1])
	end
end

return CommonTalentPop
