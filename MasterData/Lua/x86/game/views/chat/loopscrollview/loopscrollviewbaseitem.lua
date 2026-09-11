local LoopScrollViewBaseItem = class("LoopScrollViewBaseItem", ReduxView)

function LoopScrollViewBaseItem:GetIndex()
	return self.index_
end

function LoopScrollViewBaseItem:IsActive()
	return true
end

function LoopScrollViewBaseItem:IsTimeBar()
	return false
end

function LoopScrollViewBaseItem:SetData(arg_4_1, arg_4_2)
	return
end

function LoopScrollViewBaseItem:GetItemHeight()
	return self.rectGo_.sizeDelta.y
end

function LoopScrollViewBaseItem:SetAsLastSibling()
	self.transform_:SetAsLastSibling()
end

function LoopScrollViewBaseItem:SetAsFirstSibling()
	self.transform_:SetAsFirstSibling()
end

function LoopScrollViewBaseItem:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

return LoopScrollViewBaseItem
