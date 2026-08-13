class = var_0_10000

local var_0_0 = "IslandSeasonPtPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.AWARD_SHOW_CNT = 6
var_0_1.AWARD_OFFSET = 1e-05

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonPtPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "pt")

	arg_2_0.ptValueTF = var_1.Find(var_2_1, "pt/value")
	setText = var_2

	local var_2_2 = var_1
	local var_2_3 = var_1.Find(var_2_2, "Text")

	i18n = var_2_2

	var_2(var_2_3, var_2_2("island_season_pt_hold"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.getAllBtn = var_2.Find(var_2_4, "get_all")
	setText = var_2

	local var_2_5 = arg_2_0.getAllBtn
	local var_2_6 = var_3.Find(var_2_5, "Text")

	i18n = var_2_5

	var_2(var_2_6, var_2_5("island_season_pt_collectall"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.blurTF = var_2.Find(var_2_7, "content")

	local var_2_8 = arg_2_0.blurTF
	local var_2_9 = var_2.Find(var_2_8, "view")

	arg_2_0.scrollCom = var_2.GetComponent(var_2_9, "LScrollRect")

	local var_2_10 = arg_2_0._tf

	arg_2_0.importantAwardTF = var_2.Find(var_2_10, "important")

	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0.scrollCom

	function var_3_0.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0
		local var_4_1 = var_2.UpdateAward
		local var_4_2 = arg_4_0

		tf = var_2_10005

		var_4_1(var_4_0, var_4_2, var_2_10005(arg_4_1))

		return
	end

	onButton = var_3_0

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.getAllBtn

	local function var_3_3()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		IslandMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_GET_SEASON_PT_AWARD, 0)

		return
	end

	SFX_PANEL = var_1_10005

	var_3_0(var_3_1, var_3_2, var_3_3, var_1_10005)
	arg_3_0:BuildPhaseAwardScrollPos()

	local var_3_4 = arg_3_0.scrollCom.onValueChanged

	var_1.AddListener(var_3_4, function(arg_6_0)
		local var_6_0 = arg_3_0

		var_1.UpdateNextAward(var_6_0, arg_6_0.x)

		return
	end)

	return
end

function var_0_1.UpdateAward(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.awardInfos[arg_7_1 + 1]

	setText = var_4

	var_4(arg_7_2:Find("target"), var_7_0.target)

	updateCustomDrop = var_4

	var_4(arg_7_2:Find("drop"), var_7_0.drop)

	local var_7_1 = arg_7_0.pt
	local var_7_2 = var_7_0.target <= var_7_1

	table = var_5

	local var_7_3 = var_5.contains(arg_7_0.gotList, var_7_0.target)

	setActive = var_6

	var_6(arg_7_2:Find("got"), var_7_3)

	setActive = var_6

	var_6(arg_7_2:Find("get"), not var_7_3 and var_7_2)

	setActive = var_6

	var_6(arg_7_2:Find("lock"), not var_7_2)

	onButton = var_6

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_2:Find("get")

	local function var_7_6()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		IslandMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_GET_SEASON_PT_AWARD, var_7_0.target)

		return
	end

	SFX_PANEL = var_10

	var_6(var_7_4, var_7_5, var_7_6, var_10)

	onButton = var_6

	var_6(arg_7_0, arg_7_2, function()
		local var_9_0 = arg_7_0.contextData
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		i18n = var_2_10003
		var_9_2.title = var_2_10003("island_word_desc")
		IslandMsgBox = var_3
		var_9_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
		var_9_2.dropData = var_7_0.drop

		var_9_1(var_9_0, var_9_2)

		return
	end)

	return
end

function var_0_1.Show(arg_10_0)
	arg_10_0.super.Show(arg_10_0)
	arg_10_0:Flush()
	arg_10_0:OverlayPanel(arg_10_0._tf, {
		pbList = {
			arg_10_0.blurTF
		}
	})

	IslandGuideChecker = var_1

	var_1.CheckGuide("ISLAND_GUIDE_15")

	return
end

function var_0_1.Flush(arg_11_0)
	if not arg_11_0:isShowing() then
		return
	end

	local var_11_0 = arg_11_0.contextData.season

	arg_11_0.pt = var_1.GetPt(var_11_0)

	local var_11_1 = arg_11_0.contextData.season

	arg_11_0.gotList = var_1.GetGotPtAwardList(var_11_1)
	setText = var_1

	var_1(arg_11_0.ptValueTF, arg_11_0.pt)

	setActive = var_1

	local var_11_2 = arg_11_0.getAllBtn
	local var_11_3 = arg_11_0.contextData.season

	var_1(var_11_2, var_3.GanGetPtAward(var_11_3))

	local var_11_4 = arg_11_0.scrollCom

	var_1.SetTotalCount(var_11_4, #arg_11_0.awardInfos)
	arg_11_0:UpdateNextAward(arg_11_0.scrollCom.value)

	return
end

function var_0_1.BuildPhaseAwardScrollPos(arg_12_0)
	IslandSeason = var_1_10001
	arg_12_0.awardInfos = var_1_10001.GetPtAwardInfos(arg_12_0.contextData.season.id)

	local var_12_0 = arg_12_0.scrollCom
	local var_12_1 = var_1.HeadIndexToValue(var_12_0, #arg_12_0.awardInfos - var_0_1.AWARD_SHOW_CNT)
	local var_12_2 = arg_12_0.scrollCom

	arg_12_0.impTotalPos = var_12_1 - var_2.HeadIndexToValue(var_12_2, 0)
	arg_12_0.importantInfos = {}
	pairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.awardInfos) do
		if iter_12_1.isImportant then
			table = var_6

			local var_12_3 = var_6.insert
			local var_12_4 = arg_12_0.importantInfos
			local var_12_5 = {
				idx = iter_12_0
			}
			local var_12_6 = arg_12_0.scrollCom

			var_12_5.pos = var_9.HeadIndexToValue(var_12_6, iter_12_0 - var_0_1.AWARD_SHOW_CNT) / arg_12_0.impTotalPos

			var_12_3(var_12_4, var_12_5)
		end
	end

	return
end

function var_0_1.UpdateNextAward(arg_13_0, arg_13_1)
	math = var_1_10002
	arg_13_1 = var_1_10002.min(arg_13_1, 1)
	pairs = var_2

	for iter_13_0, iter_13_1 in var_2(arg_13_0.importantInfos) do
		if arg_13_1 + var_0_1.AWARD_OFFSET < iter_13_1.pos then
			setActive = var_7

			var_7(arg_13_0.importantAwardTF, true)
			arg_13_0:UpdateAward(iter_13_1.idx - 1, arg_13_0.importantAwardTF)

			break
		elseif iter_13_0 == #arg_13_0.importantInfos then
			setActive = var_7

			var_7(arg_13_0.importantAwardTF, false)
		end
	end

	return
end

function var_0_1.Hide(arg_14_0)
	arg_14_0.super.Hide(arg_14_0)
	arg_14_0:OnHide()

	return
end

function var_0_1.OnHide(arg_15_0)
	arg_15_0:UnOverlayPanel(arg_15_0._tf, arg_15_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_16_0.scrollCom)
	arg_16_0:OnHide()

	return
end

return var_0_1
