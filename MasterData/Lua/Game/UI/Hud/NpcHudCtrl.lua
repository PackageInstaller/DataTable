local NpcHudCtrl = class("NpcHudCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local TimerManager = require("GameCore.Timer.TimerManager")
NpcHudCtrl._mapNodeConfig = {
  rtRoot = {},
  rtTop = {},
  rtNpc = {},
  rtChat = {},
  txtChat = {sComponentName = "TMP_Text"},
  txtNPCType = {sComponentName = "TMP_Text"},
  rtStrength = {},
  txtStrength = {sComponentName = "TMP_Text"},
  rtCost = {},
  txtCost = {sComponentName = "TMP_Text"},
  imgCost = {sComponentName = "Image"},
  rtFree = {},
  txtFree = {
    sComponentName = "TMP_Text",
    sLanguageId = "ST_StrengthenMachine_Free"
  },
  rtBottom = {},
  txtNPCName = {sComponentName = "TMP_Text"},
  txtNPCTag = {sComponentName = "TMP_Text"}
}
NpcHudCtrl._mapEventConfig = {
  RefreshStarTowerCoin = "OnEvent_RefreshStarTowerCoin",
  InteractiveNpc = "OnEvent_InteractiveNpc",
  InteractiveNpcFinish = "OnEvent_InteractiveNpcFinish"
}
local colorGreen = Color(0.9803921568627451, 0.9803921568627451, 0.9803921568627451, 1)
local colorRed = Color(1.0, 0.44313725490196076, 0.5411764705882353, 1)
local nInterval = 0.2
local chatMinTime = 1
local chatMaxTime = 4

function NpcHudCtrl:CalChatContentShowTime(sContent)
  local sPureContent = string.gsub(sContent, "<.->", "")
  sPureContent = string.gsub(sPureContent, "\n", "")
  local nDuration = string.utf8len(sPureContent) * nInterval
  nDuration = math.min(chatMaxTime, nDuration)
  nDuration = math.max(chatMinTime, nDuration)
  return nDuration
end

function NpcHudCtrl:ShowStrengthNpc(sName, nCostCount, nHasCount)
  self._mapNode.rtStrength.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtStrength, sName)
  self.nCostCount = nCostCount
  self:RefreshStrengthCost(nHasCount)
end

function NpcHudCtrl:RefreshStrengthCost(nHasCount)
  self._mapNode.rtCost.gameObject:SetActive(self.nCostCount > 0)
  self._mapNode.rtFree.gameObject:SetActive(self.nCostCount <= 0)
  if self.nCostCount > 0 then
    NovaAPI.SetTMPText(self._mapNode.txtCost, self.nCostCount)
    NovaAPI.SetTMPColor(self._mapNode.txtCost, nHasCount >= self.nCostCount and colorGreen or colorRed)
    self:SetSprite_Coin(self._mapNode.imgCost, AllEnum.CoinItemId.FixedRogCurrency)
  end
end

function NpcHudCtrl:ShowNpc(nId, nUId, nCostCount, nHasCount)
  self.nNpcId = nId
  self.nNpcUId = nUId
  self.nCostCount = nCostCount
  self:Clear()
  local mapNpcCfg = ConfigTable.GetData("NPCConfig", nId)
  if mapNpcCfg ~= nil then
    self._mapNode.rtRoot.gameObject:SetActive(true)
    self.tbChatPool = mapNpcCfg.Chat
    self.nChatProp = mapNpcCfg.ChatProp
    if mapNpcCfg.type == GameEnum.npcNewType.Upgrade and nCostCount ~= nil then
      self:ShowStrengthNpc(mapNpcCfg.Literary, nCostCount, nHasCount)
    else
      self._mapNode.rtBottom.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtNPCName, mapNpcCfg.Name)
      NovaAPI.SetTMPText(self._mapNode.txtNPCTag, mapNpcCfg.Desc)
      if mapNpcCfg.type ~= GameEnum.npcNewType.Narrate then
        self._mapNode.rtNpc.gameObject:SetActive(true)
        NovaAPI.SetTMPText(self._mapNode.txtNPCType, mapNpcCfg.Literary)
        self:ShowChat()
        if self.chatTimer == nil then
          self.chatTimer = TimerManager.Add(0, mapNpcCfg.ChatTime, self, function()
            self:ShowChat()
          end, true, true, false)
        end
      end
    end
    AdventureModuleHelper.SetHudFollowTarget(nUId, self._mapNode.rtTop.gameObject, Vector3(0, 1.2, 0), true)
    AdventureModuleHelper.SetHudFollowTarget(nUId, self._mapNode.rtBottom.gameObject, Vector3(0, -0.7, 0), false)
  end
