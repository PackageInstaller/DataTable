class = var_0_10000

local var_0_0 = var_0_10000("AgoraDecorationCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.tr = arg_1_1.transform

	local var_1_0 = arg_1_0.tr
	local var_1_1 = var_2.Find(var_1_0, "mask/icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.icon = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0.tr

	arg_1_0.mark = var_2.Find(var_1_3, "mark")

	local var_1_4 = arg_1_0.tr
	local var_1_5 = var_2.Find(var_1_4, "name")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_0.tr

	arg_1_0.using = var_2.Find(var_1_7, "using")

	local var_1_8 = arg_1_0.using
	local var_1_9 = var_2.Find(var_1_8, "Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.usingText = var_1_10(var_1_9, var_4(var_1_10005))

	local var_1_11 = arg_1_0.tr

	arg_1_0.cntTr = var_2.Find(var_1_11, "cnt")

	local var_1_12 = arg_1_0.tr
	local var_1_13 = var_2.Find(var_1_12, "cnt/Text")
	local var_1_14 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.cntTxt = var_1_14(var_1_13, var_4(var_1_10005))

	local var_1_15 = arg_1_0.tr
	local var_1_16 = var_2.Find(var_1_15, "capcity/Text")
	local var_1_17 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.capcityTxt = var_1_17(var_1_16, var_4(var_1_10005))

	local var_1_18 = arg_1_0.tr
	local var_1_19 = var_2.Find(var_1_18, "rarity")
	local var_1_20 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.rarityTr = var_1_20(var_1_19, var_4(var_1_10005))

	local var_1_21 = arg_1_0.tr

	arg_1_0.canInteractionTF = var_2.Find(var_1_21, "interaction")

	local var_1_22 = arg_1_0.usingText

	i18n = var_1_21
	var_1_22.text = var_1_21("island_agora_using")

	local var_1_23 = arg_1_0.tr

	arg_1_0.newTr = var_2.Find(var_1_23, "new")
	GetOrAddComponent = var_2
	arg_1_0.longPressTriggerEvent = var_2(arg_1_0._go, "LongPressTrigger").onLongPressed
	GetOrAddComponent = var_2
	arg_1_0.onReleasedEvent = var_2(arg_1_0._go, "LongPressTrigger").onReleased
	GetOrAddComponent = var_2
	arg_1_0.onClickEvent = var_2(arg_1_0._go, "LongPressTrigger").onClick

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.valueObject = arg_2_1

	local var_2_0 = arg_2_1:GetFirstItem()
	local var_2_1 = arg_2_0.nameTxt

	shortenString = var_1_10005
	var_2_1.text = var_1_10005(var_2_0:GetName(), 5)
	setActive = var_2_1

	var_2_1(arg_2_0.using, arg_2_1:IsUsing())
	arg_2_0:UpdateSelected(arg_2_2)

	local var_2_2 = arg_2_1:GetMaxCnt()

	arg_2_0.cntTxt.text = var_2_2 - arg_2_1:GetAvailableCnt() .. "/" .. var_2_2

	local var_2_3 = arg_2_0.capcityTxt

	var_2_3.text = var_2_0:GetCost()
	GetSpriteFromAtlas = var_2_3

	local var_2_4

	var_2_4.sprite, var_2_4 = var_2_3("ui/IslandDecorationUI_atlas", "r" .. var_2_0:GetRarity()), arg_2_0.rarityTr
	setActive = var_2_4

	var_2_4(arg_2_0.newTr, arg_2_1:IsNew())

	setActive = var_2_4

	var_2_4(arg_2_0.cntTr, not var_2_0:IsOptionalShapeType())

	setActive = var_2_4

	var_2_4(arg_2_0.canInteractionTF, var_2_0:CanInteraction())

	LoadSpriteAsync = var_2_4

	var_2_4("island/IslandFurnitureIcon/" .. var_2_0:GetIcon(), function(arg_3_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.icon) then
			arg_2_0.icon.sprite = arg_3_0

			local var_3_0 = arg_2_0.icon

			var_1.SetNativeSize(var_3_0)
		end

		return
	end)

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.valueObject
	local var_4_1 = var_2.GetFirstItem(var_4_0)

	setActive = var_4_0

	var_4_0(arg_4_0.mark, var_4_1.id == arg_4_1)

	return
end

function var_0_0.Dispose(arg_5_0)
	local var_5_0 = arg_5_0.longPressTriggerEvent

	var_1.RemoveAllListeners(var_5_0)

	local var_5_1 = arg_5_0.onReleasedEvent

	var_1.RemoveAllListeners(var_5_1)

	local var_5_2 = arg_5_0.onClickEvent

	var_1.RemoveAllListeners(var_5_2)

	return
end

return var_0_0
