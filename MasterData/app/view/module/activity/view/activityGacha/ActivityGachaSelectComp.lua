local ActivityGachaSelectComp = class("ActivityGachaSelectComp", require("app.fairyGUI.activity.UI_ActivityGachaSelectComp"))

function ActivityGachaSelectComp:updateSelComp(arg_1_1, arg_1_2)
	self.m_typeController:setSelectedIndex(arg_1_2)
	self.m_itemIcon:setURL(arg_1_1.bigIcon or arg_1_1.pic)
	self.m_nameTxt:setText(arg_1_1.name)
	self.m_numTxt:setText("x" .. arg_1_1.size)
	self.m_fragImg:setVisible(arg_1_1.is_frag)
end

return ActivityGachaSelectComp
