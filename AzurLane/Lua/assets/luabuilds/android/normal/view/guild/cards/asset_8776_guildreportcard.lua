class = var_0_10000

local var_0_0 = var_0_10000("GuildReportCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.viewComponent = arg_1_2
	arg_1_0._go = arg_1_1
	tf = var_1_10003
	arg_1_0._tf = var_1_10003(arg_1_1)
	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.GetComponent

	typeof = var_1_10005
	Image = var_1_10006
	arg_1_0.bg = var_1_1(var_1_0, var_1_10005(var_1_10006))

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_3.Find(var_1_2, "label")
	local var_1_4 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006
	arg_1_0.label = var_1_4(var_1_3, var_5(var_1_10006))

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_3.Find(var_1_5, "title/name")
	local var_1_7 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.titleTxt = var_1_7(var_1_6, var_5(var_1_10006))

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_3.Find(var_1_8, "desc")
	local var_1_10 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.descTxt = var_1_10(var_1_9, var_5(var_1_10006))
	UIItemList = var_3

	local var_1_11 = var_3.New
	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_4.Find(var_1_12, "awards/content")
	local var_1_14 = arg_1_0._tf

	arg_1_0.awardList = var_1_11(var_1_13, var_5.Find(var_1_14, "awards/content/item"))

	local var_1_15 = arg_1_0._tf

	arg_1_0.getBtn = var_3.Find(var_1_15, "get")

	local var_1_16 = arg_1_0._tf

	arg_1_0.gotBtn = var_3.Find(var_1_16, "got")

	local var_1_17 = arg_1_0._tf

	arg_1_0.rankBtn = var_3.Find(var_1_17, "rank")
	onButton = var_3

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.rankBtn

	local function var_1_20()
		local var_2_0 = arg_1_0.viewComponent

		var_0.ShowReportRank(var_2_0, arg_1_0.report.id)

		return
	end

	SFX_PANEL = var_7

	var_3(var_1_18, var_1_19, var_1_20, var_7)

	return
end

function var_0_0.Update(arg_3_0, arg_3_1)
	arg_3_0.report = arg_3_1

	local var_3_0 = arg_3_1:GetType()
	local var_3_1 = arg_3_0.bg

	GetSpriteFromAtlas = var_1_10004
	var_3_1.sprite = var_1_10004("ui/GuildEventReportUI_atlas", "bg_" .. var_3_0)

	local var_3_2 = arg_3_0.label

	GetSpriteFromAtlas = var_4
	var_3_2.sprite = var_4("ui/GuildEventReportUI_atlas", "text_" .. var_3_0)

	local var_3_3 = arg_3_1
	local var_3_4 = arg_3_1.IsSubmited(var_3_3)

	setActive = var_3_3

	var_3_3(arg_3_0.getBtn, not var_3_4)

	setActive = var_3_3

	var_3_3(arg_3_0.gotBtn, var_3_4)

	if not var_3_4 then
		setGray = var_3_3

		var_3_3(arg_3_0.getBtn, arg_3_1:IsLock(), true)
	end

	arg_3_0:UpdateAwards()

	arg_3_0.titleTxt.text = arg_3_1:getConfig("name")
	arg_3_0.descTxt.text = arg_3_1:GetReportDesc()

	local var_3_5 = arg_3_1
	local var_3_6 = arg_3_1.IsBoss(var_3_5)

	setActive = var_3_5

	var_3_5(arg_3_0.rankBtn, var_3_6)

	return
end

function var_0_0.UpdateAwards(arg_4_0)
	local var_4_0 = arg_4_0.report
	local var_4_1, var_4_2 = var_1.GetDrop(var_4_0)
	local var_4_3 = arg_4_0.awardList

	var_4.make(var_4_3, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = var_4_1[arg_5_1 + 1]
			local var_5_1 = {
				type = var_5_0[1],
				id = var_5_0[2],
				count = var_5_0[3]
			}

			updateDrop = var_5

			var_5(arg_5_2, var_5_1)

			onButton = var_5

			local var_5_2 = arg_4_0
			local var_5_3 = arg_5_2

			local function var_5_4()
				local var_6_0 = arg_4_0.viewComponent
				local var_6_1 = var_0.emit

				BaseUI = var_3_10002

				var_6_1(var_6_0, var_3_10002.ON_DROP, var_5_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_5_2, var_5_3, var_5_4, var_2_10009)

			setActive = var_5

			var_5(arg_5_2:Find("icon_bg/bouns"), arg_5_1 + 1 <= var_4_2)
		end

		return
	end)

	local var_4_4 = arg_4_0.awardList

	var_4.align(var_4_4, #var_4_1)

	return
end

function var_0_0.Dispose(arg_7_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_7_0)

	return
end

return var_0_0
