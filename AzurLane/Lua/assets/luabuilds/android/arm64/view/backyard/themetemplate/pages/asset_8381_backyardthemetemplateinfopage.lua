class = var_0_10000

local var_0_0 = "BackYardThemeTemplateInfoPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...Shop.pages.BackYardThemeInfoPage"))

function var_0_1.getUIName(arg_1_0)
	return "BackYardTemplateInfoPage"
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.purchaseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0.contextData.themeMsgBox

		var_0.ExecuteAction(var_3_0, "SetUp", arg_2_0.template, arg_2_0.dorm, arg_2_0.player)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	setActive = var_1

	var_1(arg_2_0.icon, false)

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/icon/Image_raw")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	RawImage = var_1_10006
	arg_2_0.iconRaw = var_2_5(var_2_4, var_4(var_1_10006))
	setActive = var_1

	var_1(arg_2_0.leftArrBtn, false)

	setActive = var_1

	var_1(arg_2_0.rightArrBtn, false)

	return
end

function var_0_1.OnInitCard(arg_4_0, arg_4_1)
	BackYardThemTemplateFurnitureCard = var_1_10002

	local var_4_0 = var_1_10002.New(arg_4_1)

	onButton = var_1_10003

	local var_4_1 = arg_4_0
	local var_4_2 = var_4_0._go

	local function var_4_3()
		local var_5_0 = var_4_0.furniture

		if var_0.canPurchase(var_5_0) then
			local var_5_1 = var_4_0.furniture

			if var_0.inTime(var_5_1) then
				local var_5_2 = var_4_0.furniture

				if not var_0.canPurchaseByGem(var_5_2) then
					local var_5_3 = var_4_0.furniture

					if var_0.canPurchaseByDormMoeny(var_5_3) then
						local var_5_4 = arg_4_0.contextData.furnitureMsgBox

						var_0.ExecuteAction(var_5_4, "SetUp", var_4_0.furniture, arg_4_0.dorm, arg_4_0.target)
					end

					return
				end
			end
		end
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_4_1, var_4_2, var_4_3, var_1_10008)

	arg_4_0.cards[arg_4_1] = var_4_0

	return
end

function var_0_1.SetUp(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0

	arg_6_0.Show(var_6_0)

	arg_6_0.template = arg_6_1
	arg_6_0.dorm = arg_6_2
	arg_6_0.target = arg_6_3
	getProxy = var_4
	PlayerProxy = var_6_0

	local var_6_1 = var_4(var_6_0)

	arg_6_0.player = var_4.getData(var_6_1)

	arg_6_0:InitFurnitureList()
	arg_6_0:UpdateThemeInfo()
	arg_6_0:UpdateRes()

	return
end

function var_0_1.InitFurnitureList(arg_7_0)
	arg_7_0.displays = {}

	local var_7_0 = arg_7_0.template
	local var_7_1 = var_1.GetFurnitureCnt(var_7_0)
	local var_7_2 = arg_7_0.dorm
	local var_7_3 = var_2.GetPurchasedFurnitures(var_7_2)

	pairs = var_7_0

	for iter_7_0, iter_7_1 in var_7_0(var_7_1) do
		pg = var_1_10008

		if var_1_10008.furniture_data_template[iter_7_0] then
			if not var_7_3[iter_7_0] then
				Furniture = var_1_10009
				var_1_10008 = var_1_10009.New({
					id = iter_7_0
				})
			end

			table = var_1_10009

			var_1_10009.insert(arg_7_0.displays, var_1_10008)
		end
	end

	local function var_7_4(arg_8_0)
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

	table = var_4

	var_4.sort(arg_7_0.displays, function(arg_9_0, arg_9_1)
		if (arg_9_0:canPurchase() and 1 or 0) == (arg_9_1:canPurchase() and 1 or 0) then
			return var_7_4(arg_9_0) < var_7_4(arg_9_1)
		else
			return var_3 < var_2
		end

		return
	end)

	local var_7_5 = arg_7_0.scrollRect

	var_4.SetTotalCount(var_7_5, #arg_7_0.displays)

	return
end

function var_0_1.UpdateThemeInfo(arg_10_0)
	local var_10_0 = arg_10_0.template
	local var_10_1 = arg_10_0.nameTxt

	var_10_1.text = var_10_0:GetName()
	setActive = var_10_1

	var_10_1(arg_10_0.iconRaw.gameObject, false)

	local var_10_2 = var_10_0:GetImageMd5()

	BackYardThemeTempalteUtil = var_3

	var_3.GetTexture(var_10_0:GetTextureName(), var_10_2, function(arg_11_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_10_0.iconRaw) and arg_11_0 then
			local var_11_0 = arg_10_0.iconRaw

			var_11_0.texture = arg_11_0
			setActive = var_11_0

			var_11_0(arg_10_0.iconRaw.gameObject, true)
		end

		return
	end)

	arg_10_0.desc.text = var_10_0:GetDesc()

	arg_10_0:UpdatePurchaseBtn()

	return
end

function var_0_1.UpdatePurchaseBtn(arg_12_0)
	local var_12_0 = arg_12_0.template
	local var_12_1 = var_1.OwnThemeTemplateFurniture(var_12_0)
	local var_12_2 = arg_12_0.template
	local var_12_3 = var_2.GetFurnitureCnt(var_12_2)
	local var_12_4 = false

	pairs = var_12_2

	for iter_12_0, iter_12_1 in var_12_2(var_12_3) do
		Furniture = var_1_10009
		var_1_10009 = var_1_10009.New({
			id = iter_12_0
		})

		local var_12_5 = arg_12_0.dorm
		local var_12_6 = var_10.GetOwnFurnitureCount(var_12_5, iter_12_0)

		if var_1_10009:inTime() and var_1_10009:canPurchaseByDormMoeny() and var_12_6 < iter_12_1 then
			var_12_4 = true

			break
		end
	end

	setActive = var_4

	var_4(arg_12_0.purchaseBtn, not var_12_1 and var_12_4)

	setActive = var_4

	var_4(arg_12_0.purchaseAllBtn, false)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	var_0_1.super.OnDestroy(arg_13_0)

	IsNil = var_1

	if not var_1(arg_13_0.iconRaw.texture) then
		Object = var_1

		var_1.Destroy(arg_13_0.iconRaw.texture)

		arg_13_0.iconRaw.texture = nil
	end

	return
end

return var_0_1
