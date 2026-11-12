local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharFavourLevelUpCtrl = class("CharFavourLevelUpCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GridHeight = 51
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
CharFavourLevelUpCtrl._mapNodeConfig = {
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  aniActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Animator"
  },
  got_fullscreen_blur_black = {
    sNodeName = "t_fullscreen_blur_black",
    sComponentName = "GameObject"
  },
  btnsnapshot = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtn_ClickClose"
  },
  rtBg = {
    sNodeName = "goBg",
    sComponentName = "RectTransform"
  },
  goLevelUp = {},
  loopAdPre = {
    sNodeName = "AdPre",
    sComponentName = "LoopScrollView"
  },
  affinityLevel = {
    sCtrlName = "Game.UI.TemplateEx.TemplateAffinityLevelCtrl"
  },
  affinityLevelBefore = {
    sCtrlName = "Game.UI.TemplateEx.TemplateAffinityLevelCtrl"
  },
  trContent = {
    sNodeName = "--Content--",
    sComponentName = "RectTransform"
  },
  btnSkipAnim = {
    sNodeName = "btnSkipAnim",
    sComponentName = "UIButton",
    callback = "OnBtn_SkipAnim"
  },
  aniSafeRoot = {
    sNodeName = "----SafeRoot----",
    sComponentName = "Animator"
  },
  goSafeRoot = {
    sNodeName = "----SafeRoot----",
    sComponentName = "GameObject"
  },
  goNormal = {},
  affinityLevelNormal = {
    sCtrlName = "Game.UI.TemplateEx.TemplateAffinityLevelCtrl"
  },
  rectProgress = {
    sNodeName = "imgProgress",
    sComponentName = "RectTransform"
  },
  rectPreProgress = {
    sNodeName = "imgPreProgress",
    sComponentName = "RectTransform"
  },
  txtProgress = {
    sNodeName = "txtProgress",
    sComponentName = "TMP_Text"
  },
  txtCalHeight = {nCount = 2, sComponentName = "TMP_Text"},
  rtCalHeight = {
    nCount = 2,
    sNodeName = "txtCalHeight",
    sComponentName = "RectTransform"
  }
}
CharFavourLevelUpCtrl._mapEventConfig = {}

function CharFavourLevelUpCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam[1]) == "table" then
    self.tbLevelUpList = tbParam[1]
  else
    self.curCharId = tbParam[1]
    self.curFavourLevel = tbParam[2]
    self.lastFavourLevel = tbParam[3]
    self.curExp = tbParam[4]
    self.lastExp = tbParam[5]
    if tbParam[6] ~= nil then
      self.CloseCallBack = tbParam[6]
    end
  end
  EventManager.Hit(EventId.HideCharBgActor)
  self.progressBarWidth = 552
  self.progressBarMinWidth = 0
  self._mapNode.goLevelUp.gameObject:SetActive(false)
  self._mapNode.goNormal.gameObject:SetActive(false)
  self._mapNode.rectPreProgress.sizeDelta = Vector2(0, self._mapNode.rectPreProgress.sizeDelta.y)
  self.nAffinityMaxEffectLevel = tonumber(ConfigTable.GetConfigValue("AffinityMaxEffectLevel"))
end

function CharFavourLevelUpCtrl:OnEnable()
  self._mapNode.got_fullscreen_blur_black:SetActive(true)
  self:RefreshPanel()
  if self.lastFavourLevel < self.curFavourLevel then
    PlayerData.Voice:PlayCharFavourUpVoice(self.curCharId, self.lastFavourLevel)
  end
end

