_class("UISeasonMazeScene", UIController)
UISeasonMazeScene = UISeasonMazeScene

function UISeasonMazeScene:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeScene:GetSMazeEnterPlot()
  local storyid
  local seasonObj = self._module:CurSeasonObj()
  local comInfo = seasonObj:GetMazeComponent():GetComponentInfo()
  if comInfo.m_first_story_id and comInfo.m_first_story_id > 0 then
    storyid = comInfo.m_first_story_id
  end
  return storyid
end

function UISeasonMazeScene:PlayPlot()
  local storyid = self:GetSMazeEnterPlot()
  self:ShowDialog("UIStoryController", storyid)
end

function UISeasonMazeScene:OnShow(uiParams)
  self._module = GameGlobal.GetModule(SeasonMazeModule)
  self:InitWidget()
  local plotBtnCb
  local topBtn = self.topBtn:SpawnObject("UISMazeCommonTopButton")
  topBtn:SetData(function()
    self._module:UIModule():ExitTo(UIStateType.UISeasonMazeMain)
  end, function()
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp1, 2)
  end, function()
    self._module:UIModule():ExitTo(UIStateType.UIMain)
  end, nil, nil, nil, nil, plotBtnCb)
  self:SetUISeasonMazeCard()
  self:SetUISeasonMazeTopIcon()
  self:SetUISeasonMazeBossAtk()
  self:SetUISeasonMazeBackRoom()
  self:SetUISeasonMazeActiveItem()
  self:SetUISeasonMazeOvalArea()
  self:SetUISeasonMazeHud()
  self:SetUISeasonMazeRoundTip()
  self:SetUISeasonMazeWorldBoss()
  self:AttachEvent(GameEventType.OnSeasonMazeStateChanged, self._OnGameStateChanged)
  self:AttachEvent(GameEventType.OnSeasonMazeClickRoom, self.SetUISeasonMazeRoomInfo)
  self:AttachEvent(GameEventType.OnSeasonMazeClickTransportPoint, self.SetUISeasonMazeTransportPointInfo)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnAfterUILayerChanged)
  self:AttachEvent(GameEventType.GuideDone, self.GuideDone)
  self:AttachEvent(GameEventType.OnUISeasonMazeAttChanged, self.OnUISeasonMazeAttChanged)
  SMazeAdaptor.OnShowMainUI()
  self:Lock("UISeasonMazeScene_EnterAni")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UISeasonMazeScene_EnterAni")
    self:_CheckGuide()
  end)
  local seasonMazeId = self._module:CurSeasonMazeID()
  local cfg = Cfg.cfg_season_maze_client[seasonMazeId]
  if cfg then
    AudioHelperController.PlayBGM(cfg.Bgm, AudioConstValue.BGMCrossFadeTime)
  else
    Log.error("cfg_season_maze_client can't find maze id ", seasonMazeId)
  end
end

function UISeasonMazeScene:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeScene)
end

function UISeasonMazeScene:OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if GameGlobal.UIStateManager():IsShow("UISpiritDetailLookCgAndSpineController") and GameGlobal.UIStateManager():IsTopUI("UISpiritDetailLookCgAndSpineController") then
    topui = true
  end
  GameGlobal.EngineInput().multiTouchEnabled = topui
  Log.info("设置秘境多点触控:", not topui)
end

function UISeasonMazeScene:OnUpdate(dtMS)
  if not self._module:UIModule():IsRunning() then
    return
  end
  if self._seasonMazeOvalArea then
    self._seasonMazeOvalArea:Update(dtMS)
  end
  if self.UISeasonMazeCardWidget then
    self.UISeasonMazeCardWidget:OnUpdate(dtMS)
  end
end

