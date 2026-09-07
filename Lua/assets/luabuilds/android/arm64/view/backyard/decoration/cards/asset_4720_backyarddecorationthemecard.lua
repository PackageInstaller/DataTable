local BackYardDecorationThemeCard = class("BackYardDecorationThemeCard", import(".BackYardDecorationCard"))

function BackYardDecorationThemeCard:Ctor(arg_1_1)
	BackYardDecorationThemeCard.super.Ctor(self, arg_1_1)

	self.add = findTF(self._tf, "bg/Add")
	self.rawIcon = findTF(self._tf, "bg/icon_raw"):GetComponent(typeof(RawImage))

	setActive(self.rawIcon.gameObject, false)
	setActive(self.newTF, false)

	self.iconTr = findTF(self._tf, "bg/icon")
	self.pos = findTF(self._tf, "bg/pos")
	self.posTxt = self.pos:Find("new"):GetComponent(typeof(Text))

	return
end

function BackYardDecorationThemeCard:RemoveSizeTag(arg_2_1)
	return string.gsub(string.gsub(arg_2_1, "</size>", ""), "<size=%d+>", "")
end

function BackYardDecorationThemeCard:Update(arg_3_1, arg_3_2)
	self.themeVO = arg_3_1

	local var_3_0 = arg_3_1.id == ""

	SetActive(self.add, arg_3_1.id == "")
	setActive(self.iconTr, not var_3_0)

	if not var_3_0 then
		local var_3_1 = arg_3_1:IsSystem()

		setActive(self.iconImg.gameObject, var_3_1)
		setActive(self.rawIcon.gameObject, false)

		if not var_3_1 then
			if not BackYardThemeTempalteUtil.FileExists(arg_3_1:GetTextureIconName()) then
				if arg_3_1:IsPushed() then
					BackYardThemeTempalteUtil.GetTexture(arg_3_1:GetTextureIconName(), arg_3_1:GetIconMd5(), function(arg_4_0)
						if not IsNil(self.rawIcon) and arg_4_0 then
							setActive(self.rawIcon.gameObject, true)

							self.rawIcon.texture = arg_4_0
						end

						return
					end)

					goto label_3_0
				end
			end

			setActive(self.iconImg.gameObject, true)
			LoadSpriteAtlasAsync("furnitureicon/" .. arg_3_1:getIcon(), "", function(arg_5_0)
				self.iconImg.sprite = arg_5_0

				return
			end)

			::label_3_0::

			local var_3_2 = arg_3_1.pos

			if arg_3_1.pos <= 9 then
				self.posTxt.text = "0" .. arg_3_1.pos
			end
		else
			LoadSpriteAsync("furnitureicon/" .. arg_3_1:getIcon(), function(arg_6_0)
				self.iconImg.sprite = arg_6_0

				return
			end)
		end

		setActive(self.pos, not var_3_1)
		setText(self.comfortableTF, shortenString(self:RemoveSizeTag(arg_3_1:getName()), 4))
		SetActive(self.newTF, false)
		self:UpdateState(arg_3_2)
	else
		setActive(self.pos, false)
		setText(self.comfortableTF, "")
	end

	return
end

function BackYardDecorationThemeCard:UpdateState(arg_7_1)
	if self.themeVO.id ~= "" then
		SetActive(self.maskTF, arg_7_1)

		self.showMask = arg_7_1
	end

	return
end

function BackYardDecorationThemeCard:Dispose()
	BackYardDecorationThemeCard.super.Dispose(self)

	if not IsNil(self.rawIcon.texture) then
		Object.Destroy(self.rawIcon.texture)

		self.rawIcon.texture = nil
	end

	return
end

return BackYardDecorationThemeCard
