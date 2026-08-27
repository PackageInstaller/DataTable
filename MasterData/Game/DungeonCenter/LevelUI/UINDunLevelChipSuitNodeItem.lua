local UINDunLevelChipSuitNodeItem = class("UINDunLevelChipSuitNodeItem", UIBaseNode)
local base = UIBaseNode
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINRichIntroButtom = require("Game.CommonUI.RichIntro.UINRichIntroButtom")
local UINSltChipSuitItemIntro = require("Game.DailyDungeon.UI.SelectChipSuit.List.UINSltChipSuitItemIntro")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")

function UINDunLevelChipSuitNodeItem:ctor(dunChipSuitNode)
  self._dunChipSuitNode = dunChipSuitNode
end

function UINDunLevelChipSuitNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chipItemPool = UIItemPool.New(UINChipItemPress, self.ui.uINChipItem)
  self.ui.uINChipItem.gameObject:SetActive(false)
  self.__ShowChipDesc = BindCallback(self, self._ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self._HideChipDesc)
  self.btnRichIntro = UINRichIntroButtom.New()
  self.btnRichIntro:Init(self.ui.obj_RichIntro)
  self.btnRichIntro:InitRichIntroButtom(BindCallback(self, self._OnClickShowIntro), true)
end

function UINDunLevelChipSuitNodeItem:RefreshIsUnlock(isUnlock, unlockInfo)
  self.ui.obj_wait2UnlockNode:SetActive(not isUnlock)
  if not isUnlock and unlockInfo ~= nil then
    self.ui.text_unlockWay:SetIndex(unlockInfo.index, unlockInfo.str)
  end
end

function UINDunLevelChipSuitNodeItem:RefreshChipSuitItem(chipSuitId, quality, showIntro)
  self.chipTagId = chipSuitId
  self._showIntro = showIntro
  self:_ShowIntroNode(showIntro)
  local chipTagCfg = ConfigData.chip_tag[chipSuitId]
  local tagSuitCfg = ConfigData.chip_tag.tag_suits[chipSuitId]
  self.ui.img_Icon.sprite = CRH:GetSprite(chipTagCfg.tag_icon, CommonAtlasType.ExplorationIcon)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(chipTagCfg.tag_name)
  local influenceId = chipTagCfg.influence
  local career = ConfigData.career[influenceId]
  if career == nil then
    self.ui.tex_Apply:SetIndex(1)
    self.ui.img_Career.enabled = false
  else
    self.ui.tex_Apply:SetIndex(0, LanguageUtil.GetLocaleText(career.name))
    self.ui.img_Career.sprite = CRH:GetSprite(career.icon, CommonAtlasType.CareerCamp)
    self.ui.img_Career.enabled = true
  end
  self.chipItemPool:HideAll()
  for index, chipId in ipairs(chipTagCfg.chip_list) do
    local chipData = ChipData.NewChipForLocal(chipId, quality)
    local chipItem = self.chipItemPool:GetOne()
    chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
  end
end

function UINDunLevelChipSuitNodeItem:_ShowChipDesc(chipData, chipItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local showDesc = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription(showDesc))
  win:FloatTo(chipItem.transform, FloatAlignEnum.HAType.right, FloatAlignEnum.VAType.up)
end

function UINDunLevelChipSuitNodeItem:_HideChipDesc(chipData, chipItem)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UINDunLevelChipSuitNodeItem:_OnClickShowIntro()
  self._showIntro = not self._showIntro
  self:_ShowIntroNode(self._showIntro)
  self._dunChipSuitNode:RecordDunChipSuitItemIntroState(self.chipTagId, self._showIntro)
  if self._showIntro then
    AudioManager:PlayAudioById(1072)
  end
end

function UINDunLevelChipSuitNodeItem:_ShowIntroNode(show)
  self.btnRichIntro:SwitchUIState(show)
  if show then
    if self.introNode == nil then
      local go = self.ui.introItem:Instantiate(self.ui.richIntroHolder)
      self.introNode = UINSltChipSuitItemIntro.New()
      self.introNode:Init(go)
    end
    self.introNode:Show()
    self.introNode:InitSltChipSuitItemIntro(self.chipTagId)
    self.ui.obj_normal:SetActive(false)
  elseif self.introNode ~= nil then
    self.introNode:Hide()
    self.ui.obj_normal:SetActive(true)
  end
end

function UINDunLevelChipSuitNodeItem:OnDelete()
  if self.introNode ~= nil then
    self.introNode:Delete()
  end
  base.OnDelete(self)
end

return UINDunLevelChipSuitNodeItem