function CharFavourLevelUpCtrl:RefreshPanel()
  if self.tbLevelUpList ~= nil and #self.tbLevelUpList > 0 then
    local data = table.remove(self.tbLevelUpList, 1)
    self.curCharId = data.charID
    self.curFavourLevel = data.curLevel
    self.lastFavourLevel = data.lastLevel
    self.curExp = data.curExp
    self.lastExp = data.lastExp
  end
  self._mapNode.aniSafeRoot.speed = 1
  self._mapNode.aniActor2D_PNG.speed = 1
  self._mapNode.goSafeRoot:SetActive(true)
  CS.WwiseAudioManager.Instance:PostEvent("ui_charInfo_favour_up")
  local nSkinId = ConfigTable.GetData_Character(self.curCharId).DefaultSkinId
  self.DefaultHeight = self._mapNode.trContent.sizeDelta.y
  self._mapNode.aniSafeRoot:Play("CharFavourLevelUpPanel_in")
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.aniSafeRoot, {
    "CharFavourLevelUpPanel_in"
  })
  self.delayRefresh = self:AddTimer(1, nAnimLen, "Refresh", true, true, true)
  PlayerData.Char:ChangeShowAffinityLevelUpState(self.curCharId)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), self.curCharId, nSkinId)
    self._mapNode.aniActor2D_PNG:Play("Actor2D_PNG_CharFavour")
  end
  
  cs_coroutine.start(wait)
  self.tbAttributeList = {}
  self.tbRewardList = {}
  self.tbDescList = {}
  self.tbAllList = {}
  local templateId = ConfigTable.GetData("CharAffinityTemplate", self.curCharId).TemplateId
  local nMaxAffinityLevel = PlayerData.Char:GetMaxAffinityLevel(templateId)
  self._mapNode.affinityLevelNormal:SetInfo(self.lastFavourLevel)
  local lastData = CacheTable.GetData("_AffinityLevel", templateId)[nMaxAffinityLevel < self.lastFavourLevel + 1 and nMaxAffinityLevel or self.lastFavourLevel + 1]
  local nLastPercent
  if nMaxAffinityLevel <= self.lastFavourLevel then
    nLastPercent = 1
  else
    nLastPercent = self.lastExp / lastData.NeedExp
  end
  local sizeDelta = self._mapNode.rectProgress.sizeDelta
  sizeDelta.x = self.progressBarWidth * nLastPercent < self.progressBarMinWidth and self.progressBarMinWidth or self.progressBarWidth * nLastPercent
  self._mapNode.rectProgress.sizeDelta = sizeDelta
  NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", self.lastExp, lastData.NeedExp))
  if self.curFavourLevel == self.lastFavourLevel then
    local preData = CacheTable.GetData("_AffinityLevel", templateId)[nMaxAffinityLevel < self.curFavourLevel + 1 and nMaxAffinityLevel or self.curFavourLevel + 1]
    local nPrePercent = self.curExp / preData.NeedExp
    local nWidth = self.progressBarWidth * nPrePercent < self.progressBarMinWidth and self.progressBarMinWidth or self.progressBarWidth * nPrePercent
    self._mapNode.rectPreProgress.sizeDelta = Vector2(nWidth, sizeDelta.y)
  else
    self._mapNode.rectPreProgress.sizeDelta = Vector2(self.progressBarWidth, sizeDelta.y)
    self:RefreshAllDataList()
    local count = self:GetAllListCount()
    if 1 < count then
      local heightCount = 3 < count and 3 or count
      self._mapNode.trContent.sizeDelta = Vector2(self._mapNode.trContent.sizeDelta.x, self.DefaultHeight + (heightCount - 1) * GridHeight)
    end
  end
end

function CharFavourLevelUpCtrl:CalTextHeight(sContent, nIndex)
  NovaAPI.SetTMPText(self._mapNode.txtCalHeight[nIndex], sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCalHeight[nIndex])
  return self._mapNode.rtCalHeight[nIndex].rect.height
end

