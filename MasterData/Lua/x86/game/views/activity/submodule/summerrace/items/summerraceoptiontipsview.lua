local SummerRaceTipsPropertyItemView = import("game.views.activity.Submodule.SummerRace.Items.SummerRaceTipsPropertyItemView")
local SummerRaceOptionTipsView = class("SummerRaceOptionTipsView", ReduxView)

function SummerRaceOptionTipsView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.propertiesItemPrefab_ = arg_1_2
	self.propertyItemViews_ = {}

	self:Init()
end

function SummerRaceOptionTipsView:Init()
	self:BindCfgUI()

	for iter_2_0 = self.propertiesListGo_.transform.childCount - 1, 0, -1 do
		Object.Destroy(self.propertiesListGo_.transform:GetChild(iter_2_0).gameObject)
	end
end

function SummerRaceOptionTipsView:EnsurePropertyItemView(arg_3_1)
	if self.propertyItemViews_[arg_3_1] ~= nil then
		return self.propertyItemViews_[arg_3_1]
	end

	local var_3_0 = Object.Instantiate(self.propertiesItemPrefab_, self.propertiesListGo_.transform)

	var_3_0.name = "propertiesItem_" .. tostring(arg_3_1)
	self.propertyItemViews_[arg_3_1] = SummerRaceTipsPropertyItemView.New(var_3_0)

	return self.propertyItemViews_[arg_3_1]
end

function SummerRaceOptionTipsView:RefreshPropertyList(arg_4_1)
	arg_4_1 = arg_4_1 or {}

	for iter_4_0 = 1, #arg_4_1 do
		self:EnsurePropertyItemView(iter_4_0):SetData(arg_4_1[iter_4_0])
	end

	for iter_4_1 = #arg_4_1 + 1, #self.propertyItemViews_ do
		self:EnsurePropertyItemView(iter_4_1):SetData(nil)
	end
end

function SummerRaceOptionTipsView:SetData(arg_5_1)
	if arg_5_1 == nil then
		SetActive(self.rootGo_, false)

		return
	end

	SetActive(self.rootGo_, true)

	self.titleText_.text = tostring(arg_5_1.title or "")
	self.titleNum_.text = tostring(arg_5_1.cost or 0)
	self.descText_.text = tostring(arg_5_1.desc or "")

	self:RefreshPropertyList(arg_5_1.properties)
end

function SummerRaceOptionTipsView:Dispose()
	for iter_6_0 = 1, #(self.propertyItemViews_ or {}) do
		self.propertyItemViews_[iter_6_0]:Dispose()
	end

	self.propertyItemViews_ = nil
	self.propertiesItemPrefab_ = nil

	SummerRaceOptionTipsView.super.Dispose(self)
end

return SummerRaceOptionTipsView
