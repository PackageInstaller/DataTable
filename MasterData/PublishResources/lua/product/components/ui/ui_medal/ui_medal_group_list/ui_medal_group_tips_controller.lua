_class("UIMedalGroupTipsController", UIController)
UIMedalGroupTipsController = UIMedalGroupTipsController

function UIMedalGroupTipsController:Constructor()
end

function UIMedalGroupTipsController:OnShow(uiParams)
  self:InitWidget()
  self._medalid = uiParams[1]
  self._isBoard = uiParams[2]
  self._collect = uiParams[3]
  self:OnValue()
end

function UIMedalGroupTipsController:OnValue()
  local path
  local medalModule = GameGlobal.GetModule(MedalModule)
  local medalInfo, autoTake
  self.iconBg.gameObject:SetActive(self._isBoard)
  self.icon.gameObject:SetActive(not self._isBoard)
  local cfg_item = Cfg.cfg_item[self._medalid]
  if self._isBoard then
    medalInfo = medalModule:GetMedalBoardVec()
    local cfg = Cfg.cfg_item_medal_board[self._medalid]
    path = cfg.GetPathDesc
    autoTake = cfg.IsAutoTake
    local icon = cfg_item.Icon
    self.iconBg:LoadImage(icon)
  else
    medalInfo = medalModule:GetMedalVec()
    local cfg = Cfg.cfg_item_medal[self._medalid]
    if cfg then
      self.icon.sprite = self._atlas:GetSprite(cfg.Icon)
      self.icon:SetNativeSize()
    end
    path = cfg.GetPathDesc
    autoTake = cfg.IsAutoTake
  end
  local nam = cfg_item.Name
  local desc = cfg_item.RpIntro
  self.nam:SetText(StringTable.Get(nam))
  self.des:SetText(StringTable.Get(desc))
  self.path:SetText(StringTable.Get(path))
  if autoTake then
    local info = medalInfo[self._medalid]
    if info.status == RewardStatus.E_MEDAL_REWARD_RECVED then
      self._proGo:SetActive(false)
    else
      self._proGo:SetActive(true)
      local rate = 0
      local proValue = 0
      local proValueMax = 0
      if info.total_progress ~= nil then
        proValueMax = info.total_progress
      end
      if info.status == RewardStatus.E_MEDAL_REWARD_RECVED then
        rate = 1
        proValue = proValueMax
      elseif info.total_progress and info.total_progress ~= 0 then
        rate = info.cur_progress / info.total_progress
        proValue = info.cur_progress
      end
      local width = rate * 761
      self.proValImg.sizeDelta = Vector2(width, 20)
      self._proValue:SetText(proValue)
      self._proValueMax:SetText(string.format("/%d", proValueMax))
    end
  else
    self._proGo:SetActive(false)
  end
  self.have:SetActive(self._collect)
  self.nothave:SetActive(not self._collect)
end

function UIMedalGroupTipsController:InitWidget()
  self._atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
  self.nam = self:GetUIComponent("UILocalizationText", "txtName")
  self.des = self:GetUIComponent("UILocalizationText", "txtdesc")
  self.path = self:GetUIComponent("UILocalizationText", "txtGetWay")
  self.iconBg = self:GetUIComponent("RawImageLoader", "bgIcon")
  self.icon = self:GetUIComponent("Image", "imgIcon")
  self.proValImg = self:GetUIComponent("RectTransform", "proValImg")
  self.have = self:GetGameObject("have")
  self.nothave = self:GetGameObject("not")
  self._proGo = self:GetGameObject("proGo")
  self._proValue = self:GetUIComponent("UILocalizationText", "proValue")
  self._proValueMax = self:GetUIComponent("UILocalizationText", "proValueMax")
end

function UIMedalGroupTipsController:BgOnClick(go)
  self:CloseDialog()
end
