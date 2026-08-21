EventConst = require("view/event/EventConst")

local var_0_0 = class("EventListItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.dispatch = arg_1_2
	arg_1_0.bgNormal = arg_1_0.tr:Find("bgNormal$").gameObject
	arg_1_0.bgEmergence = arg_1_0.tr:Find("bgEmergence$").gameObject
	arg_1_0.timeLimit = arg_1_0.tr:Find("timeLimit$").gameObject
	arg_1_0.labelLimitTime = arg_1_0.tr:Find("timeLimit$/labelLimitTime$"):GetComponent("Text")
	arg_1_0.iconType = arg_1_0.tr:Find("iconType$"):GetComponent("Image")
	arg_1_0.iconState = arg_1_0.tr:Find("iconState$")
	arg_1_0.activityLimitBg = arg_1_0.tr:Find("bgAct")
	arg_1_0.shadow = arg_1_0.tr:Find("Image"):GetComponent(typeof(Image))
	arg_1_0.timerBg = arg_1_0.tr:Find("labelTime$"):GetComponent(typeof(Image))
	arg_1_0.label = arg_1_0.tr:Find("labelName$/Image"):GetComponent(typeof(Text))
	arg_1_0.labelLv = arg_1_0.tr:Find("level/labelLv$"):GetComponent("Text")
	arg_1_0.iconTip = arg_1_0.tr:Find("iconTip$").gameObject
	arg_1_0.labelName = arg_1_0.tr:Find("labelName$"):GetComponent("Text")
	arg_1_0.labelTime = arg_1_0.tr:Find("labelTime$/Text"):GetComponent("Text")
	arg_1_0.awardsTr = arg_1_0.tr:Find("awards$")
	arg_1_0.specialAward = arg_1_0.tr:Find("specialAward/item")
	arg_1_0.awardItem = arg_1_0.tr:Find("awards$/item").gameObject
	arg_1_0.mark = arg_1_0.tr:Find("mark")

	SetActive(arg_1_0.mark, false)

	arg_1_0.ptBonus = EventPtBonus.New(arg_1_0.tr:Find("bonusPt"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index = arg_2_1
	arg_2_0.event = arg_2_2

	arg_2_0:Flush()

	return
end

function var_0_0.UpdateTime(arg_3_0)
	if not arg_3_0.event then
		return
	end

	local var_3_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_3_1 = arg_3_0.event:GetState()

	if var_3_1 == EventInfo.StateNone then
		arg_3_0.labelTime.gameObject:SetActive(true)

		arg_3_0.labelTime.text = pg.TimeMgr.GetInstance():DescCDTime(arg_3_0.event.template.collect_time)
	elseif var_3_1 == EventInfo.StateActive then
		arg_3_0.labelTime.gameObject:SetActive(true)

		arg_3_0.labelTime.text = var_3_0 <= arg_3_0.event.finishTime and pg.TimeMgr.GetInstance():DescCDTime(arg_3_0.event.finishTime - var_3_0) or "00:00:00"
	elseif var_3_1 == EventInfo.StateFinish then
		arg_3_0.labelTime.gameObject:SetActive(false)
	end

	local var_3_2 = arg_3_0.event:GetCountDownTime()

	if var_3_2 and var_3_2 >= 0 then
		arg_3_0.timeLimit:SetActive(true)

		arg_3_0.labelLimitTime.text = pg.TimeMgr.GetInstance():DescCDTime(var_3_2)
	else
		arg_3_0.timeLimit:SetActive(false)
	end

	SetActive(arg_3_0.mark, var_3_1 == EventInfo.StateFinish)

	return
end

function var_0_0.Flush(arg_4_0)
	arg_4_0.bgNormal:SetActive(arg_4_0.event.template.type ~= 2)
	arg_4_0.bgEmergence:SetActive(arg_4_0.event.template.type == 2)

	if arg_4_0.event:GetState() == EventInfo.StateFinish then
		arg_4_0.iconTip:SetActive(true)
	else
		arg_4_0.iconTip:SetActive(false)
	end

	LoadImageSpriteAsync("eventtype/" .. arg_4_0.event.template.icon, arg_4_0.iconType, true)

	local var_4_0 = arg_4_0.event:IsActivityType()
	local var_4_1 = arg_4_0.iconType.transform

	if var_4_0 then
		var_4_1.localScale = Vector3.one or Vector3(1.5, 1.5, 1.5)

		setActive(arg_4_0.activityLimitBg, var_4_0)
		setActive(arg_4_0.shadow.gameObject, not var_4_0)

		local var_4_2 = arg_4_0.timerBg

		var_4_2.color = var_4_0 and Color.New(0, 0, 0, 0) or Color.New(1, 1, 1, 1)

		local var_4_3 = arg_4_0.label

		var_4_3.color = var_4_0 and Color.New(0.9411764705882353, 0.803921568627451, 1, 1) or Color.New(0.6431372549019608, 0.8117647058823529, 0.9725490196078431, 1)

		eachChild(arg_4_0.iconState, function(arg_5_0)
			setActive(arg_5_0, arg_5_0.gameObject.name == tostring(arg_4_0.event:GetState()))

			return
		end)

		arg_4_0.labelLv.text = "" .. arg_4_0.event.template.lv
		arg_4_0.labelName.text = arg_4_0.event.template.title

		for iter_4_0 = arg_4_0.awardsTr.childCount, #arg_4_0.event.template.drop_display - 1 do
			Object.Instantiate(arg_4_0.awardItem).transform:SetParent(arg_4_0.awardsTr, false)
		end

		for iter_4_1 = 0, arg_4_0.awardsTr.childCount - 1 do
			local var_4_4 = arg_4_0.awardsTr:GetChild(iter_4_1)

			if iter_4_1 < #arg_4_0.event.template.drop_display then
				var_4_4.gameObject:SetActive(true)
				updateDrop(var_4_4, {
					type = arg_4_0.event.template.drop_display[iter_4_1 + 1].type,
					id = arg_4_0.event.template.drop_display[iter_4_1 + 1].id,
					count = arg_4_0.event.template.drop_display[iter_4_1 + 1].nums
				})
			else
				var_4_4.gameObject:SetActive(false)
			end
		end

		local var_4_5 = table.getCount(arg_4_0.event.template.special_drop) ~= 0

		SetActive(arg_4_0.specialAward, var_4_5)

		if var_4_5 then
			updateDrop(arg_4_0.specialAward, {
				type = arg_4_0.event.template.special_drop.type,
				id = arg_4_0.event.template.special_drop.id
			})
		end

		return
	end
end

function var_0_0.Clear(arg_6_0)
	return
end

return var_0_0
