local DrawInfoMessageItem = class("DrawInfoMessageItem", ReduxView)

function DrawInfoMessageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.items = {}
end

function DrawInfoMessageItem:RefreshData(arg_2_1)
	SetActive(self.UpGo_, true)
	self:Show(true)

	self.labelTxt_.text = GetI18NText(arg_2_1.name)
	self.tips01.text = GetI18NText(arg_2_1.probability)
	self.tips02.text = ""

	if arg_2_1.probability2 then
		self.tips02.text = GetI18NText(arg_2_1.probability2)
	end

	if arg_2_1.s_all_hero then
		if arg_2_1.s_up_probability then
			self.infoTxt_.text = string.format(GetTips("DRAW_POOL_UP_1"), arg_2_1.s_up_probability .. "%")
		end

		self:RefreshItem(arg_2_1.s_all_hero, true, arg_2_1.s_up_hero)
	end

	if arg_2_1.a_all_hero then
		if arg_2_1.a_up_probability then
			self.infoTxt_.text = string.format(GetTips("DRAW_POOL_UP_2"), arg_2_1.a_up_probability .. "%")
		end

		if not arg_2_1.a_up_hero or #arg_2_1.a_up_hero <= 0 then
			SetActive(self.UpGo_, false)
		end

		self:RefreshItem(arg_2_1.a_all_hero, true, arg_2_1.a_up_hero)
	end

	if arg_2_1.b_hero then
		SetActive(self.UpGo_, false)
		self:RefreshItem(arg_2_1.b_hero, true)
	end

	if arg_2_1.s_all_servant then
		SetActive(self.UpGo_, false)
		self:RefreshItem(arg_2_1.s_all_servant, false, arg_2_1.s_up_servant)
	end

	if arg_2_1.a_all_servant then
		SetActive(self.UpGo_, false)
		self:RefreshItem(arg_2_1.a_all_servant, false, arg_2_1.a_up_servant)
	end

	if arg_2_1.b_servant then
		SetActive(self.UpGo_, false)
		self:RefreshItem(arg_2_1.b_servant, false)
	end
end

function DrawInfoMessageItem:RefreshItem(arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0 = 1, #arg_3_1 do
		self.items[iter_3_0] = self.items[iter_3_0] or DrawInfoCommonItem.New((Object.Instantiate(self.infoItem_, self.contentTrs_)))

		self.items[iter_3_0]:RefreshData(arg_3_1[iter_3_0], arg_3_2)
		self.items[iter_3_0]:RefreshUp(arg_3_3, arg_3_2)
	end

	for iter_3_1 = #arg_3_1 + 1, #self.items do
		self.items[iter_3_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function DrawInfoMessageItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function DrawInfoMessageItem:Dispose()
	DrawInfoMessageItem.super.Dispose(self)

	if self.items then
		for iter_5_0, iter_5_1 in ipairs(self.items) do
			iter_5_1:Dispose()
			Object.Destroy(self.items[iter_5_0].gameObject_)
		end

		self.items = nil
	end

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

return DrawInfoMessageItem
