local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharFavourRewardCtrl = class("CharFavourRewardCtrl", BaseCtrl)
local GridNormalHeight = 77
local AttributeSizeGroup = {
  74,
  123,
  172,
  221
}
local RewardType = {
  DescContent = 1,
  Attribute = 2,
  Reward = 3
}
CharFavourRewardCtrl._mapNodeConfig = {
  goblur = {
    sNodeName = "t_fullscreen_blur_blue1",
    sComponentName = "GameObject"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharPlot_Favour_Reward_Title"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharPlot_Favour_Preview"
  },
  txtTitleNextLevel = {sComponentName = "TMP_Text"},
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  anigoRewardRoot = {
    sNodeName = "goRewardRoot",
    sComponentName = "Animator"
  },
  loopsvReward = {
    sNodeName = "svReward",
    sComponentName = "LoopScrollView"
  },
  loopsvAttribute = {
    sNodeName = "svAttribute",
    sComponentName = "LoopScrollView"
  },
  loopsvAttributeNextLevel = {
    sNodeName = "svAttributeNextLevel",
    sComponentName = "LoopScrollView"
  },
  btnClose = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnBtn_ClickClose"
  }
}
CharFavourRewardCtrl._mapEventConfig = {}

function CharFavourRewardCtrl:Awake()
  local tbParam = self:GetPanelParam()
  self.curCharId = tbParam[1]
  self.tbDefualtShowAttribute = {
    self:GetEffectDescId(GameEnum.effectAttributeType.MAXHP, GameEnum.parameterType.BASE_VALUE),
    self:GetEffectDescId(GameEnum.effectAttributeType.ATK, GameEnum.parameterType.BASE_VALUE)
  }
  self.nAffinityMaxEffectLevel = tonumber(ConfigTable.GetConfigValue("AffinityMaxEffectLevel"))
end

function CharFavourRewardCtrl:OnEnable()
  self._mapNode.anigoRewardRoot:Play("t_window_04_t_in")
  self._mapNode.goblur:SetActive(true)
  local affinityData = PlayerData.Char:GetCharAffinityData(self.curCharId)
  self.curFavourLevel = affinityData.Level
  self:CacheLevelRewardData()
  self:OnRefreshPanel()
end

function CharFavourRewardCtrl:OnRefreshPanel()
  self.tbAffinityHeight = {}
  self.AffinityLevelData = {}
  local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", self.curCharId)
  if mapCharAffinity == nil then
    return
  end
  local templateId = mapCharAffinity.TemplateId
  
  local function forEachAffinityLevelReward(mapData)
    if mapData.TemplateId == templateId then
      if self.curFavourLevel == mapData.AffinityLevel then
        self.curAffinityData = mapData
      end
      local data = self.tbLevelRewardData[mapData.AffinityLevel]
      if data ~= nil then
        local height = self:CalGridHeight(data, mapData)
        if 0 < height then
          table.insert(self.AffinityLevelData, {
            levelData = mapData,
            rewardData = data,
            height = height
          })
        end
      end
    end
  end
  
  ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevelReward)
  table.sort(self.AffinityLevelData, function(a, b)
    return a.levelData.AffinityLevel < b.levelData.AffinityLevel
  end)
  for k, v in ipairs(self.AffinityLevelData) do
    if self.initSelectAdvance == nil and v.levelData.AffinityLevel > self.curFavourLevel then
      self.initSelectAdvance = #self.tbAffinityHeight
    end
    table.insert(self.tbAffinityHeight, v.height)
  end
  if self.initSelectAdvance == nil then
    self.initSelectAdvance = #self.tbAffinityHeight
  end
  self.initSelectAdvance = self.initSelectAdvance == 0 and 1 or self.initSelectAdvance
  self._mapNode.loopsvReward:SetAnim(0.07)
  self._mapNode.loopsvReward:InitEx(self.tbAffinityHeight, self, self.OnRefreshAffinityGrid)
  self._mapNode.loopsvReward:SetScrollGridPosEx(self.tbAffinityHeight, self.initSelectAdvance, 0.1, 0)
  self:OnRefreshAttributeList()
  self:OnRefreshNextLevelAttributeList()
