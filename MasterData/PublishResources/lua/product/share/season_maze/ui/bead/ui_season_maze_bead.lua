_class("UISeasonMazeBead", UIController)
UISeasonMazeBead = UISeasonMazeBead

function UISeasonMazeBead:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeBead:OnShow(uiParams)
  UnityEngine.Input.multiTouchEnabled = false
  self._atlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._curMode = nil
  self._itemWidgets = {}
  self._synthesisList = {}
  self._data = {}
  self._tempClearUIDs = {}
  self._pageCount = 20
  self._curPageIndex = 1
  self._sortTypekey = "UISeasonMazeBeadSortType" .. GameGlobal.GetModule(LoginModule):GetRoleShowID()
  self._sortOrderkey = "UISeasonMazeBeadSortOrder" .. GameGlobal.GetModule(LoginModule):GetRoleShowID()
  self._synthesisNoticeKey = "UISeasonMazeBeadSynthesis" .. GameGlobal.GetModule(LoginModule):GetRoleShowID()
  self._recordSortType = LocalDB.GetInt(self._sortTypekey, SeasonMazeBeadSortType.Quality)
  self._recordSortOrder = LocalDB.GetInt(self._sortOrderkey, SeasonMazeBeadSortOrder.Descending)
  self:_InitWidget()
  self:_OnValue()
end

function UISeasonMazeBead:_InitWidget()
  self._gameObject = self:GetGameObject()
  self._rectTransform = self:GetUIComponent("RectTransform", "Center")
  self._equipArea = self:GetUIComponent("UISelectObjectPath", "EquipArea")
  self._energyValue = self:GetUIComponent("UILocalizationText", "EnergyValue")
  self._modeCanvasGroup = {}
  self._modeCanvasGroup[SeasonMazeBeadUIMode.Equip] = self:GetUIComponent("CanvasGroup", "EquipNode")
  self._modeCanvasGroup[SeasonMazeBeadUIMode.Synthesis] = self:GetUIComponent("CanvasGroup", "SynthesisNode")
  self._modeBtnImgs = {}
  self._modeBtnImgs[SeasonMazeBeadUIMode.Equip] = self:GetUIComponent("Image", "EquipBtn")
  self._modeBtnImgs[SeasonMazeBeadUIMode.Synthesis] = self:GetUIComponent("Image", "SynthesisBtn")
  self._modeBtnText = {}
  self._modeBtnText[SeasonMazeBeadUIMode.Equip] = self:GetUIComponent("UILocalizationText", "EquipBtnText")
  self._modeBtnText[SeasonMazeBeadUIMode.Synthesis] = self:GetUIComponent("UILocalizationText", "SynthesisBtnText")
  self._sortBtnText = {}
  self._sortBtnText[SeasonMazeBeadSortType.Type] = self:GetUIComponent("UILocalizationText", "TypeBtnText")
  self._sortBtnText[SeasonMazeBeadSortType.Quality] = self:GetUIComponent("UILocalizationText", "QualityBtnText")
  self._qualitySortImg = {}
  self._qualitySortImg[SeasonMazeBeadSortOrder.Ascending] = self:GetUIComponent("Image", "Up")
  self._qualitySortImg[SeasonMazeBeadSortOrder.Descending] = self:GetUIComponent("Image", "Down")
  self._templateGO = self:GetGameObject("DragTemplate")
  self._templateTransform = self._templateGO.transform
  self._template = self:GetUIComponent("UISelectObjectPath", "DragTemplate")
  self._templateWidget = self._template:SpawnObject("UISeasonMazeBeadItem")
  self._templateGO:SetActive(false)
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISeasonMazeBeadTips")
  self._synthesisNode = {}
  self._synthesisNode[1] = self:GetUIComponent("UISelectObjectPath", "B1")
  self._synthesisNode[2] = self:GetUIComponent("UISelectObjectPath", "B2")
  self._synthesisNode[3] = self:GetUIComponent("UISelectObjectPath", "B3")
  self._beads = self:GetUIComponent("UISelectObjectPath", "Beads")
  self._turnText = self:GetUIComponent("UILocalizationText", "Turn")
  self._turnImg = {}
  self._turnImg[1] = self:GetUIComponent("Image", "TurnLeftBtn")
  self._turnImg[2] = self:GetUIComponent("Image", "TurnRightBtn")
  self._animation = self._gameObject:GetComponent(typeof(UnityEngine.Animation))
  self._commonItemTips = self:GetUIComponent("UISelectObjectPath", "CommonItemTips")
  self._commonTips = self._commonItemTips:SpawnObject("UISelectInfo")
end

function UISeasonMazeBead:_OnValue()
  self:_InitAllBeadWidgets()
  self:_InitEquipSlot()
  self:_InitSynthesisSlot()
  self:_SwitchMode(SeasonMazeBeadUIMode.Equip)
  self:_Sort(self._recordSortType, nil, true)
  self:_RefreshEnergyValue()
  self:_TagCheck()
end

function UISeasonMazeBead:_InitEquipSlot()
  if self._componentInfo.m_auto_bead_fit_list then
    local slotCount = #self._componentInfo.m_auto_bead_fit_list
    if 0 < slotCount then
      self._equipArea:SpawnObjects("UISeasonMazeBeadItem", slotCount)
      self._equipSlotWidgets = self._equipArea:GetAllSpawnList()
      for key, value in pairs(self._equipSlotWidgets) do
        value:SetData(key, self:GetBeadInfo(self._componentInfo.m_auto_bead_fit_list[key]), function(uid, id, position)
          self:ShowTips(uid, id, position, SeasonMazeBeadTipsBtnType.Demount, function(uid)
            self:_UnEquipBead(uid)
          end)
        end, SeasonMazeBeadItemType.EquipSlot)
      end
    end
  end
