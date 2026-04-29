_class("UITrailLevelController", UIController)
UITrailLevelController = UITrailLevelController

function UITrailLevelController:LoadDataOnEnter(TT, res, uiParams)
  self._talePetModule = GameGlobal.GetModule(TalePetModule)
  self._talePetModule:RequestServerFormationList(TT)
  local ctx = self:GetModule(MissionModule):TeamCtx()
  ctx:InitTrailTeam(self._talePetModule:GetFormationList())
  local ret = self._talePetModule:RequestTrailLevelData(TT)
  if ret ~= 0 then
    res.m_result = ret
    return
  end
  local maxLevel = 1
  self._buffLevel, maxLevel = self._talePetModule:GetBuffLevel()
  self._levelLayerDatas = {}
  local layerCfgs = Cfg.cfg_tale_stage_layer({})
  for i = 1, #layerCfgs do
    local layerCfg = layerCfgs[i]
    local levelLayerData = UITrailLevelLayerData:New(layerCfg)
    self._levelLayerDatas[#self._levelLayerDatas + 1] = levelLayerData
  end
  self._currentSelectLayer = nil
end

function UITrailLevelController:OnShow(uiParams)
  self._isFirstEnter = true
  self._isSwitchStatus = uiParams[1] and true
  self._anim = self:GetUIComponent("Animation", "Anim")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    if self._isSwitchStatus then
      local callState = self._talePetModule:GetCurCallState()
      if callState then
        self:SwitchState(UIStateType.UITalePetCollect, callState, true)
      else
        self:SwitchState(UIStateType.UITalePetList, true)
      end
      self:SwitchState(UIStateType.UIMain)
    else
      self:CloseDialog()
    end
  end, function()
    self:ShowDialog("UIHelpController", "UITrailLevelController")
  end)
  self._buffNameLabel = self:GetUIComponent("UILocalizationText", "BuffName")
  self._buffLevelLabel = self:GetUIComponent("UILocalizationText", "BuffLevel")
  self._buffIconImg = self:GetUIComponent("RawImageLoader", "BuffIcon")
  self._rewardRedGo = self:GetGameObject("RewardRed")
  local rewardBtn = self:GetGameObject("RewardBtn")
  self._rewardBtnClickedGo = self:GetGameObject("RewardBtnClicked")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(rewardBtn), UIEvent.Press, function(go)
    self._rewardBtnClickedGo:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(rewardBtn), UIEvent.Release, function(go)
    self._rewardBtnClickedGo:SetActive(false)
  end)
  self:AttachEvent(GameEventType.TalePetTrailLevelRewardChange, self.RefreshRewardInfo)
  self:RefreshBuffInfo()
  self:InitLevelList()
  self:RefreshRewardInfo()
  UIBgmHelper.PlayMainBgm()
end

function UITrailLevelController:OnHide()
  self:DetachEvent(GameEventType.TalePetTrailLevelRewardChange, self.RefreshRewardInfo)
end

function UITrailLevelController:RefreshRewardInfo()
  self._rewardRedGo:SetActive(self._talePetModule:IsShowRewardRed())
end

function UITrailLevelController:RefreshBuffInfo()
  local cfg = Cfg.cfg_trail_level_buff_level[self._buffLevel]
  self._buffNameLabel:SetText(StringTable.Get(cfg.BuffName))
  self._buffLevelLabel:SetText(StringTable.Get("str_tale_pet_trail_level_buff_level", self._buffLevel))
  self._buffIconImg:LoadImage(cfg.BuffIcon)
end

