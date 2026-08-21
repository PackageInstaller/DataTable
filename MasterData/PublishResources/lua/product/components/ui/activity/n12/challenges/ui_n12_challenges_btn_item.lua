_class("UIN12ChallengesbtnItem", UICustomWidget)
UIN12ChallengesbtnItem = UIN12ChallengesbtnItem

function UIN12ChallengesbtnItem:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UIN12ChallengesbtnItem:OnShow(uiParams)
  self:_SetValue()
  self:_GetComponents()
end

function UIN12ChallengesbtnItem:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "_name")
  self._scoretxt = self:GetUIComponent("UILocalizationText", "_score")
  self._lockname = self:GetUIComponent("UILocalizationText", "_lockname")
  self._unlock = self:GetGameObject("_unlock")
  self._lock = self:GetGameObject("_lock")
  self._state_select = self:GetGameObject("_state_select")
  self._bg = self:GetUIComponent("RawImageLoader", "_bg")
  self._icon = self:GetUIComponent("Image", "_icon")
  self._iconobj = self:GetGameObject("_iconobj")
  self._cg = self:GetUIComponent("RawImageLoader", "_cg")
  self._cgRaw = self:GetUIComponent("RawImage", "_cg")
  self._atlas = self:GetAsset("UIN12.spriteatlas", LoadType.SpriteAtlas)
end

function UIN12ChallengesbtnItem:_SetValue(uiParams)
  self._idx = 0
  self._cfg = nil
  self._campaign = nil
  self._callback = nil
  self._islock = false
  self._images = {}
  self._images[true] = "n12_renwu_tab_xuanzhong"
  self._images[false] = "n12_renwu_tab_weixuan"
  self._scorecolors = {}
  self._scorecolors[true] = Color.white
  self._scorecolors[false] = Color.New(0.6039215686274509, 0.5490196078431373, 0.5019607843137255)
  self._namecolors = {}
  self._namecolors[true] = Color.New(0.15294117647058825, 0.12156862745098039, 0.09803921568627451)
  self._namecolors[false] = Color.New(0.6039215686274509, 0.5490196078431373, 0.5019607843137255)
end

function UIN12ChallengesbtnItem:SetData(score, idx, callback, date, curidx)
  self._cfg = Cfg.cfg_component_challenge_mission({
    CampaignMissionId = date[1]
  })[1]
  self._cfg_task = Cfg.cfg_n12_challenges_task()[idx]
  self._unlockTime = date[2]
  self._score = score
  self._idx = idx
  self._callback = callback
  self:SetSelect(curidx == self._idx)
  self:_SetShow()
end

function UIN12ChallengesbtnItem:_SetShow()
  self._cg:LoadImage(self._cfg_task.BoosPicture)
  self._cg.transform.localPosition = Vector3(self._cfg_task.TranceformBtn[1], self._cfg_task.TranceformBtn[2], 0)
  self._cg.transform.localScale = Vector3(self._cfg_task.TranceformBtn[3], self._cfg_task.TranceformBtn[3], 1)
  self._name:SetText(StringTable.Get(self._cfg.MissionName))
  self._lockname:SetText(StringTable.Get(self._cfg.MissionName))
  local score = ""
  if self._score == 0 then
    score = StringTable.Get("str_n12_not_challenge")
  else
    score = string.format("%10s", self._score) .. string.format("%4s", "")
  end
  self._scoretxt:SetText(score)
  self:_SetState(true)
  if self:_CheckUnLock() then
    self._scoretxt:SetText(StringTable.Get("str_n12_not_open"))
    self:_SetState(false)
  end
end

function UIN12ChallengesbtnItem:_SetState(islock)
  self._islock = islock
  self._iconobj.gameObject:SetActive(islock)
  self._lock:SetActive(not islock)
end

function UIN12ChallengesbtnItem:SetSelect(isSelect)
  local str = ""
  self._state_select:SetActive(isSelect)
  self._bg:LoadImage(self._images[isSelect])
  self._name.color = self._namecolors[isSelect]
  self._scoretxt.color = self._scorecolors[isSelect]
  if isSelect then
    str = "n12_icon_3000236_1"
  else
    str = "n12_icon_3000236_2"
  end
  self._icon.sprite = self._atlas:GetSprite(str)
end

function UIN12ChallengesbtnItem:_btnOnClick(go)
  if self._callback and self._islock then
    self._callback(self._idx)
  else
    ToastManager.ShowToast(StringTable.Get("str_n12_task_tips"))
  end
end

function UIN12ChallengesbtnItem:_CheckUnLock()
  local remainTime = self._unlockTime - self._svrTimeModule:GetServerTime() * 0.001
  return 0 < remainTime
end
