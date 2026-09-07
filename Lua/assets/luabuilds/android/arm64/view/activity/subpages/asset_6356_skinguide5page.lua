local SkinGuide5Page = class("SkinGuide5Page", import("...base.BaseActivityPage"))
local var_0_1 = {
	"guandao",
	"lafei2",
	"kelifulan",
	"xingzuo"
}
local var_0_2
local var_0_3 = "ui/activityuipage/skinguide5page_atlas"

function SkinGuide5Page:OnInit()
	self.ad = self._tf:Find("AD")
	var_0_2 = PLATFORM_CODE == PLATFORM_JP and {
		Vector2(-488, 52),
		Vector2(-420, -41),
		Vector2(102, -82),
		Vector2(-471, -128)
	} or PLATFORM_CODE == PLATFORM_US and {
		Vector2(-480, 189),
		Vector2(-445, -101),
		Vector2(-410, -101),
		Vector2(-354, -108)
	} or {
		Vector2(-490, 130),
		Vector2(-400, -128),
		Vector2(89, 10),
		Vector2(-478, 57)
	}
	self.paint = findTF(self.ad, "paint")
	self.paintGot = findTF(self.paint, "show/got")
	self.paintAnim = GetComponent(self.paint, typeof(Animator))
	self.itemContent = findTF(self.ad, "items/content")
	self.itemTpl = findTF(self.ad, "items/content/itemTpl")

	setActive(self.itemTpl, false)

	self.iconContent = findTF(self.ad, "iconContent")
	self.iconTpl = findTF(self.ad, "iconContent/IconTpl")

	setActive(self.iconTpl, false)

	self.desc = findTF(self.ad, "desc")
	self.got = findTF(self.ad, "got")
	self.get = findTF(self.ad, "get")
	self.getBound = findTF(self.ad, "get_bound")
	self.times = findTF(self.ad, "times")

	onButton(self, self.get, function()
		if self.selectIndex then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, (getProxy(TaskProxy):getTaskById(self.skinDatas[self.selectIndex].task)))
		end

		return
	end, sound, guideData)

	return
end

function SkinGuide5Page:OnDataSetting()
	self.taskProxy = getProxy(TaskProxy)
	self.taskList = self.activity:getConfig("config_data")
	self.totalCnt = #self.taskList

	if not self.skinDatas then
		self.skinDatas = {}

		for iter_3_0 = 1, #self.taskList do
			local var_3_0 = tf(instantiate(self.itemTpl))

			setParent(var_3_0, self.itemContent)
			setActive(var_3_0, true)
			onButton(self, var_3_0, function()
				self:selectItem(iter_3_0)

				return
			end, SFX_CONFIRM)

			GetComponent(var_3_0, typeof(Image)).sprite = GetSpriteFromAtlas(var_0_3, "item_" .. var_0_1[iter_3_0])

			local var_3_1 = tf(Instantiate(self.iconTpl))

			setParent(var_3_1, self.iconContent)
			setActive(var_3_1, true)

			local var_3_2 = (self.taskProxy:getTaskById(self.taskList[iter_3_0]) or self.taskProxy:getFinishTaskById(self.taskList[iter_3_0])):getConfig("award_display")[1]
			local var_3_3 = {
				type = var_3_2[1],
				id = var_3_2[2],
				count = var_3_2[3]
			}

			updateDrop(var_3_1, var_3_3)
			onButton(self, var_3_1, function()
				self:emit(BaseUI.ON_DROP, var_3_3)

				return
			end, SFX_PANEL)
			table.insert(self.skinDatas, {
				task = self.taskList[iter_3_0],
				name = var_0_1[iter_3_0],
				item = var_3_0,
				icon = var_3_1
			})
		end
	end

	return
end