end

function UISeasonMazeBead:_RefreshEquipSlot()
  for key, value in ipairs(self._equipSlotWidgets) do
    value:SetData(key, self:GetBeadInfo(self._componentInfo.m_auto_bead_fit_list[key]), function(uid, id, position)
      self:ShowTips(uid, id, position, SeasonMazeBeadTipsBtnType.Demount, function(uid)
        self:_UnEquipBead(uid)
      end)
    end, SeasonMazeBeadItemType.EquipSlot)
  end
  self:_TagCheck()
end

function UISeasonMazeBead:_InitSynthesisSlot()
  self._synthesisSlotWidgets = {}
  for index, value in ipairs(self._synthesisNode) do
    self._synthesisSlotWidgets[index] = value:SpawnObject("UISeasonMazeBeadItem")
    self._synthesisSlotWidgets[index]:SetData(index, nil, function(uid, id, position)
      self:ShowTips(uid, id, position, SeasonMazeBeadTipsBtnType.RemoveSynthesis, function(uid)
        self:_UnSynthesisBead(uid)
      end)
    end, SeasonMazeBeadItemType.SynthesisSlot)
  end
end

function UISeasonMazeBead:_RefreshSynthesisSlot()
  local function GetBeadData(index)
    if self._synthesisList[1] then
      local uid = self._synthesisList[1][index]
      
      local beadData = self:_GetBeadDataByUID(uid)
      return beadData and beadData.data
    end
  end
  
  for index, value in ipairs(self._synthesisSlotWidgets) do
    if index <= 2 then
      value:SetData(index, GetBeadData(index), function(uid, id, position)
        self:ShowTips(uid, id, position, SeasonMazeBeadTipsBtnType.RemoveSynthesis, function(uid)
          self:_UnSynthesisBead(uid)
        end)
      end, SeasonMazeBeadItemType.SynthesisSlot)
    end
  end
end

function UISeasonMazeBead:_RefreshEnergyValue()
  local value1 = self._component:GetAttrValue(SeasonMazeAttrType.SMAT_AutoBeadEnergy)
  local value2 = 0
  for _, _uid in pairs(self._componentInfo.m_auto_bead_fit_list) do
    local data = self:GetBeadInfo(_uid)
    if data then
      local cfg = Cfg.cfg_component_season_maze_autobead[data.bead_info.cfg_id]
      if cfg then
        value2 = value2 + cfg.Energy
        if data.incr_value[ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Energy] then
          value2 = value2 + data.incr_value[ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Energy]
        end
      end
    end
  end
  value1 = math.min(value1, value2)
  local percent = "0%%"
  if 0 < value2 then
    local x, y = math.modf(math.floor(value1 / value2 * 100))
    percent = x .. "%%"
  end
  percent = string.format("<color=#56c49b>%s</color>", percent)
  self._energyValue:SetText(StringTable.Get("str_season_maze_bead_equip_desc", value1 .. "/" .. value2 .. "(" .. percent .. ")"))
end

function UISeasonMazeBead:ClearSynthesisSlot()
  for key, value in pairs(self._synthesisSlotWidgets) do
    value:SetData(key, nil, nil, SeasonMazeBeadItemType.SynthesisSlot)
  end
  table.clear(self._synthesisList)
end

function UISeasonMazeBead:RefreshAllShownItem()
  self:RefreshAllBeadWidgets(true)
end

function UISeasonMazeBead:GetBeadInfo(uid)
  if uid <= 0 then
    return nil
  end
  if self._componentInfo.m_auto_bead_map then
    for _, value in pairs(self._componentInfo.m_auto_bead_map) do
      if value.bead_info and value.bead_info.unique_id == uid then
        return value
      end
    end
  end
  return nil
end

function UISeasonMazeBead:_InitAllBeadWidgets()
  self._beads:SpawnObjects("UISeasonMazeBeadItem", self._pageCount)
  self._itemWidgets = self._beads:GetAllSpawnList()
  for _, widget in ipairs(self._itemWidgets) do
    widget:SetScale(0.6)
  end
end

function UISeasonMazeBead:_BeadDataTrim()
  table.clear(self._data)
  for key, value in pairs(self._componentInfo.m_auto_bead_map) do
    local beadData = SeasonMazeBeadData:New(key, value)
    if self._curMode == SeasonMazeBeadUIMode.Synthesis then
      if not beadData:IsMax() then
        table.insert(self._data, beadData)
      end
    elseif not self:InSlot(beadData.data.bead_info.unique_id) then
      table.insert(self._data, beadData)
    end
  end
end

function UISeasonMazeBead:_GetBeadData(index)
  return self._data[index] and self._data[index].data
end

function UISeasonMazeBead:_GetBeadDataByUID(uid)
  for index, value in ipairs(self._data) do
    if value.data.bead_info.unique_id == uid then
      return value
    end
  end
  return nil
end

