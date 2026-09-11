local CombineGameTeachView = class("CombineGameTeachView", ReduxView)

function CombineGameTeachView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfTeachUI"
end

function CombineGameTeachView:UIParent()
	return manager.ui.uiMain.transform
end

function CombineGameTeachView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CombineGameTeachView:InitUI()
	self:BindCfgUI()

	self.list1 = LuaList.New(handler(self, self.SetRewardItem1), self.list1Go_, CommonItem)
	self.list2 = LuaList.New(handler(self, self.SetRewardItem2), self.list2Go_, CommonItem)
	self.list3 = LuaList.New(handler(self, self.SetRewardItem3), self.list3Go_, CommonItem)
	self.controller1 = ControllerUtil.GetController(self.gameObject_.transform, "stage1")
	self.controller2 = ControllerUtil.GetController(self.gameObject_.transform, "stage2")
	self.controller3 = ControllerUtil.GetController(self.gameObject_.transform, "stage3")
end

function CombineGameTeachView:SetRewardItem1(arg_5_1, arg_5_2)
	self:SetRewardItem(arg_5_1, arg_5_2, ActivityCombineLevelCfg[self.idList[1]])
end

function CombineGameTeachView:SetRewardItem2(arg_6_1, arg_6_2)
	self:SetRewardItem(arg_6_1, arg_6_2, ActivityCombineLevelCfg[self.idList[2]])
end

function CombineGameTeachView:SetRewardItem3(arg_7_1, arg_7_2)
	self:SetRewardItem(arg_7_1, arg_7_2, ActivityCombineLevelCfg[self.idList[3]])
end

function CombineGameTeachView:SetRewardItem(arg_8_1, arg_8_2, arg_8_3)
	arg_8_2:RefreshData({
		id = arg_8_3.reward_list[arg_8_1][1],
		number = arg_8_3.reward_list[arg_8_1][2]
	})
	arg_8_2:RegistCallBack(function(arg_9_0)
		ShowPopItem(POP_ITEM, {
			arg_9_0.id,
			arg_9_0.number
		})
	end)
end

function CombineGameTeachView:AddUIListener()
	for iter_10_0 = 1, 3 do
		self:AddBtnListener(self["start" .. iter_10_0 .. "Btn_"], nil, function()
			if self["controller" .. iter_10_0]:GetSelectedState() == "lock" then
				ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[self.idList[1]].name)))

				return
			end

			CombineGameFactory:StartGame(self.idList[iter_10_0], nil, 1)
			manager.redPoint:setTip(string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(self.activityId), self.activityId, self.idList[iter_10_0]), 0)
		end)
	end
end

function CombineGameTeachView:OnEnter()
	self.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(self.activityId) then
		gameContext:Go("/home", nil, nil, true)
		ShowTips("TIME_OVER")

		return
	end

	self:UpdateView()
	self:BindRedPoint()
end

function CombineGameTeachView:UpdateView()
	self.idList = {}
	self.activityId = CombineGameData:GetDataByPara("activityId")

	for iter_13_0, iter_13_1 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[iter_13_0].type == CombineGameConst.TypeConst.TEACH or ActivityCombineLevelCfg[iter_13_0].type == CombineGameConst.TypeConst.HERO_TEACH then
			table.insert(self.idList, iter_13_0)
		end
	end

	local var_13_0 = CombineGameData:GetDataByPara("stageDataTable")

	for iter_13_2, iter_13_3 in ipairs(self.idList) do
		self["list" .. iter_13_2]:StartScroll(#ActivityCombineLevelCfg[iter_13_2].reward_list)

		self["title" .. iter_13_2 .. "Txt_"].text = GetI18NText(ActivityCombineLevelCfg[iter_13_2].name)
		self["start" .. iter_13_2 .. "Txt_"].text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")

		self["controller" .. iter_13_2]:SetSelectedState("normal")

		if self["lock" .. iter_13_2 .. "Txt_"] then
			self["lock" .. iter_13_2 .. "Txt_"].text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[self.idList[1]].name))
		end

		if var_13_0[self.idList[iter_13_2]] == true then
			self["controller" .. iter_13_2]:SetSelectedState("pass")
		elseif iter_13_2 > 1 then
			self["controller" .. iter_13_2]:SetSelectedState(var_13_0[self.idList[1]] == true and "normal" or "lock")
		else
			self["controller" .. iter_13_2]:SetSelectedState("normal")
		end
	end

	self.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_1")
	self.descTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_1")
end

function CombineGameTeachView:OnCombineGameRefresh()
	self:UpdateView()
end

function CombineGameTeachView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.start1Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(self.activityId), self.activityId, self.idList[1]), {
		x = 105,
		y = 35
	})
	manager.redPoint:bindUIandKey(self.start2Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(self.activityId), self.activityId, self.idList[2]), {
		x = 105,
		y = 35
	})
	manager.redPoint:bindUIandKey(self.start3Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(self.activityId), self.activityId, self.idList[3]), {
		x = 105,
		y = 35
	})
end

function CombineGameTeachView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.start1Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(self.activityId), self.activityId, self.idList[1]))
	manager.redPoint:unbindUIandKey(self.start2Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(self.activityId), self.activityId, self.idList[2]))
	manager.redPoint:unbindUIandKey(self.start3Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(self.activityId), self.activityId, self.idList[3]))
end

function CombineGameTeachView:OnExit()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function CombineGameTeachView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CombineGameTeachView:Dispose()
	for iter_19_0 = 1, 3 do
		if self["list" .. iter_19_0] then
			self["list" .. iter_19_0]:Dispose()

			self["list" .. iter_19_0] = nil
		end
	end

	CombineGameTeachView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameTeachView
