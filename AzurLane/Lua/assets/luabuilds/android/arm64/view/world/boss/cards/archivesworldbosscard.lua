local var_0_0 = class("ArchivesWorldBossCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.icon = arg_1_0._tf:Find("icon"):GetComponent(typeof(Image))
	arg_1_0.underwayTr = arg_1_0._tf:Find("underway")
	arg_1_0.staticTr = arg_1_0._tf:Find("static")
	arg_1_0.finishTr = arg_1_0._tf:Find("finish")
	arg_1_0.nameTxt = arg_1_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_1_0.staticMaskTr = arg_1_0._tf:Find("static_mask")
	arg_1_0.uProgress = arg_1_0.underwayTr:Find("progress/bar")
	arg_1_0.uProgressTxt = arg_1_0.underwayTr:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.sProgress = arg_1_0.staticTr:Find("progress/bar")
	arg_1_0.sProgressTxt = arg_1_0.staticTr:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.fProgress = arg_1_0.staticTr:Find("progress/bar")
	arg_1_0.arrTr = arg_1_0._tf:Find("arr")
	arg_1_0.arrLpos = arg_1_0.arrTr.localPosition
	arg_1_0.sLabel = arg_1_0.staticTr:Find("Text/label")
	arg_1_0.sSynValue = arg_1_0.staticTr:Find("Text1")
	arg_1_0.sLabelLpos = arg_1_0.sLabel.localPosition
	arg_1_0.underwayLabelStr = i18n("meta_pt_point")

	setText(arg_1_0.underwayTr:Find("label"), arg_1_0.underwayLabelStr)
	setText(arg_1_0.sLabel, i18n("meta_syn_rate"))

	arg_1_0.tip = arg_1_0._tf:Find("tip")

	setActive(arg_1_0.arrTr, false)

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1
	arg_2_0.bossId = arg_2_1.id
	arg_2_0.metaProgressVO = arg_2_1.progress

	arg_2_0:Flush()

	return
end

function var_0_0.Flush(arg_3_0)
	local var_3_0 = arg_3_0.bossId == WorldBossConst.GetArchivesId() and WorldBossConst.GetAchieveState() ~= WorldBossConst.ACHIEVE_STATE_NOSTART
	local var_3_2 = not arg_3_0.metaProgressVO.metaPtData:CanGetNextAward()

	setActive(arg_3_0.underwayTr, var_3_0 and not var_3_2)
	setActive(arg_3_0.staticTr, not var_3_0 and not var_3_2)
	setActive(arg_3_0.staticMaskTr, not var_3_0 and not var_3_2)
	setActive(arg_3_0.finishTr, var_3_2)

	local var_3_3 = var_3_1:GetResProgress()
	local var_3_4 = var_3_1:GetTotalResRequire()
	local var_3_5 = arg_3_0.metaProgressVO.metaPtData.level + 1 > arg_3_0.metaProgressVO.unlockPTLevel

	arg_3_0.icon.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_3_0.metaProgressVO.id, "archives")
	arg_3_0.sLabel.localPosition = Vector3(arg_3_0.sLabel.localPosition.x, arg_3_0.sLabelLpos.y, 0)

	if var_3_2 then
		setFillAmount(arg_3_0.fProgress, 1)
	elseif var_3_0 then
		setFillAmount(arg_3_0.uProgress, var_3_3 / var_3_4)
		setText(arg_3_0.underwayTr:Find("label"), arg_3_0.underwayLabelStr .. "(" .. var_3_3 .. "/" .. var_3_4 .. ")")
	else
		setText(arg_3_0.underwayTr:Find("label"), arg_3_0.underwayLabelStr)

		if var_3_5 then
			arg_3_0.sProgressTxt.enabled = false

			setText(arg_3_0.staticTr:Find("label"), i18n("meta_pt_point"))
			setText(arg_3_0.sLabel, i18n("meta_syn_finish"))
			setText(arg_3_0.sSynValue, "(" .. var_3_3 .. "/" .. var_3_4 .. ")")

			arg_3_0.sLabel.localPosition = Vector3(arg_3_0.sLabel.localPosition.x, arg_3_0.sLabelLpos.y + 20, 0)

			setFillAmount(arg_3_0.sProgress, var_3_3 / var_3_4)
		else
			arg_3_0.sProgressTxt.enabled = true

			setText(arg_3_0.staticTr:Find("label"), "")
			setText(arg_3_0.sSynValue, "")
			setText(arg_3_0.sLabel, i18n("meta_syn_rate"))

			local var_3_6 = math.min(1, var_3_3 / arg_3_0.metaProgressVO.unlockPTNum)

			setFillAmount(arg_3_0.sProgress, var_3_6)

			arg_3_0.sProgressTxt.text = string.format("%0.1f", var_3_6 * 100) .. "%"
		end
	end

	arg_3_0.nameTxt.text = ShipGroup.getDefaultShipConfig(arg_3_0.metaProgressVO.id).name

	setActive(arg_3_0.tip, var_3_1:CanGetAward())

	return
end

function var_0_0.Select(arg_4_0)
	arg_4_0:UnSelect()
	setActive(arg_4_0.arrTr, true)
	LeanTween.value(arg_4_0.arrTr.gameObject, arg_4_0.arrLpos.x, arg_4_0.arrLpos.x - 20, 0.9):setOnUpdate(System.Action_float(function(arg_5_0)
		arg_4_0.arrTr.localPosition = Vector3(arg_5_0, arg_4_0.arrLpos.y, 0)

		return
	end)):setLoopPingPong()

	return
end

function var_0_0.UnSelect(arg_6_0)
	setActive(arg_6_0.arrTr, false)
	LeanTween.cancel(arg_6_0.arrTr.gameObject)

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UnSelect()

	return
end

return var_0_0
