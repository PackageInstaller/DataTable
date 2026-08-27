local UINChristmas22TechSpeicalSide = class("UINChristmas22TechSpeicalSide", UIBaseNode)
local base = UIBaseNode
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINChristmasBuffItem = require("Game.ActivityChristmas.UI.Tech.UINChristmasBuffItem")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")
UINChristmas22TechSpeicalSide.ePageEnum = {strategyInfoNode = 1, buffList = 2}

function UINChristmas22TechSpeicalSide:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnClickReset)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickDetail)
  UIUtil.AddButtonListener(self.ui.btn_Clear, self, self.OnClickLv)
  UIUtil.AddButtonListener(self.ui.btn_lock, self, self.OnClickLv)
  UIUtil.AddButtonListener(self.ui.btn_BuffView, self, self.OnClickBuff)
  self._buffItemPool = UIItemPool.New(UINChristmasBuffItem, self.ui.infoItem)
  self.ui.infoItem:SetActive(false)
end

function UINChristmas22TechSpeicalSide:InitChristmas22TechSpeicalSide(actTechTree, specialBranchId, resloader)
  self._data = actTechTree
  self._branchId = specialBranchId
  self._resloader = resloader
  self:__SetUIPageState(self.ePageEnum.strategyInfoNode)
  self:RefreshChristmas22TechSpeicalSide()
end

function UINChristmas22TechSpeicalSide:__SetUIPageState(pageEnumId)
  if self._curShowPage == self.ePageEnum.buffList then
    for i, v in ipairs(self._buffItemPool.listItem) do
      v:SetBuffItemNew(false)
    end
  end
  self._curShowPage = pageEnumId
  self.ui.buffList:SetActive(pageEnumId == self.ePageEnum.buffList)
  self.ui.strategyInfoNode:SetActive(pageEnumId == self.ePageEnum.strategyInfoNode)
  self.ui.arrowUp:SetActive(pageEnumId == self.ePageEnum.strategyInfoNode)
  self.ui.arrowDown:SetActive(pageEnumId == self.ePageEnum.buffList)
end

function UINChristmas22TechSpeicalSide:SetChristmas22LogicDesType(desType)
  self._desType = desType
end

function UINChristmas22TechSpeicalSide:BindChrismas22TechSpeicalSide(lvCallback, resetCallback, detailCallback)
  self._lvCallback = lvCallback
  self._resetCallback = resetCallback
  self._detailCallback = detailCallback
end

function UINChristmas22TechSpeicalSide:RefreshChristmas22TechSpeicalSide()
  self._needRefreshInfoNode = true
  self._needRefreshBuffNode = true
  local level = self._data:GetTechBranchLevel(0)
  self.ui.tex_StrategyLvl:SetIndex(0, tostring(level))
  self.ui.btn_Refresh.gameObject:SetActive(0 < level)
  if self._curShowPage == self.ePageEnum.buffList then
    self:RefreshTechSpeicalSideBuffList()
  else
    self:RefreshTechSpeicalSideInfoNode()
  end
end

function UINChristmas22TechSpeicalSide:AddWaitLookTech(techData)
  if self._waitShowBuffTech == nil then
    self._waitShowBuffTech = {}
  end
  self._waitShowBuffTech[techData.techId] = true
end

function UINChristmas22TechSpeicalSide:RefreshTechSpeicalSideInfoNode()
  self._needRefreshInfoNode = false
  local nextTechData
  self._curTechData = nil
  local techDic = self._data:GetTechDataDic()
  local branchTechDic = techDic[self._branchId]
  if branchTechDic == nil then
    if isGameDev then
      error(" branch tech is nil ")
    end
    return
  end
  local lastTech
  for k, techData in pairs(branchTechDic) do
    if techData:GetRearTechData() == nil then
      lastTech = techData
    end
    if not techData:GetIsUnlock() then
      local preTechData = techData:GetPreTechData()
      if preTechData ~= nil then
        if preTechData:GetIsUnlock() then
          nextTechData = techData
          break
        end
        if preTechData:GetPreTechData() == nil then
          nextTechData = techData
          break
        end
      end
    end
  end
  if nextTechData ~= nil then
    self._curTechData = nextTechData:GetPreTechData()
  elseif lastTech:GetCurLevel() == 0 then
    self._curTechData = lastTech
  end
  if self._curTechData ~= nil and self._curTechData:IsMaxLvel() then
    self._curTechData = nextTechData
  end
  if self._curTechData == nil then
    self.ui.tex_Exp:SetIndex(0)
    self.ui.upgrade:SetActive(false)
    self.ui.max:SetActive(true)
    return
  end
  self.ui.upgrade:SetActive(true)
  self.ui.max:SetActive(false)
  self.ui.tex_Exp:SetIndex(1, tostring(self._curTechData:GetActTechPrfeTotleLevel()))
  self._resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorBuilding"), function(spriteAtlas)
    if spriteAtlas == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_StrategyIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, self._curTechData:GetWATechIcon())
  end)
  self.ui.tex_BuffName.text = self._curTechData:GetAWTechName()
  self.ui.tex_Des.text = self._curTechData:GetTechDescription(nil, self._desType)
  local isUnlock = self._curTechData:GetIsUnlock()
  self.ui.lock:SetActive(not isUnlock)
  self.ui.btn_Clear.gameObject:SetActive(isUnlock and not self._curTechData:IsMaxLvel())
  self.ui.redDot:SetActive(self._curTechData:IsCouldLevelUp())
