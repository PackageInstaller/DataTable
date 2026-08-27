local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavSpeciaOasisCollectReward = class("UINNavSpeciaOasisCollectReward", UINNavSpecialUIBase)
local base = UINNavSpecialUIBase
local UINNavSpeciaOasisCollectRewardItem = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpeciaOasisCollectRewardItem")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_MessageCommon = CS.MessageCommon

function UINNavSpeciaOasisCollectReward:OnInit()
  self.alphaColor = Color.New(1, 1, 1, 0.3)
  self.resItemDic = {}
  self.isTweenPlay = false
  base.OnInit(self)
  self.resItemPool = UIItemPool.New(UINNavSpeciaOasisCollectRewardItem, self.ui.resItem)
  self.ui.resItem.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_resCollect, self, self.__CollectAllRewards)
  self.__B_RefreshAllRewards = BindCallback(self, self.__RefreshAllRewards)
  self._CollectAllResCompleteFunc = BindCallback(self, self._OnCollectAllResComplete)
end

function UINNavSpeciaOasisCollectReward.GetSpecialUI(item, go, resloader)
  local specialUI = base.GetSpecialUI(UINNavSpeciaOasisCollectReward, item, go)
  specialUI:__RefreshAllRewards()
  base.__Add2TimerFuncs(specialUI.__B_RefreshAllRewards)
  return specialUI
end

function UINNavSpeciaOasisCollectReward:__RefreshAllRewards()
  if self.isTweenPlay then
    return
  end
  local allDatas = {}
  for _, buildingData in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
    local datas = buildingData:GetResDatas()
    if datas ~= nil then
      for _, data in pairs(datas) do
        if allDatas[data.id] == nil then
          allDatas[data.id] = data
        else
          allDatas[data.id].count = allDatas[data.id].count + data.count
          allDatas[data.id].countMax = allDatas[data.id].countMax + data.countMax
        end
      end
    end
  end
  if table.count(allDatas) == 0 then
    self:Hide()
    return
  end
  self:Show()
  self:__CouldCollectReward()
  self.resItemPool:HideAll()
  for _, buildingResData in pairs(allDatas) do
    local itemId = buildingResData.id
    local rate = buildingResData.count / buildingResData.countMax
    local item = self.resItemPool:GetOne()
    self.resItemDic[itemId] = item
    item:SetNSOCRItemImage(itemId)
    item:RefreshNSOCRItemRate(rate)
  end
end

function UINNavSpeciaOasisCollectReward:__CouldCollectReward()
  local buildIdDict = {}
  local failCollectBuildDatas = {}
  local buildingCount = 0
  for buildId, buildData in pairs(PlayerDataCenter.AllBuildingData.oasisBuilt) do
    if buildData:IsBuildResPeriodOk() and buildData:CanGetBuildRes() then
      buildingCount = buildingCount + 1
      buildIdDict[buildId] = true
    else
      failCollectBuildDatas[buildId] = buildData
    end
  end
  if 0 < buildingCount then
    self.ui.img_colleIcon.color = Color.white
    return true, failCollectBuildDatas, buildIdDict
  else
    self.ui.img_colleIcon.color = self.alphaColor
    return false, failCollectBuildDatas
  end
end

function UINNavSpeciaOasisCollectReward:__CollectAllRewards()
  local could, failBuildResDatas, buildIdDict = self:__CouldCollectReward()
  if could and GuideManager.collectResGuideUnComplete then
    for buildId, _ in pairs(buildIdDict) do
      if buildId == 1003 then
        GuideManager:UncompleteCollectResGuide(false)
        local topWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
        topWindow.resGroup:UpdateResourceGroupTopCurrencys()
        local oasisController = ControllerManager:GetController(ControllerTypeId.OasisController)
        if oasisController ~= nil then
          oasisController:CollectComplete(1003, {
            {id = 1004, count = 1}
          })
        end
        buildIdDict[buildId] = nil
        if table.count(buildIdDict) <= 0 then
          could = false
        end
        break
      end
    end
  end
  if could then
    NetworkManager:GetNetwork(NetworkTypeID.Building):SendBuildingCollectGroup(buildIdDict, self._CollectAllResCompleteFunc)
  end
  self:_FailCollectTips(failBuildResDatas, could)
end

function UINNavSpeciaOasisCollectReward:_FailCollectTips(failBuildResDatas, haveCouldCollect)
  local resIds = {}
  local tipsList = {}
  local isHaveFullCapicity, isHaveCannotCollect
  for buildId, buildData in pairs(failBuildResDatas) do
    if buildData.state ~= proto_object_BuildingState.BuildingStateCreate and buildData.resDatas ~= nil then
      if not buildData:IsBuildResPeriodOk() then
        isHaveCannotCollect = true
      else
        local datas = buildData:GetResDatas()
        for k, v in pairs(datas) do
          local count = v.count
          local capacity = PlayerDataCenter.playerBonus:GetWarehouseCapcity(v.id)
          local playerResCount = PlayerDataCenter:GetItemCount(v.id)
          if capacity <= playerResCount then
            isHaveFullCapicity = true
            if resIds[v.id] == nil then
              resIds[v.id] = true
              table.insert(tipsList, ConfigData:GetTipContent(TipContent.ItemInWarehouseFull, v.name))
              break
            end
          else
            isHaveCannotCollect = true
          end
        end
      end
    end
  end
  for index, tips in ipairs(tipsList) do
    cs_MessageCommon.ShowMessageTipsWithErrorSound(tips, true)
  end
  if not haveCouldCollect and not isHaveFullCapicity and isHaveCannotCollect then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Building_UnsatisfMinialRewardCycle), true)
  end
end

function UINNavSpeciaOasisCollectReward:_OnCollectAllResComplete(objList)
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return
  end
  AudioManager:PlayAudioById(1090)
  local resDic = objList[0]
  for resId, resNum in pairs(resDic) do
    local itemCfg = ConfigData.item[resId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward, LanguageUtil.GetLocaleText(itemCfg.name), resNum)
      cs_MessageCommon.ShowMessageTips(msg, true)
    end
  end
  if self.resTweenSeq ~= nil then
    self.resTweenSeq:Kill(true)
  end
  self.resTweenSeq = cs_DoTween.Sequence()
  for resId, resNum in pairs(resDic) do
    local item = self.resItemDic[resId]
    if item ~= nil and not IsNull(item) then
      self.resTweenSeq:Join(item:GetFillAmountImage():DOFillAmount(0, 0.5))
    end
  end
  self.resTweenSeq:AppendCallback(function()
    self.resTweenSeq = nil
    self.isTweenPlay = false
  end)
  self.isTweenPlay = true
end

function UINNavSpeciaOasisCollectReward:OnDelete()
  base.__RemoveFromTimerFuncs(self.__B_RefreshAllRewards)
  for id, item in pairs(self.resItemDic) do
    item:Delete()
  end
  self.resItemDic = nil
  if self.resTweenSeq ~= nil then
    self.resTweenSeq:Kill()
    self.resTweenSeq = nil
  end
  base.OnDelete(self)
end

return UINNavSpeciaOasisCollectReward
