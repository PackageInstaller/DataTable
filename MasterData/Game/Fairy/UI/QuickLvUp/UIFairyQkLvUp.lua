local base = UIBaseWindow
local UIFairyQkLvUp = class("UIFairyQkLvUp", base)
local UINFairyQkLvStarItem = require("Game.Fairy.UI.QuickLvUp.UINFairyQkLvStarItem")
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")
local UINFairyRightConsumeItem = require("Game.Fairy.UI.Right.UINFairyRightConsumeItem")
local UINFairyCultivateCardItem = require("Game.Fairy.UI.UINFairyCultivateCardItem")
local UINFairyQkLvFiltItem = require("Game.Fairy.UI.QuickLvUp.UINFairyQkLvFiltItem")
local FairyFilterEnum = require("Game.Fairy.UI.ListFilter.FairyFilterEnum")
local FairySkillData = require("Game.Fairy.Data.FairySkillData")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
local cs_MessageCommon = CS.MessageCommon

function UIFairyQkLvUp:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_MinusStar, self, self._OnClickMinusStar)
  UIUtil.AddButtonListener(self.ui.btn_PlusStar, self, self._OnClickPlusStar)
  UIUtil.AddButtonListener(self.ui.btn_Upgrade, self, self._OnClickUpgrade)
  UIUtil.AddButtonListener(self.ui.btn_SkillDetail, self, self._OnClickSkillDetail)
  UIUtil.AddValueChangedListener(self.ui.sliderLv, self, self._OnLvSliderChange)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnClickClose):SetTopStatusResData({
    ConstGlobalItem.FairyExp,
    ConstGlobalItem.FairyStarUpItem,
    ConstGlobalItem.FairyRecombineItem
  }):SetTopStatusVisible(true):SetTopStatusInfoFunc(function()
    GuidePicture.OpenGuidePicture(74)
  end):PushTopStatusDataToBackStack()
  self._starItemPool = UIItemPool.New(UINFairyQkLvStarItem, self.ui.starItem, false)
  self._skillItemPool = UIItemPool.New(UINFairySkillItem, self.ui.uINElfSkillItem, false)
  self._costItemPool = UIItemPool.New(UINFairyRightConsumeItem, self.ui.costItem, false)
  self._OnClickSkillFunc = BindCallback(self, self._OnClickSkill)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._fyItemDic = {}
  self._clickFyFunc = BindCallback(self, self._OnClickFyItem)
  self.resloader = CS.ResLoader.Create()
  local onFilterChangeFunc = BindCallback(self, self._OnFilterChange)
  local filtStarPool = UIItemPool.New(UINFairyQkLvFiltItem, self.ui.capItem, false)
  for i = 1, FairyFilterEnum.eKindMaxCount[FairyFilterEnum.eKindType.Rank] - 1 do
    local item = filtStarPool:GetOne()
    item:InitFairyQkLvFiltItem(FairyFilterEnum.eKindType.Rank, i, onFilterChangeFunc)
  end
  local filtQualityPool = UIItemPool.New(UINFairyQkLvFiltItem, self.ui.qualityItem, false)
  for i = 1, FairyFilterEnum.eKindMaxCount[FairyFilterEnum.eKindType.Quality] do
    local item = filtQualityPool:GetOne()
    item:InitFairyQkLvFiltItem(FairyFilterEnum.eKindType.Quality, i, onFilterChangeFunc)
  end
  self.__onItemUpdate = BindCallback(self, self.OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__onFairyUpdate = BindCallback(self, self.OnFairyUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
end

function UIFairyQkLvUp:InitFairyQkLvUp(fairyData, closeFunc)
  self._closeFunc = closeFunc
  self._fairyData = fairyData
  self._fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  self:_InitState()
end

function UIFairyQkLvUp:_InitState()
  self._curSelectedFairyNum = 0
  self._costFairyTotal = 0
  self._SelectedFyDataDic = {}
  self._costItemDic = table.emptytable
  self._costItemPreDic = table.emptytable
  self.ui.tex_ElfName.text = self._fairyData:GetFairyCurName()
  self._targetStar = self._fairyData:GetFairyCurStar()
  local maxStar = self._fairyData:GetMaxStar()
  self._starItemPool:HideAll()
  for i = 1, maxStar do
    local starItem = self._starItemPool:GetOne()
  end
  self:_UpdStar()
  local curLv = self._fairyData:GetFairyCurLevel()
  self._targetLv = curLv
  local curMaxLv = self._fairyData:GetCurStarMaxLevel()
  self.ui.tex_lvlUpBefore.text = tostring(curMaxLv)
  local maxLv = self._fairyData:GetMaxStarMaxLevel()
  self.ui.sliderLv.minValue = 1
  self.ui.sliderLv.maxValue = maxLv
  self.ui.sliderLv.value = curLv
  self:_CalculateCost()
  self:_RefreshFyDogeData()
  self:_RefillList()
  self:_UpdLevel()
end

function UIFairyQkLvUp:_UpdStar()
  local curStar = self._fairyData:GetFairyCurStar()
  for k, starItem in ipairs(self._starItemPool.listItem) do
    if k <= curStar then
      starItem:InitFairyQkLvStarItem(1)
    elseif k <= self._targetStar then
      starItem:InitFairyQkLvStarItem(2)
    else
      starItem:InitFairyQkLvStarItem(3)
    end
  end
  local curMaxLv = self._fairyData:GetCurStarMaxLevel()
  local targetMaxLv = self._fairyData:GetFyStarMaxLevel(self._targetStar)
  self.ui.lvMaxUpTip:SetActive(curMaxLv < targetMaxLv)
  if curMaxLv < targetMaxLv then
    self.ui.tex_lvlUpAfter.text = tostring(targetMaxLv)
  end
  local curSkillNum = self._fairyData:GetMaxSkillNum()
  local targetSkillNum = self._fairyData:GetFyStarSkillNum(self._targetStar)
  local skillNumAdd = targetSkillNum - curSkillNum
  self.ui.skillAdd:SetActive(0 < skillNumAdd)
  if 0 < skillNumAdd then
    self.ui.tex_SkillAdd:SetIndex(0, tostring(skillNumAdd))
  end
end

function UIFairyQkLvUp:_OnLvSliderChange(value, noCalculate)
  local lastMaxLv = self._targetStar == 1 and 1 or self._fairyData:GetFyStarMaxLevel(self._targetStar - 1)
  local curMaxLv = self._fairyData:GetFyStarMaxLevel(self._targetStar)
  local lvStart = math.max(lastMaxLv, self._fairyData:GetFairyCurLevel())
  local targetLv = math.clamp(FormatNum(value), lvStart, curMaxLv)
  self.ui.sliderLv:SetValueWithoutNotify(targetLv)
  if self._targetLv == targetLv then
    return
  end
  self._targetLv = targetLv
  self:_UpdLevel()
  if not noCalculate then
    self:_CalculateCost()
  end
end

function UIFairyQkLvUp:_UpdLevel()
  local maxLv = self._fairyData:GetMaxStarMaxLevel()
  self.ui.tex_Lvl:SetIndex(0, tostring(self._targetLv), tostring(maxLv))
end

local function getLvUpCostFunc(fromLv, targetLv)
  local expCost = 0
  for i = fromLv, targetLv - 1 do
    local lvCfg = ConfigData.fairy_level[i]
    expCost = expCost + lvCfg.exp
  end
  return expCost
end

function UIFairyQkLvUp:_CalculateCost()
  local curLv = self._fairyData:GetFairyCurLevel()
  local expCost = getLvUpCostFunc(curLv, self._targetLv)
  local costItemDic = table.GetDefaulValueTable(0)
  if 0 < expCost then
    costItemDic[ConstGlobalItem.FairyExp] = expCost
  end
  local costFairy = 0
  local curStar = self._fairyData:GetFairyCurStar()
  for i = curStar, self._targetStar - 1 do
    local starCfg = ConfigData.fairy_star_new[i]
    for itemId, needNum in pairs(starCfg.cost) do
      costItemDic[itemId] = costItemDic[itemId] + needNum
    end
    costFairy = costFairy + 2 ^ (i - 1)
  end
  self._costItemPreDic = costItemDic
  self._costFairyTotal = FormatNum(costFairy)
  self:_UpdDogNum()
  self:_UpdUpgradeBtn()
  self:_RefreshFyDogeData()
  self:_RefillList()
  self:_UpdItemCost()
  self:_UpdSkillList()
end

function UIFairyQkLvUp:_UpdItemCost()
  self._costItemPool:HideAll()
  if self._costFairyTotal ~= self._curSelectedFairyNum then
    return
  end
  local costItemDic = table.GetDefaulValueTable(0)
  for k, v in pairs(self._costItemPreDic) do
    costItemDic[k] = v
  end
  local minDogStar = math.maxinteger
  local fyStartNumDic = {}
  for k, fyData in pairs(self._SelectedFyDataDic) do
    local star = fyData:GetFairyCurStar()
    fyStartNumDic[star] = fyStartNumDic[star] or {}
    table.insert(fyStartNumDic[star], fyData)
    minDogStar = math.min(minDogStar, star)
  end
  local upStarNumDic = table.GetDefaulValueTable(0)
  local needExp = 0
  for i = minDogStar, self._targetStar - 1 do
    local fyList = fyStartNumDic[i]
    local fyNum = (fyList and #fyList or 0) + upStarNumDic[i]
    if not (fyNum <= 0) then
      local starUpNum = fyNum // 2
      if 0 < starUpNum then
        local needLvUpNum = starUpNum
        if fyList and 0 < #fyList then
          table.sort(fyList, function(a, b)
            return a:GetFairyCurLevel() > b:GetFairyCurLevel()
          end)
          local lvUpNum = math.min(#fyList, needLvUpNum)
          for i = 1, lvUpNum do
            local fyData = fyList[i]
            local curLv = fyData:GetFairyCurLevel()
            local targetLv = fyData:GetCurStarMaxLevel()
            needExp = needExp + getLvUpCostFunc(curLv, targetLv)
          end
          needLvUpNum = needLvUpNum - lvUpNum
        end
        if 0 < needLvUpNum and 0 < upStarNumDic[i] then
          if needLvUpNum > upStarNumDic[i] then
            error("needLvUpNum > upStarNumDic[i]")
          end
          local startLv = i <= 1 and 1 or ConfigData.fairy_star_new[i - 1].level_max
          local targetLv = ConfigData.fairy_star_new[i].level_max
          needExp = needExp + getLvUpCostFunc(startLv, targetLv) * needLvUpNum
        end
        local starCfg = ConfigData.fairy_star_new[i]
        for itemId, needNum in pairs(starCfg.cost) do
          costItemDic[itemId] = costItemDic[itemId] + needNum * starUpNum
        end
        upStarNumDic[i + 1] = starUpNum
      end
    end
  end
  if 0 < needExp then
    costItemDic[ConstGlobalItem.FairyExp] = costItemDic[ConstGlobalItem.FairyExp] + needExp
  end
  self._costItemDic = costItemDic
  for itemId, itemNum in pairs(costItemDic) do
    local costItem = self._costItemPool:GetOne()
    costItem:InitFairyRightConsumeItem(itemId, itemNum)
  end
end

function UIFairyQkLvUp:_UpdDogNum()
  self.ui.tex_DogNum:SetIndex(0, tostring(self._curSelectedFairyNum), tostring(self._costFairyTotal))
  self.ui.tex_Title:SetIndex(0, tostring(self._curSelectedFairyNum), tostring(self._costFairyTotal))
  local colorIdx = self._curSelectedFairyNum == self._costFairyTotal and 2 or 1
  self.ui.selectNum.color = self.ui.color_SelectNum[colorIdx]
  local selectFyOk = 0 < self._costFairyTotal and self._curSelectedFairyNum == self._costFairyTotal
  if selectFyOk ~= self._selectFairyOk then
    self._selectFairyOk = selectFyOk
    self.ui.scrollRect:RefreshCells()
  end
  self.ui.selectNum.gameObject:SetActive(0 < self._costFairyTotal)
  local existLvUp = false
  for k, fyData in pairs(self._SelectedFyDataDic) do
    if 1 < fyData:GetFairyCurLevel() then
      existLvUp = true
      break
    end
  end
  self.ui.obj_Tip:SetActive(existLvUp)
end

function UIFairyQkLvUp:_OnClickMinusStar()
  self:_OffsetTargetStar(-1)
end

function UIFairyQkLvUp:_OnClickPlusStar()
  self:_OffsetTargetStar(1)
end

function UIFairyQkLvUp:_OffsetTargetStar(value)
  local curStar = self._fairyData:GetFairyCurStar()
  local maxStar = self._fairyData:GetMaxStar()
  self._targetStar = math.clamp(self._targetStar + value, curStar, maxStar)
  self._SelectedFyDataDic = {}
  self._curSelectedFairyNum = 0
  self:_UpdStar()
  self:_OnLvSliderChange(self._targetLv, true)
  self:_CalculateCost()
end

function UIFairyQkLvUp:_UpdUpgradeBtn()
  local canUp = self._targetStar > self._fairyData:GetFairyCurStar() or self._targetLv > self._fairyData:GetFairyCurLevel()
  if self._costFairyTotal > 0 and self._curSelectedFairyNum ~= self._costFairyTotal then
    canUp = false
  end
  for itemId, needNum in pairs(self._costItemDic) do
    if not canUp then
      break
    end
    if needNum > PlayerDataCenter:GetItemCount(itemId) then
      canUp = false
    end
  end
  self.ui.tex_Up.color = canUp and Color.white or Color.gray
  self.ui.btn_Upgrade.targetGraphic.color = canUp and Color.white or Color.gray
end

function UIFairyQkLvUp:_OnClickUpgrade()
  local canUp = self._targetStar > self._fairyData:GetFairyCurStar() or self._targetLv > self._fairyData:GetFairyCurLevel()
  if not canUp then
    return
  end
  if self._costFairyTotal > 0 and self._curSelectedFairyNum ~= self._costFairyTotal then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22002))
    return
  end
  for itemId, needNum in pairs(self._costItemDic) do
    if needNum > PlayerDataCenter:GetItemCount(itemId) then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22019))
      return
    end
  end
  local dogUidDic = {}
  for uid, fyData in pairs(self._SelectedFyDataDic) do
    dogUidDic[uid] = true
  end
  local uid = self._fairyData:GetFairyUID()
  NetworkManager:GetNetwork(NetworkTypeID.Fairy):CS_Fairy_FastUpgrade(uid, self._targetLv, dogUidDic, self._targetStar, function(objList)
    if objList == nil or objList.Count == 0 then
      error("objList == nil or objList.Count == 0")
      return
    end
    UIUtil.OnClickBackByUiTab(self)
    local msg = objList[0]
    if msg.keepData == nil or table.IsEmptyTable(msg.keepData.keepSkills) then
      local win = UIManager:GetWindow(UIWindowTypeID.FairyCultivateMain)
      if win then
        win:PlayFairyNormalLevelUpEffect()
      end
      return
    end
    self._fairyCtrl:ShowFyKeepSkillSelect(self._fairyData)
    local win = UIManager:GetWindow(UIWindowTypeID.FairyCultivateMain)
    if win then
      win:ClearSortDataSelect(false)
    end
  end)
