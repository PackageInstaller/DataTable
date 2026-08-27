local UINAthHeroInfo = class("UINAthHeroInfo", UIBaseNode)
local base = UIBaseNode
local UINChartArea = require("Game.Arithmetic.AthMain.Chart.UINChartArea")
local UINAthHeroInfoSuit = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfoSuit")
local UINAthHeroInfoAreaName = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfoAreaName")
local cs_MessageCommon = CS.MessageCommon

function UINAthHeroInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRoot)
  self.ui.charItem:SetActive(false)
  self.areaPool = UIItemPool.New(UINChartArea, self.ui.charItem)
  self.ui.tex_AreaName:SetActive(false)
  self.areaNamePool = UIItemPool.New(UINAthHeroInfoAreaName, self.ui.tex_AreaName)
  self.suitItemList = {}
  for k, go in ipairs(self.ui.suitItemGoList) do
    local suitItem = UINAthHeroInfoSuit.New()
    suitItem:Init(go)
    table.insert(self.suitItemList, suitItem)
  end
  self.__onAthDataUpdate = BindCallback(self, self.__OnAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

function UINAthHeroInfo:InitAthHeroInfo(heroData, resLoader, withoutBlueDot)
  self.heroData = heroData
  self.resLoader = resLoader
  self.withoutBlueDot = withoutBlueDot
  local unlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
  self.unlock = unlock
  self.ui.lock:SetActive(not unlock)
  self.ui.normal:SetActive(unlock)
  self:RefreshAthHeroInfoChart()
  if unlock then
    self:__RefreshBuleDot()
  else
    self.ui.blueDot:SetActive(false)
  end
end

function UINAthHeroInfo:__OnAthDataUpdate()
  if self.unlock then
    self:__RefreshBuleDot()
  end
end

function UINAthHeroInfo:__RefreshBuleDot()
  self.ui.blueDot:SetActive(PlayerDataCenter.allAthData:GetHeroCanLoaded(self.heroData) and not self.withoutBlueDot)
end

function UINAthHeroInfo:SetShowAthWindowParam(heroResLoader, addAllTouchFunc, removeAllTouchFunc, switchHeroFunc, canClickFunc)
  self.canShowAthWindow = true
  self.heroResLoader = heroResLoader
  self.addAllTouchFunc = addAllTouchFunc
  self.removeAllTouchFunc = removeAllTouchFunc
  self.switchHeroFunc = switchHeroFunc
  self.canClickFunc = canClickFunc
end

function UINAthHeroInfo:RefreshAthHeroInfoChart()
  if not self.unlock then
    return
  end
  local athAreaCurSpaceList = self.heroData:GetAthSlotList()
  local athAreaMaxSpaceList = self.heroData:GetAthSlotList(true)
  local allSpace = 0
  local allSpaceDataList = {}
  local largestAreaId
  local largestAreaSpace = 0
  for id, maxSpace in ipairs(athAreaMaxSpaceList) do
    allSpace = allSpace + maxSpace
    if maxSpace > largestAreaSpace then
      largestAreaSpace = maxSpace
      largestAreaId = id
    end
    local curSpace = athAreaCurSpaceList[id]
    local lockedSpace = maxSpace - curSpace
    local unusedSpace = curSpace
    local qualitySpaceDic = {}
    local athList = PlayerDataCenter.allAthData:GetHeroAthList(self.heroData.dataId, id)
    for k, athData in ipairs(athList) do
      if qualitySpaceDic[athData.quality] == nil then
        qualitySpaceDic[athData.quality] = 0
      end
      unusedSpace = unusedSpace - athData.size
      qualitySpaceDic[athData.quality] = athData.size + qualitySpaceDic[athData.quality]
    end
    local spaceData = {
      maxSpace = maxSpace,
      lockedSpace = lockedSpace,
      unusedSpace = unusedSpace,
      qualitySpaceDic = qualitySpaceDic
    }
    allSpaceDataList[id] = spaceData
  end
  local totalAngle = 360 - self.ui.space * #allSpaceDataList
  local curAngleOffset = 0
  self.areaPool:HideAll()
  self.areaNamePool:HideAll()
  for id, spaceData in ipairs(allSpaceDataList) do
    local areaItem = self.areaPool:GetOne()
    local angle = spaceData.maxSpace / allSpace * totalAngle
    areaItem:InitAthChartArea(spaceData, allSpace, totalAngle, curAngleOffset)
    local areaName = self.areaNamePool:GetOne()
    local areaCfg = ConfigData.ath_area[id]
    if areaCfg == nil then
      error("Can't get ath areaCfg, id == " .. id)
    else
      local posIndex = math.ceil((-curAngleOffset + spaceData.maxSpace / allSpace / 2 * totalAngle) / 90)
      if 4 < posIndex or posIndex < 1 then
        warn("Ath area name pos index error,index = " .. tostring(posIndex))
      end
      local namePos = self.ui.areaNamePos[posIndex]
      local nameIndex = (posIndex == 2 or posIndex == 3) and 1 or 0
      areaName:InitAthHeroInfoAreaName(LanguageUtil.GetLocaleText(areaCfg.name2), namePos, nameIndex)
      curAngleOffset = curAngleOffset - angle
      curAngleOffset = curAngleOffset - self.ui.space
    end
  end
  local allAttrDic, slotAttrTab, suitDic = PlayerDataCenter.allAthData:GetHeroAthAttr(self.heroData.dataId)
  local suitDataList = {}
  for suitId, suitData in pairs(suitDic) do
    table.insert(suitDataList, suitData)
  end
  table.sort(suitDataList, function(a, b)
    local numA = a.curCount
    local numB = b.curCount
    if numA == numB then
      return a.cfg.id < b.cfg.id
    else
      return numA > numB
    end
  end)
  for k, suitItem in ipairs(self.suitItemList) do
    local suitData = suitDataList[k]
    local suitId = suitData and suitData.cfg.id
    if suitId == nil then
      suitItem:Hide()
    else
      suitItem:Show()
      local suitData = suitDic[suitId]
      local suitParamCfg = ConfigData.ath_suit.suitParamDic[suitId]
      suitItem:InitAthHeroInfoSuit(suitParamCfg, suitData.curCount, suitData.maxCount)
    end
  end
end

function UINAthHeroInfo:__OnClickRoot()
  if not self.unlock then
    local des = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
    cs_MessageCommon.ShowMessageTips(des)
    return
  end
  if not self.canShowAthWindow then
    return
  end
  if self.canClickFunc ~= nil and not self.canClickFunc() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Ath, function(window)
    if window == nil then
      return
    end
    if self.removeAllTouchFunc ~= nil then
      self.removeAllTouchFunc()
    end
    window:InitATHMain(self.heroData, self.heroResLoader, self.addAllTouchFunc, self.switchHeroFunc)
    if window.winTween ~= nil then
      window.winTween:Complete()
    end
    UIManager:HideWindow(UIWindowTypeID.HeroState)
  end)
end

function UINAthHeroInfo:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  self.areaPool:DeleteAll()
  self.areaNamePool:DeleteAll()
  base.OnDelete(self)
end

return UINAthHeroInfo
