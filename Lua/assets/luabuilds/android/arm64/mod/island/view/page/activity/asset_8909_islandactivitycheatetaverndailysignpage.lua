local IslandActivityCheateTavernDailySignPage = class("IslandActivityCheateTavernDailySignPage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function IslandActivityCheateTavernDailySignPage:OnInit()
	self.scrollCom = self.uiView:GetComponent("LScrollRect")

	function self.scrollCom.onInitItem(arg_2_0)
		self:InitAward(tf(arg_2_0))

		return
	end

	function self.scrollCom.onUpdateItem(arg_3_0, arg_3_1)
		self:UpdateTask(arg_3_0, tf(arg_3_1))

		return
	end

	onButton(self, self.uiGoBtn, function()
		self:emit(IslandMediator.RECORD_PLAYER_POS)
		self:emit(IslandMediator.OPEN_PAGE, "IslandCheaterTavernPrepareMainPage")

		return
	end, SFX_PANEL)
	onButton(self, self.uiRankBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = PlayRoomRankScene,
			mediator = PlayRoomRankMediator,
			data = {
				gameType = 101
			}
		}))

		return
	end)
	setText(self.uiGoText, i18n("bar_ui_check1"))
	setText(self.uiGotText, i18n("bar_ui_check2"))

	return
end

function IslandActivityCheateTavernDailySignPage:UpdateTaskData()
	self.taskVOs = self.actTaskProxy:getTaskById(self.activity.id)
	self.finishTaksVOs = self.actTaskProxy:getFinishTaskById(self.activity.id)
	self.taskDic = {}

	_.each(self.taskVOs, function(arg_7_0)
		self.taskDic[arg_7_0.id] = arg_7_0

		return
	end)
	_.each(self.finishTaksVOs, function(arg_8_0)
		self.taskDic[arg_8_0.id] = arg_8_0

		return
	end)

	return
end

function IslandActivityCheateTavernDailySignPage:InitAward(arg_9_1)
	return
end

function IslandActivityCheateTavernDailySignPage:UpdateTask(arg_10_1, arg_10_2)
	local var_10_0 = tf(arg_10_2)
	local var_10_1 = Drop.Create(self.taskConfig[self.taskGroup[arg_10_1 + 1]].award_display[1])

	if arg_10_1 + 1 >= 1 then
		updateCustomDrop(var_10_0:Find("IslandItemTpl"), var_10_1, {
			style = "island"
		})
		onButton(self, arg_10_2, function()
			self:emit(IslandMediator.SHOW_MSG_BOX, {
				title = i18n("island_word_desc"),
				type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
				dropData = var_10_1
			})

			return
		end, SFX_PANEL)
		onButton(self, var_10_0:Find("canget"), function()
			pg.m02:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
				inIsland = true,
				act_id = self.activity.id,
				task_ids = self:GetCanSubmitTaskIds()
			})

			return
		end, SFX_PANEL)
	end

	setText(var_10_0:Find("target"), "Day" .. tostring(arg_10_1 + 1))
	setActive(var_10_0:Find("got"), self.taskDic[self.taskGroup[arg_10_1 + 1]] and self.taskDic[self.taskGroup[arg_10_1 + 1]]:isOver())
	setActive(var_10_0:Find("canget"), self.taskDic[self.taskGroup[arg_10_1 + 1]] and self.taskDic[self.taskGroup[arg_10_1 + 1]]:getTaskStatus() == 1 and not self.taskDic[self.taskGroup[arg_10_1 + 1]]:isOver())
	setActive(var_10_0:Find("lock"), self.taskDic[self.taskGroup[arg_10_1 + 1]] and self.taskDic[self.taskGroup[arg_10_1 + 1]]:getTaskStatus() == -1 and not self.taskDic[self.taskGroup[arg_10_1 + 1]]:isOver())

	return
end

function IslandActivityCheateTavernDailySignPage:OnDataSetting()
	self.actTaskProxy = getProxy(ActivityTaskProxy)
	self.taskGroup = underscore.flatten(self.activity:getConfig("config_data"))
	self.taskConfig = pg.task_data_template

	return
end

function IslandActivityCheateTavernDailySignPage:OnFirstFlush()
	self.scrollCom:SetTotalCount(5)

	return
end

function IslandActivityCheateTavernDailySignPage:OnUpdateFlush()
	self:UpdateTaskData()
	self.scrollCom:SetTotalCount(5)
	setText(self.uiPtNum, (PlayRoomTools.GetPtScrore(self:GetGameType())))
	GetImageSpriteFromAtlasAsync("Island/IslandCheaterTavernIcon/" .. PlayRoomTools.GetPtScoreIcon(self:GetGameType()), "", self.uiPtIcon)

	return
end

function IslandActivityCheateTavernDailySignPage:OnShowFlush()
	return
end

function IslandActivityCheateTavernDailySignPage:GetGameType()
	return 101
end

function IslandActivityCheateTavernDailySignPage:GetCanSubmitTaskIds()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self.taskVOs) do
		if iter_18_1:getTaskStatus() == 1 and not iter_18_1:isOver() then
			table.insert(var_18_0, iter_18_1.id)
		end
	end

	return var_18_0
end

function IslandActivityCheateTavernDailySignPage:OnDestroy()
	ClearLScrollrect(self.scrollCom)

	return
end

return IslandActivityCheateTavernDailySignPage