end

function UINChristmas22TechSpeicalSide:RefreshTechSpeicalSideBuffList()
  self._needRefreshBuffNode = false
  self._buffItemPool:HideAll()
  local techDic = self._data:GetTechDataDic()
  local branchTechDic = techDic[self._branchId]
  if branchTechDic == nil then
    if isGameDev then
      error(" branch tech is nil ")
    end
    return
  end
  local logicDic = {}
  local updateLogicDic = {}
  for _, branchTechDic in pairs(techDic) do
    for k, techData in pairs(branchTechDic) do
      local level = techData:GetCurLevel()
      local isUpDate = self._waitShowBuffTech ~= nil and self._waitShowBuffTech[techData.techId] ~= nil
      if not (level <= 0) then
        local logicArray, para1Array, para2Array, para3Array = techData:GetTechLogic(level)
        for k, logic in ipairs(logicArray) do
          local para1, para2, para3 = para1Array[k], para2Array[k], para3Array[k]
          CommonLogicUtil.MergeLogic(logicDic, logic, {
            para1,
            para2,
            para3
          })
          if isUpDate then
            local curAddTable = updateLogicDic[logic] or {}
            updateLogicDic[logic] = curAddTable
            local mergeInfo, MergeType = CommonLogicUtil.GetMergeInfoTable(logic)
            if para3 ~= nil and (mergeInfo == nil or mergeInfo[3] == MergeType.equal) then
              curAddTable[para1] = curAddTable[para1] or {}
              curAddTable[para1][para2] = curAddTable[para1][para2] or {}
              curAddTable[para1][para2][para3] = true
            elseif para2 ~= nil and (mergeInfo == nil or mergeInfo[2] == MergeType.equal) then
              curAddTable[para1] = curAddTable[para1] or {}
              curAddTable[para1][para2] = true
            elseif para1 ~= nil and (mergeInfo == nil or mergeInfo[1] == MergeType.equal) then
              curAddTable[para1] = true
            end
          end
        end
      end
    end
  end
  for logic, paraTab in pairs(logicDic) do
    local para1Array = paraTab[1]
    local para2Array = paraTab[2]
    local para3Array = paraTab[3]
    for k, para1 in ipairs(para1Array) do
      local para2 = para2Array and para2Array[k] or nil
      local para3 = para3Array and para3Array[k] or nil
      local longDes, shortDes, valueDes = CommonLogicUtil.GetDesString(logic, para1, para2, para3, self._desType)
      local buffItem = self._buffItemPool:GetOne()
      buffItem:InitActSum22BuffItem(longDes)
      local curCheckTable = updateLogicDic[logic]
      local changed = curCheckTable ~= nil
      local mergeInfo, MergeType = CommonLogicUtil.GetMergeInfoTable(logic)
      if changed and para1 ~= nil and (mergeInfo == nil or mergeInfo[1] == MergeType.equal) then
        curCheckTable = curCheckTable[para1]
        changed = curCheckTable ~= nil
      end
      if changed and para2 ~= nil and (mergeInfo == nil or mergeInfo[2] == MergeType.equal) then
        curCheckTable = curCheckTable[para2]
        changed = curCheckTable ~= nil
      end
      if changed and para3 ~= nil and (mergeInfo == nil or mergeInfo[3] == MergeType.equal) then
        curCheckTable = curCheckTable[para3]
        changed = curCheckTable ~= nil
      end
      buffItem:SetBuffItemNew(changed)
    end
  end
  if self._waitShowBuffTech ~= nil then
    table.clearmap(self._waitShowBuffTech)
  end
end

function UINChristmas22TechSpeicalSide:OnClickReset()
  if self._resetCallback then
    self._resetCallback()
  end
end

function UINChristmas22TechSpeicalSide:OnClickLv()
  if self._lvCallback then
    self._lvCallback(self._curTechData)
  end
end

function UINChristmas22TechSpeicalSide:OnClickBuff()
  if self._curShowPage == self.ePageEnum.buffList then
    self:__SetUIPageState(self.ePageEnum.strategyInfoNode)
    if self._needRefreshInfoNode then
      self:RefreshTechSpeicalSideInfoNode()
    end
  else
    self:__SetUIPageState(self.ePageEnum.buffList)
    if self._needRefreshBuffNode then
      self:RefreshTechSpeicalSideBuffList()
    end
  end
end

function UINChristmas22TechSpeicalSide:OnClickDetail()
  if self._detailCallback then
    self._detailCallback()
  end
end

return UINChristmas22TechSpeicalSide
