_class("UIMazeController", UIController)
UIMazeController = UIMazeController

function UIMazeController:Constructor()
end

function UIMazeController:LoadDataOnEnter(TT, res, uiParams)
  local module = self:GetModule(MazeModule)
  local ack = module:RequestMazeVersion(TT)
  if ack:GetSucc() then
    res:SetSucc(true)
    Log.notice("[Maze] request data success, open ui")
  else
    res:SetSucc(false)
    Log.notice("[Maze] request data time up, open failed")
    ToastManager.ShowToast(ack:GetResult())
  end
end

function UIMazeController.SetToOpenRoomIndex(roomIndex)
  UIMazeController.RoomIndex = roomIndex
end

function UIMazeController:OnShow(uiParams)
  self._sceneReq = uiParams[1]
  self._active = true
  self._disposed = false
  local topButton = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self.topButtonWidget = topButton:SpawnObject("UICommonTopButton")
  self.topButtonWidget:SetData(function()
    self:OnLeave()
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Exit, "UI", function()
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery)
    end)
  end, function()
    self:ShowDialog("UIHelpController", "Maze")
  end, function()
    self:OnLeave()
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Exit, "UI", function()
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    end)
  end)
  self:InitUIWidget()
  self._mazeModule = GameGlobal.GetModule(MazeModule)
  self.mazeInfo = self._mazeModule:GetMazeInfo()
  self._version = self.mazeInfo.maze_version
  self._curLayer = self.mazeInfo.layer
  self._archieves = {}
  local idx = self.mazeInfo.room_index + 1
  if idx <= 0 then
    for _, _room in ipairs(self.mazeInfo.room_info) do
      if _room.layer_step == 1 and _room.level_info.has_archive then
        self._archieves[_room.room_index] = true
      end
    end
  else
    local room = self.mazeInfo.room_info[idx]
    for _, id in ipairs(room.next_rooms) do
      local _idx = id + 1
      local _room = self.mazeInfo.room_info[_idx]
      if _room.level_info.has_archive then
        self._archieves[_room.room_index] = true
      end
    end
  end
  local ctx = self:GetModule(MissionModule):TeamCtx()
  local teamInfo = self._mazeModule:GetFormationInfo()
  ctx:InitMazeTeam(teamInfo)
  self._3dManager = Maze3DManager:New()
  self._3dManager:Init(self, self.mazeInfo, function(room)
    if room then
      return self._archieves[room.room_index] == true
    else
      return false
    end
  end)
  self:RefreshUI()
  self:CheckUnselectRelics()
  self:CheckVersionAndLayer()
  self:PlayGetAwardAnim()
  self:AttachEvent(GameEventType.TeamMemberChanged, self.OnTeamMemberChanged)
  self:AttachEvent(GameEventType.MazeInfoUpdate, self.OnMazeInfoUpdate)
  self:AttachEvent(GameEventType.OnLeaveMaze, self.OnLeave)
  self:AttachEvent(GameEventType.OnPassRestRoom, self.ForceRefreshScene)
  self:AttachEvent(GameEventType.MazeJumpOutTo, self.JumpOutTo)
  self:AttachEvent(GameEventType.OnQuickFightClose, self.OnQuickFightClose)
  self:AttachEvent(GameEventType.OnChooseCardClose, self.OnChooseCardClose)
  if UIMazeController.RoomIndex then
    self._3dManager:GoToRoomByIndex(UIMazeController.RoomIndex)
    UIMazeController.RoomIndex = nil
  end
end

function UIMazeController:PlayGetAwardAnim()
  local pass = self._mazeModule:MazeIsPass()
  if pass then
  end
end

function UIMazeController:OnHide()
  self:OnLeave()
  if not self._disposed then
    self._3dManager:Dispose()
    self._disposed = true
  end
  if self._countTimer then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
  end
  if self.layerDelayTimer then
    GameGlobal.Timer():CancelEvent(self.layerDelayTimer)
    self.layerDelayTimer = nil
  end
  Log.warn("[Maze] 关闭迷宫，析构场景")
end

function UIMazeController:JumpOutTo(func)
  self:OnLeave()
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Exit, "UI", func)
end

