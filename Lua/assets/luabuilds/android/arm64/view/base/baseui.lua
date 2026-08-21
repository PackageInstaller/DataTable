local var_0_0 = class("BaseUI", import("view.base.BaseEventLogic"))

var_0_0.LOADED = "BaseUI:LOADED"
var_0_0.DID_ENTER = "BaseUI:DID_ENTER"
var_0_0.AVALIBLE = "BaseUI:AVALIBLE"
var_0_0.DID_EXIT = "BaseUI:DID_EXIT"
var_0_0.ON_BACK = "BaseUI:ON_BACK"
var_0_0.ON_RETURN = "BaseUI:ON_RETURN"
var_0_0.ON_HOME = "BaseUI:ON_HOME"
var_0_0.ON_CLOSE = "BaseUI:ON_CLOSE"
var_0_0.ON_DROP = "BaseUI.ON_DROP"
var_0_0.ON_DROP_LIST = "BaseUI.ON_DROP_LIST"
var_0_0.ON_DROP_LIST_OWN = "BaseUI.ON_DROP_LIST_OWN"
var_0_0.ON_NEW_DROP = "BaseUI.ON_NEW_DROP"
var_0_0.ON_NEW_STYLE_DROP = "BaseUI.ON_NEW_STYLE_DROP"
var_0_0.ON_NEW_STYLE_ITEMS = "BaseUI.ON_NEW_STYLE_ITEMS"
var_0_0.ON_ITEM = "BaseUI:ON_ITEM"
var_0_0.ON_ITEM_EXTRA = "BaseUI.ON_ITEM_EXTRA"
var_0_0.ON_SHIP = "BaseUI:ON_SHIP"
var_0_0.ON_AWARD = "BaseUI:ON_AWARD"
var_0_0.ON_ACHIEVE = "BaseUI:ON_ACHIEVE"
var_0_0.ON_ACHIEVE_AUTO = "BaseUI:ON_ACHIEVE_AUTO"
var_0_0.ON_WORLD_ACHIEVE = "BaseUI:ON_WORLD_ACHIEVE"
var_0_0.ON_EQUIPMENT = "BaseUI:ON_EQUIPMENT"
var_0_0.ON_SPWEAPON = "BaseUI:ON_SPWEAPON"
var_0_0.ON_SHIP_EXP = "BaseUI.ON_SHIP_EXP"
var_0_0.ON_BACK_PRESSED = "BaseUI:ON_BACK_PRESS"
var_0_0.ON_ADD_SUBLAYER = "BaseUI:ON_ADD_SUBLAYER"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0._isLoaded = false
	arg_1_0._go = nil
	arg_1_0._tf = nil
	arg_1_0._isCachedView = false

	return
end

function var_0_0.setContextData(arg_2_0, arg_2_1)
	arg_2_0.contextData = arg_2_1

	return
end

function var_0_0.getUIName(arg_3_0)
	return nil
end

function var_0_0.getGroupName(arg_4_0)
	return arg_4_0.contextData.groupName or arg_4_0.__cname
end

function var_0_0.getDefaultUI(arg_5_0)
	return arg_5_0._tf
end

function var_0_0.preloadUIList(arg_6_0)
	return {
		arg_6_0:getUIName()
	}
end

function var_0_0.needCache(arg_7_0)
	return false
end

function var_0_0.tempCache(arg_8_0)
	return false
end

function var_0_0.forceGC(arg_9_0)
	return false
end

function var_0_0.DontGC(arg_10_0)
	return false
end

function var_0_0.forceRatio(arg_11_0)
	return nil
end

function var_0_0.loadingQueue(arg_12_0)
	return false
end

function var_0_0.setLayerMgrRegister(arg_13_0, arg_13_1)
	if not arg_13_0.contextData then
		return
	end

	local var_13_0 = arg_13_0:getGroupName()

	if arg_13_1 then
		pg.LayerWeightMgr.GetInstance():RegisterGroupWeight(var_13_0)
	else
		pg.LayerWeightMgr.GetInstance():RemoveGroupWeight(var_13_0)
	end

	return
