local ChessBoardBlockManager = class("ChessBoardBlockManager")

function ChessBoardBlockManager:Ctor(arg_1_1)
	self.Blocker_ = nil
	self.moveBlockTimes_ = 0
	self.blockTimes_ = 0

	self:CreateBlocker(arg_1_1)
end

function ChessBoardBlockManager:ShowMoveBlocker()
	self.moveBlockTimes_ = 1

	self:CheckBlockerGo()
end

function ChessBoardBlockManager:HideMoveBlocker()
	self.moveBlockTimes_ = 0

	self:CheckBlockerGo()
end

function ChessBoardBlockManager:ShowBlocker()
	if self.blockTimes_ < 0 then
		self.blockTimes_ = 0
	end

	self.blockTimes_ = self.blockTimes_ + 1

	self:CheckBlockerGo()
	manager.notify:CallUpdateFunc(CHESSBOARD_BLOCK_Update)
end

function ChessBoardBlockManager:HideBlocker()
	if self.blockTimes_ > 0 then
		self.blockTimes_ = self.blockTimes_ == 0 and 0 or self.blockTimes_ - 1
	end

	self:CheckBlockerGo()
	manager.notify:CallUpdateFunc(CHESSBOARD_BLOCK_Update)
end

function ChessBoardBlockManager:CheckBlockerGo()
	if self.moveBlockTimes_ == 1 or self.blockTimes_ >= 1 then
		SetActive(self.Blocker_, true)
		ChessBoardLuaBridge.SetInputEnable(false)
	elseif self.moveBlockTimes_ == 0 and self.blockTimes_ <= 0 then
		SetActive(self.Blocker_, false)
		ChessBoardLuaBridge.SetInputEnable(true)
	end
end

function ChessBoardBlockManager:CheckIsShowBlocker()
	return (self.Blocker_ or nil) and (self.Blocker_.gameObject.activeSelf or false)
end

function ChessBoardBlockManager:ForceCloseBlocker()
	SetActive(self.Blocker_, false)
end

function ChessBoardBlockManager:CreateBlocker(arg_9_1)
	local var_9_0 = GameObject("Blocker")
	local var_9_1 = var_9_0:AddComponent(typeof(RectTransform))

	var_9_1:SetParent(arg_9_1.transform, false)

	var_9_1.anchorMin = Vector3.zero
	var_9_1.anchorMax = Vector3.one
	var_9_1.sizeDelta = Vector2.zero
	var_9_0:AddComponent(typeof(Image)).color = Color.clear

	SetActive(var_9_0, false)

	self.Blocker_ = var_9_0
end

function ChessBoardBlockManager:DestroyBlocker()
	Object.Destroy(self.Blocker_)
end

function ChessBoardBlockManager:Dispose()
	self:DestroyBlocker()
end

return ChessBoardBlockManager
