local SummerRaceIllustratedView = class("SummerRaceIllustratedView", ReduxView)
local var_0_1 = {
	"ATK",
	"ROF",
	"Skill",
	"HP",
	"Cost"
}

local function var_0_3(arg_1_0)
	if arg_1_0 == nil then
		return
	end

	if arg_1_0.filterType ~= nil then
		SummerRaceData:SetIllustratedFilter(arg_1_0.filterType, true)
	end
end

local function var_0_4(arg_2_0)
	if arg_2_0.outGameUpdateHandler_ then
		manager.notify:RemoveListener(SummerRaceData.GetEventOutGameUpdated(), arg_2_0.outGameUpdateHandler_)

		arg_2_0.outGameUpdateHandler_ = nil
	end
end

local function var_0_5(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0 or {}) do
		iter_3_1:Dispose()
	end
end

local function var_0_6(arg_4_0)
	if arg_4_0.windowBarBackHandler_ ~= nil and manager.windowBar:GetLastBackFunc() == arg_4_0.windowBarBackHandler_ then
		manager.windowBar:HideBar()
	end
end

local function var_0_7(arg_5_0)
	arg_5_0.windowBarBackHandler_ = arg_5_0.windowBarBackHandler_ or function()
		JumpTools.Back()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(arg_5_0.windowBarBackHandler_)
end

local function var_0_8(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0 == nil or arg_7_0.go == nil then
		return
	end

	local var_7_0 = arg_7_1 ~= nil and arg_7_1 ~= ""

	SetActive(arg_7_0.go, arg_7_1 ~= nil and arg_7_1 ~= "")

	if not var_7_0 then
		return
	end

	arg_7_0.controller:SetSelectedState(arg_7_1)

	if arg_7_0.valueText ~= nil then
		arg_7_0.valueText.text = tostring(arg_7_2 or "")
	end

	if arg_7_0.fillImage ~= nil then
		local var_7_1 = tonumber(arg_7_0.currentValue) or 0
		local var_7_2 = tonumber(arg_7_0.maxValue) or 0

		if var_7_2 <= 0 then
			error("[SummerRaceIllustratedView] invalid property max value for `" .. tostring(arg_7_1) .. "`")
		end

		arg_7_0.fillImage.fillAmount = Mathf.Clamp01(var_7_1 / var_7_2)
	end
end

local function var_0_9(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0 = 1, #(arg_8_2 or {}) do
		var_8_0[arg_8_2[iter_8_0].slotKey or arg_8_2[iter_8_0].state] = arg_8_2[iter_8_0]
	end

	for iter_8_1 = 1, #arg_8_1 do
		if var_8_0[arg_8_1[iter_8_1]] ~= nil then
			if arg_8_0[arg_8_1[iter_8_1]] ~= nil then
				arg_8_0[arg_8_1[iter_8_1]].currentValue = var_8_0[arg_8_1[iter_8_1]].currentValue
				arg_8_0[arg_8_1[iter_8_1]].maxValue = var_8_0[arg_8_1[iter_8_1]].maxValue
			end

			var_0_8(arg_8_0[arg_8_1[iter_8_1]], var_8_0[arg_8_1[iter_8_1]].state, var_8_0[arg_8_1[iter_8_1]].value)
		else
			local var_8_2 = arg_8_0[arg_8_1[iter_8_1]]

			if arg_8_0[arg_8_1[iter_8_1]] ~= nil then
				var_8_2.currentValue = 0
				var_8_2.maxValue = 1
			end

			var_0_8(arg_8_0[arg_8_1[iter_8_1]], nil, nil)
		end
	end
end

function SummerRaceIllustratedView:UIName()
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_IllustratedUI"
end

function SummerRaceIllustratedView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerRaceIllustratedView:Init()
	self:BindCfgUI()
	self:BindViewRuntime()
end

function SummerRaceIllustratedView:BindViewRuntime()
	self.typeController_ = self.controllerEx_:GetController("type")
	self.lockController_ = self.controllerEx_:GetController("lock")

	SetActive(self.bodyItemTemplateGo_, false)
	SetActive(self.weaponItemTemplateGo_, false)
	SetActive(self.equipItemTemplateGo_, false)

	self.detailPropertyMap_ = {
		ATK = {
			go = self.propertyAtkGo_,
			controller = self.propertyAtkControllerEx_:GetController("type"),
			valueText = self.propertyAtkValueText_,
			fillImage = self.propertyAtkFillImage_
		},
		ROF = {
			go = self.propertyRofGo_,
			controller = self.propertyRofControllerEx_:GetController("type"),
			valueText = self.propertyRofValueText_,
			fillImage = self.propertyRofFillImage_
		},
		Skill = {
			go = self.propertySkillGo_,
			controller = self.propertySkillControllerEx_:GetController("type"),
			valueText = self.propertySkillValueText_,
			fillImage = self.propertySkillFillImage_
		},
		HP = {
			go = self.propertyHpGo_,
			controller = self.propertyHpControllerEx_:GetController("type"),
			valueText = self.propertyHpValueText_,
			fillImage = self.propertyHpFillImage_
		},
		Cost = {
			go = self.propertyCostGo_,
			controller = self.propertyCostControllerEx_:GetController("type"),
			valueText = self.propertyCostValueText_,
			fillImage = self.propertyCostFillImage_
		}
	}
	self.lockPropertyMap_ = {
		slot1 = {
			go = self.lockProperty1Go_,
			controller = self.lockProperty1ControllerEx_:GetController("type"),
			valueText = self.lockProperty1ValueText_,
			fillImage = self.lockProperty1FillImage_
		},
		slot2 = {
			go = self.lockProperty2Go_,
			controller = self.lockProperty2ControllerEx_:GetController("type"),
			valueText = self.lockProperty2ValueText_,
			fillImage = self.lockProperty2FillImage_
		}
	}

	for iter_12_0, iter_12_1 in pairs(self.detailPropertyMap_) do
		-- block empty
	end

	for iter_12_2, iter_12_3 in pairs(self.lockPropertyMap_) do
		-- block empty
	end

	self.bodyItemList_ = {}
	self.weaponItemList_ = {}
	self.equipItemList_ = {}
	self.bodyItemViews_ = {}
	self.weaponItemViews_ = {}
	self.equipItemViews_ = {}
end

function SummerRaceIllustratedView:OnEnter()
	var_0_3(self.params_)
	self:UpdateBar()

	self.outGameUpdateHandler_ = handler(self, self.RefreshView)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), self.outGameUpdateHandler_)
	self:RefreshView()
