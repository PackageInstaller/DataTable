EventConst = require("view/event/EventConst")

local EventListItem = class("EventListItem")

function EventListItem:Ctor(arg_1_1, arg_1_2)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.dispatch = arg_1_2
	self.bgNormal = self.tr:Find("bgNormal$").gameObject
	self.bgEmergence = self.tr:Find("bgEmergence$").gameObject
	self.timeLimit = self.tr:Find("timeLimit$").gameObject
	self.labelLimitTime = self.tr:Find("timeLimit$/labelLimitTime$"):GetComponent("Text")
	self.iconType = self.tr:Find("iconType$"):GetComponent("Image")
	self.iconState = self.tr:Find("iconState$")
	self.activityLimitBg = self.tr:Find("bgAct")
	self.shadow = self.tr:Find("Image"):GetComponent(typeof(Image))
	self.timerBg = self.tr:Find("labelTime$"):GetComponent(typeof(Image))
	self.label = self.tr:Find("labelName$/Image"):GetComponent(typeof(Text))
	self.labelLv = self.tr:Find("level/labelLv$"):GetComponent("Text")
	self.iconTip = self.tr:Find("iconTip$").gameObject
	self.labelName = self.tr:Find("labelName$"):GetComponent("Text")
	self.labelTime = self.tr:Find("labelTime$/Text"):GetComponent("Text")
	self.awardsTr = self.tr:Find("awards$")
	self.specialAward = self.tr:Find("specialAward/item")
	self.awardItem = self.tr:Find("awards$/item").gameObject
	self.mark = self.tr:Find("mark")

	SetActive(self.mark, false)

	self.ptBonus = EventPtBonus.New(self.tr:Find("bonusPt"))

	return
end

function EventListItem:Update(arg_2_1, arg_2_2)
	self.index = arg_2_1
	self.event = arg_2_2

	self:Flush()

	return
end

function EventListItem:UpdateTime()
	if not self.event then
		return
	end

	local var_3_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_3_1 = self.event:GetState()

	if var_3_1 == EventInfo.StateNone then
		self.labelTime.gameObject:SetActive(true)

		self.labelTime.text = pg.TimeMgr.GetInstance():DescCDTime(self.event.template.collect_time)
	elseif var_3_1 == EventInfo.StateActive then
		self.labelTime.gameObject:SetActive(true)

		self.labelTime.text = var_3_0 <= self.event.finishTime and pg.TimeMgr.GetInstance():DescCDTime(self.event.finishTime - var_3_0) or "00:00:00"
	elseif var_3_1 == EventInfo.StateFinish then
		self.labelTime.gameObject:SetActive(false)
	end

	local var_3_2 = self.event:GetCountDownTime()

	if var_3_2 and var_3_2 >= 0 then
		self.timeLimit:SetActive(true)

		self.labelLimitTime.text = pg.TimeMgr.GetInstance():DescCDTime(var_3_2)
	else
		self.timeLimit:SetActive(false)
	end

	SetActive(self.mark, var_3_1 == EventInfo.StateFinish)

	return
end

function EventListItem:Flush()
	self.bgNormal:SetActive(self.event.template.type ~= 2)
	self.bgEmergence:SetActive(self.event.template.type == 2)

	if self.event:GetState() == EventInfo.StateFinish then
		self.iconTip:SetActive(true)
	else
		self.iconTip:SetActive(false)
	end

	LoadImageSpriteAsync("eventtype/" .. self.event.template.icon, self.iconType, true)

	local var_4_0 = self.event:IsActivityType()

	if var_4_0 then
		self.iconType.transform.localScale = Vector3.one or Vector3(1.5, 1.5, 1.5)
	end

	setActive(self.activityLimitBg, var_4_0)
	setActive(self.shadow.gameObject, not var_4_0)

	self.timerBg.color = var_4_0 and Color.New(0, 0, 0, 0) or Color.New(1, 1, 1, 1)
	self.label.color = var_4_0 and Color.New(0.9411764705882353, 0.803921568627451, 1, 1) or Color.New(0.6431372549019608, 0.8117647058823529, 0.9725490196078431, 1)

	eachChild(self.iconState, function(arg_5_0)
		setActive(arg_5_0, arg_5_0.gameObject.name == tostring(self.event:GetState()))

		return
	end)

	self.labelLv.text = "" .. self.event.template.lv
	self.labelName.text = self.event.template.title

	for iter_4_0 = self.awardsTr.childCount, #self.event.template.drop_display - 1 do
		Object.Instantiate(self.awardItem).transform:SetParent(self.awardsTr, false)
	end

	for iter_4_1 = 0, self.awardsTr.childCount - 1 do
		local var_4_4 = self.awardsTr:GetChild(iter_4_1)

		if iter_4_1 < #self.event.template.drop_display then
			var_4_4.gameObject:SetActive(true)
			updateDrop(var_4_4, {
				type = self.event.template.drop_display[iter_4_1 + 1].type,
				id = self.event.template.drop_display[iter_4_1 + 1].id,
				count = self.event.template.drop_display[iter_4_1 + 1].nums
			})
		else
			var_4_4.gameObject:SetActive(false)
		end
	end

	local var_4_5 = table.getCount(self.event.template.special_drop) ~= 0

	SetActive(self.specialAward, var_4_5)

	if var_4_5 then
		updateDrop(self.specialAward, {
			type = self.event.template.special_drop.type,
			id = self.event.template.special_drop.id
		})
	end

	return
end

function EventListItem:Clear()
	return
end

return EventListItem
