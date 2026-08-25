local TYPE_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TYPEOF_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TYPEOF_NotDrawImage = typeof(CS.UnityEngine.UI.NotDrawImage)
local TYPEOF_RepeatButton = typeof(CS.RepeatButton)
local _IsNull = CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull
local Vector2 = CS.UnityEngine.Vector2
local CONTENT_ORI_HEIGHT = 70
local CommonKeyWordDescGroupItem, Super = NewViewComponent("CommonKeyWordDescGroupItem")

function CommonKeyWordDescGroupItem:ctor(uiNode, view, strList, effectDescGroupList, isChaos, extraParam)
  Super.ctor(self, uiNode, view)
  self.ui = CardKeyWordItem_New_DoubleResource(uiNode)
  self._strList = strList or {}
  self._effectDescGroupList = effectDescGroupList or {}
  self._isChaos = isChaos
  self._extraParam = extraParam or {}
  self:_InitData()
end

function CommonKeyWordDescGroupItem:_InitData()
  local extraParam = self._extraParam
  self._useSetHeight = extraParam.useSetHeight or nil
  self._needMoveRootPos = extraParam.needMoveRootPos or nil
  self._needAutoScroll = extraParam.needAutoScroll or nil
  self._needDelayAdjustLayout = extraParam.needDelayAdjustLayout or nil
  self._awakerData = extraParam.awakerData or {}
  self._skillTid = extraParam.skillTid or extraParam.skillId or nil
  self._skillLevel = extraParam.skillLevel or 1
  self._card = extraParam.card
  self._closeCallback = extraParam.closeCallback
  for _, effectDescGroup in ipairs(self._effectDescGroupList) do
    if effectDescGroup and effectDescGroup.descList then
      for _, descGroup in ipairs(effectDescGroup.descList) do
        table.insert(self._strList, descGroup.desc)
      end
    end
  end
  self:_ParseSkillExistStateDesc(self._skillTid)
  self:_ParseStrListExistStateDesc(self._strList)
  self._enableAutoScroll = false
  self._isHide = false
end

function CommonKeyWordDescGroupItem:OnEnterComponent()
  self._scrollGo = self.ui.ScrollView:GetComponent(TYPEOF_ScrollRect)
  self._scrollGo.scrollSensitivity = cd.ScrollSensitivity
  self._scrollGo.verticalNormalizedPosition = 1
  self.ui.Content.transform.sizeDelta = Vector2(self.ui.Content.transform.sizeDelta.x, CONTENT_ORI_HEIGHT)
  local notDrawImage = self.ui.Content:GetComponent(TYPEOF_NotDrawImage)
  if notDrawImage then
    notDrawImage.enabled = not self._needAutoScroll
  end
  local repeatButtonComp = self.ui.Content:GetComponent(TYPEOF_RepeatButton)
  repeatButtonComp = repeatButtonComp or self.ui.Content:AddComponent(TYPEOF_RepeatButton)
  self:SetLongPressButtonIntervalTime(self.ui.Content, tonumber(DT.GetConstant("Role_Press_Time")))
  self:AddLongPressButtonListener(self.ui.Content, System.fn(self, self._OnLongPressClose))
  local enchatGroup, skillGroup, affixGroup, schoolGroup, stateGroup = self:_GetEffectDescGroup(self._strList, self._effectDescGroupList)
  self:_BindDescGroup(enchatGroup, skillGroup, affixGroup, schoolGroup, stateGroup)
  if 0 == #enchatGroup.descList + #skillGroup.descList + #affixGroup.descList + #schoolGroup.descList + #stateGroup.descList then
    self._isHide = true
    self.gameObject:SetActive(false)
  else
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content)
    if self._needDelayAdjustLayout then
      FrameWaiter.OnNextFrame(function()
        if self.ui and not IsNil(self.gameObject) then
          self:_AdjustLayout()
          self:_EnableAutoScroll()
        end
      end, 1)
    else
      self:_AdjustLayout()
      self:_EnableAutoScroll()
    end
  end
end