function UISeasonMazeScene:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._testText = self:GetUIComponent("UILocalizationText", "TestText")
  self._testText.gameObject:SetActive(EngineGameHelper.IsDevelopmentBuild())
  self.UISeasonMazeCard = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeCard")
  self.UISeasonMazeTopIcon = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeTopIcon")
  self.UISeasonMazeBossAtk = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeBossAtk")
  self.UISeasonMazeBackRoom = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeBackRoom")
  self.UISeasonMazeRoomInfo = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeRoomInfo")
  self.UISeasonMazeRoomInfoRt = self:GetUIComponent("RectTransform", "UISeasonMazeRoomInfo")
  self.UISeasonMazeActiveItem = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeActiveItem")
  self.UISeasonMazeWorldBoss = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeWorldBoss")
  self.UISeasonMazeRoomTest = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeRoomTest")
  self.UISeasonMazeRoomTestWidget = self.UISeasonMazeRoomTest:SpawnObject("UISeasonMazeRoomTest")
  self._seasonMazeManger = self._module:UIModule():SeasonMazeManager()
  self._camera = self._seasonMazeManger:SeasonMazeCameraManager():Camera()
  self._layer1 = self:GetGameObject("Layer1")
  self._layer2 = self:GetGameObject("Layer2")
  self._layer3 = self:GetGameObject("Layer3")
  self._black = self:GetUIComponent("Image", "black")
end

function UISeasonMazeScene:SetUISeasonMazeActiveItem()
  if self.UISeasonMazeActiveItem then
    if not self.UISeasonMazeActiveItemWidget then
      self.UISeasonMazeActiveItemWidget = self.UISeasonMazeActiveItem:SpawnObject("UISeasonMazeActiveItem")
    end
    self.UISeasonMazeActiveItemWidget:SetData()
    self.UISeasonMazeActiveItemWidget:SetShowUiCb(function(active)
      self:ShowUiWithoutItem(active)
    end)
  end
end

function UISeasonMazeScene:HideActiveItemTip()
  self.UISeasonMazeActiveItemWidget:CloseItemInfoOnClick()
end

function UISeasonMazeScene:ShowUiWithoutItem(active)
  self._layer1:SetActive(active)
  self._layer2:SetActive(true)
  self._layer3:SetActive(active)
end

function UISeasonMazeScene:OnUISeasonMazeAttChanged()
  self:SetUISeasonMazeWorldBoss()
end

function UISeasonMazeScene:SetUISeasonMazeRoomInfo(type, id, pos)
  if self.UISeasonMazeRoomInfo then
    if not self.UISeasonMazeRoomInfoWidget then
      self.UISeasonMazeRoomInfoWidget = self.UISeasonMazeRoomInfo:SpawnObject("UISeasonMazeRoomInfo")
    end
    local screenPos = self._camera:WorldToScreenPoint(pos)
    local camera2d = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local res, posui = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.UISeasonMazeRoomInfoRt, screenPos, camera2d, nil)
    local cfg_room_view = Cfg.cfg_season_maze_room_view[type]
    local desc, title
    if type == SeasonMazeRoomType.SMRT_Resource then
      local roomCfg = Cfg.cfg_component_season_maze_room_res[id]
      local resourceRoom = cfg_room_view.CustomParam[roomCfg.ResType]
      desc = resourceRoom.Desc
      title = resourceRoom.Name
    else
      desc = cfg_room_view.Desc
      title = cfg_room_view.Name
    end
    self.UISeasonMazeRoomInfoWidget:SetData(posui, title, desc)
  end
end

function UISeasonMazeScene:SetUISeasonMazeTransportPointInfo(pos)
  if self.UISeasonMazeRoomInfo then
    if not self.UISeasonMazeRoomInfoWidget then
      self.UISeasonMazeRoomInfoWidget = self.UISeasonMazeRoomInfo:SpawnObject("UISeasonMazeRoomInfo")
    end
    local screenPos = self._camera:WorldToScreenPoint(pos)
    local camera2d = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local res, posui = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.UISeasonMazeRoomInfoRt, screenPos, camera2d, nil)
    local desc, title
    desc = "str_season_maze_transport_point_desc"
    title = "str_season_maze_transport_point_name"
    self.UISeasonMazeRoomInfoWidget:SetData(posui, title, desc)
  end
end

function UISeasonMazeScene:SetUISeasonMazeCard()
  if self.UISeasonMazeCard then
    if not self.UISeasonMazeCardWidget then
      self.UISeasonMazeCardWidget = self.UISeasonMazeCard:SpawnObject("UISeasonMazeCard")
    end
    self.UISeasonMazeCardWidget:SetData(nil)
  end
end

function UISeasonMazeScene:ShowCard(ids, closeAnim)
  if self.UISeasonMazeCardWidget then
    self.UISeasonMazeCardWidget:SetData(ids, closeAnim)
  end
