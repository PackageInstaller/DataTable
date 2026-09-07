local BaseUI = class("BaseUI", import("view.base.BaseEventLogic"))

BaseUI.LOADED = "BaseUI:LOADED"
BaseUI.DID_ENTER = "BaseUI:DID_ENTER"
BaseUI.AVALIBLE = "BaseUI:AVALIBLE"
BaseUI.DID_EXIT = "BaseUI:DID_EXIT"
BaseUI.ON_BACK = "BaseUI:ON_BACK"
BaseUI.ON_RETURN = "BaseUI:ON_RETURN"
BaseUI.ON_HOME = "BaseUI:ON_HOME"
BaseUI.ON_CLOSE = "BaseUI:ON_CLOSE"
BaseUI.ON_DROP = "BaseUI.ON_DROP"
BaseUI.ON_DROP_LIST = "BaseUI.ON_DROP_LIST"
BaseUI.ON_DROP_LIST_OWN = "BaseUI.ON_DROP_LIST_OWN"
BaseUI.ON_NEW_DROP = "BaseUI.ON_NEW_DROP"
BaseUI.ON_NEW_STYLE_DROP = "BaseUI.ON_NEW_STYLE_DROP"
BaseUI.ON_NEW_STYLE_ITEMS = "BaseUI.ON_NEW_STYLE_ITEMS"
BaseUI.ON_ITEM = "BaseUI:ON_ITEM"
BaseUI.ON_ITEM_EXTRA = "BaseUI.ON_ITEM_EXTRA"
BaseUI.ON_SHIP = "BaseUI:ON_SHIP"
BaseUI.ON_AWARD = "BaseUI:ON_AWARD"
BaseUI.ON_ACHIEVE = "BaseUI:ON_ACHIEVE"
BaseUI.ON_ACHIEVE_AUTO = "BaseUI:ON_ACHIEVE_AUTO"
BaseUI.ON_WORLD_ACHIEVE = "BaseUI:ON_WORLD_ACHIEVE"
BaseUI.ON_EQUIPMENT = "BaseUI:ON_EQUIPMENT"
BaseUI.ON_SPWEAPON = "BaseUI:ON_SPWEAPON"
BaseUI.ON_SHIP_EXP = "BaseUI.ON_SHIP_EXP"
BaseUI.ON_BACK_PRESSED = "BaseUI:ON_BACK_PRESS"
BaseUI.ON_ADD_SUBLAYER = "BaseUI:ON_ADD_SUBLAYER"

function BaseUI:Ctor()
	BaseUI.super.Ctor(self)

	self._isLoaded = false
	self._go = nil
	self._tf = nil
	self._isCachedView = false

	return
end

function BaseUI:setContextData(arg_2_1)
	self.contextData = arg_2_1

	return
end

function BaseUI:getUIName()
	return nil
end

function BaseUI:getGroupName()
	return self.contextData.groupName or self.__cname
end

function BaseUI:getDefaultUI()
	return self._tf
end

function BaseUI:preloadUIList()
	return {
		self:getUIName()
	}
end

function BaseUI:needCache()
	return false
end

function BaseUI:tempCache()
	return false
end

function BaseUI:forceGC()
	return false
end

function BaseUI:DontGC()
	return false
end

function BaseUI:forceRatio()
	return nil
end

function BaseUI:loadingQueue()
	return false
end

function BaseUI:setLayerMgrRegister(arg_13_1)
	if not self.contextData then
		return
	end

	local var_13_0 = self:getGroupName()

	if arg_13_1 then
		pg.LayerWeightMgr.GetInstance():RegisterGroupWeight(var_13_0)
	else
		pg.LayerWeightMgr.GetInstance():RemoveGroupWeight(var_13_0)
	end

	return
end

function BaseUI:preload(arg_14_1)
	arg_14_1()

	return
end

function BaseUI:loadUISync(arg_15_1)
	local var_15_0 = LoadAndInstantiateSync("UI", arg_15_1, true, false)

	var_15_0.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)

	return var_15_0
end

function BaseUI:GCWhenAwake()
	return tobool(self:loadingQueue())
end

function BaseUI:load()
	self:setLayerMgrRegister(true)

	local var_17_0
	local var_17_1 = Time.realtimeSinceStartup
	local var_17_2 = self:getUIName()

	seriesAsync({
		function(arg_18_0)
			if self:GCWhenAwake() then
				gcAll(true)
			end

			self:preload(arg_18_0)

			return
		end,
		function(arg_19_0)
			self:LoadUIFromPool(var_17_2, function(arg_20_0)
				print("Loaded " .. var_17_2)

				var_17_0 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end
	}, function()
		originalPrint("load " .. var_17_0.name .. " time cost: " .. Time.realtimeSinceStartup - var_17_1)
		self:SetUIParent(var_17_0)

		if self:CheckTempCache() then
			PoolMgr.GetInstance():KeepUICache(var_17_2, true)
		end

		self:onUILoaded(var_17_0)

		return
	end)

	return
end

function BaseUI:SetUIParent(arg_22_1)
	arg_22_1.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)

	return