end

local function SiftFunction(fairyData, sortKindData)
  local realSortKindData = sortKindData
  if realSortKindData == nil then
    return true
  end
  local rankConfig = realSortKindData[FairyFilterEnum.eKindType.Rank]
  local rankOk = rankConfig == nil or table.IsEmptyTable(rankConfig) or rankConfig[fairyData:GetFairyCurStar()]
  local qualityConfig = realSortKindData[FairyFilterEnum.eKindType.Quality]
  local qualityOk = qualityConfig == nil or table.IsEmptyTable(qualityConfig) or qualityConfig[fairyData:GetCurFairyQuality()]
  if rankOk and qualityOk then
    return true
  else
    return false
  end
end

function UIFairyQkLvUp:_OnFilterChange(kindType, index, select)
  self._sortKindData = self._sortKindData or {}
  self._sortKindData[kindType] = self._sortKindData[kindType] or {}
  if select then
    self._sortKindData[kindType][index] = true
  else
    self._sortKindData[kindType][index] = nil
  end
  self:_RefreshFyDogeData()
  self:_RefillList()
end

function UIFairyQkLvUp:_RefreshFyDogeData()
  if self._costFairyTotal <= 0 then
    self._fairyDataList = table.emptytable
    return
  end
  local fairyDataDic = self._fairyCtrl:GetFairyDataDic()
  self._fairyDataList = {}
  for uid, fyData in pairs(fairyDataDic) do
    if not fyData:GetIsFavouriteFairy() and fyData ~= self._fairyData and SiftFunction(fyData, self._sortKindData) and fyData:GetFairyCurStar() < self._targetStar then
      table.insert(self._fairyDataList, fyData)
    end
  end
  table.sort(self._fairyDataList, function(a, b)
    local qA = a:GetCurFairyQuality()
    local qB = b:GetCurFairyQuality()
    if qA ~= qB then
      return qA < qB
    end
    local starA = a:GetFairyCurStar()
    local starB = b:GetFairyCurStar()
    if starA ~= starB then
      return starA > starB
    end
    local lvA = a:GetFairyCurLevel()
    local lvB = b:GetFairyCurLevel()
    if lvA ~= lvB then
      return lvA > lvB
    end
    return a:GetFairyID() < b:GetFairyID()
  end)