function UIMazeController:OnLeave()
  self._active = false
end

function UIMazeController:RefreshUI()
  self:HideRoomMsg()
  local sop = self:GetUIComponent("UISelectObjectPath", "currencyMenu")
  local currencyMenu = sop:SpawnObject("UICurrencyMenu")
  currencyMenu:SetData({
    RoleAssetID.RoleAssetLight
  })
  self.lightItem = currencyMenu:GetItemByTypeId(RoleAssetID.RoleAssetLight)
  self._layerText.text = string.format(StringTable.Get("str_maze_tip_cur_layer"), self.mazeInfo.layer)
  self:CountDown()
end

function UIMazeController:OnMazeInfoUpdate()
  Log.warn("[Maze] 刷新迷宫")
  if not self._active then
    return
  end
  local curVer = GameGlobal.GetModule(MazeModule):GetMazeInfo().maze_version
  if self._version == curVer then
    Log.warn("[Maze] 版本号没变，不执行刷新")
    return
  end
  self:SwitchState(UIStateType.UIMaze, self._sceneReq)
end

function UIMazeController:OnTeamMemberChanged()
  self._3dManager:RefreshActor()
end

function UIMazeController:CheckUnselectRelics()
  local count = #self._mazeModule._mazeInfo.dangling_relics
  if 0 < count then
    self:ShowDialog("UIRugueLikeChooseCardController", self._mazeModule._mazeInfo.dangling_relics)
  end
end

function UIMazeController:CheckVersionAndLayer()
  local serverVer = self.mazeInfo.maze_version
  local serverLayer = self.mazeInfo.layer
  local playerID = GameGlobal.GetModule(RoleModule):GetPstId()
  local versionkey = "MazeVersion-" .. playerID
  local layerkey = "MazeLayer-" .. playerID
  if UnityEngine.PlayerPrefs.HasKey(versionkey) then
    local localLayer = UnityEngine.PlayerPrefs.GetInt(layerkey)
    local layerChanged = localLayer ~= serverLayer
    if layerChanged then
      UnityEngine.PlayerPrefs.SetInt(layerkey, serverLayer)
    end
    local localVer = UnityEngine.PlayerPrefs.GetInt(versionkey)
    if localVer ~= serverVer then
      UnityEngine.PlayerPrefs.SetInt(versionkey, serverVer)
      self:ShowDialog("UIRugueLikeResetMsgBoxController", StringTable.Get("str_maze_tips_reset"), function()
        if layerChanged then
          self:OnLayerChanged()
        end
      end)
      if GameGlobal.UIStateManager():IsShow("UIRugueLikeChooseCardController") then
        GameGlobal.UIStateManager():CloseDialog("UIRugueLikeChooseCardController")
      end
      if GameGlobal.UIStateManager():IsShow("UIMazeQuickFightController") then
        GameGlobal.UIStateManager():CloseDialog("UIMazeQuickFightController")
      end
      return true
    else
      if layerChanged then
        self:OnLayerChanged()
      end
      return false
    end
  else
    UnityEngine.PlayerPrefs.SetInt(versionkey, serverVer)
    UnityEngine.PlayerPrefs.SetInt(layerkey, serverLayer)
  end
  return false
end

function UIMazeController:OnLayerChanged()
  local layer = self.mazeInfo.layer
  if false then
    self._layerEndless:SetActive(true)
    self._layerStepGO:SetActive(false)
  else
    self._layerEndless:SetActive(false)
    self._layerStepGO:SetActive(true)
    self._layerNum.text = layer
    self._layerTextEN.text = string.format(StringTable.Get("str_maze_enter_layer_en"), layer)
  end
  self._layerTipGO:SetActive(true)
  self._animation:Play("UIMaze_1")
  self.layerDelayTimer = GameGlobal.Timer():AddEvent(1700, function()
    self._layerTipGO:SetActive(false)
    self.layerDelayTimer = nil
  end)
end

function UIMazeController:ForceRefreshScene()
  Log.warn("[Maze] 休息完成，刷新路点")
  self.mazeInfo = self._mazeModule:GetMazeInfo()
  self._3dManager:Dispose()
  self._disposed = false
  self._3dManager:Init(self, self.mazeInfo, function(room)
    if room then
      return self._archieves[room.room_index] == true
    else
      return false
    end
  end)
  self:RefreshUI()