end

function CharFavourRewardCtrl:OnRefreshAffinityGrid(go, gridIndex)
  local index = gridIndex + 1
  local data = self.AffinityLevelData[index]
  local trans = go.transform:Find("AnimRoot")
  local goTitle = trans:Find("goTitle")
  local goUnlock = goTitle:Find("goUnlock")
  local goLock = goTitle:Find("goLock")
  local txtLevel = goUnlock:Find("txtLevel"):GetComponent("TMP_Text")
  local txtLevelName1 = goUnlock:Find("txtLevelName"):GetComponent("TMP_Text")
  local imgHead = goUnlock:Find("imgHead"):GetComponent("Image")
  local txtLevel_Lock = goLock:Find("txtLevelName/txtLevel_Lock"):GetComponent("TMP_Text")
  local txtLevelName2 = goLock.gameObject.transform:Find("txtLevelName"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtLevelName1, ConfigTable.GetUIText("CharPlot_Favour_Reward_Level"))
  NovaAPI.SetTMPText(txtLevelName2, ConfigTable.GetUIText("CharPlot_Favour_Reward_Level"))
  NovaAPI.SetTMPText(txtLevel, data.levelData.AffinityLevel)
  NovaAPI.SetTMPText(txtLevel_Lock, data.levelData.AffinityLevel)
  goLock.gameObject:SetActive(data.levelData.AffinityLevel > self.curFavourLevel)
  goUnlock.gameObject:SetActive(data.levelData.AffinityLevel <= self.curFavourLevel)
  NovaAPI.SetComponentEnable(imgHead, data.levelData.AffinityLevel <= self.curFavourLevel)
  if data.levelData.AffinityLevel <= self.curFavourLevel then
    self:SetPngSprite(imgHead, data.levelData.AffinityLevelIcon)
  end
  local goRewardRoot = trans:Find("goRewardInfoList")
  local rewardInfoList = self:GetRewardInfoList(data.rewardData, data.levelData)
  if #rewardInfoList <= 0 then
    goRewardRoot.gameObject:SetActive(false)
    return
  end
  goRewardRoot.gameObject:SetActive(true)
  table.sort(rewardInfoList, function(a, b)
    return a.rewardType < b.rewardType
  end)
  for i = 1, 4 do
    local goReward = goRewardRoot:Find("goRewardInfo_" .. i)
    local cgGoReward = goReward:GetComponent("CanvasGroup")
    local goLine = 1 < i and goRewardRoot:Find("goLine_" .. i - 1) or nil
    if goLine ~= nil then
      goLine.gameObject:SetActive(rewardInfoList[i] ~= nil)
    end
    goReward.gameObject:SetActive(rewardInfoList[i] ~= nil)
    if rewardInfoList[i] ~= nil then
      self:SetGridRewardInfoList(goReward, rewardInfoList[i])
    end
    NovaAPI.SetCanvasGroupAlpha(cgGoReward, data.levelData.AffinityLevel > self.curFavourLevel and 0.4 or 1)
  end
end

