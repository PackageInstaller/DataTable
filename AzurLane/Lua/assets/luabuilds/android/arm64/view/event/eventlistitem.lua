require = var_0_10000

local var_0_0 = var_0_10000("view/event/EventConst")

class = EventConst

local var_0_1 = var_0("EventListItem")

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0.dispatch = arg_1_2

	local var_1_0 = arg_1_0.tr

	arg_1_0.bgNormal = var_3.Find(var_1_0, "bgNormal$").gameObject

	local var_1_1 = arg_1_0.tr

	arg_1_0.bgEmergence = var_3.Find(var_1_1, "bgEmergence$").gameObject

	local var_1_2 = arg_1_0.tr

	arg_1_0.timeLimit = var_3.Find(var_1_2, "timeLimit$").gameObject

	local var_1_3 = arg_1_0.tr
	local var_1_4 = var_3.Find(var_1_3, "timeLimit$/labelLimitTime$")

	arg_1_0.labelLimitTime = var_3.GetComponent(var_1_4, "Text")

	local var_1_5 = arg_1_0.tr
	local var_1_6 = var_3.Find(var_1_5, "iconType$")

	arg_1_0.iconType = var_3.GetComponent(var_1_6, "Image")

	local var_1_7 = arg_1_0.tr

	arg_1_0.iconState = var_3.Find(var_1_7, "iconState$")

	local var_1_8 = arg_1_0.tr

	arg_1_0.activityLimitBg = var_3.Find(var_1_8, "bgAct")

	local var_1_9 = arg_1_0.tr
	local var_1_10 = var_3.Find(var_1_9, "Image")
	local var_1_11 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.shadow = var_1_11(var_1_10, var_6(var_1_10008))

	local var_1_12 = arg_1_0.tr
	local var_1_13 = var_3.Find(var_1_12, "labelTime$")
	local var_1_14 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.timerBg = var_1_14(var_1_13, var_6(var_1_10008))

	local var_1_15 = arg_1_0.tr
	local var_1_16 = var_3.Find(var_1_15, "labelName$/Image")
	local var_1_17 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.label = var_1_17(var_1_16, var_6(var_1_10008))

	local var_1_18 = arg_1_0.tr
	local var_1_19 = var_3.Find(var_1_18, "level/labelLv$")

	arg_1_0.labelLv = var_3.GetComponent(var_1_19, "Text")

	local var_1_20 = arg_1_0.tr

	arg_1_0.iconTip = var_3.Find(var_1_20, "iconTip$").gameObject

	local var_1_21 = arg_1_0.tr
	local var_1_22 = var_3.Find(var_1_21, "labelName$")

	arg_1_0.labelName = var_3.GetComponent(var_1_22, "Text")

	local var_1_23 = arg_1_0.tr
	local var_1_24 = var_3.Find(var_1_23, "labelTime$/Text")

	arg_1_0.labelTime = var_3.GetComponent(var_1_24, "Text")

	local var_1_25 = arg_1_0.tr

	arg_1_0.awardsTr = var_3.Find(var_1_25, "awards$")

	local var_1_26 = arg_1_0.tr

	arg_1_0.specialAward = var_3.Find(var_1_26, "specialAward/item")

	local var_1_27 = arg_1_0.tr

	arg_1_0.awardItem = var_3.Find(var_1_27, "awards$/item").gameObject

	local var_1_28 = arg_1_0.tr

	arg_1_0.mark = var_3.Find(var_1_28, "mark")
	SetActive = var_3

	var_3(arg_1_0.mark, false)

	EventPtBonus = var_3

	local var_1_29 = var_3.New
	local var_1_30 = arg_1_0.tr

	arg_1_0.ptBonus = var_1_29(var_5.Find(var_1_30, "bonusPt"))

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index = arg_2_1
	arg_2_0.event = arg_2_2

	arg_2_0:Flush()

	return
end

function var_0_1.UpdateTime(arg_3_0)
	if not arg_3_0.event then
		return
	end

	pg = var_1

	local var_3_0 = var_1.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetServerTime(var_3_0)
	local var_3_2 = arg_3_0.event
	local var_3_3 = var_2.GetState(var_3_2)

	EventInfo = var_3_0

	local var_3_5

	if var_3_3 == var_3_0.StateNone then
		local var_3_4 = arg_3_0.labelTime.gameObject

		var_3_5.SetActive(var_3_4, true)

		var_3_5 = arg_3_0.labelTime
		pg = var_3_2

		local var_3_6 = var_3_2.TimeMgr.GetInstance()

		var_3_5.text = var_3_2.DescCDTime(var_3_6, arg_3_0.event.template.collect_time)
	else
		EventInfo = var_3_5

		local var_3_8

		if var_3_3 == var_3_5.StateActive then
			local var_3_7 = arg_3_0.labelTime.gameObject

			var_3_8.SetActive(var_3_7, true)

			if var_3_1 <= arg_3_0.event.finishTime then
				var_3_8 = arg_3_0.labelTime
				pg = var_3_2

				local var_3_9 = var_3_2.TimeMgr.GetInstance()

				var_3_8.text = var_3_2.DescCDTime(var_3_9, arg_3_0.event.finishTime - var_3_1)
			else
				var_3_8 = arg_3_0.labelTime
				var_3_8.text = "00:00:00"
			end
		else
			EventInfo = var_3_8

			if var_3_3 == var_3_8.StateFinish then
				local var_3_10 = arg_3_0.labelTime.gameObject

				var_3.SetActive(var_3_10, false)
			end
		end
	end

	local var_3_11 = arg_3_0.event

	if var_3.GetCountDownTime(var_3_11) and 0 <= var_3 then
		local var_3_12 = arg_3_0.timeLimit

		var_3_2.SetActive(var_3_12, true)

		var_3_2 = arg_3_0.labelLimitTime
		pg = var_3_11
		var_1_10007 = var_3_11.TimeMgr.GetInstance()
		var_3_2.text = var_5.DescCDTime(var_1_10007, var_3)
	else
		local var_3_13 = arg_3_0.timeLimit

		var_3_2.SetActive(var_3_13, false)
	end

	SetActive = var_3_2

	local var_3_14 = arg_3_0.mark

	EventInfo = var_1_10007

	var_3_2(var_3_14, var_3_3 == var_1_10007.StateFinish)

	return
