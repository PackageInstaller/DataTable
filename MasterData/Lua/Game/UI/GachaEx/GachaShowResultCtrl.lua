local GachaShowResultCtrl = class("GachaShowResultCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
GachaShowResultCtrl._mapNodeConfig = {
  Item = {
    sCtrlName = "Game.UI.GachaEx.GachaShowResultGrid",
    nCount = 10
  },
  rtItem = {sNodeName = "rtItem_", nCount = 3},
  imgItemIcon = {sComponentName = "Image", nCount = 3},
  TMPItemCount = {sComponentName = "TMP_Text", nCount = 3},
  TMPTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "GachaItemTIpsTitle"
  },
  btnClose = {
    nCount = 2,
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  imgItemsBg = {}
}
GachaShowResultCtrl._mapEventConfig = {}

function GachaShowResultCtrl:Awake()
end

function GachaShowResultCtrl:FadeIn()
end

function GachaShowResultCtrl:FadeOut()
end

function GachaShowResultCtrl:OnEnable()
  self.gameObject:SetActive(false)
end

function GachaShowResultCtrl:OnDisable()
end

function GachaShowResultCtrl:OnDestroy()
end

function GachaShowResultCtrl:OnRelease()
end

function GachaShowResultCtrl:ShowResult(tbReward, mapRewardItem, tbGiveItems)
  WwiseAudioMgr:PlaySound("ui_recuit_gacha_result")
  self.curStep = 1
  self._mapNode.imgItemsBg:SetActive(false)
  local nDelayTime = 0
  for i = 1, 10 do
    if tbReward[i] ~= nil then
      self._mapNode.Item[i].gameObject:SetActive(true)
      local itemTime = self._mapNode.Item[i]:Refresh(tbReward[i].id, tbReward[i].bNew, nDelayTime)
      nDelayTime = nDelayTime + itemTime
    else
      self._mapNode.Item[i].gameObject:SetActive(false)
    end
  end
  
  local function AllCardShowCallback()
    self.curStep = 2
    self.delayTimer = nil
    local tbItem = {}
    for nTid, nQty in pairs(mapRewardItem) do
      table.insert(tbItem, {nTid = nTid, nQty = nQty})
    end
    local bRewardActive = false
    for i = 1, 3 do
      if tbItem[i] ~= nil then
        self._mapNode.rtItem[i].gameObject:SetActive(true)
        local mapItemCfgData = ConfigTable.GetData_Item(tbItem[i].nTid)
        if mapItemCfgData == nil then
          printError("ItemDataMisssing:" .. tbItem[i].nTid)
          self._mapNode.rtItem[i].gameObject:SetActive(false)
        else
          self:SetPngSprite(self._mapNode.imgItemIcon[i], mapItemCfgData.Icon)
          NovaAPI.SetTMPText(self._mapNode.TMPItemCount[i], string.format("×%d", tbItem[i].nQty))
          bRewardActive = true
        end
      else
        self._mapNode.rtItem[i].gameObject:SetActive(false)
      end
    end
    if tbGiveItems[1] ~= nil then
      self._mapNode.rtItem[3].gameObject:SetActive(true)
      local mapItemCfgData = ConfigTable.GetData_Item(tbGiveItems[1].Tid)
      if mapItemCfgData == nil then
        printError("ItemDataMisssing:" .. tbGiveItems[1].Tid)
        self._mapNode.rtItem[3].gameObject:SetActive(false)
      else
        self:SetPngSprite(self._mapNode.imgItemIcon[3], mapItemCfgData.Icon)
        NovaAPI.SetTMPText(self._mapNode.TMPItemCount[3], string.format("×%d", tbGiveItems[1].Qty))
        bRewardActive = true
      end
    else
      self._mapNode.rtItem[3].gameObject:SetActive(false)
    end
    self._mapNode.imgItemsBg:SetActive(bRewardActive)
    for i = 1, 10 do
      self._mapNode.Item[i]:ShowAllCardEnd()
    end
    
    local function wait()
      local animtorItemContent = self._mapNode.imgItemsBg:GetComponent("Animator")
      animtorItemContent:Play("GachaShowResult_imgItemsBg_in")
    end
    
    cs_coroutine.start(wait)
    self:BlockJump(0.5)
  end
  
  self.delayTimer = self:AddTimer(1, nDelayTime, AllCardShowCallback, true, true, nil, nil)
end

function GachaShowResultCtrl:BlockJump(nTime)
  self.bBlockJump = true
  
  local function unBlockJump()
    self.bBlockJump = false
  end
  
  self:AddTimer(1, nTime, unBlockJump, true, true, nil, nil)
end

function GachaShowResultCtrl:OnBtnClick_Close()
  if self.bBlockJump then
    return
  end
  if self.curStep == 1 then
    for i = 1, 10 do
      self._mapNode.Item[i]:JumpDelay()
    end
    if self.delayTimer ~= nil then
      self.delayTimer:Cancel(true)
    end
  else
    self.gameObject:SetActive(false)
    WwiseAudioMgr:SetState("recruit_rarity", "None")
    for i = 1, 10 do
      self._mapNode.Item[i].gameObject:SetActive(false)
    end
    PlayerData.Item:TryOpenFragmentsOverflow(function()
      PlayerData.Phone:CheckNewChat()
    end)
  end
end

return GachaShowResultCtrl