end

function var_0_0.preload(arg_14_0, arg_14_1)
	arg_14_1()

	return
end

function var_0_0.loadUISync(arg_15_0, arg_15_1)
	local var_15_0 = LoadAndInstantiateSync("UI", arg_15_1, true, false)

	var_15_0.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)

	return var_15_0
end

function var_0_0.GCWhenAwake(arg_16_0)
	return tobool(arg_16_0:loadingQueue())
end

function var_0_0.load(arg_17_0)
	arg_17_0:setLayerMgrRegister(true)

	local var_17_0
	local var_17_1 = Time.realtimeSinceStartup
	local var_17_2 = arg_17_0:getUIName()

	seriesAsync({
		function(arg_18_0)
			if arg_17_0:GCWhenAwake() then
				gcAll(true)
			end

			arg_17_0:preload(arg_18_0)

			return
		end,
		function(arg_19_0)
			arg_17_0:LoadUIFromPool(var_17_2, function(arg_20_0)
				print("Loaded " .. var_17_2)

				var_17_0 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end
	}, function()
		originalPrint("load " .. var_17_0.name .. " time cost: " .. Time.realtimeSinceStartup - var_17_1)
		arg_17_0:SetUIParent(var_17_0)

		if arg_17_0:CheckTempCache() then
			PoolMgr.GetInstance():KeepUICache(var_17_2, true)
		end

		arg_17_0:onUILoaded(var_17_0)

		return
	end)

	return
end

function var_0_0.SetUIParent(arg_22_0, arg_22_1)
	arg_22_1.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)

	return
end

function var_0_0.LoadUIFromPool(arg_23_0, arg_23_1, arg_23_2)
	PoolMgr.GetInstance():GetUI(arg_23_1, true, arg_23_2)

	return
end

function var_0_0.getBGM(arg_24_0, arg_24_1)
	return getBgm(arg_24_1 or arg_24_0.__cname)
end

function var_0_0.PlayBGM(arg_25_0)
	local var_25_0 = arg_25_0:getBGM()

	if var_25_0 then
		pg.BgmMgr.GetInstance():Push(arg_25_0.__cname, var_25_0)
	end

	return
end

function var_0_0.StopBgm(arg_26_0)
	if not arg_26_0.contextData then
		return
	end

	if arg_26_0.contextData.isLayer then
		pg.BgmMgr.GetInstance():Pop(arg_26_0.__cname)
	else
		pg.BgmMgr.GetInstance():Clear()
	end

	return
end

function var_0_0.isLoaded(arg_27_0)
	return arg_27_0._isLoaded
end

function var_0_0.CheckTempCache(arg_28_0)
	return arg_28_0:tempCache() and arg_28_0:isLayer()
end

function var_0_0.isLayer(arg_29_0)
	return arg_29_0.contextData ~= nil and arg_29_0.contextData.isLayer
end

function var_0_0.Add2Overlay(arg_30_0, arg_30_1, arg_30_2)
	if not arg_30_0.contextData then
		return
	end

	arg_30_2 = arg_30_2 or {}
	arg_30_2.groupName = arg_30_0:getGroupName()

	pg.LayerWeightMgr.GetInstance():Add2Overlay(arg_30_1, arg_30_2)

	return
end

function var_0_0.DelFromOverlay(arg_31_0, arg_31_1, ...)
	if not arg_31_0.contextData then
		return
	end

	pg.LayerWeightMgr.GetInstance():DelFromOverlay(arg_31_1, ...)

	return
end

function var_0_0.OverlayPanel(arg_32_0, arg_32_1, arg_32_2)
	arg_32_2 = arg_32_2 or {}
	arg_32_2.type = LayerWeightConst.UI_TYPE_SUB

	arg_32_0:Add2Overlay(arg_32_1, arg_32_2)

	return
end

function var_0_0.BlurPanel(arg_33_0, arg_33_1, arg_33_2)
	arg_33_2 = arg_33_2 or {}
	arg_33_2.type = LayerWeightConst.UI_TYPE_SUB
	arg_33_2.globalBlur = true

	arg_33_0:Add2Overlay(arg_33_1, arg_33_2)

	return
