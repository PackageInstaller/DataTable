local CryptolaliaScrollRectItem = class("CryptolaliaScrollRectItem")
local var_0_1 = Vector3(490, -35, 0)
local var_0_2 = Vector3(297, 297, 0)

local function var_0_3(arg_1_0, arg_1_1)
	return var_0_1 + var_0_2 * (arg_1_0.midIndex - arg_1_1)
end

function CryptolaliaScrollRectItem:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self._go = arg_2_1
	self._tf = arg_2_1.transform
	self.initIndex = arg_2_3
	self.midIndex = arg_2_2
	self.img = self._go:GetComponent(typeof(Image))
	self.text = self._tf:Find("Text")
	self.index = arg_2_3

	self:SetPosition((var_0_3(self, arg_2_3)))

	return
end

function CryptolaliaScrollRectItem:Interactable(arg_3_1)
	self.img.raycastTarget = arg_3_1

	setActive(self.text, not arg_3_1)

	return
end

function CryptolaliaScrollRectItem:CanInteractable()
	return self.img.raycastTarget
end

function CryptolaliaScrollRectItem:UpdateIndexWithAnim(arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0(arg_6_0, arg_6_1)
		LeanTween.moveLocal(self._go, arg_6_0, 0.594):setEase(LeanTweenType.easeInOutCirc):setOnComplete(System.Action(arg_6_1))

		return
	end

	if math.abs(arg_5_1 - self.index) > 1 then
		var_5_0(var_0_3(self, arg_5_2), function()
			self:UpdateIndex(arg_5_1)
			arg_5_3()

			return
		end)
	else
		var_5_0(var_0_3(self, arg_5_1), function()
			self:UpdateIndex(arg_5_1)

			return
		end)
	end

	return
end

function CryptolaliaScrollRectItem:UpdateIndex(arg_9_1)
	self.index = arg_9_1
	self._go.name = arg_9_1

	self:SetPosition((var_0_3(self, arg_9_1)))

	return
end

function CryptolaliaScrollRectItem:UpdateIndexSilence(arg_10_1)
	self.index = arg_10_1
	self._go.name = arg_10_1

	return
end

function CryptolaliaScrollRectItem:Refresh()
	self:UpdateIndex((self:GetIndex()))

	return
end

function CryptolaliaScrollRectItem:ClearAnimation()
	if LeanTween.isTweening(self._go) then
		LeanTween.cancel(self._go)
	end

	self:SetPosition(var_0_3(self, self.index))

	return
end

function CryptolaliaScrollRectItem:GetIndex()
	return self.index
end

function CryptolaliaScrollRectItem:GetInitIndex()
	return self.initIndex
end

function CryptolaliaScrollRectItem:IsMidIndex()
	return self:GetIndex() == self.midIndex
end

function CryptolaliaScrollRectItem:UpdateSprite(arg_16_1)
	self.img.sprite = arg_16_1

	self.img:SetNativeSize()

	return
end

function CryptolaliaScrollRectItem:SetPosition(arg_17_1)
	self._tf.localPosition = arg_17_1

	return
end

function CryptolaliaScrollRectItem:GetPosition()
	return self._tf.localPosition
end

function CryptolaliaScrollRectItem:Dispose()
	self:ClearAnimation()

	return
end

return CryptolaliaScrollRectItem
