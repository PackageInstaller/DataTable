local CommonQuality = CommonDefine.CommonQuality
local UIAnimationController = CS.Z1Client.UIAnimationController
local UI_Summon_Popup_ShowResource = require("UI.UIPackages.UI_Summon_Popup_ShowResource")
local typeof = _ENV.typeof
local SummonNewItemPanel, Super = System.NewClass("SummonNewItemPanel", UIBasePanel)
SummonNewItemPanel.uiResCls = UI_Summon_Popup_ShowResource

function SummonNewItemPanel:ctor(ItemTid, type, transItems, animData, closeCb)
  Super.ctor(self)
  self.ItemTid = Vue.ref(ItemTid)
  self.type = Vue.ref(type)
  self.transItems = Vue.ref(transItems or {})
  self.haveShowNum = Vue.ref(0)
  self.animData = animData
  self.haveSkipBegin = self.animData and self.animData.skipBeginAnim or nil
  self.isSpecialAwakerTid = animData.isSpecialAwakerTid
  self.closeCb = closeCb
  self.beginAnimDone = false
  self.lastAnimDone = false
  self.lastAnimHaveShow = false
end

function SummonNewItemPanel:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  AudioManager.Instance:PostSoundEvent("Set_State_Aa_Interface_Awaker_Get")
  binder:BindButtonClick(self.ui.Btn_Skip, function()
    self:Close()
  end)
  binder:SetActive(self.ui.Btn_Click, false)
  binder:BindEvent(EventMgr.Instance.SummonGainItemCbSet, function(cb)
    self:SetCallback(cb)
  end)
  self.itemDetails = {
    [CommonQuality.White] = binder:BindComponent(SummonResultItemDetailR(self.ui.Item_N)),
    [CommonQuality.Blue] = binder:BindComponent(SummonResultItemDetailR(self.ui.Item_R)),
    [CommonQuality.Purple] = binder:BindComponent(SummonResultItemDetailSR(self.ui.Item_SR)),
    [CommonQuality.Orange] = binder:BindComponent(SummonResultItemDetailSSR(self.ui.Item_SSR)),
    [CommonQuality.UR] = binder:BindComponent(SummonResultItemDetailSSR(self.ui.Item_SSR))
  }
  self:_HideAllItemDetails()
  self:_CreateShareBtnCom()
  binder:BindToRaw(function(_, nTbl, _)
    if not nTbl[1] or self.animData then
      self.animData = nil
      self:ShowNext()
      return
    end
    self:SetShareBtnShow(false)
    local tid = nTbl[1]
    local type = nTbl[2]
    local extraItems = nTbl[3] or {}
    for _, extraItem in ipairs(extraItems) do
      extraItem.changedNum = extraItem.num
    end
    self:_HideAllItemDetails()
    if type == CommonDefine.SummonItemType.Awaker then
      local awakerTid = self.isSpecialAwakerTid and tid or ItemDataUtils.GetAwakerTidByItemTid(tid)
      local awakerCfg = DT.AwakerConfig[awakerTid]
      local itemDetail = self.itemDetails[awakerCfg.Quality]
      itemDetail.ui.uiNode:SetActive(true)
      itemDetail:DisplayAwaker(awakerTid, extraItems, nil, function()
        self:SetItemHaveShow()
        self:ShowNext()
      end)
      self:_PlaySound(awakerCfg.Quality)
    elseif type == CommonDefine.SummonItemType.Weapon then
      if PopTipsManager.Instance.weaponLock[tid] then
        self:SetItemHaveShow()
        self:ShowNext()
      else
        PopTipsManager.Instance:UpdateWeaponLock(tid, true)
        local summonItem = {
          tid = tid,
          count = 1,
          isNew = true,
          extraItems = extraItems
        }
        local itemCfg = ItemDataUtils.GetItemConfig(tid)
        local itemDetail = self.itemDetails[itemCfg.Quality]
        itemDetail.ui.uiNode:SetActive(true)
        itemDetail:Display(summonItem, nil, function()
          self:SetItemHaveShow()
          self:ShowNext()
        end)
        self:_PlaySound(itemCfg.Quality)
      end
    elseif type == CommonDefine.SummonItemType.Skin then
      local itemCfg = ItemDataUtils.GetItemConfig(tid)
      local itemDetail = self.itemDetails[itemCfg.Quality]
      itemDetail.ui.uiNode:SetActive(true)
      itemDetail:DisplaySkin(tid, extraItems, nil, function()
        self:SetItemHaveShow()
        self:ShowNext()
      end)
      self:_PlaySound(itemCfg.Quality)
      self.binder:BindTimer(0.1, 0, nil, function()
        self:_PlaySkinSound()
      end)
      self:SetShareBtnShow(true)
    end
  end, function()
    return {
      self.ItemTid.value,
      self.type.value,
      self.transItems.value,
      self.haveShowNum.value
    }
  end)
