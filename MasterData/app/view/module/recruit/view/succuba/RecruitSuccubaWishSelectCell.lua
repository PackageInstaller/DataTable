local RecruitSuccubaWishSelectCell = class("RecruitSuccubaWishSelectCell", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaWishSelectCell"))

function RecruitSuccubaWishSelectCell:ctor()
	return
end

function RecruitSuccubaWishSelectCell:updateItem(arg_2_1, arg_2_2)
	self.m_item:updateIcon({
		type = g.core.common.Goods.TYPE_SUCCUBA,
		value = arg_2_1.value
	})
	self.m_stateController:setSelectedIndex(arg_2_2 and 1 or 0)
end

return RecruitSuccubaWishSelectCell
