class = var_0_10000

local var_0_0 = var_0_10000("ArchivesWorldBossCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.icon = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0._tf

	arg_1_0.underwayTr = var_2.Find(var_1_3, "underway")

	local var_1_4 = arg_1_0._tf

	arg_1_0.staticTr = var_2.Find(var_1_4, "static")

	local var_1_5 = arg_1_0._tf

	arg_1_0.finishTr = var_2.Find(var_1_5, "finish")

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_2.Find(var_1_6, "name")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_8(var_1_7, var_4(var_1_10005))

	local var_1_9 = arg_1_0._tf

	arg_1_0.staticMaskTr = var_2.Find(var_1_9, "static_mask")

	local var_1_10 = arg_1_0.underwayTr

	arg_1_0.uProgress = var_2.Find(var_1_10, "progress/bar")

	local var_1_11 = arg_1_0.underwayTr
	local var_1_12 = var_2.Find(var_1_11, "Text")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.uProgressTxt = var_1_13(var_1_12, var_4(var_1_10005))

	local var_1_14 = arg_1_0.staticTr

	arg_1_0.sProgress = var_2.Find(var_1_14, "progress/bar")

	local var_1_15 = arg_1_0.staticTr
	local var_1_16 = var_2.Find(var_1_15, "Text")
	local var_1_17 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.sProgressTxt = var_1_17(var_1_16, var_4(var_1_10005))

	local var_1_18 = arg_1_0.staticTr

	arg_1_0.fProgress = var_2.Find(var_1_18, "progress/bar")

	local var_1_19 = arg_1_0._tf

	arg_1_0.arrTr = var_2.Find(var_1_19, "arr")
	arg_1_0.arrLpos = arg_1_0.arrTr.localPosition

	local var_1_20 = arg_1_0.staticTr

	arg_1_0.sLabel = var_2.Find(var_1_20, "Text/label")

	local var_1_21 = arg_1_0.staticTr

	arg_1_0.sSynValue = var_2.Find(var_1_21, "Text1")
	arg_1_0.sLabelLpos = arg_1_0.sLabel.localPosition
	i18n = var_2
	arg_1_0.underwayLabelStr = var_2("meta_pt_point")
	setText = var_2

	local var_1_22 = arg_1_0.underwayTr

	var_2(var_3.Find(var_1_22, "label"), arg_1_0.underwayLabelStr)

	setText = var_2

	local var_1_23 = arg_1_0.sLabel

	i18n = var_4

	var_2(var_1_23, var_4("meta_syn_rate"))

	local var_1_24 = arg_1_0._tf

	arg_1_0.tip = var_2.Find(var_1_24, "tip")
	setActive = var_2

	var_2(arg_1_0.arrTr, false)

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
	local var_3_0 = arg_3_0.metaProgressVO

	WorldBossConst = var_1_10002

	local var_3_1 = var_1_10002.GetArchivesId()

	if arg_3_0.bossId == var_3_1 then
		WorldBossConst = var_3

		local var_3_2 = var_3.GetAchieveState()

		WorldBossConst = var_1_10004

		local var_3_3

		if var_3_2 == var_1_10004.ACHIEVE_STATE_NOSTART then
			var_3_3 = false
		else
			var_3_3 = true
		end

		local var_3_4 = var_3_0.metaPtData
		local var_3_5 = not var_4.CanGetNextAward(var_3_4)

		setActive = var_3_4

		var_3_4(arg_3_0.underwayTr, var_3_3 and not var_3_5)

		setActive = var_3_4

		var_3_4(arg_3_0.staticTr, not var_3_3 and not var_3_5)

		setActive = var_3_4

		var_3_4(arg_3_0.staticMaskTr, not var_3_3 and not var_3_5)

		setActive = var_3_4

		var_3_4(arg_3_0.finishTr, var_3_5)

		local var_3_6 = var_4:GetResProgress()
		local var_3_7 = var_4:GetTotalResRequire()
		local var_3_8 = var_3_0.metaPtData.level + 1 > var_3_0.unlockPTLevel
		local var_3_9 = var_3_0.id
		local var_3_10 = arg_3_0.icon

		GetSpriteFromAtlas = var_1_10011
		var_3_10.sprite = var_1_10011("MetaWorldboss/" .. var_3_9, "archives")

		local var_3_11 = arg_3_0.sLabel

		Vector3 = var_11
		var_3_11.localPosition = var_11(arg_3_0.sLabel.localPosition.x, arg_3_0.sLabelLpos.y, 0)

		if var_3_5 then
			setFillAmount = var_3_11

			var_3_11(arg_3_0.fProgress, 1)
		elseif var_3_3 then
			setFillAmount = var_3_11

			var_3_11(arg_3_0.uProgress, var_3_6 / var_3_7)

			setText = var_3_11

			local var_3_12 = arg_3_0.underwayTr

			var_3_11(var_11.Find(var_3_12, "label"), arg_3_0.underwayLabelStr .. "(" .. var_3_6 .. "/" .. var_3_7 .. ")")
		else
			setText = var_3_11

			local var_3_13 = arg_3_0.underwayTr

			var_3_11(var_11.Find(var_3_13, "label"), arg_3_0.underwayLabelStr)

			if var_3_8 then
				var_3_11 = arg_3_0.sProgressTxt
				var_3_11.enabled = false
				setText = var_3_11

				local var_3_14 = arg_3_0.staticTr
				local var_3_15 = var_11.Find(var_3_14, "label")

				i18n = var_3_14

				var_3_11(var_3_15, var_3_14("meta_pt_point"))

				setText = var_3_11

				local var_3_16 = arg_3_0.sLabel

				i18n = var_12

				var_3_11(var_3_16, var_12("meta_syn_finish"))

				setText = var_3_11

				var_3_11(arg_3_0.sSynValue, "(" .. var_3_6 .. "/" .. var_3_7 .. ")")

				var_3_11 = arg_3_0.sLabel
				Vector3 = var_11
				var_3_11.localPosition = var_11(arg_3_0.sLabel.localPosition.x, arg_3_0.sLabelLpos.y + 20, 0)
				setFillAmount = var_3_11

				var_3_11(arg_3_0.sProgress, var_3_6 / var_3_7)
			else
				var_3_11 = arg_3_0.sProgressTxt
				var_3_11.enabled = true
				setText = var_3_11

				local var_3_17 = arg_3_0.staticTr

				var_3_11(var_11.Find(var_3_17, "label"), "")

				setText = var_3_11

				var_3_11(arg_3_0.sSynValue, "")

				setText = var_3_11

				local var_3_18 = arg_3_0.sLabel

				i18n = var_12

				var_3_11(var_3_18, var_12("meta_syn_rate"))

				math = var_3_11
				var_3_11 = var_3_11.min(1, var_3_6 / var_3_0.unlockPTNum)
				setFillAmount = var_11

				var_11(arg_3_0.sProgress, var_3_11)

				local var_3_19 = arg_3_0.sProgressTxt

				string = var_12
				var_3_19.text = var_12.format("%0.1f", var_3_11 * 100) .. "%"
			end
		end

		ShipGroup = var_3_11

		local var_3_20 = var_3_11.getDefaultShipConfig(var_3_0.id)
		local var_3_21 = arg_3_0.nameTxt

		var_3_21.text = var_3_20.name
		setActive = var_3_21

		var_3_21(arg_3_0.tip, var_4:CanGetAward())

		return
	end
end

function var_0_0.Select(arg_4_0)
	arg_4_0:UnSelect()

	setActive = var_1

	var_1(arg_4_0.arrTr, true)

	LeanTween = var_1

	local var_4_0 = var_1.value(arg_4_0.arrTr.gameObject, arg_4_0.arrLpos.x, arg_4_0.arrLpos.x - 20, 0.9)
	local var_4_1 = var_1.setOnUpdate

	System = var_3

	local var_4_2 = var_4_1(var_4_0, var_3.Action_float(function(arg_5_0)
		local var_5_0 = arg_4_0.arrTr

		Vector3 = var_2_10002
		var_5_0.localPosition = var_2_10002(arg_5_0, arg_4_0.arrLpos.y, 0)

		return
	end))

	var_1.setLoopPingPong(var_4_2)

	return
end

function var_0_0.UnSelect(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0.arrTr, false)

	LeanTween = var_1_10001

	var_1_10001.cancel(arg_6_0.arrTr.gameObject)

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:UnSelect()

	return
end

return var_0_0
