local TowerDefenseCharacterFuncCtrl = class("TowerDefenseCharacterFuncCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local normalLevelUpTextColor = Color(0.21176470588235294, 0.24705882352941178, 0.3058823529411765)
local lockLevelUpTextColor = Color(0.7411764705882353, 0.18823529411764706, 0.34901960784313724)
TowerDefenseCharacterFuncCtrl._mapNodeConfig = {
  btn_close = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  },
  go_func = {nCount = 6}
}
TowerDefenseCharacterFuncCtrl._mapEventConfig = {
  TowerDefenseCharacterCharacterLevelUp = "OnEvent_LevelUp",
  TOWERDEFENSE_UPDATE_LEVELUP = "OnEvent_LevelUpPointChange"
}
TowerDefenseCharacterFuncCtrl._mapRedDotConfig = {}

function TowerDefenseCharacterFuncCtrl:Awake()
  self.UseFuncGo = {}
  self.UnUseFuncGo = {}
  for _, go_func in pairs(self._mapNode.go_func) do
    table.insert(self.UnUseFuncGo, go_func)
    go_func:SetActive(false)
  end
  self._mapNode.btn_close.gameObject:SetActive(false)
  GamepadUIManager.AddGamepadUINode("TowerDefense", self:GetGamepadUINode())
  self.bIsShowLevelBtn = true
end

function TowerDefenseCharacterFuncCtrl:SetLevelBtnState(bIsShow)
  self.bIsShowLevelBtn = bIsShow
end

function TowerDefenseCharacterFuncCtrl:SetData(levelData)
  self.TowerDefenseLevelData = levelData
end

function TowerDefenseCharacterFuncCtrl:BindFuncIcon(characterId, uiPos, detailCallback, levelupCallback, henshinCallback)
  if self.UseFuncGo[characterId] ~= nil then
    return
  end
  local go = self.UnUseFuncGo[1]
  table.remove(self.UnUseFuncGo, 1)
  self.UseFuncGo[characterId] = go
  local rectTran = go:GetComponent("RectTransform")
  rectTran.anchoredPosition = Vector2(uiPos.x, uiPos.y - 18)
  go:SetActive(false)
  local btn_detail = go.transform:Find("btn_detail"):GetComponent("NaviButton")
  local btn_LevelUp = go.transform:Find("btn_levelUp"):GetComponent("NaviButton")
  local btn_henshin = go.transform:Find("btn_henshin"):GetComponent("NaviButton")
  btn_detail.onClick:RemoveAllListeners()
  btn_LevelUp.onClick:RemoveAllListeners()
  btn_henshin.onClick:RemoveAllListeners()
  btn_detail.onClick:AddListener(detailCallback)
  btn_LevelUp.onClick:AddListener(levelupCallback)
  btn_henshin.onClick:AddListener(henshinCallback)
  local tbGamepadUINode = {
    [1] = {
      mapNode = btn_detail,
      sComponentName = "NaviButton",
      sAction = "TowerDefCharInfo"
    },
    [2] = {
      mapNode = btn_LevelUp,
      sComponentName = "NaviButton",
      sAction = "TowerDefCharLvUp"
    },
    [3] = {
      mapNode = btn_henshin,
      sComponentName = "NaviButton",
      sAction = "TowerDefCharHenshin"
    }
  }
  GamepadUIManager.AddGamepadUINode("TowerDefense", tbGamepadUINode)
end

function TowerDefenseCharacterFuncCtrl:HideIcon()
  if self.nCharacterId == 0 then
    return
  end
  if self.UseFuncGo[self.nCharacterId] == nil then
    return
  end
  local go = self.UseFuncGo[self.nCharacterId]
  local btn_detail = go.transform:Find("btn_detail"):GetComponent("NaviButton")
  local btn_LevelUp = go.transform:Find("btn_levelUp"):GetComponent("NaviButton")
  local btn_henshin = go.transform:Find("btn_henshin"):GetComponent("NaviButton")
  NovaAPI.SetNaviButtonAction(btn_detail, false)
  NovaAPI.SetNaviButtonAction(btn_LevelUp, false)
  NovaAPI.SetNaviButtonAction(btn_henshin, false)
  self._mapNode.btn_close.gameObject:SetActive(false)
  local animator = go:GetComponent("Animator")
  animator:Play("go_CharFunc_out")
  self:AddTimer(1, 0.13, function()
    go:SetActive(false)
  end, true, true, true)
  EventManager.Hit("TowerDefenseFuncShow", false, self.nCharacterId)
  self.nCharacterId = 0
end

