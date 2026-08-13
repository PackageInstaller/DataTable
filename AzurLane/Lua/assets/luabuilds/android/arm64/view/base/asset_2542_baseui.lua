class = var_0_10000

local var_0_0 = "BaseUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseEventLogic"))

var_0_1.LOADED = "BaseUI:LOADED"
var_0_1.DID_ENTER = "BaseUI:DID_ENTER"
var_0_1.AVALIBLE = "BaseUI:AVALIBLE"
var_0_1.DID_EXIT = "BaseUI:DID_EXIT"
var_0_1.ON_BACK = "BaseUI:ON_BACK"
var_0_1.ON_RETURN = "BaseUI:ON_RETURN"
var_0_1.ON_HOME = "BaseUI:ON_HOME"
var_0_1.ON_CLOSE = "BaseUI:ON_CLOSE"
var_0_1.ON_DROP = "BaseUI.ON_DROP"
var_0_1.ON_DROP_LIST = "BaseUI.ON_DROP_LIST"
var_0_1.ON_DROP_LIST_OWN = "BaseUI.ON_DROP_LIST_OWN"
var_0_1.ON_NEW_DROP = "BaseUI.ON_NEW_DROP"
var_0_1.ON_NEW_STYLE_DROP = "BaseUI.ON_NEW_STYLE_DROP"
var_0_1.ON_NEW_STYLE_ITEMS = "BaseUI.ON_NEW_STYLE_ITEMS"
var_0_1.ON_ITEM = "BaseUI:ON_ITEM"
var_0_1.ON_ITEM_EXTRA = "BaseUI.ON_ITEM_EXTRA"
var_0_1.ON_SHIP = "BaseUI:ON_SHIP"
var_0_1.ON_AWARD = "BaseUI:ON_AWARD"
var_0_1.ON_ACHIEVE = "BaseUI:ON_ACHIEVE"
var_0_1.ON_ACHIEVE_AUTO = "BaseUI:ON_ACHIEVE_AUTO"
var_0_1.ON_WORLD_ACHIEVE = "BaseUI:ON_WORLD_ACHIEVE"
var_0_1.ON_EQUIPMENT = "BaseUI:ON_EQUIPMENT"
var_0_1.ON_SPWEAPON = "BaseUI:ON_SPWEAPON"
var_0_1.ON_SHIP_EXP = "BaseUI.ON_SHIP_EXP"
var_0_1.ON_BACK_PRESSED = "BaseUI:ON_BACK_PRESS"
var_0_1.ON_ADD_SUBLAYER = "BaseUI:ON_ADD_SUBLAYER"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0._isLoaded = false
	arg_1_0._go = nil
	arg_1_0._tf = nil
	arg_1_0._isCachedView = false

	return
end

function var_0_1.setContextData(arg_2_0, arg_2_1)
	arg_2_0.contextData = arg_2_1

	return
end

function var_0_1.getUIName(arg_3_0)
	return nil
end

function var_0_1.getGroupName(arg_4_0)
	local var_4_0

	if not arg_4_0.contextData.groupName then
		var_4_0 = arg_4_0.__cname
	end

	return var_4_0
end

function var_0_1.getDefaultUI(arg_5_0)
	return arg_5_0._tf
end

function var_0_1.preloadUIList(arg_6_0)
	return {
		arg_6_0:getUIName()
	}
end

function var_0_1.needCache(arg_7_0)
	return false
end

function var_0_1.tempCache(arg_8_0)
	return false
end

function var_0_1.forceGC(arg_9_0)
	return false
end

function var_0_1.DontGC(arg_10_0)
	return false
end

function var_0_1.forceRatio(arg_11_0)
	return nil
end

function var_0_1.loadingQueue(arg_12_0)
	return false
end

function var_0_1.setLayerMgrRegister(arg_13_0, arg_13_1)
	if not arg_13_0.contextData then
		return
	end

	local var_13_0 = arg_13_0:getGroupName()

	if arg_13_1 then
		pg = var_1_10003

		local var_13_1 = var_1_10003.LayerWeightMgr.GetInstance()

		var_1_10003.RegisterGroupWeight(var_13_1, var_13_0)
	else
		pg = var_1_10003

		local var_13_2 = var_1_10003.LayerWeightMgr.GetInstance()

		var_3.RemoveGroupWeight(var_13_2, var_13_0)
	end

	return
end

