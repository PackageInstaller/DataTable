local ArchivesWorldBossCard = class("ArchivesWorldBossCard")

function ArchivesWorldBossCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.icon = self._tf:Find("icon"):GetComponent(typeof(Image))
	self.underwayTr = self._tf:Find("underway")
	self.staticTr = self._tf:Find("static")
	self.finishTr = self._tf:Find("finish")
	self.nameTxt = self._tf:Find("name"):GetComponent(typeof(Text))
	self.staticMaskTr = self._tf:Find("static_mask")
	self.uProgress = self.underwayTr:Find("progress/bar")
	self.uProgressTxt = self.underwayTr:Find("Text"):GetComponent(typeof(Text))
	self.sProgress = self.staticTr:Find("progress/bar")
	self.sProgressTxt = self.staticTr:Find("Text"):GetComponent(typeof(Text))
	self.fProgress = self.staticTr:Find("progress/bar")
	self.arrTr = self._tf:Find("arr")
	self.arrLpos = self.arrTr.localPosition
	self.sLabel = self.staticTr:Find("Text/label")
	self.sSynValue = self.staticTr:Find("Text1")
	self.sLabelLpos = self.sLabel.localPosition
	self.underwayLabelStr = i18n("meta_pt_point")

	setText(self.underwayTr:Find("label"), self.underwayLabelStr)
	setText(self.sLabel, i18n("meta_syn_rate"))

	self.tip = self._tf:Find("tip")

	setActive(self.arrTr, false)

	return
end

function ArchivesWorldBossCard:Update(arg_2_1)
	self.data = arg_2_1
	self.bossId = arg_2_1.id
	self.metaProgressVO = arg_2_1.progress

	self:Flush()

	return
end

function ArchivesWorldBossCard:Flush()
	local var_3_0 = self.bossId == WorldBossConst.GetArchivesId() and WorldBossConst.GetAchieveState() ~= WorldBossConst.ACHIEVE_STATE_NOSTART
	local var_3_1 = self.metaProgressVO.metaPtData
	local var_3_2 = not self.metaProgressVO.metaPtData:CanGetNextAward()

	setActive(self.underwayTr, var_3_0 and not var_3_2)
	setActive(self.staticTr, not var_3_0 and not var_3_2)
	setActive(self.staticMaskTr, not var_3_0 and not var_3_2)
	setActive(self.finishTr, var_3_2)

	local var_3_3 = var_3_1:GetResProgress()
	local var_3_4 = var_3_1:GetTotalResRequire()
	local var_3_5 = self.metaProgressVO.metaPtData.level + 1 > self.metaProgressVO.unlockPTLevel

	self.icon.sprite = GetSpriteFromAtlas("MetaWorldboss/" .. self.metaProgressVO.id, "archives")
	self.sLabel.localPosition = Vector3(self.sLabel.localPosition.x, self.sLabelLpos.y, 0)

	if var_3_2 then
		setFillAmount(self.fProgress, 1)
	elseif var_3_0 then
		setFillAmount(self.uProgress, var_3_3 / var_3_4)
		setText(self.underwayTr:Find("label"), self.underwayLabelStr .. "(" .. var_3_3 .. "/" .. var_3_4 .. ")")
	else
		setText(self.underwayTr:Find("label"), self.underwayLabelStr)

		if var_3_5 then
			self.sProgressTxt.enabled = false

			setText(self.staticTr:Find("label"), i18n("meta_pt_point"))
			setText(self.sLabel, i18n("meta_syn_finish"))
			setText(self.sSynValue, "(" .. var_3_3 .. "/" .. var_3_4 .. ")")

			self.sLabel.localPosition = Vector3(self.sLabel.localPosition.x, self.sLabelLpos.y + 20, 0)

			setFillAmount(self.sProgress, var_3_3 / var_3_4)
		else
			self.sProgressTxt.enabled = true

			setText(self.staticTr:Find("label"), "")
			setText(self.sSynValue, "")
			setText(self.sLabel, i18n("meta_syn_rate"))

			local var_3_6 = math.min(1, var_3_3 / self.metaProgressVO.unlockPTNum)

			setFillAmount(self.sProgress, var_3_6)

			self.sProgressTxt.text = string.format("%0.1f", var_3_6 * 100) .. "%"
		end
	end

	self.nameTxt.text = ShipGroup.getDefaultShipConfig(self.metaProgressVO.id).name

	setActive(self.tip, var_3_1:CanGetAward())

	return
end

function ArchivesWorldBossCard:Select()
	self:UnSelect()
	setActive(self.arrTr, true)
	LeanTween.value(self.arrTr.gameObject, self.arrLpos.x, self.arrLpos.x - 20, 0.9):setOnUpdate(System.Action_float(function(arg_5_0)
		self.arrTr.localPosition = Vector3(arg_5_0, self.arrLpos.y, 0)

		return
	end)):setLoopPingPong()

	return
end

function ArchivesWorldBossCard:UnSelect()
	setActive(self.arrTr, false)
	LeanTween.cancel(self.arrTr.gameObject)

	return
end

function ArchivesWorldBossCard:Dispose()
	self:UnSelect()

	return
end

return ArchivesWorldBossCard
