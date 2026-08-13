class = var_0_10000

local var_0_0 = "GuildEventReportLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GuildEventReportUI"
end

function var_0_1.SetReports(arg_2_0, arg_2_1)
	arg_2_0.reports = arg_2_1

	return
end

function var_0_1.OnGetReportRankList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.rankPage

	var_2.ExecuteAction(var_3_0, "Show", arg_3_1)

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "frame/scrollrect")

	arg_4_0.scrollrect = var_1.GetComponent(var_4_1, "LScrollRect")

	local var_4_2 = arg_4_0._tf

	arg_4_0.getAll = var_1.Find(var_4_2, "frame/get_all")

	local var_4_3 = arg_4_0._tf

	arg_4_0.gotAll = var_1.Find(var_4_3, "frame/get_all/gray")

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_1.Find(var_4_4, "frame/desc")
	local var_4_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.descTxt = var_4_6(var_4_5, var_3(var_1_10004))

	local var_4_7 = arg_4_0._tf
	local var_4_8 = var_1.Find(var_4_7, "frame/cnt")
	local var_4_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_4_0.cntTxt = var_4_9(var_4_8, var_3(var_1_10004))

	local var_4_10 = arg_4_0._tf

	arg_4_0.closeBtn = var_1.Find(var_4_10, "frame/close")
	setText = var_1

	local var_4_11 = arg_4_0.getAll
	local var_4_12 = var_2.Find(var_4_11, "Text")

	i18n = var_4_11

	var_1(var_4_12, var_4_11("guild_report_get_all"))

	arg_4_0._parentTf = arg_4_0._tf.parent
	setText = var_1

	local var_4_13 = arg_4_0._tf
	local var_4_14 = var_2.Find(var_4_13, "frame/desc")

	i18n = var_4_13

	var_1(var_4_14, var_4_13("guild_report_tooltip"))

	GuildBossRankPage = var_1
	arg_4_0.rankPage = var_1.New(arg_4_0._tf, arg_4_0.event)

	return
end

function var_0_1.didEnter(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_0, arg_5_0._tf)

	onButton = var_1

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.closeBtn

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_1, var_5_2, var_5_3, var_1_10005)

	onButton = var_1

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf

	local function var_5_6()
		local var_7_0 = arg_5_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_4, var_5_5, var_5_6, var_1_10005)

	onButton = var_1

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.getAll

	local function var_5_9()
		local var_8_0 = {}

		pairs = var_2_10001

		for iter_8_0, iter_8_1 in var_2_10001(arg_5_0.reports) do
			if iter_8_1:CanSubmit() then
				table = var_6

				var_6.insert(var_8_0, iter_8_1.id)
			end
		end

		if #var_8_0 == 0 then
			return
		end

		local var_8_1 = arg_5_0
		local var_8_2 = var_1.emit

		GuildEventReportMediator = var_3

		var_8_2(var_8_1, var_3.ON_SUBMIT_REPORTS, var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_5_7, var_5_8, var_5_9, var_1_10005)

	function arg_5_0.scrollrect.onInitItem(arg_9_0)
		local var_9_0 = arg_5_0

		var_1.OnInitItem(var_9_0, arg_9_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_10_0, arg_10_1)
		local var_10_0 = arg_5_0

		var_2.OnUpdateItem(var_10_0, arg_10_0, arg_10_1)

		return
	end

	arg_5_0:SetTotalCount()
	arg_5_0:UpdateGetAllBtn()

	return
end

function var_0_1.preload(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.m02
	local var_11_1 = var_2.sendNotification

	GAME = var_1_10004

	var_11_1(var_11_0, var_1_10004.GET_GUILD_REPORT, {
		callback = function(arg_12_0)
			local var_12_0 = arg_11_0

			var_1.SetReports(var_12_0, arg_12_0)
			arg_11_1()

			return
		end
	})

	return
end

function var_0_1.UpdateReports(arg_13_0, arg_13_1)
	ipairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_1) do
		pairs = var_1_10007

		for iter_13_2, iter_13_3 in var_1_10007(arg_13_0.cards) do
			if iter_13_3.report.id == iter_13_1 then
				local var_13_0 = arg_13_0.reports[iter_13_1]

				iter_13_3:Update(var_13_0)
			end
		end
	end

	arg_13_0:UpdateGetAllBtn()

	return