end

function BaseUI:LoadUIFromPool(arg_23_1, arg_23_2)
	PoolMgr.GetInstance():GetUI(arg_23_1, true, arg_23_2)

	return
end

function BaseUI:getBGM(arg_24_1)
	return getBgm(arg_24_1 or self.__cname)
end

function BaseUI:PlayBGM()
	local var_25_0 = self:getBGM()

	if var_25_0 then
		pg.BgmMgr.GetInstance():Push(self.__cname, var_25_0)
	end

	return
end

function BaseUI:StopBgm()
	if not self.contextData then
		return
	end

	if self.contextData.isLayer then
		pg.BgmMgr.GetInstance():Pop(self.__cname)
	else
		pg.BgmMgr.GetInstance():Clear()
	end

	return
end

function BaseUI:isLoaded()
	return self._isLoaded
end

function BaseUI:CheckTempCache()
	return self:tempCache() and self:isLayer()
end

function BaseUI:isLayer()
	return self.contextData ~= nil and self.contextData.isLayer
end

function BaseUI:Add2Overlay(arg_30_1, arg_30_2)
	if not self.contextData then
		return
	end

	arg_30_2 = arg_30_2 or {}
	arg_30_2.groupName = self:getGroupName()

	pg.LayerWeightMgr.GetInstance():Add2Overlay(arg_30_1, arg_30_2)

	return
end

function BaseUI:DelFromOverlay(arg_31_1, ...)
	if not self.contextData then
		return
	end

	pg.LayerWeightMgr.GetInstance():DelFromOverlay(arg_31_1, ...)

	return
end

function BaseUI:OverlayPanel(arg_32_1, arg_32_2)
	arg_32_2 = arg_32_2 or {}
	arg_32_2.type = LayerWeightConst.UI_TYPE_SUB

	self:Add2Overlay(arg_32_1, arg_32_2)

	return
end

function BaseUI:BlurPanel(arg_33_1, arg_33_2)
	arg_33_2 = arg_33_2 or {}
	arg_33_2.type = LayerWeightConst.UI_TYPE_SUB
	arg_33_2.globalBlur = true

	self:Add2Overlay(arg_33_1, arg_33_2)

	return
end

function BaseUI:UnOverlayPanel(arg_34_1, arg_34_2)
	self:DelFromOverlay(arg_34_1, arg_34_2 or self.UIMain)

	return
end

function BaseUI:TempOverlayPanelPB(arg_35_1, arg_35_2)
	if not self.contextData then
		return
	end

	arg_35_2 = arg_35_2 or {}
	arg_35_2.groupName = self:getGroupName()

	pg.UIMgr.GetInstance():TempOverlayPanelPB(arg_35_1, arg_35_2)

	return
end

function BaseUI:TempUnOverlayPanelPB(arg_36_1, arg_36_2)
	if not self.contextData then
		return
	end

	pg.UIMgr.GetInstance():TempUnOverlayPanelPB(arg_36_1, arg_36_2)

	return
end