function UISeasonMazeBead:_Pair(uid, level, kind, checkFunc)
  if 4 <= level then
    return nil
  end
  for _, _uid in pairs(self._componentInfo.m_auto_bead_fit_list) do
    if 0 < _uid and _uid ~= uid and checkFunc(_uid) then
      local temp = self:_GetBeadDataByUID(_uid)
      if temp and temp.level == level then
        if kind ~= nil then
          if temp.kind == kind then
            return temp
          end
        else
          return temp
        end
      end
    end
  end
  for _, value in pairs(self._data) do
    if value.data.bead_info.unique_id ~= uid and checkFunc(value.data.bead_info.unique_id) then
      local temp = self:_GetBeadDataByUID(value.data.bead_info.unique_id)
      if temp and temp.level == level then
        if kind ~= nil then
          if temp.kind == kind then
            return temp
          end
        else
          return temp
        end
      end
    end
  end
  return nil
end

function UISeasonMazeBead:EquipRealBtnOnClick(go)
  if self._curMode == SeasonMazeBeadUIMode.Equip then
    return
  end
  self:Lock("UISeasonMazeBeadEquipBtnOnClick")
  self:StartTask(function(TT)
    self._animation:Play("uianim_UISeasonMazeBead_handoff_out")
    YIELD(TT, 333)
    self:_SwitchMode(SeasonMazeBeadUIMode.Equip)
    self:_UnLockBeads()
    self:UnLock("UISeasonMazeBeadEquipBtnOnClick")
  end)
end

function UISeasonMazeBead:SynthesisRealBtnOnClick(go)
  if self._curMode == SeasonMazeBeadUIMode.Synthesis then
    return
  end
  self:Lock("UISeasonMazeBeadSynthesisBtnOnClick")
  self:StartTask(function(TT)
    self._animation:Play("uianim_UISeasonMazeBead_handoff_in")
    YIELD(TT, 333)
    self:ClearSynthesisSlot()
    self:_SwitchMode(SeasonMazeBeadUIMode.Synthesis)
    self:_UnLockBeads()
    self:UnLock("UISeasonMazeBeadSynthesisBtnOnClick")
  end)
end

function UISeasonMazeBead:SynthesisOnceBtnOnClick(go)
  if self._synthesisList[1] then
    local beadData1 = self:_GetBeadDataByUID(self._synthesisList[1][1])
    local beadData2 = self:_GetBeadDataByUID(self._synthesisList[1][2])
    if beadData1 and beadData2 and beadData1.type ~= beadData2.type then
      local record = LocalDB.GetInt(self._synthesisNoticeKey, 0)
      if record <= 0 then
        LocalDB.SetInt(self._synthesisNoticeKey, 1)
        UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_synthesis_tips_title"), StringTable.Get("str_season_maze_synthesis_error2"), SeasonMazeMsgBoxType.OkCancel, function()
          self:SynthesisBead()
        end)
        return
      end
    end
  end
  self:SynthesisBead()
end

function UISeasonMazeBead:SynthesisAllBtnOnClick(go)
  local list = self:_BeadPair()
  if table.count(list) > 0 then
    table.clear(self._synthesisList)
    self:ShowDialog("UISeasonMazeBeadAutoSyn", self, list)
  else
    ToastManager.ShowToast(StringTable.Get("str_season_maze_synthesis_error1"))
  end
end

function UISeasonMazeBead:_BeadPair()
  local list = {}
  
  local function IsVaildID(uid)
    if uid <= 0 then
      return false
    end
    for _, value in ipairs(list) do
      if uid == value.uid1 or uid == value.uid2 then
        return false
      end
    end
    return true
  end
  
  local function CreatePair(uid1, uid2, data1, data2)
    table.insert(list, SeasonMazeBeadPair:New(uid1, uid2, data1, data2))
  end
  
  if self._componentInfo.m_auto_bead_fit_list then
    for _, uid in pairs(self._componentInfo.m_auto_bead_fit_list) do
      if IsVaildID(uid) then
        local data = self:_GetBeadDataByUID(uid)
        if data then
          local pairBead = self:_Pair(uid, data.level, data.kind, function(uid)
            return IsVaildID(uid) and not self:InSlot(uid)
          end)
          if pairBead then
            CreatePair(uid, pairBead.data.bead_info.unique_id, data.data, pairBead.data)
          end
        end
      end
    end
  end
  for key, value in pairs(self._data) do
    local uid = value.data.bead_info.unique_id
    if IsVaildID(uid) then
      local data = self:_GetBeadDataByUID(uid)
      if data then
        local pairBead = self:_Pair(uid, data.level, data.kind, function(uid)
          return IsVaildID(uid)
        end)
        if pairBead then
          CreatePair(uid, pairBead.data.bead_info.unique_id, data.data, pairBead.data)
        end
      end
    end
  end
  for key, value in pairs(self._data) do
    local uid = value.data.bead_info.unique_id
    if IsVaildID(uid) and not self:InSlot(uid) then
      local data = self:_GetBeadDataByUID(uid)
      if data then
        local pairBead = self:_Pair(uid, data.level, nil, function(uid)
          return IsVaildID(uid)
        end)
        if pairBead then
          CreatePair(uid, pairBead.data.bead_info.unique_id, data.data, pairBead.data)
        end
      end
    end
  end
  for key, value in pairs(self._data) do
    local uid = value.data.bead_info.unique_id
    if IsVaildID(uid) then
      local data = self:_GetBeadDataByUID(uid)
      if data then
        local pairBead = self:_Pair(uid, data.level, nil, function(uid)
          return IsVaildID(uid)
        end)
        if pairBead then
          CreatePair(uid, pairBead.data.bead_info.unique_id, data.data, pairBead.data)
        end
      end
    end
  end
  return list
end

function UISeasonMazeBead:QualityBtnOnClick(go)
  self:_Sort(SeasonMazeBeadSortType.Quality, true)
  self:RefreshAllBeadWidgets(true)
  self:_TryLockBead()
