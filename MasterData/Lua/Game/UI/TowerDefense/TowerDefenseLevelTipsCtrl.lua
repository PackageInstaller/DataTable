local ConfigData = require("GameCore.Data.ConfigData")
local TowerDefenseLevelTipsCtrl = class("TowerDefenseLevelTipsCtrl", BaseCtrl)
TowerDefenseLevelTipsCtrl._mapNodeConfig = {
  monsterTemp = {},
  charTemp = {},
  listParent = {
    sNodeName = "List",
    sComponentName = "RectTransform"
  }
}
TowerDefenseLevelTipsCtrl._mapEventConfig = {
  TowerDefenseShowFullScreenPanel = "OnEvent_OnPause",
  TowerDefenseShowHideScreenPanel = "OnEvent_OnResume"
}
TowerDefenseLevelTipsCtrl._mapRedDotConfig = {}
local tipsType = {CHAR = 1, MONSTER = 2}
local spaceValue = 18
local addCdValue = 0.1
local moveTime = 0.2
local startPosY = 0

function TowerDefenseLevelTipsCtrl:Awake()
  self._mapNode.monsterTemp:SetActive(false)
  self._mapNode.charTemp:SetActive(false)
  self.sequence = DOTween.Sequence()
  self.sequence:SetUpdate(true)
  self.ShowQueue = {}
  self.WaitQueue = {}
  self.bInCD = false
  self.cdTimer = nil
  self.bInMove = false
  self.tbMoveTweer = {}
end

function TowerDefenseLevelTipsCtrl:AddQueue(nId, nType)
  table.insert(self.WaitQueue, {nId = nId, nType = nType})
  self:CheckShowQueue()
end

function TowerDefenseLevelTipsCtrl:CheckShowQueue()
  print("===================ShowQueueBeigin" .. tostring(self.bInCD), tostring(self.bInMove))
  if #self.ShowQueue == 3 then
    return
  end
  if #self.WaitQueue == 0 then
    return
  end
  if self.bInCD then
    return
  end
  if self.bInMove then
    return
  end
  print("===================ShowQueue")
  local tipsData = self.WaitQueue[1]
  table.remove(self.WaitQueue, 1)
  if tipsData.nType == tipsType.CHAR then
    local charData = {
      nId = tipsData.nId,
      obj = nil,
      showTimer = nil
    }
    self:ShowCharTips(charData)
    table.insert(self.ShowQueue, charData)
  else
    if tipsData.nType == tipsType.MONSTER then
      local monsterData = {
        nId = tipsData.nId,
        obj = nil,
        showTimer = nil
      }
      self:ShowMonsterTips(monsterData)
      table.insert(self.ShowQueue, monsterData)
    else
    end
  end
  self.bInCD = true
  self.cdTimer = self:AddTimer(1, addCdValue, function()
    self.bInCD = false
    self:CheckShowQueue()
  end, true, true, true)
end