function CharFavourLevelUpCtrl:Refresh()
  local templateId = ConfigTable.GetData("CharAffinityTemplate", self.curCharId).TemplateId
  local nMaxAffinityLevel = PlayerData.Char:GetMaxAffinityLevel(templateId)
  local nAniTime = 0.2
  if self.curFavourLevel - self.lastFavourLevel < 6 then
    nAniTime = 0.2
  else
    nAniTime = 0.1
  end
  local nBeforeMaxExp = CacheTable.GetData("_AffinityLevel", templateId)[nMaxAffinityLevel < self.lastFavourLevel + 1 and nMaxAffinityLevel or self.lastFavourLevel + 1].NeedExp
  local nMaxExp = CacheTable.GetData("_AffinityLevel", templateId)[nMaxAffinityLevel < self.curFavourLevel + 1 and nMaxAffinityLevel or self.curFavourLevel + 1].NeedExp
  local nBeforeToMaxTime = nAniTime * (1 - self.lastExp / nBeforeMaxExp)
  local nBeforeToAfterTime = nAniTime * ((self.curExp - self.lastExp) / nMaxExp)
  local nZeroToAfterTime = nAniTime * self.curExp / nMaxExp
  local nAddCount = self.curFavourLevel - self.lastFavourLevel
  local sizeDelta = self._mapNode.rectProgress.sizeDelta
  local nAllTime = 0
  local sequence = DOTween.Sequence()
  for i = self.lastFavourLevel, self.curFavourLevel - 1 do
    local nTime = i == self.lastFavourLevel and nBeforeToMaxTime or nAniTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(self.progressBarWidth, sizeDelta.y), nTime))
    sequence:AppendCallback(function()
      local data = CacheTable.GetData("_AffinityLevel", templateId)[i + 1 > nMaxAffinityLevel and nMaxAffinityLevel or i + 1]
      NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", data.NeedExp, data.NeedExp))
      self._mapNode.affinityLevelNormal:SetInfo(i + 1)
      self._mapNode.rectPreProgress.sizeDelta = Vector2(self.progressBarWidth, sizeDelta.y)
      self._mapNode.rectProgress.sizeDelta = Vector2(0, sizeDelta.y)
    end)
  end
  sequence:AppendCallback(function()
    local data = CacheTable.GetData("_AffinityLevel", templateId)[self.curFavourLevel + 1 > nMaxAffinityLevel and nMaxAffinityLevel or self.curFavourLevel + 1]
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", self.curExp, data.NeedExp))
  end)
  if self.curFavourLevel == nMaxAffinityLevel then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(self.progressBarWidth, sizeDelta.y), nTime))
  elseif self.curExp > 0 then
    local nTime = 1 < nAddCount and nZeroToAfterTime or nBeforeToAfterTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      local preData = CacheTable.GetData("_AffinityLevel", templateId)[self.curFavourLevel + 1 > nMaxAffinityLevel and nMaxAffinityLevel or self.curFavourLevel + 1]
      local nPrePercent = self.curExp / preData.NeedExp
      local nWidth = self.progressBarWidth * nPrePercent < self.progressBarMinWidth and self.progressBarMinWidth or self.progressBarWidth * nPrePercent
      self._mapNode.rectPreProgress.sizeDelta = Vector2(nWidth, sizeDelta.y)
    end)
    local width = self.progressBarWidth * self.curExp / nMaxExp
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(width, sizeDelta.y), nTime))
  elseif self.curExp == 0 then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    self._mapNode.rectPreProgress.sizeDelta = Vector2(0, sizeDelta.y)
    sequence:Append(self._mapNode.rectProgress:DOSizeDelta(Vector2(self.progressBarWidth, sizeDelta.y), nTime))
    sequence:AppendCallback(function()
      self._mapNode.rectProgress.sizeDelta = Vector2(0, sizeDelta.y)
    end)
  end
  sequence:AppendInterval(0.05)
  sequence:AppendCallback(function()
    if self.curFavourLevel ~= self.lastFavourLevel then
      self._mapNode.aniSafeRoot:Play("CharFavourLevelUpPanel_up")
    end
    local count = self:GetAllListCount()
    self._mapNode.loopAdPre.gameObject:SetActive(true)
    if 0 < count then
      self.tbGridHeight = {}
      for _, v in ipairs(self.tbAllList) do
        local nHeight1, nHeight2 = 0
        if v.rewardType == "Desc" then
          nHeight1 = self:CalTextHeight(v.rewardData.sFront, 1)
          nHeight2 = self:CalTextHeight(v.rewardData.sAfter, 2)
        elseif v.rewardType == "Attribute" then
          nHeight1 = self:CalTextHeight(ConfigTable.GetUIText("Attribute_Up"), 1)
          local descData = ConfigTable.GetData("EffectDesc", v.rewardData[1])
          local addTxt = FormatEffectValue(v.rewardData[2], descData.isPercent, descData.Format)
          nHeight2 = self:CalTextHeight(descData.Desc .. " +" .. addTxt, 2)
        end
        local nHeight = math.max(nHeight1, nHeight2) + 15
        table.insert(self.tbGridHeight, nHeight)
      end
      self._mapNode.loopAdPre:SetAnim(0.07)
      self._mapNode.loopAdPre:InitEx(self.tbGridHeight, self, self.RefreshPreAdvanceBuffsGridItem)
    else
      self._mapNode.loopAdPre.gameObject:SetActive(false)
    end
    self._mapNode.affinityLevel:SetInfo(self.curFavourLevel)
    self._mapNode.affinityLevelBefore:SetInfo(self.lastFavourLevel)
  end)
  sequence:SetUpdate(true)
  self._mapNode.btnSkipAnim.gameObject:SetActive(false)
  EventManager.Hit(EventId.TemporaryBlockInput, nAllTime)
