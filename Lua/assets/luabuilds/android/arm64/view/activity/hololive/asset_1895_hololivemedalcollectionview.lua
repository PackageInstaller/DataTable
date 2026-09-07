local HololiveMedalCollectionView = class("HololiveMedalCollectionView", import("view.base.BaseUI"))

function HololiveMedalCollectionView:getUIName()
	return "HololiveMedalCollectionUI"
end

function HololiveMedalCollectionView:init()
	self:InitData()
	self:FindUI()
	self:AddListener()

	return
end

function HololiveMedalCollectionView:didEnter()
	self:UpdateView()

	return
end

function HololiveMedalCollectionView:InitData()
	self.taskProxy = getProxy(TaskProxy)
	self.actMedal = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLOLIVE_MEDAL_COLLECTION)
	self.allIDList = self.actMedal:getConfig("config_data")
	self.taskGroup = pg.activity_template[ActivityConst.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data
	self.activatableIDList = self.actMedal.data1_list
	self.activeIDList = self.actMedal.data2_list

	return
end

local var_0_1 = {
	"mio",
	"fubuki",
	"matsuri",
	"sora",
	"shion",
	"aqua",
	"ayame",
	"purer",
	"tnt"
}
local var_0_2 = {
	1,
	2,
	3,
	6,
	9,
	8,
	7,
	4,
	5
}

function HololiveMedalCollectionView:FindUI()
	self.bg = self._tf:Find("bg")
	self.top = self._tf:Find("top")
	self.backBtn = self.top:Find("back")
	self.helpBtn = self.top:Find("help")
	self.progressText = self._tf:Find("middle/board/progress")
	self.taskScroll = self._tf:Find("middle/board/Scroll View")
	self.taskScrollBar = self._tf:Find("middle/board/Scrollbar")
	self.taskListItems = CustomIndexLayer.Clone2Full(self.taskScroll:Find("Content"), #self.taskGroup)
	self.medalListItems = CustomIndexLayer.Clone2Full(self._tf:Find("middle/console/grid"), 9)
	self.medalImg = self._tf:Find("middle/console/slot"):GetComponent(typeof(Image))
	self.medalGet = self._tf:Find("middle/console/get")
	self.medalGot = self._tf:Find("middle/console/got")

	for iter_5_0 = 1, #self.taskGroup do
		local var_5_0 = LoadSprite("ui/HololiveMedalCollectionUI_atlas", var_0_1[iter_5_0])
		local var_5_1 = self.taskListItems[iter_5_0]:Find("icon"):GetComponent(typeof(Image))

		var_5_1.sprite = var_5_0
		var_5_1.enabled = true

		local var_5_2 = self.medalListItems[var_0_2[iter_5_0]]:Find("icon"):GetComponent(typeof(Image))

		var_5_2.sprite = var_5_0
		var_5_2.enabled = true
	end

	self.materialGray = LoadAny("ui/HololiveMedalCollectionUI_atlas", "gray.mat")

	return
end

function HololiveMedalCollectionView:AddListener()
	onButton(self, self.backBtn, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.hololive_dalaozhang.tip
		})

		return
	end, SFX_PANEL)

	local var_6_0 = self._tf:Find("middle/board/arrow")

	onScroll(self, self.taskScroll, function(arg_9_0)
		setActive(var_6_0, arg_9_0.y > 0.001)

		return
	end)
	onButton(self, self.medalGet, function()
		self:GetFinal()

		return
	end, SFX_PANEL)

	return
end

function HololiveMedalCollectionView:DataSetting()
	if #self.activatableIDList > 0 then
		local var_11_0

		while #self.activatableIDList >= 1 do
			if not table.contains(self.activeIDList, self.activatableIDList[1]) then
				var_11_0 = self.activatableIDList[1]

				break
			end
		end

		if var_11_0 then
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = var_11_0,
				actId = ActivityConst.HOLOLIVE_MEDAL_COLLECTION
			})

			return true
		end
	end

	return
end

