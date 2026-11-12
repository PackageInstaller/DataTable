local GachaNewBieShowResultCtrl = class("GachaNewBieShowResultCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
GachaNewBieShowResultCtrl._mapNodeConfig = {
  Item = {
    sCtrlName = "Game.UI.GachaEx.GachaShowResultGrid",
    nCount = 10
  },
  txt_newbie_result_save = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSaveResult"
  },
  txt_newbie_result_summon = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieResultSummonAgain"
  },
  txt_newbie_result_summon_remain = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieRecordResultRemain"
  },
  txt_newbie_result_record = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieRecordResult"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btn_newbie_save = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  btn_newbie_summon = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Summon"
  },
  btn_newbie_record = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Record"
  }
}
GachaNewBieShowResultCtrl._mapEventConfig = {
  Guide_GachaStart = "OnEvent_Guide_GachaStart"
}

function GachaNewBieShowResultCtrl:Awake()
  self.remainCount = -1
end

function GachaNewBieShowResultCtrl:FadeIn()
end

function GachaNewBieShowResultCtrl:FadeOut()
end

function GachaNewBieShowResultCtrl:OnEnable()
  self.GuideBlock = false
  self.gameObject:SetActive(false)
end

function GachaNewBieShowResultCtrl:OnDisable()
end

function GachaNewBieShowResultCtrl:OnDestroy()
end

function GachaNewBieShowResultCtrl:OnRelease()
end

function GachaNewBieShowResultCtrl:RefreshInfo()
  if self.curPoolId == nil then
    return
  end
  local newbie = ConfigTable.GetData("GachaNewbie", self.curPoolId)
  if newbie == nil then
    return
  end
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData == nil then
    return
  end
  local c = tostring(#newbieData.Cards) .. "/" .. tostring(newbie.SaveCount)
  local nTotalCount = newbie.SpinCount
  local remainCount = nTotalCount - newbieData.Times
  if #newbieData.Temp == 0 or remainCount == 0 then
    self._mapNode.btn_newbie_save.gameObject:SetActive(false)
  else
    self._mapNode.btn_newbie_save.gameObject:SetActive(true)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_newbie_result_record, orderedFormat(ConfigTable.GetUIText("Gacha_NewBieRecordResult") or "", c))
  NovaAPI.SetTMPText(self._mapNode.txt_newbie_result_summon_remain, orderedFormat(ConfigTable.GetUIText("Gacha_NewBieRecordResultRemain") or "", remainCount))
  if remainCount <= 0 then
    NovaAPI.SetTMPText(self._mapNode.txt_newbie_result_summon, ConfigTable.GetUIText("Gacha_Newbie_BtnShowRecord"))
  end
  self.remainCount = remainCount
end

function GachaNewBieShowResultCtrl:ShowResult(tbReward, poolId)
  self.curPoolId = poolId
  WwiseAudioMgr:PlaySound("ui_recuit_gacha_result")
  self:RefreshInfo()
  self.curStep = 1
  local nDelayTime = 0
  self.hasSSR = false
  for i = 1, 10 do
    if tbReward[i] ~= nil then
      self._mapNode.Item[i].gameObject:SetActive(true)
      local itemTime = self._mapNode.Item[i]:Refresh(tbReward[i].id, tbReward[i].bNew, nDelayTime)
      local mapItemCfg = ConfigTable.GetData_Item(tbReward[i].id)
      nDelayTime = nDelayTime + itemTime
      if mapItemCfg ~= nil and mapItemCfg.Rarity == GameEnum.itemRarity.SSR then
        self.hasSSR = true
      end
    else
      self._mapNode.Item[i].gameObject:SetActive(false)
    end
  end
  
  local function AllCardShowCallback()
    self.curStep = 2
    self.delayTimer = nil
    for i = 1, 10 do
      self._mapNode.Item[i]:ShowAllCardEnd()
    end
    EventManager.Hit("Guide_GachaFinish")
    self:BlockJump(0.5)
  end
  
  self.delayTimer = self:AddTimer(1, nDelayTime, AllCardShowCallback, true, true, nil, nil)
end

function GachaNewBieShowResultCtrl:BlockJump(nTime)
  self.bBlockJump = true
  
  local function unBlockJump()
    self.bBlockJump = false
  end
  
  self:AddTimer(1, nTime, unBlockJump, true, true, nil, nil)
end

function GachaNewBieShowResultCtrl:OnBtnClick_Close()
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

function GachaNewBieShowResultCtrl:OnBtnClick_Save()
  if self.GuideBlock then
    return
  end
  EventManager.Hit("GachaNewbieSaveRecord")
  self.hasSSR = false
end

function GachaNewBieShowResultCtrl:OnBtnClick_Summon()
  local function ConfirmCallback()
    EventManager.Hit("GachaNewbieSpin")
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Gacha_Newbie_RecordSSRHint"),
    callbackConfirm = ConfirmCallback,
    bDisableSnap = false
  }
  if self.remainCount == 0 then
    self:OnBtnClick_Record()
  elseif self.hasSSR then
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    ConfirmCallback()
  end
end

function GachaNewBieShowResultCtrl:OnBtnClick_Record()
  EventManager.Hit("GachaNewbieRecord")
end

function GachaNewBieShowResultCtrl:OnEvent_Guide_GachaStart(bBlock)
  self.GuideBlock = bBlock
end

return GachaNewBieShowResultCtrl