end

function CharFavourLevelUpCtrl:RefreshPreAdvanceBuffsGridItem(go)
  local index = tonumber(go.name) + 1
  local data = self:GetGridData(index)
  go = go.transform:Find("AnimRoot")
  local goReward = go.transform:Find("goReward")
  local goDesc = go.transform:Find("goDesc")
  local imgLine = go.transform:Find("imgLine")
  imgLine.gameObject:SetActive(1 < index)
  goReward.gameObject:SetActive(data.rewardType == "Reward")
  goDesc.gameObject:SetActive(data.rewardType ~= "Reward")
  if data.rewardType == "Reward" then
    local goContent = goReward:Find("goTxtContent")
    local imgRewardIcon = goContent:Find("goImgReward/imgReward"):GetComponent("Image")
    local item = ConfigTable.GetData_Item(data.rewardData[1])
    self:SetPngSprite(imgRewardIcon, item.Icon2)
    local txtReward = goContent:Find("txtReward"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtReward, data.rewardData[2])
  else
    local goImgLock = goDesc:Find("imgLock")
    local goImgAttribute = goDesc:Find("imgAttribute")
    goImgLock.gameObject:SetActive(data.rewardType == "Desc")
    goImgAttribute.gameObject:SetActive(data.rewardType == "Attribute")
    local txtFront = goDesc:Find("txtFront"):GetComponent("TMP_Text")
    local txtAfter = goDesc:Find("txtAfter"):GetComponent("TMP_Text")
    if data.rewardType == "Desc" then
      NovaAPI.SetTMPText(txtFront, data.rewardData.sFront)
      NovaAPI.SetTMPText(txtAfter, data.rewardData.sAfter)
    else
      NovaAPI.SetTMPText(txtFront, ConfigTable.GetUIText("Attribute_Up"))
      local descData = ConfigTable.GetData("EffectDesc", data.rewardData[1])
      local addTxt = FormatEffectValue(data.rewardData[2], descData.isPercent, descData.Format)
      NovaAPI.SetTMPText(txtAfter, descData.Desc .. " +" .. addTxt)
    end
  end
end

function CharFavourLevelUpCtrl:RefreshAllDataList()
  local templateId = ConfigTable.GetData("CharAffinityTemplate", self.curCharId).TemplateId
  local lastEffectData = {}
  local curEffectData = {}
  
  local function forEachAffinityLevelReward(mapData)
    if mapData.TemplateId == templateId then
      if mapData.AffinityLevel == self.lastFavourLevel then
        lastEffectData = mapData.Effect
      end
      if mapData.AffinityLevel == self.curFavourLevel then
        curEffectData = mapData.Effect
      end
    end
  end
  
  ForEachTableLine(DataTable.AffinityLevel, forEachAffinityLevelReward)
  self:RefreshAttributeList(lastEffectData, curEffectData)
  
  local function forEachAffinityUpReward(mapData)
    if mapData.CharId == self.curCharId and mapData.RewardLevel > self.lastFavourLevel and mapData.RewardLevel <= self.curFavourLevel then
      self:RefreshRewardList(mapData)
    end
  end
  
  ForEachTableLine(DataTable.AffinityUpReward, forEachAffinityUpReward)
  table.sort(self.tbDescList, function(a, b)
    if a.nId == b.nId then
      return a.nIndex < b.nIndex
    end
    return a.nId < b.nId
  end)
  if self.lastFavourLevel >= self.nAffinityMaxEffectLevel and #self.tbDescList == 0 then
    table.insert(self.tbDescList, 1, {
      nId = 0,
      nIndex = 0,
      sFront = ConfigTable.GetUIText("Affinity_Title"),
      sAfter = ConfigTable.GetUIText("Affinity_Title_LevelUp")
    })
  end
  for k, v in ipairs(self.tbDescList) do
    table.insert(self.tbAllList, {
      rewardType = "Desc",
      rewardData = self.tbDescList[k]
    })
  end
  for k, v in pairs(self.tbAttributeList) do
    table.insert(self.tbAllList, {
      rewardType = "Attribute",
      rewardData = {k, v}
    })
  end
  for k, v in pairs(self.tbRewardList) do
    table.insert(self.tbAllList, {
      rewardType = "Reward",
      rewardData = {k, v}
    })
  end
end