end

function UIFairyQkLvUp:_RefillList()
  self.ui.scrollRect.totalCount = #self._fairyDataList
  self.ui.scrollRect:RefillCells()
  if self._costFairyTotal > 0 and #self._fairyDataList == 0 then
    self.ui.tip_NoFairy.gameObject:SetActive(true)
    self.ui.tip_NoFairy:SetIndex(0)
  elseif self._costFairyTotal == 0 then
    self.ui.tip_NoFairy.gameObject:SetActive(true)
    self.ui.tip_NoFairy:SetIndex(1)
  else
    self.ui.tip_NoFairy.gameObject:SetActive(false)
  end
end

function UIFairyQkLvUp:__OnNewItem(go)
  local item = UINFairyCultivateCardItem.New()
  item:Init(go)
  self._fyItemDic[go] = item
end

function UIFairyQkLvUp:__OnChangeItem(go, index)
  local item = self._fyItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local fyData = self._fairyDataList[index + 1]
  if fyData == nil then
    return
  end
  item:InitFairyCultivateCardItem(fyData, index + 1, self.resloader, self._clickFyFunc)
  item:IgnoreFyCardItemBlockClick()
  local isSelected = self._SelectedFyDataDic[fyData:GetFairyUID()] ~= nil
  item:SetInteriorSelected(isSelected)
  item:SetMaskAndIndex(self._selectFairyOk and not isSelected)
