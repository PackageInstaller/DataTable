local NewEducateNodePanel = class("NewEducateNodePanel", import("view.base.BaseSubView"))

NewEducateNodePanel.NODE_TYPE = {
	MAIN_OPTION = 104,
	EVENT_TEXT = 100,
	MAIN_TEXT = 103,
	STORY_BRANCH = 2,
	DROP = 102,
	EVENT_OPTION = 101,
	PERFORMANCE = 1
}
NewEducateNodePanel.NEXT_TYPE = {
	OPTION = 2,
	NOMARL = 1,
	STORY_FLAG = 4,
	PROBABILITY = 3
}
NewEducateNodePanel.DROP_TYPE = {
	POLAROID = 4,
	WORD_PERFORMANCE = 1,
	EVENT = 3,
	MAIN_TIP = 2,
	DROP_LAYER = 5
}

function NewEducateNodePanel:getUIName()
	return "NewEducateNodeUI"
end

function NewEducateNodePanel:OnLoaded()
	eachChild(self._tf, function(arg_3_0)
		setActive(arg_3_0, false)

		return
	end)

	self.loopCpkTF = self._tf:Find("cpk_bg")
	self.loopCpkTF:GetComponent(typeof(Image)).enabled = false
	self.loopCpkPlayer = self.loopCpkTF:Find("cpk/usm"):GetComponent(typeof(CriManaCpkUI))

	self.loopCpkPlayer:SetMaxFrameDrop(CriWare.CriManaMovieMaterialBase.MaxFrameDrop.Infinite)

	self.cpkHandler = NewEducateCpkHandler.New(self._tf:Find("cpk"))
	self.pictureHandler = NewEducatePictureHandler.New(self._tf:Find("picture"))
	self.wordHandler = NewEducateWordHandler.New(self._tf:Find("dialogue"))
	self.dropHandler = NewEducateDropHandler.New(self._tf:Find("drop"))
	self.siteHandler = NewEducateSiteHandler.New(self._tf:Find("site"))
	self.optionsHandler = NewEducateOptionsHandler.New(self._tf:Find("options"))
	self.minigameHandler = NewEducateMinigameHandler.New(self._tf:Find("minigame"), self.contextData.view)
	self.scheduleTF = self._tf:Find("scheduleBg")

	setText(self.scheduleTF:Find("root/window/left/title/Text"), i18n("child_plan_perform_title"))

	local var_2_0 = self.scheduleTF:Find("root/window/left/content")

	self.planUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	return
end

function NewEducateNodePanel:OnInit()
	self.siteHandler:BindEndBtn(function()
		self:Hide()

		return
	end, self.contextData.onSiteEnd, self.contextData.onNormal)
	self.planUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventInit then
			setActive(arg_6_2:Find("icon"), self.plans[arg_6_1 + 1])

			if self.plans[arg_6_1 + 1] then
				LoadImageSpriteAtlasAsync("ui/neweducatecommonui_atlas", "plan_type" .. pg.child2_plan[self.plans[arg_6_1 + 1]].replace_type_show, arg_6_2:Find("icon"))
			end
		elseif arg_6_0 == UIItemList.EventUpdate then
			arg_6_1 = arg_6_1 + 1

			if self.plans[arg_6_1] then
				setText(arg_6_2:Find("Text"), shortenString(pg.child2_plan[self.plans[arg_6_1]].name_2, 4))
				setTextColor(arg_6_2:Find("Text"), Color.NewHex((arg_6_1 == self.curPlanIdx or nil) and "29bfff"))
				setActive(arg_6_2:Find("selected"), arg_6_1 == self.curPlanIdx)
			else
				setText(arg_6_2:Find("Text"), i18n("child2_empty_plan"))
				setActive(arg_6_2:Find("selected"), false)
			end
		end

		return
	end)
	self:OverlayPanel(self._tf, {
		groupDelta = 2
	})

	return
end

function NewEducateNodePanel:PlayLoopCpk(arg_7_1)
	self.loopCpkPlayer.cpkPath = string.lower("OriginSource/cpk/" .. arg_7_1 .. ".cpk")
	self.loopCpkPlayer.movieName = string.lower(arg_7_1 .. ".bytes")

	self.loopCpkPlayer:StopCpk()
	self.loopCpkPlayer:SetCpkTotalTimeCallback(function(arg_8_0)
		self.loopCpkTF:GetComponent(typeof(Image)).enabled = true

		return
	end)
	setActive(self.loopCpkTF, true)
	self.loopCpkPlayer:PlayCpk()

	return
end