end

function var_0_1.Flush(arg_4_0)
	local var_4_0 = arg_4_0.bgNormal

	var_1.SetActive(var_4_0, arg_4_0.event.template.type ~= 2)

	local var_4_1 = arg_4_0.bgEmergence

	var_1.SetActive(var_4_1, arg_4_0.event.template.type == 2)

	local var_4_2 = arg_4_0.event
	local var_4_3 = var_1.GetState(var_4_2)

	EventInfo = var_1_10002

	if var_4_3 == var_1_10002.StateFinish then
		local var_4_4 = arg_4_0.iconTip

		var_4_3.SetActive(var_4_4, true)
	else
		local var_4_5 = arg_4_0.iconTip

		var_4_3.SetActive(var_4_5, false)
	end

	LoadImageSpriteAsync = var_4_3

	var_4_3("eventtype/" .. arg_4_0.event.template.icon, arg_4_0.iconType, true)

	local var_4_6 = arg_4_0.event
	local var_4_7 = var_1.IsActivityType(var_4_6)
	local var_4_8 = arg_4_0.iconType.transform

	if var_4_7 then
		Vector3 = var_4_6

		if not var_4_6.one then
			Vector3 = var_4_6
			var_4_6 = var_4_6(1.5, 1.5, 1.5)
		end

		var_4_8.localScale = var_4_6
		setActive = var_4_8

		var_4_8(arg_4_0.activityLimitBg, var_4_7)

		setActive = var_4_8

		var_4_8(arg_4_0.shadow.gameObject, not var_4_7)

		local var_4_9 = arg_4_0.timerBg

		if var_4_7 then
			Color = var_4_6

			if not var_4_6.New(0, 0, 0, 0) then
				Color = var_4_6
				var_4_6 = var_4_6.New(1, 1, 1, 1)
			end

			var_4_9.color = var_4_6

			local var_4_10 = arg_4_0.label

			if var_4_7 then
				Color = var_4_6

				if not var_4_6.New(0.9411764705882353, 0.803921568627451, 1, 1) then
					Color = var_4_6
					var_4_6 = var_4_6.New(0.6431372549019608, 0.8117647058823529, 0.9725490196078431, 1)
				end

				var_4_10.color = var_4_6
				eachChild = var_4_10

				var_4_10(arg_4_0.iconState, function(arg_5_0)
					setActive = var_2_10001

					local var_5_0 = arg_5_0
					local var_5_1 = arg_5_0.gameObject.name

					tostring = var_2_10005

					local var_5_2 = arg_4_0.event

					var_2_10001(var_5_0, var_5_1 == var_2_10005(var_7.GetState(var_5_2)))

					return
				end)

				arg_4_0.labelLv.text = "" .. arg_4_0.event.template.lv
				arg_4_0.labelName.text = arg_4_0.event.template.title

				local var_4_11 = arg_4_0.event.template.drop_display

				for iter_4_0 = arg_4_0.awardsTr.childCount, #var_4_11 - 1 do
					Object = var_1_10008

					local var_4_12 = var_1_10008.Instantiate(arg_4_0.awardItem).transform

					var_9.SetParent(var_4_12, arg_4_0.awardsTr, false)
				end

				local var_4_13 = arg_4_0.awardsTr.childCount

				for iter_4_1 = 0, var_4_13 - 1 do
					local var_4_14 = arg_4_0.awardsTr
					local var_4_15 = var_8.GetChild(var_4_14, iter_4_1)

					if iter_4_1 < #var_4_11 then
						local var_4_16 = var_4_15.gameObject

						var_9.SetActive(var_4_16, true)

						local var_4_17 = var_4_11[iter_4_1 + 1]

						updateDrop = var_4_14

						var_4_14(var_4_15, {
							type = var_4_17.type,
							id = var_4_17.id,
							count = var_4_17.nums
						})
					else
						local var_4_18 = var_4_15.gameObject

						var_9.SetActive(var_4_18, false)
					end
				end

				table = var_4

				local var_4_19 = var_4.getCount(arg_4_0.event.template.special_drop) ~= 0

				SetActive = var_5

				var_5(arg_4_0.specialAward, var_4_19)

				if var_4_19 then
					updateDrop = var_5

					var_5(arg_4_0.specialAward, {
						type = arg_4_0.event.template.special_drop.type,
						id = arg_4_0.event.template.special_drop.id
					})
				end

				return
			end
		end
	end
end

function var_0_1.Clear(arg_6_0)
	return
end

return var_0_1
