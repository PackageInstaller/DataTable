local TYPE_RectTransform = typeof(CS.UnityEngine.RectTransform)
local TYPEOF_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local _IsNull = CS.Z1Client.UnityEngineObjectExtensionForLua.IsNull
local TYPEOF_NotDrawImage = typeof(CS.UnityEngine.UI.NotDrawImage)
local CONTENT_ORI_HEIGHT = 70
local CommonKeyWordDescGroup, Super = System.NewComponent("CommonKeyWordDescGroup")

function CommonKeyWordDescGroup:ctor(uiNode, strList, effectDescGroupList, isChaos, extraParam)
  Super.ctor(self)
  self.ui = CardKeyWordItem_New_DoubleResource(uiNode)
  self.strList = strList or {}
  self.effectDescGroupList = effectDescGroupList or {}
  self.isChaos = isChaos
  if extraParam and type(extraParam) == "table" then
    self.useSetHeight = extraParam.useSetHeight or nil
    self.needMoveRootPos = extraParam.needMoveRootPos or nil
    self.needAutoScroll = extraParam.needAutoScroll or nil
    self.needDelayAdjustLayout = extraParam.needDelayAdjustLayout or nil
    self.awakerData = extraParam.awakerData or {}
    self.skillTid = extraParam.skillTid or extraParam.skillId or nil
    self.skillLevel = extraParam.skillLevel or 1
    self.card = extraParam.card
    self.closeCallback = extraParam.closeCallback
  end
  for _, effectDescGroup in ipairs(self.effectDescGroupList) do
    if effectDescGroup and effectDescGroup.descList then
      for _, descGroup in ipairs(effectDescGroup.descList) do
        table.insert(self.strList, descGroup.desc)
      end
    end
  end
  self:ParseSkillExistStateDesc(self.skillTid)
  self:ParseStrListExistStateDesc(self.strList)
  self.enableAutoScroll = false
  self.isHide = false
end

function CommonKeyWordDescGroup:OnBind(binder)
  self.binder = binder
  self.scrollGo = self.ui.ScrollView:GetComponent(TYPEOF_ScrollRect)
  self.scrollGo.scrollSensitivity = cd.ScrollSensitivity
  self.scrollGo.verticalNormalizedPosition = 1
  self.ui.Content.transform.sizeDelta = CS.UnityEngine.Vector2(self.ui.Content.transform.sizeDelta.x, CONTENT_ORI_HEIGHT)
  local notDrawImage = self.ui.Content:GetComponent(TYPEOF_NotDrawImage)
  if notDrawImage then
    notDrawImage.enabled = not self.needAutoScroll
  end
  binder:BindLongPressButton(self.ui.Content, nil, function()
    if self.closeCallback then
      self.closeCallback()
    end
  end, tonumber(DT.GetConstant("Role_Press_Time")))
  local enchatGroup, skillGroup, affixGroup, schoolGroup, stateGroup = self:GetEffectDescGroup(self.strList, self.effectDescGroupList)
  self:BindDescGroup(enchatGroup, skillGroup, affixGroup, schoolGroup, stateGroup)
  if 0 == #enchatGroup.descList + #skillGroup.descList + #affixGroup.descList + #schoolGroup.descList + #stateGroup.descList then
    self.isHide = true
    self.ui.uiNode:SetActive(false)
  else
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Content)
    if self.needDelayAdjustLayout then
      FrameWaiter.OnNextFrame(function()
        if self.ui then
          self:AdjustLayout()
          self:EnableAutoScroll()
        end
      end, 1)
    else
      self:AdjustLayout()
      self:EnableAutoScroll()
    end
  end
end

function CommonKeyWordDescGroup:BindDescGroup(enchatGroup, skillGroup, affixGroup, schoolGroup, stateGroup)
  local createList = {}
  local baseGroupNode = self.ui.Group_Enchant
  local baseParantTF = baseGroupNode.transform.parent
  self:HideChildNode(baseParantTF)
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
        groupNode = GameObject.Instantiate(baseGroupNode, baseParantTF)
      end
      self.binder:SetActive(groupNode, true)
      table.insert(createList, {groupNode, groupInfo})
    end
  end
  for _, info in ipairs(createList) do
    self.binder:BindComponent(CommonEffectDescGroup(info[1], info[2]))
  end
end

function CommonKeyWordDescGroup:HideChildNode(parentTf)
  for i = 0, parentTf.childCount - 1 do
    local child = parentTf:GetChild(i)
    if child then
      self.binder:SetActive(child.gameObject, false)
    end
  end
end

function CommonKeyWordDescGroup:GetEffectDescGroup(strList, effectDesGroupList)
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
      table.append(schoolDescGroup.descList, effectGroup.descList)
    else
      for _, group in ipairs({
        enchantDescGroup,
        skillDescGroup,
        affixDescGroup,
        stateDescGroup
      }) do
        if effectGroup.name == group.name then
          table.append(group.descList, effectGroup.descList)
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
    local list = self:GetEffectDescFromStr(str)
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

function CommonKeyWordDescGroup:GetEffectDescFromStr(str)
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
  for richKey, id in string.gmatch(str or "", patternLink) do
    local effectDesc = self:_BuildEffectDesc(richKey, id)
    if effectDesc then
      table.insert(effectDescList, effectDesc)
    end
  end
  return effectDescList
