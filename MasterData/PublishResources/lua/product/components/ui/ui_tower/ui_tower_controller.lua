_class("UITowerController", UIController)
UITowerController = UITowerController

function UITowerController:LoadDataOnEnter(TT, res)
  local module = self:GetModule(TowerModule)
  local result, data = module:ReqPlayerTowerData(TT)
  if result:GetSucc() then
    Log.notice("[Tower] 请求尖塔数据成功，打开ui")
    res:SetSucc(true)
  else
    ToastManager.ShowToast(module:GetErrorMsg(result:GetResult()))
    res:SetSucc(false)
  end
end

function UITowerController:OnShow(uiParams)
  local cfgID = uiParams[1]
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:SwitchState(UIStateType.UIDiscovery)
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, nil, nil)
  local passAward = self:GetUIComponent("UISelectObjectPath", "PassAward")
  self._passAwardObj = self:GetGameObject("PassAward")
  self._passAwardWidget = passAward:SpawnObject("UITowerPassAwardEntrance")
  self._passAwardWidget:SetData()
  self:InitWidget()
  self._module = self:GetModule(TowerModule)
  self.waterTower = self.water:SpawnObject("UITowerInfoItem")
  self.fireTower = self.fire:SpawnObject("UITowerInfoItem")
  self.woodTower = self.wood:SpawnObject("UITowerInfoItem")
  self.thunderTower = self.thunder:SpawnObject("UITowerInfoItem")
  local mRole = GameGlobal.GetModule(RoleModule)
  local psdId = mRole:GetPstId()
  local key = "UITowerDiffcult" .. psdId
  if LocalDB.GetInt(key, 0) == 1 then
    self.click = false
    self:SetDiffclut()
  else
    self.click = true
    self:SetNormal()
  end
  if cfgID then
    self:ShowTower(cfgID)
  end
  self._module = self:GetModule(TowerModule)
  local showLevel = Cfg.cfg_global.difficulty_tower_show_level.IntValue
  for i = 1, 4 do
    local cur = self._module:GetTowerLayer(i)
    if showLevel > cur then
      self._passShowLevel = false
    else
      self._passShowLevel = true
      break
    end
  end
  self.change:SetActive(self._passShowLevel)
  for i = 1, 4 do
    local ceiling = self._module:GetTowerCeiling(i)
    local cur = self._module:GetTowerLayer(i)
    if ceiling > cur then
      self._passAllTower = false
      break
    else
      self._passAllTower = true
    end
  end
end

function UITowerController:ShowTower(id)
  local cfg = Cfg.cfg_tower_detail[id]
  if cfg == nil then
    Log.exception("[Tower] 尖塔初始化参数错误，不能默认打开尖塔。id:", id)
    return
  end
  self:SwitchState(UIStateType.UITowerLayer, cfg.Type)
end

function UITowerController:OnHide()
end

function UITowerController:InitWidget()
  self.water = self:GetUIComponent("UISelectObjectPath", "water")
  self.fire = self:GetUIComponent("UISelectObjectPath", "fire")
  self.wood = self:GetUIComponent("UISelectObjectPath", "wood")
  self.thunder = self:GetUIComponent("UISelectObjectPath", "thunder")
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self.icon = self:GetUIComponent("Image", "icon")
  self.change = self:GetGameObject("Change")
  self.changeRT = self:GetUIComponent("RectTransform", "Change")
  self.bg = self:GetUIComponent("RawImageLoader", "bg")
  self.btmMask = self:GetGameObject("BtmMask")
  self.atlas = self:GetAsset("UITower.spriteatlas", LoadType.SpriteAtlas)
end

function UITowerController:GetBtn(index)
  if index == 1 then
    return self.waterTower:GetGameObject("Image")
  elseif index == 2 then
    return self.fireTower:GetGameObject("Image")
  elseif index == 3 then
    return self.woodTower:GetGameObject("Image")
  elseif index == 4 then
    return self.thunderTower:GetGameObject("Image")
  end
end

function UITowerController:Clear()
  self.water:ClearWidgets()
  self.fire:ClearWidgets()
  self.wood:ClearWidgets()
  self.thunder:ClearWidgets()
  self.waterTower = self.water:SpawnObject("UITowerInfoItem")
  self.fireTower = self.fire:SpawnObject("UITowerInfoItem")
  self.woodTower = self.wood:SpawnObject("UITowerInfoItem")
  self.thunderTower = self.thunder:SpawnObject("UITowerInfoItem")
end

function UITowerController:SetNormal()
  self._passAwardObj:SetActive(true)
  self.txt:SetText(StringTable.Get("str_tower_normal_model"))
  self.icon.sprite = self.atlas:GetSprite("ht_gqxq_di10")
  self.bg:LoadImage("tower_xuanze_bg")
  self.btmMask:SetActive(false)
  self.waterTower:SetData(TowerElementType.TowerElementType_Blue)
  self.fireTower:SetData(TowerElementType.TowerElementType_Red)
  self.woodTower:SetData(TowerElementType.TowerElementType_Green)
  self.thunderTower:SetData(TowerElementType.TowerElementType_Yellow)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.changeRT)
end

function UITowerController:SetDiffclut()
  self._passAwardObj:SetActive(false)
  self.txt:SetText(StringTable.Get("str_tower_diffcult_model"))
  self.icon.sprite = self.atlas:GetSprite("ht_gqxq_di09")
  self.bg:LoadImage("ht_gqxq_di01")
  self.btmMask:SetActive(true)
  self.waterTower:SetData(TowerElementType.TowerElementType_Difficulty_Blue)
  self.fireTower:SetData(TowerElementType.TowerElementType_Difficulty_Red)
  self.woodTower:SetData(TowerElementType.TowerElementType_Difficulty_Green)
  self.thunderTower:SetData(TowerElementType.TowerElementType_Difficulty_Yellow)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.changeRT)
end

function UITowerController:Change()
  local mRole = GameGlobal.GetModule(RoleModule)
  local psdId = mRole:GetPstId()
  local key = "UITowerDiffcult" .. psdId
  if self.click then
    LocalDB.SetInt(key, 1)
    self:Clear()
    self:SetDiffclut()
    self.click = false
  else
    LocalDB.SetInt(key, 0)
    self:Clear()
    self:SetNormal()
    self.click = true
  end
end

function UITowerController:ChangeOnClick()
  if self._passAllTower then
    self:Change()
  else
    ToastManager.ShowToast(StringTable.Get("str_tower_not_open_tips"))
  end
end
