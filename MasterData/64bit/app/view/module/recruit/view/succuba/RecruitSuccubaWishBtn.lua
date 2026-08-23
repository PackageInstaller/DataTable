local var_0_0 = g.core.model.User.recruitData
local RecruitSuccubaWishBtn = class("RecruitSuccubaWishBtn", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaWishBtn"))

function RecruitSuccubaWishBtn:updateSuccubaWish()
	local var_1_0 = var_0_0:getSuccubaNormalWish()

	if next(var_1_0) then
		self.m_itemIcon:updateIcon({
			type = g.core.common.Goods.TYPE_SUCCUBA,
			value = var_1_0[1].r_value
		})
	else
		local var_1_1 = {
			type = g.core.common.Goods.TYPE_SUCCUBA
		}

		var_1_1.value = var_0_0:getSuccubaTotalNormalWishItems()[1].value

		self.m_itemIcon:updateIcon(var_1_1)
	end
end

return RecruitSuccubaWishBtn
