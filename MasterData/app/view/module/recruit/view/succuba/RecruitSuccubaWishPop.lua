local var_0_0 = g.core.model.User.recruitData
local RecruitSuccubaWishPop = class("RecruitSuccubaWishPop", require("app.fairyGUI.recruitSuccuba.UI_RecruitSuccubaWishPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitSuccubaWishPop",
		pkgPath = "ui/recruitSuccuba/recruitSuccuba",
		isFullScreen = false,
		pkgName = "recruitSuccuba"
	}, ...)
end)

function RecruitSuccubaWishPop:ctor(arg_2_1)
	self:showAtCenter()

	self._cfg = arg_2_1.cfg
	self._ttPool = nil
	self._selIndex = 0

	self.m_closeBtn:addClickListener(handler(self, self._onClose))
	self.m_wishList:setVirtual()
	self.m_wishList:setItemRenderer(handler(self, self._onWishListRenderer))
	self.m_wishList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onItemClick))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmClick))
	self:updateWishView()
end

function RecruitSuccubaWishPop:onItemClick(arg_3_1)
	self._selIndex = self.m_wishList:getSelectedIndex()

	self.m_wishList:setNumItems(#self._ttPool)
	self:updateLeftShow()
end

function RecruitSuccubaWishPop:updateLeftShow()
	self.m_memberComp1:updateSuccuba({
		res = g.core.common.Path:getRecruitShowSuccubaIconById(self._ttPool[self._selIndex + 1].value),
		good = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_SUCCUBA,
			value = self._ttPool[self._selIndex + 1].value
		})
	})
end

function RecruitSuccubaWishPop:_onWishListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateItem(self._ttPool[arg_5_1 + 1], self._selIndex == arg_5_1)
end

function RecruitSuccubaWishPop:updateWishView()
	local var_6_0 = var_0_0:getSuccubaTotalNormalWishItems()
	local var_6_1 = var_0_0:getSuccubaNormalWish()

	if next(var_6_1) then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if iter_6_1.type == var_6_1[1].r_type and iter_6_1.value == var_6_1[1].r_value then
				self._selIndex = iter_6_0 - 1

				break
			end
		end
	end

	self._ttPool = var_6_0

	self.m_wishList:setNumItems(#var_6_0)
	self:updateLeftShow()
end

function RecruitSuccubaWishPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RecruitSuccubaWishPop:_onConfirmClick()
	local var_8_0 = var_0_0:getSuccubaNormalWish()

	if next(var_8_0) and self._ttPool[self._selIndex + 1].type == var_8_0[1].r_type and self._ttPool[self._selIndex + 1].value == var_8_0[1].r_value then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewRecruit_Luck({
		id = self._cfg.id,
		wish = {
			{
				pos = 1,
				r_type = self._ttPool[self._selIndex + 1].type,
				r_value = self._ttPool[self._selIndex + 1].value
			}
		}
	})
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return RecruitSuccubaWishPop
