ChapterSectionView = import("game.views.sectionSelect.chapter.ChapterSectionView")

local var_0_0 = class("ChapterSectionRollBgView", ChapterSectionView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	arg_1_0.bgTypeController_:SetSelectedState("roll")
	arg_1_0:SwitchBG()
end

function var_0_0.RefreshUI(arg_2_0)
	var_0_0.super.RefreshUI(arg_2_0)
	arg_2_0:SwitchBG()
end

function var_0_0.SwitchBG(arg_3_0)
	arg_3_0:AddRollBG()
end

function var_0_0.AddRollBG(arg_4_0)
	local var_4_0 = ChapterCfg[arg_4_0.chapterID_].bg

	if arg_4_0.rollBgPath and arg_4_0.rollBgPath == var_4_0 then
		arg_4_0:UpdateBgWidth()
		arg_4_0:OnScrollValueChanged(true)

		return
	elseif arg_4_0.rollBg then
		GameObject.Destroy(arg_4_0.rollBg)

		arg_4_0.rollBg = nil
	end

	local var_4_1 = Asset.Load(var_4_0)

	if not arg_4_0.rollBg then
		arg_4_0.rollBg = GameObject.Instantiate(var_4_1, arg_4_0.rollnodebgTrs_)
		arg_4_0.rollBgTrs = arg_4_0.rollBg.transform
		arg_4_0.rollBgPos = arg_4_0.rollBgTrs.localPosition
		arg_4_0.bgWidth = arg_4_0.rollBgTrs:Find("panel/bg"):GetComponent("RectTransform").sizeDelta.x
	end

	arg_4_0:UpdateBgWidth()

	arg_4_0.rollBgPath = var_4_0
end

function var_0_0.UpdateBgWidth(arg_5_0)
	if arg_5_0.bgWidth then
		local var_5_0 = manager.ui.canvasSize_

		arg_5_0.bgMaxWidth = (arg_5_0.bgWidth - var_5_0.x) * arg_5_0:CalcuteStageOpenProgress()
	end
end

function var_0_0.FindMaxScrollPos(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = ChapterCfg[arg_6_0.chapterID_].section_id_list

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = arg_6_0:GetCfgName()[iter_6_1]
		local var_6_3 = var_6_2.position ~= "" and var_6_2.position[1] or 0

		if var_6_0 < var_6_3 then
			var_6_0 = var_6_3
		end
	end

	return var_6_0
end

function var_0_0.CalcuteStageOpenProgress(arg_7_0)
	local var_7_0 = arg_7_0:FindMaxScrollPos() + arg_7_0.viewportRect_.rect.width / 4

	return (arg_7_0:GetScrollWidth() + arg_7_0.viewportRect_.rect.width / 4) / var_7_0
end

function var_0_0.OnScrollValueChanged(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.scrollMoveView_.scrollView_.horizontalNormalizedPosition

	if not arg_8_1 and arg_8_0.contentRect_.rect.width < arg_8_0.viewportRect_.rect.width then
		return
	end

	if arg_8_0.rollBg and arg_8_0.rollBgPos then
		local var_8_1 = -var_8_0 * arg_8_0.bgMaxWidth

		if var_8_1 > 0 then
			var_8_1 = 0
		end

		if var_8_1 < -arg_8_0.bgMaxWidth then
			var_8_1 = -arg_8_0.bgMaxWidth
		end

		arg_8_0.rollBgPos.x = var_8_1
		arg_8_0.rollBgTrs.localPosition = arg_8_0.rollBgPos
	end
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)

	arg_9_0.rollBgPath = nil

	if arg_9_0.rollBg then
		GameObject.Destroy(arg_9_0.rollBg)

		arg_9_0.rollBg = nil
	end
end

return var_0_0