end

function SummerRaceIllustratedView:OnTop()
	self:UpdateBar()
end

function SummerRaceIllustratedView:OnEnterOver()
	self:UpdateBar()
end

function SummerRaceIllustratedView:UpdateBar()
	var_0_7(self)
end

function SummerRaceIllustratedView:OnBehind()
	return
end

function SummerRaceIllustratedView:OnExit()
	var_0_4(self)
	var_0_6(self)
end

function SummerRaceIllustratedView:SyncItemViews_(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = #(arg_19_4 or {})

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		SetActive(iter_19_1.gameObject_, iter_19_0 <= var_19_0)
	end

	for iter_19_2 = 1, var_19_0 do
		local var_19_1 = arg_19_1[iter_19_2]

		if arg_19_1[iter_19_2] == nil then
			local var_19_2 = Object.Instantiate(arg_19_3, arg_19_2)

			SetActive(var_19_2, true)

			var_19_1 = SummerRaceIllustratedItemView.New(var_19_2)
			arg_19_1[iter_19_2] = var_19_1
		end

		var_19_1:SetData(arg_19_4[iter_19_2], iter_19_2, handler(self, self.OnIllustratedItemAction))
	end
end

function SummerRaceIllustratedView:OnIllustratedItemAction(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_3 == "select" and arg_20_2 ~= nil then
		SummerRaceAction.SelectIllustratedItem(arg_20_2.itemId)
	end
end

function SummerRaceIllustratedView:RefreshDetail(arg_21_1)
	local var_21_0 = arg_21_1 or {}

	if self.typeController_ ~= nil then
		self.typeController_:SetSelectedState(tostring(var_21_0.typeState or "carbody"))
	end

	if self.lockController_ ~= nil then
		self.lockController_:SetSelectedState(tostring(var_21_0.lockState or "off"))
	end

	self.detailNameText_.text = tostring(var_21_0.name or "")
	self.detailCostText_.text = tostring(var_21_0.cost or "")
	self.detailDescText_.text = tostring(var_21_0.desc or "")

	local var_21_3 = tostring(var_21_0.imageState or "item")
	local var_21_4 = tostring(var_21_0.itemImagePath or "")
	local var_21_5 = tostring(var_21_0.carImagePath or "")

	SetActive(self.itemImage_.gameObject, var_21_3 ~= "car")
	SetActive(self.carImgae_.gameObject, var_21_3 == "car")

	self.itemImage_.spriteSync = var_21_4 ~= "" and var_21_4 or nil
	self.carImgae_.spriteSync = var_21_5 ~= "" and var_21_5 or nil

	var_0_9(self.detailPropertyMap_, var_0_1, var_21_0.propertyList or {})
end

function SummerRaceIllustratedView:RefreshView()
	local var_22_0 = SummerRaceData:GetIllustratedPageModel()

	self.bodyItemList_ = var_22_0.bodyList or {}
	self.weaponItemList_ = var_22_0.weaponList or {}
	self.equipItemList_ = var_22_0.equipList or {}

	self:SyncItemViews_(self.bodyItemViews_, self.bodyListGo_, self.bodyItemTemplateGo_, self.bodyItemList_)
	self:SyncItemViews_(self.weaponItemViews_, self.weaponListGo_, self.weaponItemTemplateGo_, self.weaponItemList_)
	self:SyncItemViews_(self.equipItemViews_, self.equipListGo_, self.equipItemTemplateGo_, self.equipItemList_)
	self:RefreshDetail(var_22_0.detailPanel)
end

function SummerRaceIllustratedView:Dispose()
	var_0_4(self)
	var_0_6(self)
	var_0_5(self.bodyItemViews_)
	var_0_5(self.weaponItemViews_)
	var_0_5(self.equipItemViews_)

	self.bodyItemViews_ = nil
	self.weaponItemViews_ = nil
	self.equipItemViews_ = nil
	self.windowBarBackHandler_ = nil

	SummerRaceIllustratedView.super.Dispose(self)
end

return SummerRaceIllustratedView
