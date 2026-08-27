local UINSelectChipSuitListItem = class("UINSelectChipSuitListItem", UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local UINSltChipSuitItemIntro = require("Game.DailyDungeon.UI.SelectChipSuit.List.UINSltChipSuitItemIntro")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local UINRichIntroButtom = require("Game.CommonUI.RichIntro.UINRichIntroButtom")

function UINSelectChipSuitListItem:ctor(seChipSuitList)
  self.seChipSuitList = seChipSuitList
end

function UINSelectChipSuitListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
  self.ui.uINChipItem.gameObject:SetActive(false)
  self.chipItemPool = UIItemPool.New(UINChipItemPress, self.ui.uINChipItem)
  self.__ShowChipDesc = BindCallback(self, self._ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self._HideChipDesc)
  self.btnRichIntro = UINRichIntroButtom.New()
  self.btnRichIntro:Init(self.ui.obj_RichIntro)
  self.btnRichIntro:InitRichIntroButtom(BindCallback(self, self._OnClickShowIntro), true)
end

function UINSelectChipSuitListItem:InitSelectChipSuitListItem(seChipSuitData, showIntro, selected)
  self.seChipSuitData = seChipSuitData
  local dynChipSuitData = seChipSuitData.dynChipSuitData
  self.chipTagId = dynChipSuitData.tagId
  self._selected = selected
  self._showIntro = showIntro
  self:_ShowIntroNode(showIntro)
  self:_ShowSelect(selected)
  local influenceId = dynChipSuitData:GetSuitChipInfluence()
  local career = ConfigData.career[influenceId]
  if career == nil then
    self.ui.tex_Apply:SetIndex(1)
    self.ui.img_Career.enabled = false
  else
    self.ui.tex_Apply:SetIndex(0, LanguageUtil.GetLocaleText(career.name))
    self.ui.img_Career.sprite = CRH:GetSprite(career.icon, CommonAtlasType.CareerCamp)
    self.ui.img_Career.enabled = true
  end
  self.ui.img_Light.color = self.ui.highlightColors[influenceId] or Color.white
  self.ui.img_Icon.sprite = dynChipSuitData:GetChipSuitIconSprite()
  self.ui.tex_Name.text = dynChipSuitData:GetChipSuitName()
  local notShowCouldUseTime = seChipSuitData.notShowCouldUseTime
  self.ui.tex_Count.gameObject:SetActive(not notShowCouldUseTime)
  if not notShowCouldUseTime then
    local canUseNum = math.max(seChipSuitData.selectNumMax - seChipSuitData.selectNumCur, 0)
    self.ui.tex_Count:SetIndex(0, tostring(canUseNum), tostring(seChipSuitData.selectNumMax))
  end
  local useUp = seChipSuitData.selectNumCur >= seChipSuitData.selectNumMax
  self.ui.obj_NoCount:SetActive(useUp)
  self.ui.btn_root.interactable = not useUp
  self.ui.obj_wait2UnlockNode:SetActive(false)
  self.ui.Img_Recommend:SetActive(seChipSuitData.isRecommend)
  self.chipItemPool:HideAll()
  local chipIdList = dynChipSuitData:GetSuitChipList()
  for k, chipId in ipairs(chipIdList) do
    local chipData = ChipData.NewChipForLocal(chipId, seChipSuitData.chipQuality)
    local chipItem = self.chipItemPool:GetOne()
    chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
  end
end

function UINSelectChipSuitListItem:InitLockedState(chipPoolId, unlockInfo)
  local chipTagCfg = ConfigData.chip_tag[chipPoolId]
  local tagSuitCfg = ConfigData.chip_tag.tag_suits[chipPoolId]
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
  self.ui.img_Light.color = self.ui.highlightColors[influenceId] or Color.white
  self.ui.tex_Count.gameObject:SetActive(false)
  self.ui.obj_NoCount:SetActive(false)
  self.ui.btn_root.interactable = false
  self.ui.obj_wait2UnlockNode:SetActive(true)
  if unlockInfo ~= nil then
    self.ui.text_unlockWay:SetIndex(unlockInfo.index, unlockInfo.str)
  end
  self.chipItemPool:HideAll()
  local chipTagCfg = ConfigData.chip_tag[chipPoolId]
  local chipIdList = chipTagCfg.chip_list
  for k, chipId in ipairs(chipIdList) do
    local chipData = ChipData.NewChipForLocal(chipId, 1)
    local chipItem = self.chipItemPool:GetOne()
    chipItem:InitChipItemWithPress(chipData, false, nil, nil)
  end
end

function UINSelectChipSuitListItem:_ShowChipDesc(chipData, chipItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local showDesc = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription(showDesc))
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

function UINSelectChipSuitListItem:_HideChipDesc(chipData, chipItem)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UINSelectChipSuitListItem:_OnClickRoot()
  local selected = not self._selected
  if not self.seChipSuitList:TrySelectChipSuitItem(self.chipTagId, selected) then
    return
  end
  self._selected = selected
  self:_ShowSelect(self._selected)
  if self._selected then
    AudioManager:PlayAudioById(1058)
  end
end

function UINSelectChipSuitListItem:_ShowSelect(show)
  if show then
    if IsNull(self.selectObj) then
      self.selectObj = self.ui.obj_IsSelect:Instantiate(self.transform)
      self.selectObj.transform.anchoredPosition = Vector2.zero
    end
    self.selectObj:SetActive(true)
  elseif not IsNull(self.selectObj) then
    self.selectObj:SetActive(false)
  end
  self.ui.img_IsSel:SetIndex(show and 1 or 0)
end

function UINSelectChipSuitListItem:_OnClickShowIntro()
  self._showIntro = not self._showIntro
  self:_ShowIntroNode(self._showIntro)
  self.seChipSuitList:RecordSeChipSuitListItemIntroState(self.chipTagId, self._showIntro)
  if self._showIntro then
    AudioManager:PlayAudioById(1072)
  end
end

function UINSelectChipSuitListItem:_ShowIntroNode(show)
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

function UINSelectChipSuitListItem:OnDelete()
  self.chipItemPool:DeleteAll()
  if self.introNode ~= nil then
    self.introNode:Delete()
  end
  self.btnRichIntro:Delete()
  base.OnDelete(self)
end

return UINSelectChipSuitListItem
