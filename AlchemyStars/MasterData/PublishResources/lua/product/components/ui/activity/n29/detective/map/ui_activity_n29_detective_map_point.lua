_class("UIActivityN29DetectiveMapPoint", UICustomWidget)
UIActivityN29DetectiveMapPoint = UIActivityN29DetectiveMapPoint

function UIActivityN29DetectiveMapPoint:Constructor(uiview)
  self._isExplored = true
  self._isLock = true
end

function UIActivityN29DetectiveMapPoint:OnShow(uiParams)
  self:_GetComponent()
end

function UIActivityN29DetectiveMapPoint:_GetComponent()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._newObj = self:GetGameObject("new")
  self._markObj = self:GetGameObject("mark")
  self._parent = self:GetGameObject("parent")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._playerImg = self:GetUIComponent("RawImageLoader", "playerImg")
  self._playerImgRect = self:GetUIComponent("RectTransform", "playerImg")
  self._pointBtn = self:GetGameObject("pointBtn")
  self._anim = self:GetUIComponent("Animation", "rect")
  self._rect.anchorMax = Vector2(0.5, 0.5)
  self._rect.anchorMin = Vector2(0.5, 0.5)
end

function UIActivityN29DetectiveMapPoint:SetData(data, campaign, psdid, stage)
  self._data = data
  self._campaign = campaign
  local localProcess = campaign:GetLocalProcess()
  self._compInfo = localProcess:GetComponentInfo(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._clueInfo = self._compInfo.cur_info
  self._psdId = psdid
  self._curStage = stage
  self._legalClueList = {}
  self:CheckPointIsOver()
  self:InitData()
end

function UIActivityN29DetectiveMapPoint:GetLegalClueList()
  local stageCfg = Cfg.cfg_component_detective_stage({})
  for i, cfg in pairs(stageCfg) do
    if i > self._curStage then
      return
    end
    local stageClues = cfg.ClueList
    table.appendArray(self._legalClueList, stageClues)
  end
end

function UIActivityN29DetectiveMapPoint:InitData()
  local position = self._data.Position
  self._rect.anchoredPosition = Vector2(position[1] / 10, position[2] / 10)
  if self._data.PointPic then
    self._playerImg:LoadImage(self._data.PointPic)
    self._playerImgRect.sizeDelta = Vector2(self._data.PointPicSize[1], self._data.PointPicSize[2])
    if self._data.Scale then
      local scale = self._data.Scale * 0.01
      self._playerImgRect.localScale = Vector3(scale, scale, 1)
    end
  end
end

function UIActivityN29DetectiveMapPoint:GetCfg()
  return self._data
end

function UIActivityN29DetectiveMapPoint:GetIsLockStatue()
  return self._isLock
end

function UIActivityN29DetectiveMapPoint:GetContentXPos()
  return self._rect.anchoredPosition.x
end

function UIActivityN29DetectiveMapPoint:GetContentYPos()
  return self._rect.anchoredPosition.y
end

function UIActivityN29DetectiveMapPoint:SetUnLock(callback)
  self:StartTask(self._SetUnLockAnim, self, callback)
end

function UIActivityN29DetectiveMapPoint:_SetUnLockAnim(TT, callback)
  self:SetPointActive(true)
  self:SetLock(false)
  self._newObj:SetActive(true)
  self:CheckPointIsOver()
  self._anim:Play("uieff_UIN29DetectiveMapPoint_unlock")
  YIELD(TT, 600)
  self._anim:Play("uieff_UIN29DetectiveMapPoint_unlockedswing")
  if callback then
    callback()
  end
end

function UIActivityN29DetectiveMapPoint:CancelNew()
  UIN29DetectiveHelper.SetOpenIdKey(self._psdId, "UIActivityN29DetectiveMapPoint" .. self._data.ID)
  self._newObj:SetActive(false)
end

function UIActivityN29DetectiveMapPoint:SetLock(isLock, isAnim)
  self:StartTask(self._SetLock, self, isLock, isAnim)
end

function UIActivityN29DetectiveMapPoint:_SetLock(TT, isLock, isAnim)
  if isLock then
    self._newObj:SetActive(false)
    self._isLock = true
    self._icon:LoadImage("n29_dt_icon03")
    self._title:SetText(StringTable.Get(self._data.HideName))
    self._markObj:SetActive(false)
  else
    self._isLock = false
    self._title:SetText(StringTable.Get(self._data.ShowName))
    self._icon:LoadImage(self._data.Icon)
  end
  self._anim:Play("uieff_UIN29DetectiveMapPoint_unlockedswing")
end

function UIActivityN29DetectiveMapPoint:CheckPointIsOver()
  local hasKey = UIN29DetectiveHelper.CheckOpenIdKey(self._psdId, "UIActivityN29DetectiveMapPoint" .. self._data.ID)
  if hasKey then
    self._newObj:SetActive(false)
    self:SetPointExplored()
    self._isExplored = true
  else
    self._newObj:SetActive(true)
    self._isExplored = false
  end
  local clueList = self._clueInfo.clue_list
  local needItems = Cfg.cfg_component_detective_waypoint[self._data.ID].WaypointContent
  local isOver = true
  for _, v in pairs(needItems) do
    local talkItem
    if self._data.Type == 1 then
      local cfg = Cfg.cfg_component_detective_suspicious({})
      talkItem = cfg[v]
    else
      local cfg = Cfg.cfg_component_detective_talk({})
      talkItem = cfg[v]
    end
    local stageClues = Cfg.cfg_component_detective_stage[self._curStage].ClueList
    local isContain = UIN29DetectiveHelper.Contain(clueList, talkItem.ClueId)
    local isLegal = UIN29DetectiveHelper.Contain(stageClues, talkItem.ClueId)
    if isLegal then
      if not isContain and not talkItem.NeedClue then
        isOver = false
        break
      elseif not isContain and talkItem.NeedClue then
        local isAllGet = true
        for i, need in pairs(talkItem.NeedClue) do
          if not UIN29DetectiveHelper.Contain(clueList, need) then
            isAllGet = false
          end
        end
        if isAllGet then
          isOver = false
        end
      end
    end
  end
  self._isOver = isOver
  self._markObj:SetActive(not isOver)
end

function UIActivityN29DetectiveMapPoint:GetPointIsOver()
  return self._isLock or self._isOver
end

function UIActivityN29DetectiveMapPoint:SetPointActive(isActive)
  self._parent:SetActive(isActive)
end

function UIActivityN29DetectiveMapPoint:SetPointExplored()
  self._title:SetText(StringTable.Get(self._data.ShowName))
  self._icon:LoadImage(self._data.Icon)
end

function UIActivityN29DetectiveMapPoint:PointBtnOnClick()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = svrTimeModule and math.floor(svrTimeModule:GetServerTime() * 0.001) or 0
  local closeTime = self._compInfo.m_close_time
  local isOpen = curTime < closeTime
  if not isOpen then
    ToastManager.ShowToast(StringTable.Get("str_n24_specialtask_close"))
    self:SwitchState(UIStateType.UIActivityN29MainController)
    return
  end
  if not self._isExplored and not self._isLock then
    self:CancelNew()
    self:SetPointExplored()
  end
  self:ShowDialog("UIActivityN29DetectiveWayController", self, self._curStage, self._psdId)
end

function UIActivityN29DetectiveMapPoint:GetPointBtnGo()
  return self._pointBtn
end
