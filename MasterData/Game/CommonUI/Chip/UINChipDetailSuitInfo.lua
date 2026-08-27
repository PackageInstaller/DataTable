local UINChipDetailSuitInfo = class("UINChipDetailSuitInfo", UIBaseNode)
local base = UIBaseNode
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local ChipData = require("Game.PlayerData.Item.ChipData")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_TweenLoopType = CS.DG.Tweening.LoopType

function UINChipDetailSuitInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  self.ui.obj_Text:SetActive(false)
  self.suitDescPool = UIItemPool.New(UINEpChipSuitDescItem, self.ui.obj_Text)
  self.ui.uINChipItem:SetActive(false)
  self.chipItemPool = UIItemPool.New(UINChipItemPress, self.ui.uINChipItem)
  self.__ShowChipDesc = BindCallback(self, self._ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self._HideChipDesc)
end

function UINChipDetailSuitInfo:InitChipDetailSuitInfo(chipTagId, curChipData, closeCallback)
  self.chipTagId = chipTagId
  self.curChipData = curChipData
  self.closeCallback = closeCallback
  self:RefreshSuitInfo(chipTagId, curChipData)
end

function UINChipDetailSuitInfo:RefreshSuitInfo(chipTagId, curChipData)
  local chipTagCfg = ConfigData.chip_tag[chipTagId]
  local dynPlayer = BattleUtil.GetCurDynPlayer(true)
  local normalChipDic = table.emptytable
  local tmpBuffChipDic = table.emptytable
  if dynPlayer ~= nil then
    normalChipDic = dynPlayer:GetNormalChipDic()
    tmpBuffChipDic = dynPlayer:GetTmpBuffChipDic()
  end
  local previewChipDataDic = ExplorationManager:GetChipDataPreviewDic(true)
  local chipDataList = {}
  local haveCount = 0
  local haveCurChip = false
  for _, chipId in ipairs(chipTagCfg.chip_list) do
    local chipData
    local have = false
    if normalChipDic[chipId] ~= nil then
      chipData = normalChipDic[chipId]
      have = true
    elseif tmpBuffChipDic[chipId] ~= nil then
      chipData = tmpBuffChipDic[chipId]
      have = true
    else
      chipData = previewChipDataDic[chipId]
      if chipData == nil then
        chipData = ChipData.NewChipForLocal(chipId)
      end
    end
    if chipData.dataId == curChipData.dataId then
      if have then
        haveCurChip = true
      end
      have = true
    end
    if have then
      haveCount = haveCount + 1
      table.insert(chipDataList, haveCount, chipData)
    else
      table.insert(chipDataList, chipData)
    end
  end
  self.chipItemPool:HideAll()
  for index, chipData in pairs(chipDataList) do
    local chipItem = self.chipItemPool:GetOne()
    chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
    chipItem:UnlockChipItem(index <= haveCount)
    if chipData.dataId == curChipData.dataId then
      self.ui.img_CurChip.transform:SetParent(chipItem.transform)
      self.ui.img_CurChip.transform.localPosition = Vector3.zero
      self:TweenChipSelectAlpha()
    end
  end
  local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  self.suitDescPool:HideAll()
  local tagSuitCfg = ConfigData.chip_tag.tag_suits[chipTagId]
  for _, tag_suit in pairs(tagSuitCfg) do
    local chipDescItem = self.suitDescPool:GetOne()
    local active = false
    if haveCount >= tag_suit.number then
      active = true
    end
    chipDescItem:InitSuitDescItem(tag_suit.number, active, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail))
    if active and not haveCurChip and haveCount - 1 < tag_suit.number then
      chipDescItem:TweenEpChipSuitDescItem()
    end
  end
end

function UINChipDetailSuitInfo:_ShowChipDesc(chipData, chipItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription())
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

function UINChipDetailSuitInfo:_HideChipDesc(chipData, chipItem)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UINChipDetailSuitInfo:TweenChipSelectAlpha()
  self.ui.img_CurChip:DOKill(true)
  self.ui.img_CurChip.color = Color.white
  local t = Time.time % 1.4
  self.ui.img_CurChip:DOFade(Color.New(1, 1, 1, 0.5), 0.7):From():SetLoops(-1, cs_TweenLoopType.Yoyo):SetLink(self.gameObject):Goto(t, true)
end

function UINChipDetailSuitInfo:_OnClickClose()
  self:Hide()
  if self.closeCallback ~= nil then
    self.closeCallback({})
  end
end

function UINChipDetailSuitInfo:OnDelete()
  self.suitDescPool:DeleteAll()
  self.chipItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINChipDetailSuitInfo
