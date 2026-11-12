local MainlineLevelCtrl = class("MainlineLevelCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
MainlineLevelCtrl._mapNodeConfig = {
  txtLevelIndex = {sComponentName = "TMP_Text"},
  txtLevelName = {sComponentName = "TMP_Text"},
  goAvg = {},
  goNormal = {},
  imgLevel = {sComponentName = "Image"},
  imgLevel1 = {sComponentName = "Image"},
  imgStar = {nCount = 3, sComponentName = "Button"},
  imgJade = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"},
  btnSelect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Select"
  },
  btnSelectComplete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Select"
  },
  goJade = {
    sComponentName = "RectTransform"
  },
  imgComplete = {},
  goMask = {},
  goMaskBlack = {},
  TMP_UnlockCount = {sComponentName = "TMP_Text"},
  imgUnlockIcon = {sComponentName = "Image"},
  btnUnlock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Unlock"
  },
  unlockAnim = {sComponentName = "Animator", sNodeName = "lockAnim"},
  TMPGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go",
    nCount = 2
  }
}
MainlineLevelCtrl._mapEventConfig = {}

function MainlineLevelCtrl:Awake()
end

function MainlineLevelCtrl:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function MainlineLevelCtrl:OnEnable()
end

function MainlineLevelCtrl:OnDisable()
end

function MainlineLevelCtrl:OnDestroy()
end

function MainlineLevelCtrl:OnRelease()
end

function MainlineLevelCtrl:Refresh(mapData, nStar, unLock, nTid, nCount, tbTarget)
  self.nStar = nStar
  self.levelData = mapData
  if not unLock then
    self.gameObject:SetActive(false)
    self.gameObject.transform.localScale = Vector3.zero
    return
  end
  self.gameObject.transform.localScale = Vector3.one
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtLevelIndex, mapData.Num)
  NovaAPI.SetTMPText(self._mapNode.txtLevelName, mapData.Name)
  if mapData.AvgId == "" or mapData.AvgId == nil then
    self._mapNode.goAvg:SetActive(false)
    self._mapNode.goNormal:SetActive(true)
    for index = 1, 3 do
      self._mapNode.imgStar[index].interactable = tbTarget[index]
    end
    self:SetPngSprite(self._mapNode.imgLevel1, mapData.MainlineImg)
  else
    self._mapNode.goAvg:SetActive(true)
    self._mapNode.goNormal:SetActive(false)
    self:SetPngSprite(self._mapNode.imgLevel, mapData.MainlineImg)
  end
  self._mapNode.goJade.gameObject:SetActive(nStar < 1)
  self._mapNode.imgComplete.gameObject:SetActive(1 <= nStar)
  if nTid == 0 then
    self._mapNode.imgJade.gameObject:SetActive(false)
    self._mapNode.txtCount.gameObject:SetActive(false)
  else
    self._mapNode.imgJade.gameObject:SetActive(true)
    self._mapNode.txtCount.gameObject:SetActive(true)
    local itemCfgData = ConfigTable.GetData_Item(nTid)
    self:SetPngSprite(self._mapNode.imgJade, itemCfgData.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtCount, nCount)
  end
  local _, unlockCoin = PlayerData.Mainline:IsMainlineLevelUnlock(self.levelData.Id)
  if not unlockCoin and 0 < self.levelData.UnlockItem then
    self._mapNode.goMask:SetActive(true)
    self._mapNode.goMaskBlack:SetActive(true)
    self._mapNode.btnUnlock.gameObject:SetActive(true)
    self._mapNode.btnSelect.gameObject:SetActive(false)
    self._mapNode.btnSelectComplete.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMP_UnlockCount, self.levelData.UnlockQty)
    self:SetSprite_Coin(self._mapNode.imgUnlockIcon, self.levelData.UnlockItem)
  else
    self._mapNode.goMask:SetActive(false)
    self._mapNode.btnSelect.gameObject:SetActive(nStar < 1)
    self._mapNode.btnSelectComplete.gameObject:SetActive(1 <= nStar)
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goJade)
end

function MainlineLevelCtrl:OnBtnClick_Unlock(btn)
  local function callback()
    local function wait()
      self._mapNode.goMask:SetActive(false)
    end
    
    local function wait1()
      self._mapNode.goMaskBlack:SetActive(false)
    end
    
    local function wait2()
      self:OnBtnClick_Select()
    end
    
    self._mapNode.unlockAnim:Play("unlock_in")
    CS.WwiseAudioManager.Instance:PostEvent("ui_mainline_unlock")
    self._mapNode.btnSelect.gameObject:SetActive(self.nStar < 1)
    self._mapNode.btnSelectComplete.gameObject:SetActive(self.nStar >= 1)
    self._mapNode.btnUnlock.gameObject:SetActive(false)
    self:AddTimer(1, 1.3, wait, true, true, true, nil)
    self:AddTimer(1, 0.3, wait1, true, true, true, nil)
    self:AddTimer(1, 0.7, wait2, true, true, true, nil)
  end
  
  local curCount = PlayerData.Item:GetItemCountByID(self.levelData.UnlockItem)
  if curCount >= self.levelData.UnlockQty then
    PlayerData.Mainline:NetMsg_UnlockMainline(self.levelData.Id, callback)
  else
    EventManager.Hit(EventId.OpenMessageBox, "解锁道具不足")
  end
end

function MainlineLevelCtrl:OnBtnClick_Select(btn)
  EventManager.Hit("SelectLevel", self.levelData.Id)
end

return MainlineLevelCtrl
