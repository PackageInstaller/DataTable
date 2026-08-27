local UIEpChipSuit = class("UIEpChipSuit", UIBaseWindow)
local base = UIBaseWindow
local UINEpChipSuitItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitItem")
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local ChipData = require("Game.PlayerData.Item.ChipData")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UIEpChipSuit:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnBtnReturnClicked)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnBtnReturnClicked)
  UIUtil.AddButtonListener(self.ui.btn_SuitDetail, self, self.OnBtnChipSuitDetail)
  self.ui.chipSuitItem:SetActive(false)
  self.ui.suitDescItem:SetActive(false)
  self.ui.chipItem:SetActive(false)
  self.ui.simpleSuitItem:SetActive(false)
  self.ui.btn_SuitDetail.gameObject:SetActive(false)
  self.chipSuitPool = UIItemPool.New(UINEpChipSuitItem, self.ui.chipSuitItem)
  self.simpleChipSuitPool = UIItemPool.New(UINEpChipSuitItem, self.ui.simpleSuitItem)
  self.suitDescPool = UIItemPool.New(UINEpChipSuitDescItem, self.ui.suitDescItem)
  self.chipItemPool = UIItemPool.New(UINChipItemPress, self.ui.chipItem)
  self.__ShowChipDesc = BindCallback(self, self.ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self.HideChipDesc)
  self.__chipSuitClick = BindCallback(self, self.OnChipSuitItemClick)
  self.__OnEpChipSuitItemClicked = BindCallback(self, self.OnEpChipSuitItemClicked)
  self.__onChipSuitUpdate = BindCallback(self, self.RefreshChipSuitList)
  MsgCenter:AddListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
end

function UIEpChipSuit:InitEpChipSuit(dynplayer, OnCloseCallback)
  self.__dynplayer = dynplayer or BattleUtil.GetCurDynPlayer()
  self.OnCloseCallback = OnCloseCallback
end