function HololiveMedalCollectionView:UpdateView()
	self:InitData()

	if self:DataSetting() then
		return
	end

	local var_12_0 = #self.activeIDList == #self.allIDList and self.actMedal.data1 ~= 1
	local var_12_1 = self.actMedal.data1 == 1
	local var_12_2 = 0

	for iter_12_0 = 1, #self.taskGroup do
		local var_12_3 = self.taskListItems[iter_12_0]
		local var_12_4 = self.taskGroup[iter_12_0]
		local var_12_5 = self.taskProxy:getTaskVO(self.taskGroup[iter_12_0])
		local var_12_6 = self.taskListItems[iter_12_0]:Find("btn_go")
		local var_12_7 = self.taskListItems[iter_12_0]:Find("btn_get")
		local var_12_8 = self.taskListItems[iter_12_0]:Find("btn_got")
		local var_12_9 = table.contains(self.activeIDList, self.allIDList[iter_12_0])
		local var_12_10
		local var_12_11 = 0

		if var_12_5 then
			setText(var_12_3:Find("desc"), (string.gsub(string.gsub(var_12_5:getConfig("desc"), "$1", (var_12_5:getProgress())), "$2", (var_12_5:getConfig("target_num")))))

			var_12_11 = var_12_5:getTaskStatus()
			var_12_10 = var_12_11 == 2 and self.materialGray or nil

			onButton(self, var_12_6, function()
				self:emit(ActivityMediator.ON_TASK_GO, var_12_5)

				return
			end, SFX_PANEL)
			onButton(self, var_12_7, function()
				self:emit(ActivityMediator.ON_TASK_SUBMIT, var_12_5)

				return
			end, SFX_PANEL)
		else
			setText(var_12_3:Find("desc"), (string.gsub(string.gsub(pg.task_data_template[var_12_4].desc, "$1", var_12_9 and pg.task_data_template[var_12_4].target_num or 0), "$2", pg.task_data_template[var_12_4].target_num)))

			var_12_11 = var_12_9 and 2 or 0
			var_12_10 = self.materialGray

			onButton(self, var_12_6, function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end, SFX_PANEL)
		end

		setActive(var_12_6, var_12_11 == 0)
		setActive(var_12_7, var_12_11 == 1)
		setActive(var_12_8, var_12_11 == 2)

		var_12_3:GetComponent(typeof(Image)).material = var_12_10
		var_12_3:Find("icon"):GetComponent(typeof(Image)).material = var_12_10

		local var_12_12 = self.medalListItems[var_0_2[iter_12_0]]:Find("icon"):GetComponent(typeof(Image))

		var_12_12.enabled = var_12_9

		if var_12_1 then
			var_12_12.material = self.materialGray or nil
		end

		var_12_2 = var_12_2 + (var_12_11 == 2 and 1 or 0)
	end

	setText(self.progressText, var_12_2 .. "/9")

	self.medalImg.material = not var_12_0 and not var_12_1 and self.materialGray

	setActive(self.medalGet, var_12_0)
	setActive(self.medalGot, var_12_1)

	return
end

function HololiveMedalCollectionView:GetFinal()
	if #self.activeIDList == #self.allIDList and self.actMedal.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.HOLOLIVE_MEDAL_COLLECTION
		})
	end

	return
end

function HololiveMedalCollectionView:PlayStory(arg_17_1)
	local var_17_0 = self.actMedal:getConfig("config_client").story

	if var_17_0 then
		pg.NewStoryMgr.GetInstance():Play(var_17_0, arg_17_1)
	else
		arg_17_1()
	end

	return
end

function HololiveMedalCollectionView.IsTip()
	local var_18_0 = getProxy(TaskProxy)
	local var_18_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.HOLOLIVE_MEDAL_COLLECTION)

	if var_18_1 and not var_18_1:isEnd() then
		for iter_18_0, iter_18_1 in ipairs(pg.activity_template[ActivityConst.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data) do
			local var_18_2 = var_18_0:getTaskVO(pg.activity_template[ActivityConst.HOLOLIVE_MEDAL_COLLECTION_TASK].config_data[iter_18_0])

			if var_18_2 and var_18_2:getTaskStatus() == 1 then
				return true
			end
		end

		for iter_18_2, iter_18_3 in ipairs(var_18_1.data1_list) do
			if not table.contains(var_18_1.data2_list, iter_18_3) then
				return true
			end
		end

		if #var_18_1.data2_list == #var_18_1:getConfig("config_data") and var_18_1.data1 ~= 1 then
			return true
		end
	end

	return
end

return HololiveMedalCollectionView