end

function var_0_1.UpdateGetAllBtn(arg_14_0)
	local var_14_0

	if #arg_14_0.displays ~= 0 then
		_ = var_1
		var_14_0 = var_1.all(arg_14_0.displays, function(arg_15_0)
			return not arg_15_0:CanSubmit()
		end)

		if false then
			var_14_0 = false
		end
	else
		var_14_0 = true
	end

	setActive = var_1_10002

	var_1_10002(arg_14_0.gotAll, var_14_0)

	return
end

function var_0_1.SetTotalCount(arg_16_0)
	arg_16_0.displays = {}
	pairs = var_1

	for iter_16_0, iter_16_1 in var_1(arg_16_0.reports) do
		table = var_1_10006

		var_1_10006.insert(arg_16_0.displays, iter_16_1)
	end

	local function var_16_0(arg_17_0)
		if arg_17_0.state == 0 then
			return 1
		elseif arg_17_0.state == 1 then
			return 2
		elseif arg_17_0.state == 2 then
			return 0
		end

		return
	end

	table = var_2

	var_2.sort(arg_16_0.displays, function(arg_18_0, arg_18_1)
		return var_16_0(arg_18_0) > var_16_0(arg_18_1)
	end)

	local var_16_1 = arg_16_0.scrollrect

	var_2.SetTotalCount(var_16_1, #arg_16_0.displays)

	local var_16_2 = arg_16_0.cntTxt
	local var_16_3 = #arg_16_0.displays
	local var_16_4 = "/"

	GuildConst = iter_16_1
	var_16_2.text = var_16_3 .. var_16_4 .. iter_16_1.MAX_REPORT_CNT()

	return
end

function var_0_1.OnInitItem(arg_19_0, arg_19_1)
	GuildReportCard = var_1_10002

	local var_19_0 = var_1_10002.New(arg_19_1, arg_19_0)

	if not arg_19_0.cards then
		arg_19_0.cards = {}
	end

	onButton = var_3

	local var_19_1 = arg_19_0
	local var_19_2 = var_19_0.getBtn

	local function var_19_3()
		local var_20_0 = var_19_0.report

		if var_0.IsLock(var_20_0) then
			pg = var_0

			local var_20_1 = var_0.TipsMgr.GetInstance()
			local var_20_2 = var_0.ShowTips

			i18n = var_2_10002

			var_20_2(var_20_1, var_2_10002("guild_can_not_get_tip"))

			return
		end

		local var_20_3 = arg_19_0
		local var_20_4 = var_0.emit

		GuildEventReportMediator = var_2_10002

		var_20_4(var_20_3, var_2_10002.ON_SUBMIT_REPORTS, {
			var_19_0.report.id
		})

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_19_1, var_19_2, var_19_3, var_1_10007)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_1.OnUpdateItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	if not arg_21_0.cards[arg_21_2] then
		arg_21_0:OnInitItem(arg_21_2)

		var_21_0 = arg_21_0.cards[arg_21_2]
	end

	local var_21_1 = arg_21_0.displays[arg_21_1 + 1]

	var_21_0:Update(var_21_1)

	return
end

function var_0_1.ShowReportRank(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.emit

	GuildEventReportMediator = var_1_10004

	var_22_1(var_22_0, var_1_10004.GET_REPORT_RANK, arg_22_1)

	return
end

function var_0_1.willExit(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_23_0, arg_23_0._tf, arg_23_0._parentTf)

	if arg_23_0.cards then
		pairs = var_1

		for iter_23_0, iter_23_1 in var_1(arg_23_0.cards) do
			iter_23_1:Dispose()
		end

		arg_23_0.cards = nil
	end

	if arg_23_0.rankPage then
		local var_23_1 = arg_23_0.rankPage

		var_1.Destroy(var_23_1)

		arg_23_0.rankPage = nil
	end

	return
end

return var_0_1
