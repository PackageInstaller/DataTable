local AgoraDecorationCard = class("AgoraDecorationCard")

function AgoraDecorationCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self.tr = arg_1_1.transform
	self.icon = self.tr:Find("mask/icon"):GetComponent(typeof(Image))
	self.mark = self.tr:Find("mark")
	self.nameTxt = self.tr:Find("name"):GetComponent(typeof(Text))
	self.using = self.tr:Find("using")
	self.usingText = self.using:Find("Text"):GetComponent(typeof(Text))
	self.cntTr = self.tr:Find("cnt")
	self.cntTxt = self.tr:Find("cnt/Text"):GetComponent(typeof(Text))
	self.capcityTxt = self.tr:Find("capcity/Text"):GetComponent(typeof(Text))
	self.rarityTr = self.tr:Find("rarity"):GetComponent(typeof(Image))
	self.canInteractionTF = self.tr:Find("interaction")
	self.usingText.text = i18n("island_agora_using")
	self.newTr = self.tr:Find("new")
	self.longPressTriggerEvent = GetOrAddComponent(self._go, "LongPressTrigger").onLongPressed
	self.onReleasedEvent = GetOrAddComponent(self._go, "LongPressTrigger").onReleased
	self.onClickEvent = GetOrAddComponent(self._go, "LongPressTrigger").onClick

	return
end

function AgoraDecorationCard:Update(arg_2_1, arg_2_2)
	self.valueObject = arg_2_1

	local var_2_0 = arg_2_1:GetFirstItem()

	self.nameTxt.text = shortenString(var_2_0:GetName(), 5)

	setActive(self.using, arg_2_1:IsUsing())
	self:UpdateSelected(arg_2_2)

	local var_2_1 = arg_2_1:GetMaxCnt()

	self.cntTxt.text = var_2_1 - arg_2_1:GetAvailableCnt() .. "/" .. var_2_1
	self.capcityTxt.text = var_2_0:GetCost()
	self.rarityTr.sprite = GetSpriteFromAtlas("ui/IslandDecorationUI_atlas", "r" .. var_2_0:GetRarity())

	setActive(self.newTr, arg_2_1:IsNew())
	setActive(self.cntTr, not var_2_0:IsOptionalShapeType())
	setActive(self.canInteractionTF, var_2_0:CanInteraction())
	LoadSpriteAsync("island/IslandFurnitureIcon/" .. var_2_0:GetIcon(), function(arg_3_0)
		if not IsNil(self.icon) then
			self.icon.sprite = arg_3_0

			self.icon:SetNativeSize()
		end

		return
	end)

	return
end

function AgoraDecorationCard:UpdateSelected(arg_4_1)
	setActive(self.mark, self.valueObject:GetFirstItem().id == arg_4_1)

	return
end

function AgoraDecorationCard:Dispose()
	self.longPressTriggerEvent:RemoveAllListeners()
	self.onReleasedEvent:RemoveAllListeners()
	self.onClickEvent:RemoveAllListeners()

	return
end

return AgoraDecorationCard
