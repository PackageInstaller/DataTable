local RefluxPTView = class("RefluxPTView", import("..base.BaseSubView"))

function RefluxPTView:getUIName()
	return "RefluxPTUI"
end

function RefluxPTView:OnInit()
	self:initData()
	self:initUI()
	self:updateUI()

	return
end

function RefluxPTView:OnDestroy()
	return
end

function RefluxPTView:OnBackPress()
	self:Hide()

	return
end

function RefluxPTView:initData()
	self.refluxProxy = getProxy(RefluxProxy)

	return
end

function RefluxPTView:initUI()
	self.nextBtn = self._tf:Find("NextBtn")
	self.countText = self._tf:Find("PTCount")

	local var_6_0 = self.countText:GetComponent(typeof(Text))

	var_6_0.material = Object.Instantiate(var_6_0.material)
	self.faceSpriteList = {}

	local var_6_1 = self._tf:Find("Face")

	for iter_6_0 = 0, var_6_1.childCount - 1 do
		table.insert(self.faceSpriteList, (getImageSprite((var_6_1:GetChild(iter_6_0)))))
	end

	self.scrollViewTF = self._tf:Find("ScrollRect")
	self.viewportTF = self.scrollViewTF
	self.tpl = self._tf:Find("StepTpl")
	self.tplContainerTF = self._tf:Find("ScrollRect/Container")
	self.stepUIIList = UIItemList.New(self.tplContainerTF, self.tpl)

	self.stepUIIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			self:updateTpl(arg_7_2, arg_7_1)
		end

		return
	end)

	return
end

function RefluxPTView:updateData()
	return
end

function RefluxPTView:updateUI()
	self:updateTplList()
	self:ScrollPt(self.refluxProxy.ptStage - 1)
	setText(self.countText, self.refluxProxy.ptNum)

	return
end

function RefluxPTView:updateOutline()
	local var_10_0 = self.countText:GetComponent(typeof(Text))

	var_10_0.material = Object.Instantiate(var_10_0.material)

	return
end

function RefluxPTView:updateTpl(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("item")
	local var_11_1 = arg_11_1:Find("checked")
	local var_11_2 = arg_11_1:Find("face")
	local var_11_3 = arg_11_1:Find("progress")
	local var_11_4 = var_11_3:Find("text")
	local var_11_5 = var_11_3:Find("Fill Area")
	local var_11_6 = arg_11_1:Find("achieve")
	local var_11_7 = self.refluxProxy.ptNum
	local var_11_8 = pg.return_pt_template[arg_11_2].pt_require
	local var_11_9 = self.refluxProxy.ptStage + 1

	updateDrop(var_11_0:Find("award"), self:getAwardForShow(arg_11_2), {
		Q = true
	})
	setText(var_11_0:Find("text_unlock"), i18n("reflux_word_2"))
	setText(var_11_0:Find("text_pt"), var_11_8 .. "PT")
	setActive(var_11_1, arg_11_2 < var_11_9)

	local var_11_11

	if arg_11_2 < var_11_9 then
		var_11_11 = Color.gray or Color.white
	end

	for iter_11_0, iter_11_1 in ipairs((arg_11_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_11_1.color = var_11_11
	end

	setImageColor(var_11_0, var_11_11)

	local var_11_12, var_11_13 = self:getPTMinAndMax(arg_11_2)

	var_11_3.sizeDelta = Vector2(125, 20)

	setSlider(var_11_3, var_11_12, var_11_13, var_11_7)
	setActive(var_11_5, var_11_12 < var_11_7)
	setText(var_11_4, var_11_8 .. "PT")

	local var_11_14 = arg_11_2 == var_11_9 and var_11_8 <= var_11_7

	setActive(var_11_6, arg_11_2 == var_11_9 and var_11_8 <= var_11_7)

	if var_11_14 then
		onButton(self, arg_11_1, function()
			self:onStepClick(arg_11_2)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_11_1)
	end

	setImageSprite(var_11_2, self.faceSpriteList[(arg_11_2 - 1) % 10 + 1])

	return
end

function RefluxPTView:updateTplList()
	self.stepUIIList:align(#pg.return_pt_template.all)

	return
end

function RefluxPTView:updateAfterServer()
	if self.refluxProxy.ptStage + 1 <= #pg.return_pt_template.all and self.refluxProxy.ptStage + 1 >= 1 then
		self:updateTpl(self.tplContainerTF:GetChild(self.refluxProxy.ptStage + 1 - 1), self.refluxProxy.ptStage + 1)
	end

	if self.refluxProxy.ptStage + 1 - 1 <= #pg.return_pt_template.all and self.refluxProxy.ptStage + 1 - 1 >= 1 then
		self:updateTpl(self.tplContainerTF:GetChild(self.refluxProxy.ptStage + 1 - 1 - 1), self.refluxProxy.ptStage + 1 - 1)
	end

	self:ScrollPt(self.refluxProxy.ptStage - 1)

	return
end

function RefluxPTView:ScrollPt(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = self.tplContainerTF:GetComponent(typeof(HorizontalLayoutGroup))
	local var_15_1 = self.tpl:GetComponent(typeof(LayoutElement))

	self.scrollViewTF:GetComponent(typeof(ScrollRect)).horizontalNormalizedPosition = math.clamp(math.max(arg_15_1 * (var_15_1.preferredWidth + var_15_0.spacing) - self.viewportTF.rect.width * 0.5 + var_15_1.preferredWidth, 0) / (self.tplContainerTF.childCount * var_15_1.preferredWidth + (self.tplContainerTF.childCount - 1) * var_15_0.spacing - self.viewportTF.rect.width), 0, 1)

	return
end

function RefluxPTView:onStepClick(arg_16_1)
	local function var_16_0()
		pg.m02:sendNotification(GAME.REFLUX_GET_PT_AWARD)

		return
	end

	local var_16_1 = self:getAwardForShow(arg_16_1)

	var_16_1[1] = var_16_1.type
	var_16_1[2] = var_16_1.id
	var_16_1[3] = var_16_1.count

	local var_16_2, var_16_3 = Task.StaticJudgeOverflow(false, false, false, true, true, {
		var_16_1
	})

	if var_16_2 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("award_max_warning"),
			items = var_16_3,
			onYes = var_16_0
		})
	else
		var_16_0()
	end

	return
end

function RefluxPTView:getAwardForShow(arg_18_1)
	local var_18_0

	for iter_18_0, iter_18_1 in ipairs(pg.return_pt_template[arg_18_1].level) do
		if iter_18_1[1] <= self.refluxProxy.returnLV and self.refluxProxy.returnLV <= iter_18_1[2] then
			var_18_0 = iter_18_0
		end
	end

	return {
		type = pg.return_pt_template[arg_18_1].award_display[var_18_0][1],
		id = pg.return_pt_template[arg_18_1].award_display[var_18_0][2],
		count = pg.return_pt_template[arg_18_1].award_display[var_18_0][3]
	}
end

function RefluxPTView:getPTMinAndMax(arg_19_1)
	return pg.return_pt_template[arg_19_1 - 1] and pg.return_pt_template[arg_19_1 - 1].pt_require or 0, nil
end

function RefluxPTView.isAnyPTCanGetAward()
	local var_20_0 = getProxy(RefluxProxy)

	if var_20_0.ptStage + 1 <= #pg.return_pt_template.all then
		return pg.return_pt_template[var_20_0.ptStage + 1].pt_require <= var_20_0.ptNum
	else
		return false
	end

	return
end

return RefluxPTView