end

function UISeasonMazeScene:ReSetCards()
  if self.UISeasonMazeCardWidget then
    self.UISeasonMazeCardWidget:ReSet()
  end
end

function UISeasonMazeScene:SetUISeasonMazeTopIcon()
  if self.UISeasonMazeTopIcon then
    if not self.UISeasonMazeTopIconWidget then
      self.UISeasonMazeTopIconWidget = self.UISeasonMazeTopIcon:SpawnObject("UISeasonMazeTopIcon")
    end
    self.UISeasonMazeTopIconWidget:SetData()
  end
end

function UISeasonMazeScene:SetUISeasonMazeBackRoom()
  if self.UISeasonMazeBackRoom then
    if not self.UISeasonMazeBackRoomWidget then
      self.UISeasonMazeBackRoomWidget = self.UISeasonMazeBackRoom:SpawnObject("UISeasonMazeBackRoom")
    end
    self.UISeasonMazeBackRoomWidget:SetData()
  end
end

function UISeasonMazeScene:SetUISeasonMazeBossAtk()
  if self.UISeasonMazeBossAtk then
    if not self.UISeasonMazeBossAtkWidget then
      self.UISeasonMazeBossAtkWidget = self.UISeasonMazeBossAtk:SpawnObject("UISeasonMazeBossAtk")
    end
    self.UISeasonMazeBossAtkWidget:SetData()
  end
end

function UISeasonMazeScene:SetUISeasonMazeWorldBoss()
  if self.UISeasonMazeWorldBoss then
    local seasonObj = self._module:CurSeasonObj()
    local comInfo = seasonObj:GetMazeComponent():GetComponentInfo()
    local component = seasonObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
    local curTucket = component:GetAttrValue(SeasonMazeAttrType.SMAT_WorldBossTicket)
    if curTucket == 0 then
      return
    end
    if comInfo.hard < 4 then
      return
    end
    if not self.UISeasonMazeWorldBossWidget then
      self.UISeasonMazeWorldBossWidget = self.UISeasonMazeWorldBoss:SpawnObject("UISeasonMazeWorldBoss")
    end
    self.UISeasonMazeWorldBossWidget:SetData()
  end
end

function UISeasonMazeScene:_OnGameStateChanged(type)
  if EngineGameHelper.IsDevelopmentBuild() then
    self._testText:SetText(type)
  end
end

function UISeasonMazeScene:SetUISeasonMazeOvalArea()
  if not self._seasonMazeOvalArea then
    local widget = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeOvalArea")
    self._seasonMazeOvalArea = widget:SpawnObject("UISeasonMazeOvalArea")
  end
end

function UISeasonMazeScene:SetUISeasonMazeHud()
  if not self.UISeasonMazeHud then
    local widget = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeHud")
    self.UISeasonMazeHud = widget:SpawnObject("UISeasonMazeHud")
    self.UISeasonMazeHud:SetData()
  end
end

function UISeasonMazeScene:GetToastTimeline(assets)
  return self.UISeasonMazeHud:GetToastTimeline(assets)
end

function UISeasonMazeScene:SetUISeasonMazeRoundTip()
  if not self.UISeasonMazeRoundTip then
    local widget = self:GetUIComponent("UISelectObjectPath", "UISeasonMazeRoundTip")
    self.UISeasonMazeRoundTip = widget:SpawnObject("UISeasonMazeRoundTip")
  end
end

function UISeasonMazeScene:GetRoundTip()
  return self.UISeasonMazeRoundTip
end

function UISeasonMazeScene:TransEndPoint(time)
  if self._black then
    self._black:DOColor(Color(0, 0, 0, 0), time)
  end
end

function UISeasonMazeScene:TransStartPoint(time)
  if self._black then
    self._black:DOColor(Color(0, 0, 0, 1), time)
  end
end

function UISeasonMazeScene:GetMiddleCard()
  return self.UISeasonMazeCardWidget:GetMiddleCard()
end

function UISeasonMazeScene:GuideDone()
  self:_CheckGuide()
end

function UISeasonMazeScene:BossAtkAnim()
  if self.UISeasonMazeBossAtkWidget then
    self.UISeasonMazeBossAtkWidget:BossAtkAnim()
  end
end