BaseUI.optionsPath = {
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

function BaseUI:onUILoaded(arg_37_1)
	self._go = arg_37_1
	self._tf = arg_37_1 and arg_37_1.transform

	self:Add2Overlay(self:getDefaultUI(), {
		type = LayerWeightConst.UI_TYPE_SYSTEM
	})
	pg.SeriesGuideMgr.GetInstance():dispatch({
		view = self.__cname
	})
	pg.NewStoryMgr.GetInstance():OnSceneEnter({
		view = self.__cname
	})

	self._isLoaded = true

	pg.DelegateInfo.New(self)

	self.optionBtns = {}

	for iter_37_0, iter_37_1 in ipairs(self.optionsPath) do
		table.insert(self.optionBtns, self._tf:Find(iter_37_1))
	end

	setActiveViaLayer(self._tf, true)
	bindComponent(self, self._go)
	self:init()
	self:emit(BaseUI.LOADED)

	return
end

function BaseUI:ResUISettings()
	return nil
end

function BaseUI:ShowOrHideResUI(arg_39_1)
	local var_39_0 = self:ResUISettings()

	if not var_39_0 then
		return
	end

	if var_39_0 == true then
		var_39_0 = {
			anim = true,
			showType = PlayerResUI.TYPE_ALL
		}
	end

	local var_39_1 = self:getGroupName()

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

function BaseUI:onUIAnimEnd(arg_40_1)
	arg_40_1()

	return
end

function BaseUI:init()
	return
end

function BaseUI:quickExitFunc()
	self:emit(BaseUI.ON_HOME)

	return
end

function BaseUI:quickExit()
	for iter_43_0, iter_43_1 in ipairs(self.optionBtns) do
		onButton(self, iter_43_1, function()
			self:quickExitFunc()

			return
		end, SFX_PANEL)
	end

	return
end

function BaseUI:enter()
	self:quickExit()
	self:PlayBGM()
	self:emit(BaseUI.DID_ENTER)

	if self:forceRatio() then
		pg.CameraFixMgr.GetInstance():SetForceRatio(self:forceRatio())
	end

	if not self._isCachedView then
		self:didEnter()
		self:ShowOrHideResUI(true)
	end

	if tobool(self:loadingQueue()) and self.contextData.resumeCallback then
		self.contextData.resumeCallback = nil

		self.contextData.resumeCallback()
	end

	self:emit(BaseUI.AVALIBLE)
	self:onUIAnimEnd(function()
		pg.SeriesGuideMgr.GetInstance():start({
			view = self.__cname,
			code = {
				pg.SeriesGuideMgr.CODES.MAINUI
			}
		})
		pg.NewGuideMgr.GetInstance():OnSceneEnter({
			view = self.__cname
		})

		return
	end)

	return
end

function BaseUI:closeView()
	if self.contextData.isLayer then
		self:emit(BaseUI.ON_CLOSE)
	else
		self:emit(BaseUI.ON_BACK)
	end

	return
end

function BaseUI:didEnter()
	return
end

function BaseUI:willExit()
	return
end

function BaseUI:exit()
	self.exited = true

	self:StopBgm()
	pg.DelegateInfo.Dispose(self)
	self:willExit()
	bindComponent(self, self._go, true)
	self:ShowOrHideResUI(false)
	self:DelFromOverlay(self:getDefaultUI())
	self:setLayerMgrRegister(false)
	self:detach()

	if self:forceRatio() then
		pg.CameraFixMgr.GetInstance():SetForceRatio(nil)
	end

	pg.NewGuideMgr.GetInstance():OnSceneExit({
		view = self.__cname
	})
	pg.NewStoryMgr.GetInstance():OnSceneExit({
		view = self.__cname
	})
	self:emit(BaseUI.DID_EXIT)

	return
end

function BaseUI:PlayUIAnimation(arg_51_1, arg_51_2, arg_51_3)
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

function BaseUI:attach(arg_53_1)
	return
end

function BaseUI:ClearTweens(arg_54_1)
	self:cleanManagedTween(arg_54_1)

	return
end

function BaseUI:detach(arg_55_1)
	self._isLoaded = false

	pg.DynamicBgMgr.GetInstance():ClearBg(self:getUIName())
	self:disposeEvent()
	self:ClearTweens(false)

	self._tf = nil

	local var_55_0 = self:getUIName()

	if self._go ~= nil and var_55_0 then
		PoolMgr.GetInstance():ReturnUI(var_55_0, self._go)

		self._go = nil
	end

	return
end

function BaseUI:getTpl(arg_56_1, arg_56_2)
	local var_56_0 = (arg_56_2 or self._tf):Find(arg_56_1)

	var_56_0:SetParent(self._tf, false)
	SetActive(var_56_0, false)

	return var_56_0
end

function BaseUI:setSpriteTo(arg_57_1, arg_57_2, arg_57_3)
	local var_57_0 = arg_57_2:GetComponent(typeof(Image))

	var_57_0.sprite = self._tf:Find(arg_57_1):GetComponent(typeof(Image)).sprite

	if arg_57_3 then
		var_57_0:SetNativeSize()
	end

	return
end

function BaseUI:setImageAmount(arg_58_1, arg_58_2)
	arg_58_1:GetComponent(typeof(Image)).fillAmount = arg_58_2

	return
end

function BaseUI:setVisible(arg_59_1)
	self:ShowOrHideResUI(arg_59_1)

	if arg_59_1 then
		self:OnVisible()
	else
		self:OnDisVisible()
	end

	setActiveViaLayer(self._tf, arg_59_1)

	return
end

function BaseUI:OnVisible()
	return
end

function BaseUI:OnDisVisible()
	return
end

function BaseUI:onBackPressed()
	self:emit(BaseUI.ON_BACK_PRESSED)

	return
end

return BaseUI