end

function UIMazeController:OnUpdate(deltaTimeMS)
  if not self._active then
    return
  end
  self._3dManager:Update(deltaTimeMS / 1000)
end

function UIMazeController:InitUIWidget()
  self._roomName = self:GetUIComponent("UILocalizationText", "RoomName")
  self._roomBG = self:GetUIComponent("Image", "RoomBg")
  self._roomBGRect = self:GetUIComponent("RectTransform", "RoomCard")
  self._roomDes = self:GetUIComponent("UILocalizationText", "RoomDesc")
  self._property = self:GetUIComponent("UILocalizationText", "propertyDesc")
  self._battleText = self:GetUIComponent("UILocalizationText", "BattleText")
  self._battleButton = self:GetGameObject("StartBattle")
  self._cantReach = self:GetGameObject("CantReach")
  self._roomMsg = self:GetGameObject("RoomMsg")
  self._attribute = self:GetGameObject("attributes")
  self._layerText = self:GetUIComponent("UILocalizationText", "Layer")
  self._timerText = self:GetUIComponent("UILocalizationText", "Timer")
  self._roomUICfg = {
    [1] = {
      bg = "map_tansuo_tu1",
      btnText = "str_maze_btn_battle"
    },
    [2] = {
      bg = "map_tansuo_tu2",
      btnText = "str_maze_btn_battle"
    },
    [3] = {
      bg = "map_tansuo_tu4",
      btnText = "str_maze_btn_battle"
    },
    [4] = {
      bg = "map_tansuo_tu3",
      btnText = "str_maze_btn_battle"
    },
    [5] = {
      bg = "map_tansuo_tu5",
      btnText = "str_maze_btn_battle"
    },
    [6] = {
      bg = "map_tansuo_tu11",
      btnText = "str_maze_btn_battle"
    },
    [7] = {
      bg = "map_tansuo_tu6",
      btnText = "str_maze_btn_battle"
    }
  }
  self._atlas = self:GetAsset("UIMazeMain.spriteatlas", LoadType.SpriteAtlas)
  self._dropLoader = self:GetUIComponent("UISelectObjectPath", "DropContent")
  self._dropTitle = self:GetUIComponent("RectTransform", "awardTitle")
  self._dropList = self:GetUIComponent("RectTransform", "awards")
  self._enemyLoader = self:GetUIComponent("UISelectObjectPath", "EnemyLoader")
  self._enemyRoot = self:GetGameObject("EnemyLoader")
  self._enemyTitle = self:GetUIComponent("RectTransform", "enemytitle")
  self._enemyList = self:GetUIComponent("RectTransform", "EnemyLoader")
  self.matTip = self:GetUIComponent("UISelectObjectPath", "matTip")
  self.matTipWidget = self.matTip:SpawnObject("UISelectInfo")
  self._roomInfoGO = self:GetGameObject("msg")
  self._layerTipGO = self:GetGameObject("LayerTip")
  self._animation = self:GetUIComponent("Animation", "uianim")
  self._layerTipGO:SetActive(false)
  self._layerStepGO = self:GetGameObject("Step")
  self._layerEndless = self:GetGameObject("Endless")
  self._layerNum = self:GetUIComponent("UILocalizationText", "LayerNum")
  self._layerTextEN = self:GetUIComponent("UILocalizationText", "LayerTextEn")
  self._quickFightBtn = self:GetGameObject("quickFightBtn")
  self._quickFightCost = self:GetUIComponent("UILocalizationText", "cost")
  self._quickFightLock = self:GetGameObject("quickFightLock")
end

function UIMazeController:CountDown()
  if not self._active then
    return
  end
  self:_refreshCountDownTime()
  local time = math.floor(self._mazeModule:GetSecToFinish())
  if 0 < time then
    self._countTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:_refreshCountDownTime()
    end)
  end
end