function CommonKeyWordDescGroupItem:OnExitComponent()
  if self._timer then
    self:StopTimer(self._timer)
    self._timer = nil
  end
  Super.OnExitComponent(self)
end

function CommonKeyWordDescGroupItem:_OnLongPressClose()
  if self._closeCallback then
    self._closeCallback()
  end
end

function CommonKeyWordDescGroupItem:_BindDescGroup(enchatGroup, skillGroup, affixGroup, schoolGroup, stateGroup)
  local createList = {}
  local baseGroupNode = self.ui.Group_Enchant
  local baseParantTF = baseGroupNode.transform.parent
  self:_HideChildNode(baseParantTF)
  local validCount = 0
  local effectGroupList = {
    stateGroup,
    enchatGroup,
    skillGroup,
    affixGroup,
    schoolGroup
  }
  local groupNode
  for _, groupInfo in ipairs(effectGroupList) do
    if #groupInfo.descList > 0 then
      validCount = validCount + 1
      if validCount <= baseParantTF.childCount then
        groupNode = baseParantTF:GetChild(validCount - 1)
        groupNode = groupNode.gameObject
      else
        groupNode = self.view:Instantiate(baseGroupNode, baseParantTF)
      end
      self:SetActive(groupNode, true)
      table.insert(createList, {groupNode, groupInfo})
    end
  end
  for _, info in ipairs(createList) do
    self:AddViewComponent(info[1], CommonEffectDescGroupItem, info[2])
  end
end

function CommonKeyWordDescGroupItem:_HideChildNode(parentTf)
  for i = 0, parentTf.childCount - 1 do
    local child = parentTf:GetChild(i)
    if child then
      self:SetActive(child.gameObject, false)
    end
  end
end

function CommonKeyWordDescGroupItem:_GetEffectDescGroup(strList, effectDesGroupList)
  local enchantDescGroup = {
    name = LT.Text("EnchantDesc"),
    descList = {}
  }
  local skillDescGroup = {
    name = LT.Text("DerivedCardDesc"),
    descList = {}
  }
  local affixDescGroup = {
    name = LT.Text("WordItemDesc"),
    descList = {}
  }
  local stateDescGroup = {
    name = LT.Text("StateEffectDesc"),
    descList = {}
  }
  local schoolDescGroup = {
    name = nil,
    descList = {},
    isSchool = true
  }
  local enchantDescGroupName = LT.Text("EnchantDesc")
  for _, effectGroup in ipairs(effectDesGroupList or {}) do
    if effectGroup.isSchool then
      schoolDescGroup.name = schoolDescGroup.name or effectGroup.name
      for _, desc in ipairs(effectGroup.descList) do
        table.insert(schoolDescGroup.descList, desc)
      end
    else
      for _, group in ipairs({
        enchantDescGroup,
        skillDescGroup,
        affixDescGroup,
        stateDescGroup
      }) do
        if effectGroup.name == group.name then
          for _, desc in ipairs(effectGroup.descList) do
            table.insert(group.descList, desc)
          end
          if group.name == enchantDescGroupName then
            for _, desc in ipairs(group.descList) do
              desc.useBigIcon = true
            end
          end
          break
        end
      end
    end
  end
  for _, str in ipairs(strList) do
    local list = self:_GetEffectDescFromStr(str)
    for _, effectDesc in ipairs(list) do
      if effectDesc.isSkill then
        table.insert(skillDescGroup.descList, effectDesc)
      else
        table.insert(affixDescGroup.descList, effectDesc)
      end
    end
  end
  if bg.isPVP then
    affixDescGroup.name = LT.Text("StateEffectDesc")
  end
  return enchantDescGroup, skillDescGroup, affixDescGroup, schoolDescGroup, stateDescGroup
end

