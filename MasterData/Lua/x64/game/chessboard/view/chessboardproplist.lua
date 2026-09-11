local ChessBoardPropList = class("ChessBoardPropList", ReduxView)

;({}).showState = {
	selected = "selected",
	name = "state",
	grey = "grey",
	blank = "blank",
	normal = "normal"
}

function ChessBoardPropList:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.closeSelectState = arg_1_2 or false

	self:Init()
end

function ChessBoardPropList:Init()
	self:InitUI()
end

function ChessBoardPropList:InitUI()
	self:BindCfgUI()

	self.selectItemClickHandle_ = handler(self, self.OnSelectItemClick)
	self.propList = {}

	for iter_3_0 = 1, ChessBoardConst.CHESSBOARD_MAX_PROP_NUMS do
		self.propList[iter_3_0] = ChessBoardPropItem.New(self[string.format("propItem%sGo_", iter_3_0)], iter_3_0)

		self.propList[iter_3_0]:SetSelectHandle(self.selectItemClickHandle_)
	end
end

function ChessBoardPropList:OnSelectItemClick(arg_4_1)
	if self.closeSelectState then
		return
	end

	if self.propList[self.SelectIndex] then
		self.propList[self.SelectIndex]:SetSelectState(arg_4_1)
	end

	self.SelectIndex = arg_4_1

	if self.propList[self.SelectIndex] then
		self.propList[self.SelectIndex]:SetSelectState(arg_4_1)
	end
end

function ChessBoardPropList:OnEnter()
	self.SelectIndex = nil

	self:RefreshList()
end

function ChessBoardPropList:CheckGetEffect()
	local var_6_0 = #manager.ChessBoardManager:GetHeroProp()

	if self.propList[var_6_0] then
		self.propList[var_6_0]:ShowGetEffect()
	end
end

function ChessBoardPropList:RefreshList()
	local var_7_0 = manager.ChessBoardManager:GetHeroProp()

	for iter_7_0, iter_7_1 in pairs(self.propList) do
		iter_7_1:Refresh(var_7_0[iter_7_0] or nil)
	end
end

function ChessBoardPropList:SetClickHandle(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(self.propList or {}) do
		iter_8_1:SetClickHandle(arg_8_1)
	end
end

function ChessBoardPropList:ClickTargetProp(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.propList) do
		if iter_9_0 == arg_9_1 then
			iter_9_1:OnClick()

			break
		end
	end
end

function ChessBoardPropList:GetSelectIndex()
	return self.SelectIndex
end

function ChessBoardPropList:SetUnInteractable()
	for iter_11_0, iter_11_1 in pairs(self.propList) do
		iter_11_1:SetUnInteractable()
	end
end

function ChessBoardPropList:StartArenaChance()
	for iter_12_0, iter_12_1 in pairs(self.propList) do
		iter_12_1:StartArenaChance()
	end
end

function ChessBoardPropList:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.propList) do
		iter_13_1:Dispose()
	end

	self.propList = nil

	self.super.Dispose(self)
end

return ChessBoardPropList
