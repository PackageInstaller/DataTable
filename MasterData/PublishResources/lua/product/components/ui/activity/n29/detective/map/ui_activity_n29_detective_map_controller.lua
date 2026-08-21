_class("UIActivityN29DetectiveMapController", UIController)
UIActivityN29DetectiveMapController = UIActivityN29DetectiveMapController

function UIActivityN29DetectiveMapController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N29, ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._comp = self._localProcess:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._info = self._localProcess:GetComponentInfo(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  self._curDetectiveInfo = self._info.cur_info
  self._psdId = self._curDetectiveInfo.pstid
end

function UIActivityN29DetectiveMapController:OnShow(data)
  self._data = data
  self._unLockQueue = {}
  self._moveSpeed = 2
  self._curStage = 1
  self._leftPoints = {}
  self._rightPoints = {}
  self._screenWidth = ResolutionManager.ScreenWidth()
  self._halfScreenWidth = self._screenWidth * 0.5
  self:CheckStage()
  self:_GetComponent()
  self:CheckPointShow()
  self:CheckNewPoint()
  self:CheckHasUnLock()
  self:_CheckPointsCanExplore()
  self:CheckGuide()
end

function UIActivityN29DetectiveMapController:OnHide()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = self._psdId .. openID .. "UIActivityN29DetectiveMapController_MovePose"
  local value = self._srMemory.horizontalNormalizedPosition * 1000
  LocalDB.SetInt(key, value)
end

function UIActivityN29DetectiveMapController:_GetComponent()
  self._degree = self:GetUIComponent("UILocalizationText", "degree")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._pointContent = self:GetUIComponent("UISelectObjectPath", "pointContent")
  self._srMemory = self:GetUIComponent("ScrollRect", "Scroll View")
  self._explorFill = self:GetUIComponent("Image", "explorFill")
  self._leftPointBtnObj = self:GetGameObject("LeftPointBtn")
  self._rightPointBtnObj = self:GetGameObject("RightPointBtn")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:SwitchState(UIStateType.UIN29DetectiveLogin)
  end, nil, nil, true, nil)
  local compCfgId = self._comp:GetComponentCfgId()
  local wayPointCfgs = Cfg.cfg_component_detective_waypoint({ComponentID = compCfgId})
  self._points = self._pointContent:SpawnObjects("UIActivityN29DetectiveMapPoint", #wayPointCfgs)
  for _, v in pairs(wayPointCfgs) do
    local infoCfg = Cfg.cfg_n29_detective_waypoint_info[v.ID]
    self._points[v.ID]:SetData(infoCfg, self._campaign, self._psdId, self._curStage)
  end
  local hasClueNum = #self._info.cur_info.clue_list
  local totalNum = #Cfg.cfg_component_detective_item({Type = 1})
  local precent = hasClueNum / totalNum
  self._degree:SetText(math.floor(precent * 100) .. "%")
  self._explorFill.fillAmount = precent
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = self._psdId .. openID .. "UIActivityN29DetectiveMapController_MovePose"
  local hasKey = LocalDB.HasKey(key)
  if hasKey then
    local value = LocalDB.GetInt(key)
    self._srMemory.horizontalNormalizedPosition = value / 1000
  else
    for _, point in pairs(self._points) do
      local isDefaultFocus = point:GetCfg().IsDefaultFocus
      if isDefaultFocus then
        self.defaultPointView = point
        self._srMemory.horizontalNormalizedPosition = point:GetContentXPos() / self._contentRect.sizeDelta.x
        break
      end
    end
  end
  self._srMemory.onValueChanged:AddListener(function(ve2)
    self:_CheckPointsCanExplore()
  end)
end

function UIActivityN29DetectiveMapController:CheckHasUnLock()
  if #self._unLockQueue > 0 then
    local point = self._unLockQueue[1]
    table.remove(self._unLockQueue, 1)
    self:Lock("UIActivityN29DetectiveMapController_CheckHasUnLock")
    self:StartTask(self._RemoveToTarget, self, point, function()
      point:SetUnLock(function()
        self:ShowDialog("UIActivityN29DetectiveNewwayController", point:GetCfg(), function()
          self:CheckHasUnLock()
        end)
        self:UnLock("UIActivityN29DetectiveMapController_CheckHasUnLock")
      end)
    end)
  end
end

function UIActivityN29DetectiveMapController:_CheckPointsCanExplore()
  self._leftPoints = {}
  self._rightPoints = {}
  for _, point in pairs(self._points) do
    local isOver = point:GetPointIsOver()
    if not isOver then
      local pointPos = point:GetContentXPos()
      local curPos = self._srMemory.horizontalNormalizedPosition * (self._contentRect.sizeDelta.x - self._screenWidth) + self._halfScreenWidth
      if 1500 < curPos - pointPos then
        table.insert(self._leftPoints, point)
      elseif 650 < pointPos - curPos then
        table.insert(self._rightPoints, point)
      end
    end
  end
  self._leftPointBtnObj:SetActive(#self._leftPoints > 0)
  self._rightPointBtnObj:SetActive(#self._rightPoints > 0)
end

function UIActivityN29DetectiveMapController:_RemoveToTarget(TT, point, callback)
  self:Lock("UIActivityN29DetectiveMapController_RemoveToTarget")
  local posX = point:GetContentXPos()
  local targetPercent = (posX - self._halfScreenWidth) / (self._contentRect.sizeDelta.x - self._screenWidth)
  local curPercent = self._srMemory.horizontalNormalizedPosition
  local diff = curPercent - targetPercent
  local step = 0.01
  while 0.01 <= math.abs(diff) do
    if 0 < diff then
      curPercent = curPercent - step
    else
      curPercent = curPercent + step
    end
    self._srMemory.horizontalNormalizedPosition = curPercent
    diff = curPercent - targetPercent
    YIELD(TT, 1)
  end
  self:UnLock("UIActivityN29DetectiveMapController_RemoveToTarget")
  if callback then
    callback()
  end
end

function UIActivityN29DetectiveMapController:CheckStage()
  local list = self._curDetectiveInfo.fragment_list
  local stageCfg = Cfg.cfg_component_detective_stage({})
  self._curStage = 1
  for i, v in pairs(stageCfg) do
    local needFrament = v.NeedFragment
    if needFrament then
      for _, frament in pairs(needFrament) do
        if not UIN29DetectiveHelper.Contain(list, frament) then
          return
        end
      end
    end
    self._curStage = i
  end
end

function UIActivityN29DetectiveMapController:CheckPointShow()
  for _, v in pairs(self._points) do
    v:SetPointActive(false)
  end
  local waypoint = Cfg.cfg_component_detective_stage[self._curStage].Waypoint
  for i, v in pairs(waypoint) do
    local point = self._points[v]
    local pointCfg = Cfg.cfg_component_detective_waypoint[v]
    point:SetPointActive(true)
    local hasClue = self:_CheckPointHasClue(pointCfg)
    if hasClue then
      point:SetLock(false, true)
    else
      point:SetLock(true, true)
    end
  end
end

function UIActivityN29DetectiveMapController:CheckNewPoint()
  local pointCfg = Cfg.cfg_component_detective_waypoint({})
  for i, v in pairs(pointCfg) do
    if v.NeedClue then
      local hasOpenId = UIN29DetectiveHelper.CheckOpenIdKey(self._psdId, "UIActivityN29DetectiveMapControllerLock" .. v.ID)
      if not hasOpenId then
        local hasClue = self:_CheckPointHasClue(v)
        if hasClue then
          UIN29DetectiveHelper.SetOpenIdKey(self._psdId, "UIActivityN29DetectiveMapControllerLock" .. v.ID)
          local point = self._points[i]
          point:SetLock(true, true)
          table.insert(self._unLockQueue, point)
        end
      end
    end
  end
end

function UIActivityN29DetectiveMapController:_CheckPointHasClue(pointCfg)
  local clueList = self._curDetectiveInfo.clue_list
  if not pointCfg.NeedClue then
    return true
  end
  for k, needClue in pairs(pointCfg.NeedClue) do
    local isContain = UIN29DetectiveHelper.Contain(clueList, needClue)
    if not isContain then
      return false
    end
  end
  return true
end

function UIActivityN29DetectiveMapController:ClueBtnOnClick()
  self:ShowDialog("UIActivityN29DetectiveBagController", true, self._curDetectiveInfo)
end

function UIActivityN29DetectiveMapController:PieceBtnOnClick()
  self:ShowDialog("UIActivityN29DetectiveBagController", false, self._curDetectiveInfo)
end

function UIActivityN29DetectiveMapController:LeftPointBtnOnClick()
  local point = self._leftPoints[1]
  self:StartTask(self._RemoveToTarget, self, point)
end

function UIActivityN29DetectiveMapController:RightPointBtnOnClick()
  local point = self._rightPoints[1]
  self:StartTask(self._RemoveToTarget, self, point)
end

function UIActivityN29DetectiveMapController:GetFirstGuidePerson()
  if not self.defaultPointView then
    return nil
  end
  return self.defaultPointView:GetPointBtnGo()
end

function UIActivityN29DetectiveMapController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN29DetectiveMapController)
end