function CommonKeyWordDescGroupItem:_GetEffectDescFromStr(str)
  if not str or "" == str then
    return {}
  end
  local patternLink = "\"([%w_]+):(%d+)\""
  local effectDescList = {}
  for richKey, id in StrUtils.GmatchWordsEffectTag(str) do
    local richConfig = DT.WordsEffectConfig[richKey]
    if richConfig and richConfig.SkillLink then
      richKey = "SkillLink"
      id = richConfig.SkillLink
    elseif richConfig and richConfig.StateLink then
      richKey = "StateLink"
      id = richConfig.StateLink
    end
    local effectDesc = self:_BuildEffectDesc(richKey, id)
    if effectDesc then
      table.insert(effectDescList, effectDesc)
    end
  end
  for richKey, id in string.gmatch(str, patternLink) do
    local effectDesc = self:_BuildEffectDesc(richKey, id)
    if effectDesc then
      table.insert(effectDescList, effectDesc)
    end
  end
  return effectDescList
end

function CommonKeyWordDescGroupItem:_BuildEffectDesc(richKey, id)
  local effectDesc = {}
  id = tonumber(id)
  if "SkillLink" == richKey then
    local skillCfg = DT.Skill[id]
    if not skillCfg then
      Logger.Warn("CommonKeyWordDescGroupItem: SkillLink id not found, id=", id)
    else
      local awakerData = self._awakerData
      local breakSkillLevel, potencyLevel = SkillUtils.GetAwakerSkillTQLevels(awakerData)
      local nameParams = {
        awaker = awakerData,
        card = self._card,
        skillId = id
      }
      effectDesc.isSkill = true
      effectDesc.icon = CommonDefine.DerivativeCardIcon
      effectDesc.name = BattleSkillUtils.GetSkillName(skillCfg, breakSkillLevel, potencyLevel, nameParams)
      if skillCfg.Cost then
        local cost = BattleSkillUtils.GetResolvedSkillCost(skillCfg, breakSkillLevel, potencyLevel, nameParams)
        if nil ~= cost then
          effectDesc.subDesc = string.format("<EnergyColour:%s>", LT.Textf("AwakerSkillValueTips", cost))
        end
      end
      effectDesc.desc = SkillUtils.GetAwakerSkillDesc(awakerData or {}, id, self._skillLevel, nil, self._card)
      effectDesc.layerCountList = {}
    end
  elseif "StateLink" == richKey then
    local stateCfg = DT.State[id]
    if not stateCfg then
      Logger.Warn("CommonKeyWordDescGroupItem: StateLink id not found, id=", id)
    else
      local desc, name
      if self._skillTid then
        desc, name = SkillUtils.GetStateDescBySkill(self._awakerData or {}, self._skillTid, self._skillLevel, id, self._card)
      else
        local stateCompute = OuterStateCompute(id, {}, 1, {})
        name = stateCfg.Name
        desc = stateCompute:GetDesc()
      end
      effectDesc.icon = stateCfg.Icon and bc.ICON_PATH_PERFIX .. stateCfg.Icon
      effectDesc.name = name
      effectDesc.desc = desc
      effectDesc.subDesc = nil
      effectDesc.layerCountList = {}
    end
  end
  if effectDesc.name then
    return effectDesc
  end
  return nil
end