end

function UISeasonMazeBead:TypeBtnOnClick(go)
  self:_Sort(SeasonMazeBeadSortType.Type, true)
  self:RefreshAllBeadWidgets(true)
  self:_TryLockBead()
end

function UISeasonMazeBead:TurnLeftBtnOnClick(go)
  local count = table.count(self._data)
  local totalPageCount = math.ceil(count / self._pageCount)
  if self._curPageIndex > 1 then
    self._curPageIndex = self._curPageIndex - 1
  end
  self._turnText:SetText(self._curPageIndex .. "/" .. totalPageCount)
  self:_RefreshTurnImg(self._curPageIndex, totalPageCount)
  self:RefreshAllBeadWidgets(true)
end

function UISeasonMazeBead:TurnRightBtnOnClick(go)
  local count = table.count(self._data)
  local totalPageCount = math.ceil(count / self._pageCount)
  if totalPageCount > self._curPageIndex then
    self._curPageIndex = self._curPageIndex + 1
  end
  self._turnText:SetText(self._curPageIndex .. "/" .. totalPageCount)
  self:_RefreshTurnImg(self._curPageIndex, totalPageCount)
  self:RefreshAllBeadWidgets(true)
end

function UISeasonMazeBead:_RefreshTurnImg(curIndex, totalIndex)
  if curIndex < totalIndex then
    self._turnImg[2].sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di09")
  else
    self._turnImg[2].sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di08")
  end
  if curIndex <= 1 then
    self._turnImg[1].sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di08")
  else
    self._turnImg[1].sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di09")
  end
end

function UISeasonMazeBead:RefreshAllBeadWidgets(playAnimation)
  local btnType = SeasonMazeBeadTipsBtnType.None
  if self._curMode == SeasonMazeBeadUIMode.Equip then
    btnType = SeasonMazeBeadTipsBtnType.Equiped
  elseif self._curMode == SeasonMazeBeadUIMode.Synthesis then
    btnType = SeasonMazeBeadTipsBtnType.AddSynthesis
  end
  for index, widget in ipairs(self._itemWidgets) do
    local data = self:_GetBeadData(index + (self._curPageIndex - 1) * self._pageCount)
    widget:SetData(index, data, function(uid, id, position)
      self:ShowTips(uid, id, position, btnType, function(uid)
        if self._curMode == SeasonMazeBeadUIMode.Equip then
          self:_AddBeadToEquipSlot(uid)
        elseif self._curMode == SeasonMazeBeadUIMode.Synthesis then
          self:_AddBeadToSynthesisSlot(uid)
        end
      end)
    end)
  end
  self:_PlayAnimation(playAnimation)
end

function UISeasonMazeBead:_PlayAnimation(play)
  if not play then
    return
  end
  local row1 = {}
  local row2 = {}
  for index, widget in ipairs(self._itemWidgets) do
    local data = self:_GetBeadData(index + (self._curPageIndex - 1) * self._pageCount)
    if data then
      if index <= self._pageCount / 2 then
        table.insert(row1, widget)
      else
        table.insert(row2, widget)
      end
      widget:Alpha(0)
    end
  end
  if 0 < #row1 then
    self:Lock("UISeasonMazeBeadPlayAnimation")
    self:StartTask(function(TT)
      for _, rw1 in ipairs(row1) do
        rw1:PlayAnimation()
      end
      if 0 < #row2 then
        YIELD(TT, 70)
        for _, rw2 in ipairs(row2) do
          rw2:PlayAnimation()
        end
        YIELD(TT, 400)
      end
      self:UnLock("UISeasonMazeBeadPlayAnimation")
    end)
  end
end

function UISeasonMazeBead:_AddBeadToEquipSlot(uid)
  local emptySlotIndex = 0
  if self._componentInfo.m_auto_bead_fit_list then
    for index, _uid in ipairs(self._componentInfo.m_auto_bead_fit_list) do
      if _uid == 0 then
        emptySlotIndex = index
        break
      end
    end
  end
  if emptySlotIndex <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_bead_equiped_error"))
  else
    self:_EquipBead(emptySlotIndex, uid)
  end
end

function UISeasonMazeBead:_AddBeadToSynthesisSlot(uid)
  local emptySlotIndex = 0
  if not self._synthesisList[1] then
    self._synthesisList[1] = {0, 0}
  end
  for index, _uid in ipairs(self._synthesisList[1]) do
    if _uid == 0 then
      emptySlotIndex = index
      break
    end
  end
  if emptySlotIndex <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_bead_addsynthesis_error"))
  else
    self:_TryAddSynthesisBead(false, emptySlotIndex, uid)
  end
end

function UISeasonMazeBead:_TryLockBead()
  if self._curMode == SeasonMazeBeadUIMode.Synthesis then
    if self._synthesisList[1] then
      for _, uid in ipairs(self._synthesisList[1]) do
        local data = self:_GetBeadDataByUID(uid)
        if data then
          self:_LockBeads(data.level)
          break
        end
      end
    end
  else
    self:_UnLockBeads()
  end
end

function UISeasonMazeBead:CloseBtnOnClick(go)
  self:Lock("UISeasonMazeBeadClearNew")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._component:HandleSeasonMazeClearAllBeadNew(TT, res)
    self._animation:Play("uianim_UISeasonMazeBead_out")
    YIELD(TT, 267)
    self:CloseDialog()
    UnityEngine.Input.multiTouchEnabled = true
    self:UnLock("UISeasonMazeBeadClearNew")
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end)
end

