local ChessBlockerManager = class("ChessBlockerManager")

function ChessBlockerManager:Ctor(arg_1_1)
	self.Blocker_ = nil
	self.blockTimes_ = 0

	self:CreateBlocker(arg_1_1)
end

function ChessBlockerManager:ShowBlocker()
	self.blockTimes_ = self.blockTimes_ + 1

	if self.blockTimes_ >= 1 then
		SetActive(self.Blocker_, true)
		ChessLuaBridge.SetChessInputEnable(false)
	end
end

function ChessBlockerManager:HideBlocker()
	self.blockTimes_ = self.blockTimes_ == 0 and 0 or self.blockTimes_ - 1

	if self.blockTimes_ <= 0 then
		SetActive(self.Blocker_, false)
		ChessLuaBridge.SetChessInputEnable(true)
	end
end

function ChessBlockerManager:CreateBlocker(arg_4_1)
	local var_4_0 = GameObject("Blocker")
	local var_4_1 = var_4_0:AddComponent(typeof(RectTransform))

	var_4_1:SetParent(arg_4_1.transform, false)

	var_4_1.anchorMin = Vector3.zero
	var_4_1.anchorMax = Vector3.one
	var_4_1.sizeDelta = Vector2.zero
	var_4_0:AddComponent(typeof(Image)).color = Color.clear

	SetActive(var_4_0, false)

	self.Blocker_ = var_4_0
end

function ChessBlockerManager:DestroyBlocker()
	Object.Destroy(self.Blocker_)
end

function ChessBlockerManager:Dispose()
	self:DestroyBlocker()
end

return ChessBlockerManager