function NewEducateNodePanel:StopLoopCpk()
	setActive(self.loopCpkTF, false)

	self.loopCpkTF:GetComponent(typeof(Image)).enabled = false

	return
end

function NewEducateNodePanel:StartNode(arg_10_1)
	self:Show()

	self.stystemNo = self.contextData.char:GetFSM():GetSystemNo()

	setActive(self.scheduleTF, self.stystemNo == NewEducateFSM.SYSTEM.PLAN)

	if self.stystemNo == NewEducateFSM.SYSTEM.MAP then
		local var_10_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP):GetCurSiteId()

		self.siteHandler:SetSite(var_10_0)

		local var_10_1 = 0

		if pg.child2_site_display[var_10_0].type == NewEducateConst.SITE_TYPE.WORK then
			var_10_1 = self.contextData.char:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.WORK)
		elseif pg.child2_site_display[var_10_0].type == NewEducateConst.SITE_TYPE.TRAVEL then
			var_10_1 = self.contextData.char:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.TRAVEL)
		end

		if var_10_1 ~= 0 then
			self:PlayLoopCpk(pg.child2_site_normal[var_10_1].cpk[self.contextData.char:GetRoundData():getConfig("stage")])
		end
	end

	self:ProceedNode(arg_10_1)

	return
end

function NewEducateNodePanel:OnNodeChainEnd()
	setActive(self.loopCpkTF, false)

	if self.stystemNo == NewEducateFSM.SYSTEM.MAP then
		self.cpkHandler:Reset()
		self.pictureHandler:Reset()
		self.wordHandler:Reset()
		self.dropHandler:Reset()
		self.minigameHandler:Reset()
		self.siteHandler:OnEventEnd()
	elseif self.stystemNo == NewEducateFSM.SYSTEM.PLAN then
		if self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.PLAN):IsFinish() then
			self:Hide()
		end
	else
		self:Hide()
	end

	return
end

function NewEducateNodePanel:InitCallback(arg_12_1)
	self.callback = nil

	switch(arg_12_1, {
		[NewEducateNodePanel.NEXT_TYPE.NOMARL] = function()
			function self.callback()
				pg.m02:sendNotification(GAME.NEW_EDUCATE_TRIGGER_NODE, {
					id = self.contextData.char.id
				})

				return
			end

			return
		end,
		[NewEducateNodePanel.NEXT_TYPE.PROBABILITY] = function()
			function self.callback()
				pg.m02:sendNotification(GAME.NEW_EDUCATE_TRIGGER_NODE, {
					id = self.contextData.char.id
				})

				return
			end

			return
		end,
		[NewEducateNodePanel.NEXT_TYPE.OPTION] = function()
			function self.callback(arg_18_0, arg_18_1)
				pg.m02:sendNotification(GAME.NEW_EDUCATE_TRIGGER_NODE, {
					id = self.contextData.char.id,
					branch = arg_18_0,
					costs = arg_18_1
				})

				return
			end

			return
		end,
		[NewEducateNodePanel.NEXT_TYPE.STORY_FLAG] = function()
			function self.callback(arg_20_0)
				pg.m02:sendNotification(GAME.NEW_EDUCATE_TRIGGER_NODE, {
					id = self.contextData.char.id,
					branch = arg_20_0
				})

				return
			end

			return
		end
	}, function()
		assert(false, "node表非法next_type: " .. arg_12_1)

		return
	end)

	return
end

function NewEducateNodePanel:CheckSchedule()
	if self.stystemNo == NewEducateFSM.SYSTEM.PLAN then
		local var_22_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.PLAN)

		self.unlockPlanNum = self.contextData.char:GetRoundData():getConfig("plan_num")
		self.plans = var_22_0:GetPlans()
		self.curPlanIdx = var_22_0:GetCurIdx()

		self.planUIList:align(self.unlockPlanNum)
	end

	return
end

