local AwakerSkillMode = CommonDefine.AwakerSkillMode
local tableInsert = table.insert
local tableSort = table.sort

local function createAwakerSkillModelState(awakerModel)
  local state = {}
  state.MAX_SKILL_SHOW_NUM = 5
  state.awakerModel = awakerModel
  
  function state.awakerTid()
    return awakerModel.selectAwakerId
  end
  
  function state.skillList()
    if not state.awakerModel:HasOwnedAwaker(state.awakerTid) and not table.next(DataCenter.awakerData.mockAwakerMap) then
      local skills = state:GetNotOwnAwakerSkillList(state.awakerTid)
      return skills
    end
    local awaker = AwakerDataUtils.GetAwakerData(state.awakerTid)
    if not awaker then
      return {}
    end
    local list = {}
    if not awaker.skills then
      return list
    end
    for _, skill in pairs(awaker.skills) do
      if not skill.isSpecialSkill then
        tableInsert(list, skill)
      end
    end
    tableSort(list, function(a, b)
      return a.slot < b.slot
    end)
    return list
  end
  
  state.selectSlot = 0
  state.mode = AwakerSkillMode.DBG
  state.showSkillStory = false
  
  function state.skillMaxLevel()
    do return state.GetMaxLevel, state, state.selectSlot end
    return state.GetMaxLevel, state, state.selectSlot, state.mode
  end
  
  function state.needAwakerLevel()
    local slot = state.selectSlot
    if 0 == slot then
      return 0
    end
    local curSlotLv = state:GetSlotLevel(slot)
    local breakthroughLvNeed = AwakerDataUtils.GetSkillLevelUpBreakthroughNeed(curSlotLv)
    if not breakthroughLvNeed then
      return 0
    end
    return breakthroughLvNeed
  end
  
  function state.canLevelUp()
    local slot = state.selectSlot
    if 0 == slot or 0 == state.awakerModel.selectAwakerId then
      return false
    end
    if not state.awakerModel:HasOwnedAwaker(state.awakerModel.selectAwakerId) then
      return false
    end
    local mode = state.mode
    if state:IsSkillLevelMax(slot, mode) then
      return false
    end
    local level = state:GetSkillLevel(slot, mode)
    if not AwakerDataUtils.CheckSkillLevelUpUnlockCondition(level) then
      return false
    end
    local awaker = state.awakerModel:GetAwakerData(state.awakerModel.selectAwakerId)
    local awakerNeedLv = state.needAwakerLevel
    local breakthroughLevel = awaker.currBreakthroughStar or 0
    return awakerNeedLv <= breakthroughLevel
  end
  
  function state.targetLevel()
    local curLevel = state:GetSkillLevel(state.selectSlot, state.mode)
    if curLevel >= state.skillMaxLevel then
      return state.skillMaxLevel
    end
    if not state.canLevelUp then
      return curLevel + 1
    end
    return curLevel + 1
  end
  
  function state.selectSlotLevel()
    if 0 == state.selectSlot then
      return 0
    end
    do return state.GetSkillLevel, state, state.selectSlot end
    return state.GetSkillLevel, state, state.selectSlot, state.mode
  end
  
  function state.seletSlotOriLevel()
    if 0 == state.selectSlot then
      return 0
    end
    do return state.GetSlotLevel, state end
    return state.GetSlotLevel, state, state.selectSlot
  end
  
  function state.hasCoefficientTypelist()
    local slot = state.selectSlot
    local mode = state.mode
    local tid = state:GetSkillTid(slot, mode)
    local skillCfg = DT.Skill[tid]
    if not skillCfg then
      return false
    end
    local awaker = state.awakerModel:GetAwakerData(state.awakerModel.selectAwakerId)
    local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
    local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awaker)
    return BattleSkillUtils.GetSkillCoefficientTypelist(skillCfg, breakSkillLevel, potencyLevel) ~= nil
  end
  
  state.showSkillLevelUp = false
  
  function state.skillChangeArgs()
    if state.showSkillLevelUp == false then
      return {}
    end
    local awaker = state.awakerModel:GetAwakerData(state.awakerTid)
    if not awaker then
      Logger.Info("找不到唤醒体数据:", tostring(state.awakerTid))
      return
    end
    local slot = state.selectSlot
    local mode = state.mode
    local tid = state:GetSkillTid(slot, mode)
    assert(nil ~= tid, string.format("技能配置id为空: %s, %s", slot, mode))
    local skillCfg = DT.Skill[tid]
    assert(nil ~= skillCfg, "找不到技能配置:" .. tostring(tid))
    local changeArgs = {}
    local currAgrs = SkillUtils.GetSkillPropertyListDesc(skillCfg, awaker, state.selectSlotLevel)
    local nextArgs = SkillUtils.GetSkillPropertyListDesc(skillCfg, awaker, state.targetLevel)
    local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
    local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awaker)
    local effectNameText = BattleSkillUtils.GetSkillEffectNameList(skillCfg, breakSkillLevel, potencyLevel)
    effectNameText = LT.Text(effectNameText)
    local effectNameList
    if string.contains(effectNameText, ",") then
      effectNameList = string.split(effectNameText, ",")
    elseif string.contains(effectNameText, "， ") then
      effectNameList = string.split(effectNameText, "， ")
    elseif string.contains(effectNameText, "，") then
      effectNameList = string.split(effectNameText, "，")
    elseif string.contains(effectNameText, "、") then
      effectNameList = string.split(effectNameText, "、")
    else
      effectNameList = {effectNameText}
    end
    local length = math.max(#currAgrs, #nextArgs)
    for i = 1, length do
      local currShowValue = currAgrs[i] or 0
      local nextShowValue = nextArgs[i] or 0
      local hasMatchStr = false
      local isMaxLevel = state.skillMaxLevel
      if currShowValue and nextShowValue and (isMaxLevel or currAgrs[i] ~= nextArgs[i]) then
        if string.match(nextShowValue, "(%*%d+%.?%d*%%)") then
          hasMatchStr = true
          nextShowValue = string.gsub(nextShowValue, "(%*%d+%.?%d*%%)", "<Blue:%0>")
        end
        if not hasMatchStr then
          nextShowValue = string.format("<Blue:%s>", nextShowValue)
        end
        local data = {
          nameText = effectNameList[i],
          currArgShowText = currShowValue,
          nextArgShowText = nextShowValue,
          iconPath = skillCfg.Icon,
          hasImproved = true
        }
        print("[AwakerSkillModel.skillChangeArgs] insert data:", table.tostring and table.tostring(data) or tostring(data))
        table.insert(changeArgs, data)
      end
    end
    return changeArgs
  end
  
  function state.levelUpCostItems()
    local slot = state.selectSlot
    if 0 == slot then
      return {}
    end
    local mode = state.mode
    local skillLevel = state.seletSlotOriLevel
    local tid = state:GetSkillTid(slot, mode)
    do return AwakerDataUtils.GetSkillUpgradeCostItem, state.awakerTid, tid end
    return AwakerDataUtils.GetSkillUpgradeCostItem, state.awakerTid, tid, skillLevel
  end
  
  function state.levelUpNeedMoneyData()
    if 0 == state.selectSlot then
      return
    end
    local slot = state.selectSlot
    local mode = state.mode
    local skillLevel = state.seletSlotOriLevel
    local tid = state:GetSkillTid(slot, mode)
    local coinCostData = AwakerDataUtils.GetSkillUpgradeCoinCost(state.awakerTid, tid, skillLevel)
    return coinCostData
  end
  
  function state.isItemEnoughForLevelUp()
    local slot = state.selectSlot
    if 0 == slot then
      return false
    end
    local list = state.levelUpCostItems
    local enough = true
    for _, data in pairs(list) do
      if not data then
      else
        local ownNum = ItemDataUtils.GetItemNum(data.tid)
        if ownNum < data.num then
          enough = false
          break
        end
      end
    end
    if enough then
      local moneyTid = state.levelUpNeedMoneyData.tid
      local ownMoney = ItemDataUtils.GetItemNum(moneyTid) or 0
      local need = state.levelUpNeedMoneyData.num or 0
      local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
      local funcModule = "AwakerSkillLvUp"
      local effectResultValue = awakerModel:GetResNeedReducePreviewResult(need, effectType, funcModule)
      if effectResultValue then
        need = effectResultValue
      end
      enough = ownMoney >= need
    end
    return enough
  end
  
  state.showSkillDetail = false
  return state
end

local function createAwakerSkillModelViews(data)
  local views = {}
  
  function views:GetSkillData(slot)
    if not self.skillList or #self.skillList <= 0 then
      return {}
    end
    for _, skill in pairs(self.skillList) do
      if not skill then
      elseif skill.slot == slot then
        return skill
      end
    end
    return {}
  end
  
  function views:GetSkillStateDesc(skill)
    local awaker = self.awakerModel:GetAwakerData(self.awakerTid)
    if not awaker then
      return ""
    end
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerTid)
    local stateText = ""
    local careTypes = {Normal = true, Describe = true}
    local stateInfoList = SkillUtils.GetSkillDescStateInfoList(awakerData, skill.tid, skill.level)
    for _, stateInfo in pairs(stateInfoList) do
      local stateCfg = DT.State[stateInfo.stateId]
      if stateCfg and careTypes[stateInfo.ShowType] then
        if LangTable.NeedJoinSpaceBetweenDesc() then
          stateText = LangTable.JoinWesternDescSegment(stateText, StrUtils.ToWesternNoBreakNameText(stateInfo.name))
        else
          stateText = stateText .. stateInfo.name .. LT.Text("Dot")
        end
      end
    end
    do return LT.Text end
    return LT.Text, stateText, pairs(stateInfoList)
  end
  
  function views:GetSkillTid(slot, _)
    local skill = self:GetSkillData(slot)
    if not skill then
      return 0
    end
    return skill.tid
  end
  
  function views:GetSkillName(slot, mode)
    local tid = self:GetSkillTid(slot, mode)
    assert(nil ~= tid, string.format("技能配置id为空: %s, %s", slot, mode))
    local awaker = self.awakerModel:GetAwakerData(self.awakerTid)
    if not awaker then
      Logger.Info("找不到唤醒体数据:", tostring(self.awakerTid))
      return
    end
    local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
    local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awaker)
    do return BattleSkillUtils.GetSkillName, DT.Skill[tid], breakSkillLevel end
    return BattleSkillUtils.GetSkillName, DT.Skill[tid], breakSkillLevel, potencyLevel
  end
  
  function views:GetSkillIcon(slot, _)
    local skill = self:GetSkillData(slot)
    if skill and skill.isSpecialSkill then
      local spSkillTid = self:GetSpecialSkillTidByAwaker()
      do return AwakerDataUtils.GetSpecialSkillIcon end
      return AwakerDataUtils.GetSpecialSkillIcon, spSkillTid
    end
    local iconName = DT.GetOriginalConstant("AwakerSkillIconName")[slot]
    return AwakerDataUtils.GetSkillIconPrefix() .. iconName
  end
  
  function views:GetSkillAwakerIcon(slot)
    local skill = self:GetSkillData(slot)
    local config = DT.Skill[skill.tid]
    if not config then
      return nil
    end
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, config.AwakerID
  end
  
  function views:GetSkillLevel(slot, _)
    local skill = self:GetSkillData(slot)
    if not skill then
      return 0
    end
    if skill.isBreakthroughSkill then
      return 0
    end
    if skill.isSpecialSkill then
      do return self.GetSlotLevel, self end
      return self.GetSlotLevel, self, slot
    end
    return skill.level or 0
  end
  
  function views:GetMaxLevel(slot, mode)
    if not slot or 0 == slot then
      return
    end
    local cfgLevel = DT.GetConstant("AwakerSkillUpperLevel")
    local level = data:GetSkillLevel(slot, mode)
    local slotLevel = data:GetSlotLevel(slot)
    local extraLevel = math.max(0, level - slotLevel)
    return cfgLevel + extraLevel
  end
  
  function views:GetSlotLevel(slot)
    local skill = self:GetSkillData(slot)
    if not skill then
      return 0
    end
    if skill.isBreakthroughSkill then
      return 0
    end
    return skill.upNum + 1
  end
  
  function views:GetSkillExtraLevel(slot, mode)
    local skill = self:GetSkillData(slot)
    if not skill then
      return 0
    end
    local level = self:GetSkillLevel(slot, mode)
    local slotLevel = self:GetSlotLevel(slot)
    local extraLevel = level - slotLevel
    return extraLevel
  end
  
  function views:GetSkillDesc(slot, mode, isPreview)
    local awaker = self.awakerModel:GetAwakerData(self.awakerTid)
    if not awaker then
      Logger.Info("找不到唤醒体数据:", tostring(self.awakerTid))
      return
    end
    local tid = self:GetSkillTid(slot, mode)
    assert(nil ~= tid, string.format("技能配置id为空: %s, %s", slot, mode))
    local level = self:GetSkillLevel(slot, mode)
    if isPreview then
      level = self:GetMaxLevel(slot)
    end
    local desc = SkillUtils.GetAwakerSkillDesc(awaker, tid, level)
    return desc
  end
  
  function views:GetSkillCost(slot)
    if 0 == slot then
      return 0
    end
    local tid = self:GetSkillTid(slot, AwakerSkillMode.DBG)
    assert(nil ~= tid, string.format("技能配置id为空: %s, %s", slot, AwakerSkillMode.DBG))
    local cfg = DT.Skill[tid]
    if not cfg then
      return 0
    end
    local awaker = self.awakerModel:GetAwakerData(self.awakerTid)
    if not awaker then
      Logger.Info("找不到唤醒体数据:", tostring(self.awakerTid))
      return
    end
    local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
    local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awaker)
    do return BattleSkillUtils.GetSkillCost, cfg, breakSkillLevel end
    return BattleSkillUtils.GetSkillCost, cfg, breakSkillLevel, potencyLevel
  end
  
  function views:GetSpecialSkillTidByAwaker()
    local awakerTid = self.awakerModel.selectAwakerId
    if not awakerTid then
      return ""
    end
    do return AwakerDataUtils.GetSpeciallSkillIdByAwaker end
    return AwakerDataUtils.GetSpeciallSkillIdByAwaker, awakerTid
  end
  
  function views:GetSkillStory(slot, mode)
    local skill = self:GetSkillData(slot)
    if skill and skill.isSpecialSkill then
      local spSkillTid = self:GetSpecialSkillTidByAwaker()
      do return AwakerDataUtils.GetSpecialSkillWorldDesc end
      return AwakerDataUtils.GetSpecialSkillWorldDesc, spSkillTid, nil, nil, nil, nil
    end
    local tid = self:GetSkillTid(slot, mode)
    assert(nil ~= tid, string.format("技能配置id为空: %s, %s", slot, mode))
    local cfg = DT.Skill[tid]
    assert(nil ~= cfg, "找不到技能配置:" .. tostring(tid))
    do return LT.Text end
    return LT.Text, cfg.AwakerSkillBackgroundStory, "找不到技能配置:" .. tostring(tid), tostring(tid), tid
  end
  
  function views:IsSkillLevelMax(slot, _)
    local level = self:GetSkillLevel(slot, data.mode)
    return level >= self.skillMaxLevel
  end
  
  function views:GetSelectSlot()
    return self.selectSlot
  end
  
  function views:GetNotOwnAwakerSkillList(tid)
    local skills = AwakerDataUtils.GetNotOwnAwakerSkills(tid)
    return skills
  end
  
  function views:IsAllSkillLevelMax()
    if self.skillList then
      for _, skill in ipairs(self.skillList) do
        if skill.level < self:GetMaxLevel(skill.slot) then
          return false
        end
      end
    end
    return true
  end
  
  return views
