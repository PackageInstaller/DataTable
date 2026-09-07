local CatteryStyleCard = class("CatteryStyleCard")

function CatteryStyleCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.styleIcon = self._tf:Find("mask/icon"):GetComponent(typeof(Image))
	self.lockTF = findTF(self._tf, "lock")
	self.mark = findTF(self._tf, "mark")

	return
end

function CatteryStyleCard:Update(arg_2_1, arg_2_2)
	self.style = arg_2_1
	self.styleIcon.sprite = GetSpriteFromAtlas("CatteryStyle/" .. arg_2_1:getConfig("name"), "")

	setActive(self.lockTF, not arg_2_1:IsOwn())
	setActive(self.mark, arg_2_2)

	return
end

function CatteryStyleCard:Dispose()
	return
end

return CatteryStyleCard