function UITrailLevelController:InitLevelList()
  self._maxLevelCount = 4
  self._levelItem = {}
  for i = 1, self._maxLevelCount do
    local level = self:GetUIComponent("UISelectObjectPath", "Level" .. i)
    local levelItem = level:SpawnObject("UITrailLevelItem")
    levelItem:Refresh()
    self._levelItem[#self._levelItem + 1] = levelItem
  end
  local bossLevel = self:GetUIComponent("UISelectObjectPath", "BossLevel")
  self._bossLevelItem = bossLevel:SpawnObject("UITrailLevelFinalItem")
  self._bossLevelItem:Refresh()
  local layer = self:GetUIComponent("UISelectObjectPath", "Layer")
  layer:SpawnObjects("UITrailLevelLayerItem", #self._levelLayerDatas)
  local layerItems = layer:GetAllSpawnList()
  local defaultLevelLayerData = self._levelLayerDatas[1]
  local defaultLevelLayerItem = layerItems[1]
  self._layerItems = layerItems
  local hasFind = false
  local isOpenFinalLayer = self._talePetModule:HasOpenFinalLevel()
  for i = 1, #layerItems do
    local levelLayerData = self._levelLayerDatas[i]
    local layerItem = layerItems[i]
    layerItem:Refresh(levelLayerData, self)
    local layerType = levelLayerData:GetLayerType()
    local isOpen = layerType == TrailLevelLayerType.Normal or layerType == TrailLevelLayerType.Final and isOpenFinalLayer
    if hasFind == false and levelLayerData and isOpen then
      local levelDatas = levelLayerData:GetLevelDatas()
      if levelDatas then
        for j = 1, #levelDatas do
          local levelData = levelDatas[j]
          if not levelData:IsComplete() then
            defaultLevelLayerData = levelLayerData
            defaultLevelLayerItem = layerItem
            hasFind = true
            break
          end
        end
      end
    end
  end
  self:Lock("UITrailLevelController_PlayEnterAnim")
  GameGlobal.TaskManager():StartTask(self.PlayEnterAnim, self, defaultLevelLayerItem)
  self:OnLevelLayerItemSelect(defaultLevelLayerItem, defaultLevelLayerData, true)
end

function UITrailLevelController:PlayEnterAnim(TT, levelLayerItem)
  for i = 1, #self._layerItems do
    self._layerItems[i]:HideSelf()
  end
  for i = 1, #self._layerItems do
    local item = self._layerItems[i]
    item:PlayEnterAnim(levelLayerItem == item)
    YIELD(TT)
  end
  self:UnLock("UITrailLevelController_PlayEnterAnim")
end

function UITrailLevelController:OnLevelLayerItemSelect(levelLayerItem, levelLayerData, isEnter)
  if levelLayerData:GetLayerType() == TrailLevelLayerType.Final and not self._talePetModule:HasOpenFinalLevel() then
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_trail_level_level_un_open"))
    return
  end
  self:Lock("UITrailLevelController_PlayShowLevelAnim")
  GameGlobal.TaskManager():StartTask(self.PlayShowLevelAnim, self, levelLayerItem, levelLayerData, isEnter)
end

function UITrailLevelController:PlayShowLevelAnim(TT, levelLayerItem, levelLayerData, isEnter)
  if self._currentSelectLayer == levelLayerItem then
    self:UnLock("UITrailLevelController_PlayShowLevelAnim")
    return
  end
  if self._currentSelectLayer then
    self._currentSelectLayer:UnSelect(isEnter)
  end
  self._currentSelectLayer = levelLayerItem
  if self._currentSelectLayer then
    self._currentSelectLayer:Select(isEnter)
  end
  local levelDatas = levelLayerData:GetLevelDatas()
  if levelLayerData:GetLayerType() == TrailLevelLayerType.Normal then
    self:ShowFinalLayer(false)
    self._anim:Play("uieff_UITrailLevelController_in")
    self._bossLevelItem:Refresh()
    for i = 1, #self._levelItem do
      self._levelItem[i]:Refresh(levelDatas[i])
      YIELD(TT)
      YIELD(TT)
    end
    YIELD(TT, 480)
  elseif levelLayerData:GetLayerType() == TrailLevelLayerType.Final then
    self:ShowFinalLayer(true)
    for i = 1, #self._levelItem do
      self._levelItem[i]:Refresh()
    end
    self._bossLevelItem:Refresh(levelDatas[1])
    if self._isFirstEnter then
      self._anim:Play("uieff_UITrailLevelController_Final")
      self._isFirstEnter = false
      YIELD(TT, 3500)
    else
      self._anim:Play("uieff_UITrailLevelController_Final_2")
      YIELD(TT, 700)
    end
  end
  self:UnLock("UITrailLevelController_PlayShowLevelAnim")
end

function UITrailLevelController:BuffBtnOnClick()
  self:ShowDialog("UITrailLevelBuffDes")
end

function UITrailLevelController:RewardBtnOnClick()
  self:ShowDialog("UITrailLevelRewardController")
end

function UITrailLevelController:ShowFinalLayer(isShowFinalLayer)
  local bg1 = self:GetGameObject("Bg1")
  local bg2 = self:GetGameObject("Bg2")
  local bg3 = self:GetGameObject("Bg3")
  local bg4 = self:GetGameObject("Bg4")
  local bg5 = self:GetGameObject("Bg5")
  local finalBg1 = self:GetGameObject("FinalBg1")
  local finalBg2 = self:GetGameObject("FinalBg2")
  local finalBg3 = self:GetGameObject("FinalBg3")
  if isShowFinalLayer then
    bg1:SetActive(false)
    bg2:SetActive(false)
    bg3:SetActive(false)
    bg4:SetActive(false)
    bg5:SetActive(false)
    finalBg1:SetActive(true)
    finalBg2:SetActive(true)
    finalBg3:SetActive(true)
  else
    bg1:SetActive(true)
    bg2:SetActive(true)
    bg3:SetActive(true)
    bg4:SetActive(true)
    bg5:SetActive(true)
    finalBg1:SetActive(false)
    finalBg2:SetActive(false)
    finalBg3:SetActive(false)
  end
end
