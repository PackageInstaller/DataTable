local SpringPreheatLetterTextItem = class("SpringPreheatLetterTextItem", ReduxView)

function SpringPreheatLetterTextItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.richText_ = self:FindCom("RichText", "", arg_1_1.transform)

	self:BindCfgUI()
	self:AddUIListener()
end

function SpringPreheatLetterTextItem:AddUIListener()
	self.richText_:AddListener(function(arg_3_0, arg_3_1)
		if arg_3_0 == "1" then
			self:SelectLetter(self.paragIdx_, (tonumber(arg_3_1)))
		end
	end)

	if self.btn_ then
		local var_2_0 = self.richText_.gameObject:GetComponent("RectTransform")

		self:GetOrAddComponent(self.richText_.gameObject, typeof(EventTriggerListener)):AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, LuaHelper.EventTriggerAction1(function(arg_4_0, arg_4_1)
			self:SelectLetter(self.paragIdx_, (self:FindNearestUnderlineIndex(LuaHelper.ScreenToLocal(var_2_0, arg_4_1.position, arg_4_1.enterEventCamera).x)))
		end))
	end
end

function SpringPreheatLetterTextItem:Dispose()
	self.richText_:RemoveAllListeners()
	SpringPreheatLetterTextItem.super.Dispose(self)
end

function SpringPreheatLetterTextItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.isSelecting_ = arg_6_4

	self.richText_:AddSprite("selecting", arg_6_2)
	self.richText_:AddSprite("selected", arg_6_3)

	if self.paragIdx_ ~= arg_6_1 then
		self.paragIdx_ = arg_6_1

		self:InitLetterInfo()
	end

	self:UpdateRichText()
end

function SpringPreheatLetterTextItem:SetPreviewMode(arg_7_1)
	self.previewMode_ = arg_7_1
end

function SpringPreheatLetterTextItem:SetSendingMode(arg_8_1)
	self.sendingMode_ = arg_8_1
end

function SpringPreheatLetterTextItem:RefreshUI()
	self:UpdateRichText()
end

function SpringPreheatLetterTextItem:UpdateRichText()
	local var_10_0 = SpringPreheatData:GetPlayerLetter()
	local var_10_3 = ""
	local var_10_4 = GetTips("SPRING_PREHEAT_WORD_BRACKET")
	local var_10_5 = GameDisplayCfg.spring_preheat_select_color.value[1]
	local var_10_6 = 1

	for iter_10_0 = 1, #self.letterInfo_ do
		local var_10_7 = self.letterInfo_[iter_10_0]

		if SpringPreheatData:IsEnableOption(var_10_0.id, self.paragIdx_, iter_10_0) then
			local var_10_8 = var_10_7 ~= 0 and GetTips(var_10_7) or self.previewMode_ and "______" or "______"
			local var_10_9 = var_10_7 == 0 and var_10_5 or nil

			var_10_3 = self.sendingMode_ and var_10_3 .. var_10_8 or var_10_9 and var_10_3 .. string.format(string.format("<color=%s>%s</color>", var_10_9, var_10_4), (string.format("<material=underline c=%s h=-1.5 event=1 args=%d>%s</material>", var_10_9, var_10_6, var_10_8))) or var_10_3 .. string.format(var_10_4, (string.format("<material=underline h=1.5 event=1 args=%d>%s</material>", var_10_6, var_10_8)))
			var_10_6 = var_10_6 + 1
		else
			var_10_3 = var_10_3 .. GetTips(var_10_7)
		end
	end

	self.richText_.text = var_10_3
	self.underlineCount_ = var_10_6 - 1

	self:CalcUnderlineData()
end

function SpringPreheatLetterTextItem:InitLetterInfo()
	local var_11_0 = SpringPreheatData:GetPlayerLetter()

	self.letterInfo_ = {}
	self.richTextList_ = {}
	self.hasOption_ = false

	for iter_11_0 = 1, #var_11_0.option_button_list[self.paragIdx_] do
		if SpringPreheatData:IsEnableOption(var_11_0.id, self.paragIdx_, iter_11_0) then
			self.letterInfo_[iter_11_0] = 0
			self.hasOption_ = true
		else
			self.letterInfo_[iter_11_0] = SpringPreheatData:GetLetterFixedText(var_11_0.id, self.paragIdx_, iter_11_0)
		end
	end
end

function SpringPreheatLetterTextItem:SetLetterInfo(arg_12_1)
	local var_12_0 = SpringPreheatData:GetPlayerLetter()

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if SpringPreheatData:IsEnableOption(var_12_0.id, self.paragIdx_, iter_12_0) then
			self.letterInfo_[iter_12_0] = iter_12_1
		end
	end
end

function SpringPreheatLetterTextItem:SelectLetter(arg_13_1, arg_13_2)
	if not self.hasOption_ or self.sendingMode_ then
		return
	end

	local var_13_0 = {
		isStickerMode = false,
		paragIdx = arg_13_1,
		optionIdx = arg_13_2,
		letterInfo = self:GetLetterInfo()
	}

	if not self.previewMode_ then
		function var_13_0.onChangeFullLetter(arg_14_0)
			self:SetLetterInfo(arg_14_0)
			self:RefreshUI()
		end
	else
		var_13_0.updateAni = true
	end

	JumpTools.OpenPageByJump("springPreheatLetterSelect", var_13_0)
end

function SpringPreheatLetterTextItem:ResetLetterInfo()
	self:InitLetterInfo()
	self:UpdateRichText()
end

function SpringPreheatLetterTextItem:GetLetterInfo()
	return self.letterInfo_
end

function SpringPreheatLetterTextItem:IsComplete()
	for iter_17_0, iter_17_1 in ipairs(self.letterInfo_) do
		if iter_17_1 == 0 then
			return false
		end
	end

	return true
end

function SpringPreheatLetterTextItem:CalcUnderlineData()
	Timer.New(function()
		local var_19_0 = self.richText_.gameObject:GetComponentsInChildren(typeof(RectTransform))

		self.underlinePos_ = {}

		for iter_19_0 = 1, math.min(var_19_0.Length - 1, self.underlineCount_) do
			table.insert(self.underlinePos_, self.richText_.transform.rect.center.x + var_19_0[iter_19_0].anchoredPosition.x)
		end
	end, 0.5, 0):Start()
end

function SpringPreheatLetterTextItem:FindNearestUnderlineIndex(arg_20_1)
	local var_20_0 = 1

	for iter_20_0, iter_20_1 in ipairs(self.underlinePos_ or {}) do
		if math.abs(iter_20_1 - arg_20_1) <= math.abs(self.underlinePos_[var_20_0] - arg_20_1) then
			var_20_0 = iter_20_0
		end
	end

	return var_20_0
end

function SpringPreheatLetterTextItem:UpdateAnim(arg_21_1, arg_21_2)
	if self.ani_ then
		self.ani_.enabled = arg_21_1

		SetActive(self.aniGo_, arg_21_1)

		if arg_21_1 then
			self.ani_:Play(arg_21_2, -1, 0)
		end
	end
end

return SpringPreheatLetterTextItem
