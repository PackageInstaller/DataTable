local BulletinContentView = class("BulletinContentView", ReduxView)

function BulletinContentView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.bulletinItem_ = {}

	self:InitUI()
end

function BulletinContentView:SetBulletInId(arg_2_1)
	self:SetViewProp("bulletinID", arg_2_1)
	self:RefreshContent()
end

function BulletinContentView:OnEnter()
	return
end

function BulletinContentView:OnExit()
	return
end

function BulletinContentView:Dispose()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	for iter_5_0 = #self.bulletinItem_, 1, -1 do
		self.bulletinItem_[iter_5_0]:Dispose()

		self.bulletinItem_[iter_5_0] = nil
	end

	self.bulletinItem_ = nil
	self.gameObject_ = nil
	self.transform_ = nil

	BulletinContentView.super.Dispose(self)
end

function BulletinContentView:InitUI()
	self:BindCfgUI()

	self.itemParent_ = self.gameObject_
end

function BulletinContentView:RefreshContent()
	SetActive(self.itemParent_.gameObject, false)

	for iter_7_0 = #self.bulletinItem_, 1, -1 do
		self.bulletinItem_[iter_7_0]:Dispose()

		self.bulletinItem_[iter_7_0] = nil
	end

	for iter_7_1, iter_7_2 in ipairs(self:GetContent(self:GetViewProp("bulletinID"))) do
		if iter_7_2.itemType == 1 then
			table.insert(self.bulletinItem_, BulletinImageItemView.New(Object.Instantiate(self.imageItem_, self.itemParent_.transform), self:GetViewProp("bulletinID"), iter_7_1))
		elseif iter_7_2.itemType == 2 then
			table.insert(self.bulletinItem_, BulletinTextItemView.New(Object.Instantiate(self.textItem_, self.itemParent_.transform), self:GetViewProp("bulletinID"), iter_7_1))
		elseif iter_7_2.itemType == 4 then
			table.insert(self.bulletinItem_, BulletinTitleItemView.New(Object.Instantiate(self.titleItem_, self.itemParent_.transform), self:GetViewProp("bulletinID"), iter_7_1))
		end
	end

	if self.timer_ ~= nil then
		self.timer_:Stop()
	end

	self.timer_ = TimeTools.StartAfterSeconds(0.1, function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemParent_.transform)
		SetActive(self.itemParent_.gameObject, true)
	end, {})
end

function BulletinContentView:SwitchBulletinPage(arg_9_1)
	self:SetViewProp("bulletinID", arg_9_1)
	self:RefreshContent()
end

function BulletinContentView:GetContent(arg_10_1)
	local var_10_0 = manager.time:GetServerTime()
	local var_10_1 = SettingData:GetCurrentLanguage()

	for iter_10_0, iter_10_1 in pairs(BulletinData.GetBulletinPageList()) do
		if iter_10_1.id == arg_10_1 and var_10_0 < iter_10_1.endTime then
			if var_10_1 and iter_10_1.i18n_info_content[var_10_1] then
				return iter_10_1.i18n_info_content[var_10_1]
			else
				return iter_10_1.content
			end
		end
	end

	return {}
end

return BulletinContentView