end

function SummonNewItemPanel:_PlaySound(quality)
  local soundID = CommonDefine.SummonSoundID.ShowItemDetail[quality]
  if soundID then
    AudioManager.Instance:PostSoundEvent(soundID)
  end
end

function SummonNewItemPanel:_PlaySkinSound()
end

function SummonNewItemPanel:_HideAllItemDetails()
  for _, itemDetail in pairs(self.itemDetails) do
    itemDetail.ui.uiNode:SetActive(false)
  end
end

function SummonNewItemPanel:SetItemHaveShow()
  local gainShowList = SummonDataUtils.GetSummonGainShowList()
  if gainShowList[1] then
    gainShowList[1].haveShow = true
  else
    self.lastAnimHaveShow = true
  end
end

function SummonNewItemPanel:ShowNext()
  if self.animData then
    return
  end
  local gainShowList = SummonDataUtils.GetSummonGainShowList()
  local isLocked = false
  for i = #gainShowList, 1, -1 do
    if gainShowList[i] and PopTipsManager.Instance.weaponLock[gainShowList[i].configId] then
      table.remove(gainShowList, i)
      isLocked = true
    end
  end
  local info = gainShowList[1]
  if not info and not isLocked and self.lastAnimDone == false then
    self.lastAnimDone = true
    info = self.info or {}
    info.haveShow = self.lastAnimHaveShow
  end
  if info then
    if false == self.beginAnimDone then
      self.beginAnimDone = true
      table.remove(gainShowList, 1)
      self.ItemTid.value = info.configId
      self.type.value = info.type
      self.transItems.value = info.transItems
      self.haveShowNum.value = self.haveShowNum.value + 1
      self.info = info
      return
    end
    if not info.haveShow then
      info.haveShow = true
    elseif true == info.haveShow then
      table.remove(gainShowList, 1)
      if self.lastAnimDone == false then
        self.ItemTid.value = info.configId
        self.type.value = info.type
        self.transItems.value = info.transItems
        self.haveShowNum.value = self.haveShowNum.value + 1
        self.info = info
      else
        self:Close()
      end
    end
  else
    self:Close()
  end
end

function SummonNewItemPanel:_CreateShareBtnCom()
  if SteamSdk.Instance:IsSteam() or ApplicationUtils.IsWindowsOrEditor() then
    self.binder:SetActive(self.ui.Btn_Share, false)
    return
  end
  self.binder:BindToRaw(function(cbinder, isShowShare)
    cbinder:SetActive(self.ui.Btn_Share, isShowShare)
    if isShowShare then
      local ShareBtnCom = require("UI.Share.ShareBtnCom")
      self.shareCom = self.binder:BindComponent(ShareBtnCom(self.ui.Btn_Share, System.fn(self, self.ShowSharePanel), "Image_Across"))
    end
  end, function()
    if self.animData and self.animData.forbidShare then
      return
    end
    return self.type.value == CommonDefine.SummonItemType.Awaker or self.type.value == CommonDefine.SummonItemType.Weapon
  end)
end

function SummonNewItemPanel:ShowSharePanel()
  self:SetObjsVisibleInShare(true)
  
  local function afterCall()
    self:SetObjsVisibleInShare(false)
  end
  
  local tid = self.ItemTid.value
  local SdkMgr = require("Managers.Sdk.SdkMgr")
  UIManager.Instance:SetTempPanelLayer(Urls.ShareSummonView, self.panelCfg.layer)
  SdkMgr.Instance:GetShare():OpenShareSummonPanel(tid, nil, afterCall, nil)
end

function SummonNewItemPanel:SetShareBtnShow(bShow)
  if self.shareCom then
    self.shareCom:SetVisible(bShow)
  end
end

function SummonNewItemPanel:SetObjsVisibleInShare(isInShare)
  self:SetShareBtnShow(not isInShare)
  self.ui.Btn_Skip:SetActive(not isInShare)
end

function SummonNewItemPanel:Close()
  if self.closeCb then
    self.closeCb()
  end
  PopTipsManager.Instance:UpdateWeaponLock(self.ItemTid.value)
  self.closeCb = nil
  Super.Close(self)
  SummonDataUtils.SetSummonGainShowList({})
  local WorldStageManager = require("Managers.WorldStage.WorldStageManager")
  WorldStageManager.Instance:ReplayBGM()
  EventMgr.Instance.CheckShowRewardEvent:Dispatch()
end

function SummonNewItemPanel:SetCallback(cb)
  self.closeCb = cb
end

return SummonNewItemPanel
