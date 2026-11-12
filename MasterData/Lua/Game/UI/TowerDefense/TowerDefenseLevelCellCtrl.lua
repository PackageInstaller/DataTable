local TowerDefenseLevelCellCtrl = class("TowerDefenseLevelCellCtrl", BaseCtrl)
TowerDefenseLevelCellCtrl._mapNodeConfig = {
  txt_Name = {sComponentName = "TMP_Text"},
  img_bg = {sComponentName = "Image"},
  goStar = {},
  Star = {nCount = 3},
  reddotNew = {},
  go_Perfect = {},
  txt_Perfect = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Perfect"
  },
  goTips = {},
  txt_Time = {sComponentName = "TMP_Text"},
  btn_Level = {
    sNodeName = "btnGrid",
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectLevel"
  },
  img_lock = {sComponentName = "Image"}
}
TowerDefenseLevelCellCtrl._mapEventConfig = {
  TowerDefenseLevelUpdateTime = "TowerDefenseLevelUpdateTime"
}
TowerDefenseLevelCellCtrl._mapRedDotConfig = {}

function TowerDefenseLevelCellCtrl:SetData(nActId, levelData)
  if self.levelData ~= nil then
    RedDotManager.UnRegisterNode(RedDotDefine.Activity_TowerDefense_Level, {
      self.levelConfig.LevelPage,
      self.levelData.nLevelId
    }, self._mapNode.reddotNew)
  end
  self.actData = PlayerData.Activity:GetActivityDataById(nActId)
  self.levelData = levelData
  self.levelConfig = ConfigTable.GetData("TowerDefenseLevel", self.levelData.nLevelId)
  if self.levelConfig.LevelBg ~= "" then
    self:SetPngSprite(self._mapNode.img_bg, self.levelConfig.LevelBg)
    self:SetPngSprite(self._mapNode.img_lock, self.levelConfig.LevelBg)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_Name, self.levelConfig.LevelName)
  self:TowerDefenseLevelUpdateTips()
  local bIsUnlock = self.actData:IsLevelUnlock(self.levelData.nLevelId)
  local bPreLevelPass = self.actData:IsPreLevelPass(self.levelData.nLevelId)
  self._mapNode.goStar:SetActive(bIsUnlock and bPreLevelPass)
  for i = 1, #self._mapNode.Star do
    if i <= self.levelData.nStar then
      self._mapNode.Star[i]:SetActive(true)
    else
      self._mapNode.Star[i]:SetActive(false)
    end
  end
  local nStar = self.levelData.nStar
  if nStar // 10 == 1 then
    self._mapNode.go_Perfect:SetActive(true)
  else
    self._mapNode.go_Perfect:SetActive(false)
  end
  self._mapNode.img_lock.gameObject:SetActive(not bIsUnlock or not bPreLevelPass)
  RedDotManager.RegisterNode(RedDotDefine.Activity_TowerDefense_Level, {
    self.levelConfig.LevelPage,
    self.levelData.nLevelId
  }, self._mapNode.reddotNew)
end

function TowerDefenseLevelCellCtrl:TowerDefenseLevelUpdateTips()
  if self.levelData == nil then
    return
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  if curTime >= self.actData:GetLevelStartTime(self.levelData.nLevelId) then
    local bPreLevelPass = self.actData:IsPreLevelPass(self.levelData.nLevelId)
    if bPreLevelPass then
      self._mapNode.goTips:SetActive(false)
    else
      self._mapNode.goTips:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txt_Time, ConfigTable.GetUIText("TowerDef_PreLevelNotPass"))
    end
  else
    self._mapNode.goTips:SetActive(true)
    local remainTime = self.actData:GetLevelStartTime(self.levelData.nLevelId) - curTime
    local sTime = self:GetTimeText(remainTime)
    NovaAPI.SetTMPText(self._mapNode.txt_Time, orderedFormat(ConfigTable.GetUIText("TowerDef_TimeTips") or "", sTime))
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goTips:GetComponent("RectTransform"))
  end
end

function TowerDefenseLevelCellCtrl:GetTimeText(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function TowerDefenseLevelCellCtrl:OnBtnClick_SelectLevel()
  local bIsUnlock = self.actData:IsLevelUnlock(self.levelData.nLevelId)
  if not bIsUnlock then
    return
  end
  if not self.actData:IsPreLevelPass(self.levelData.nLevelId) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDef_NeedPassPreLevel"))
    return
  end
  EventManager.Hit("TowerDefenseLevelCell_OnSelected", self.levelData.nLevelId)
end

return TowerDefenseLevelCellCtrl