function UIMazeController:_refreshCountDownTime()
  if not self._active then
    return
  end
  local time = math.floor(self._mazeModule:GetSecToFinish())
  if time <= 0 then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
    self._timerText:SetText("00:00:00")
    GameGlobal.TaskManager():StartTask(self.RequestUpdateMazeInfo, self)
  elseif 86400 < time then
    local day = math.floor(time / 60 / 60 / 24)
    day = day .. StringTable.Get("str_maze_open_time_day_str")
    local hour = math.floor(time / 60 / 60) % 24
    hour = hour .. StringTable.Get("str_maze_open_time_hour_str")
    self._timerText:SetText(day .. hour)
  else
    local hour = math.floor(time / 3600)
    local min = math.floor(time % 3600 / 60)
    if min < 10 then
      min = "0" .. min
    end
    local sceonds = math.floor(time % 60)
    if sceonds < 10 then
      sceonds = "0" .. sceonds
    end
    self._timerText:SetText(hour .. ":" .. min .. ":" .. sceonds)
  end
end

function UIMazeController:ShowRoomMsg(roomData, canReach)
  self._roomData = roomData
  self._roomCfgData = Cfg.cfg_maze_room[roomData.room_id]
  self._battleButton:SetActive(canReach)
  self._roomName.text = self:FormateColorText(self._roomCfgData.Title)
  self._roomDes.text = StringTable.Get(self._roomCfgData.Desc)
  local uiCfg = self._roomUICfg[self._roomCfgData.MazeRoomType]
  self._battleText:SetText(StringTable.Get(uiCfg.btnText))
  self._roomBG.sprite = self._atlas:GetSprite(uiCfg.bg)
  local roomType = self._roomCfgData.MazeRoomType
  if roomType == MazeRoomType.MazeRoomType_Normal then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.MazeRoomType_Normal)
  elseif roomType == MazeRoomType.MazeRoomType_Battery then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.MazeRoomType_Battery)
  elseif roomType == MazeRoomType.MazeRoomType_XRoot then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.MazeRoomType_XRoot)
  elseif roomType == MazeRoomType.MazeRoomType_Elite then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.MazeRoomType_Elite)
  end
  if self._roomCfgData.MazeRoomType == MazeRoomType.MazeRoomType_Battery then
    self._roomInfoGO:SetActive(false)
    self._roomBGRect.anchoredPosition = Vector2(-36, self._roomBGRect.anchoredPosition.y)
  else
    local wordCount = #self._roomData.level_info.word_ids
    local hasWord = false
    if 0 < wordCount then
      local wordIds = self._roomData.level_info.word_ids
      local totalWordDesc
      for _, wordId in ipairs(wordIds) do
        local wordCfg = Cfg.cfg_word_buff[wordId]
        local word = "【" .. StringTable.Get(wordCfg.Word[1]) .. "】"
        local wordName = string.format("<color=#%s>%s</color>", wordCfg.Word[2], word)
        local desc = wordName .. StringTable.Get(wordCfg.Desc)
        if totalWordDesc then
          totalWordDesc = totalWordDesc .. "\n" .. desc
        else
          totalWordDesc = desc
        end
      end
      self._property.text = totalWordDesc
      self._attribute:SetActive(true)
      hasWord = true
    elseif wordCount == 0 then
      self._attribute:SetActive(false)
      hasWord = false
    end
    self:SetEnemy(hasWord)
    self:SetDrop(hasWord)
    self._roomBGRect.anchoredPosition = Vector2(-428, self._roomBGRect.anchoredPosition.y)
    self._roomInfoGO:SetActive(true)
  end
  self._cantReach:SetActive(not canReach)
  self:SetQuickFightBtn(canReach)
  self._roomMsg:SetActive(true)
end

function UIMazeController:CheckArchieve(room)
  if not next(self._archieves) then
    return
  end
  if not self._archieves[room.room_index] then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_maze_hava_a_archieve_room"), function(param)
      Log.notice("[Maze] 进入没有存档的关卡")
    end, nil, function(param)
      self._3dManager:ExitPreviewRoom()
    end, nil)
  end
end

function UIMazeController:FormateColorText(text)
  local color = text[2]
  if color then
    return string.format("<color=#%s>%s</color>", color, StringTable.Get(text[1]))
  else
    return StringTable.Get(text[1])
  end
end

