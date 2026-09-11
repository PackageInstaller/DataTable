local NewWarChessBlockerManager = class("NewWarChessBlockerManager")

function NewWarChessBlockerManager:Ctor(arg_1_1)
	self.Blocker_ = nil
	self.moveBlockTimes_ = 0
	self.blockTimes_ = 0

	self:CreateBlocker(arg_1_1)
end

function NewWarChessBlockerManager:ShowMoveBlocker()
	self.moveBlockTimes_ = 1

	self:CheckBlockerGo()
end

function NewWarChessBlockerManager:HideMoveBlocker()
	self.moveBlockTimes_ = 0

	self:CheckBlockerGo()
end

function NewWarChessBlockerManager:ShowBlocker()
	if self.blockTimes_ < 0 then
		self.blockTimes_ = 0
	end

	self.blockTimes_ = self.blockTimes_ + 1

	self:CheckBlockerGo()
end

function NewWarChessBlockerManager:HideBlocker()
	if self.blockTimes_ > 0 then
		self.blockTimes_ = self.blockTimes_ == 0 and 0 or self.blockTimes_ - 1
	end

	self:CheckBlockerGo()
end

function NewWarChessBlockerManager:CheckBlockerGo()
	if self.moveBlockTimes_ == 1 or self.blockTimes_ >= 1 then
		SetActive(self.Blocker_, true)
		NewChessLuaBridge.SetChessInputEnable(false)
	elseif self.moveBlockTimes_ == 0 and self.blockTimes_ <= 0 then
		SetActive(self.Blocker_, false)
		NewChessLuaBridge.SetChessInputEnable(true)
	end
end

function NewWarChessBlockerManager:CreateBlocker(arg_7_1)
	local var_7_0 = GameObject("Blocker")
	local var_7_1 = var_7_0:AddComponent(typeof(RectTransform))

	var_7_1:SetParent(arg_7_1.transform, false)

	var_7_1.anchorMin = Vector3.zero
	var_7_1.anchorMax = Vector3.one
	var_7_1.sizeDelta = Vector2.zero
	var_7_0:AddComponent(typeof(Image)).color = Color.clear

	SetActive(var_7_0, false)

	self.Blocker_ = var_7_0
end

function NewWarChessBlockerManager:DestroyBlocker()
	Object.Destroy(self.Blocker_)
end

function NewWarChessBlockerManager:Dispose()
	self:DestroyBlocker()
end

return NewWarChessBlockerManager