function UISeasonMazeBead:_SwitchMode(mode, needSort)
  self._curMode = mode
  for _mode, img in pairs(self._modeBtnImgs) do
    if _mode == mode then
      self._modeBtnText[_mode].color = Color(1, 1, 1)
      self._modeCanvasGroup[_mode].alpha = 1
      self._modeCanvasGroup[_mode].interactable = true
      self._modeCanvasGroup[_mode].blocksRaycasts = true
    else
      self._modeBtnText[_mode].color = Color(0.22745098039215686, 0.22745098039215686, 0.22745098039215686)
      self._modeCanvasGroup[_mode].alpha = 0
      self._modeCanvasGroup[_mode].interactable = false
      self._modeCanvasGroup[_mode].blocksRaycasts = false
    end
  end
  self:_BeadDataTrim()
  self:_SortByRecord()
  self._curPageIndex = 1
  self:TurnLeftBtnOnClick()
end

function UISeasonMazeBead:_SortByRecord()
  if self._recordSortType then
    if self._recordSortType == SeasonMazeBeadSortType.Type then
      table.sort(self._data, function(a, b)
        return a.type > b.type
      end)
    elseif self._recordSortType == SeasonMazeBeadSortType.Quality then
      if self._recordSortOrder == SeasonMazeBeadSortOrder.Descending then
        table.sort(self._data, function(a, b)
          return a.quality > b.quality
        end)
      elseif self._recordSortOrder == SeasonMazeBeadSortOrder.Ascending then
        table.sort(self._data, function(a, b)
          return a.quality < b.quality
        end)
      end
    end
    LocalDB.SetInt(self._sortTypekey, self._recordSortType)
    LocalDB.SetInt(self._sortOrderkey, self._recordSortOrder)
  else
    Log.error("UISeasonMazeBead sort record type is nil.")
  end
end

function UISeasonMazeBead:_Sort(sortType, isSortData, isInit)
  if self._recordSortType == SeasonMazeBeadSortType.Type and sortType == SeasonMazeBeadSortType.Type then
    return
  end
  if sortType == SeasonMazeBeadSortType.Quality then
    if self._recordSortType == SeasonMazeBeadSortType.Quality and not isInit then
      if self._recordSortOrder == SeasonMazeBeadSortOrder.Descending then
        self._recordSortOrder = SeasonMazeBeadSortOrder.Ascending
      elseif self._recordSortOrder == SeasonMazeBeadSortOrder.Ascending then
        self._recordSortOrder = SeasonMazeBeadSortOrder.Descending
      end
    end
    for sortType, img in pairs(self._qualitySortImg) do
      if sortType == self._recordSortOrder then
        img.sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di09")
      else
        img.sprite = self._atlas:GetSprite("cn14_sjmj_xdjmk_di08")
      end
    end
  end
  self._recordSortType = sortType
  for _type, text in pairs(self._sortBtnText) do
    if _type == sortType then
      text.color = Color(1, 1, 1)
    else
      text.color = Color(0.22745098039215686, 0.22745098039215686, 0.22745098039215686)
    end
  end
  if isSortData then
    self:_SortByRecord()
  end
end

function UISeasonMazeBead:OnBeginDrag(eventData, widget)
  self._curDragBeadWidget = widget
  self._templateWidget:SetData(widget:Index(), widget:Data(), nil, SeasonMazeBeadItemType.Template)
  self._templateTransform.position = widget:Transform().position
  self:_ClearNewByUID(widget:Data().bead_info.unique_id)
  self._dragSuccSlot = 0
end

function UISeasonMazeBead:OnDrag(eventData)
  if not self._templateGO.activeSelf then
    self._templateGO:SetActive(true)
  end
  local position = self:ScreenPointToLocalPointInRectangle(self._rectTransform, eventData)
  self._templateTransform.localPosition = Vector3(position.x, position.y, 0)
  self._dragSuccSlot = self:_OnDragCheck(self._templateTransform)
end

function UISeasonMazeBead:ScreenPointToLocalPointInRectangle(rect, eventData)
  local res, position = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, eventData.position, eventData.pressEventCamera, nil)
  return position
end

function UISeasonMazeBead:OnDragEnd(eventData)
  if self._dragSuccSlot > 0 then
    self:_OnDragSucc()
  else
    self:_OnDragFail()
  end
  self._templateGO:SetActive(false)
  self._curDragBeadWidget = nil
end

function UISeasonMazeBead:_OnDragSucc()
  if self._curMode == SeasonMazeBeadUIMode.Equip then
    self:_EquipBead(self._dragSuccSlot, self._templateWidget:Data().bead_info.unique_id)
  elseif self._curMode == SeasonMazeBeadUIMode.Synthesis then
    local isDragSlot, index = self:_IsDragSlot(self._curDragBeadWidget)
    self:_TryAddSynthesisBead(isDragSlot, self._dragSuccSlot, self._templateWidget:Data().bead_info.unique_id)
  end
end

function UISeasonMazeBead:_OnDragFail()
  if not self._templateGO.activeSelf then
    return
  end
  local isDragSlot = self:_IsDragSlot(self._curDragBeadWidget)
  if not isDragSlot then
    return
  end
  local data = self._templateWidget:Data()
  if data then
    if self._curMode == SeasonMazeBeadUIMode.Equip then
      self:_UnEquipBead(data.bead_info.unique_id)
    elseif self._curMode == SeasonMazeBeadUIMode.Synthesis then
      self:_UnSynthesisBead(data.bead_info.unique_id)
    end
  end
