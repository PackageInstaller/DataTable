local UINLevelSimpleItem = class("UINLevelSimpleItem", UIBaseNode)
local base = UIBaseNode
local SectorEnum = require("Game.Sector.SectorEnum")
local verticalAnchor = Vector2.New(0.5, 1)
local horizontalAnchor = Vector2.New(0, 0.5)

function UINLevelSimpleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.OnClickLevelItem)
  self._challengeUISizeDefault = self.ui.challengeBg.sizeDelta.x
end

function UINLevelSimpleItem:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
  self.clickEvent = clickEvent
  self.stageCfg = stageCfg
  local stageId = ConfigData:GetSectorIdShow(stageCfg.sector)
  if ConfigData.sector.onlyShowStageIdSectorDic[stageCfg.sector] then
    local descStr = SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber]
    self.ui.tex_SubTile.text = string.format(descStr, stageCfg.num)
  else
    local descStr
    if stageCfg.special_arrange > 0 then
      local descType = ConfigData.level_arrange.pos_tag_dic[stageCfg.special_arrange]
      descStr = SectorEnum.SectorLevelItemDesc[descType]
    else
      descStr = SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.Normal]
    end
    self.ui.tex_SubTile.text = string.format(descStr, stageId, stageCfg.num)
  end
  self.ui.tex_Tile.text = LanguageUtil.GetLocaleText(stageCfg.name)
  if stageCfg.icon ~= nil and not string.IsNullOrEmpty(stageCfg.icon) then
    resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
      if spriteAtlas == nil or IsNull(self.transform) then
        return
      end
      local stageIcon = AtlasUtil.GetResldSprite(spriteAtlas, stageCfg.icon)
      self.ui.img_Pic.sprite = stageIcon
    end)
  end
  self:RefreshLevelState()
  self:LevelItemShowContinue(false)
  if arrangeCfg.vertical then
    self.transform.anchorMin = verticalAnchor
    self.transform.anchorMax = verticalAnchor
  else
    self.transform.anchorMin = horizontalAnchor
    self.transform.anchorMax = horizontalAnchor
  end
  self.transform.anchoredPosition = Vector2.New(arrangeCfg.pos[1], arrangeCfg.pos[2])
  self:SeletedLevelItem(false, false)
  self:UpdLvItemChallengeTask()
end

function UINLevelSimpleItem:UpdLvItemChallengeTask()
  if PlayerDataCenter.sectorAchievementDatas:HasStageChallengeTask(self.stageCfg.id) then
    self.ui.challenge:SetActive(true)
    local size = self.ui.challengeBg.sizeDelta
    size.x = self._challengeUISizeDefault * #self.stageCfg.hard_task
    self.ui.challengeBg.sizeDelta = size
    local curNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskCompleteNum(self.stageCfg.id)
    size = self.ui.img_ChallengeCur.sizeDelta
    size.x = self._challengeUISizeDefault * curNum
    self.ui.img_ChallengeCur.sizeDelta = size
  else
    self.ui.challenge.gameObject:SetActive(false)
  end
end

function UINLevelSimpleItem:OnClickLevelItem()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UINLevelSimpleItem:DisableSelectLevelItem(disable)
  if not self.isUnlock then
    return
  end
  self.isDisable = disable
  self:RefreshNoEntry()
end

function UINLevelSimpleItem:RefreshNoEntry()
  if not self.isUnlock or self.isDisable then
    self.ui.clearLevelIcon:SetActive(false)
    self.ui.noEntry:SetActive(true)
    if self.isDisable then
      self.ui.img_NoEntry:SetIndex(0)
    else
      self.ui.img_NoEntry:SetIndex(1)
    end
  else
    self.ui.noEntry:SetActive(false)
    self.ui.clearLevelIcon:SetActive(self.isClear)
  end
end

function UINLevelSimpleItem:LevelItemShowContinue(show)
  self.ui.continue:SetActive(show)
  if self.isClear then
    self.ui.clearLevel:SetActive(not show)
  end
end

function UINLevelSimpleItem:SeletedLevelItem(select, withTween)
  self.ui.obj_Select:SetActive(select)
end

function UINLevelSimpleItem:ShowBlueDotLevelItem(show)
  self.ui.blueDot:SetActive(show)
end

function UINLevelSimpleItem:RefreshLevelState()
  self.isClear = PlayerDataCenter.sectorStage:IsStageComplete(self.stageCfg.id)
  self.ui.clearLevel:SetActive(self.isClear)
  self.isUnlock = PlayerDataCenter.sectorStage:IsStageUnlock(self.stageCfg.id)
  self:RefreshNoEntry()
  local showUnlockView = false
  if not self.isClear then
    local systeId = ConfigData.system_open.mainLevelUnlock[self.stageCfg.id]
    if systeId ~= nil and 0 < systeId then
      showUnlockView = true
      self.ui.tex_UnlockView.text = LanguageUtil.GetLocaleText(ConfigData.system_open[systeId].name)
    end
  end
  self.ui.go_unlockView:SetActive(showUnlockView)
end

function UINLevelSimpleItem:IsLevelUnlock()
  return self.isUnlock
end

function UINLevelSimpleItem:GetLevelStageData()
  return self.stageCfg
end

return UINLevelSimpleItem
