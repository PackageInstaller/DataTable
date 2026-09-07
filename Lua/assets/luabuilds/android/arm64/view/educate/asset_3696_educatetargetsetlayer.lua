local EducateTargetSetLayer = class("EducateTargetSetLayer", import(".base.EducateBaseUI"))

function EducateTargetSetLayer:getUIName()
	return "EducateTargetSetUI"
end

function EducateTargetSetLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateTargetSetLayer:initData()
	self:initTargetList()

	self.selectedIndex = 1

	return
end

function EducateTargetSetLayer:initTargetList()
	local var_4_0 = getProxy(EducateProxy)
	local var_4_1 = var_4_0:GetCharData()

	self.maxAttrId = var_4_1:GetAttrSortIds()[1]

	local var_4_2 = var_4_0:GetTaskProxy():GetTargetId() == 0 and 1 or var_4_1:GetStage() + 1
	local var_4_3 = var_4_0:GetPersonalityId()
	local var_4_4 = {}
	local var_4_5 = {}

	for iter_4_0, iter_4_1 in ipairs(pg.child_target_set.all) do
		if pg.child_target_set[iter_4_1].stage == var_4_2 then
			if pg.child_target_set[iter_4_1].condition == "" or #pg.child_target_set[iter_4_1].condition == 0 then
				table.insert(var_4_4, iter_4_1)
			elseif var_4_3 == pg.child_target_set[iter_4_1].condition[2][1] then
				table.insert(var_4_5, iter_4_1)
			end
		end
	end

	table.sort(var_4_5, CompareFuncs({
		function(arg_5_0)
			return -var_4_1:GetAttrById(pg.child_target_set[arg_5_0].condition[1][1])
		end,
		function(arg_6_0)
			return arg_6_0
		end
	}))

	local var_4_6 = 0

	self.targetList = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_5) do
		table.insert(self.targetList, iter_4_3)

		var_4_6 = var_4_6 + 1

		if var_4_6 == 4 then
			break
		end
	end

	if var_4_6 < 4 then
		for iter_4_4, iter_4_5 in ipairs(var_4_4) do
			table.insert(self.targetList, iter_4_5)

			var_4_6 = var_4_6 + 1

			if var_4_6 == 4 then
				break
			end
		end
	end

	return
end

function EducateTargetSetLayer:findUI()
	self.windowTF = self._tf:Find("anim_root/window")
	self.targetContent = self.windowTF:Find("content")
	self.targetTpl = self.targetContent:Find("tpl")

	setActive(self.targetTpl, false)

	self.sureBtn = self.windowTF:Find("sure_btn")

	setText(self.sureBtn:Find("Text"), i18n("word_ok"))

	return
end

function EducateTargetSetLayer:addListener()
	onButton(self, self.sureBtn, function()
		local var_9_0 = self.targetList[self.selectedIndex]

		self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_target_set_sure_tip", pg.child_attr[pg.child_target_set[self.targetList[self.selectedIndex]].recommend_attr2].name),
			onYes = function()
				self:emit(EducateTargetSetMediator.ON_TARGET_SET, {
					open = true,
					id = var_9_0
				})

				local var_10_0 = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

				var_10_0:SetEndEvent(function()
					var_10_0:SetEndEvent(nil)
					self:emit(EducateTargetSetLayer.ON_CLOSE)

					return
				end)
				self._tf:Find("anim_root"):GetComponent(typeof(Animation)):Play("anim_educate_targetset_out")

				return
			end
		})

		return
	end, SFX_PANEL)

	return
end

function EducateTargetSetLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:initTarget()

	return
end

function EducateTargetSetLayer:initTarget()
	for iter_13_0 = 1, #self.targetList do
		local var_13_0 = cloneTplTo(self.targetTpl, self.targetContent, tostring(iter_13_0))
		local var_13_1 = self.targetList[iter_13_0]

		setImageSprite(var_13_0:Find("animroot/icon/Image"), LoadSprite("educatetarget/" .. pg.child_target_set[self.targetList[iter_13_0]].icon), true)
		setImageSprite(var_13_0:Find("animroot/name"), LoadSprite("educatetarget/" .. pg.child_target_set[var_13_1].pic), true)
		onButton(self, var_13_0, function()
			if self.selectedIndex == iter_13_0 then
				return
			end

			self.selectedIndex = iter_13_0

			self:updateTarget()

			return
		end, SFX_PANEL)
		setActive(var_13_0:Find("animroot/recommand"), pg.child_target_set[var_13_1].recommend_attr == self.maxAttrId)
	end

	self:updateTarget()

	local var_13_2 = {}

	table.insert(var_13_2, function(arg_15_0)
		onDelayTick(function()
			arg_15_0()

			return
		end, 0.066)

		return
	end)

	for iter_13_1 = 1, #self.targetList do
		table.insert(var_13_2, function(arg_17_0)
			self.targetContent:Find(tostring(iter_13_1)):GetComponent(typeof(Animation)):Play("anim_educate_targetset_tpl_in")
			onDelayTick(function()
				arg_17_0()

				return
			end, 0.066)

			return
		end)
	end

	seriesAsync(var_13_2, function()
		return
	end)

	return
end

function EducateTargetSetLayer:updateTarget()
	eachChild(self.targetContent, function(arg_21_0)
		setActive(arg_21_0:Find("animroot/selected"), self.selectedIndex == tonumber(arg_21_0.name))

		return
	end)

	return
end

function EducateTargetSetLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function EducateTargetSetLayer:onBackPressed()
	return
end

return EducateTargetSetLayer