function UIMazeController:SetEnemy(hasWord)
  local enemyIds = self._mazeModule:GetRoomMonsterList(self._roomData.room_index)
  if next(enemyIds) then
    local enemyMsg = self._enemyLoader:SpawnObject("UIEnemyMsg")
    enemyMsg:SetData(nil, enemyIds)
    self._enemyRoot:SetActive(true)
  else
    self._enemyRoot:SetActive(false)
  end
  if hasWord then
    self._enemyList.anchoredPosition = Vector2(245.6, 19)
    self._enemyTitle.anchoredPosition = Vector2(1100, -557)
  else
    self._enemyList.anchoredPosition = Vector2(245.6, 120)
    self._enemyTitle.anchoredPosition = Vector2(1100, -436)
  end
end

function UIMazeController:SetDrop(hasWord)
  local certainDrop, randomDrop = UICommonHelper:GetInstance():GetPassAward(AwardHeadType.Maze, self._roomCfgData.ID, true)
  local randomCount = 0
  if randomDrop and 0 < #randomDrop then
    randomCount = #randomDrop
  end
  local certainDropCount = #certainDrop
  local totalDrop = certainDropCount + randomCount
  self._dropLoader:SpawnObjects("UIAssetItem1", totalDrop)
  local items = self._dropLoader:GetAllSpawnList()
  local randomText = StringTable.Get("str_maze_random_drop")
  local certainText = StringTable.Get("str_maze_certain_drop")
  for idx = 1, totalDrop do
    local item = items[idx]
    local text, data
    if idx <= certainDropCount then
      text = string.format("<color=#ffffff>%s</color>", certainText)
      data = certainDrop[idx]
    else
      text = string.format("<color=#ffdc39>%s</color>", randomText)
      data = randomDrop[idx - certainDropCount]
    end
    item:SetData(data.ItemID, text, function(id, pos)
      self:OnMatClick(id, pos)
    end, data.Count)
  end
  if hasWord then
    self._dropList.anchoredPosition = Vector2(236.6, -258)
    self._dropTitle.anchoredPosition = Vector2(1099, -855)
  else
    self._dropList.anchoredPosition = Vector2(236.6, -208)
    self._dropTitle.anchoredPosition = Vector2(1099, -794)
  end
end

function UIMazeController:HideRoomMsg()
  self._roomMsg:SetActive(false)
end

function UIMazeController:EnemyButtonOnClick()
  local enemyIds = self._mazeModule:GetRoomMonsterList(self._roomData.room_index)
  self:ShowDialog("UIEnemyTip", enemyIds, 1)
end

function UIMazeController:StartBattleOnClick()
  if self._roomCfgData == nil then
    Log.fatal("[Maze]", "room is nil")
  end
  local showArchieve = false
  if next(self._archieves) and not self._archieves[self._roomData.room_index] then
    showArchieve = true
  end
  if showArchieve then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_maze_hava_a_archieve_room"), function(param)
      Log.notice("[Maze] 进入没有存档的关卡")
      self:EnterRoom()
    end, nil, function(param)
      self._3dManager:ExitPreviewRoom()
    end, nil)
  else
    self:EnterRoom()
  end
end

function UIMazeController:EnterRoom()
  if self._roomCfgData.MazeRoomType == MazeRoomType.MazeRoomType_Battery then
    self:ShowDialog("UIRugueLikeRestRoomController", self._roomData)
  else
    local light = GameGlobal.GetModule(RoleModule):GetLight()
    if light <= 0 then
      ToastManager.ShowToast(StringTable.Get("str_maze_no_light"))
      return
    end
    local module = self:GetModule(MissionModule)
    local ctx = module:TeamCtx()
    ctx:Init(TeamOpenerType.Maze, self._roomData.room_index)
    self:ShowDialog("UITeams")
  end
end

function UIMazeController:RequestUpdateMazeInfo(TT)
  local res = self._mazeModule:RequestMazeVersion(TT)
  if res:GetSucc() then
  else
    Log.fatal("[Maze] update maze info error:", res:GetResult())
  end
end

function UIMazeController:RelicBagButtonOnClick()
  if #self.mazeInfo.relics <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_maze_no_relics"))
    return
  end
  self:ShowDialog("UIRugueLikeBackpackController")
