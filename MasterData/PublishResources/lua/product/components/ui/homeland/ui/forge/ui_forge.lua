_class("UIForge", UIController)
UIForge = UIForge

function UIForge:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
  self.data:ResetSort()
  self.data.filter = 0
  self.data:Init(self.mHomeland:GetHomelandInfo())
  self.data:FilterList()
  self._firstItem = nil
  self._firstSquenceItem = nil
  self._fourthTagItem = nil
end

function UIForge:OnShow(uiParams)
  self.cTypeRect = self:GetUIComponent("RectTransform", "cType")
  self.cType = self:GetUIComponent("UISelectObjectPath", "cType")
  self.txtSequence = self:GetUIComponent("UILocalizationText", "txtSequence")
  self.imgClock = self:GetGameObject("imgClock")
  self.redSequence = self:GetGameObject("redSequence")
  self.redSequence:SetActive(false)
  self.goSort = self:GetGameObject("sort")
  self.sort = self:GetUIComponent("UISelectObjectPath", "sort")
  self.goEconomy = self:GetGameObject("economy")
  self.economy = self:GetUIComponent("UISelectObjectPath", "economy")
  self.list = self:GetGameObject("list")
  self.sequence = self:GetGameObject("sequence")
  self.cList = self:GetUIComponent("UISelectObjectPath", "cList")
  self.cSequence = self:GetUIComponent("UISelectObjectPath", "cSequence")
  self.oneKeyUnlockBtn = self:GetGameObject("OneKeyUnlock")
  self:AttachEvent(GameEventType.ShowHideListSequence, self.ShowHideListSequence)
  self:AttachEvent(GameEventType.HomelandForgeUpdateList, self.FlushList)
  self:AttachEvent(GameEventType.HomelandForgeUpdateSequence, self.FlushSequence)
  self:AttachEvent(GameEventType.HomelandLevelOnLevelInfoChange, self.HomelandLevelOnLevelInfoChange)
  self:Init()
  self:ShowHideListSequence(true)
  self:Flush()
  self:_CheckGuide()
end

function UIForge:OnHide()
  self:DetachEvent(GameEventType.ShowHideListSequence, self.ShowHideListSequence)
  self:DetachEvent(GameEventType.HomelandForgeUpdateList, self.FlushList)
  self:DetachEvent(GameEventType.HomelandForgeUpdateSequence, self.FlushSequence)
  self:DetachEvent(GameEventType.HomelandLevelOnLevelInfoChange, self.HomelandLevelOnLevelInfoChange)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIHomelandMain)
  if self._moveTask then
    GameGlobal.TaskManager():KillTask(self._moveTask)
    self._moveTask = nil
  end
end

function UIForge:Init()
  self:InitTypeTree()
  self:InitSort()
  self:InitEconomy()
end

function UIForge:InitTypeTree()
  local len = table.count(self.data.filters)
  self.cType:SpawnObjects("UIForgeTypeTreeItem", len)
  local uis = self.cType:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    local id = self.data.filters[i].id
    ui:Init(id)
    if id == 0 then
      ui:FoldFilter(0)
    end
    if id == 4 then
      self._fourthTagItem = ui
    end
  end
end

function UIForge:InitSort()
  local len = table.count(ForgeSortType)
  self.sort:SpawnObjects("UIForgeSort", len)
  local uis = self.sort:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Init(i)
  end
end

function UIForge:InitEconomy()
  self.economy:SpawnObject("UIForgeEconomy")
end

function UIForge:Flush()
  self:FlushSequence()
  self:GuideSort()
  self:FlushList()
end

function UIForge:GuideSort()
  if self:GetModule(GuideModule):IsGuideProcessKey("guide_dormitory_build") then
    local cfg = Cfg.cfg_guide_const.guide_dormitory_build
    local temp
    for i = 1, #self.data.list do
      if self.data.list[i].id == cfg.ArrayValue[1] then
        temp = self.data.list[i]
        table.remove(self.data.list, i)
        break
      end
    end
    if temp then
      table.insert(self.data.list, 1, temp)
    end
  end
end

function UIForge:FlushList(needFlushData)
  local len = table.count(self.data.list)
  self.cList:SpawnObjects("UIForgeItem", len)
  local uis = self.cList:GetAllSpawnList()
  self._firstItem = nil
  for i, ui in ipairs(uis) do
    local item = self.data.list[i]
    if item then
      ui:Flush(item.id)
    end
    if not self._firstItem then
      self._firstItem = ui
    end
  end
  self.oneKeyUnlockBtn:SetActive(self.data:HasCanUnlockItem() and self._isShowList)
  self:FlushSort()
end

function UIForge:FlushSort()
  local uis = self.sort:GetAllSpawnList()
  for i, ui in ipairs(uis) do
    ui:Flush()
  end
end