function CharFavourRewardCtrl:SetGridRewardInfoList(goRewardRoot, rewardInfoList)
  local goReward = goRewardRoot:Find("goReward")
  local goDesc = goRewardRoot:Find("goDesc")
  goReward.gameObject:SetActive(rewardInfoList.rewardType == RewardType.Reward)
  goDesc.gameObject:SetActive(rewardInfoList.rewardType ~= RewardType.Reward)
  if rewardInfoList.rewardType == RewardType.Reward then
    local imgRewardIcon = goReward:Find("goRewardTxtContent/goImgReward/imgReward"):GetComponent("Image")
    local item = ConfigTable.GetData_Item(rewardInfoList.rewardData[1])
    self:SetPngSprite(imgRewardIcon, item.Icon2)
    local txtReward = goReward:Find("goRewardTxtContent/txtReward"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtReward, rewardInfoList.rewardData[2])
  else
    local imgLock = goDesc:Find("imgLock")
    local imgAttribute = goDesc:Find("imgAttribute")
    local txtFront = goDesc:Find("txtFront"):GetComponent("TMP_Text")
    local txtAfter = goDesc:Find("txtAfter"):GetComponent("TMP_Text")
    if rewardInfoList.rewardType == RewardType.DescContent then
      imgLock.gameObject:SetActive(true)
      imgAttribute.gameObject:SetActive(false)
      NovaAPI.SetTMPText(txtFront, rewardInfoList.rewardData.front)
      NovaAPI.SetTMPText(txtAfter, rewardInfoList.rewardData.after)
    elseif rewardInfoList.rewardType == RewardType.Attribute then
      imgLock.gameObject:SetActive(false)
      imgAttribute.gameObject:SetActive(true)
      NovaAPI.SetTMPText(txtFront, ConfigTable.GetUIText("Attribute_Up"))
      local addTxt = FormatEffectValue(rewardInfoList.attributeData.value, rewardInfoList.attributeData.descData.isPercent, rewardInfoList.attributeData.descData.Format)
      NovaAPI.SetTMPText(txtAfter, rewardInfoList.attributeData.descData.Desc .. " +" .. addTxt)
    end
  end
end

function CharFavourRewardCtrl:OnRefreshAttributeList()
  self.tbAttributeList = {}
  local count = 0
  for k, v in ipairs(self.tbDefualtShowAttribute) do
    self.tbAttributeList[v] = {sort = k, value = 0}
    count = count + 1
  end
  if self.curAffinityData ~= nil then
    for i = 1, #self.curAffinityData.Effect do
      local effectData = self:GetEffectData(self.curAffinityData.Effect[i])
      local descId = effectData.descData.Id
      if self.tbAttributeList[descId] ~= nil then
        self.tbAttributeList[descId].value = self.tbAttributeList[descId].value + effectData.value
      else
        self.tbAttributeList[descId] = {
          sort = count + 1,
          value = effectData.value
        }
        count = count + 1
      end
    end
  end
  self._mapNode.loopsvAttribute:Init(count, self, self.OnRefreshAttributeGrid)
end

function CharFavourRewardCtrl:OnRefreshAttributeGrid(go, index)
  local index = index + 1
  local data = {}
  local descId = 0
  for k, v in pairs(self.tbAttributeList) do
    if index == v.sort then
      data = v
      descId = k
      break
    end
  end
  if descId <= 0 then
    go:SetActive(false)
    return
  end
  local trans = go.transform
  local imgIcon = trans:Find("imgIcon"):GetComponent("Image")
  local txtAttributeName = trans:Find("txtAttributeName"):GetComponent("TMP_Text")
  local txtAttributeNum = trans:Find("txtAttributeNum"):GetComponent("TMP_Text")
  local effectDescData = ConfigTable.GetData("EffectDesc", descId)
  self:SetPngSprite(imgIcon, effectDescData.Icon)
  NovaAPI.SetTMPText(txtAttributeName, effectDescData.Desc)
  local sValue = FormatEffectValue(data.value, effectDescData.isPercent, effectDescData.Format)
  NovaAPI.SetTMPText(txtAttributeNum, sValue)
end

