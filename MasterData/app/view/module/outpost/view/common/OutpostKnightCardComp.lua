local OutpostKnightCardComp = class("OutpostKnightCardComp", require("app.fairyGUI.outpost.UI_OutpostKnightCardComp"))

function OutpostKnightCardComp:ctor()
	return
end

function OutpostKnightCardComp:updateKnightWithStruct(arg_2_1)
	self.m_levelTxt:setText(arg_2_1:getLevel())

	local var_2_0 = arg_2_1:getCfg()

	self.m_elemLoader:setURL(g.core.common.Path:getKnightElementIcon(var_2_0.classical))
	self.m_nameTxt:setText(arg_2_1:getCfg().name)
	self.m_fightValueTxt:setText(arg_2_1:getSelfFightValue())
	self.m_knightLabel:setIcon(g.core.common.Path:getKnightBookPicRes(var_2_0.advance_id))
	self.m_qualityLoader:setURL("ui://base_new/pic_yht_pinzhi_" .. var_2_0.quality + 1)
	self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. var_2_0.profession)
end

return OutpostKnightCardComp