function SkinGuide5Page:selectItem(arg_6_1)
	for iter_6_0 = 1, #self.skinDatas do
		if LeanTween.isTweening(go(self.skinDatas[iter_6_0].item)) then
			return
		end
	end

	local var_6_0 = 0

	for iter_6_1 = arg_6_1 + 1, #self.skinDatas do
		self.skinDatas[iter_6_1].item:SetAsFirstSibling()
		setActive(self.skinDatas[iter_6_1].item, iter_6_1 ~= arg_6_1)
		setActive(self.skinDatas[iter_6_1].icon, iter_6_1 == arg_6_1)

		self.skinDatas[iter_6_1].targetPos = Vector2(var_6_0 * 215, 0)
		var_6_0 = var_6_0 + 1
	end

	for iter_6_2 = 1, arg_6_1 do
		self.skinDatas[iter_6_2].item:SetAsFirstSibling()
		setActive(self.skinDatas[iter_6_2].item, iter_6_2 ~= arg_6_1)
		setActive(self.skinDatas[iter_6_2].icon, iter_6_2 == arg_6_1)

		self.skinDatas[iter_6_2].targetPos = Vector2(var_6_0 * 215, 0)
		var_6_0 = var_6_0 + 1
	end

	local var_6_2 = self.taskProxy:getFinishTaskById(self.skinDatas[arg_6_1].task)

	setActive(self.get, not var_6_2 and self.remainCnt > 0)
	setActive(self.getBound, not var_6_2 and self.remainCnt > 0)
	setActive(self.got, var_6_2)

	self.paintGot.anchoredPosition = var_0_2[arg_6_1]

	setActive(self.paintGot, var_6_2)

	local var_6_3 = GetComponent(findTF(self.paint, "show"), typeof(Image))

	var_6_3.sprite = GetSpriteFromAtlas(var_0_3, "bg_" .. self.skinDatas[arg_6_1].name)

	var_6_3:SetNativeSize()

	local var_6_4 = GetComponent(findTF(self.paint, "temp"), typeof(Image))

	var_6_4.sprite = self.selectIndex and GetSpriteFromAtlas(var_0_3, "bg_" .. self.skinDatas[self.selectIndex].name) or GetSpriteFromAtlas(var_0_3, "bg_" .. self.skinDatas[arg_6_1].name)

	var_6_4:SetNativeSize()

	if self.selectIndex and self.selectIndex ~= arg_6_1 then
		self.paintAnim:SetTrigger((self.selectIndex ~= 1 or arg_6_1 ~= #self.skinDatas or false) and (self.selectIndex == #self.skinDatas and arg_6_1 == 1 and true or arg_6_1 > self.selectIndex) and "next" or "pre")
		self:updateItemPos(true, var_6_5)
	else
		self:updateItemPos(false)
	end

	self.selectIndex = arg_6_1

	return
end

function SkinGuide5Page:OnFirstFlush()
	self.usedCnt = self.activity:getData1()
	self.unlockCnt = pg.TimeMgr.GetInstance():DiffDay(self.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1

	if self.unlockCnt > self.totalCnt then
		self.unlockCnt = self.totalCnt or self.unlockCnt
	end

	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	setText(self.desc, i18n("skin_page_desc", self.activity:getConfig("config_id")))
	setText(findTF(self.get, "desc"), i18n("skin_page_sign"))

	local var_7_0 = 1

	for iter_7_0 = 1, #self.skinDatas do
		if not (self.taskProxy:getFinishTaskById(self.skinDatas[iter_7_0].task) or false) then
			var_7_0 = var_7_0 or iter_7_0
		end
	end

	self:selectItem(var_7_0)
	self:updateItemData()

	return
end

function SkinGuide5Page:OnUpdateFlush()
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

	self.unlockCnt = (pg.TimeMgr.GetInstance():DiffDay(self.activity:getStartTime(), pg.TimeMgr.GetInstance():GetServerTime()) + 1) * self.activity:getConfig("config_id")

	if self.unlockCnt > self.totalCnt then
		self.unlockCnt = self.totalCnt or self.unlockCnt
	end

	self.remainCnt = self.usedCnt >= self.totalCnt and 0 or self.unlockCnt - self.usedCnt

	setText(findTF(self.times, "desc"), i18n("last_times_sign", self.remainCnt))

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

	self:selectItem(self.selectIndex)
	self:updateItemData()

	return
end

local var_0_4 = 215

function SkinGuide5Page:updateItemPos(arg_9_1, arg_9_2)
	local var_9_0 = Vector2(-var_0_4, 0)
	local var_9_1 = Vector2((#self.skinDatas - 1) * var_0_4, 0)

	for iter_9_0 = 1, #self.skinDatas do
		local var_9_2 = self.skinDatas[iter_9_0].item

		if LeanTween.isTweening(go(self.skinDatas[iter_9_0].item)) then
			LeanTween.cancel(go(var_9_2))
		end

		local var_9_3 = self.skinDatas[iter_9_0].targetPos

		if arg_9_1 then
			local var_9_4 = {}

			if not arg_9_2 and var_9_2.anchoredPosition.x > var_9_3.x then
				table.insert(var_9_4, var_9_1)
				table.insert(var_9_4, var_9_0)
			elseif arg_9_2 and var_9_2.anchoredPosition.x < var_9_3.x then
				table.insert(var_9_4, var_9_0)
				table.insert(var_9_4, var_9_1)
			end

			table.insert(var_9_4, var_9_3)
			table.insert(var_9_4, var_9_3)
			self:tweenItem(var_9_2, var_9_4)
		else
			var_9_2.anchoredPosition = var_9_3
		end
	end

	return
end

function SkinGuide5Page:tweenItem(arg_10_1, arg_10_2)
	if #arg_10_2 >= 2 then
		local var_10_0 = arg_10_1.anchoredPosition
		local var_10_1 = table.remove(arg_10_2, 1)
		local var_10_2 = table.remove(arg_10_2, 1)

		LeanTween.value(go(arg_10_1), arg_10_1.anchoredPosition.x, var_10_1.x, math.abs(var_10_1.x - arg_10_1.anchoredPosition.x) / var_0_4 * 0.25):setOnUpdate(System.Action_float(function(arg_11_0)
			var_10_0.x = arg_11_0
			arg_10_1.anchoredPosition = var_10_0

			return
		end)):setOnComplete(System.Action(function()
			arg_10_1.anchoredPosition = var_10_2

			self:tweenItem(arg_10_1, arg_10_2)

			return
		end))
	end

	return
end

function SkinGuide5Page:updateItemData()
	for iter_13_0 = 1, #self.skinDatas do
		setActive(findTF(self.skinDatas[iter_13_0].item, "got"), self.taskProxy:getFinishTaskById(self.skinDatas[iter_13_0].task) or false)
	end

	return
end

function SkinGuide5Page:OnDestroy()
	for iter_14_0 = 1, #self.skinDatas do
		if LeanTween.isTweening(go(self.skinDatas[iter_14_0].item)) then
			LeanTween.cancel(go(self.skinDatas[iter_14_0].item), false)
		end
	end

	return
end

return SkinGuide5Page
