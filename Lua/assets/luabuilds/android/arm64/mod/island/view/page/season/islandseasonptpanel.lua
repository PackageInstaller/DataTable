local var_0_0 = class("IslandSeasonPtPanel", import("view.base.BaseSubView"))

var_0_0.AWARD_SHOW_CNT = 6
var_0_0.AWARD_OFFSET = 1e-05

function var_0_0.getUIName(arg_1_0)
	return "IslandSeasonPtPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("pt")

	arg_2_0.ptValueTF = var_2_0:Find("pt/value")

	setText(var_2_0:Find("Text"), i18n("island_season_pt_hold"))

	arg_2_0.getAllBtn = arg_2_0._tf:Find("get_all")

	setText(arg_2_0.getAllBtn:Find("Text"), i18n("island_season_pt_collectall"))

	arg_2_0.blurTF = arg_2_0._tf:Find("content")
	arg_2_0.scrollCom = arg_2_0.blurTF:Find("view"):GetComponent("LScrollRect")
	arg_2_0.importantAwardTF = arg_2_0._tf:Find("important")

	return
end

function var_0_0.OnInit(arg_3_0)
	function arg_3_0.scrollCom.onUpdateItem(arg_4_0, arg_4_1)
		arg_3_0:UpdateAward(arg_4_0, tf(arg_4_1))

		return
	end

	onButton(arg_3_0, arg_3_0.getAllBtn, function()
		arg_3_0:emit(IslandMediator.ON_GET_SEASON_PT_AWARD, 0)

		return
	end, SFX_PANEL)
	arg_3_0:BuildPhaseAwardScrollPos()
	arg_3_0.scrollCom.onValueChanged:AddListener(function(arg_6_0)
		arg_3_0:UpdateNextAward(arg_6_0.x)

		return
	end)

	return
end

function var_0_0.UpdateAward(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.awardInfos[arg_7_1 + 1]

	setText(arg_7_2:Find("target"), arg_7_0.awardInfos[arg_7_1 + 1].target)
	updateCustomDrop(arg_7_2:Find("drop"), var_7_0.drop)

	local var_7_1 = arg_7_0.pt >= var_7_0.target
	local var_7_2 = table.contains(arg_7_0.gotList, var_7_0.target)

	setActive(arg_7_2:Find("got"), var_7_2)
	setActive(arg_7_2:Find("get"), not var_7_2 and var_7_1)
	setActive(arg_7_2:Find("lock"), not var_7_1)
	onButton(arg_7_0, arg_7_2:Find("get"), function()
		arg_7_0:emit(IslandMediator.ON_GET_SEASON_PT_AWARD, var_7_0.target)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_2, function()
		arg_7_0.contextData:ShowMsgBox({
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_7_0.drop
		})

		return
	end)

	return
end

function var_0_0.Show(arg_10_0)
	arg_10_0.super.Show(arg_10_0)
	arg_10_0:Flush()
	arg_10_0:OverlayPanel(arg_10_0._tf, {
		pbList = {
			arg_10_0.blurTF
		}
	})
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_15")

	return
end

function var_0_0.Flush(arg_11_0)
	if not arg_11_0:isShowing() then
		return
	end

	arg_11_0.pt = arg_11_0.contextData.season:GetPt()
	arg_11_0.gotList = arg_11_0.contextData.season:GetGotPtAwardList()

	setText(arg_11_0.ptValueTF, arg_11_0.pt)
	setActive(arg_11_0.getAllBtn, arg_11_0.contextData.season:GanGetPtAward())
	arg_11_0.scrollCom:SetTotalCount(#arg_11_0.awardInfos)
	arg_11_0:UpdateNextAward(arg_11_0.scrollCom.value)

	return
end

function var_0_0.BuildPhaseAwardScrollPos(arg_12_0)
	arg_12_0.awardInfos = IslandSeason.GetPtAwardInfos(arg_12_0.contextData.season.id)
	arg_12_0.impTotalPos = arg_12_0.scrollCom:HeadIndexToValue(#arg_12_0.awardInfos - var_0_0.AWARD_SHOW_CNT) - arg_12_0.scrollCom:HeadIndexToValue(0)
	arg_12_0.importantInfos = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.awardInfos) do
		if iter_12_1.isImportant then
			table.insert(arg_12_0.importantInfos, {
				idx = iter_12_0,
				pos = arg_12_0.scrollCom:HeadIndexToValue(iter_12_0 - var_0_0.AWARD_SHOW_CNT) / arg_12_0.impTotalPos
			})
		end
	end

	return
end

function var_0_0.UpdateNextAward(arg_13_0, arg_13_1)
	arg_13_1 = math.min(arg_13_1, 1)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.importantInfos) do
		if arg_13_1 + var_0_0.AWARD_OFFSET < iter_13_1.pos then
			setActive(arg_13_0.importantAwardTF, true)
			arg_13_0:UpdateAward(iter_13_1.idx - 1, arg_13_0.importantAwardTF)

			break
		elseif iter_13_0 == #arg_13_0.importantInfos then
			setActive(arg_13_0.importantAwardTF, false)
		end
	end

	return
end

function var_0_0.Hide(arg_14_0)
	arg_14_0.super.Hide(arg_14_0)
	arg_14_0:OnHide()

	return
end

function var_0_0.OnHide(arg_15_0)
	arg_15_0:UnOverlayPanel(arg_15_0._tf, arg_15_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	ClearLScrollrect(arg_16_0.scrollCom)
	arg_16_0:OnHide()

	return
end

return var_0_0
