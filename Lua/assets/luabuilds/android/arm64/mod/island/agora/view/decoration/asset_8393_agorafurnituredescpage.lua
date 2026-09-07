local AgoraFurnitureDescPage = class("AgoraFurnitureDescPage", import("view.base.BaseSubView"))

function AgoraFurnitureDescPage:getUIName()
	return "IslandAgoraFurnitureDescUI"
end

function AgoraFurnitureDescPage:OnLoaded()
	self.width = self._tf.rect.width
	self.height = self._tf.rect.height
	self.prantLeftBound = self._tf.parent.rect.width / 2
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.themeNameTxt = self._tf:Find("theme"):GetComponent(typeof(Text))
	self.capacityTxt = self._tf:Find("capacity/Text"):GetComponent(typeof(Text))
	self.descTxt = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("icon"):GetComponent(typeof(Image))
	self.cntTxt = self._tf:Find("cnt/Text"):GetComponent(typeof(Text))

	setActive(self._tf:Find("cnt"), false)

	return
end

function AgoraFurnitureDescPage:Show(arg_3_1, arg_3_2)
	AgoraFurnitureDescPage.super.Show(self)

	self._tf.position = arg_3_2

	if self._tf.localPosition.x + self.width > self.prantLeftBound then
		self._tf.localPosition = Vector3(self._tf.localPosition.x - self.width, self._tf.localPosition.y, self._tf.localPosition.z)
	end

	self:FlushInfo(arg_3_1)

	return
end

function AgoraFurnitureDescPage:FlushInfo(arg_4_1)
	local var_4_0 = arg_4_1:GetFirstItem()

	self.nameTxt.text = var_4_0:GetName()
	self.themeNameTxt.text = i18n("agora_belong_theme", arg_4_1:GetThemeName())
	self.capacityTxt.text = var_4_0:GetCost()
	self.descTxt.text = var_4_0:GetDesc()
	self.cntTxt.text = arg_4_1:GetAvailableCnt()

	LoadSpriteAsync("island/IslandFurnitureIcon/" .. var_4_0:GetIcon(), function(arg_5_0)
		if not IsNil(self.icon) then
			self.icon.sprite = arg_5_0
		end

		return
	end)

	return
end

function AgoraFurnitureDescPage:OnDestroy()
	return
end

return AgoraFurnitureDescPage
