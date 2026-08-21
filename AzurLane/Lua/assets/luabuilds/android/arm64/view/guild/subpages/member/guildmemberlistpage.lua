local var_0_0 = class("GuildMemberListPage", import("...base.GuildBasePage"))

function var_0_0.getTargetUI(arg_1_0)
	return "GuildMemberListBlueUI", "GuildMemberListRedUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.rectView = arg_2_0._tf:Find("scroll")
	arg_2_0.rectRect = arg_2_0.rectView:GetComponent("LScrollRect")
	arg_2_0.rankBtn = arg_2_0._tf:Find("rank")
	arg_2_0.blurBg = arg_2_0._tf:Find("blur_bg")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.rankBtn, function()
		arg_3_0.contextData.rankPage:ExecuteAction("Flush", arg_3_0.ranks)

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():OverlayPanel(arg_3_0._tf, {
		pbList = {
			arg_3_0.blurBg
		},
		overlayType = LayerWeightConst.OVERLAY_UI_ADAPT
	})

	arg_3_0.items = {}

	function arg_3_0.rectRect.onInitItem(arg_5_0)
		arg_3_0:OnInitItem(arg_5_0)

		return
	end

	function arg_3_0.rectRect.onUpdateItem(arg_6_0, arg_6_1)
		arg_3_0:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	return
end

function var_0_0.SetUp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:Show()
	arg_7_0:Flush(arg_7_1, arg_7_2, arg_7_3)

	return
end

function var_0_0.Flush(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.ranks = arg_8_3
	arg_8_0.memberVOs = arg_8_2
	arg_8_0.guildVO = arg_8_1

	arg_8_0:SetTotalCount()

	return
end

function var_0_0.SetTotalCount(arg_9_0)
	table.sort(arg_9_0.memberVOs, function(arg_10_0, arg_10_1)
		if arg_10_0.duty ~= arg_10_1.duty then
			return arg_10_0.duty < arg_10_1.duty
		else
			return arg_10_0.liveness > arg_10_1.liveness
		end

		return
	end)
	arg_9_0.rectRect:SetTotalCount(#arg_9_0.memberVOs, 0)

	return
end

function var_0_0.OnInitItem(arg_11_0, arg_11_1)
	local var_11_0 = GuildMemberCard.New(arg_11_1)

	onButton(arg_11_0, var_11_0.tf, function()
		if arg_11_0.selected == var_11_0 then
			return
		end

		if arg_11_0.selected then
			arg_11_0.selected:SetSelected(false)
		end

		arg_11_0.selected = var_11_0

		arg_11_0.selected:SetSelected(true)

		arg_11_0.selectedId = var_11_0.memberVO.id

		if arg_11_0.OnClickMember then
			arg_11_0.OnClickMember(var_11_0.memberVO)
		end

		return
	end, SFX_PANEL)

	arg_11_0.items[arg_11_1] = var_11_0

	return
end

function var_0_0.OnUpdateItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.items[arg_13_2]

	if not arg_13_0.items[arg_13_2] then
		arg_13_0:OnInitItem(arg_13_2)

		var_13_0 = arg_13_0.items[arg_13_2]
	end

	local var_13_1 = arg_13_0.memberVOs[arg_13_1 + 1]

	var_13_0:Update(arg_13_0.memberVOs[arg_13_1 + 1], arg_13_0.guildVO)

	local var_13_2 = arg_13_0.selectedId and arg_13_0.selectedId == var_13_1.id

	var_13_0:SetSelected(var_13_2)

	if not arg_13_0.selected and arg_13_1 == 0 then
		triggerButton(var_13_0.tf)
	end

	return
end

function var_0_0.TriggerFirstCard(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.items) do
		if iter_14_1.memberVO.id == arg_14_0.memberVOs[1].id then
			triggerButton(iter_14_1.tf)

			break
		end
	end

	return
end

function var_0_0.OnDestroy(arg_15_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf, arg_15_0._parentTf)

	for iter_15_0, iter_15_1 in pairs(arg_15_0.items) do
		iter_15_1:Dispose()
	end

	return
end

return var_0_0
