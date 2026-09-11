local AreaBattleSelectView = class("AreaBattleSelectView", ReduxView)

function AreaBattleSelectView:UIName()
	return ActivityAreaBattleData:GetPrefabByActivityID(self.params_.mainActivityID) .. "NormalfightingSelectUI"
end

function AreaBattleSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function AreaBattleSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AreaBattleSelectView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, AreaBattleSelectItem)
	self.raceController = self.raceController_:GetController("name")
	self.buffController = self.buffController_:GetController("name")
end

function AreaBattleSelectView:SetItem(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1

	if self.raceController:GetSelectedState() == "false" then
		var_5_0 = var_5_0 + 8
	end

	arg_5_2:SetData(self.typeList[arg_5_1], arg_5_1, handler(self, self.ClickCallBack), self, var_5_0, self.listGo_.transform.rect)
end

function AreaBattleSelectView:AddUIListener()
	self:AddBtnListener(self.clearBtn_, nil, function()
		self.selectList = {}
		self.canUsePoint = self.maxPoint

		self:UpdateBottom()

		for iter_7_0, iter_7_1 in pairs(self.list:GetItemList()) do
			iter_7_1:Clear()
		end

		saveData("AreaBattle", tostring(self.stageID), "")
	end)
	self:AddBtnListener(self.raceBtn_, nil, function()
		if self.raceController:GetSelectedState() == "false" then
			self.raceController:SetSelectedState("true")
			self.buffController:SetSelectedState("false")
			self:UpdateBuff(self.raceController:GetSelectedState() == "true", self.buffController:GetSelectedState() == "true")
			self:UpdateView()
		end
	end)
	self:AddBtnListener(self.buffBtn_, nil, function()
		if self.buffController:GetSelectedState() == "false" then
			self.buffController:SetSelectedState("true")
			self.raceController:SetSelectedState("false")
			self:UpdateBuff(self.raceController:GetSelectedState() == "true", self.buffController:GetSelectedState() == "true")
			self:UpdateView()
		end
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in pairs(self.selectList) do
			table.insert(var_10_0, iter_10_0)
		end

		AreaBattleAction.SaveAffix(self.activityID, var_10_0, self.stageID)
		gameContext:Go("/sectionSelectHero", {
			section = self.stageID,
			sectionType = BattleConst.STAGE_TYPE_NEW.AREA_BATTLE,
			activityID = self.activityID
		})
	end)
end

function AreaBattleSelectView:UpdateView()
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.listGo_.transform)
	TimeTools.StartAfterSeconds(0.1, function()
		self.list:StartScroll(#self.typeList)
		self:UpdateBottom()

		if self.index ~= 999 then
			self.list:ScrollToIndex(self.index, false, false)
		end
	end, {})
end

function AreaBattleSelectView:UpdateBottom()
	self.canUseTxt_.text = self.canUsePoint .. "/" .. self.maxPoint
	self.totalTxt_.text = self.canUsePoint
end

function AreaBattleSelectView:ClickCallBack()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(self.selectList) do
		var_14_0 = var_14_0 + 1
	end

	self.canUsePoint = self.maxPoint - var_14_0

	self:UpdateBottom()

	local var_14_1 = ""

	for iter_14_2, iter_14_3 in pairs(self.selectList) do
		var_14_1 = var_14_1 .. iter_14_2 .. "," .. tostring(iter_14_3) .. "."
	end

	saveData("AreaBattle", tostring(self.stageID), var_14_1)
end

function AreaBattleSelectView:UpdateBuff(arg_15_1, arg_15_2)
	local var_15_0 = {}

	self.typeList = {}

	if self.canUsePoint < 0 then
		self.canUsePoint = self.maxPoint

		saveData("AreaBattle", tostring(self.stageID), "")

		self.selectList = {}
	end

	for iter_15_0, iter_15_1 in ipairs(self.buffList) do
		if var_15_0[TalentTreeCfg[iter_15_1].stage] == nil then
			var_15_0[TalentTreeCfg[iter_15_1].stage] = {}
		end

		table.insert(var_15_0[TalentTreeCfg[iter_15_1].stage], iter_15_1)
	end

	for iter_15_2, iter_15_3 in pairs(var_15_0) do
		table.sort(iter_15_3, function(arg_16_0, arg_16_1)
			return arg_16_0 < arg_16_1
		end)
	end

	for iter_15_4, iter_15_5 in ipairs(var_15_0) do
		for iter_15_6, iter_15_7 in pairs(iter_15_5) do
			if self.selectList[iter_15_7] then
				self.index = math.min(self.index, iter_15_4)
			end
		end
	end

	if not arg_15_1 and not arg_15_2 then
		if self.index > 8 and self.index ~= 999 then
			self.raceController:SetSelectedState("false")
			self.buffController:SetSelectedState("true")

			self.index = self.index - 8

			for iter_15_8, iter_15_9 in ipairs(var_15_0) do
				if iter_15_8 > 8 then
					table.insert(self.typeList, {
						data = iter_15_9,
						type = iter_15_8
					})
				end
			end
		else
			for iter_15_10, iter_15_11 in ipairs(var_15_0) do
				if iter_15_10 <= 8 then
					table.insert(self.typeList, {
						data = iter_15_11,
						type = iter_15_10
					})
				end
			end
		end
	else
		for iter_15_12, iter_15_13 in ipairs(var_15_0) do
			if arg_15_1 and iter_15_12 <= 8 then
				table.insert(self.typeList, {
					data = iter_15_13,
					type = iter_15_12
				})
			end

			if arg_15_2 and iter_15_12 > 8 then
				table.insert(self.typeList, {
					data = iter_15_13,
					type = iter_15_12
				})
			end
		end
	end
end

function AreaBattleSelectView:UpdateData()
	self.stageID = self.params_.stageID
	self.activityID = self.params_.activityID
	self.mainActivityID = self.params_.mainActivityID
	self.cfg = ActivityAreaBattleCfg[self.activityID]
	self.data = ActivityAreaBattleData:GetDataByActivityID(self.mainActivityID)[self.activityID]

	for iter_17_0, iter_17_1 in pairs(self.cfg.buff_list) do
		if iter_17_1[1] == self.stageID then
			self.buffList = iter_17_1[2]
			difficult = iter_17_0
		end
	end

	self.maxPoint = 0

	for iter_17_2, iter_17_3 in pairs(self.data.difficultList[self.params_.difficult] or {}) do
		if iter_17_2 ~= self.stageID then
			self.maxPoint = self.maxPoint + iter_17_3.point
		end
	end

	self.canUsePoint = self.maxPoint
	self.selectList = {}
	self.index = 999

	local var_17_0 = 0
	local var_17_1 = getData("AreaBattle", tostring(self.stageID)) or ""

	if var_17_1 ~= "" then
		for iter_17_4, iter_17_5 in ipairs((string.split(var_17_1, "."))) do
			if iter_17_5 ~= "" then
				self.selectList[tonumber(string.split(iter_17_5, ",")[1])] = true
				var_17_0 = var_17_0 + 1
			end
		end
	end

	self.canUsePoint = self.canUsePoint - var_17_0

	self:UpdateBuff()
end

function AreaBattleSelectView:OnEnter()
	self.raceController:SetSelectedState("true")
	self.buffController:SetSelectedState("false")
	self:UpdateData()
	self:UpdateView()
end

function AreaBattleSelectView:OnExit()
	manager.windowBar:HideBar()
end

function AreaBattleSelectView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AreaBattleSelectView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	AreaBattleSelectView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleSelectView
