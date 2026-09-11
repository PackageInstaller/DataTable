local ChessPurify = class("ChessPurify", ReduxView)

function ChessPurify:UIName()
	return "Widget/System/WarChess_Battle/WarChessPurifyUI"
end

function ChessPurify:UIParent()
	return manager.ui.uiMain.transform
end

function ChessPurify:Init()
	self:InitUI()
	self:AddUIListener()

	self.itemList_ = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, ChessPurifyItem)
end

function ChessPurify:InitUI()
	self:BindCfgUI()
end

function ChessPurify:AddUIListener()
	self:AddBtnListener(self.btn_tickBtn_, nil, function()
		if self.selectItem_ == 0 then
			ShowTips("NO_DEBUFF")
		else
			local var_6_0 = manager.ChessManager:GetExecutingChess()

			WarChessAction.PurifyDeBuff({
				x = var_6_0.x,
				z = var_6_0.z
			}, self.itemList_[self.selectItem_])
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
		manager.ChessManager:EventsEnd()
	end)
end

function ChessPurify:OnPurifyDeBuff(arg_8_1, arg_8_2)
	if arg_8_2.param ~= 0 then
		if isSuccess(arg_8_1.result) then
			WarChessData:ModifyArtifactData(arg_8_2.param, -1)
			self:Back()
			manager.ChessManager:DoNextEvent()
			ShowTips("PURIFY_SUCCESS")
		else
			self:Back()
			manager.ChessManager:EventsEnd()
			ShowTips(arg_8_1.result)
		end
	end
end

function ChessPurify:RefreshUI()
	self.selectItem_ = 0

	self:UpdateData()
	self.scrollHelper_:StartScroll(#self.itemList_)
end

function ChessPurify:UpdateData()
	self.itemList_ = {}

	for iter_10_0, iter_10_1 in pairs((WarChessData:GetArtifactData())) do
		if WarchessItemCfg[iter_10_0].identify_buff == 1 then
			table.insert(self.itemList_, iter_10_0)
		end
	end
end

function ChessPurify:indexItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(arg_11_1, {
		id = self.itemList_[arg_11_1]
	})
	arg_11_2:SetSelectedState(arg_11_1 == self.selectItem_)
	arg_11_2:RegisterListener(function(arg_12_0)
		if arg_12_0 ~= self.selectItem_ then
			self.selectItem_ = arg_12_0

			self.scrollHelper_:Refresh()

			self.btn_tickBtn_.interactable = true

			SetActive(self.itemiconGo_, true)

			self.itemiconImg_.sprite = getSprite("Atlas/WarChess_BattleAtlas", WarchessItemCfg[self.itemList_[arg_12_0]].icon)
			self.nameText_.text = GetI18NText(WarchessItemCfg[self.itemList_[arg_12_0]].name)
		end
	end)
end

function ChessPurify:OnEnter()
	self:RefreshUI()
	SetActive(self.itemiconGo_, false)

	self.btn_tickBtn_.interactable = false
	self.nameText_.text = ""
end

function ChessPurify:OnExit()
	return
end

function ChessPurify:Dispose()
	self.scrollHelper_:Dispose()
	ChessPurify.super.Dispose(self)
end

return ChessPurify
