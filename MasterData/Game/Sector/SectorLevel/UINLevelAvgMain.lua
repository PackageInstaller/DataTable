local UINLevelAvgMain = class("UINLevelAvgMain", UIBaseNode)
local base = UIBaseNode
local SectorEnum = require("Game.Sector.SectorEnum")
local verticalAnchor = Vector2.New(0.5, 1)
local horizontalAnchor = Vector2.New(0, 0.5)
local aniSelectTweenSizeDelta = Vector2.New(10, 10)

function UINLevelAvgMain:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.OnClickLevelAvgMain)
end

function UINLevelAvgMain:InitLAvgMain(avgCfg, arrangeCfg, clickEvent, resLoader)
  self.avgCfg = avgCfg
  self.clickEvent = clickEvent
  self.ui.img_Pic.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Pic.sprite = AtlasUtil.GetResldSprite(spriteAtlas, avgCfg.pic)
    self.ui.img_Pic.enabled = true
  end)
  self.ui.tex_Tile.text = LanguageUtil.GetLocaleText(avgCfg.name)
  local descStr
  if avgCfg.type == eAvgTriggerType.MainAvg then
    local stageCfg = ConfigData.sector_stage[avgCfg.set_place]
    if stageCfg.special_arrange > 0 then
      local descType = ConfigData.level_arrange.pos_tag_dic[stageCfg.special_arrange]
      descStr = SectorEnum.SectorAvgItemDesc[descType]
    end
  end
  if descStr == nil then
    descStr = SectorEnum.SectorAvgItemDesc[SectorEnum.eSectorLevelItemType.Normal]
  end
  self.ui.tex_SubTile.text = string.format(descStr, avgCfg.number)
  self:RefreshLAvgMainState()
  if arrangeCfg.vertical then
    self.transform.anchorMin = verticalAnchor
    self.transform.anchorMax = verticalAnchor
  else
    self.transform.anchorMin = horizontalAnchor
    self.transform.anchorMax = horizontalAnchor
  end
  self.transform.anchoredPosition = Vector2.New(arrangeCfg.pos[1], arrangeCfg.pos[2])
  self:SelectedLAvgMain(false)
end

function UINLevelAvgMain:OnClickLevelAvgMain()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UINLevelAvgMain:SelectedLAvgMain(select)
  self.ui.obj_Select:SetActive(select)
  self:__ClearTween()
  if select and not IsNull(self.ui.ani_Select) then
    self.__selectSizeTween = self.ui.ani_Select.transform:DOSizeDelta(aniSelectTweenSizeDelta, 1):SetLoops(-1)
    self.__selectFadeTween = self.ui.ani_Select:DOFade(0, 1):SetLoops(-1):SetDelay(0.3)
  end
end

function UINLevelAvgMain:ShowBlueDotLAvgMain(show)
  self.ui.blueDot:SetActive(show)
end

function UINLevelAvgMain:RefreshLAvgMainState()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  self.isUnlock = avgPlayCtrl:IsAvgUnlock(self.avgCfg.id)
  self.ui.noEntry:SetActive(not self.isUnlock)
  self.ui.clearLevel:SetActive(avgPlayCtrl:IsAvgPlayed(self.avgCfg.id))
end

function UINLevelAvgMain:IsLAvgMainUnlock()
  return self.isUnlock
end

function UINLevelAvgMain:GetLAvgMainCfg()
  return self.avgCfg
end

function UINLevelAvgMain:__ClearTween()
  if self.__selectSizeTween ~= nil then
    self.__selectSizeTween:Rewind()
    self.__selectSizeTween:Kill()
    self.__selectSizeTween = nil
    self.__selectFadeTween:Rewind()
    self.__selectFadeTween:Kill()
    self.__selectFadeTween = nil
  end
end

function UINLevelAvgMain:OnReturnLAvgMainItem()
  self:__ClearTween()
end

function UINLevelAvgMain:OnDelete()
  self:__ClearTween()
  base.OnDelete(self)
end

return UINLevelAvgMain