end

function var_0_0.UnOverlayPanel(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0:DelFromOverlay(arg_34_1, arg_34_2 or arg_34_0.UIMain)

	return
end

function var_0_0.TempOverlayPanelPB(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0.contextData then
		return
	end

	arg_35_2 = arg_35_2 or {}
	arg_35_2.groupName = arg_35_0:getGroupName()

	pg.UIMgr.GetInstance():TempOverlayPanelPB(arg_35_1, arg_35_2)

	return
end

function var_0_0.TempUnOverlayPanelPB(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_0.contextData then
		return
	end

	pg.UIMgr.GetInstance():TempUnOverlayPanelPB(arg_36_1, arg_36_2)

	return
end

var_0_0.optionsPath = {
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

function var_0_0.onUILoaded(arg_37_0, arg_37_1)
	arg_37_0._go = arg_37_1
	arg_37_0._tf = arg_37_1 and arg_37_1.transform

	arg_37_0:Add2Overlay(arg_37_0:getDefaultUI(), {
		type = LayerWeightConst.UI_TYPE_SYSTEM
	})
	pg.SeriesGuideMgr.GetInstance():dispatch({
		view = arg_37_0.__cname
	})
	pg.NewStoryMgr.GetInstance():OnSceneEnter({
		view = arg_37_0.__cname
	})

	arg_37_0._isLoaded = true

	pg.DelegateInfo.New(arg_37_0)

	arg_37_0.optionBtns = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_0.optionsPath) do
		table.insert(arg_37_0.optionBtns, arg_37_0._tf:Find(iter_37_1))
	end

	setActiveViaLayer(arg_37_0._tf, true)
	bindComponent(arg_37_0, arg_37_0._go)
	arg_37_0:init()
	arg_37_0:emit(var_0_0.LOADED)

	return
end

function var_0_0.ResUISettings(arg_38_0)
	return nil
end

function var_0_0.ShowOrHideResUI(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:ResUISettings()

	if not var_39_0 then
		return
	end

	if var_39_0 == true then
		var_39_0 = {
			anim = true,
			showType = PlayerResUI.TYPE_ALL
		}
	end

	local var_39_1 = arg_39_0:getGroupName()

	if arg_39_1 then
		pg.playerResUI:SetSettings(var_39_1, setmetatable({
			groupName = var_39_1
		}, {
			__index = var_39_0
		}))
	else
		pg.playerResUI:RemoveSettings(var_39_1)
	end

	return
end

function var_0_0.onUIAnimEnd(arg_40_0, arg_40_1)
	arg_40_1()

	return
end

function var_0_0.init(arg_41_0)
	return
end

function var_0_0.quickExitFunc(arg_42_0)
	arg_42_0:emit(var_0_0.ON_HOME)

	return
end

function var_0_0.quickExit(arg_43_0)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0.optionBtns) do
		onButton(arg_43_0, iter_43_1, function()
			arg_43_0:quickExitFunc()

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.enter(arg_45_0)
	arg_45_0:quickExit()
	arg_45_0:PlayBGM()
	arg_45_0:emit(var_0_0.DID_ENTER)

	if arg_45_0:forceRatio() then
		pg.CameraFixMgr.GetInstance():SetForceRatio(arg_45_0:forceRatio())
	end

	if not arg_45_0._isCachedView then
		arg_45_0:didEnter()
		arg_45_0:ShowOrHideResUI(true)
	end

	if tobool(arg_45_0:loadingQueue()) and arg_45_0.contextData.resumeCallback then
		arg_45_0.contextData.resumeCallback = nil

		arg_45_0.contextData.resumeCallback()
	end

	arg_45_0:emit(var_0_0.AVALIBLE)
	arg_45_0:onUIAnimEnd(function()
		pg.SeriesGuideMgr.GetInstance():start({
			view = arg_45_0.__cname,
			code = {
				pg.SeriesGuideMgr.CODES.MAINUI
			}
		})
		pg.NewGuideMgr.GetInstance():OnSceneEnter({
			view = arg_45_0.__cname
		})

		return
	end)

	return
end

function var_0_0.closeView(arg_47_0)
	if arg_47_0.contextData.isLayer then
		arg_47_0:emit(var_0_0.ON_CLOSE)
	else
		arg_47_0:emit(var_0_0.ON_BACK)
	end

	return
end

function var_0_0.didEnter(arg_48_0)
	return
end

function var_0_0.willExit(arg_49_0)
	return
end

function var_0_0.exit(arg_50_0)
	arg_50_0.exited = true

	arg_50_0:StopBgm()
	pg.DelegateInfo.Dispose(arg_50_0)
	arg_50_0:willExit()
	bindComponent(arg_50_0, arg_50_0._go, true)
	arg_50_0:ShowOrHideResUI(false)
	arg_50_0:DelFromOverlay(arg_50_0:getDefaultUI())
	arg_50_0:setLayerMgrRegister(false)
	arg_50_0:detach()

	if arg_50_0:forceRatio() then
		pg.CameraFixMgr.GetInstance():SetForceRatio(nil)
	end

	pg.NewGuideMgr.GetInstance():OnSceneExit({
		view = arg_50_0.__cname
	})
	pg.NewStoryMgr.GetInstance():OnSceneExit({
		view = arg_50_0.__cname
	})
	arg_50_0:emit(var_0_0.DID_EXIT)

	return
end

function var_0_0.PlayUIAnimation(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_1:GetComponent(typeof(UIEventTrigger))

	var_51_0.didExit:RemoveAllListeners()
	var_51_0.didExit:AddListener(function()
		var_51_0.didExit:RemoveAllListeners()
		arg_51_3()

		return
	end)
	arg_51_1:GetComponent(typeof(Animation)):Play(arg_51_2)

	return
end

function var_0_0.attach(arg_53_0, arg_53_1)
	return
end

function var_0_0.ClearTweens(arg_54_0, arg_54_1)
	arg_54_0:cleanManagedTween(arg_54_1)

	return
end

function var_0_0.detach(arg_55_0, arg_55_1)
	arg_55_0._isLoaded = false

	pg.DynamicBgMgr.GetInstance():ClearBg(arg_55_0:getUIName())
	arg_55_0:disposeEvent()
	arg_55_0:ClearTweens(false)

	arg_55_0._tf = nil

	local var_55_0 = arg_55_0:getUIName()

	if arg_55_0._go ~= nil and var_55_0 then
		PoolMgr.GetInstance():ReturnUI(var_55_0, arg_55_0._go)

		arg_55_0._go = nil
	end

	return
end

function var_0_0.getTpl(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = (arg_56_2 or arg_56_0._tf):Find(arg_56_1)

	var_56_0:SetParent(arg_56_0._tf, false)
	SetActive(var_56_0, false)

	return var_56_0
end

function var_0_0.setSpriteTo(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = arg_57_2:GetComponent(typeof(Image))

	var_57_0.sprite = arg_57_0._tf:Find(arg_57_1):GetComponent(typeof(Image)).sprite

	if arg_57_3 then
		var_57_0:SetNativeSize()
	end

	return
end

function var_0_0.setImageAmount(arg_58_0, arg_58_1, arg_58_2)
	arg_58_1:GetComponent(typeof(Image)).fillAmount = arg_58_2

	return
end

function var_0_0.setVisible(arg_59_0, arg_59_1)
	arg_59_0:ShowOrHideResUI(arg_59_1)

	if arg_59_1 then
		arg_59_0:OnVisible()
	else
		arg_59_0:OnDisVisible()
	end

	setActiveViaLayer(arg_59_0._tf, arg_59_1)

	return
end

function var_0_0.OnVisible(arg_60_0)
	return
end

function var_0_0.OnDisVisible(arg_61_0)
	return
end

function var_0_0.onBackPressed(arg_62_0)
	arg_62_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

return var_0_0
