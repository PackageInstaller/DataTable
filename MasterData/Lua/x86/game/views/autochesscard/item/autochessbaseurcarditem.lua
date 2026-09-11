local AutoChessBaseURCardItem = class("AutoChessBaseURCardItem", ReduxView)

function AutoChessBaseURCardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.cardID_ = 0
	self.ItemList = {}

	self:Init()
end

function AutoChessBaseURCardItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddListeners()
end

function AutoChessBaseURCardItem:InitUI()
	return
end

function AutoChessBaseURCardItem:AddListeners()
	return
end

function AutoChessBaseURCardItem:SetItem(arg_5_1, arg_5_2)
	if self.ItemList[arg_5_1] == nil then
		self.ItemList[arg_5_1] = AutoChessBaseCardItem.New((Object.Instantiate(arg_5_2, self.parentTrans_)))
	end
end

function AutoChessBaseURCardItem:SetData(arg_6_1)
	self.cardID_ = arg_6_1

	for iter_6_0, iter_6_1 in pairs(self.ItemList) do
		if iter_6_0 == self.cardID_ then
			iter_6_1:SetActive(true)
		else
			iter_6_1:SetActive(false)
		end
	end

	self:RefreshUI()
end

function AutoChessBaseURCardItem:SetClickHandler(arg_7_1)
	self.ItemList[self.cardID_]:SetClickHandler(arg_7_1)
end

function AutoChessBaseURCardItem:RefreshUI()
	self.ItemList[self.cardID_]:SetData(self.cardID_, true)
end

function AutoChessBaseURCardItem:SetPositionState(arg_9_1)
	self.ItemList[self.cardID_]:SetPositionState(arg_9_1)
end

function AutoChessBaseURCardItem:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function AutoChessBaseURCardItem:Dispose()
	for iter_11_0, iter_11_1 in pairs(self.ItemList) do
		iter_11_1:Dispose()
	end

	AutoChessBaseURCardItem.super.Dispose(self)
end

return AutoChessBaseURCardItem
