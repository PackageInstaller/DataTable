local UINLevelItem = class("UINLevelItem", UIBaseNode)
local base = UIBaseNode
local CS_DoTween = CS.DG.Tweening.DOTween
local SectorEnum = require("Game.Sector.SectorEnum")
local verticalAnchor = Vector2.New(0.5, 1)
local horizontalAnchor = Vector2.New(0, 0.5)
local bottomTweenSizeDelta = Vector2.New(295.25, 128.27)
local aniSelectTweenSizeDelta = Vector2.New(-10, -10)

function UINLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.OnClickLevelItem)
  self.bottomTweenSizeDeltaDefault = self.ui.buttom.transform.sizeDelta
  self.aniSelectTweenSizeDeltaDefault = self.ui.ani_Select.transform.sizeDelta
  self._challengeUISizeDefault = self.ui.challenge.sizeDelta.x
end

function UINLevelItem:InitSectorLevelItem(stageCfg, arrangeCfg, clickEvent, resLoader)
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
  self.ui.tex_Tile:SetIndex(0, LanguageUtil.GetLocaleText(stageCfg.name))
  self.ui.img_LevlelPic.enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_LevlelPic.sprite = AtlasUtil.GetResldSprite(spriteAtlas, stageCfg.pic)
    self.ui.img_LevlelPic.enabled = true
  end)
  if stageCfg.icon ~= nil and not string.IsNullOrEmpty(stageCfg.icon) then
    resLoader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorLevelIcon"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      local stageIcon = AtlasUtil.GetResldSprite(spriteAtlas, stageCfg.icon)
      self.ui.img_Pic.sprite = stageIcon
      self.ui.img_SubIcon.sprite = stageIcon
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

function UINLevelItem:UpdLvItemChallengeTask()
  if PlayerDataCenter.sectorAchievementDatas:HasStageChallengeTask(self.stageCfg.id) then
    self.ui.challenge.gameObject:SetActive(true)
    local size = self.ui.challenge.sizeDelta
    size.x = self._challengeUISizeDefault * #self.stageCfg.hard_task
    self.ui.challenge.sizeDelta = size
    local curNum = PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskCompleteNum(self.stageCfg.id)
    size = self.ui.img_ChallengeCur.sizeDelta
    size.x = self._challengeUISizeDefault * curNum
    self.ui.img_ChallengeCur.sizeDelta = size
  else
    self.ui.challenge.gameObject:SetActive(false)
  end
end

function UINLevelItem:OnClickLevelItem()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UINLevelItem:DisableSelectLevelItem(disable)
  if not self.isUnlock then
    return
  end
  self.isDisable = disable
  self:RefreshNoEntry()
end

function UINLevelItem:RefreshNoEntry()
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

function UINLevelItem:LevelItemShowContinue(show)
  self.ui.continue:SetActive(show)
  self.ui.clearLevel:SetActive(not show)
end

function UINLevelItem:SeletedLevelItem(select, withTween)
  self:__ClearSelectedSequence()
  local seq
  if withTween then
    seq = CS_DoTween.Sequence()
  end
  if select then
    self.ui.img_Pic.gameObject:SetActive(false)
    self.ui.clearLevelIcon:SetActive(false)
    self.ui.img_LevlelPic.gameObject:SetActive(true)
    if withTween then
      self.ui.ani_Select.transform.sizeDelta = self.aniSelectTweenSizeDeltaDefault
      local color = self.ui.img_LevlelPic.color
      color.a = 0
      self.ui.img_LevlelPic.color = color
      color = self.ui.ani_Select.color
      color.a = 1
      self.ui.ani_Select.color = color
      seq:Join(self.ui.buttom.transform:DOSizeDelta(bottomTweenSizeDelta, 0.25))
      seq:Join(self.ui.img_LevlelPic:DOFade(1, 0.25))
      seq:AppendCallback(function()
        self.ui.ani_Select.gameObject:SetActive(true)
      end)
    else
      self.ui.buttom.transform.sizeDelta = bottomTweenSizeDelta
      local color = self.ui.img_LevlelPic.color
      color.a = 1
      self.ui.img_LevlelPic.color = color
      self.ui.ani_Select.gameObject:SetActive(true)
    end
    self.__selectSizeTween = self.ui.ani_Select.transform:DOSizeDelta(aniSelectTweenSizeDelta, 1):SetLoops(-1)
    self.__selectFadeTween = self.ui.ani_Select:DOFade(0, 1):SetLoops(-1):SetDelay(0.3)
  else
    self.ui.ani_Select.gameObject:SetActive(false)
    if withTween then
      seq:Join(self.ui.buttom.transform:DOSizeDelta(self.bottomTweenSizeDeltaDefault, 0.25))
      seq:AppendCallback(function()
        self.ui.img_Pic.gameObject:SetActive(true)
        self.ui.img_LevlelPic.gameObject:SetActive(false)
        self:RefreshLevelState()
      end)
    else
      self.ui.buttom.transform.sizeDelta = self.bottomTweenSizeDeltaDefault
      self.ui.img_Pic.gameObject:SetActive(true)
      self.ui.img_LevlelPic.gameObject:SetActive(false)
      self:RefreshLevelState()
    end
  end
  self.__sequence = seq
end

function UINLevelItem:ShowBlueDotLevelItem(show)
  self.ui.blueDot:SetActive(show)
end

function UINLevelItem:RefreshLevelState()
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
  self.ui.unlockView:SetActive(showUnlockView)
  if 0 < self.stageCfg.show_item then
    self.ui.previewItem:SetActive(true)
    self.ui.img_PreviewItem.sprite = CRH:GetSpriteByItemId(self.stageCfg.show_item)
  else
    self.ui.previewItem:SetActive(false)
  end
end

function UINLevelItem:IsLevelUnlock()
  return self.isUnlock
end

function UINLevelItem:GetLevelStageData()
  return self.stageCfg
end

function UINLevelItem:__ClearSelectedSequence()
  if self.__sequence ~= nil then
    self.__sequence:Kill()
    self.__sequence = nil
  end
  if self.__selectSizeTween ~= nil then
    self.__selectSizeTween:Rewind()
    self.__selectSizeTween:Kill()
    self.__selectSizeTween = nil
    self.__selectFadeTween:Rewind()
    self.__selectFadeTween:Kill()
    self.__selectFadeTween = nil
  end
end

function UINLevelItem:OnReturnLevelItem()
  self:__ClearSelectedSequence()
end

function UINLevelItem:OnDelete()
  self:__ClearSelectedSequence()
  base.OnDelete(self)
end

return UINLevelItem
