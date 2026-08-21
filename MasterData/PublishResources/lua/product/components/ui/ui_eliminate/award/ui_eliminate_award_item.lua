_class("UIEliminateAwardItem", UICustomWidget)
UIEliminateAwardItem = UIEliminateAwardItem

function UIEliminateAwardItem:Constructor()
  self._status = EliminateAwardStatus.Received
end

function UIEliminateAwardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIEliminateAwardItem:_GetComponents()
  self._assetContent = self:GetUIComponent("UISelectObjectPath", "Asset")
  self._scoreTxt = self:GetUIComponent("UILocalizationText", "scoreTxt")
  self._topBg = self:GetUIComponent("Image", "topBg")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._animObj = self:GetGameObject("anim")
  self._getMaskObj = self:GetGameObject("GetMask")
  self._canReceiveMaskObj = self:GetGameObject("CanReceiveMask")
end

function UIEliminateAwardItem:SetData(itemInfo, index, receiveCallback, clickCallback)
  self._itemInfo = itemInfo
  self._index = index
  self._receiveCallback = receiveCallback
  self._clickCallback = clickCallback
  self:_InitComponents()
end

function UIEliminateAwardItem:_InitComponents()
  self._ownerController = self:RootUIOwner()
  self._atlas = self._ownerController.atlas
  self._scoreTxt:SetText(self._itemInfo.Score)
  self._asset = self._assetContent:SpawnObject("UIAsset")
  local cfg = Cfg.cfg_item[self._itemInfo.ID]
  local param = {}
  param.text = self._itemInfo.Num
  param.quality = cfg.Color
  param.icon = cfg.Icon
  param.showBG = true
  self._asset:SetData(self._itemInfo.ID)
  self._asset:SetItemData(param)
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local weekInfo = anipopInfo.week_info
  if table.icontains(weekInfo.score_received, self._itemInfo.CfgID) then
    self._getMaskObj:SetActive(true)
    self._canReceiveMaskObj:SetActive(false)
    self._status = EliminateAwardStatus.Received
    self._topBg.sprite = self._atlas:GetSprite("N37_qdhl_jf_di03")
    self._scoreTxt.color = Color(0, 0, 0)
  elseif self._itemInfo.Score <= weekInfo.total_score and not table.icontains(weekInfo.score_received, self._itemInfo.CfgID) then
    self._getMaskObj:SetActive(false)
    self._canReceiveMaskObj:SetActive(true)
    self._status = EliminateAwardStatus.CanReceive
    self._topBg.sprite = self._atlas:GetSprite("N37_qdhl_jf_di04")
    self._scoreTxt.color = Color(1, 0.8705882352941177, 0.5254901960784314)
  else
    self._getMaskObj:SetActive(false)
    self._canReceiveMaskObj:SetActive(false)
    self._status = EliminateAwardStatus.CantReceive
    self._topBg.sprite = self._atlas:GetSprite("N37_qdhl_jf_di03")
    self._scoreTxt.color = Color(0, 0, 0)
  end
  self:StartTask(function(TT)
    local yieldTime = (self._index - 1) * 30
    YIELD(TT, yieldTime)
    if not tolua.isnull(self._animObj) then
      self._anim:Play("uieff_UIEliminateAwardItem_in")
    end
  end)
end

function UIEliminateAwardItem:FullBtnOnClick(go)
  if self._status == EliminateAwardStatus.CanReceive then
    if self._receiveCallback then
      self._receiveCallback(self._itemInfo.CfgID)
    end
  elseif self._clickCallback then
    self._clickCallback(self._itemInfo.ID, go.transform.position)
  end
end

function UIEliminateAwardItem:GetScore()
  return self._itemInfo.Score
end

function UIEliminateAwardItem:GetCfgID()
  return self._itemInfo.CfgID
end

local EliminateAwardStatus = {
  CantReceive = 1,
  CanReceive = 2,
  Received = 3
}
_enum("EliminateAwardStatus", EliminateAwardStatus)
