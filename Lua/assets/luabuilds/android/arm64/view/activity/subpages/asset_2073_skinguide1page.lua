local SkinGuide1Page = class("SkinGuide1Page", import("...base.BaseActivityPage"))
local var_0_2 = {
	"xiafei",
	"weiyan",
	"kuersike",
	"deliyasite",
	"fuluoxiluofu"
}

function SkinGuide1Page:OnInit()
	self.bg = self._tf:Find("AD/mask")
	self.countTF = self.bg:Find("rightPanel/count")
	self.itemTpl = self.bg:Find("itemTpl")

	setActive(self.itemTpl, false)

	self.items = self.bg:Find("rightPanel/items")
	self.countImg = self.bg:Find("countImg")
	self.paintings = self.bg:Find("paintings")
	self.paintingsSelected = self.bg:Find("paintingsSelected")
	self.descTf = self.bg:Find("rightPanel/desc")
	self.rightPanel = self.bg:Find("rightPanel")
	self.itemTfs = {}
	self.selectedIndex = 1
	self.paintingTfs = {}

	return
end

function SkinGuide1Page:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = self.activity:getConfig("config_data")
	self.totalCnt = #self.taskList

	return
end

function SkinGuide1Page:OnFirstFlush()
	self.usedCnt = self.activity:getData1()
	self.unlockCnt = pg.TimeMgr.GetInstance():DiffDay(self.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1
	self.unlockCnt = self.unlockCnt * tonumber(self.activity:getConfig("config_id"))

	if self.unlockCnt > self.totalCnt then
		self.unlockCnt = self.totalCnt or self.unlockCnt
	end

	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	local var_3_0 = 1

	for iter_3_0 = 1, #self.taskList do
		local var_3_1 = iter_3_0
		local var_3_2 = tf(instantiate(self.itemTpl))

		setParent(var_3_2, self.items)

		var_3_2.anchoredPosition = Vector2(0, 0)

		setActive(var_3_2, false)

		local var_3_3 = self.taskProxy:getTaskById(self.taskList[iter_3_0]) or self.taskProxy:getFinishTaskById(self.taskList[iter_3_0])
		local var_3_4 = var_3_3:getConfig("award_display")[1]
		local var_3_5 = {
			type = var_3_4[1],
			id = var_3_4[2],
			count = var_3_4[3]
		}

		updateDrop(findTF(var_3_2, "item"), var_3_5)
		onButton(self, var_3_2, function()
			self:emit(BaseUI.ON_DROP, var_3_5)

			return
		end, SFX_PANEL)
		table.insert(self.itemTfs, var_3_2)
		onButton(self, var_3_2:Find("get"), function()
			self:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_3)

			return
		end, SFX_PANEL)

		local var_3_6 = findTF(self.paintings, var_0_2[iter_3_0])

		table.insert(self.paintingTfs, var_3_6)

		GetComponent(findTF(var_3_6, "normal"), typeof(Image)).alphaHitTestMinimumThreshold = 0.5

		onButton(self, findTF(var_3_6, "normal"), function()
			self:selectedChange(var_3_1)

			return
		end, SFX_PANEL)

		if var_3_3:getTaskStatus() == 1 and self.remainCnt > 0 then
			var_3_0 = iter_3_0
		end
	end

	self:updateUI()
	self:selectedChange(var_3_0)

	return
end

function SkinGuide1Page:selectedChange(arg_7_1)
	for iter_7_0 = 1, #self.itemTfs do
		setActive(self.itemTfs[iter_7_0], iter_7_0 == arg_7_1)

		local var_7_0 = self.paintingTfs[iter_7_0]

		setActive(findTF(self.paintingTfs[iter_7_0], "name"), iter_7_0 == arg_7_1)
		setActive(findTF(var_7_0, "selected"), iter_7_0 == arg_7_1)
		setActive(findTF(var_7_0, "normal"), iter_7_0 ~= arg_7_1)
		setActive(findTF(var_7_0, "mask"), not ((self.taskProxy:getTaskById(self.taskList[iter_7_0]) or self.taskProxy:getFinishTaskById(self.taskList[iter_7_0])):getTaskStatus() == 2) or arg_7_1 == iter_7_0)

		if iter_7_0 == arg_7_1 then
			setParent(var_7_0, self.paintingsSelected)
			var_7_0:SetAsLastSibling()
		else
			setParent(var_7_0, self.paintings)
		end
	end

	if self.selectedIndex ~= arg_7_1 then
		setActive(self.rightPanel, false)
		setActive(self.rightPanel, true)
	end

	self.selectedIndex = arg_7_1

	return
end

function SkinGuide1Page:OnUpdateFlush()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(self.taskList) do
		if self.taskProxy:getFinishTaskById(iter_8_1) ~= nil then
			var_8_0 = var_8_0 + 1
		end
	end

	if self.usedCnt ~= var_8_0 then
		self.usedCnt = var_8_0
		self.activity.data1 = self.usedCnt

		getProxy(ActivityProxy):updateActivity(self.activity)
	end

	self.unlockCnt = pg.TimeMgr.GetInstance():DiffDay(self.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1
	self.unlockCnt = self.unlockCnt * tonumber(self.activity:getConfig("config_id"))

	if self.unlockCnt > self.totalCnt then
		self.unlockCnt = self.totalCnt or self.unlockCnt
	end

	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	setText(self.countTF, tostring(self.remainCnt))

	local var_8_1 = self.activity:getConfig("config_client").story

	for iter_8_2, iter_8_3 in ipairs(self.taskList) do
		if self.taskProxy:getFinishTaskById(iter_8_3) and checkExist(var_8_1, {
			iter_8_2
		}, {
			1
		}) then
			pg.NewStoryMgr.GetInstance():Play(var_8_1[iter_8_2][1])
		end
	end

	self:updateUI()

	return
end

function SkinGuide1Page:updateUI()
	for iter_9_0 = 1, #self.itemTfs do
		local var_9_0 = self.taskProxy:getTaskById(self.taskList[iter_9_0]) or self.taskProxy:getFinishTaskById(self.taskList[iter_9_0])
		local var_9_1 = self.itemTfs[iter_9_0]:Find("item")
		local var_9_2 = var_9_0:getTaskStatus()
		local var_9_3 = self.itemTfs[iter_9_0]:Find("got")
		local var_9_4 = var_9_2 == 2

		setActive(self.itemTfs[iter_9_0]:Find("get"), var_9_2 == 1 and self.remainCnt > 0)
		setActive(var_9_3, var_9_4)

		local var_9_5 = self.paintingTfs[iter_9_0]

		setActive(findTF(self.paintingTfs[iter_9_0], "got"), var_9_4)
		setActive(findTF(var_9_5, "mask"), not var_9_4 or self.selectedIndex == iter_9_0)
	end

	return
end

function SkinGuide1Page:OnShowFlush()
	return
end

function SkinGuide1Page:OnDestroy()
	return
end

return SkinGuide1Page