end

function UIFairyQkLvUp:_OnClickFyItem(index, fairyData, fyItem)
  local uid = fairyData:GetFairyUID()
  local star = fairyData:GetFairyCurStar()
  local sign = 1
  local curSelectedFairyNum = self._curSelectedFairyNum
  if self._SelectedFyDataDic[uid] == nil then
    if curSelectedFairyNum >= self._costFairyTotal then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22018))
      return
    end
    curSelectedFairyNum = curSelectedFairyNum + (1 << star - 1)
    if curSelectedFairyNum > self._costFairyTotal then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(22018))
      return
    end
    self._SelectedFyDataDic[uid] = fairyData
    fyItem:SetInteriorSelected(true)
  else
    self._SelectedFyDataDic[uid] = nil
    fyItem:SetInteriorSelected(false)
    curSelectedFairyNum = curSelectedFairyNum - (1 << star - 1)
  end
  self._curSelectedFairyNum = curSelectedFairyNum
  self:_UpdDogNum()
  self:_UpdSkillList()
  self:_UpdItemCost()
  self:_UpdUpgradeBtn()
end

function UIFairyQkLvUp:_UpdSkillList()
  local fySkillDataDic = {}
  local skillDataList = {}
  
  local function searchSkillFunc(fyData)
    for slot, fySkillData in pairs(fyData:GetFairySkillDic()) do
      local realSkillId = fySkillData:GetFiaryRealSkillId()
      if fySkillDataDic[realSkillId] == nil or fySkillDataDic[realSkillId]:GetFairySkillRareLevel() > fySkillData:GetFairySkillRareLevel() then
        fySkillDataDic[realSkillId] = fySkillData
      end
    end
  end
  
  for k, fyData in pairs(self._SelectedFyDataDic) do
    searchSkillFunc(fyData)
  end
  searchSkillFunc(self._fairyData)
  for k, fySkillData in pairs(fySkillDataDic) do
    table.insert(skillDataList, fySkillData)
  end
  table.sort(skillDataList, function(a, b)
    local qA = a:GetFairySkillRareLevel()
    local qB = b:GetFairySkillRareLevel()
    if qA ~= qB then
      return qA < qB
    end
    return a.fairySkillId < b.fairySkillId
  end)
  self._skillItemPool:HideAll()
  for k, skillData in ipairs(skillDataList) do
    local skillItem = self._skillItemPool:GetOne()
    skillItem:InitFairySkillItem(skillData, self.resloader, self._OnClickSkillFunc)
  end
