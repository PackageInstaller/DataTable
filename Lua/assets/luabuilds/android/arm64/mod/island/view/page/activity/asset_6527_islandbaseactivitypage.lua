local IslandBaseActivityPage = class("IslandBaseActivityPage", import("view.base.BaseSubView"))

function IslandBaseActivityPage:SetShareData(arg_1_1)
	self.shareData = arg_1_1

	return
end

function IslandBaseActivityPage:SetUIName(arg_2_1)
	self._uiName = arg_2_1

	return
end

function IslandBaseActivityPage:getUIName()
	return self._uiName
end

function IslandBaseActivityPage:Flush(arg_4_1)
	self.activity = arg_4_1

	if self:OnDataSetting() then
		return
	end

	if defaultValue(self.isFirst, true) then
		self.isFirst = false

		self:OnFirstFlush()
	end

	self:OnUpdateFlush()

	return
end

function IslandBaseActivityPage:ShowOrHide(arg_5_1)
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

function IslandBaseActivityPage:SwitchOut(arg_6_1)
	arg_6_1()

	return
end

function IslandBaseActivityPage:OnInit()
	return
end

function IslandBaseActivityPage:OnDataSetting()
	return
end

function IslandBaseActivityPage:OnFirstFlush()
	return
end

function IslandBaseActivityPage:OnUpdateFlush()
	return
end

function IslandBaseActivityPage:OnHideFlush()
	return
end

function IslandBaseActivityPage:OnShowFlush()
	return
end

function IslandBaseActivityPage:OnDestroy()
	return
end

function IslandBaseActivityPage:UseSecondPage(arg_14_1)
	return false
end

return IslandBaseActivityPage
