local var_0_0 = class("AgoraDecorationCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.icon = arg_1_0.tr:Find("mask/icon"):GetComponent(typeof(Image))
	arg_1_0.mark = arg_1_0.tr:Find("mark")
	arg_1_0.nameTxt = arg_1_0.tr:Find("name"):GetComponent(typeof(Text))
	arg_1_0.using = arg_1_0.tr:Find("using")
	arg_1_0.usingText = arg_1_0.using:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.cntTr = arg_1_0.tr:Find("cnt")
	arg_1_0.cntTxt = arg_1_0.tr:Find("cnt/Text"):GetComponent(typeof(Text))
	arg_1_0.capcityTxt = arg_1_0.tr:Find("capcity/Text"):GetComponent(typeof(Text))
	arg_1_0.rarityTr = arg_1_0.tr:Find("rarity"):GetComponent(typeof(Image))
	arg_1_0.canInteractionTF = arg_1_0.tr:Find("interaction")
	arg_1_0.usingText.text = i18n("island_agora_using")
	arg_1_0.newTr = arg_1_0.tr:Find("new")
	arg_1_0.longPressTriggerEvent = GetOrAddComponent(arg_1_0._go, "LongPressTrigger").onLongPressed
	arg_1_0.onReleasedEvent = GetOrAddComponent(arg_1_0._go, "LongPressTrigger").onReleased
	arg_1_0.onClickEvent = GetOrAddComponent(arg_1_0._go, "LongPressTrigger").onClick

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.valueObject = arg_2_1

	local var_2_0 = arg_2_1:GetFirstItem()

	arg_2_0.nameTxt.text = shortenString(var_2_0:GetName(), 5)

	setActive(arg_2_0.using, arg_2_1:IsUsing())
	arg_2_0:UpdateSelected(arg_2_2)

	local var_2_1 = arg_2_1:GetMaxCnt()

	arg_2_0.cntTxt.text = var_2_1 - arg_2_1:GetAvailableCnt() .. "/" .. var_2_1
	arg_2_0.capcityTxt.text = var_2_0:GetCost()
	arg_2_0.rarityTr.sprite = GetSpriteFromAtlas("ui/IslandDecorationUI_atlas", "r" .. var_2_0:GetRarity())

	setActive(arg_2_0.newTr, arg_2_1:IsNew())
	setActive(arg_2_0.cntTr, not var_2_0:IsOptionalShapeType())
	setActive(arg_2_0.canInteractionTF, var_2_0:CanInteraction())
	LoadSpriteAsync("island/IslandFurnitureIcon/" .. var_2_0:GetIcon(), function(arg_3_0)
		if not IsNil(arg_2_0.icon) then
			arg_2_0.icon.sprite = arg_3_0

			arg_2_0.icon:SetNativeSize()
		end

		return
	end)

	return
end

function var_0_0.UpdateSelected(arg_4_0, arg_4_1)
	setActive(arg_4_0.mark, arg_4_0.valueObject:GetFirstItem().id == arg_4_1)

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.longPressTriggerEvent:RemoveAllListeners()
	arg_5_0.onReleasedEvent:RemoveAllListeners()
	arg_5_0.onClickEvent:RemoveAllListeners()

	return
end

return var_0_0