function CommonKeyWordDescGroupItem:_AdjustLayout()
  if self._useSetHeight then
    local setHeight = self:_GetScrollViewHeight()
    self.ui.ScrollView.transform.sizeDelta = Vector2(self.ui.ScrollView.transform.sizeDelta.x, setHeight)
    return
  end
  local uiNodeRT = self.gameObject:GetComponent(TYPE_RectTransform)
  if not uiNodeRT then
    return
  end
  local uiNodeRTPosY = uiNodeRT.anchoredPosition.y
  local targetParent = uiNodeRT.parent
  while not _IsNull(targetParent) do
    uiNodeRTPosY = uiNodeRTPosY + targetParent.anchoredPosition.y
    targetParent = targetParent.parent
  end
  local contentHeight = self.ui.Content.transform.sizeDelta.y
  local screenHeight = UIRootMgr.GetBGImageHeight()
  local halfScreenHight = screenHeight / 2
  local scrollViewTargetHeight
  local overBottomVal = uiNodeRTPosY + halfScreenHight - contentHeight
  local isOverBottom = overBottomVal < 0
  if isOverBottom then
    scrollViewTargetHeight = uiNodeRTPosY + halfScreenHight
  else
    scrollViewTargetHeight = contentHeight
  end
  self.ui.ScrollView.transform.sizeDelta = Vector2(self.ui.ScrollView.transform.sizeDelta.x, scrollViewTargetHeight)
  if not self._needMoveRootPos then
    if isOverBottom then
      self._enableAutoScroll = true
    end
    return
  end
  if not isOverBottom then
    return
  end
  local screenTopPadding = self:_GetScreenTopPadding()
  local remainTopVal
  if uiNodeRTPosY > 0 then
    remainTopVal = halfScreenHight - uiNodeRTPosY - screenTopPadding
  else
    remainTopVal = math.abs(uiNodeRTPosY) + halfScreenHight - screenTopPadding
  end
  if remainTopVal < math.abs(overBottomVal) then
    self._enableAutoScroll = true
  end
  if remainTopVal < 0 then
    return
  end
  local realMoveUpVal = math.min(math.abs(overBottomVal), remainTopVal)
  uiNodeRT.transform.anchoredPosition = Vector2(uiNodeRT.transform.anchoredPosition.x, uiNodeRT.transform.anchoredPosition.y + realMoveUpVal)
  self.ui.ScrollView.transform.sizeDelta = Vector2(self.ui.ScrollView.transform.sizeDelta.x, scrollViewTargetHeight + realMoveUpVal)
end

function CommonKeyWordDescGroupItem:_EnableAutoScroll()
  if not self._enableAutoScroll or not self._needAutoScroll then
    return
  end
  local scrollToBottom = true
  local sideStopTime = 0
  self._timer = self:BindTimer(0.01, -1, function()
    if sideStopTime >= 0 then
      sideStopTime = sideStopTime - 1
      return
    end
    if scrollToBottom then
      local newPos = self._scrollGo.verticalNormalizedPosition - 0.0025
      self._scrollGo.verticalNormalizedPosition = newPos
      if newPos < 0 then
        sideStopTime = 100
        scrollToBottom = false
      end
    else
      local newPos = self._scrollGo.verticalNormalizedPosition + 0.0025
      self._scrollGo.verticalNormalizedPosition = newPos
      if newPos > 1 then
        sideStopTime = 100
        scrollToBottom = true
      end
    end
  end)
end

function CommonKeyWordDescGroupItem:_GetScreenTopPadding()
  return self.ui.Screen_Top_Padding.transform.sizeDelta.y
end

function CommonKeyWordDescGroupItem:_GetScrollViewHeight()
  return self.ui.ScrollView_Height.transform.sizeDelta.y
end

function CommonKeyWordDescGroupItem:_ParseStrListExistStateDesc(strList)
  for _, str in ipairs(strList) do
    for richKey, id in StrUtils.GmatchWordsEffectTag(str) do
      local richConfig = DT.WordsEffectConfig[richKey]
      if richConfig and richConfig.SkillLink then
        richKey = "SkillLink"
        id = richConfig.SkillLink
      end
      id = tonumber(id)
      if "SkillLink" == richKey then
        local skillCfg = DT.Skill[id]
        if skillCfg then
          self:_ParseSkillExistStateDesc(skillCfg.ID)
        end
      end
    end
    for richKey, id in string.gmatch(str or "", "\"([%w_]+):(%d+)\"") do
      id = tonumber(id)
      if "SkillLink" == richKey then
        local skillCfg = DT.Skill[id]
        if skillCfg then
          self:_ParseSkillExistStateDesc(skillCfg.ID)
        end
      end
    end
  end
end

function CommonKeyWordDescGroupItem:_ParseSkillExistStateDesc(skillId)
  if not skillId then
    return
  end
  local keyWordTips = SkillUtils.GetSkillKeyWordTips(self._awakerData, skillId, self._skillLevel)
  local effectDescGroup = SkillUtils.GetKeyWordEffectDescGroup(keyWordTips)
  table.insert(self._effectDescGroupList, effectDescGroup)
end

return CommonKeyWordDescGroupItem