end

function UISeasonMazeBead:_IsDragSlot(widget)
  if widget then
    for key, value in ipairs(self._equipSlotWidgets) do
      if widget == value then
        return true, key
      end
    end
    for key, value in ipairs(self._synthesisSlotWidgets) do
      if widget == value then
        return true, key
      end
    end
  end
  return false, nil
end

function UISeasonMazeBead:_EquipBead(slotIndex, uid)
  self:Lock("UISeasonMazeBead:_EquipBead")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local list = table.clone(self._componentInfo.m_auto_bead_fit_list)
    local originalSlotIndex = self:_GetSlotIndexByUID(uid)
    if originalSlotIndex then
      if 0 < list[slotIndex] then
        list[originalSlotIndex] = list[slotIndex]
      else
        list[originalSlotIndex] = 0
      end
    end
    list[slotIndex] = uid
    local result = self._component:HandleSeasonMazeFitAutoBead(TT, res, list)
    if not res:GetSucc() then
      Log.error("UISeasonMazeBead Equipt Fail.", self._dragSuccSlot)
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
      return
    end
    self:_BeadDataTrim()
    self:_SortByRecord()
    self:_RefreshEquipSlot()
    self:_RefreshEnergyValue()
    self:RefreshAllBeadWidgets(false)
    self:UnLock("UISeasonMazeBead:_EquipBead")
  end, self)
end

function UISeasonMazeBead:_UnEquipBead(uid)
  self:Lock("UISeasonMazeBead:_UnEquipBead")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local list = {}
    for _slotIndex, _uid in ipairs(self._componentInfo.m_auto_bead_fit_list) do
      list[_slotIndex] = _uid
      if _uid == uid then
        list[_slotIndex] = 0
      end
    end
    local result = self._component:HandleSeasonMazeFitAutoBead(TT, res, list)
    if not res:GetSucc() then
      Log.error("UISeasonMazeBead UnEquipt Fail.", uid)
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
    end
    self:_BeadDataTrim()
    self:_SortByRecord()
    self:_RefreshEquipSlot()
    self:_RefreshEnergyValue()
    self:RefreshAllBeadWidgets(false)
    self:UnLock("UISeasonMazeBead:_UnEquipBead")
  end, self)
end

function UISeasonMazeBead:_UnSynthesisBead(uid)
  if self._synthesisList[1] then
    for index, _uid in ipairs(self._synthesisList[1]) do
      if _uid == uid then
        self._synthesisList[1][index] = 0
        break
      end
    end
  end
  self:_RefreshSynthesisSlot()
  self:RefreshAllBeadWidgets(false)
  self:SynthesisPreView(self._synthesisSlotWidgets[3], SeasonMazeBeadData:New(nil, self._synthesisSlotWidgets[1]:Data()), SeasonMazeBeadData:New(nil, self._synthesisSlotWidgets[2]:Data()), SeasonMazeBeadItemType.SynthesisSlot)
end

function UISeasonMazeBead:OnReleased()
end

function UISeasonMazeBead:ShowTips(uid, id, position, btnType, callBack)
  local realBtnType = btnType
  if self._curMode == SeasonMazeBeadUIMode.Equip then
    if self._componentInfo.m_auto_bead_fit_list then
      for _, _uid in ipairs(self._componentInfo.m_auto_bead_fit_list) do
        if _uid == uid then
          if btnType == SeasonMazeBeadTipsBtnType.Equiped then
            realBtnType = SeasonMazeBeadTipsBtnType.None
          end
          break
        end
      end
    end
  elseif self._curMode == SeasonMazeBeadUIMode.Synthesis then
    if self._synthesisList[1] then
      for _, _uid in ipairs(self._synthesisList[1]) do
        if _uid == uid then
          if btnType == SeasonMazeBeadTipsBtnType.AddSynthesis then
            realBtnType = SeasonMazeBeadTipsBtnType.None
          end
          break
        end
      end
    end
    if self._synthesisList[1] then
      local level = 0
      for _, _uid in ipairs(self._synthesisList[1]) do
        local slotBeadData = self:_GetBeadDataByUID(_uid)
        if slotBeadData then
          level = slotBeadData.level
          break
        end
      end
      if 0 < level then
        local beadData = self:_GetBeadDataByUID(uid)
        if beadData and beadData.level ~= level and btnType == SeasonMazeBeadTipsBtnType.AddSynthesis then
          realBtnType = SeasonMazeBeadTipsBtnType.None
        end
      end
    end
  end
  self._tips:SetData(uid, id, position, realBtnType, callBack)
  self:_ClearNewByUID(uid)
end

function UISeasonMazeBead:CanDrag(uid, itemType)
  if self._curMode == SeasonMazeBeadUIMode.Equip and itemType and itemType == SeasonMazeBeadItemType.Normal then
    return not self:InSlot(uid)
  end
  return true
end

function UISeasonMazeBead:InSlot(uid)
  if uid <= 0 then
    return false
  end
  if self._componentInfo and self._componentInfo.m_auto_bead_fit_list then
    for _, _uid in pairs(self._componentInfo.m_auto_bead_fit_list) do
      if _uid == uid then
        return true
      end
    end
  end
  return false
end

