local UICommonActivityLogin = class("UICommonActivityLogin", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UICommonActivityLogin:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Background, self, self.OnActivityBtnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnActivityBtnCloseClicked)
  UIUtil.AddValueChangedListener(self.ui.tog_Popup, self, self.OnReadOnePopupChanged)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  self.resloader = CS.ResLoader.Create()
end

function UICommonActivityLogin:InitActivityLoginUI(loginPopupUiCfg)
  self.__loginPopupUiCfg = loginPopupUiCfg
  local prefabPath = PathConsts:GetUIPrefabPath("ActivityLoginInHolder/" .. self.__loginPopupUiCfg.login_prefab)
  self.resloader:LoadABAssetAsync(prefabPath, function(prefab)
    if IsNull(prefab) then
      return
    end
    if loginPopupUiCfg ~= self.__loginPopupUiCfg then
      return
    end
    local go = prefab:Instantiate()
    self:__InitActivityGameObject(go)
  end)
  local systemSaveData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
  self.ui.tog_Popup.isOn = systemSaveData:GetActEntranceReadOneValue()
  self.ui.tog_Popup.gameObject:SetActive(not loginPopupUiCfg.ishide)
end

function UICommonActivityLogin:__InitActivityGameObject(go)
  go.transform:SetParent(self.ui.activityHolder)
  go.transform.localScale = Vector3.one
  go.transform.anchoredPosition3D = Vector3.zero
  self.contentui = {}
  UIUtil.LuaUIBindingTable(go.transform, self.contentui)
  if self.contentui.jumpBtn ~= nil then
    UIUtil.AddButtonListener(self.contentui.jumpBtn, self, self.OnClickJump)
  end
  if self.lateJumpFunc ~= nil then
    self.lateJumpFunc()
  end
  if self.lateTimeFunc ~= nil then
    self.lateTimeFunc()
  end
  if self.__loginPopupUiCfg.item_icon <= 0 then
    return
  end
  local itemCfg = ConfigData.item[self.__loginPopupUiCfg.item_icon]
  if itemCfg == nil then
    error("item cfg is null,id:" .. tostring(self.__loginPopupUiCfg.item_icon))
    return
  end
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.contentui.baseItem)
  self.baseItem:SetNotNeedAnyJump(true)
  self.baseItem:InitBaseItem(itemCfg)
end

function UICommonActivityLogin:SetJumpFunc(func)
  function self.lateJumpFunc()
    if not IsNull(self.contentui.jumpBtn.gameObject) then
      self._jumpCallback = func
    end
  end
end

function UICommonActivityLogin:SetTimeId(isShop, shopId)
  function self.lateTimeFunc()
    if IsNull(self.contentui.tex_time.gameObject) then
      return
    end
    if isShop == false then
      return
    end
    local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    if not shopCtrl:GetIsThisShopHasTimeLimit(shopId) then
      return
    end
    self:ClearTimeId()
    
    local function timeCut()
      local hasLimit, startTime, endTime = shopCtrl:GetIsThisShopHasTimeLimit(shopId)
      if not hasLimit then
        UIUtil.OnClickBackByUiTab(self)
        return
      end
      local remaindTime = endTime - PlayerDataCenter.timestamp
      local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
      if remaindTime < 0 then
        UIUtil.OnClickBackByUiTab(self)
        return
      end
      if 0 < d then
        self.contentui.tex_time:SetIndex(0, tostring(d), tostring(h), tostring(m))
      elseif 0 < h then
        self.contentui.tex_time:SetIndex(1, tostring(h), tostring(m))
      elseif 0 < m then
        self.contentui.tex_time:SetIndex(2, tostring(m), tostring(s))
      else
        self.contentui.tex_time:SetIndex(3, tostring(s))
      end
    end
    
    self._timerID = TimerManager:StartTimer(1, timeCut, self, false, false, false)
    timeCut()
  end
end

function UICommonActivityLogin:SetIgnoreExtraPopupUI()
  self.ui.btn_Close.gameObject:SetActive(false)
  self.ui.tog_Popup.gameObject:SetActive(false)
end

function UICommonActivityLogin:OnClickJump()
  if self._jumpCallback ~= nil then
    local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
    if homeCtrl ~= nil then
      homeCtrl:OnAutoShowOver()
    end
    UIUtil.OnClickBackByUiTab(self)
    self._jumpCallback()
  end
end

function UICommonActivityLogin:BackAction()
  self:Delete()
  if self.__closeCallback ~= nil then
    local action = self.__closeCallback
    self.__closeCallback = nil
    action()
  end
end

function UICommonActivityLogin:SetCloseCallback(callback)
  self.__closeCallback = callback
end

function UICommonActivityLogin:OnActivityBtnCloseClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UICommonActivityLogin:OnReadOnePopupChanged(value)
  local systemSaveData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
  systemSaveData:SetActEntranceReadOneValue(value)
end

function UICommonActivityLogin:ClearTimeId()
  if self._timerID ~= nil then
    TimerManager:StopTimer(self._timerID)
    self._timerID = nil
  end
end

function UICommonActivityLogin:OnDelete()
  if self.__loginPopupUiCfg ~= nil and self.ui.tog_Popup.isOn then
    local showTime = math.floor(PlayerDataCenter.timestamp)
    local userSaveData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userSaveData:SaveActEntranceLastShow(self.__loginPopupUiCfg.id, showTime)
  end
  PersistentManager:SaveModelData(PersistentConfig.ePackage.SystemData)
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self:ClearTimeId()
  base.OnDelete(self)
end

return UICommonActivityLogin
