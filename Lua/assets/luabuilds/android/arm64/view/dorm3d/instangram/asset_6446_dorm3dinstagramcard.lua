local Dorm3dInstagramCard = class("Dorm3dInstagramCard")

function Dorm3dInstagramCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.iconTF = self._tf:Find("head/icon")
	self.nameTxt = self._tf:Find("name")
	self.txt = self._tf:Find("Text")
	self.like = self._tf:Find("like/Text")
	self.likeMark = self._tf:Find("like/mark")
	self.tip = self._tf:Find("head/tip")
	self.image = self._tf:Find("image")
	self.mask = self._tf:Find("mask")
	self.maskTxt = self._tf:Find("mask/content/Text")

	return
end

function Dorm3dInstagramCard:Update(arg_2_1)
	self.instagram = arg_2_1

	setImageSprite(self.iconTF, LoadSprite("qicon/" .. arg_2_1:GetIcon()), false)
	setText(self.nameTxt, arg_2_1:GetName())
	LoadSpriteAsync("Dorm3dIns/" .. arg_2_1:GetPicture(), function(arg_3_0)
		setImageSprite(self.image, arg_3_0, false)

		return
	end)
	setActive(self.likeMark, arg_2_1:IsGood())
	setText(self.txt, arg_2_1:GetText())
	setActive(self.tip, arg_2_1:ShouldTip())
	setActive(self.mask, arg_2_1:IsLock())
	setText(self.maskTxt, arg_2_1:GetUnLockConditionDesc())

	return
end

function Dorm3dInstagramCard:Dispose()
	return
end

return Dorm3dInstagramCard
