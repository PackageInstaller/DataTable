local GuideMissionShopCtrl = class("GuideMissionShopCtrl", BaseCtrl)
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local BubbleVoiceManager = require("Game.Actor2D.BubbleVoiceManager")
local PlayerVoiceData = PlayerData.Voice
GuideMissionShopCtrl._mapNodeConfig = {
  sv = {
    sComponentName = "LoopScrollView"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  btnActor2D = {
    sComponentName = "Button",
    callback = "OnBtnClick_Actor2D"
  },
  goBubbleRoot = {
    sNodeName = "----fixed_bubble----"
  },
  goRefresh = {},
  txtRefreshCn = {sComponentName = "TMP_Text"},
  txtRefreshTime = {sComponentName = "TMP_Text"}
}
GuideMissionShopCtrl._mapEventConfig = {
  [EventId.ShowBubbleVoiceText] = "OnEvent_ShowBubbleVoiceText",
  ShopRefreshGoods = "OnEvent_ShopRefreshGoods",
  ShopBuyVoice = "PlayBuyVoice"
}
local npcId = 915201

function GuideMissionShopCtrl:PlayEnterVoice()
  local sTimeVoice = PlayerVoiceData:GetNPCGreetTimeVoiceKey()
  local sVoice = math.random(1, 2) == 1 and sTimeVoice or "greet_npc"
  PlayerVoiceData:PlayCharVoice(sVoice, npcId, nil, true)
end

function GuideMissionShopCtrl:PlayBuyVoice(bSale, bLimit)
  if not self.bInShop then
    return
  end
  local sVoice = ""
  if bSale then
    sVoice = "onsale"
  elseif bLimit then
    sVoice = "limited"
  else
    sVoice = "thank_npc"
  end
  PlayerVoiceData:PlayCharVoice(sVoice, npcId, nil, true)
end

function GuideMissionShopCtrl:PlaySwitchTogVoice()
  PlayerVoiceData:PlayCharVoice("Tab", npcId, nil, true)
end

function GuideMissionShopCtrl:EnterShop(nTogIndex)
  if not self.bInShop then
    self.bInShop = true
    self.nTogIndex = nil
    PlayerVoiceData:StartBoardFreeTimer(npcId)
    self:RefreshNPC2D()
    self:PlayEnterVoice()
  end
  self:CheckShopData(nTogIndex)
end

function GuideMissionShopCtrl:ExitShop()
  if not self.bInShop then
    return
  end
  self.bInShop = false
  self.nTogIndex = nil
  Actor2DManager.UnsetBoardNPC2D()
  BubbleVoiceManager.StopBubbleAnim()
  PlayerVoiceData:ClearTimer()
  PlayerVoiceData:StopCharVoice()
end

function GuideMissionShopCtrl:CheckShopData(nTogIndex)
  if nTogIndex ~= nil and self.nTogIndex ~= nil and self.nTogIndex ~= nTogIndex then
    self:PlaySwitchTogVoice()
  end
  self.nTogIndex = nTogIndex or self.nTogIndex
  PlayerData.Shop:CheckShopData(function()
    self:RefreshData()
  end)
end

function GuideMissionShopCtrl:RefreshData()
  self.tbShops = PlayerData.Shop:GetShopListByType(GameEnum.ShopType.GuideMission)
  local nShopIndex = self.nTogIndex == 3 and 2 or 1
  self.bDiscShop = self.nTogIndex == 3
  local mapShop = self.tbShops[nShopIndex]
  self.mapCurShop = mapShop
  if mapShop == nil then
    self.nShopId = nil
    self.tbGoods = {}
    self:RefreshList()
    self:RefreshRemainTime(0)
    return
  end
  self.nShopId = mapShop.nId
  PlayerData.Shop:CheckGoodsData(self.nShopId)
  self.tbGoods = PlayerData.Shop:GetGoodsList(self.nShopId)
  self:RefreshList()
  local nRemainTime = mapShop.nNextRefreshTime == 0 and 0 or mapShop.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp
  self:RefreshRemainTime(nRemainTime)
end

function GuideMissionShopCtrl:RefreshList()
  if self.tbGridCtrl ~= nil then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
  end
  self.tbGridCtrl = {}
  self._mapNode.sv:SetAnim(0.02)
  self._mapNode.sv:Init(#self.tbGoods, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function GuideMissionShopCtrl:RefreshRemainTime(nRemainTime)
  self.nRemainTime = nRemainTime
  if self.timerCountDown == nil then
    self.timerCountDown = self:AddTimer(0, 1, "RefreshTime", false, true, false)
  end
  if self.nRemainTime > 0 then
    self._mapNode.goRefresh:SetActive(true)
    self:RefreshTime()
    self.timerCountDown:Pause(false)
  else
    self._mapNode.goRefresh:SetActive(false)
    self.timerCountDown:Pause(true)
  end
end

function GuideMissionShopCtrl:RefreshTime()
  self.nRemainTime = self.nRemainTime - 1
  if self.nRemainTime > 0 then
    local mapShop = self.mapCurShop
    NovaAPI.SetTMPText(self._mapNode.txtRefreshCn, mapShop ~= nil and mapShop.nNextRefreshTime == mapShop.nCloseTime and ConfigTable.GetUIText("Shop_NextClose") or ConfigTable.GetUIText("Shop_NextRefresh"))
    local sTime = ""
    if self.nRemainTime <= 60 then
      local sec = math.floor(self.nRemainTime)
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Sec") or "", sec)
    elseif self.nRemainTime > 60 and self.nRemainTime <= 3600 then
      local min = math.floor(self.nRemainTime / 60)
      local sec = math.floor(self.nRemainTime - min * 60)
      if sec == 0 then
        min = min - 1
        sec = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Min") or "", min, sec)
    elseif self.nRemainTime > 3600 and self.nRemainTime <= 86400 then
      local hour = math.floor(self.nRemainTime / 3600)
      local min = math.floor((self.nRemainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Hour") or "", hour, min)
    elseif self.nRemainTime > 86400 then
      local day = math.floor(self.nRemainTime / 86400)
      local hour = math.floor((self.nRemainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTime = orderedFormat(ConfigTable.GetUIText("Shop_NextRefresh_Day") or "", day, hour)
    end
    NovaAPI.SetTMPText(self._mapNode.txtRefreshTime, sTime)
  else
    self.timerCountDown:Pause(true)
  end
end

function GuideMissionShopCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoods[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.ShopEx.ShopGoodsItemCtrl")
  end
  mapData.bGuideMissionShop = self.bDiscShop
  self.tbGridCtrl[nInstanceID]:Refresh(mapData)
end

function GuideMissionShopCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbGoods[nIndex]
  EventManager.Hit(EventId.OpenPanel, PanelId.ShopPopupPanel, mapData, self.nShopId)
end

function GuideMissionShopCtrl:RefreshNPC2D()
  local bUseL2D = LocalSettingData.mapData.UseLive2D
  self._mapNode.rawImgActor2D.transform.localScale = bUseL2D == true and Vector3.one or Vector3.zero
  self._mapNode.trActor2D_PNG.localScale = bUseL2D == true and Vector3.zero or Vector3.one
  if bUseL2D == true then
    Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.rawImgActor2D, npcId)
  else
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), npcId)
  end
end

function GuideMissionShopCtrl:Awake()
end

function GuideMissionShopCtrl:OnEnable()
  self.bInShop = false
end

function GuideMissionShopCtrl:OnDisable()
  self:ExitShop()
end

function GuideMissionShopCtrl:OnDestroy()
end

function GuideMissionShopCtrl:OnBtnClick_Actor2D()
  PlayerVoiceData:PlayBoardNPCClickVoice(npcId)
end

function GuideMissionShopCtrl:OnEvent_ShopRefreshGoods()
  self:CheckShopData()
end

function GuideMissionShopCtrl:OnEvent_ShowBubbleVoiceText(nNpcId, nId)
  if nNpcId ~= npcId then
    return
  end
  local mapVoDirectoryData = ConfigTable.GetData("VoDirectory", nId)
  if mapVoDirectoryData == nil then
    printError("VoDirectory未找到数据id:" .. nId)
    return
  end
  BubbleVoiceManager.PlayFixedBubbleAnim(self._mapNode.goBubbleRoot, mapVoDirectoryData.voResource)
end

return GuideMissionShopCtrl