end

function CommonKeyWordDescGroup:_BuildEffectDesc(richKey, id)
  local effectDesc = {}
  id = tonumber(id)
  if "SkillLink" == richKey then
    local skillCfg = DT.Skill[id]
    if not skillCfg then
      Logger.Warn("CommonKeyWordDescGroup: SkillLink id not found, id=", id)
    else
      local awakerData = self.awakerData
      local breakSkillLevel, potencyLevel = SkillUtils.GetAwakerSkillTQLevels(awakerData)
      local nameParams = {
        awaker = awakerData,
        card = self.card,
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
      effectDesc.desc = SkillUtils.GetAwakerSkillDesc(awakerData or {}, id, self.skillLevel, nil, self.card)
      effectDesc.layerCountList = {}
    end
  elseif "StateLink" == richKey then
    local stateCfg = DT.State[id]
    if not stateCfg then
      Logger.Warn("CommonKeyWordDescGroup: StateLink id not found, id=", id)
    else
      local desc, name
      if self.skillTid then
        desc, name = SkillUtils.GetStateDescBySkill(self.awakerData or {}, self.skillTid, self.skillLevel, id, self.card)
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

function CommonKeyWordDescGroup:AdjustLayout()
  if self.useSetHeight then
    local setHeight = self:GetScrollViewHeight()
    self.ui.ScrollView.transform.sizeDelta = CS.UnityEngine.Vector2(self.ui.ScrollView.transform.sizeDelta.x, setHeight)
    return
  end
  local uiNodeRT = self.ui.uiNode:GetComponent(TYPE_RectTransform)
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
  self.ui.ScrollView.transform.sizeDelta = CS.UnityEngine.Vector2(self.ui.ScrollView.transform.sizeDelta.x, scrollViewTargetHeight)
  if not self.needMoveRootPos then
    if isOverBottom then
      self.enableAutoScroll = true
    end
    return
  end
  if not isOverBottom then
    return
  end
  local screenTopPadding = self:GetScreenTopPadding()
  local remainTopVal
  if uiNodeRTPosY > 0 then
    remainTopVal = halfScreenHight - uiNodeRTPosY - screenTopPadding
  else
    remainTopVal = math.abs(uiNodeRTPosY) + halfScreenHight - screenTopPadding
  end
  if remainTopVal < math.abs(overBottomVal) then
    self.enableAutoScroll = true
  end
  if remainTopVal < 0 then
    return
  end
  local realMoveUpVal = math.min(math.abs(overBottomVal), remainTopVal)
  uiNodeRT.transform.anchoredPosition = CS.UnityEngine.Vector2(uiNodeRT.transform.anchoredPosition.x, uiNodeRT.transform.anchoredPosition.y + realMoveUpVal)
  self.ui.ScrollView.transform.sizeDelta = CS.UnityEngine.Vector2(self.ui.ScrollView.transform.sizeDelta.x, self.ui.ScrollView.transform.sizeDelta.y + realMoveUpVal)
end

function CommonKeyWordDescGroup:EnableAutoScroll()
  if not self.enableAutoScroll or not self.needAutoScroll then
    return
  end
  local scrollToBottom = true
  local sideStopTime = 0
  self.timer = self.binder:BindTimer(0.01, -1, function()
    if sideStopTime >= 0 then
      sideStopTime = sideStopTime - 1
      return
    end
    if scrollToBottom then
      local newPos = self.scrollGo.verticalNormalizedPosition - 0.0025
      self.scrollGo.verticalNormalizedPosition = newPos
      if newPos < 0 then
        sideStopTime = 100
        scrollToBottom = false
      end
    else
      local newPos = self.scrollGo.verticalNormalizedPosition + 0.0025
      self.scrollGo.verticalNormalizedPosition = newPos
      if newPos > 1 then
        sideStopTime = 100
        scrollToBottom = true
      end
    end
  end)
end

function CommonKeyWordDescGroup:GetScreenTopPadding()
  return self.ui.Screen_Top_Padding.transform.sizeDelta.y
end

function CommonKeyWordDescGroup:GetScrollViewHeight()
  return self.ui.ScrollView_Height.transform.sizeDelta.y
end

function CommonKeyWordDescGroup:ParseStrListExistStateDesc(strList)
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
          self:ParseSkillExistStateDesc(skillCfg.ID)
        end
      end
    end
    for richKey, id in string.gmatch(str or "", "\"([%w_]+):(%d+)\"") do
      id = tonumber(id)
      if "SkillLink" == richKey then
        local skillCfg = DT.Skill[id]
        if skillCfg then
          self:ParseSkillExistStateDesc(skillCfg.ID)
        end
      end
    end
  end
end

function CommonKeyWordDescGroup:ParseSkillExistStateDesc(skillId)
  if not skillId then
    return
  end
  local keyWordTips = SkillUtils.GetSkillKeyWordTips(self.awakerData, skillId, self.skillLevel)
  local effectDescGroup = SkillUtils.GetKeyWordEffectDescGroup(keyWordTips)
  table.insert(self.effectDescGroupList, effectDescGroup)
end

function CommonKeyWordDescGroup:OnUnbind()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

return CommonKeyWordDescGroup