function UIForge:FlushSequence()
  local len = table.count(self.data.sequnces)
  self.cSequence:SpawnObjects("UIForgeSequenceItem", len)
  local uis = self.cSequence:GetAllSpawnList()
  self._firstSquenceItem = nil
  for i, ui in ipairs(uis) do
    ui:Flush(self.data.sequnces[i].index)
    if not self._firstSquenceItem then
      self._firstSquenceItem = ui
    end
  end
  self:FlushSequenceButton()
  self.oneKeyUnlockBtn:SetActive(false)
end

function UIForge:FlushSequenceButton()
  local mapStateCount = self.data:GetSequenceStateCountMap()
  local countForging = mapStateCount[ForgeSequenceState.Forging]
  local countGetable = mapStateCount[ForgeSequenceState.Getable]
  local countIdle = mapStateCount[ForgeSequenceState.Idle]
  local countLocked = mapStateCount[ForgeSequenceState.Locked]
  self.redSequence:SetActive(false)
  self.imgClock:SetActive(false)
  if 0 < countGetable then
    self.redSequence:SetActive(true)
  elseif 0 < countForging then
    self.imgClock:SetActive(true)
  end
  if 0 < countForging then
    self.txtSequence:SetText(StringTable.Get("str_homeland_forge_sequence_produce_ing", countForging, countForging + countGetable + countIdle))
  else
    self.txtSequence:SetText(StringTable.Get("str_homeland_forge_sequence_produce_list"))
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshInteractUI)
end

function UIForge:HomelandLevelOnLevelInfoChange()
  self.data:Init(self.mHomeland:GetHomelandInfo())
  self:FlushSequence()
end

function UIForge:ShowHideListSequence(isShowList)
  if isShowList then
    self.goSort:SetActive(true)
    self.goEconomy:SetActive(false)
    self.list:SetActive(true)
    self.sequence:SetActive(false)
  else
    self.goSort:SetActive(false)
    self.goEconomy:SetActive(true)
    self.list:SetActive(false)
    self.sequence:SetActive(true)
  end
  self._isShowList = isShowList
end

function UIForge.FlushCDText(uiText, time, strs, isUILocalizationText)
  local leftSeconds = UICommonHelper.CalcLeftSeconds(time)
  local d, h, m, s = UICommonHelper.S2DHMS(leftSeconds)
  
  local function SetText(str)
    if isUILocalizationText then
      uiText:SetText(str)
    else
      uiText:RefreshText(str)
    end
  end
  
  if 1 <= d then
    if 1 <= h then
      SetText(StringTable.Get(strs[1], math.floor(d), math.floor(h)))
    else
      SetText(StringTable.Get(strs[2], math.floor(d)))
    end
  elseif 1 <= h then
    if 1 <= m then
      SetText(StringTable.Get(strs[3], math.floor(h), math.floor(m)))
    else
      SetText(StringTable.Get(strs[4], math.floor(h)))
    end
  elseif 1 <= m then
    SetText(StringTable.Get(strs[5], math.floor(m)))
  else
    SetText(StringTable.Get(strs[5], "<1"))
  end
end

function UIForge.GetTimestampStr(timeDelta, strs)
  local d, h, m, s = UICommonHelper.S2DHMS(timeDelta)
  local str = ""
  if 1 <= d then
    if 1 <= h then
      str = StringTable.Get(strs[1], math.ceil(d), math.ceil(h))
    else
      str = StringTable.Get(strs[2], math.ceil(d))
    end
  elseif 1 <= h then
    if 1 <= m then
      str = StringTable.Get(strs[3], math.ceil(h), math.ceil(m))
    else
      str = StringTable.Get(strs[4], math.ceil(h))
    end
  elseif 1 <= m then
    str = StringTable.Get(strs[5], math.ceil(m))
  else
    str = StringTable.Get(strs[5], "<1")
  end
  return str
end

function UIForge:btnBackOnClick()
  self:CloseDialog()
end

function UIForge:btnInfoOnClick()
  self:ShowDialog("UIHomeHelpController", "UIForge")
end

function UIForge:btnSequenceOnClick()
  self:ShowHideListSequence(false)
  self:FlushSequence()
end

function UIForge:OneKeyUnlockOnClick()
  self:ShowDialog("UIForgeOneKeyUnlock")
end

function UIForge:GeForgeItem()
  return self._firstItem:GetGameObject("bg")
end

function UIForge:GeForgeFirstSquenceItemBg()
  return self._firstSquenceItem:GetGameObject("bg")
end

function UIForge:GeForgeFirstSquenceItemSpeedBtn()
  return self._firstSquenceItem:GetGameObject("btnSpeed")
end

function UIForge:GeForgeFirstSquenceBtnGet()
  return self._firstSquenceItem:GetGameObject("BtnGet")
end

function UIForge:GetSpecialTagItem()
  return self._fourthTagItem:GetGameObject("bg")
end

function UIForge:GetLandTagItem()
  self._moveTask = self:StartTask(function(TT)
    YIELD(TT, 100)
    if self.cTypeRect then
      self.cTypeRect.anchoredPosition = Vector2(self.cTypeRect.anchoredPosition.x, 120)
    end
  end)
  return self._fourthTagItem:GetLandBtn()
end

function UIForge:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIForge)
end