function UISeasonMazeBead:_OnDragCheck(transform)
  local precision = 0.09
  if self._curMode == SeasonMazeBeadUIMode.Equip then
    if self._equipSlotWidgets then
      for key, value in pairs(self._equipSlotWidgets) do
        local distance = Vector3.Distance(value:Transform().position, transform.position)
        if precision >= distance then
          return key
        end
      end
    end
  elseif self._curMode == SeasonMazeBeadUIMode.Synthesis and self._synthesisSlotWidgets then
    for key, value in pairs(self._synthesisSlotWidgets) do
      if key < #self._synthesisSlotWidgets then
        local distance = Vector3.Distance(value:Transform().position, transform.position)
        if precision >= distance then
          return key
        end
      end
    end
  end
  return 0
end

function UISeasonMazeBead:_TryAddSynthesisBead(isDragSlot, slotIndex, uid)
  local isEquiped = false
  if self._componentInfo.m_auto_bead_fit_list then
    for _, _uid in ipairs(self._componentInfo.m_auto_bead_fit_list) do
      if uid == _uid then
        isEquiped = true
        break
      end
    end
  end
  if isEquiped and not isDragSlot then
    UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_synthesis_tips_title"), StringTable.Get("str_season_maze_synthesis_tips_desc"), SeasonMazeMsgBoxType.OkCancel, function()
      self:_AddSynthesisBead(isDragSlot, slotIndex, uid)
    end)
  else
    self:_AddSynthesisBead(isDragSlot, slotIndex, uid)
  end
end

function UISeasonMazeBead:_AddSynthesisBead(isDragSlot, slotIndex, uid)
  if not self._synthesisList[1] then
    self._synthesisList[1] = {0, 0}
  end
  if isDragSlot then
    local uid1 = self._synthesisList[1][1]
    local uid2 = self._synthesisList[1][2]
    if self._synthesisList[1][slotIndex] ~= uid then
      self._synthesisList[1][1] = uid2
      self._synthesisList[1][2] = uid1
    end
  else
    for index, _uid in ipairs(self._synthesisList[1]) do
      if _uid == uid then
        self._synthesisList[1][index] = 0
      end
    end
  end
  self._synthesisList[1][slotIndex] = uid
  self:_RefreshSynthesisSlot()
  self:RefreshAllBeadWidgets(false)
  self:SynthesisPreView(self._synthesisSlotWidgets[3], SeasonMazeBeadData:New(nil, self._synthesisSlotWidgets[1]:Data()), SeasonMazeBeadData:New(nil, self._synthesisSlotWidgets[2]:Data()), SeasonMazeBeadItemType.SynthesisSlot)
end

function UISeasonMazeBead:_LockBeads(level)
  for key, value in pairs(self._itemWidgets) do
    value:Lock(value:Level() ~= level)
  end
end

function UISeasonMazeBead:_SynthesisMark()
  if self._curMode == SeasonMazeBeadUIMode.Equip then
    for key, value in pairs(self._itemWidgets) do
      value:Mark(false)
    end
  elseif self._curMode == SeasonMazeBeadUIMode.Synthesis then
    for key, value in pairs(self._itemWidgets) do
      local data = value:Data()
      if data then
        local uid = data.bead_info.unique_id
        if self._synthesisList[1] and table.icontains(self._synthesisList[1], uid) then
          value:Mark(true)
        else
          value:Mark(false)
        end
      else
        value:Mark(false)
      end
    end
  end
end

function UISeasonMazeBead:IsLock(data, itemType)
  if itemType ~= SeasonMazeBeadItemType.Normal then
    return false
  end
  if self._curMode == SeasonMazeBeadUIMode.Synthesis and data then
    local uid = data.bead_info.unique_id
    local beadData = self:_GetBeadDataByUID(uid)
    if beadData and self._synthesisList[1] then
      for _, _uid in ipairs(self._synthesisList[1]) do
        local slotBeadData = self:_GetBeadDataByUID(_uid)
        if slotBeadData and beadData.level ~= slotBeadData.level then
          return true
        end
      end
    end
  end
  return false
end

function UISeasonMazeBead:IsMark(data, itemType)
  if itemType ~= SeasonMazeBeadItemType.Normal then
    return false
  end
  if self._curMode == SeasonMazeBeadUIMode.Synthesis and data then
    local uid = data.bead_info.unique_id
    if self._synthesisList[1] then
      for _, _uid in ipairs(self._synthesisList[1]) do
        if uid == _uid then
          return true
        end
      end
    end
  end
  return false
end

function UISeasonMazeBead:_UnLockBeads()
  for key, value in pairs(self._itemWidgets) do
    value:Lock(false)
  end
end

function UISeasonMazeBead:SynthesisBead(callBack)
  if table.count(self._synthesisList) <= 0 then
    if callBack then
      callBack()
    end
    ToastManager.ShowToast(StringTable.Get("str_season_maze_synthesis_error"))
    return
  end
  for _, value in ipairs(self._synthesisList) do
    if value and (value[1] == 0 or value[2] == 0) then
      if callBack then
        callBack()
      end
      ToastManager.ShowToast(StringTable.Get("str_season_maze_synthesis_error"))
      return
    end
  end
  self:Lock("UISeasonMazeBead:SynthesisBead")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local uids = self._component:HandleSeasonMazeAutoBeadCompose(TT, res, self._synthesisList)
    if not res:GetSucc() then
      Log.error("UISeasonMazeBead Synthesis Fail.")
      self:UnLock("UISeasonMazeBead:SynthesisBead")
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
      return
    end
    self:_BeadDataTrim()
    self:_SortByRecord()
    self:ClearSynthesisSlot()
    self._curPageIndex = 1
    self:TurnLeftBtnOnClick()
    self:_UnLockBeads()
    self:_RefreshEquipSlot()
    self:_RefreshEnergyValue()
    self:ShowDialog("UISeasonMazeBeadRewards", self:_UID2CfgID(uids), function()
      if callBack then
        callBack()
      end
    end)
    self:_SynthesisMark()
    self:UnLock("UISeasonMazeBead:SynthesisBead")
  end, self)