end

function NpcHudCtrl:ShowChat()
  if self.tbChatPool == nil then
    return
  end
  local bTrigger = math.random(1, 100) <= self.nChatProp and true or false
  self._mapNode.rtChat.gameObject:SetActive(bTrigger)
  if bTrigger then
    local nAllCount = #self.tbChatPool
    local nIndex = math.random(1, nAllCount)
    local nChatId = self.tbChatPool[nIndex]
    local mapChatCfg = ConfigTable.GetData("StarTowerTalk", nChatId)
    NovaAPI.SetTMPText(self._mapNode.txtChat, mapChatCfg.Content)
    local nDuration = self:CalChatContentShowTime(mapChatCfg.Content)
    self:AddTimer(1, nDuration, function()
      self._mapNode.rtChat.gameObject:SetActive(false)
    end, true, true, true, nil)
  end
end

function NpcHudCtrl:Clear()
  self._mapNode.rtNpc.gameObject:SetActive(false)
  self._mapNode.rtChat.gameObject:SetActive(false)
  self._mapNode.rtStrength.gameObject:SetActive(false)
  self._mapNode.rtBottom.gameObject:SetActive(false)
  self.tbChatPool = nil
  self.nChatProp = nil
end

function NpcHudCtrl:HideNpc()
  if self.chatTimer ~= nil then
    TimerManager.Remove(self.chatTimer, false)
  end
  self.chatTimer = nil
  self:Clear()
  self._mapNode.rtRoot.gameObject:SetActive(false)
end

function NpcHudCtrl:Awake()
  self._mapNode.rtRoot.gameObject:SetActive(false)
end

function NpcHudCtrl:OnDisable()
  self:HideNpc()
  self.nNpcId = nil
  self.nNpcUId = nil
  self.nCostCount = nil
end

function NpcHudCtrl:OnEvent_InteractiveNpc(nId)
  if nId ~= self.nNpcId then
    return
  end
  if self.chatTimer ~= nil then
    TimerManager.Remove(self.chatTimer, false)
  end
  self.chatTimer = nil
  self._mapNode.rtChat.gameObject:SetActive(false)
end

function NpcHudCtrl:OnEvent_InteractiveNpcFinish(nId, nCostCount, nHasCount)
  if nId ~= self.nNpcId then
    return
  end
  local mapNpcCfg = ConfigTable.GetData("NPCConfig", nId)
  if mapNpcCfg == nil then
    printError("读取NPCConfig配置失败！！！id = " .. tostring(nId))
    return
  end
  self:ShowChat()
  if self.chatTimer == nil then
    self.chatTimer = TimerManager.Add(0, mapNpcCfg.ChatTime, self, function()
      self:ShowChat()
    end, true, true, false)
  end
  if mapNpcCfg.type == GameEnum.npcNewType.Upgrade and nCostCount ~= nil then
    self.nCostCount = nCostCount
    self:RefreshStrengthCost(nHasCount)
  end
end

function NpcHudCtrl:OnEvent_RefreshStarTowerCoin(nCoin)
  if self.nNpcId ~= nil and self.nCostCount ~= nil then
    local mapNpcCfg = ConfigTable.GetData("NPCConfig", self.nNpcId)
    if mapNpcCfg ~= nil and mapNpcCfg.type == GameEnum.npcNewType.Upgrade then
      self:RefreshStrengthCost(nCoin)
    end
  end
end

return NpcHudCtrl