end

function UIMazeController:MysteryStoreButtonOnClick()
  ClientShop.OpenShop(nil, ShopMainTabType.Secret, MarketType.Shop_MysteryMarket)
end

function UIMazeController:RoomEmptyOnClick()
  self._3dManager:ExitPreviewRoom()
end

function UIMazeController:OnMatClick(matId, pos)
  self.matTipWidget:SetData(matId, pos)
end

function UIMazeController:GetLightItemBg()
  return self.lightItem and self.lightItem:GetGameObject()
end

function UIMazeController:SetQuickFightBtn(canReach)
  local _showBtn, _unLock
  self._cost = 0
  if not canReach then
    _showBtn = false
  else
    local roomid = self._roomData.room_id
    local cfg_maze_room = Cfg.cfg_maze_room[roomid]
    if not cfg_maze_room then
      Log.error("###[UIMazeController] cfg_maze_room is nil ! id --> ", roomid)
    end
    if cfg_maze_room.CanSkip then
      _showBtn = true
      _unLock = self._mazeModule:UnlockSweep()
      self._cost = cfg_maze_room.SkipCostMS
    else
      _showBtn = false
    end
  end
  if _showBtn then
    if _unLock then
      local light = GameGlobal.GetModule(RoleModule):GetLight()
      local _costTex
      if light >= self._cost then
        _costTex = "<color=#ffffff>" .. self._cost .. "</color><color=#ffd83d>/" .. light .. "</color>"
      else
        _costTex = "<color=#ff0000>" .. self._cost .. "</color><color=#ffd83d>/" .. light .. "</color>"
      end
      self._quickFightCost:SetText(_costTex)
    end
    self._quickFightLock:SetActive(not _unLock)
    self._quickFightBtn:SetActive(_unLock)
  else
    self._quickFightLock:SetActive(false)
    self._quickFightBtn:SetActive(false)
  end
end

function UIMazeController:quickFightLockBtnOnClick(go)
  ToastManager.ShowToast(StringTable.Get("str_maze_quick_fight_lock"))
end

function UIMazeController:quickFightBtnOnClick(go)
  self:Lock("UIMazeController:quickFightBtnOnClick")
  GameGlobal.TaskManager():StartTask(self.OnQuickFightRequest, self)
end

function UIMazeController:OnQuickFightRequest(TT)
  local res, reply = self._mazeModule:RequestSweep(TT, self._roomData.room_index)
  self:UnLock("UIMazeController:quickFightBtnOnClick")
  if res:GetSucc() then
    local rewards = reply.awards
    self:ShowDialog("UIMazeQuickFightController", rewards, self._cost)
  else
    local result = res:GetResult()
    local tips = self:GetErrorResult(result)
    ToastManager.ShowToast(tips)
    Log.error("###[UIMazeController] self._mazeModule:RequestSweep fail ! result --> ", result)
  end
end

function UIMazeController:GetErrorResult(result)
  local str
  if result == MazeOpResCode.MAZE_NEED_LIGHT then
    str = StringTable.Get("str_maze_no_light")
  elseif result == MazeOpResCode.MAZE_INVALID_ROOM then
    str = StringTable.Get("str_maze_tip_cantreach")
  elseif result == MazeOpResCode.MAZE_VERSION_ERROR then
    str = StringTable.Get("str_help_maze_title6")
  else
    str = "Other Error ! Result --> " .. result
  end
  return str
end

function UIMazeController:OnQuickFightClose()
  Log.debug("###[UIMazeController] OnQuickFightClose 关闭扫荡收获界面，开始选择圣物")
  self._quickRelic = self._mazeModule._mazeInfo.dangling_relics
  if self._quickRelic and table.count(self._quickRelic) > 0 then
    Log.debug("###[UIMazeController] OnQuickFightClose 有圣物，开始选择")
    self:ShowDialog("UIRugueLikeChooseCardController", self._quickRelic, true)
  else
    Log.debug("###[UIMazeController] OnQuickFightClose 没有圣物，刷新秘境")
    self:OnChooseCardClose()
  end
end

function UIMazeController:OnChooseCardClose()
  self:SwitchState(UIStateType.UIMaze, self._sceneReq)
end