function TowerDefenseCharacterFuncCtrl:ShowIcon(characterId)
  self.nCharacterId = characterId
  if self.UseFuncGo[characterId] == nil then
    return
  end
  local go = self.UseFuncGo[characterId]
  local btn_LevelUp = go.transform:Find("btn_levelUp")
  local level = self.TowerDefenseLevelData:GetCharacterLevel(self.nCharacterId)
  if level == nil then
    return
  end
  local config = ConfigTable.GetData("TowerDefenseCharacter", self.nCharacterId)
  if config == nil then
    return
  end
  local btn_henshin = go.transform:Find("btn_henshin")
  btn_henshin.gameObject:SetActive(false)
  if level < 6 then
    if not self.bIsShowLevelBtn then
      btn_LevelUp.gameObject:SetActive(false)
    else
      btn_LevelUp.gameObject:SetActive(true)
      local icon_levelUp = go.transform:Find("btn_levelUp/AnimRoot/img_levelUp")
      local icon_lock = go.transform:Find("btn_levelUp/AnimRoot/img_lock")
      local txt_costPoint = go.transform:Find("btn_levelUp/AnimRoot/img_point/txt_needPoint")
      NovaAPI.SetTMPText(txt_costPoint:GetComponent("TMP_Text"), config.PointNeeded[level])
      icon_levelUp.gameObject:SetActive(not (config.PointNeeded[level] > self.point))
      icon_lock.gameObject:SetActive(config.PointNeeded[level] > self.point)
      btn_LevelUp:GetComponent("NaviButton").interactable = not (config.PointNeeded[level] > self.point)
      if config.PointNeeded[level] > self.point then
        NovaAPI.SetTMPColor(txt_costPoint:GetComponent("TMP_Text"), lockLevelUpTextColor)
      else
        NovaAPI.SetTMPColor(txt_costPoint:GetComponent("TMP_Text"), normalLevelUpTextColor)
      end
    end
  else
    btn_LevelUp.gameObject:SetActive(false)
    if config.IsShapeshifter then
      btn_henshin.gameObject:SetActive(true)
    end
  end
  go:SetActive(true)
  self._mapNode.btn_close.gameObject:SetActive(true)
  local animator = go:GetComponent("Animator")
  animator:Play("go_CharFunc_in")
  local txt_animator = go.transform:Find("btn_levelUp/AnimRoot"):GetComponent("Animator")
  if level < 6 then
    if config.PointNeeded[level] > self.point then
      txt_animator:Play("btn_levelUp_Unlock")
    else
      txt_animator:Play("New State")
    end
  else
    txt_animator:Play("New State")
  end
  EventManager.Hit("TowerDefenseFuncShow", true, self.nCharacterId)
end

function TowerDefenseCharacterFuncCtrl:UpdateFunc(characterId, go)
  local level = self.TowerDefenseLevelData:GetCharacterLevel(characterId)
  local config = ConfigTable.GetData("TowerDefenseCharacter", characterId)
  if config == nil then
    return
  end
  local btn_LevelUp = go.transform:Find("btn_levelUp"):GetComponent("NaviButton")
  local btn_henshin = go.transform:Find("btn_henshin")
  btn_henshin.gameObject:SetActive(false)
  if level < 6 then
    if not self.bIsShowLevelBtn then
      btn_LevelUp.gameObject:SetActive(false)
    else
      btn_LevelUp.gameObject:SetActive(true)
      local icon_levelUp = go.transform:Find("btn_levelUp/AnimRoot/img_levelUp")
      local icon_lock = go.transform:Find("btn_levelUp/AnimRoot/img_lock")
      local txt_costPoint = go.transform:Find("btn_levelUp/AnimRoot/img_point/txt_needPoint")
      local txt_animator = go.transform:Find("btn_levelUp/AnimRoot"):GetComponent("Animator")
      NovaAPI.SetTMPText(txt_costPoint:GetComponent("TMP_Text"), config.PointNeeded[level])
      icon_levelUp.gameObject:SetActive(not (config.PointNeeded[level] > self.point))
      icon_lock.gameObject:SetActive(config.PointNeeded[level] > self.point)
      btn_LevelUp.interactable = not (config.PointNeeded[level] > self.point)
      if config.PointNeeded[level] > self.point then
        NovaAPI.SetTMPColor(txt_costPoint:GetComponent("TMP_Text"), lockLevelUpTextColor)
        txt_animator:Play("btn_levelUp_Unlock")
      else
        NovaAPI.SetTMPColor(txt_costPoint:GetComponent("TMP_Text"), normalLevelUpTextColor)
        txt_animator:Play("New State")
      end
    end
  else
    btn_LevelUp.gameObject:SetActive(false)
    if config.IsShapeshifter then
      btn_henshin.gameObject:SetActive(true)
    end
  end
end

function TowerDefenseCharacterFuncCtrl:OnBtnClick_Close()
  NovaAPI.DispatchEventWithData("TOWERDEFENSE_CANCEL_SELECT_STATE")
end

function TowerDefenseCharacterFuncCtrl:OnEvent_LevelUp(characterId)
  self.nCharacterId = characterId
end

function TowerDefenseCharacterFuncCtrl:OnEvent_LevelUpPointChange(point)
  self.point = point
  for charId, go in pairs(self.UseFuncGo) do
    self:UpdateFunc(charId, go)
  end
end

return TowerDefenseCharacterFuncCtrl
