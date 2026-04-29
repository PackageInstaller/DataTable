_class("UIAircraftItemSmeltController", UIController)
UIAircraftItemSmeltController = UIAircraftItemSmeltController

function UIAircraftItemSmeltController:OnShow(uiParams)
  self:InitWidget()
  self:InitDataUpdater()
  self._roleModule = self:GetModule(RoleModule)
  self._missionModule = self:GetModule(MissionModule)
  self._airModule = self:GetModule(AircraftModule)
  self._smeltRoom = self._airModule:GetSmeltRoom()
  self._atomDiscount = self._smeltRoom:AtomDiscount()
  local topWidget = self.topButton:SpawnObject("UICommonTopButton")
  topWidget:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIHelpController", "UIAircraftSmeltRoom")
  end, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
  end)
  if GameGlobal.UIStateManager():IsShow("UIItemGetPathController") then
    GameGlobal.UIStateManager():CloseDialog("UIItemGetPathController")
  end
  local tab1s = Cfg.cfg_aircraft_smelt_tab1({})
  table.sort(tab1s, function(a, b)
    return a.Index < b.Index
  end)
  self.tabs:SpawnObjects("UIAircraftSmeltTab", #tab1s)
  self._1stTabWidgets = {}
  local _1stWidgets = self.tabs:GetAllSpawnList()
  
  local function tab1Click(id)
    self:OnTypeChanged(id)
  end
  
  local _count = #tab1s
  for i = 1, _count do
    local widget = _1stWidgets[i]
    local data = tab1s[_count - i + 1]
    widget:SetData(data, tab1Click)
    self._1stTabWidgets[data.ID] = widget
  end
  self._tab1IDs = {}
  for i, cfg in ipairs(tab1s) do
    self._tab1IDs[i] = cfg.ID
  end
  self._topTipID = {}
  for i, cfg in ipairs(tab1s) do
    local id = cfg.ID
    local toptips = {}
    for i, asset in ipairs(cfg.TopTips) do
      toptips[i] = asset
    end
    self._topTipID[id] = toptips
  end
  self:OpenJump(uiParams[1], uiParams[2])
  self:AttachEvent(GameEventType.AircraftOnAtomChanged, self.OnAtomChanged)
  self:AttachEvent(GameEventType.AircraftOnFireFlyChanged, self.OnFireflyChanged)
end

function UIAircraftItemSmeltController:OnHide()
  if self.d_dataUpdater then
    GameGlobal.Timer():CancelEvent(self.d_dataUpdater)
    self.d_dataUpdater = nil
  end
end

function UIAircraftItemSmeltController:OpenJump(goodsId, targetNum, jumpFromSelf)
  if goodsId then
    local jumpID = goodsId
    local targetCfg
    local allCfgs = Cfg.cfg_item_smelt({})
    for _, cfg in pairs(allCfgs) do
      if cfg.Output[1] == jumpID then
        targetCfg = cfg
        break
      end
    end
    if not targetCfg then
      AirError("找不到跳转ID:", jumpID)
    end
    local targetTab2Cfg = Cfg.cfg_aircraft_smelt_tab2[targetCfg.Tab]
    self:OnTypeChanged(targetTab2Cfg.Tab1)
    if self._1stTabWidgets[self._tab1]:UIType() == SmeltRoomUIType.Resolve then
      AirError("策划配置错误, 分解材料不支持跳转：", jumpID)
    elseif self._1stTabWidgets[self._tab1]:UIType() == SmeltRoomUIType.Compond then
      self._compound:JumpTo(targetCfg.ID, targetNum, jumpFromSelf)
    elseif self._1stTabWidgets[self._tab1]:UIType() == SmeltRoomUIType.Camp then
      self._camp:JumpTo(targetCfg.ID)
    end
  else
    self:OnTypeChanged(self._tab1IDs[1])
  end
end

function UIAircraftItemSmeltController:InitWidget()
  self.topButton = self:GetUIComponent("UISelectObjectPath", "TopButton")
  self.topCurrency = self:GetUIComponent("UISelectObjectPath", "TopCurrency")
  self.tabs = self:GetUIComponent("UISelectObjectPath", "Tabs")
  self._compoundLoader = self:GetUIComponent("UISelectObjectPath", "Compound")
  self._resolveLoader = self:GetUIComponent("UISelectObjectPath", "Resolve")
  self._campLoader = self:GetUIComponent("UISelectObjectPath", "Camp")
  self._selectInfo = self:GetUIComponent("UISelectObjectPath", "SelectInfo")
end

function UIAircraftItemSmeltController:OnTypeChanged(tabID)
  if self._tab1 == tabID then
    return
  end
  if self._tab1 then
    self._1stTabWidgets[self._tab1]:Cancel()
  end
  self._tab1 = tabID
  self._1stTabWidgets[self._tab1]:Select()
  local uiType = self._1stTabWidgets[self._tab1]:UIType()
  if uiType == SmeltRoomUIType.Resolve then
    if not self._resolve then
      self._resolve = self._resolveLoader:SpawnObject("UIAircraftResolve")
    end
    if self._compound then
      self._compound:SetShow(false)
    end
    if self._camp then
      self._camp:SetShow(false)
    end
    self._resolve:SetData(self._tab1, function(id, pos)
      self:ShowSelectInfo(id, pos)
    end)
    self._resolve:SetShow(true)
  elseif uiType == SmeltRoomUIType.Compond then
    if not self._compound then
      self._compound = self._compoundLoader:SpawnObject("UIAircraftCompound")
    end
    if self._resolve then
      self._resolve:SetShow(false)
    end
    if self._camp then
      self._camp:SetShow(false)
    end
    self._compound:SetData(self._tab1)
    self._compound:SetShow(true)
  elseif uiType == SmeltRoomUIType.Camp then
    if self._resolve then
      self._resolve:SetShow(false)
    end
    if self._compound then
      self._compound:SetShow(false)
    end
    if not self._camp then
      self._camp = self._campLoader:SpawnObject("UIAircraftCamp")
    end
    self._camp:SetData(self._tab1)
    self._camp:SetShow(true)
  else
    Log.exception("Tab1类型错误:", self._tab1)
  end
  self._topTips = self.topCurrency:SpawnObject("UICurrencyMenu")
  self._topTips:SetData(self._topTipID[self._tab1])
  local atom = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetAtom)
  if atom then
    atom:SetAddCallBack(function()
      self:ShowDialog("UISmeltAtomExchangeController")
    end)
    self:OnAtomChanged()
  end
  local firefly = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  if firefly then
    firefly:CloseAddBtn()
    self:OnFireflyChanged()
  end