end

function UISeasonMazeBead:_UID2CfgID(uids)
  local ids = {}
  if uids then
    for _, uid in ipairs(uids) do
      local beadInfo = self:GetBeadInfo(uid)
      if beadInfo then
        table.insert(ids, beadInfo.bead_info.cfg_id)
      end
    end
  end
  return ids
end

function UISeasonMazeBead:UID2Rewards(uids)
  local rewards = {}
  if uids then
    for _, uid in ipairs(uids) do
      local data = SeasonMazeEffect:New()
      data.type = SeasonMazeEffectType.SMET_Bead
      local beadData = self:GetBeadInfo(uid)
      if beadData then
        data.id = beadData.bead_info.cfg_id
      else
        data.id = 0
      end
      data.value_min = 1
      data.value_max = 1
      table.insert(rewards, data)
    end
  end
  return rewards
end

function UISeasonMazeBead:OnChoiceChange(data)
  table.clear(self._synthesisList)
  for _, value in ipairs(data) do
    if value.choice then
      table.insert(self._synthesisList, {
        value.uid1,
        value.uid2
      })
    end
  end
end

function UISeasonMazeBead:SynthesisPreView(beadItem, beadData1, beadData2, itemType, tipsFunc, commonTips)
  if not beadData1.data and not beadData2.data then
    beadItem:SetData(nil, nil, nil, itemType)
    return
  end
  if beadData1.kind == beadData2.kind then
    local cfg = Cfg.cfg_component_season_maze_autobead({
      KindID = beadData1.kind,
      Lv = beadData1.level + 1
    })
    if cfg then
      local data = SeasonMazeAutoBeadClient:New()
      data.bead_info.unique_id = 0
      data.bead_info.cfg_id = cfg[1].ID
      data.bead_info.b_new = false
      beadItem:SetData(3, data, function(uid, id, position)
        if tipsFunc then
          tipsFunc(uid, id, position)
        else
          self:ShowTips(uid, id, position)
        end
      end, itemType)
      return
    end
  end
  local level = 0
  if beadData1.data then
    level = beadData1.level
  else
    level = beadData2.level
  end
  local beadType
  if beadData1.type == beadData2.type then
    beadType = beadData1.type
  end
  beadItem:ShowUnknown(level + 1, function(go)
    local data = SeasonMazeEffect:New()
    data.type = SeasonMazeEffectType.SMET_Bead_LV
    data.id = level + 1
    data.value_min = 0
    data.value_max = 0
    data.beadType = beadType
    if commonTips then
      commonTips:SetSeasonMazeData(data, 0, go.transform.position)
    else
      self._commonTips:SetSeasonMazeData(data, 0, go.transform.position)
    end
  end, beadType)
end

function UISeasonMazeBead:IntroBtnOnClick(go)
  UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp7, 1)
end

function UISeasonMazeBead:_TagCheck()
  if self._equipSlotWidgets then
    for _, value in ipairs(self._equipSlotWidgets) do
      local data = value:Data()
      if data then
        local cfg = Cfg.cfg_component_season_maze_autobead[data.bead_info.cfg_id]
        if cfg then
          if self:_ContainTag(cfg.NeedTag) then
            value:TagLock(false)
          else
            value:TagLock(true)
          end
        end
      end
    end
  end
end

function UISeasonMazeBead:_ContainTag(tags)
  if not tags then
    return true
  end
  local contain = false
  if self._componentInfo.m_auto_bead_fit_list then
    for _, _uid in ipairs(self._componentInfo.m_auto_bead_fit_list) do
      local autoBeadClient = self._componentInfo.m_auto_bead_map[_uid]
      if autoBeadClient then
        local cfgID = autoBeadClient.bead_info.cfg_id
        local cfg = Cfg.cfg_component_season_maze_autobead[cfgID]
        if cfg and cfg.Tag then
          for _, _tag in ipairs(cfg.Tag) do
            if table.icontains(tags, _tag) then
              contain = true
              break
            end
          end
        end
      end
    end
  end
  return contain
end

function UISeasonMazeBead:_ClearNewByUID(uid)
  if self._componentInfo.m_auto_bead_map then
    for _uid, value in pairs(self._componentInfo.m_auto_bead_map) do
      if _uid == uid then
        table.insert(self._tempClearUIDs, uid)
        break
      end
    end
  end
  for index, value in pairs(self._itemWidgets) do
    local data = value:Data()
    if data and data.bead_info.unique_id == uid then
      value:RefreshNew()
      break
    end
  end
end

function UISeasonMazeBead:IsTempClear(uid)
  if uid then
    for _, _uid in pairs(self._tempClearUIDs) do
      if _uid == uid then
        return true
      end
    end
  end
  return false
end

function UISeasonMazeBead:GetGuideItem()
  if self._itemWidgets then
    return self._itemWidgets[1]:IconGO()
  end
end

function UISeasonMazeBead:_GetSlotIndexByUID(uid)
  if self._componentInfo.m_auto_bead_fit_list then
    for _slotIndex, _uid in ipairs(self._componentInfo.m_auto_bead_fit_list) do
      if _uid == uid then
        return _slotIndex
      end
    end
  end
  return nil
end
