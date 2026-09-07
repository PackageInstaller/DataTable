local MallMapScene = class("MallMapScene", import("view.base.BaseUI"))

MallMapScene.TYPE2INFOS = {
	[MallActivity.POINT_TYPE.SITE] = {
		"name_bg_blue",
		i18n("mall_point_name_type1"),
		"icon_site"
	},
	[MallActivity.POINT_TYPE.MAIN_STORY] = {
		"name_bg_green",
		i18n("mall_point_name_type2"),
		"icon_branch"
	},
	[MallActivity.POINT_TYPE.BRANCH_STORY] = {
		"name_bg_green",
		i18n("mall_point_name_type3"),
		"icon_branch"
	},
	[MallActivity.POINT_TYPE.INTERACT_STORY] = {
		"name_bg_orange",
		i18n("mall_point_name_type4"),
		""
	}
}

function MallMapScene:getUIName()
	return "MallMapUI"
end

function MallMapScene:init()
	onButton(self, self.uiBackBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHomeBtn, function()
		self:quickExitFunc()

		return
	end, SOUND_BACK)
	onButton(self, self.uiHelpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.mall_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiMallBtn, function()
		self:emit(MallMapMediator.CHANGE_SCENE, SCENE.MALL)

		return
	end, SFX_PANEL)
	onButton(self, self.uiBookBtn, function()
		self:emit(MallMapMediator.GO_SUBLAYER, Context.New({
			mediator = MallStoryLineMediator,
			viewComponent = MallStoryLineLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiOrderBtn, function()
		self:emit(MallMapMediator.GO_SUBLAYER, Context.New({
			mediator = MallOrderMediator,
			viewComponent = MallOrderLayer,
			data = {
				onExit = function()
					self:UpdateOrderTip()

					return
				end
			}
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.uiSummaryBtn, function()
		self:ShowSummaryBox()

		return
	end, SFX_PANEL)

	self.pointUIList = UIItemList.New(self.uiContentTF, self.uiContentTF:Find("tpl"))

	self.pointUIList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:UpdatePointTpl(arg_11_1, arg_11_2)
		end

		return
	end)

	self.siteBox = MallSiteBox.New(self._tf, self.event, self.contextData)
	self.summaryBox = MallSummaryBox.New(self._tf, self.event, self.contextData)

	setText(self.uiTitleText, i18n("mall_title"))
	setText(self.uiTitleEnText, i18n("mall_title_en"))

	return
end

function MallMapScene:didEnter()
	self:UpdateData()
	self:UpdateView()
	self:UpdateBg()
	self:CheckGuide()
	self:CheckOrderStory()

	return
end

function MallMapScene:CheckGuide()
	if not pg.NewStoryMgr.GetInstance():IsPlayed("MALL_GUIDE") then
		pg.NewGuideMgr.GetInstance():Play("MALL_GUIDE")
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = "MALL_GUIDE"
		})

		return
	end

	if not pg.NewStoryMgr.GetInstance():IsPlayed("MALL_GUIDE_2") then
		pg.NewGuideMgr.GetInstance():Play("MALL_GUIDE_2")
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = "MALL_GUIDE_2"
		})

		return
	end

	return
end

function MallMapScene:CheckOrderStory()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs((self.activity:GetOrderData():GetFinishedList())) do
		if pg.activity_mall_custom_order[iter_14_1].story_unlock ~= "" then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(pg.activity_mall_custom_order[iter_14_1].story_unlock) then
				table.insert(var_14_0, pg.activity_mall_custom_order[iter_14_1].story_unlock)
			end
		end
	end

	if #var_14_0 > 0 then
		local var_14_1 = {}

		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			table.insert(var_14_1, function(arg_15_0)
				pg.NewStoryMgr.GetInstance():Play(iter_14_3, arg_15_0)

				return
			end)
		end

		seriesAsync(var_14_1, function()
			return
		end)
	end

	return
end

function MallMapScene:UpdateData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	assert(self.activity and not self.activity:isEnd(), "not exist mall act, type: " .. ActivityConst.ACTIVITY_TYPE_MALL)

	self.triggeredIds = self.activity:GetTriggeredPointIds()
	self.showPointIds = {}

	for iter_17_0, iter_17_1 in pairs((self.activity:GetLevelData():GetUnlockStoryIdsByType())) do
		local var_17_0 = iter_17_0 ~= MallActivity.POINT_TYPE.SITE
		local var_17_1 = underscore.detect(iter_17_1, function(arg_18_0)
			return table.contains(self.triggeredIds, arg_18_0) and var_17_0 and (pg.activity_mall_story[arg_18_0].lua ~= "" and not pg.NewStoryMgr.GetInstance():IsPlayed(pg.activity_mall_story[arg_18_0].lua) or false) or true
		end)

		if var_17_1 then
			table.insert(self.showPointIds, var_17_1)
		end
	end

	self.bgConfig = self.activity:getConfig("config_client").bg_switch

	return
end

function MallMapScene:UpdateView()
	self.pointUIList:align(#self.showPointIds)
	self:UpdateOrderBtn()
	self:UpdateTips()

	return
end

function MallMapScene:UpdateBg()
	local var_20_0 = self:GetCurBg()

	if var_20_0 then
		setImageSprite(self.uiBgTF, LoadSprite("bg/" .. var_20_0), false)
	end

	return
end

function MallMapScene:GetCurBg()
	for iter_21_0 = #self.bgConfig, 1, -1 do
		if pg.NewStoryMgr.GetInstance():IsPlayed(self.bgConfig[iter_21_0][1]) then
			return self.bgConfig[iter_21_0][2]
		end
	end

	return nil
end

function MallMapScene:UpdateOrderBtn()
	setActive(self.uiOrderTimeTF, false)

	self.orderData = self.activity:GetOrderData()

	if self.orderData.id ~= 0 then
		if pg.TimeMgr.GetInstance():GetServerTime() < self.orderData:GetEndTime() then
			setActive(self.uiOrderTimeTF, true)
			self:StartTimer()
		end
	else
		self:StopTimer()
	end

	return
end

function MallMapScene:UpdateTips()
	setActive(self.uiMallTip, MallMapScene.IsMallTip())
	self:UpdateOrderTip()

	return
end

function MallMapScene:UpdateOrderTip()
	setActive(self.uiOrderTip, MallScene.IsOrderTip())

	return
end

function MallMapScene:UpdatePointTpl(arg_25_1, arg_25_2)
	local var_25_0 = self.showPointIds[arg_25_1 + 1]

	arg_25_2.name = self.showPointIds[arg_25_1 + 1]

	local var_25_1 = pg.activity_mall_story[self.showPointIds[arg_25_1 + 1]]

	setAnchoredPosition(arg_25_2, {
		x = pg.activity_mall_story[self.showPointIds[arg_25_1 + 1]].posion[1],
		y = pg.activity_mall_story[self.showPointIds[arg_25_1 + 1]].posion[2]
	})

	local var_25_2 = var_25_1.type
	local var_25_3 = MallMapScene.TYPE2INFOS[var_25_1.type]

	GetImageSpriteFromAtlasAsync("ui/mallmapui_atlas", MallMapScene.TYPE2INFOS[var_25_1.type][1], arg_25_2:Find("name"), true)
	setText(arg_25_2:Find("name/Text"), var_25_3[2])

	local var_25_4 = var_25_2 == MallActivity.POINT_TYPE.INTERACT_STORY

	setActive(arg_25_2:Find("ship"), var_25_2 == MallActivity.POINT_TYPE.INTERACT_STORY)
	setActive(arg_25_2:Find("icon"), not var_25_4)

	if var_25_4 then
		GetImageSpriteFromAtlasAsync(var_25_1.icon, "", arg_25_2:Find("ship"))
	else
		GetImageSpriteFromAtlasAsync("ui/mallmapui_atlas", var_25_3[3], arg_25_2:Find("icon"), true)
	end

	onButton(self, arg_25_2, function()
		if not table.contains(self.triggeredIds, var_25_0) then
			self:emit(MallMapMediator.TRIGGER_POINT, self.activity.id, var_25_0)
		end

		if var_25_2 == MallActivity.POINT_TYPE.SITE then
			self.siteBox:ExecuteAction("Show", var_25_0)
		else
			pg.NewStoryMgr.GetInstance():Play(var_25_1.lua, function()
				self:didEnter()

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function MallMapScene:StartTimer()
	self:StopTimer()

	self.orderEndTime = self.orderData:GetEndTime()
	self.timer = Timer.New(function()
		local var_29_0 = self.orderEndTime - pg.TimeMgr.GetInstance():GetServerTime()

		setText(self.uiOrderTimeTF:Find("Text"), pg.TimeMgr.GetInstance():DescCDTime(var_29_0))

		if var_29_0 <= 0 then
			self:UpdateOrderBtn()
			setActive(self.uiOrderTip, true)
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function MallMapScene:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MallMapScene:ShowSummaryBox()
	self.summaryBox:ExecuteAction("Show")

	return
end

function MallMapScene:onBackPressed()
	if self.siteBox and self.siteBox:isShowing() then
		self.siteBox:ExecuteAction("Hide")

		return
	end

	if self.summaryBox and self.summaryBox:isShowing() then
		self.summaryBox:ExecuteAction("Hide")

		return
	end

	MallMapScene.super.onBackPressed(self)

	return
end

function MallMapScene:willExit()
	if self.siteBox then
		self.siteBox:Destroy()

		self.siteBox = nil
	end

	if self.summaryBox then
		self.summaryBox:Destroy()

		self.summaryBox = nil
	end

	self:StopTimer()

	return
end

function MallMapScene.IsMallTip()
	return MallScene.IsAwardTip() or MallScene.IsOrderTip()
end

function MallMapScene.IsEntranceTip()
	local var_35_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)

	if not var_35_0 or var_35_0:isEnd() then
		return false
	end

	return MallScene.IsMapTip() or MallMapScene.IsMallTip()
end

return MallMapScene