end

function UIFairyQkLvUp:_OnClickSkill(fairySkillData, isSelected, item)
  UIManager:ShowWindowAsync(UIWindowTypeID.FairySkillDetailFloat, function(win)
    if win == nil then
      return
    end
    win:InitFaitySkillDetailFloat(fairySkillData, item.transform)
  end)
end

function UIFairyQkLvUp:_OnClickSkillDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.FairySkillDetails, function(window)
    if window == nil then
      return
    end
    window:InitFairySkillDetailsNode(self._fairyData)
  end)
end

function UIFairyQkLvUp:OnItemUpdate()
  self:_UpdItemCost()
  self:_UpdUpgradeBtn()
end

function UIFairyQkLvUp:OnFairyUpdate(haveChange, fairyCtrl)
  self:_RefreshFyDogeData()
  self:_RefillList()
end

function UIFairyQkLvUp:_OnClickClose()
  self:Delete()
  if self._closeFunc then
    self._closeFunc()
  end
end

function UIFairyQkLvUp:OnDelete()
  self.resloader:Put2Pool()
  self.resloader = nil
  for k, v in pairs(self._fyItemDic) do
    v:Delete()
  end
  self._skillItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UpdateFairy, self.__onFairyUpdate)
  base.OnDelete(self)
end

return UIFairyQkLvUp
