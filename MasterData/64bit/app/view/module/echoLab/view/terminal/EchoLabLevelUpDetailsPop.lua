local var_0_0 = g.core.model.User.echoLabData
local EchoLabLevelUpDetailsPop = class("EchoLabLevelUpDetailsPop", require("app.fairyGUI.echoLab.UI_EchoLabLevelUpDetailsPop"), function()
	return fgui.GComponent:create({
		resName = "EchoLabLevelUpDetailsPop",
		pkgName = "echoLab",
		pkgPath = "ui/echoLab/echoLab"
	}, ...)
end)

function EchoLabLevelUpDetailsPop:ctor()
	self:showAtCenter()
	self:_initRegisterUI()
	self:_initMainPopView()
end

function EchoLabLevelUpDetailsPop:_initRegisterUI()
	self._nextattrButes = {}

	self.m_nextLvAttrList:setVirtual()
	self.m_nextLvAttrList:setItemRenderer(handler(self, self._onNextLvAttrItemRenderer))
end

function EchoLabLevelUpDetailsPop:_initMainPopView()
	local var_4_0 = var_0_0:getPalaceId()
	local var_4_1 = var_0_0:getCoreMaxLevel()

	if var_4_1 <= var_4_0 then
		self.m_isMaxLvController:setSelectedIndex(1)
		self.m_maxLvTxt:setText(var_4_1)
	else
		self.m_isMaxLvController:setSelectedIndex(0)
		self.m_lvTxt:setText(var_4_0)
		self.m_alterNameTxt:setText(var_0_0:getTreeData():getMinNotActiveBigTalent():getName())

		self._nextattrButes = var_0_0:getAttriButesByCoreLevel(var_4_0 + 1)

		self.m_nextLvAttrList:setNumItems(#self._nextattrButes)
	end
end

function EchoLabLevelUpDetailsPop:_onNextLvAttrItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateAttrCell(self._nextattrButes[arg_5_1 + 1])
end

return EchoLabLevelUpDetailsPop