function TowerDefenseLevelTipsCtrl:ShowCharTips(charData)
  local characterConfig = ConfigTable.GetData("TowerDefenseCharacter", charData.nId)
  if characterConfig == nil then
    return
  end
  local obj = instantiate(self._mapNode.charTemp, self._mapNode.listParent)
  local objTra = obj:GetComponent("RectTransform")
  objTra.anchoredPosition = Vector2(objTra.anchoredPosition.x, startPosY - #self.ShowQueue * 131.823 - #self.ShowQueue * spaceValue)
  charData.obj = obj
  local animator = obj:GetComponent("Animator")
  local icon = obj.transform:Find("icon_bg/icon"):GetComponent("Image")
  local txt_Title = obj.transform:Find("txt_title"):GetComponent("TMP_Text")
  local txt_Name = obj.transform:Find("txt_name"):GetComponent("TMP_Text")
  self:SetPngSprite(icon, characterConfig.Icon .. AllEnum.CharHeadIconSurfix.QM)
  NovaAPI.SetTMPText(txt_Name, characterConfig.Name)
  NovaAPI.SetTMPText(txt_Title, ConfigTable.GetUIText("TowerDef_Tips_Title"))
  
  local function close()
    animator:Play("TowerDefenseMonsterTipsPanel_out")
    charData.showTimer = self:AddTimer(1, 0.2, function()
      local index = table.indexof(self.ShowQueue, charData)
      table.remove(self.ShowQueue, index)
      self:MoveOtherUI()
      destroy(charData.obj)
      self:ClearTipData(charData)
    end, true, true, true)
  end
  
  obj:SetActive(true)
  animator:Play("TowerDefenseMonsterTipsPanel_in")
  self:AddTimer(1, 5, close, true, true, true)
end

function TowerDefenseLevelTipsCtrl:ShowMonsterTips(monsterData)
  local config = ConfigTable.GetData("TowerDefenseMonster", monsterData.nId)
  if config == nil then
    return
  end
  local monsterConfig = ConfigTable.GetData("Monster", config.Id)
  if monsterConfig == nil then
    return
  end
  local skinConfig = ConfigTable.GetData("MonsterSkin", monsterConfig.FAId)
  if skinConfig == nil then
    return
  end
  local manualConfig = ConfigTable.GetData("MonsterManual", skinConfig.MonsterManual)
  if manualConfig == nil then
    return
  end
  local obj = instantiate(self._mapNode.monsterTemp, self._mapNode.listParent)
  local objTra = obj:GetComponent("RectTransform")
  objTra.anchoredPosition = Vector2(objTra.anchoredPosition.x, startPosY - #self.ShowQueue * 131.823 - #self.ShowQueue * spaceValue)
  monsterData.obj = obj
  local animator = obj:GetComponent("Animator")
  local icon = obj.transform:Find("icon_monster"):GetComponent("Image")
  local txt_Name = obj.transform:Find("txt_name"):GetComponent("TMP_Text")
  local txt_Des = obj.transform:Find("txt_des"):GetComponent("TMP_Text")
  self:SetPngSprite(icon, manualConfig.Icon)
  NovaAPI.SetTMPText(txt_Name, manualConfig.Name)
  NovaAPI.SetTMPText(txt_Des, config.Brief)
  
  local function close()
    animator:Play("TowerDefenseMonsterTipsPanel_out")
    monsterData.showTimer = self:AddTimer(1, 0.2, function()
      local index = table.indexof(self.ShowQueue, monsterData)
      table.remove(self.ShowQueue, index)
      self:MoveOtherUI()
      destroy(monsterData.obj)
      self:ClearTipData(monsterData)
    end, true, true, true)
  end
  
  obj:SetActive(true)
  animator:Play("TowerDefenseMonsterTipsPanel_in")
  self:AddTimer(1, 5, close, true, true, true)
end

function TowerDefenseLevelTipsCtrl:MoveOtherUI()
  if #self.tbMoveTweer > 0 then
    for i = 1, #self.tbMoveTweer do
      local tweer = self.tbMoveTweer[i]
      tweer:Kill()
    end
    self.bInMove = false
  end
  self.tbMoveTweer = {}
  self.bInMove = true
  if #self.ShowQueue == 0 then
    self.bInMove = false
    self:CheckShowQueue()
  else
    for i = 1, #self.ShowQueue do
      local data = self.ShowQueue[i]
      if data.obj ~= nil then
        local objTra = data.obj:GetComponent("RectTransform")
        if i == #self.ShowQueue then
          local tweer = objTra:DOLocalMoveY(startPosY - (i - 1) * 131.823 - math.min(#self.ShowQueue - 1, 0) * spaceValue, moveTime):SetUpdate(true)
          tweer:OnComplete(function()
            self.bInMove = false
            self:CheckShowQueue()
          end)
          table.insert(self.tbMoveTweer, tweer)
        else
          local tweer = objTra:DOLocalMoveY(startPosY - (i - 1) * 131.823 - math.min(#self.ShowQueue - 1, 0) * spaceValue, moveTime):SetUpdate(true)
          table.insert(self.tbMoveTweer, tweer)
        end
      end
    end
  end
end

function TowerDefenseLevelTipsCtrl:ClearTipData(tipData)
  if tipData.showTimer == nil then
    return
  end
  tipData.showTimer:_Stop()
end

function TowerDefenseLevelTipsCtrl:OnEvent_OnPause()
  if self.cdTimer ~= nil then
    self.cdTimer:Pause(true)
  end
  if #self.tbMoveTweer > 0 then
    for i = 1, #self.tbMoveTweer do
      local tweer = self.tbMoveTweer[i]
      tweer:Pause()
    end
  end
end

function TowerDefenseLevelTipsCtrl:OnEvent_OnResume()
  if self.cdTimer ~= nil then
    self.cdTimer:Pause(false)
  end
  if #self.tbMoveTweer > 0 then
    for i = 1, #self.tbMoveTweer do
      local tweer = self.tbMoveTweer[i]
      tweer:Play()
    end
  end
end

return TowerDefenseLevelTipsCtrl
