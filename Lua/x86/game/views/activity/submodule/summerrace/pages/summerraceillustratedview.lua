local var_0_0 = class("SummerRaceIllustratedView", ReduxView)
local var_0_1 = {
	"ATK",
	"ROF",
	"Skill",
	"HP",
	"Cost"
}
local var_0_2 = {
	"slot1",
	"slot2"
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

	SetActive(arg_7_0.go, var_7_0)

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
		local var_8_1 = arg_8_2[iter_8_0]

		var_8_0[var_8_1.slotKey or var_8_1.state] = var_8_1
	end

	for iter_8_1 = 1, #arg_8_1 do
		local var_8_2 = arg_8_1[iter_8_1]
		local var_8_3 = var_8_0[var_8_2]

		if var_8_3 ~= nil then
			local var_8_4 = arg_8_0[var_8_2]

			if var_8_4 ~= nil then
				var_8_4.currentValue = var_8_3.currentValue
				var_8_4.maxValue = var_8_3.maxValue
			end

			var_0_8(arg_8_0[var_8_2], var_8_3.state, var_8_3.value)
		else
			local var_8_5 = arg_8_0[var_8_2]

			if var_8_5 ~= nil then
				var_8_5.currentValue = 0
				var_8_5.maxValue = 1
			end

			var_0_8(arg_8_0[var_8_2], nil, nil)
		end
	end
end

function var_0_0.UIName(arg_9_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_IllustratedUI"
end

function var_0_0.UIParent(arg_10_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_11_0)
	arg_11_0:BindCfgUI()
	arg_11_0:BindViewRuntime()
end

function var_0_0.BindViewRuntime(arg_12_0)
	arg_12_0.typeController_ = arg_12_0.controllerEx_:GetController("type")
	arg_12_0.lockController_ = arg_12_0.controllerEx_:GetController("lock")

	SetActive(arg_12_0.bodyItemTemplateGo_, false)
	SetActive(arg_12_0.weaponItemTemplateGo_, false)
	SetActive(arg_12_0.equipItemTemplateGo_, false)

	arg_12_0.detailPropertyMap_ = {
		ATK = {
			go = arg_12_0.propertyAtkGo_,
			controller = arg_12_0.propertyAtkControllerEx_:GetController("type"),
			valueText = arg_12_0.propertyAtkValueText_,
			fillImage = arg_12_0.propertyAtkFillImage_
		},
		ROF = {
			go = arg_12_0.propertyRofGo_,
			controller = arg_12_0.propertyRofControllerEx_:GetController("type"),
			valueText = arg_12_0.propertyRofValueText_,
			fillImage = arg_12_0.propertyRofFillImage_
		},
		Skill = {
			go = arg_12_0.propertySkillGo_,
			controller = arg_12_0.propertySkillControllerEx_:GetController("type"),
			valueText = arg_12_0.propertySkillValueText_,
			fillImage = arg_12_0.propertySkillFillImage_
		},
		HP = {
			go = arg_12_0.propertyHpGo_,
			controller = arg_12_0.propertyHpControllerEx_:GetController("type"),
			valueText = arg_12_0.propertyHpValueText_,
			fillImage = arg_12_0.propertyHpFillImage_
		},
		Cost = {
			go = arg_12_0.propertyCostGo_,
			controller = arg_12_0.propertyCostControllerEx_:GetController("type"),
			valueText = arg_12_0.propertyCostValueText_,
			fillImage = arg_12_0.propertyCostFillImage_
		}
	}
	arg_12_0.lockPropertyMap_ = {
		slot1 = {
			go = arg_12_0.lockProperty1Go_,
			controller = arg_12_0.lockProperty1ControllerEx_:GetController("type"),
			valueText = arg_12_0.lockProperty1ValueText_,
			fillImage = arg_12_0.lockProperty1FillImage_
		},
		slot2 = {
			go = arg_12_0.lockProperty2Go_,
			controller = arg_12_0.lockProperty2ControllerEx_:GetController("type"),
			valueText = arg_12_0.lockProperty2ValueText_,
			fillImage = arg_12_0.lockProperty2FillImage_
		}
	}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.detailPropertyMap_) do
		-- block empty
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.lockPropertyMap_) do
		-- block empty
	end

	arg_12_0.bodyItemList_ = {}
	arg_12_0.weaponItemList_ = {}
	arg_12_0.equipItemList_ = {}
	arg_12_0.bodyItemViews_ = {}
	arg_12_0.weaponItemViews_ = {}
	arg_12_0.equipItemViews_ = {}
end

