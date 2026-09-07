local BaseActivityPage = class("BaseActivityPage", import(".BaseSubView"))

function BaseActivityPage:SetShareData(arg_1_1)
	self.shareData = arg_1_1

	return
end

function BaseActivityPage:SetUIName(arg_2_1)
	self._uiName = arg_2_1

	return
end

function BaseActivityPage:getUIName()
	return self._uiName
end

function BaseActivityPage:Flush(arg_4_1)
	self.activity = arg_4_1

	if self:OnDataSetting() then
		return
	end

	if defaultValue(self.isFirst, true) then
		self.isFirst = false

		self:BindPageLink()
		self:OnFirstFlush()
	end

	self:OnUpdateFlush()

	return
end

function BaseActivityPage:ShowOrHide(arg_5_1)
	SetActive(self._go, arg_5_1)

	if arg_5_1 then
		local var_5_0 = {}

		self:emit(ActivityMainScene.GET_PAGE_BGM, self.__cname, var_5_0)

		if var_5_0.bgm then
			pg.BgmMgr.GetInstance():Push(ActivityMainScene.__cname, var_5_0.bgm)
		end

		self:OnShowFlush()
	else
		self:OnHideFlush()
	end

	return
end

function BaseActivityPage:BindPageLink()
	for iter_6_0, iter_6_1 in ipairs(self:GetPageLink()) do
		ActivityConst.PageIdLink[iter_6_1] = self.activity.id
	end

	return
end

function BaseActivityPage:SwitchOut(arg_7_1)
	arg_7_1()

	return
end

function BaseActivityPage:OnInit()
	return
end

function BaseActivityPage:OnDataSetting()
	return
end

function BaseActivityPage:GetPageLink()
	return {}
end

function BaseActivityPage:OnFirstFlush()
	return
end

function BaseActivityPage:OnUpdateFlush()
	return
end

function BaseActivityPage:OnHideFlush()
	return
end

function BaseActivityPage:OnShowFlush()
	return
end

function BaseActivityPage:OnDestroy()
	return
end

function BaseActivityPage:UseSecondPage(arg_16_1)
	return false
end

return BaseActivityPage