function CharFavourLevelUpCtrl:RefreshRewardList(rewardData)
  local index = 1
  while rewardData ~= nil and (rewardData["DescFront" .. index] ~= nil or rewardData["Reward" .. index] ~= nil) do
    if rewardData["DescFront" .. index] ~= nil and rewardData["DescFront" .. index] ~= "" then
      table.insert(self.tbDescList, {
        nId = rewardData.Id,
        nIndex = index,
        sFront = rewardData["DescFront" .. index],
        sAfter = rewardData["DescAfter" .. index]
      })
    end
    index = index + 1
  end
end

function CharFavourLevelUpCtrl:GetAllListCount()
  local count = 0
  count = count + #self.tbDescList
  for k, v in pairs(self.tbAttributeList) do
    count = count + 1
  end
  for k, v in pairs(self.tbRewardList) do
    count = count + 1
  end
  return count
end

function CharFavourLevelUpCtrl:GetGridData(index)
  local count = 0
  if index <= #self.tbDescList then
    return {
      rewardType = "Desc",
      rewardData = self.tbDescList[index]
    }
  end
  index = index - #self.tbDescList
  for k, v in pairs(self.tbAttributeList) do
    index = index - 1
    if index == 0 then
      return {
        rewardType = "Attribute",
        rewardData = {k, v}
      }
    end
  end
  for k, v in pairs(self.tbRewardList) do
    index = index - 1
    if index == 0 then
      return {
        rewardType = "Reward",
        rewardData = {k, v}
      }
    end
  end
end

function CharFavourLevelUpCtrl:RefreshAttributeList(levelDataBefore, levelDataAfter)
  local tbBeforeValue = {}
  local tbAfterValue = {}
  if levelDataBefore ~= nil then
    for i = 1, #levelDataBefore do
      local effectData = ConfigTable.GetData("EffectValue", levelDataBefore[i])
      local descId = self:GetEffectDescId(effectData.EffectTypeFirstSubtype, effectData.EffectTypeSecondSubtype)
      if tbBeforeValue[descId] ~= nil then
        tbBeforeValue[descId] = tbBeforeValue[descId] + effectData.EffectTypeParam1
      else
        tbBeforeValue[descId] = effectData.EffectTypeParam1
      end
    end
  end
  if levelDataAfter ~= nil then
    for i = 1, #levelDataAfter do
      local effectData = ConfigTable.GetData("EffectValue", levelDataAfter[i])
      local descId = self:GetEffectDescId(effectData.EffectTypeFirstSubtype, effectData.EffectTypeSecondSubtype)
      if tbAfterValue[descId] ~= nil then
        tbAfterValue[descId] = tbAfterValue[descId] + effectData.EffectTypeParam1
      else
        tbAfterValue[descId] = effectData.EffectTypeParam1
      end
    end
  end
  for k, v in pairs(tbAfterValue) do
    if tbBeforeValue[k] ~= nil then
      local beforeValue = tonumber(tbBeforeValue[k])
      local afterValue = tonumber(v)
      if beforeValue < afterValue then
        self.tbAttributeList[k] = afterValue - beforeValue
      end
    else
      self.tbAttributeList[k] = v
    end
  end
end

function CharFavourLevelUpCtrl:GetEffectDescId(attributeType, numType)
  return GameEnum.effectType.ATTR_FIX * 10000 + attributeType * 10 + numType
end

function CharFavourLevelUpCtrl:OnBtn_SkipAnim()
  self._mapNode.aniSafeRoot.speed = 1000
  self._mapNode.aniActor2D_PNG.speed = 1000
  if self.delayRefresh ~= nil then
    self.delayRefresh:Cancel()
    self.delayRefresh = nil
  end
  self:Refresh()
end

function CharFavourLevelUpCtrl:OnBtn_ClickClose()
  PlayerData.Char:ChangeShowAffinityLevelUpState(self.curCharId)
  if self.tbLevelUpList ~= nil and #self.tbLevelUpList > 0 then
    self._mapNode.goSafeRoot:SetActive(false)
    self._mapNode.loopAdPre.gameObject:SetActive(false)
    self:RefreshPanel()
    return
  end
  EventManager.Hit(EventId.RevertCharBgActor)
  if self.CloseCallBack ~= nil then
    self.CloseCallBack()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.CharFavourLevelUp)
  PlayerData.Phone:CheckNewChat()
end

return CharFavourLevelUpCtrl