function CharFavourRewardCtrl:OnRefreshNextLevelAttributeList()
  self.tbNextLevelAttributeList = {}
  local count = 0
  for k, v in ipairs(self.tbDefualtShowAttribute) do
    self.tbNextLevelAttributeList[v] = {sort = k, value = 0}
    count = count + 1
  end
  local nextLevelData = self:GetTargetLevelData(self.curAffinityData.AffinityLevel + 1, self.curAffinityData.TemplateId)
  if nextLevelData ~= nil and self.curAffinityData.AffinityLevel < self.nAffinityMaxEffectLevel then
    local effectData = self:GetEffectDataSubValue(self.curAffinityData.Effect, nextLevelData.Effect)
    if effectData ~= nil then
      for i = 1, #effectData do
        local descId = effectData[i].descData.Id
        if self.tbNextLevelAttributeList[descId] ~= nil then
          self.tbNextLevelAttributeList[descId].value = self.tbNextLevelAttributeList[descId].value + effectData[i].value
        else
          self.tbNextLevelAttributeList[descId] = {
            sort = count + 1,
            value = effectData[i].value
          }
          count = count + 1
        end
      end
      NovaAPI.SetTMPText(self._mapNode.txtTitleNextLevel, ConfigTable.GetUIText("Affinity_Next_Level"))
    end
    local ShowData = {}
    for k, v in pairs(self.tbNextLevelAttributeList) do
      if 0 < tonumber(v.value) then
        table.insert(ShowData, {
          sort = v.sort,
          value = v.value,
          id = k
        })
      end
    end
    table.sort(ShowData, function(a, b)
      return a.sort < b.sort
    end)
    self.tbNextLevelAttributeList = {}
    for i = 1, #ShowData do
      ShowData[i].sort = i
      self.tbNextLevelAttributeList[ShowData[i].id] = {
        sort = i,
        value = ShowData[i].value
      }
    end
    count = #ShowData
  else
    count = 0
    NovaAPI.SetTMPText(self._mapNode.txtTitleNextLevel, ConfigTable.GetUIText("Affinity_Max_Level"))
  end
  self._mapNode.loopsvAttributeNextLevel:Init(count, self, self.OnRefreshNextLevelAttributeGrid)
end

function CharFavourRewardCtrl:OnRefreshNextLevelAttributeGrid(go, index)
  local index = index + 1
  local data = {}
  local descId = 0
  for k, v in pairs(self.tbNextLevelAttributeList) do
    if index == v.sort then
      data = v
      descId = k
      break
    end
  end
  if descId <= 0 then
    go:SetActive(false)
    return
  end
  local trans = go.transform
  local imgIcon = trans:Find("imgIcon"):GetComponent("Image")
  local txtAttributeName = trans:Find("txtAttributeName"):GetComponent("TMP_Text")
  local txtAttributeNum = trans:Find("txtAttributeNum"):GetComponent("TMP_Text")
  local effectDescData = ConfigTable.GetData("EffectDesc", descId)
  self:SetPngSprite(imgIcon, effectDescData.Icon)
  NovaAPI.SetTMPText(txtAttributeName, effectDescData.Desc)
  local sValue = FormatEffectValue(data.value, effectDescData.isPercent, effectDescData.Format)
  NovaAPI.SetTMPText(txtAttributeNum, sValue)
end

function CharFavourRewardCtrl:CacheLevelRewardData()
  self.tbLevelRewardData = {}
  
  local function forEachAffinityUpReward(mapData)
    if mapData.CharId == self.curCharId then
      self.tbLevelRewardData[mapData.RewardLevel] = mapData
    end
  end
  
  ForEachTableLine(DataTable.AffinityUpReward, forEachAffinityUpReward)
end

function CharFavourRewardCtrl:GetEffectData(effectId)
  local data
  local effectData = ConfigTable.GetData("EffectValue", effectId)
  if effectData == nil then
    printError("属性配置错误，不存在的属性：" .. effectId)
  end
  local descId = self:GetEffectDescId(effectData.EffectTypeFirstSubtype, effectData.EffectTypeSecondSubtype)
  local mapEffectDesc = ConfigTable.GetData("EffectDesc", descId)
  if mapEffectDesc ~= nil then
    data = {
      descData = mapEffectDesc,
      value = effectData.EffectTypeParam1
    }
  end
  return data
end

