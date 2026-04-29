require("ui_activity_diff_level_node")
_class("UIActivityBlackBoxMainDiffLevelNode", UIActivityDiffLevelNode)
UIActivityBlackBoxMainDiffLevelNode = UIActivityBlackBoxMainDiffLevelNode

function UIActivityBlackBoxMainDiffLevelNode:OnInit()
  self._bIsSelect = false
  self._selectAnim = self:GetUIComponent("Animation", "Select")
  self._select = self:GetGameObject("Select")
  self._selectImg = self:GetUIComponent("RawImageLoader", "Select")
  self._normalImg = self:GetUIComponent("RawImageLoader", "Normal")
  self._lockImg = self:GetUIComponent("RawImageLoader", "Lock")
  self._unSelectColor = {
    Color(0.6431372549019608, 0.5058823529411764, 0.13725490196078433, 1),
    Color(0.5450980392156862, 0.3607843137254902, 0.12549019607843137, 1)
  }
  self._selectColor = {
    Color(0.1450980392156863, 0.13333333333333333, 0.12156862745098039, 1),
    Color(0.1568627450980392, 0.10196078431372549, 0.023529411764705882, 1)
  }
  self._bossUnSelectColor = {
    Color(0.8666666666666667, 0.6784313725490196, 0.5411764705882353, 1),
    Color(0.8666666666666667, 0.6784313725490196, 0.5411764705882353, 1)
  }
  self._bossSelectColor = {
    Color(0.996078431372549, 0.803921568627451, 0.5019607843137255, 1),
    Color(0.996078431372549, 0.803921568627451, 0.5019607843137255, 1)
  }
end

function UIActivityBlackBoxMainDiffLevelNode:SetData(data, campaign, cb)
  self._data = data
  self._campaign = campaign
  self._onClick = cb
  self._go:SetActive(true)
  self._rectTransform.anchorMax = Vector2(0, 0.5)
  self._rectTransform.anchorMin = Vector2(0, 0.5)
  self._rectTransform.sizeDelta = Vector2.zero
  self._rectTransform.anchoredPosition = self._data:GetPosition()
  self.name:SetText(self._data:GetNodeName())
  if self._data:IsOpen() then
    self._lock:SetActive(false)
    self._iconLoader:LoadImage(self._data:GetOpenIcon())
  else
    self._lock:SetActive(true)
    self._iconLoader:LoadImage(self._data:GetUnOpenIcon())
    self._unLockTips:SetText(self._data:GetLockTips())
  end
  self:RefreshCupInfo()
  local levelCfg = self._data:GetLevelCfg()
  local compId = levelCfg.ComponentID
  local cfg = Cfg.cfg_blackbox_main({ComponentID = compId})[1]
  self._lockImg:LoadImage(cfg.CommonLock)
  if levelCfg.Type == 1 then
    self._normalImg:LoadImage(cfg.CommonNormal)
    self._selectImg:LoadImage(cfg.CommonSelect)
  elseif levelCfg.Type == 2 then
    self._normalImg:LoadImage(cfg.BossNormal)
    self._selectImg:LoadImage(cfg.BossSelect)
  end
  self:SetSelect(false)
end

function UIActivityBlackBoxMainDiffLevelNode:SetSelect(bIsSelect)
  self._bIsSelect = bIsSelect
  local levelCfg = self._data:GetLevelCfg()
  if levelCfg.Type == 1 then
    self.name.color = self._bIsSelect and self._selectColor[2] or self._unSelectColor[2]
    self._cupNum.color = self._bIsSelect and self._selectColor[1] or self._unSelectColor[1]
  else
    self.name.color = self._bIsSelect and self._bossSelectColor[2] or self._bossUnSelectColor[2]
    self._cupNum.color = self._bIsSelect and self._bossSelectColor[1] or self._bossUnSelectColor[1]
  end
  if bIsSelect then
    self._selectAnim:Play("uieff_UIActivityBlackBoxMainNode_select")
  else
    self._selectAnim:Play("uieff_UIActivityBlackBoxMainNode_out")
  end
end

function UIActivityBlackBoxMainDiffLevelNode:BtnOnClick()
  if not self._campaign:CheckComponentOpen(ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION) then
    local result = self._campaign:CheckComponentOpenClientError(ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION)
    self._campaign:CheckErrorCode(result)
    return
  end
  if not self._data:IsOpen() then
    local lockTip = self._data:GetLockTipsNoST()
    local s = StringTable.Get(lockTip, self._data:GetLastNodeName())
    ToastManager.ShowToast(s)
    return
  end
  self._onClick(self._data, self)
end

function UIActivityBlackBoxMainDiffLevelNode:GetDiffLevelID()
  return self._data._missionId
end