end

function UIAircraftItemSmeltController:OnAtomChanged()
  local atom = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetAtom)
  if atom then
    atom:SetText(math.floor(self._roleModule:GetAtom()) .. "/" .. math.floor(self._smeltRoom:GetStorageMax()))
  end
end

function UIAircraftItemSmeltController:OnFireflyChanged()
  local firefly = self._topTips:GetItemByTypeId(RoleAssetID.RoleAssetFirefly)
  if firefly then
    firefly:SetText(self._airModule:GetFirefly() .. "/" .. math.floor(self._airModule:GetMaxFirefly()))
  end
end

function UIAircraftItemSmeltController:ShowSelectInfo(id, pos)
  if not self._itemTips then
    self._itemTips = self._selectInfo:SpawnObject("UISelectInfo")
  end
  self._itemTips:SetData(id, pos)
end

function UIAircraftItemSmeltController:InitDataUpdater()
  local airController = GameGlobal.UIStateManager():GetController("UIAircraftController")
  if airController then
    return
  end
  local airModule = GameGlobal.GetModule(AircraftModule)
  local d_curFireFly = math.floor(airModule:GetFirefly())
  local d_atom = GameGlobal.GetModule(RoleModule):GetAtom()
  local roleModule = GameGlobal.GetModule(RoleModule)
  self.d_dataUpdater = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    if roleModule == nil or airModule == nil or airModule:GetAircraftInfo() == nil then
      return
    end
    local curFire = math.floor(airModule:GetFirefly())
    if curFire ~= d_curFireFly then
      d_curFireFly = curFire
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftOnFireFlyChanged)
    end
    if airModule:GetSmeltRoom() then
      local count = roleModule:GetAtom()
      if count ~= d_atom then
        d_atom = count
        GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftOnAtomChanged)
      end
    end
  end)
end

local AirItemErrorCode = {
  None = 0,
  Zero = 2,
  NotEnough = 4,
  SNotEnough = 8,
  FireflyOverflow = 16
}
_enum("AirItemErrorCode", AirItemErrorCode)