function CharFavourRewardCtrl:GetEffectDataSubValue(levelDataBefore, levelDataAfter)
  local tbBeforeValue = {}
  local tbAfterValue = {}
  local data
  if levelDataBefore ~= nil then
    for i = 1, #levelDataBefore do
      local data = self:GetEffectData(levelDataBefore[i])
      if data ~= nil then
        tbBeforeValue[data.descData.Id] = data
      end
    end
  end
  if levelDataAfter ~= nil then
    for i = 1, #levelDataAfter do
      local data = self:GetEffectData(levelDataAfter[i])
      if data ~= nil then
        tbAfterValue[data.descData.Id] = data
      end
    end
  end
  for k, v in pairs(tbAfterValue) do
    if tbBeforeValue[k] ~= nil then
      local beforeValue = tonumber(tbBeforeValue[k].value)
      local afterValue = tonumber(v.value)
      if beforeValue < afterValue then
        if data == nil then
          data = {}
        end
        v.value = afterValue - beforeValue
        table.insert(data, v)
      end
    else
      if data == nil then
        data = {}
      end
      table.insert(data, v)
    end
  end
  return data
end

function CharFavourRewardCtrl:CalGridHeight(rewardData, levelData)
  local data = self:GetRewardInfoList(rewardData, levelData)
  if #data <= 0 then
    return 0
  end
  if 4 < #data then
    printError("好感度配置有误,奖励词条超过上限，错误等级：" .. levelData.AffinityLevel)
  end
  return AttributeSizeGroup[#data] + GridNormalHeight
end

function CharFavourRewardCtrl:GetRewardInfoList(rewardData, levelData)
  local rewardInfoList = {}
  local index = 1
  while rewardData ~= nil and (rewardData["DescFront" .. index] ~= nil or rewardData["Reward" .. index] ~= nil) do
    if rewardData["DescFront" .. index] ~= "" then
      local data = {}
      data.rewardType = RewardType.DescContent
      data.rewardData = {
        front = rewardData["DescFront" .. index],
        after = rewardData["DescAfter" .. index]
      }
      table.insert(rewardInfoList, data)
    end
    index = index + 1
  end
  if levelData.IsKeyAffinityLevel == true and levelData.Effect ~= nil then
    local lastData = self:GetTargetLevelData(levelData.AffinityLevel - 1, levelData.TemplateId)
    if lastData == nil then
      for i = 1, #levelData.Effect do
        local data = {}
        local effectData = self:GetEffectData(levelData.Effect[i])
        if effectData ~= nil then
          data.rewardType = RewardType.Attribute
          data.attributeData = effectData
          table.insert(rewardInfoList, data)
        end
      end
    else
      local effectData = self:GetEffectDataSubValue(lastData.Effect, levelData.Effect)
      if effectData ~= nil then
        for i = 1, #effectData do
          local data = {}
          if effectData[i] ~= nil then
            data.rewardType = RewardType.Attribute
            data.attributeData = effectData[i]
            table.insert(rewardInfoList, data)
          end
        end
      end
    end
  end
  return rewardInfoList
end

function CharFavourRewardCtrl:GetEffectDescId(attributeType, numType)
  return GameEnum.effectType.ATTR_FIX * 10000 + attributeType * 10 + numType
end

function CharFavourRewardCtrl:GetTargetLevelData(affinityLevel, templateId)
  local data
  
  local function forEachAffinityLevelReward(mapData)
    if mapData.TemplateId == templateId and affinityLevel == mapData.AffinityLevel then
      data = mapData
    end
  end
  
  ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevelReward)
  return data
end

function CharFavourRewardCtrl:OnBtn_ClickClose()
  self._mapNode.anigoRewardRoot:Play("t_window_04_t_out")
  self._mapNode.goblur:SetActive(false)
  self:AddTimer(1, 0.3, "OnCloseAnimFinish", true, true, true)
end

function CharFavourRewardCtrl:OnCloseAnimFinish()
  EventManager.Hit(EventId.ClosePanel, PanelId.CharFavourReward)
end

return CharFavourRewardCtrl
