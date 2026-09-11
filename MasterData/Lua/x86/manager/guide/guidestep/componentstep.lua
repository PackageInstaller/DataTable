local ComponentStep = class("ComponentStep", BaseStep)

function ComponentStep:Init(arg_1_1)
	local var_1_0 = GuideStepCfg[self._stepId]

	self._guideComponentCfg = GuideStepCfg[self._stepId].guide_component
	self._maskComponentCfg = var_1_0.mask_component
	self._params = var_1_0.params
	self._maskScale = var_1_0.mask_scale == "" and Vector3.New(1, 1, 1) or Vector3.New(var_1_0.mask_scale[1] or 1, var_1_0.mask_scale[2] or 1, 1)
	self.isHideMask = var_1_0.has_mask == 1
end

function ComponentStep:OnStepEnd()
	ComponentStep.super.OnStepEnd(self)

	self._component = nil
end

function ComponentStep:Check()
	return self:Component() ~= nil
end

function ComponentStep:GetShowMask()
	return true
end

function ComponentStep:Play()
	manager.guide.view:Init()
	self:ShowTalk()

	local var_5_0 = self:AnalyzeComponentCfg(self._maskComponentCfg)

	manager.guide.view:ShowHoldMask((var_5_0 or nil) and (var_5_0.gameObject or self:Component().gameObject), self._maskScale, self._params, self.isHideMask)
end

function ComponentStep:Component()
	if self._component == nil then
		self:SetSpecialParams()

		self._component = self:AnalyzeComponentCfg(self._guideComponentCfg)
	end

	return self._component
end

function ComponentStep:AnalyzeComponentCfg(arg_7_1)
	if arg_7_1 == "" or #arg_7_1 == 0 then
		return nil
	end

	local var_7_0 = string.split(arg_7_1[1], "_")
	local var_7_1 = var_7_0[2] and var_7_0[2] == "getcom"

	if var_7_0[1] == "common" then
		local var_7_2 = self:GetViewComponent(arg_7_1[2], arg_7_1[3])

		if var_7_2 and var_7_1 then
			return var_7_2:GetComponent(arg_7_1[4])
		end

		return var_7_2
	elseif var_7_0[1] == "child" then
		local var_7_3 = self:GetViewComponent(arg_7_1[2], arg_7_1[3])

		if var_7_3 then
			local var_7_4 = var_7_3.transform:Find(arg_7_1[4])

			if var_7_4 and var_7_1 then
				return var_7_4:GetComponent(arg_7_1[5])
			end

			return var_7_4
		end
	elseif var_7_0[1] == "listIndex" then
		local var_7_5 = self:GetViewComponent(arg_7_1[2], arg_7_1[3])

		if var_7_5 then
			local var_7_6 = var_7_5:GetItemList()

			if var_7_6 and var_7_6[arg_7_1[4]] then
				local var_7_7 = self:GetComponentPath(var_7_6[arg_7_1[4]], arg_7_1[5])

				if var_7_7 and var_7_1 then
					return var_7_7:GetComponent(arg_7_1[6])
				end

				return var_7_7
			end
		end
	elseif var_7_0[1] == "windowBar" then
		if manager.windowBar:GetIsShow() then
			return manager.windowBar[arg_7_1[2]]
		end

		return nil
	elseif var_7_0[1] == "windowBarCurrency" then
		if manager.windowBar:GetIsShow() then
			if manager.windowBar.barGo_[arg_7_1[2]] then
				local var_7_8 = self:GetComponentPath(manager.windowBar.barGo_[arg_7_1[2]], arg_7_1[3])

				if var_7_8 and var_7_1 then
					return var_7_8:GetComponent(arg_7_1[4])
				end

				return var_7_8
			end
		end

		return nil
	elseif var_7_0[1] == "messageBox" then
		local var_7_9 = manager.messageBox:GetItemList()

		if var_7_9 then
			for iter_7_0, iter_7_1 in pairs(var_7_9) do
				for iter_7_2, iter_7_3 in pairs(iter_7_1 or {}) do
					if not iter_7_3:IsFree() then
						return iter_7_3[arg_7_1[2]]
					end
				end
			end
		end

		return nil
	elseif var_7_0[1] == "treeGroup" then
		local var_7_10 = self:GetViewComponent(arg_7_1[2], arg_7_1[3])

		if var_7_10 then
			local var_7_11 = var_7_10:GetGroupGameObjectById(arg_7_1[4])

			if var_7_11 then
				local var_7_12 = var_7_11:GetComponent("UITreeGroup")

				if var_7_12 then
					return var_7_12.toggle
				end
			end
		end
	elseif var_7_0[1] == "treeGroupChild" then
		local var_7_13 = self:GetViewComponent(arg_7_1[2], arg_7_1[3])

		if var_7_13 then
			local var_7_14 = var_7_13:GetGroupGameObjectById(arg_7_1[4])

			if var_7_14 then
				return var_7_14.transform:Find(arg_7_1[5])
			end
		end
	elseif var_7_0[1] == "treeItem" then
		local var_7_15 = self:GetViewComponent(arg_7_1[2], arg_7_1[3])

		if var_7_15 then
			local var_7_16 = var_7_15:GetItemGameObjectById(arg_7_1[4], arg_7_1[5])

			if var_7_16 then
				local var_7_17 = var_7_16:GetComponent("UITreeItem")

				if var_7_17 then
					return var_7_17.toggle
				end
			end
		end
	elseif var_7_0[1] == "rogueTeamBottomBar" then
		return manager.rogueTeamInGameInfoBox[arg_7_1[2]]
	elseif var_7_0[1] == "rogueTeamMechanismBar" then
		return manager.rogueTeamMechanismBar[arg_7_1[2]]
	else
		error("guide unknown way to get component" .. var_7_0[1])
	end
end

function ComponentStep:SetSpecialParams()
	if self._params[1] == "chapterMapContent" then
		BattleFieldAction.ChangeSelectChapterID(self._params[2])
	elseif self._params[1] == "chapterMap" then
		BattleFieldData:SetCacheChapterClient(self._params[2], self._params[3])
		manager.notify:Invoke(CHANGE_DUNGEON)
	elseif self._params[1] == "draw" then
		self._guideComponentCfg[4] = GuideTool.GetPoolIndex(self._params[2])
		self._maskComponentCfg[4] = GuideTool.GetPoolIndex(self._params[2])
	elseif self._params[1] == "chess" then
		if manager.ChessBoardManager and #manager.ChessBoardManager:GetHeroProp() > 1 then
			self._guideComponentCfg[3][3] = self._params[3]
		end
	end
end

function ComponentStep:GetViewComponent(arg_9_1, arg_9_2)
	local var_9_0 = gameContext:GetOpenPageHandler(arg_9_1)

	if var_9_0 then
		return self:GetComponentPath(var_9_0, arg_9_2)
	end

	return nil
end

function ComponentStep:GetComponentPath(arg_10_1, arg_10_2)
	local var_10_0 = 1
	local var_10_1

	while var_10_0 <= #arg_10_2 do
		local var_10_2 = var_10_0 == 1 and arg_10_1[arg_10_2[var_10_0]] or var_10_1[arg_10_2[var_10_0]]

		if var_10_2 then
			var_10_1 = var_10_2
			var_10_0 = var_10_0 + 1
		else
			return nil
		end
	end

	return var_10_1
end

return ComponentStep
