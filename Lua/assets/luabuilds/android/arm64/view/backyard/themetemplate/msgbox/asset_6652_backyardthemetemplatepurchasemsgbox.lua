local BackYardThemeTemplatePurchaseMsgbox = class("BackYardThemeTemplatePurchaseMsgbox", import("...Shop.msgbox.BackYardThemeMsgBoxPage"))

function BackYardThemeTemplatePurchaseMsgbox:SetUp(arg_1_1, arg_1_2, arg_1_3)
	self.dorm = arg_1_2
	self.template = arg_1_1
	self.player = arg_1_3
	self.count = 1
	self.maxCount = 1

	self:UpdateMainInfo()
	self:UpdateBtns()
	self:UpdatePrice()
	self:Show()

	self.purchase.text = i18n("purchase_backyard_theme_desc_for_onekey")

	setText(self.goldPurchaseBtn:Find("content/Text"), i18n("fur_onekey_buy"))

	return
end

function BackYardThemeTemplatePurchaseMsgbox:UpdateMainInfo()
	self.nameTxt.text = self.template:GetName()
	self.descTxt.text = self.template:GetDesc()

	setActive(self.icon.gameObject, false)
	setActive(self.rawIcon.gameObject, false)
	BackYardThemeTempalteUtil.GetTexture(self.template:GetTextureIconName(), self.template:GetIconMd5(), function(arg_3_0)
		if not IsNil(self.rawIcon) and arg_3_0 then
			setActive(self.rawIcon.gameObject, true)

			self.rawIcon.texture = arg_3_0
		end

		return
	end)

	return
end

function BackYardThemeTemplatePurchaseMsgbox:GetAddList()
	local var_4_0 = {}
	local var_4_1 = self.dorm:GetPurchasedFurnitures()

	for iter_4_0, iter_4_1 in pairs((self.template:GetFurnitureCnt())) do
		if pg.furniture_data_template[iter_4_0] then
			local var_4_2 = var_4_1[iter_4_0]
			local var_4_3 = 0

			if not var_4_1[iter_4_0] then
				var_4_2 = Furniture.New({
					id = iter_4_0
				})
			else
				var_4_3 = var_4_2.count
			end

			if var_4_2:canPurchase() and var_4_2:inTime() and var_4_2:canPurchaseByDormMoeny() then
				for iter_4_2 = 1, iter_4_1 - var_4_3 do
					table.insert(var_4_0, var_4_2)
				end
			end
		end
	end

	return var_4_0
end

function BackYardThemeTemplatePurchaseMsgbox:OnDestroy()
	BackYardThemeTemplatePurchaseMsgbox.super.OnDestroy(self)

	if not IsNil(self.rawIcon.texture) then
		Object.Destroy(self.rawIcon.texture)

		self.rawIcon.texture = nil
	end

	return
end

return BackYardThemeTemplatePurchaseMsgbox