function UIEpChipSuit:RefreshChipSuitSimpleUI()
  self.simpleChipSuitPool:HideAll()
  local suitList = self.__dynplayer:GetChipSuitSortList()
  self.ui.btn_SuitDetail.gameObject:SetActive(0 < #suitList)
  for i = 1, #suitList do
    local chipSuit = suitList[i]
    local chipSuitItem = self.simpleChipSuitPool:GetOne()
    chipSuitItem.gameObject.name = tostring(chipSuit.tagId)
    chipSuitItem:InitEpChipSuitItem(chipSuit, self.__OnEpChipSuitItemClicked)
  end
end

function UIEpChipSuit:RefreshChipSuitDetailUI(tagId)
  self.__selectChipItem = nil
  self:RefreshChipSuitList(tagId)
  self:_LocateScrollPos(self.ui.scroll_chipSuit.verticalNormalizedPosition)
end

function UIEpChipSuit:RefreshChipSuitList(tagId)
  local dynplayer = self.__dynplayer
  local selectChipSuit
  if self.__selectChipItem ~= nil then
    selectChipSuit = self.__selectChipItem:GetDynChipSuit()
    self.__selectChipItem = nil
  end
  self.chipSuitPool:HideAll()
  local chiplist = dynplayer:GetChipSuitSortList()
  if BattleUtil.IsInDailyDungeon() then
    local dungeonDyncElem = PlayerDataCenter.dungeonDyncData:GetDailyDungeonDyncData()
    if dungeonDyncElem ~= nil then
      local lastChipGroup = dungeonDyncElem.lastChipGroup
      if lastChipGroup ~= nil then
        table.sort(chiplist, function(a, b)
          local v1 = lastChipGroup[a.tagId]
          local v2 = lastChipGroup[b.tagId]
          if v1 ~= nil and v2 ~= nil and v1 ~= v2 then
            return v1 < v2
          end
          return a.tagId < b.tagId
        end)
      end
    end
  end
  if #chiplist <= 0 then
    self.suitDescPool:HideAll()
    self.chipItemPool:HideAll()
    self.ui.suitTitleNode:SetActive(false)
    self.ui.suitSelectNode:SetActive(false)
    return
  else
    self.ui.suitTitleNode:SetActive(true)
    self.ui.suitSelectNode:SetActive(true)
  end
  for _, chipSuit in pairs(chiplist) do
    local chipSuitItem = self.chipSuitPool:GetOne()
    chipSuitItem:InitEpChipSuitItem(chipSuit, self.__chipSuitClick)
    if chipSuit == selectChipSuit then
      self.__selectChipItem = chipSuitItem
    elseif self.__selectChipItem == nil and chipSuit.tagId == tagId then
      self.__selectChipItem = chipSuitItem
    end
  end
  if self.__selectChipItem == nil then
    self.__selectChipItem = self.chipSuitPool.listItem[1]
  end
  self:HideChipDesc()
  self:__RefreshSelectChipSuit(self.__selectChipItem)
end

function UIEpChipSuit:_LocateScrollPos(verticalNormalizedPosition)
  if verticalNormalizedPosition ~= nil then
    CS.UnityEngine.Canvas.ForceUpdateCanvases()
    self.ui.scroll.verticalNormalizedPosition = verticalNormalizedPosition
    return
  end
  if self.__selectChipItem == nil then
    return
  end
  for i, v in ipairs(self.chipSuitPool.listItem) do
    if v == self.__selectChipItem then
      CS.UnityEngine.Canvas.ForceUpdateCanvases()
      local scrollHeight = self.ui.scroll.transform.rect.height
      local rectHeight = self.ui.scroll.content.rect.height
      local overRectIndex = math.floor(scrollHeight / (rectHeight / #self.chipSuitPool.listItem))
      if i > overRectIndex then
        do
          local allOverCount = #self.chipSuitPool.listItem - overRectIndex
          local overCount = i - overRectIndex
          self.ui.scroll.verticalNormalizedPosition = 1 - overCount / allOverCount
        end
        break
      end
      self.ui.scroll.verticalNormalizedPosition = 1
      break
    end
  end
end

function UIEpChipSuit:OnChipSuitItemClick(chipSuitItem)
  if self.__selectChipItem == chipSuitItem then
    return
  end
  self.__selectChipItem = chipSuitItem
  self:__RefreshSelectChipSuit(chipSuitItem)
end

function UIEpChipSuit:__RefreshSelectChipSuit(chipSuitItem)
  self.ui.suitSelectNode.transform:SetParent(chipSuitItem.transform)
  self.ui.suitSelectNode.transform.localPosition = Vector3.zero
  local chipSuit = chipSuitItem:GetDynChipSuit()
  self.ui.tex_TagName.text = chipSuit:GetChipSuitName()
  self.ui.img_TagIcon.sprite = chipSuit:GetChipSuitIconSprite()
  self.chipItemPool:HideAll()
  local normalChipDic = self.__dynplayer:GetNormalChipDic()
  local tmpBuffChipDic = self.__dynplayer:GetTmpBuffChipDic()
  local chipDataList = {}
  local haveCount = 0
  local previewChipDataDic = ExplorationManager:GetChipDataPreviewDic(true)
  for _, chipId in pairs(chipSuit:GetSuitChipList()) do
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
    if have then
      haveCount = haveCount + 1
      table.insert(chipDataList, haveCount, chipData)
    else
      table.insert(chipDataList, chipData)
    end
  end
  for index, chipData in pairs(chipDataList) do
    local chipItem = self.chipItemPool:GetOne()
    chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
    chipItem:UnlockChipItem(index <= haveCount)
  end
  local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  self.suitDescPool:HideAll()
  local count = chipSuit:GetChipSuitCount()
  for _, tag_suit in pairs(chipSuit.tagSuitCfg) do
    local chipDescItem = self.suitDescPool:GetOne()
    local active = false
    if count >= tag_suit.number then
      active = true
    end
    chipDescItem:InitSuitDescItem(tag_suit.number, active, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail))
  end
end

function UIEpChipSuit:ShowChipDesc(chipData, chipItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local showDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription(showDetail))
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

function UIEpChipSuit:HideChipDesc(chipData, chipItem)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UIEpChipSuit:OnBtnReturnClicked()
  self:_SetDetailUIActive(false)
end

function UIEpChipSuit:OnBtnChipSuitDetail()
  self:_SetDetailUIActive(true)
  self:RefreshChipSuitDetailUI(nil)
end

function UIEpChipSuit:OnEpChipSuitItemClicked(chipSuitItem)
  self:_SetDetailUIActive(true)
  local chipSuit = chipSuitItem:GetDynChipSuit()
  self:RefreshChipSuitDetailUI(chipSuit.tagId)
end

function UIEpChipSuit:_SetDetailUIActive(active)
  if active then
    AudioManager:PlayAudioById(1070)
  else
    AudioManager:PlayAudioById(1071)
  end
  self.ui.obj_chipSuitNode:SetActive(not active)
  self.ui.obj_chipSuitDetail:SetActive(active)
  self.ui.btn_background.gameObject:SetActive(active)
end

function UIEpChipSuit:OnDelete()
  if self.OnCloseCallback ~= nil then
    self.OnCloseCallback()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
  base.OnDelete(self)
end

return UIEpChipSuit