function var_0_1.preload(arg_14_0, arg_14_1)
	arg_14_1()

	return
end

function var_0_1.loadUISync(arg_15_0, arg_15_1)
	LoadAndInstantiateSync = var_1_10002

	local var_15_0 = var_1_10002("UI", arg_15_1, true, false)

	pg = var_1_10003

	local var_15_1 = var_1_10003.UIMgr.GetInstance().UIMain
	local var_15_2 = var_15_0.transform

	var_4.SetParent(var_15_2, var_15_1.transform, false)

	return var_15_0
end

function var_0_1.GCWhenAwake(arg_16_0)
	tobool = var_1_10001

	return var_1_10001(arg_16_0:loadingQueue())
end

function var_0_1.load(arg_17_0)
	arg_17_0:setLayerMgrRegister(true)

	local var_17_0

	Time = var_1_10002

	local var_17_1 = var_1_10002.realtimeSinceStartup
	local var_17_2 = arg_17_0:getUIName()

	seriesAsync = var_4

	var_4({
		function(arg_18_0)
			local var_18_0 = arg_17_0

			if var_1.GCWhenAwake(var_18_0) then
				gcAll = var_1

				var_1(true)
			end

			local var_18_1 = arg_17_0

			var_1.preload(var_18_1, arg_18_0)

			return
		end,
		function(arg_19_0)
			local var_19_0 = arg_17_0

			var_1.LoadUIFromPool(var_19_0, var_17_2, function(arg_20_0)
				print = var_3_10001

				var_3_10001("Loaded " .. var_17_2)

				var_17_0 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end
	}, function()
		originalPrint = var_2_10000

		local var_21_0 = "load "
		local var_21_1 = var_17_0.name
		local var_21_2 = " time cost: "

		Time = var_2_10005

		var_2_10000(var_21_0 .. var_21_1 .. var_21_2 .. var_2_10005.realtimeSinceStartup - var_17_1)

		local var_21_3 = arg_17_0

		var_0.SetUIParent(var_21_3, var_17_0)

		local var_21_4 = arg_17_0

		if var_0.CheckTempCache(var_21_4) then
			PoolMgr = var_0

			local var_21_5 = var_0.GetInstance()

			var_0.KeepUICache(var_21_5, var_17_2, true)
		end

		local var_21_6 = arg_17_0

		var_0.onUILoaded(var_21_6, var_17_0)

		return
	end)

	return
end

function var_0_1.SetUIParent(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0 = var_1_10002.UIMgr.GetInstance().UIMain
	local var_22_1 = arg_22_1.transform

	var_3.SetParent(var_22_1, var_22_0.transform, false)

	return
end

function var_0_1.LoadUIFromPool(arg_23_0, arg_23_1, arg_23_2)
	PoolMgr = var_1_10003

	local var_23_0 = var_1_10003.GetInstance()

	var_3.GetUI(var_23_0, arg_23_1, true, arg_23_2)

	return
end

function var_0_1.getBGM(arg_24_0, arg_24_1)
	getBgm = var_1_10002

	return var_1_10002(arg_24_1 or arg_24_0.__cname)
end

function var_0_1.PlayBGM(arg_25_0)
	if arg_25_0:getBGM() then
		pg = var_1_10002

		local var_25_0 = var_1_10002.BgmMgr.GetInstance()

		var_2.Push(var_25_0, arg_25_0.__cname, var_1)
	end

	return
end

function var_0_1.StopBgm(arg_26_0)
	if not arg_26_0.contextData then
		return
	end

	if arg_26_0.contextData.isLayer then
		pg = var_1

		local var_26_0 = var_1.BgmMgr.GetInstance()

		var_1.Pop(var_26_0, arg_26_0.__cname)
	else
		pg = var_1

		local var_26_1 = var_1.BgmMgr.GetInstance()

		var_1.Clear(var_26_1)
	end

	return
end

function var_0_1.isLoaded(arg_27_0)
	return arg_27_0._isLoaded
end

function var_0_1.CheckTempCache(arg_28_0)
	local var_28_0

	if arg_28_0:tempCache() then
		var_28_0 = arg_28_0:isLayer()
	end

	return var_28_0
end

function var_0_1.isLayer(arg_29_0)
	return arg_29_0.contextData ~= nil and arg_29_0.contextData.isLayer
end

function var_0_1.Add2Overlay(arg_30_0, arg_30_1, arg_30_2)
	if not arg_30_0.contextData then
		return
	end

	arg_30_2 = arg_30_2 or {}
	arg_30_2.groupName = arg_30_0:getGroupName()
	pg = var_3

	local var_30_0 = var_3.LayerWeightMgr.GetInstance()

	var_3.Add2Overlay(var_30_0, arg_30_1, arg_30_2)

	return
end

function var_0_1.DelFromOverlay(arg_31_0, arg_31_1, ...)
	if not arg_31_0.contextData then
		return
	end

	pg = var_2

	local var_31_0 = var_2.LayerWeightMgr.GetInstance()

	var_2.DelFromOverlay(var_31_0, arg_31_1, ...)

	return
end

function var_0_1.OverlayPanel(arg_32_0, arg_32_1, arg_32_2)
	arg_32_2 = arg_32_2 or {}
	LayerWeightConst = var_1_10003
	arg_32_2.type = var_1_10003.UI_TYPE_SUB

	arg_32_0:Add2Overlay(arg_32_1, arg_32_2)

	return
end

function var_0_1.BlurPanel(arg_33_0, arg_33_1, arg_33_2)
	arg_33_2 = arg_33_2 or {}
	LayerWeightConst = var_1_10003
	arg_33_2.type = var_1_10003.UI_TYPE_SUB
	arg_33_2.globalBlur = true

	arg_33_0:Add2Overlay(arg_33_1, arg_33_2)

	return
end

function var_0_1.UnOverlayPanel(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0:DelFromOverlay(arg_34_1, arg_34_2 or arg_34_0.UIMain)

	return
end

function var_0_1.TempOverlayPanelPB(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0.contextData then
		return
	end

	arg_35_2 = arg_35_2 or {}
	arg_35_2.groupName = arg_35_0:getGroupName()
	pg = var_3

	local var_35_0 = var_3.UIMgr.GetInstance()

	var_3.TempOverlayPanelPB(var_35_0, arg_35_1, arg_35_2)

	return
end

function var_0_1.TempUnOverlayPanelPB(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0.contextData then
		return
	end

	pg = var_3

	local var_36_0 = var_3.UIMgr.GetInstance()

	var_3.TempUnOverlayPanelPB(var_36_0, arg_36_1, arg_36_2)

	return
end

var_0_1.optionsPath = {
	"option",
	"top/option",
	"top/left_top/option",
	"blur_container/top/title/option",
	"blur_container/top/option",
	"top/top/option",
	"common/top/option",
	"blur_panel/top/option",
	"blurPanel/top/option",
	"blur_container/top/option",
	"top/title/option",
	"blur_panel/adapt/top/option",
	"mainPanel/top/option",
	"bg/top/option",
	"blur_container/adapt/top/title/option",
	"blur_container/adapt/top/option",
	"ForNorth/top/option",
	"top/top_chapter/option",
	"Main/blur_panel/adapt/top/option",
	"adapt/blur_panel/adapt/top/option"
}

function var_0_1.onUILoaded(arg_37_0, arg_37_1)
	arg_37_0._go = arg_37_1
	arg_37_0._tf = arg_37_1 and arg_37_1.transform

	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.Add2Overlay
	local var_37_2 = arg_37_0
	local var_37_3 = arg_37_0.getDefaultUI(var_37_2)
	local var_37_4 = {}

	LayerWeightConst = var_37_2
	var_37_4.type = var_37_2.UI_TYPE_SYSTEM

	var_37_1(var_37_0, var_37_3, var_37_4)

	pg = var_37_1

	local var_37_5 = var_37_1.SeriesGuideMgr.GetInstance()

	var_2.dispatch(var_37_5, {
		view = arg_37_0.__cname
	})

	pg = var_2

	local var_37_6 = var_2.NewStoryMgr.GetInstance()

	var_2.OnSceneEnter(var_37_6, {
		view = arg_37_0.__cname
	})

	arg_37_0._isLoaded = true
	pg = var_2

	var_2.DelegateInfo.New(arg_37_0)

	arg_37_0.optionBtns = {}
	ipairs = var_2

	for iter_37_0, iter_37_1 in var_2(arg_37_0.optionsPath) do
		table = var_37_7

		local var_37_7 = var_37_7.insert
		local var_37_8 = arg_37_0.optionBtns
		local var_37_9 = arg_37_0._tf

		var_37_7(var_37_8, var_10.Find(var_37_9, iter_37_1))
	end

	setActiveViaLayer = var_2

	var_2(arg_37_0._tf, true)

	bindComponent = var_2

	var_2(arg_37_0, arg_37_0._go)
	arg_37_0:init()
	arg_37_0:emit(var_0_1.LOADED)

	return
end

function var_0_1.ResUISettings(arg_38_0)
	return nil
end

function var_0_1.ShowOrHideResUI(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0

	if not arg_39_0.ResUISettings(var_39_0) then
		return
	end

	local var_39_2

	if var_39_2 == true then
		local var_39_1 = {
			anim = true
		}

		PlayerResUI = var_39_0
		var_39_1.showType = var_39_0.TYPE_ALL
		var_39_2 = var_39_1
	end

	local var_39_3 = arg_39_0:getGroupName()

	if arg_39_1 then
		pg = var_39_0

		local var_39_4 = var_39_0.playerResUI

		var_39_0 = var_39_0.SetSettings

		local var_39_5 = var_39_3

		setmetatable = var_1_10008

		var_39_0(var_39_4, var_39_5, var_1_10008({
			groupName = var_39_3
		}, {
			__index = var_39_2
		}))
	else
		pg = var_39_0

		local var_39_6 = var_39_0.playerResUI

		var_4.RemoveSettings(var_39_6, var_39_3)
	end

	return
end

function var_0_1.onUIAnimEnd(arg_40_0, arg_40_1)
	arg_40_1()

	return
end

function var_0_1.init(arg_41_0)
	return
end

function var_0_1.quickExitFunc(arg_42_0)
	arg_42_0:emit(var_0_1.ON_HOME)

	return
end

function var_0_1.quickExit(arg_43_0)
	ipairs = var_1_10001

	for iter_43_0, iter_43_1 in var_1_10001(arg_43_0.optionBtns) do
		onButton = var_1_10006

		local var_43_0 = arg_43_0
		local var_43_1 = iter_43_1

		local function var_43_2()
			local var_44_0 = arg_43_0

			var_0.quickExitFunc(var_44_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_43_0, var_43_1, var_43_2, var_1_10011)
	end

	return
end

function var_0_1.enter(arg_45_0)
	arg_45_0:quickExit()
	arg_45_0:PlayBGM()
	arg_45_0:emit(var_0_1.DID_ENTER)

	if arg_45_0:forceRatio() then
		pg = var_1

		local var_45_0 = var_1.CameraFixMgr.GetInstance()

		var_1.SetForceRatio(var_45_0, arg_45_0:forceRatio())
	end

	if not arg_45_0._isCachedView then
		arg_45_0:didEnter()
		arg_45_0:ShowOrHideResUI(true)
	end

	tobool = var_1

	if var_1(arg_45_0:loadingQueue()) and arg_45_0.contextData.resumeCallback then
		local var_45_1 = arg_45_0.contextData.resumeCallback

		arg_45_0.contextData.resumeCallback = nil

		var_45_1()
	end

	arg_45_0:emit(var_0_1.AVALIBLE)
	arg_45_0:onUIAnimEnd(function()
		pg = var_2_10000

		local var_46_0 = var_2_10000.SeriesGuideMgr.GetInstance()
		local var_46_1 = var_0.start
		local var_46_2 = {
			view = arg_45_0.__cname
		}
		local var_46_3 = {}

		pg = var_2_10005
		var_46_3[1] = var_2_10005.SeriesGuideMgr.CODES.MAINUI
		var_46_2.code = var_46_3

		var_46_1(var_46_0, var_46_2)

		pg = var_46_1

		local var_46_4 = var_46_1.NewGuideMgr.GetInstance()

		var_0.OnSceneEnter(var_46_4, {
			view = arg_45_0.__cname
		})

		return
	end)

	return
end

function var_0_1.closeView(arg_47_0)
	if arg_47_0.contextData.isLayer then
		arg_47_0:emit(var_0_1.ON_CLOSE)
	else
		arg_47_0:emit(var_0_1.ON_BACK)
	end

	return
end

function var_0_1.didEnter(arg_48_0)
	return
end

function var_0_1.willExit(arg_49_0)
	return
end

function var_0_1.exit(arg_50_0)
	arg_50_0.exited = true

	arg_50_0:StopBgm()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_50_0)
	arg_50_0:willExit()

	bindComponent = var_1

	var_1(arg_50_0, arg_50_0._go, true)
	arg_50_0:ShowOrHideResUI(false)
	arg_50_0:DelFromOverlay(arg_50_0:getDefaultUI())
	arg_50_0:setLayerMgrRegister(false)
	arg_50_0:detach()

	if arg_50_0:forceRatio() then
		pg = var_1

		local var_50_0 = var_1.CameraFixMgr.GetInstance()

		var_1.SetForceRatio(var_50_0, nil)
	end

	pg = var_1

	local var_50_1 = var_1.NewGuideMgr.GetInstance()

	var_1.OnSceneExit(var_50_1, {
		view = arg_50_0.__cname
	})

	pg = var_1

	local var_50_2 = var_1.NewStoryMgr.GetInstance()

	var_1.OnSceneExit(var_50_2, {
		view = arg_50_0.__cname
	})
	arg_50_0:emit(var_0_1.DID_EXIT)

	return
end

function var_0_1.PlayUIAnimation(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_1
	local var_51_1 = arg_51_1.GetComponent

	typeof = var_1_10007
	Animation = var_1_10009

	local var_51_2 = var_51_1(var_51_0, var_1_10007(var_1_10009))
	local var_51_3 = arg_51_1
	local var_51_4 = arg_51_1.GetComponent

	typeof = var_1_10008
	UIEventTrigger = var_1_10010

	local var_51_5 = var_51_4(var_51_3, var_1_10008(var_1_10010)).didExit

	var_6.RemoveAllListeners(var_51_5)

	local var_51_6 = var_5.didExit

	var_6.AddListener(var_51_6, function()
		local var_52_0 = var_0.didExit

		var_0.RemoveAllListeners(var_52_0)
		arg_51_3()

		return
	end)
	var_51_2:Play(arg_51_2)

	return
end

function var_0_1.attach(arg_53_0, arg_53_1)
	return
end

function var_0_1.ClearTweens(arg_54_0, arg_54_1)
	arg_54_0:cleanManagedTween(arg_54_1)

	return
end

function var_0_1.detach(arg_55_0, arg_55_1)
	arg_55_0._isLoaded = false
	pg = var_2

	local var_55_0 = var_2.DynamicBgMgr.GetInstance()

	var_2.ClearBg(var_55_0, arg_55_0:getUIName())
	arg_55_0:disposeEvent()
	arg_55_0:ClearTweens(false)

	arg_55_0._tf = nil
	PoolMgr = var_2

	local var_55_1 = var_2.GetInstance()
	local var_55_2 = arg_55_0:getUIName()

	if arg_55_0._go ~= nil and var_55_2 then
		var_55_1:ReturnUI(var_55_2, arg_55_0._go)

		arg_55_0._go = nil
	end

	return
end

function var_0_1.getTpl(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_2 or arg_56_0._tf
	local var_56_1 = var_3.Find(var_56_0, arg_56_1)

	var_3.SetParent(var_56_1, arg_56_0._tf, false)

	SetActive = var_4

	var_4(var_3, false)

	return var_3
end

function var_0_1.setSpriteTo(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = arg_57_2
	local var_57_1 = arg_57_2.GetComponent

	typeof = var_1_10007
	Image = var_1_10009

	local var_57_2 = var_57_1(var_57_0, var_1_10007(var_1_10009))
	local var_57_3 = arg_57_0._tf
	local var_57_4 = var_5.Find(var_57_3, arg_57_1)
	local var_57_5 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010
	var_57_2.sprite = var_57_5(var_57_4, var_8(var_1_10010)).sprite

	if arg_57_3 then
		var_57_2:SetNativeSize()
	end

	return
end

function var_0_1.setImageAmount(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_1
	local var_58_1 = arg_58_1.GetComponent

	typeof = var_1_10006
	Image = var_1_10008
	var_58_1(var_58_0, var_1_10006(var_1_10008)).fillAmount = arg_58_2

	return
end

function var_0_1.setVisible(arg_59_0, arg_59_1)
	arg_59_0:ShowOrHideResUI(arg_59_1)

	if arg_59_1 then
		arg_59_0:OnVisible()
	else
		arg_59_0:OnDisVisible()
	end

	setActiveViaLayer = var_2

	var_2(arg_59_0._tf, arg_59_1)

	return
end

function var_0_1.OnVisible(arg_60_0)
	return
end

function var_0_1.OnDisVisible(arg_61_0)
	return
end

function var_0_1.onBackPressed(arg_62_0)
	arg_62_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

return var_0_1