end

local function createAwakerSkillModelActions(data)
  local actions = {}
  
  function actions:SetSelectSlot(slot)
    if not slot then
      return
    end
    data.selectSlot = slot
  end
  
  function actions:SetAwakerId(tid)
    if not tid then
      return
    end
    data.awakerTid = tid
  end
  
  function actions:SetSkillMode(mode)
    if not mode then
      return
    end
    data.mode = mode
  end
  
  function actions:SetStoryShow(show)
    if nil == show then
      show = false
    end
    data.showSkillStory = show
  end
  
  function actions:ShowSkillLevelUp(show)
    if nil == show then
      show = false
    end
    data.showSkillLevelUp = show
  end
  
  function actions:SetShowSkillDetail(state)
    if nil == state then
      state = false
    end
    data.showSkillDetail = state
  end
  
  function actions:UpdateSkillLevel(slot, svrData)
    local skill = data:GetSkillData(slot)
    if skill then
      if svrData.upNum then
        skill.upNum = svrData.upNum
      end
      if svrData.level then
        skill.level = svrData.level
      end
    end
  end
  
  function actions:ReqAwakerSkillLevelUp(cb)
    local slot = data.selectSlot
    if 0 == slot or 0 == data.awakerModel.selectAwakerId then
      return false
    end
    if not data.awakerModel:HasOwnedAwaker(data.awakerTid) then
      return false
    end
    local mode = data.mode
    if data:IsSkillLevelMax(slot, mode) then
      Alert.Show(10450)
      return
    end
    local level = data:GetSkillLevel(slot, mode)
    if not AwakerDataUtils.CheckSkillLevelUpUnlockCondition(level, true) then
      return
    end
    local awakerNeedLv = data.needAwakerLevel
    local awaker = data.awakerModel:GetAwakerData(data.awakerModel.selectAwakerId)
    if awakerNeedLv > awaker.currBreakthroughStar then
      Alert.Show(10451)
      return
    end
    if not data.isItemEnoughForLevelUp then
      Alert.Show(10452)
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnSkillUpgrade", function(svrData)
      self:UpdateSkillLevel(data.selectSlot, svrData)
      local awakerTid = data.awakerTid
      local awakerData = data.awakerModel:GetAwakerData(awakerTid)
      RedPointDataUtils.UpdateAwakerRed(awakerData)
      if cb then
        cb()
      end
    end, function()
    end, data.awakerTid, data.selectSlot)
  end
  
  function actions:ReqAwakerBreakSkillActive(cb)
    local slot = data.selectSlot
    if 0 == slot or 0 == data.awakerModel.selectAwakerId then
      return
    end
    local skill = data:GetSkillData(slot)
    if not skill or not skill.isBreakthroughSkill then
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "ActiveAwakerBreakSkill", function()
      local awakerData = AwakerDataUtils.GetAwakerData(data.awakerTid)
      awakerData.breakSkillUnlock[skill.unlockBreakthroughLevel] = true
      skill.actived = true
      if cb then
        cb()
      end
    end, function()
    end, data.awakerTid, skill.unlockBreakthroughLevel)
  end
  
  return actions
end

local function onSetup(_, _)
end

local AwakerSkillModel = Vue.model("AwakerSkillModel", createAwakerSkillModelState):views(createAwakerSkillModelViews):actions(createAwakerSkillModelActions):setup(onSetup)
return AwakerSkillModel
