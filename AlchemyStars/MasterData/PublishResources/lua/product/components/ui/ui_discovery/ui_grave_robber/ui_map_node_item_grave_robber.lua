_class("UIMapNodeItemGraveRobber", UICustomWidget)
UIMapNodeItemGraveRobber = UIMapNodeItemGraveRobber

function UIMapNodeItemGraveRobber:Constructor()
  self.mCampaign = GameGlobal.GetModule(CampaignModule)
  self.grassData = self.mCampaign:GetGraveRobberData()
  self._vec0_5 = Vector2.one * 0.5
end

function UIMapNodeItemGraveRobber:OnShow()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self.img = self:GetGameObject("img")
  self.imgClear = self:GetGameObject("imgClear")
  self.imgClick = self:GetGameObject("imgClick")
  self.imgClick:SetActive(false)
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.cd = self:GetGameObject("cd")
  self.rtCD = self:GetUIComponent("RollingText", "txtCD")
  self:AttachEvent(GameEventType.GrassClose, self.CloseGrass)
  self:Init()
end

function UIMapNodeItemGraveRobber:OnHide()
  self:DetachEvent(GameEventType.GrassClose, self.CloseGrass)
end

function UIMapNodeItemGraveRobber:Init()
  self._rectTransform.anchorMax = self._vec0_5
  self._rectTransform.anchorMin = self._vec0_5
  self._rectTransform.sizeDelta = Vector2.zero
end

function UIMapNodeItemGraveRobber:CloseGrass()
  self:ShowHideNode(false)
end

function UIMapNodeItemGraveRobber:ShowHideNode(isShow)
  self._rectTransform.gameObject:SetActive(isShow)
end

function UIMapNodeItemGraveRobber:Flush(node, clickCallback)
  self.node = node
  self.clickCallback = clickCallback
  if not node:State() then
    self:ShowHideNode(false)
    return
  end
  self:ShowHideNode(true)
  self._rectTransform.anchoredPosition = node.pos
  if node:State() == DiscoveryStageState.Nomal then
    self.img:SetActive(false)
    self.imgClear:SetActive(true)
    self.cd:SetActive(false)
  else
    self.img:SetActive(true)
    self.imgClear:SetActive(false)
    self.cd:SetActive(true)
    local cInfo = self.grassData:GetComponentInfoGrassMission()
    self:FlushCDText(cInfo.m_close_time)
  end
  self.txtName:SetText(node.name)
end

function UIMapNodeItemGraveRobber:FlushCDText(time)
  local strs = {
    "str_activity_grass_escape_after_d_h",
    "str_activity_grass_escape_after_h_m",
    "str_activity_grass_escape_after_m",
    "str_activity_grass_escape_after_lt_m"
  }
  local leftSeconds = UICommonHelper.CalcLeftSeconds(time)
  local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
  if 1 <= d then
    self.rtCD:RefreshText(StringTable.Get(strs[1], math.floor(d), math.floor(h)))
  elseif 1 <= h then
    self.rtCD:RefreshText(StringTable.Get(strs[2], math.floor(h), math.floor(m)))
  elseif 1 <= m then
    self.rtCD:RefreshText(StringTable.Get(strs[3], math.floor(m)))
  else
    self.rtCD:RefreshText(StringTable.Get(strs[4], math.ceil(m)))
  end
end

function UIMapNodeItemGraveRobber:imgOnClick()
  self:ClickItem()
end

function UIMapNodeItemGraveRobber:imgClearOnClick()
  self:ClickItem()
end

function UIMapNodeItemGraveRobber:ClickItem()
  if not self.node:State() then
    return
  end
  self:StartTask(function(TT)
    self:Lock("UIMapNodeItemGraveRobberClickItem")
    self.imgClick:SetActive(true)
    YIELD(TT, 100)
    self.imgClick:SetActive(false)
    self:UnLock("UIMapNodeItemGraveRobberClickItem")
    local ui = self:RootUIOwner()
    ui.fsm:ChangeState(StateDiscovery.Move2GrassNode, self.node, function()
      if self.clickCallback then
        self.clickCallback()
      end
    end)
  end, self)
end