function NewEducateNodePanel:CheckLastDrops(arg_23_1, arg_23_2)
	if not self.curNodeId or not arg_23_1 or #arg_23_1 == 0 then
		arg_23_2()
	else
		local var_23_0 = pg.child2_node[self.curNodeId]
		local var_23_1 = pg.child2_node[self.curNodeId].drop_type_client

		switch(pg.child2_node[self.curNodeId].drop_type_client, {
			[NewEducateNodePanel.DROP_TYPE.WORD_PERFORMANCE] = function()
				if self.stystemNo == NewEducateFSM.SYSTEM.PLAN then
					self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.PLAN):AddDrops(arg_23_1)
				end

				self.wordHandler:Play(var_23_0.performance_param[1], arg_23_2, arg_23_1, false)

				return
			end,
			[NewEducateNodePanel.DROP_TYPE.MAIN_TIP] = function()
				self.dropHandler:Play(arg_23_1, arg_23_2)
				self.wordHandler:Reset()

				return
			end,
			[NewEducateNodePanel.DROP_TYPE.EVENT] = function()
				seriesAsync({
					function(arg_27_0)
						local var_27_0 = underscore.select(arg_23_1, function(arg_28_0)
							return arg_28_0.type == NewEducateConst.DROP_TYPE.BUFF
						end)

						if #var_27_0 > 0 then
							self:emit(NewEducateBaseUI.ON_DROP, {
								items = var_27_0,
								removeFunc = arg_27_0
							})
						else
							arg_27_0()
						end

						return
					end
				}, function()
					self.siteHandler:Play(self.curNodeId, arg_23_2, arg_23_1)

					return
				end)

				return
			end,
			[NewEducateNodePanel.DROP_TYPE.POLAROID] = function()
				self:StopLoopCpk()
				self.cpkHandler:Reset()
				self.wordHandler:Reset()

				local var_30_0 = {}

				for iter_30_0, iter_30_1 in ipairs(arg_23_1) do
					assert(iter_30_1.type == NewEducateConst.DROP_TYPE.POLAROID, "drop_type_client4的掉落必须为大头贴")
					table.insert(var_30_0, function(arg_31_0)
						self.dropHandler:PlayPolaroid(iter_30_1, arg_31_0)

						return
					end)
					table.insert(var_30_0, function(arg_32_0)
						if #pg.child2_polaroid[iter_30_1.id].desc > 0 then
							self.wordHandler:PlayWordIds(pg.child2_polaroid[iter_30_1.id].desc, arg_32_0)
						else
							arg_32_0()
						end

						return
					end)
				end

				seriesAsync(var_30_0, function()
					existCall(arg_23_2)

					if #arg_23_1 > 0 then
						pg.TipsMgr.GetInstance():ShowTips(i18n("child_polaroid_get_tip"))
					end

					return
				end)

				return
			end,
			[NewEducateNodePanel.DROP_TYPE.DROP_LAYER] = function()
				self:emit(NewEducateBaseUI.ON_DROP, {
					items = arg_23_1,
					removeFunc = arg_23_2
				})

				return
			end
		}, function()
			warning("node表非法drop_type_client: " .. var_23_1 .. ",node:" .. self.curNodeId)
			self:emit(NewEducateBaseUI.ON_DROP, {
				items = arg_23_1,
				removeFunc = arg_23_2
			})

			return
		end)

		if self.stystemNo == NewEducateFSM.SYSTEM.MAP and pg.child2_node[self.curNodeId].drop_type_client == NewEducateNodePanel.DROP_TYPE.WORD_PERFORMANCE then
			self.siteHandler:AddDropRecords(arg_23_1)
		end
	end

	return
end

function NewEducateNodePanel:ProceedNode(arg_36_1, arg_36_2, arg_36_3)
	seriesAsync({
		function(arg_37_0)
			self:CheckLastDrops(arg_36_2, arg_37_0)

			return
		end
	}, function()
		self:_ProceedNode(arg_36_1, arg_36_2, arg_36_3)

		return
	end)

	return
end

function NewEducateNodePanel:_ProceedNode(arg_39_1, arg_39_2, arg_39_3)
	self.curNodeId = arg_39_1

	if self.curNodeId == 0 then
		existCall(arg_39_3)
		self:OnNodeChainEnd()

		return
	end

	self:CheckSchedule()

	local var_39_0 = pg.child2_node[arg_39_1]

	originalPrint("ProceedNode", arg_39_1)
	self:InitCallback(pg.child2_node[arg_39_1].next_type)
	switch(pg.child2_node[arg_39_1].type, {
		[NewEducateNodePanel.NODE_TYPE.PERFORMANCE] = function()
			self:PlayPerformances(var_39_0.performance_type, var_39_0.performance_param, self.callback)

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.DROP] = function()
			self.callback()

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.STORY_BRANCH] = function()
			self:PlayStoryBranch(var_39_0.performance_param, function(arg_43_0)
				self.callback(arg_43_0)

				return
			end)

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.EVENT_TEXT] = function()
			self.siteHandler:Play(arg_39_1, self.callback)

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.EVENT_OPTION] = function()
			self.siteHandler:Play(arg_39_1, self.callback)

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.MAIN_TEXT] = function()
			local var_46_0 = self:_IsShowNextInMainText(var_39_0)

			if var_39_0.next_type == NewEducateNodePanel.NEXT_TYPE.OPTION then
				self.wordHandler:Play(tonumber(var_39_0.text), function()
					self.optionsHandler:Play(var_39_0.next, self.callback)

					return
				end, nil, var_46_0, true)
			else
				self.wordHandler:Play(tonumber(var_39_0.text), self.callback, nil, var_46_0, true)
			end

			return
		end,
		[NewEducateNodePanel.NODE_TYPE.MAIN_OPTION] = function()
			self.callback()

			return
		end
	}, function()
		assert(false, "node表非法type: " .. var_39_0.type)

		return
	end)

	return
