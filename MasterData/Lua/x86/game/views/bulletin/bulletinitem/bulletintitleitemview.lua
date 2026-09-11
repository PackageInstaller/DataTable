local BulletinTitleItemView = class("BulletinTitleItemView", ReduxView)

function BulletinTitleItemView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:SetViewProp("bulletinID", arg_1_2)
	self:SetViewProp("contentIndex", arg_1_3)
	self:InitUI()
	self:AddListeners()
	self:RefreshUI()
end

function BulletinTitleItemView:Dispose()
	if self.time_ then
		self.timt_:Stop()

		self.time_ = nil
	end

	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil

	BulletinTitleItemView.super.Dispose(self)
end

function BulletinTitleItemView:InitUI()
	self.titleText_ = self:FindCom(typeof(Text), "titleText")
	self.timeText_ = self:FindCom(typeof(Text), "time/text")
	self.blueImg_ = self:FindCom(typeof(RectTransform), "blueImg")
	self.titleTrs_ = self:FindCom(typeof(RectTransform), "titleText")
end

function BulletinTitleItemView:AddListeners()
	return
end

function BulletinTitleItemView:RemoveListeners()
	return
end

function BulletinTitleItemView:RefreshUI()
	self.titleText_.text = GetI18NText(self:GetContent(self:GetViewProp("bulletinID"), self:GetViewProp("contentIndex")).text)
	self.timeText_.text = TimeMgr.GetInstance():STimeDescS(self:GetTimestamp(self:GetViewProp("bulletinID")), "!%Y/%m/%d")
	self.time_ = Timer.New(function()
		self.blueImg_.sizeDelta = Vector2(self.titleTrs_.rect.width + 10, self.blueImg_.sizeDelta.y)
		self.time_ = nil
	end, 0.05, 1)

	self.time_:Start()
	SetActive(self.gameObject_, true)
end

function BulletinTitleItemView:GetTimestamp(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_8_1.id == arg_8_1 then
			local var_8_0 = TimeMgr.GetInstance():GetServerTime()

			return iter_8_1.startTime
		end
	end
end

function BulletinTitleItemView:GetContent(arg_9_1, arg_9_2)
	local var_9_0 = SettingData:GetCurrentLanguage()

	for iter_9_0, iter_9_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_9_1.id == arg_9_1 then
			if var_9_0 and iter_9_1.i18n_info_content[var_9_0] then
				return iter_9_1.i18n_info_content[var_9_0][arg_9_2]
			else
				return iter_9_1.content[arg_9_2]
			end
		end
	end
end

return BulletinTitleItemView
