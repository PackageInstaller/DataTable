local var_0_0 = class("BackYardThemeTemplateInfoPage", import("...Shop.pages.BackYardThemeInfoPage"))

function var_0_0.getUIName(arg_1_0)
	return "BackYardTemplateInfoPage"
end

function var_0_0.OnInit(arg_2_0)
	var_0_0.super.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0.purchaseBtn, function()
		arg_2_0.contextData.themeMsgBox:ExecuteAction("SetUp", arg_2_0.template, arg_2_0.dorm, arg_2_0.player)

		return
	end, SFX_PANEL)
	setActive(arg_2_0.icon, false)

	arg_2_0.iconRaw = arg_2_0._tf:Find("frame/icon/Image_raw"):GetComponent(typeof(RawImage))

	setActive(arg_2_0.leftArrBtn, false)
	setActive(arg_2_0.rightArrBtn, false)

	return
end

function var_0_0.OnInitCard(arg_4_0, arg_4_1)
	local var_4_0 = BackYardThemTemplateFurnitureCard.New(arg_4_1)

	onButton(arg_4_0, var_4_0._go, function()
		if var_4_0.furniture:canPurchase() and var_4_0.furniture:inTime() and (var_4_0.furniture:canPurchaseByGem() or var_4_0.furniture:canPurchaseByDormMoeny()) then
			arg_4_0.contextData.furnitureMsgBox:ExecuteAction("SetUp", var_4_0.furniture, arg_4_0.dorm, arg_4_0.target)
		end

		return
	end, SFX_PANEL)

	arg_4_0.cards[arg_4_1] = var_4_0

	return
end

function var_0_0.SetUp(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:Show()

	arg_6_0.template = arg_6_1
	arg_6_0.dorm = arg_6_2
	arg_6_0.target = arg_6_3
	arg_6_0.player = getProxy(PlayerProxy):getData()

	arg_6_0:InitFurnitureList()
	arg_6_0:UpdateThemeInfo()
	arg_6_0:UpdateRes()

	return
end

function var_0_0.InitFurnitureList(arg_7_0)
	arg_7_0.displays = {}

	local var_7_0 = arg_7_0.dorm:GetPurchasedFurnitures()

	for iter_7_0, iter_7_1 in pairs((arg_7_0.template:GetFurnitureCnt())) do
		if pg.furniture_data_template[iter_7_0] then
			local var_7_1 = var_7_0[iter_7_0] or Furniture.New({
				id = iter_7_0
			})

			table.insert(arg_7_0.displays, var_7_1)
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

	table.sort(arg_7_0.displays, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:canPurchase() and 1 or 0
		local var_9_1 = arg_9_1:canPurchase() and 1 or 0

		if var_9_0 == var_9_1 then
			return var_7_2(arg_9_0) < var_7_2(arg_9_1)
		else
			return var_9_1 < var_9_0
		end

		return
	end)
	arg_7_0.scrollRect:SetTotalCount(#arg_7_0.displays)

	return
end

function var_0_0.UpdateThemeInfo(arg_10_0)
	arg_10_0.nameTxt.text = arg_10_0.template:GetName()

	setActive(arg_10_0.iconRaw.gameObject, false)
	BackYardThemeTempalteUtil.GetTexture(arg_10_0.template:GetTextureName(), arg_10_0.template:GetImageMd5(), function(arg_11_0)
		if not IsNil(arg_10_0.iconRaw) and arg_11_0 then
			arg_10_0.iconRaw.texture = arg_11_0

			setActive(arg_10_0.iconRaw.gameObject, true)
		end

		return
	end)

	arg_10_0.desc.text = arg_10_0.template:GetDesc()

	arg_10_0:UpdatePurchaseBtn()

	return
end

function var_0_0.UpdatePurchaseBtn(arg_12_0)
	local var_12_0 = arg_12_0.template:OwnThemeTemplateFurniture()
	local var_12_1 = false

	for iter_12_0, iter_12_1 in pairs((arg_12_0.template:GetFurnitureCnt())) do
		local var_12_2 = Furniture.New({
			id = iter_12_0
		})
		local var_12_3 = arg_12_0.dorm:GetOwnFurnitureCount(iter_12_0)

		if var_12_2:inTime() and var_12_2:canPurchaseByDormMoeny() and var_12_3 < iter_12_1 then
			var_12_1 = true

			break
		end
	end

	setActive(arg_12_0.purchaseBtn, not var_12_0 and var_12_1)
	setActive(arg_12_0.purchaseAllBtn, false)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	var_0_0.super.OnDestroy(arg_13_0)

	if not IsNil(arg_13_0.iconRaw.texture) then
		Object.Destroy(arg_13_0.iconRaw.texture)

		arg_13_0.iconRaw.texture = nil
	end

	return
end

return var_0_0
