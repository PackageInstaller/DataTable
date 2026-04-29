_class("UIDiffStageCupItem", UICustomWidget)
UIDiffStageCupItem = UIDiffStageCupItem

function UIDiffStageCupItem:OnShow(uiParam)
  self:GetComponents()
end

function UIDiffStageCupItem:GetComponents()
  self._descTex = self:GetUIComponent("UILocalizationText", "desc")
  self._img = self:GetUIComponent("Image", "img")
  self._bg = self:GetUIComponent("Image", "bg")
  self._awardGo = self:GetGameObject("award")
  self._awardIcon = self:GetUIComponent("RawImageLoader", "awardIcon")
  self._awardCount = self:GetUIComponent("UILocalizationText", "awardCount")
  self._atlas = self:GetAsset("UIDiffMission.spriteatlas", LoadType.SpriteAtlas)
end

function UIDiffStageCupItem:OnValue()
  local cfg = Cfg.cfg_difficulty_mission_enties[self._id]
  if not cfg then
    Log.error("###[UIDiffStageCupItem] cfg is nil ! id --> ", self._id)
  end
  self._desc = ""
  local cond = cfg.Cond
  if cond then
    local desc = cfg.Desc
    if desc then
      local uiModoule = GameGlobal.GetUIModule(DifficultyMissionModule)
      self._desc = uiModoule:GetDiffMissionEnties(desc)
    end
  end
  self._descTex:SetText(self._desc)
  self._award = nil
  local awards = cfg.Rewards
  if awards then
    local award = ItemAsset:New()
    award.id = awards[1][1]
    award.count = awards[1][2]
    self._award = award
  end
  local sprite, bg
  if self._finish then
    sprite = self._atlas:GetSprite("map_black_icon02")
    bg = self._atlas:GetSprite("map_black_di02")
    self._award = nil
  else
    sprite = self._atlas:GetSprite("map_black_icon03")
    bg = self._atlas:GetSprite("map_black_di03")
  end
  self._img.sprite = sprite
  self._bg.sprite = bg
  self._awardGo:SetActive(self._award ~= nil)
  if self._award then
    local cfg_item = Cfg.cfg_item[self._award.id]
    if not cfg_item then
      Log.error("###[UIDiffStageCupItem] cfg_item is nil ! id --> ", self._award.id)
    end
    self._awardIcon:LoadImage(cfg_item.Icon)
    self._awardCount:SetText(self._award.count)
  end
end

function UIDiffStageCupItem:SetData(id, finish)
  self._id = id
  self._finish = finish
  self:OnValue()
end

function UIDiffStageCupItem:OnHide()
end