function var_0_0.OnEnter(arg_13_0)
	var_0_3(arg_13_0.params_)
	arg_13_0:UpdateBar()

	arg_13_0.outGameUpdateHandler_ = handler(arg_13_0, arg_13_0.RefreshView)

	manager.notify:RegistListener(SummerRaceData.GetEventOutGameUpdated(), arg_13_0.outGameUpdateHandler_)
	arg_13_0:RefreshView()
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:UpdateBar()
end

function var_0_0.OnEnterOver(arg_15_0)
	arg_15_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_16_0)
	var_0_7(arg_16_0)
end

function var_0_0.OnBehind(arg_17_0)
	return
end

function var_0_0.OnExit(arg_18_0)
	var_0_4(arg_18_0)
	var_0_6(arg_18_0)
end

function var_0_0.SyncItemViews_(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = #(arg_19_4 or {})

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		SetActive(iter_19_1.gameObject_, iter_19_0 <= var_19_0)
	end

	for iter_19_2 = 1, var_19_0 do
		local var_19_1 = arg_19_1[iter_19_2]

		if var_19_1 == nil then
			local var_19_2 = Object.Instantiate(arg_19_3, arg_19_2)

			SetActive(var_19_2, true)

			var_19_1 = SummerRaceIllustratedItemView.New(var_19_2)
			arg_19_1[iter_19_2] = var_19_1
		end

		var_19_1:SetData(arg_19_4[iter_19_2], iter_19_2, handler(arg_19_0, arg_19_0.OnIllustratedItemAction))
	end
end

function var_0_0.OnIllustratedItemAction(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_3 == "select" and arg_20_2 ~= nil then
		SummerRaceAction.SelectIllustratedItem(arg_20_2.itemId)
	end
end

function var_0_0.RefreshDetail(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1 or {}

	if arg_21_0.typeController_ ~= nil then
		arg_21_0.typeController_:SetSelectedState(tostring(var_21_0.typeState or "carbody"))
	end

	if arg_21_0.lockController_ ~= nil then
		arg_21_0.lockController_:SetSelectedState(tostring(var_21_0.lockState or "off"))
	end

	arg_21_0.detailNameText_.text = tostring(var_21_0.name or "")
	arg_21_0.detailCostText_.text = tostring(var_21_0.cost or "")
	arg_21_0.detailDescText_.text = tostring(var_21_0.desc or "")

	local var_21_1 = tostring(var_21_0.imageState or "item")
	local var_21_2 = tostring(var_21_0.itemImagePath or "")
	local var_21_3 = tostring(var_21_0.carImagePath or "")

	SetActive(arg_21_0.itemImage_.gameObject, var_21_1 ~= "car")
	SetActive(arg_21_0.carImgae_.gameObject, var_21_1 == "car")

	arg_21_0.itemImage_.spriteSync = var_21_2 ~= "" and var_21_2 or nil
	arg_21_0.carImgae_.spriteSync = var_21_3 ~= "" and var_21_3 or nil

	var_0_9(arg_21_0.detailPropertyMap_, var_0_1, var_21_0.propertyList or {})
end

function var_0_0.RefreshView(arg_22_0)
	local var_22_0 = SummerRaceData:GetIllustratedPageModel()

	arg_22_0.bodyItemList_ = var_22_0.bodyList or {}
	arg_22_0.weaponItemList_ = var_22_0.weaponList or {}
	arg_22_0.equipItemList_ = var_22_0.equipList or {}

	arg_22_0:SyncItemViews_(arg_22_0.bodyItemViews_, arg_22_0.bodyListGo_, arg_22_0.bodyItemTemplateGo_, arg_22_0.bodyItemList_)
	arg_22_0:SyncItemViews_(arg_22_0.weaponItemViews_, arg_22_0.weaponListGo_, arg_22_0.weaponItemTemplateGo_, arg_22_0.weaponItemList_)
	arg_22_0:SyncItemViews_(arg_22_0.equipItemViews_, arg_22_0.equipListGo_, arg_22_0.equipItemTemplateGo_, arg_22_0.equipItemList_)
	arg_22_0:RefreshDetail(var_22_0.detailPanel)
end

function var_0_0.Dispose(arg_23_0)
	var_0_4(arg_23_0)
	var_0_6(arg_23_0)
	var_0_5(arg_23_0.bodyItemViews_)
	var_0_5(arg_23_0.weaponItemViews_)
	var_0_5(arg_23_0.equipItemViews_)

	arg_23_0.bodyItemViews_ = nil
	arg_23_0.weaponItemViews_ = nil
	arg_23_0.equipItemViews_ = nil
	arg_23_0.windowBarBackHandler_ = nil

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
