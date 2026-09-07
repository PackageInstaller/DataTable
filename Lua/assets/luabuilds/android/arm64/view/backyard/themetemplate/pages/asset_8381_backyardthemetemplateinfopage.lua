local BackYardThemeTemplateInfoPage = class("BackYardThemeTemplateInfoPage", import("...Shop.pages.BackYardThemeInfoPage"))

function BackYardThemeTemplateInfoPage:getUIName()
	return "BackYardTemplateInfoPage"
end

function BackYardThemeTemplateInfoPage:OnInit()
	BackYardThemeTemplateInfoPage.super.OnInit(self)
	onButton(self, self.purchaseBtn, function()
		self.contextData.themeMsgBox:ExecuteAction("SetUp", self.template, self.dorm, self.player)

		return
	end, SFX_PANEL)
	setActive(self.icon, false)

	self.iconRaw = self._tf:Find("frame/icon/Image_raw"):GetComponent(typeof(RawImage))

	setActive(self.leftArrBtn, false)
	setActive(self.rightArrBtn, false)

	return
end

function BackYardThemeTemplateInfoPage:OnInitCard(arg_4_1)
	local var_4_0 = BackYardThemTemplateFurnitureCard.New(arg_4_1)

	onButton(self, var_4_0._go, function()
		if var_4_0.furniture:canPurchase() and var_4_0.furniture:inTime() and (var_4_0.furniture:canPurchaseByGem() or var_4_0.furniture:canPurchaseByDormMoeny()) then
			self.contextData.furnitureMsgBox:ExecuteAction("SetUp", var_4_0.furniture, self.dorm, self.target)
		end

		return
	end, SFX_PANEL)

	self.cards[arg_4_1] = var_4_0

	return
end

function BackYardThemeTemplateInfoPage:SetUp(arg_6_1, arg_6_2, arg_6_3)
	self:Show()

	self.template = arg_6_1
	self.dorm = arg_6_2
	self.target = arg_6_3
	self.player = getProxy(PlayerProxy):getData()

	self:InitFurnitureList()
	self:UpdateThemeInfo()
	self:UpdateRes()

	return
end

function BackYardThemeTemplateInfoPage:InitFurnitureList()
	self.displays = {}

	local var_7_0 = self.dorm:GetPurchasedFurnitures()

	for iter_7_0, iter_7_1 in pairs((self.template:GetFurnitureCnt())) do
		if pg.furniture_data_template[iter_7_0] then
			table.insert(self.displays, var_7_0[iter_7_0] or Furniture.New({
				id = iter_7_0
			}))
		end
	end

	local function var_7_2(arg_8_0)
		if arg_8_0:inTime() then
			if arg_8_0:canPurchaseByGem() and not arg_8_0:canPurchaseByDormMoeny() then
				return 1
			elseif arg_8_0:canPurchaseByGem() and arg_8_0:canPurchaseByDormMoeny() then
				return 2
			else
				return 3
			end
		else
			return 4
		end

		return
	end

	table.sort(self.displays, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:canPurchase() and 1 or 0
		local var_9_1 = arg_9_1:canPurchase() and 1 or 0

		if var_9_0 == var_9_1 then
			return var_7_2(arg_9_0) < var_7_2(arg_9_1)
		else
			return var_9_1 < var_9_0
		end

		return
	end)
	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function BackYardThemeTemplateInfoPage:UpdateThemeInfo()
	self.nameTxt.text = self.template:GetName()

	setActive(self.iconRaw.gameObject, false)
	BackYardThemeTempalteUtil.GetTexture(self.template:GetTextureName(), self.template:GetImageMd5(), function(arg_11_0)
		if not IsNil(self.iconRaw) and arg_11_0 then
			self.iconRaw.texture = arg_11_0

			setActive(self.iconRaw.gameObject, true)
		end

		return
	end)

	self.desc.text = self.template:GetDesc()

	self:UpdatePurchaseBtn()

	return
end

function BackYardThemeTemplateInfoPage:UpdatePurchaseBtn()
	local var_12_0 = self.template:OwnThemeTemplateFurniture()
	local var_12_1 = false

	for iter_12_0, iter_12_1 in pairs((self.template:GetFurnitureCnt())) do
		local var_12_2 = Furniture.New({
			id = iter_12_0
		})

		if var_12_2:inTime() and var_12_2:canPurchaseByDormMoeny() and self.dorm:GetOwnFurnitureCount(iter_12_0) < iter_12_1 then
			var_12_1 = true

			break
		end
	end

	setActive(self.purchaseBtn, not var_12_0 and var_12_1)
	setActive(self.purchaseAllBtn, false)

	return
end

function BackYardThemeTemplateInfoPage:OnDestroy()
	BackYardThemeTemplateInfoPage.super.OnDestroy(self)

	if not IsNil(self.iconRaw.texture) then
		Object.Destroy(self.iconRaw.texture)

		self.iconRaw.texture = nil
	end

	return
end

return BackYardThemeTemplateInfoPage
