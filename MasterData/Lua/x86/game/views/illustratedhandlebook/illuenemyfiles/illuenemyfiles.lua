local IlluEnemyFiles = class("IlluEnemyFiles", ReduxView)
local var_0_1 = {
	7,
	8,
	6,
	10
}

function IlluEnemyFiles:UIName()
	return "Widget/System/IllustratedHandbook/IlluEnemyUI"
end

function IlluEnemyFiles:UIParent()
	return manager.ui.uiMain.transform
end

function IlluEnemyFiles:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluEnemyFiles:InitUI()
	self:BindCfgUI()

	self.scroll_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, IlluEnemyFilesItem)
	self.btnControllerList_ = {}

	for iter_4_0 = 1, 4 do
		self.btnControllerList_[iter_4_0] = ControllerUtil.GetController(self[string.format("btn%strs_", iter_4_0)], "name")
	end
end

function IlluEnemyFiles:AddUIListener()
	self:AddBtnListener(self.btn_1, nil, function()
		self:RefreshUI(1)

		self.params_.index = 1
	end)
	self:AddBtnListener(self.btn_2, nil, function()
		self:RefreshUI(2)

		self.params_.index = 2
	end)
	self:AddBtnListener(self.btn_3, nil, function()
		self:RefreshUI(3)

		self.params_.index = 3
	end)
	self:AddBtnListener(self.btn_4, nil, function()
		self:RefreshUI(4)

		self.params_.index = 4
	end)
end

function IlluEnemyFiles:UpdateDate(arg_10_1)
	self.itemList_ = {}

	if MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]] then
		for iter_10_0, iter_10_1 in pairs(MonsterCfg.get_id_list_by_race[var_0_1[arg_10_1]]) do
			if CollectMonsterCfg[iter_10_1].hide == 0 then
				table.insert(self.itemList_, {
					id = iter_10_1,
					name = GetMonsterName({
						iter_10_1
					})
				})
			elseif CollectMonsterCfg[iter_10_1].hide == 2 then
				-- block empty
			elseif IllustratedData:GetEnemyInfo()[iter_10_1] then
				table.insert(self.itemList_, {
					id = iter_10_1,
					name = GetMonsterName({
						iter_10_1
					})
				})
			end
		end
	end
end

function IlluEnemyFiles:RefreshNum(arg_11_1)
	local var_11_2 = IllustratedData:GetEnemyInfo()
	local var_11_3 = 0
	local var_11_4 = 0

	if MonsterCfg.get_id_list_by_race[var_0_1[arg_11_1]] then
		for iter_11_0, iter_11_1 in pairs(MonsterCfg.get_id_list_by_race[var_0_1[arg_11_1]]) do
			if var_11_2[iter_11_1] then
				var_11_3 = var_11_3 + 1
			end

			if not var_11_2[iter_11_1] and CollectMonsterCfg[iter_11_1].hide == 1 then
				var_11_4 = var_11_4 + 1
			end
		end
	end

	self.collectnumText_.text = var_11_3 .. "/" .. var_11_0 - var_11_4
end

function IlluEnemyFiles:indexItem(arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(self.itemList_[arg_12_1])
end

function IlluEnemyFiles:RefreshUI(arg_13_1, arg_13_2)
	self:UpdateDate(arg_13_1)

	if arg_13_2 then
		if self.params_.scrollPos_ then
			self.scroll_:StartScrollByPosition(#self.itemList_, self.params_.scrollPos_)
		else
			self.scroll_:StartScroll(#self.itemList_)
		end
	else
		self.scroll_:StartScroll(#self.itemList_)
	end

	self:RefreshNum(arg_13_1)

	for iter_13_0 = 1, 4 do
		self.btnControllerList_[iter_13_0]:SetSelectedState(tostring(arg_13_1 == iter_13_0))
	end
end

function IlluEnemyFiles:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.params_.index = self.params_.index or 1

	self:RefreshUI(self.params_.index, true)
	manager.redPoint:bindUIandKey(self.btn1trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[1]])
	manager.redPoint:bindUIandKey(self.btn2trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[2]])
	manager.redPoint:bindUIandKey(self.btn3trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[3]])
	manager.redPoint:bindUIandKey(self.btn4trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[4]])
end

function IlluEnemyFiles:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.btn1trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[1]])
	manager.redPoint:unbindUIandKey(self.btn2trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[2]])
	manager.redPoint:unbindUIandKey(self.btn3trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[3]])
	manager.redPoint:unbindUIandKey(self.btn4trs_, RedPointConst["ILUU_ENEMY" .. var_0_1[4]])

	self.params_.scrollPos_ = self.scroll_:GetScrolledPosition()
end

function IlluEnemyFiles:Dispose()
	self.scroll_:Dispose()

	self.scroll_ = nil

	IlluEnemyFiles.super.Dispose(self)
end

return IlluEnemyFiles
