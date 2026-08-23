local var_0_0 = g.core.model.User.halfAnniversaryData
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.model.User.bagData
local HalfAnniversaryScoreComp = class("HalfAnniversaryScoreComp", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryScoreComp"))

function HalfAnniversaryScoreComp:updateScore()
	local var_1_0 = var_0_0:getHalfYearActivityCfg()
	local var_1_1 = var_0_1:convert({
		type = var_0_1.TYPE_ITEM,
		value = var_1_0.item_id
	})

	if var_1_1 then
		self.m_iconLoader:setURL(var_1_1.icon_mini)
		self.m_itemNumTxt:setText((var_0_2:getCountById(var_0_1.TYPE_ITEM, var_1_0.item_id)))
		self.m_curItemTxt:setText(g.core.lang:get(408205, {
			itemStr = var_1_1.name
		}))
	end

	self.m_typeController:setSelectedIndex(var_1_0.id)
end

return HalfAnniversaryScoreComp