end

function NewEducateNodePanel:_IsShowNextInMainText(arg_50_1)
	if arg_50_1.next == "" then
		return false
	end

	if arg_50_1.next_type == NewEducateNodePanel.NEXT_TYPE.NOMARL then
		return pg.child2_node[tonumber(arg_50_1.next)].type ~= NewEducateNodePanel.NODE_TYPE.DROP
	end

	return true
end

function NewEducateNodePanel:PlayPerformances(arg_51_1, arg_51_2, arg_51_3)
	switch(arg_51_1, {
		[NewEducateConst.PERFORM_TYPE.CPK] = function()
			self.wordHandler:Reset()

			local var_52_0 = self.contextData.char:GetRoundData():getConfig("stage")
			local var_52_1 = ""

			if self.stystemNo == NewEducateFSM.SYSTEM.PLAN then
				var_52_1 = pg.child2_plan[self.plans[self.curPlanIdx]].name
			end

			self.cpkHandler:SetUIParam(self.stystemNo == NewEducateFSM.SYSTEM.PLAN)
			self.cpkHandler:Play(arg_51_2[var_52_0], arg_51_3, var_52_1)

			return
		end,
		[NewEducateConst.PERFORM_TYPE.PICTURE] = function()
			self.wordHandler:Reset()
			self.pictureHandler:Play(arg_51_2, arg_51_3)

			return
		end,
		[NewEducateConst.PERFORM_TYPE.WORD] = function()
			self.wordHandler:Play(arg_51_2[1], arg_51_3, nil, not (pg.child2_node[self.curNodeId].next == ""), true)

			return
		end,
		[NewEducateConst.PERFORM_TYPE.STORY] = function()
			NewEducateHelper.PlaySpecialStory(arg_51_2, function(arg_56_0, arg_56_1)
				arg_51_3(arg_56_1)

				return
			end, true)

			return
		end,
		[NewEducateConst.PERFORM_TYPE.MINIGAME] = function()
			self.minigameHandler:Play(tonumber(arg_51_2), function(arg_58_0)
				arg_51_3(arg_58_0)
				self.minigameHandler:Reset()

				return
			end)

			return
		end
	}, function()
		assert(false, "node表非法performance_type: " .. arg_51_1)

		return
	end)

	return
end

function NewEducateNodePanel:PlayStoryBranch(arg_60_1, arg_60_2)
	NewEducateHelper.PlaySpecialStory(arg_60_1, function(arg_61_0, arg_61_1)
		arg_60_2(arg_61_1)

		return
	end, true)

	return
end

function NewEducateNodePanel:PlayWordIds(arg_62_1, arg_62_2)
	self:Show()
	self.wordHandler:PlayWordIds(arg_62_1, function()
		self.wordHandler:Reset()
		self.super.Hide(self)
		existCall(arg_62_2)

		return
	end)

	return
end

function NewEducateNodePanel:UpdateCallName()
	self.wordHandler:UpdateCallName()
	self.siteHandler:UpdateCallName()
	self.optionsHandler:UpdateCallName()

	return
end

function NewEducateNodePanel:Hide()
	existCall(self.contextData.onHide)
	self:StopLoopCpk()
	self.cpkHandler:Reset()
	self.pictureHandler:Reset()
	self.wordHandler:Reset()
	self.dropHandler:Reset()
	self.siteHandler:Reset()
	self.optionsHandler:Reset()
	self.minigameHandler:Reset()
	self.super.Hide(self)

	return
end

function NewEducateNodePanel:OnDestroy()
	self:UnOverlayPanel(self._tf, self._parentTf)

	if self.cpkHandler then
		self.cpkHandler:Destroy()
	end

	if self.pictureHandler then
		self.pictureHandler:Destroy()
	end

	if self.wordHandler then
		self.wordHandler:Destroy()
	end

	if self.dropHandler then
		self.dropHandler:Destroy()
	end

	if self.siteHandler then
		self.siteHandler:Destroy()
	end

	if self.optionsHandler then
		self.optionsHandler:Destroy()
	end

	if self.minigameHandler then
		self.minigameHandler:Destroy()
	end

	return
end

return NewEducateNodePanel
