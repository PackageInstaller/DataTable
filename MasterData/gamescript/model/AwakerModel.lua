local tableInsert = table.insert
local tableSort = table.sort
local ALL_SCHOOL = 0

local function createAwakerModelState(data)
  local state = {}
  data = data or {}
  state.panelState = CommonDefine.AwakerPanelState.BigHead
  state.oldPanelState = nil
  state.jumpPage = data and data.jumpPage or nil
  if nil ~= state.jumpPage then
    state.panelState = CommonDefine.AwakerPanelState.MiniHead
  end
  state.haveJump = state.jumpPage and true or false
  state.previewAwakersData = data.previewAwakersData
  state.specialAwakerList = data and data.specialAwakerList or nil
  
  function state.specialAwakerMap()
    local map = {}
    if state.specialAwakerList then
      for _, awakerData in pairs(state.specialAwakerList) do
        map[awakerData.tid] = awakerData
      end
    end
    return map
  end
  
  state.showSortType = false
  
  function state.sortTypeList()
    local list = {}
    for _, typeValue in pairs(CommonDefine.AwakerSortType) do
      if nil ~= typeValue and type(typeValue) == "number" then
        tableInsert(list, typeValue)
      end
    end
    tableSort(list, function(a, b)
      return a < b
    end)
    return list
  end
  
  state.sortType = CommonDefine.AwakerSortType.Level
  state.showSchollFilter = false
  state.sortOrder = CommonDefine.SortOrder.Descend
  state.selectAwakerId = data.selectAwakerId or 0
  state.selectAwakerData = nil
  
  function state.awakerCurSkin()
    return state.selectAwakerData and state.selectAwakerData.curSkin or cd.DefaultSkinTid
  end
  
  state.page = state.jumpPage and state.jumpPage or CommonDefine.AwakerPage.List
  state.oldPage = nil
  state.curSchool = 0
  state.playingTransAnim = false
  
  function state.filterSchools()
    local list = {ALL_SCHOOL}
    for tid, _ in pairs(DT.SchoolConfig) do
      tableInsert(list, tid)
    end
    
    local function sortFunc(a, b)
      local cfgA = DT.SchoolConfig[a]
      local cfgB = DT.SchoolConfig[b]
      local orderA = cfgA and cfgA.Order or 0
      local orderB = cfgB and cfgB.Order or 0
      return orderA < orderB
    end
    
    tableSort(list, sortFunc)
    return list
  end
  
  function state.awakerMap()
    if table.next(DataCenter.awakerData.mockAwakerMap) then
      return DataCenter.awakerData.mockAwakerMap
    end
    local map = {}
    for tid, awakerData in pairs(DataCenter.awakerData.awakerMap) do
      if 0 == awakerData.show then
        map[tid] = awakerData
      end
    end
    return map
  end
  
  function state.awakerList()
    local mockAwakerMap = AwakerDataUtils.GetMockAwakerMap()
    if mockAwakerMap and table.next(mockAwakerMap) then
      local rst = {}
      for _, awakerData in pairs(mockAwakerMap) do
        table.insert(rst, awakerData)
      end
      table.sort(rst, function(a, b)
        return a.sort < b.sort
      end)
      return rst
    end
    if state.specialAwakerList then
      return state.specialAwakerList
    end
    local list = {}
    local awakerMap = state.awakerMap
    local curSchool = state.curSchool
    local curTime = math.floor(TimeUtils.GetServerTime())
    for _, awakerData in pairs(awakerMap) do
      local tid = awakerData and awakerData.tid or 0
      local config = DT.AwakerConfig[tid]
      local school = config.School
      local own = AwakerDataUtils.HasOwnedAwaker(tid)
      local canShow = config.AwakeDisplayDate and curTime >= config.AwakeDisplayDate
      canShow = nil == canShow and true or canShow
      if config and (curSchool == school or curSchool == ALL_SCHOOL) then
        if own or canShow then
          tableInsert(list, awakerData)
        end
      else
        Logger.Info("找不到唤醒体配置, tid=%s", tid)
      end
    end
    list = AwakerDataUtils.Sort(list, state.sortOrder, state.sortType)
    return list
  end
  
  state.curAwakerVoiceContent = ""
  state.curAwakerVoiceEventName = ""
  state.darkTidMap = {}
  return state
