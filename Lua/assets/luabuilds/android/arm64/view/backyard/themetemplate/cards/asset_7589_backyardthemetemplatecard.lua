local BackYardThemeTemplateCard = class("BackYardThemeTemplateCard", import("...Shop.cards.BackYardThemeCard"))

function BackYardThemeTemplateCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.content = self._tf:Find("content")
	self.mask = self.content:Find("mask")
	self.iconRaw = self.content:Find("icon_mask/icon_raw"):GetComponent(typeof(RawImage))
	self.nameTxt = self.content:Find("Text"):GetComponent(typeof(Text))
	self.pos = self.content:Find("pos")
	self.posTxt = self.pos:Find("Text"):GetComponent(typeof(Text))

	return
end

function BackYardThemeTemplateCard:FlushData(arg_2_1)
	self.template = arg_2_1
	self.themeVO = arg_2_1
	self.nameTxt.text = arg_2_1:GetName()

	return
end

function BackYardThemeTemplateCard:Update(arg_3_1)
	if self.template and arg_3_1.id == self.template.id then
		self:FlushData(arg_3_1)

		return
	else
		self:FlushData(arg_3_1)
		setActive(self.iconRaw.gameObject, false)
		BackYardThemeTempalteUtil.GetTexture(arg_3_1:GetTextureIconName(), arg_3_1:GetIconMd5(), function(arg_4_0)
			if not IsNil(self.iconRaw) and arg_4_0 then
				setActive(self.iconRaw.gameObject, true)

				self.iconRaw.texture = arg_4_0
			end

			return
		end)

		local var_3_0 = arg_3_1:IsSelfUsage()

		setActive(self.mask, arg_3_1:IsPushed() and var_3_0)
		setActive(self.pos, var_3_0)

		if var_3_0 then
			if arg_3_1.pos <= 9 then
				self.posTxt.text = "0" .. arg_3_1.pos
			end
		end
	end

	return
end

function BackYardThemeTemplateCard:Dispose()
	BackYardThemeTemplateCard.super.Dispose(self)

	if not IsNil(self.iconRaw.texture) then
		Object.Destroy(self.iconRaw.texture)

		self.iconRaw.texture = nil
	end

	return
end

return BackYardThemeTemplateCard