end

local function createAwakerModelViews(model)
  local views = {}
  
  function views:GetAwakerData(tid)
    if not tid then
      Logger.Info("配置数据获取失败, tid:", tostring(tid))
      return
    end
    local awakerData = self.specialAwakerMap[tid]
    if awakerData then
      return awakerData
    end
    local mapAwakerData = self.awakerMap[tid]
    if mapAwakerData then
      return mapAwakerData
    end
    awakerData = AwakerDataUtils.GetAwakerData(tid)
    if not awakerData then
      return
    end
    if not self:HasOwnedAwaker(awakerData.tid) and not table.next(DataCenter.awakerData.mockAwakerMap) then
      local attrs = AwakerDataUtils.GetNotOwnAwakerAttrs(tid, 1, awakerData)
      awakerData.attrs = attrs
    end
    return awakerData
  end
  
  function views:HasOwnedSelectAwaker()
    do return self.HasOwnedAwaker, self end
    return self.HasOwnedAwaker, self, self.selectAwakerId
  end
  
  function views:IsMockOrOtherPlayer()
    if table.next(DataCenter.awakerData.mockAwakerMap) then
      return true
    end
    if self.previewAwakersData then
      return true
    end
  end
  
  function views:HasOwnedAwaker(tid)
    if not tid then
      return false
    end
    do return AwakerDataUtils.HasOwnedAwaker end
    return AwakerDataUtils.HasOwnedAwaker, tid
  end
  
  function views:GetIsDark(tid)
    return self.darkTidMap[tid]
  end
  
  function views:GetAwakerFighting(tid)
    local awakerData = self:GetAwakerData(tid)
    if not awakerData then
      Logger.Info("数据获取失败, tid:", tostring(tid))
      return 0
    end
    return awakerData.fighting or 0
  end
  
  function views:GetAwakerConfig(tid)
    local config = DT.AwakerConfig[tid]
    return config
  end
  
  function views:IsAllSchool(school)
    return school == ALL_SCHOOL
  end
  
  function views:GetSchoolName(tid)
    local config = DT.SchoolConfig[tid]
    local schoolName = config and LT.Text(config.Name)
    if not schoolName and self:IsAllSchool(tid) then
      schoolName = LT.Text("RoleInterface_Str_Title")
    end
    return schoolName
  end
  
  function views:GetCollectIcon(state)
    if nil == state then
      state = false
    end
    if state then
      return "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Image_Collect_Icon.png"
    end
    return "UIResources/AtlasSource/UI_Awaker_Image/UI_Awaker_Image_UnCollect_Icon.png"
  end
  
  function views:GetSchoolIcon(tid)
    local config = DT.SchoolConfig[tid]
    return config.Icon
  end
  
  function views:GetLittleIcon(tid)
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, tid
  end
  
  function views:GetLittleIcon(tid)
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, tid
  end
  
  function views:GetSortTypeName(sortType)
    do return AwakerDataUtils.GetSortTypeTitle end
    return AwakerDataUtils.GetSortTypeTitle, sortType
  end
  
  function views:GetSortTypeTagContent(sortType, awakerTid)
    if not sortType or not awakerTid then
      return
    end
    local awaker = self:GetAwakerData(awakerTid)
    if not awaker then
      return
    end
    do return AwakerDataUtils.GetSortTypeTagContent, sortType end
    return AwakerDataUtils.GetSortTypeTagContent, sortType, awaker
  end
  
  function views:GetSortOrderName(order)
    if not order then
      return ""
    end
    local key = "ActorString_Sort_Ascend"
    if order == CommonDefine.SortOrder.Descend then
      key = "ActorString_Sort_Descend"
    end
    do return LT.Text end
    return LT.Text, key
  end
  
  function views:GetAwakerName(tid)
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, tid
  end
  
  function views:GetAwakerTitle(tid)
    local config = self:GetAwakerConfig(tid)
    return config and LT.Text(config.Title) or ""
  end
  
  function views:GetAwakerNameEn(tid)
    local config = self:GetAwakerConfig(tid)
    return config and LT.Text(config.NameEn) or ""
  end
  
  function views:GetAwakerClientAttrs(tid)
    if not tid then
      Logger.Info("Error Param: tid is nil")
      return {}
    end
    local awaker = self:GetAwakerData(tid)
    return awaker.clientAttrs
  end
  
  function views:GetAwakerAttrData(tid, attrId)
    if not attrId or not tid then
      return 0
    end
    local awakerData = self:GetAwakerData(tid)
    if not awakerData then
      return 0
    end
    for _, attr in ipairs(awakerData.clientAttrs) do
      if attr and attr.tid == attrId then
        return attr
      end
    end
    return nil
  end
  
  function views:GetAwakerInterest(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return -1
    end
    return awaker.interest
  end
  
  function views:GetAwakerLikes(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    if not self:HasOwnedAwaker(awaker.tid) then
      return 0
    end
    return awaker.like or 0
  end
  
  function views:GetAwakerLikeExpRate(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    if not self:HasOwnedAwaker(awaker.tid) then
      return 0
    end
    local cfg = DT.AwakerFavorability[tid]
    if not cfg then
      return 0
    end
    local datalist = cfg.data_list
    local nexCfg = datalist[awaker.likeLevel + 1]
    if nil == nexCfg then
      return 1
    else
      local rate = awaker.like / nexCfg.AwakerFavorabilityRequire
      return rate
    end
  end
  
  function views:GetAwakerLikeUpgradeExp()
    return 0
  end
  
  function views:GetAwakerLikeLevel(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    if not self:HasOwnedAwaker(awaker.tid) then
      return 0
    end
    return awaker.likeLevel
  end
  
  function views:GetAwakerLevel(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    return awaker.level
  end
  
  function views:GetAwakerType(tid)
    do return AwakerDataUtils.GetAwakerType end
    return AwakerDataUtils.GetAwakerType, tid
  end
  
  function views:GetAwakerExp(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    return awaker.exp
  end
  
  function views:GetAwakerCurrLevelLimit(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    do return AwakerDataUtils.GetAwakerCurrLevelLimit end
    return AwakerDataUtils.GetAwakerCurrLevelLimit, awaker
  end
  
  function views:GetAwakerNextLevelLimit(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    do return AwakerDataUtils.GetAwakerNextBreakthroughLevelLimit end
    return AwakerDataUtils.GetAwakerNextBreakthroughLevelLimit, awaker
  end
  
  function views:GetAwakerReachLevelLimit(tid)
    do return AwakerDataUtils.IsAwakerReachLevelLimit end
    return AwakerDataUtils.IsAwakerReachLevelLimit, tid
  end
  
  function views:GetAwakerCurrBreakthroughStar(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    return awaker.currBreakthroughStar
  end
  
  function views:GetAwakerCurrBreakthroughStarSkillName(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    return awaker.currBreakthroughStarSkillName
  end
  
  function views:GetAwakerCurrBreakthroughStarSkillIcon(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return ""
    end
    return awaker.currBreakthroughStarSkillIcon
  end
  
  function views:GetAwakerNextBreakthroughStarSkillName(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return
    end
    return awaker.nextBreakthroughStarSkillName
  end
  
  function views:GetAwakerNextBreakthroughStarSkillIcon(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return
    end
    return awaker.nextBreakthroughStarSkillIcon
  end
  
  function views:GetAwakerCurrBreakthroughStarAttrAdd(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.currBreakthroughStarAttrAdd
  end
  
  function views:GetAwakerNextBreakthroughStarAttrAdd(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.nextBreakthroughStarAttrAdd
  end
  
  function views:IsOpenBacktrack()
    local own = self:HasOwnedAwaker(self.selectAwakerId)
    local isOpen = BackTrackDataUtils.IsAwakerOpen(self.selectAwakerId)
    local isMock = table.next(DataCenter.awakerData.mockAwakerMap)
    local isSpecList = self.specialAwakerList and table.next(self.specialAwakerList) or false
    return isOpen and own and not isMock and not isSpecList
  end
  
  function views:IsOpenTrinketBind()
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketBind, 0)
    return unlocked
  end
  
  function views:GetAwakerNextBreakthroughStarMtrlCost(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.nextBreakthroughStarMtrlCost
  end
  
  function views:GetAwakerNextBreakthroughStarGoldCost(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    return awaker.nextBreakthroughStarGoldCost
  end
  
  function views:GetAwakerNextBreakthroughStarCostMtrlEnough(tid)
    do return AwakerDataUtils.NextBreakthroughMaterialEnough end
    return AwakerDataUtils.NextBreakthroughMaterialEnough, tid
  end
  
  function views:GetAwakerNextBreakthroughStarCostGoldEnough(tid)
    do return AwakerDataUtils.NextBreakthroughGoldEnough end
    return AwakerDataUtils.NextBreakthroughGoldEnough, tid
  end
  
  function views:GetAwakerCurrBreakthroughStarAttrChange(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.currBreakthroughStarAttrChange
  end
  
  function views:GetAwakerNextBreakthroughStarAttrChange(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.nextBreakthroughStarAttrChange
  end
  
  function views:GetAwakerBreakthroughStarPreview(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return 0
    end
    return awaker.breakthroughStarPreview
  end
  
  function views:GetAwakerBreakthroughMtrlCostPreview(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.breakthroughMtrlCostPreview
  end
  
  function views:GetAwakerBreakthroughGoldCostPreview(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.breakthroughGoldCostPreview
  end
  
  function views:GetAwakerBreakthroughRewardPreview(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return
    end
    return awaker.breakthroughRewardPreview
  end
  
  function views:GetAwakerBreakthroughRewardReceiveStatePreview(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.breakthroughRewardReceiveStatePreview
  end
  
  function views:GetAwakerBreakthroughNextLvRequireTask(tid)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return {}
    end
    return awaker.nextRequireTaskComplete or {}
  end
  
  function views:GetAwakerBreakthroughMaxStar(tid)
    if nil == tid or 0 == tid then
      return CommonDefine.AwakerBreakThrough.NullLevel
    end
    local cfg = DT.AwakerBreakThrough[tid]
    if cfg then
      return #cfg.data_list - 1
    else
      Logger.Error("[突破] 找不到唤醒体\"%s\"的突破配置！", tid)
      return CommonDefine.AwakerBreakThrough.NullLevel
    end
  end
  
  function views:GetBreakthroughRewardReceiveState(tid, star)
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if not awaker then
      return CommonDefine.AwakerBreakThrough.RewardUnavailable
    end
    do return AwakerDataUtils.GetBreakthroughRewardReceiveState, awaker end
    return AwakerDataUtils.GetBreakthroughRewardReceiveState, awaker, star
  end
  
  function views:GetResNeedReducePreviewResult(originValue, effectType, funcModule)
    do return TalentDataUtils.GetResouceReduceResult, originValue, effectType end
    return TalentDataUtils.GetResouceReduceResult, originValue, effectType, funcModule
  end
  
  function views:GetShowOriginBtn()
    local showOriginBtn = true
    if model.specialAwakerList ~= nil or model.previewAwakersData and model.previewAwakersData.hideAwakerChangeForm then
      showOriginBtn = false
    end
    return showOriginBtn
  end
  
  return views
end

local function createAwakerModelActions(data)
  local actions = {}
  
  function actions:SetSelectAwaker(tid)
    local awaker = data:GetAwakerData(tid)
    if not awaker then
      Logger.Info("找不到唤醒体数据:", tostring(tid))
      return
    end
    data.selectAwakerData = awaker
  end
  
  function actions:SetCurSchool(school)
    data.curSchool = school
  end
  
  function actions:SetDarkTid(tid)
    self.darkTidMap[tid] = true
  end
  
  function actions:BackPanelState()
    if self.panelState == CommonDefine.AwakerPanelState.Detail then
      self:ExitDetailState()
    else
      self:ExitMiniHeadState()
    end
  end
  
  function actions:EnterDetailState()
    self:SetPanelState(CommonDefine.AwakerPanelState.Detail)
  end
  
  function actions:ExitDetailState()
    self:SetPanelState(CommonDefine.AwakerPanelState.MiniHead)
  end
  
  function actions:EnterMiniHeadState()
    self:SetPanelState(CommonDefine.AwakerPanelState.MiniHead)
  end
  
  function actions:ExitMiniHeadState()
    self:SetPanelState(CommonDefine.AwakerPanelState.BigHead)
  end
  
  function actions:SetPanelState(panelState)
    self.oldPanelState = self.panelState
    self.panelState = panelState
  end
  
  function actions:SetSortType(sortType)
    data.sortType = sortType
  end
  
  function actions:SetSchoolFilterShow(show)
    data.showSchollFilter = show
  end
  
  function actions:SetSortTypeShow(show)
    data.showSortType = show
  end
  
  function actions:SetSelectAwakerId(tid)
    if not tid then
      return
    end
    data.selectAwakerId = tid
    if not self:IsOpenBacktrack() and data.page == CommonDefine.AwakerPage.BackTrack then
      self:SetAwakerPage(CommonDefine.AwakerPage.Detail)
    end
  end
  
  function actions:CheckUpdateSelectAwaker()
    if not self.awakerList then
      return
    end
    local includeSelect = false
    for _, awaker in ipairs(self.awakerList) do
      if awaker and awaker.tid == self.selectAwakerId then
        includeSelect = true
        break
      end
    end
    if not includeSelect and #self.awakerList > 0 then
      self:SetSelectAwakerId(self.awakerList[1].tid)
    end
  end
  
  function actions:SetSortOrder(order)
    if order then
      data.sortOrder = order
      return
    end
    local new = CommonDefine.SortOrder.Descend
    if new == data.sortOrder then
      new = CommonDefine.SortOrder.Ascend
    end
    data.sortOrder = new
  end
  
  function actions:SetPlayingTransAnim(isPlaying)
    self.playingTransAnim = isPlaying
  end
  
  function actions:SetAwakerPage(page)
    if not page then
      Logger.Info("Error Parameter: nil")
      return
    end
    if page == data.page then
      return
    end
    data.oldPage = data.page
    data.page = page
  end
  
  function actions:GotoPrePage()
    data.page, data.oldPage = data.oldPage, data.page
  end
  
  function actions:SetHaveJump(val)
    if nil == val then
      Logger.Info("Error Parameter: nil")
      return
    end
    data.haveJump = val
  end
  
  function actions:SetInterest(awakerTid, interest)
    local awaker = data:GetAwakerData(awakerTid)
    if not awaker then
      Logger.Info("找不到唤醒体数据:", tostring(awakerTid))
      return
    end
    awaker.interest = interest
  end
  
  function actions:SetCurAwakerVoice(content, eventName)
    data.curAwakerVoiceContent = content
    data.curAwakerVoiceEventName = eventName
  end
  
  function actions:UpdatePotency(awakerTid, potency)
    if not potency then
      return
    end
    local awaker = data:GetAwakerData(awakerTid)
    if not awaker then
      Logger.Info("找不到唤醒体数据:", tostring(awakerTid))
      return
    end
    awaker.potency = potency
  end
  
  function actions:CalcCurrBreakthroughStarAttrChange(awakerTid, attrModel)
    local awaker = data:GetAwakerData(awakerTid)
    if awaker then
      awaker.currBreakthroughStarAttrChange = {}
      local attrAddList = data:GetAwakerCurrBreakthroughStarAttrAdd(awakerTid)
      for _, attrAdd in ipairs(attrAddList) do
        local currValue
        for _, attr in ipairs(attrModel.baseAttrs) do
          if attr.tid == attrAdd.id then
            currValue = attr.count
            break
          end
        end
        if currValue then
          table.insert(awaker.currBreakthroughStarAttrChange, {
            id = attrAdd.id,
            oldValue = self:_CalcAttrValue(awaker, attrAdd.id, -attrAdd.add),
            newValue = currValue
          })
        else
          local cfg = DT.ActorAttrType[attrAdd.id]
          currValue = awaker.attrs[cfg.Name] or 0
          table.insert(awaker.currBreakthroughStarAttrChange, {
            id = attrAdd.id,
            oldValue = currValue - attrAdd.add,
            newValue = currValue
          })
        end
      end
      table.sort(awaker.currBreakthroughStarAttrChange, function(a, b)
        local aSort = DT.ActorAttrType[a.id].AttributeSort
        local bSort = DT.ActorAttrType[b.id].AttributeSort
        return aSort < bSort
      end)
    end
  end
  
  function actions:CalcNextBreakthroughStarAttrChange(awakerTid, attrModel)
    local awaker = data:GetAwakerData(awakerTid)
    if awaker then
      awaker.nextBreakthroughStarAttrChange = {}
      local attrAddList = data:GetAwakerNextBreakthroughStarAttrAdd(awakerTid)
      for _, attrAdd in ipairs(attrAddList) do
        local currValue
        for _, attr in ipairs(attrModel.baseAttrs) do
          if attr.tid == attrAdd.id then
            currValue = attr.count
            break
          end
        end
        if currValue then
          table.insert(awaker.nextBreakthroughStarAttrChange, {
            id = attrAdd.id,
            oldValue = currValue,
            newValue = self:_CalcAttrValue(awaker, attrAdd.id, attrAdd.add)
          })
        else
          local cfg = DT.ActorAttrType[attrAdd.id]
          currValue = awaker.attrs[cfg.Name] or 0
          table.insert(awaker.nextBreakthroughStarAttrChange, {
            id = attrAdd.id,
            oldValue = currValue,
            newValue = currValue + attrAdd.add
          })
        end
      end
      table.sort(awaker.nextBreakthroughStarAttrChange, function(a, b)
        local aSort = DT.ActorAttrType[a.id].AttributeSort
        local bSort = DT.ActorAttrType[b.id].AttributeSort
        return aSort < bSort
      end)
    end
  end
  
  function actions:_CalcAttrValue(awaker, tid, changeValue)
    local value = 0
    for _, attr in ipairs(awaker.clientAttrs) do
      if attr.tid == tid then
        value = (attr.count or 0) + changeValue
        local cfg = DT.ActorAttrType[attr.tid]
        local attrKey = cfg.Name .. "_per"
        local perVal = awaker.attrs[attrKey]
        if perVal then
          perVal = perVal / 100
          value = AttrUtils.GetAwakerFinalAttr(value, perVal)
        end
        break
      end
    end
    return value
  end
  
  function actions:SetBreakthroughStarPreview(awakerTid, star)
    AwakerDataUtils.SetupBreakthroughPreviewData(awakerTid, star)
  end
  
  function actions:ReqSetBoardAwaker(awakerTid)
    if not awakerTid or type(awakerTid) ~= "number" then
      return
    end
    if not self:HasOwnedAwaker(awakerTid) then
      Logger.Info("未拥有唤醒体, 无法设置为看板娘")
      return
    end
    if DataCenter.playerData.DRole.boardAwaker == awakerTid then
      local awakerName = self:GetAwakerName(awakerTid)
      local desc = DT.TipsType[10610] and LT.Textf(DT.TipsType[10610].Desc, awakerName) or ""
      Alert.Show(10610, nil, nil, nil, desc)
      return
    end
    AwakerDataUtils.SetBoardAwaker(awakerTid)
  end
  
  function actions:ReqBreakthrough(awakerTid, callback)
    if not awakerTid then
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnBreak", function()
      if callback then
        callback()
      end
    end, function(_, code)
      Logger.Error("[突破] 突破失败！错误码: %s", code.code)
    end, awakerTid)
  end
  
  function actions:ReqGainBreakReward(awakerTid, breakLevel, callback)
    if not awakerTid or not breakLevel then
      return
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "GainBreakReward", function()
      AwakerDataUtils.SetBreakthroughRewardReceived(awakerTid, breakLevel)
      if callback then
        callback()
      end
    end, function(_, code)
      Logger.Error("[突破] 领取奖励失败！错误码: %s", code.code)
    end, awakerTid, breakLevel)
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, nVal, oVal)
    if not nVal or 0 == nVal then
      return
    end
    if nVal == oVal then
      return
    end
    model:SetSelectAwaker(nVal)
  end, function()
    return model.selectAwakerId
  end)
  binder:BindToRaw(function(_, n, _)
    if not n or n <= 0 then
      return
    end
    if 0 == model.selectAwakerId then
      local firstAwakerTid = model.awakerList[1].tid
      model:SetSelectAwakerId(firstAwakerTid)
    end
  end, function()
    return #model.awakerList
  end)
end

local AwakerModel = Vue.model("AwakerModel", createAwakerModelState):views(createAwakerModelViews):actions(createAwakerModelActions):setup(onSetup)
return AwakerModel
