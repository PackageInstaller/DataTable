_class("UIN33EightPetsTeams", UIController)
UIN33EightPetsTeams = UIN33EightPetsTeams

function UIN33EightPetsTeams:Constructor()
  self._widgetCount = 8
  self._layoutWidth = 0
  self._isLongPressing = false
  self._lastClickTime = 0
end

function UIN33EightPetsTeams:LoadDataOnEnter(TT, res, uiParams)
  self._module = self:GetModule(MissionModule)
  self._ctx = self._module:TeamCtx()
  self.ctid = nil
end

function UIN33EightPetsTeams:OnShow(uiParams)
  self:UnLock("DoEnterEightPetsTeam")
  local teamId = self._ctx:GetCurrTeamId()
  self:UIWidget()
  self:DefaultVisible()
  self:AddEvents()
  self:InitCommonTopButton()
  self:InitTeamPageBtn()
  self:InitTeams()
  self:FlushTeamPageBtn()
  self:FlushTeam(teamId)
  self:FlushTeamCondition()
  self:InAnimation()
end

function UIN33EightPetsTeams:OnHide()
  if self._ctx:GetFightAgain() then
    self._ctx:SetFightAgain(false)
  end
  if self._ctx:IsFastSelect() then
    self._ctx:ClearFastSelect()
  end
  local hpm = self:GetModule(HelpPetModule)
  hpm:UI_ClearHelpPet()
  self:GetModule(PetModule):ClearAllPetSortInfo()
end

function UIN33EightPetsTeams:OnUpdate(deltaTimeMS)
  self:OnLayoutChanged(deltaTimeMS)
end

function UIN33EightPetsTeams:BtnChangeNameOnClick(go)
  if self.ctid then
    self:ShowDialog("UITeamsNameModify", self.ctid)
  end
end

function UIN33EightPetsTeams:BtnClearOnClick(go)
  if not self._team:HasPet() then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_discovery_clear_all_pet_or_not"), function(param)
    local team = self._team:Clone()
    local pets = team:GetPets()
    for k, v in pairs(pets) do
      pets[k] = 0
    end
    self:UpdateFormationInfo(team)
  end, nil, function(param)
  end, nil)
end

function UIN33EightPetsTeams:BtnFastTeamOnClick(go)
  self._ctx:InitTeamFastSelect()
  self:ShowDialog("UITeamChangeController")
end

function UIN33EightPetsTeams:BtnFightOnClick(go)
  local l_curTime = os.time()
  if l_curTime - self._lastClickTime < 1 then
    Log.debug("btnFightOnClick repeat")
    return
  else
    self._lastClickTime = l_curTime
  end
  local pc = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  pc:ResetCollector()
  pc:Sample("UIN33EightPetsTeams:BtnFightOnClick()")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIBattleStart)
  local bCheckTeamValid, team = self:CheckTeamValid()
  if not bCheckTeamValid then
    ToastManager.ShowToast(StringTable.Get("str_discovery_no_leader_no_fight"))
    return
  end
  if not self:CheckTeamMemberDuplicate() then
    ToastManager.ShowToast(StringTable.Get("str_tower_error_8"))
    return
  end
  if UIN33EightPetsTeamsContext:TeamConditionTestBattle() ~= UIN33EightPetsTeamsReason.SUCCESS then
    ToastManager.ShowToast(StringTable.Get("str_tower_error_7"))
    return
  end
  local petModule = self:GetModule(PetModule)
  petModule:ClearAllPetSortInfo()
  self:Lock("DoEnterMatch")
  local game = GameGlobal.GetModule(GameMatchModule)
  local role = GameGlobal.GetModule(RoleModule)
  local curTeamId = self._ctx:GetCurrTeamId()
  local matchType = MatchType.MT_EightPets
  local param = self._ctx:GetParam()
  local createInfo = game:GetMatchCreateInfo(matchType, param)
  self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
  local petsList = self._team.pets
  role:UpdateMatchPetsList(petsList)
end

function UIN33EightPetsTeams:UIWidget()
  self._btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._tglGoupTrans = self:GetUIComponent("RectTransform", "hlgTgls")
  self._tglGroup = self:GetUIComponent("ToggleGroup", "hlgTgls")
  self._tglObjectPath = self:GetUIComponent("UISelectObjectPath", "hlgTgls")
  self._tglScrollViewTrans = self:GetUIComponent("RectTransform", "TglScrollView")
  self._tglScrollView = self:GetUIComponent("ScrollRect", "TglScrollView")
  self._viewPointTrans = self:GetUIComponent("RectTransform", "TglViewport")
  self._leftTglGroupArrow = self:GetGameObject("leftArrow")
  self._rightTglGroupArrow = self:GetGameObject("rightArrow")
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._fightBtnTrans = self:GetUIComponent("RectTransform", "btnFight")
  self._hlgLayout = self:GetUIComponent("GridLayoutGroup", "hlg")
  self._hlgPath = self:GetUIComponent("UISelectObjectPath", "hlg")
  self._uiTeamsLeaderPath = self:GetUIComponent("UISelectObjectPath", "leader")
  self._replaceTran = self:GetUIComponent("RectTransform", "replace")
  self._replaceCard = nil
  self._replaceCardPath = self:GetUIComponent("UISelectObjectPath", "card")
  self._imgCondition = self:GetUIComponent("RectTransform", "imgCondition")
  self._txtCondition = self:GetUIComponent("UILocalizationText", "txtCondition")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._atlasProf = self:GetAsset("UIPetJobIcon.spriteatlas", LoadType.SpriteAtlas)
end

function UIN33EightPetsTeams:DefaultVisible()
  self._replaceTran.gameObject:SetActive(false)
end

function UIN33EightPetsTeams:AddEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:AttachEvent(GameEventType.DiscoveryChangeTeamData, self.FlushTeam)
  self:AttachEvent(GameEventType.TeamItemLongPress, self.TeamItemLongPress)
  self:AttachEvent(GameEventType.TeamUpdateReplaceCardPos, self.UpdateReplaceCardPos)
end

function UIN33EightPetsTeams:InitCommonTopButton()
  self._backBtns = self._btns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, function()
    UICommonHelper:GetInstance():SwitchToUIMain()
  end, false, nil)
end

function UIN33EightPetsTeams:InitTeamPageBtn()
  self._tglGroupOriginPosX = self._tglGoupTrans.anchoredPosition.x - 1
  self._tglObjectPath:SpawnObjects("UITeamsSelectItem", self._ctx:GetTeamCount())
  self._hlgTglsSpawns = self._tglObjectPath:GetAllSpawnList()
  self._tglScrollView.onValueChanged:AddListener(function()
    local maxScrollDis = self._tglGoupTrans.sizeDelta.x - self._viewPointTrans.rect.width
    if maxScrollDis < 0 then
      local isVisible = 0 < self._tglGoupTrans.anchoredPosition.x
      isVisible = isVisible and math.abs(self._tglGoupTrans.anchoredPosition.x) > math.abs(maxScrollDis)
      self._rightTglGroupArrow:SetActive(isVisible)
    else
      local isVisible = math.abs(self._tglGoupTrans.anchoredPosition.x) < math.abs(maxScrollDis)
      self._rightTglGroupArrow:SetActive(isVisible)
    end
    local isVisible = self._tglGoupTrans.anchoredPosition.x < self._tglGroupOriginPosX
    self._leftTglGroupArrow:SetActive(isVisible)
  end)
  self:TglBtnPosReset()
end

function UIN33EightPetsTeams:TglBtnPosReset()
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tglGoupTrans)
  local select = self._ctx:GetCurrTeamId()
  if self._ctx:GetTeamCount() > 1 then
    local seletbtn = self._hlgTglsSpawns[select]
    local btnRectTrans = seletbtn.view:GetComponent("RectTransform")
    local anchoredPosX = btnRectTrans.anchoredPosition.x
    if anchoredPosX > self._viewPointTrans.rect.width / 2 then
      local maxMove = self._tglGoupTrans.sizeDelta.x - self._viewPointTrans.rect.width
      local move = anchoredPosX - self._viewPointTrans.rect.width / 2
      if maxMove < move then
        move = maxMove
      end
      local originY = self._tglGoupTrans.anchoredPosition.y
      self._tglGoupTrans.anchoredPosition = Vector2(-move, originY)
    end
  end
end

function UIN33EightPetsTeams:InitTeams()
  self._hlgSpawns = self._hlgPath:SpawnObjects("UIN33EightPetsTeamItem", self._widgetCount)
  for k, v in pairs(self._hlgSpawns) do
    v:GetGameObject().name = k - 1
  end
  self:OnLayoutChanged(0)
  for k, v in pairs(self._hlgSpawns) do
    v:InitData(self._atlasProperty, self._atlasAwake, self._atlasProf, function(slot)
      self:OpenTeamMemberSelect(slot)
    end)
  end
  self._replaceCard = self._replaceCardPath:SpawnObject("UIN33EightPetsTeamItem")
  self._replaceCard:InitData(self._atlasProperty, self._atlasAwake, self._atlasProf, function(slot)
    self:OpenTeamMemberSelect(slot)
  end)
end

function UIN33EightPetsTeams:OnLayoutChanged(deltaTimeMS)
  local newLayoutWidth = self._hlgLayout.transform.rect.width
  if self._layoutWidth ~= newLayoutWidth then
    self._layoutWidth = newLayoutWidth
    local padding = self._hlgLayout.padding
    local itemWidth = (newLayoutWidth - padding.right) * 0.5
    local cellSize = self._hlgLayout.cellSize
    cellSize = Vector2(itemWidth, cellSize.y)
    self._hlgLayout.cellSize = cellSize
    self._replaceTran.sizeDelta = cellSize
    UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(self._hlgLayout.transform)
    if self._fightBtnTrans ~= nil then
      local width = self._safeArea.rect.size.x - self._fightBtnTrans.sizeDelta.x + 70
      local height = self._tglScrollViewTrans.sizeDelta.y
      self._tglScrollViewTrans.sizeDelta = Vector2(width, height)
    end
  end
end

function UIN33EightPetsTeams:FlushTeamPageBtn()
  for k, v in pairs(self._hlgTglsSpawns) do
    v:Init(k, self, self._tglGroup, self._tglScrollView)
  end
end

function UIN33EightPetsTeams:FlushTeam(teamId)
  UIN33EightPetsTeamsContext:SetCurrTeamId(teamId)
  self._teams = self._ctx:Teams()
  self._team = self._teams:Get(teamId)
  if self._team == nil then
    return
  end
  for k, v in pairs(self._hlgTglsSpawns) do
    local info = self._teams:Get(k)
    if info ~= nil then
      v:FlushName(info.id)
    end
  end
  for k, v in pairs(self._hlgSpawns) do
    v:FlushPet(k, teamId)
  end
  self.ctid = teamId
end

function UIN33EightPetsTeams:FlushTeamCondition()
  local param = self._ctx:GetParam()
  local eightID = param[4]
  local cfgEight = Cfg.cfg_component_eight_pets_mission[eightID]
  if cfgEight.TeamCondition == nil then
    self._imgCondition.gameObject:SetActive(false)
  else
    self._imgCondition.gameObject:SetActive(true)
    self._txtCondition:SetText(StringTable.Get(cfgEight.TeamCondition))
  end
end

function UIN33EightPetsTeams:InAnimation()
  local lockName = "UIN33EightPetsTeams:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("effanim_UIN33EightPetsTeams_in")
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
end

function UIN33EightPetsTeams:OnActivityCloseEvent(id)
  self:CloseDialog()
end

function UIN33EightPetsTeams:OpenTeamMemberSelect(slot)
  self._ctx:InitTeamMemberSelect(slot)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  self:ShowDialog("UITeamChangeController", nil, nil, nil, false)
end

function UIN33EightPetsTeams:UpdateFormationInfo(newTeam)
  local lockName = "UIN33EightPetsTeams:UpdateFormationInfo"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local teamId = newTeam:GetID()
    local teamName = newTeam:GetName()
    local pets = newTeam:GetPets()
    local res = UIN33EightPetsTeamsContext:UpdateFormationInfoTT(TT, teamId, teamName, pets)
    if res:GetSucc() then
      UIN33EightPetsTeamsContext:UpdateTeam(newTeam)
      self:FlushTeam(teamId)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
    end
    self:UnLock(lockName)
  end)
end

function UIN33EightPetsTeams:TeamItemLongPress(isBegin, slot, petPstID)
  local teamId = self._ctx:GetCurrTeamId()
  if isBegin then
    self._isLongPressing = true
    self._replaceCard:FlushPet(slot, teamId)
    self._replaceCard:HideGuideWarn()
  else
    self._isLongPressing = false
    local WorldToScreenPoint = UnityEngine.RectTransformUtility.WorldToScreenPoint
    local RectangleContainsScreenPoint = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    for i, v in pairs(self._hlgSpawns) do
      local tran = v:GetGameObject().transform
      local screenPos = WorldToScreenPoint(camera, self._replaceTran.position)
      local inSlot = RectangleContainsScreenPoint(tran, screenPos, camera)
      local localPos = tran:InverseTransformPoint(self._replaceTran.position)
      if tran.rect:Contains(localPos) and not v:IsLocked() then
        local team = self._team:Clone()
        team:Swap(slot, i)
        self:UpdateFormationInfo(team)
        break
      end
    end
  end
  self._replaceTran.gameObject:SetActive(self._isLongPressing)
end

function UIN33EightPetsTeams:UpdateReplaceCardPos(screenPos)
  if self._replaceTran ~= nil then
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._replaceTran.parent, screenPos, camera)
    self._replaceTran.position = pos
  end
end

function UIN33EightPetsTeams:CheckTeamValid()
  local team = self._team
  if not team or not team.pets then
    return false
  end
  if table.count(team.pets) <= 0 then
    return false
  end
  local leaderId = team.pets[1]
  if not leaderId then
    return false
  end
  if leaderId == 0 then
    return false
  end
  return true, team
end

function UIN33EightPetsTeams:CheckTeamMemberDuplicate()
  local team = self._team
  if not team or not team.pets then
    return false
  end
  local petModule = self:GetModule(PetModule)
  local dic = {}
  for index, pstId in pairs(team.pets) do
    if 0 < pstId then
      local petData = petModule:GetPet(pstId)
      if petData then
        local tmpId = petData:GetTemplateID()
        if dic[tmpId] == nil then
          dic[tmpId] = 0
        end
        dic[tmpId] = dic[tmpId] + 1
      end
    end
  end
  for k, v in pairs(dic) do
    if 1 < v then
      return false
    end
  end
  return true
end

function UIN33EightPetsTeams:_MatchStart(TT, nMatchType, teamId, createInfo)
  self._matchType = nMatchType
  self._matchTeamId = teamId
  self._matchCreateInfo = createInfo
  self:_OnMatchStart()
end

function UIN33EightPetsTeams:_OnMatchStart()
  self:StartTask(self.StartMatchTask, self, self._matchType, self._matchTeamId, self._matchCreateInfo)
end

function UIN33EightPetsTeams:StartMatchTask(TT, nMatchType, teamId, createInfo)
  local game = GameGlobal.GetModule(GameMatchModule)
  local res = game:StartMatchTask(TT, nMatchType, teamId, createInfo)
  self:UnLock("DoEnterMatch")
  if not res:GetSucc() then
    if GameGlobal.UIStateManager():IsShow("UIAircraftTacticSwitch") then
      GameGlobal.UIStateManager():CloseDialog("UIAircraftTacticSwitch")
    end
    local result = res:GetResult()
    if result == MatchOpResCode.MATCH_NOT_ENOUGH_PHY_POWER then
      self:ShowDialog("UIGetPhyPointController")
    elseif result == MatchOpResCode.MATCH_CAMPAIGN_MISSIOHN_CROSS_DAY then
      ToastManager.ShowToast(game:GetErrorMsg(result))
      if nMatchType == MatchType.MT_BlackFist then
        self:SwitchState(UIStateType.UIBlackFightMain)
      else
        self:SwitchState(UIStateType.UIActivityN5BattleField)
      end
    elseif result == MatchOpResCode.MATCH_WORLD_BOSS_MISSION_INVALID then
      ToastManager.ShowToast(game:GetErrorMsg(result))
      self:SwitchState(UIStateType.UIWorldBoss)
    elseif result == MatchOpResCode.MATCH_DM_FORMATION_INVALID then
      local tips = StringTable.Get("str_diff_mission_MATCH_DM_FORMATION_INVALID")
      ToastManager.ShowToast(tips)
    else
      ToastManager.ShowToast(game:GetErrorMsg(result))
    end
    return
  end
  local serial = GameGlobal.GetModule(SerialAutoFightModule)
  serial:StartSerialFight()
end

_class("UIN33EightPetsTeamItem", UICustomWidget)
UIN33EightPetsTeamItem = UIN33EightPetsTeamItem

function UIN33EightPetsTeamItem:Constructor()
  self._petPstID = 0
end

function UIN33EightPetsTeamItem:OnShow(uiParams)
  self._module = self:GetModule(MissionModule)
  self._ctx = self._module:TeamCtx()
  self:UIWidget()
  self:DefaultVisible()
  self:UIEvents()
end

function UIN33EightPetsTeamItem:OnHide()
  if self._equipLvWidget ~= nil then
    self._equipLvWidget:Dispose()
  end
end

function UIN33EightPetsTeamItem:BtnDetailOnClick(go)
  self._teams = self._ctx:Teams()
  self._team = self._teams:Get(self._teamId)
  self._petPstID = self._team.pets[self._slot]
  local pstids = {}
  local pets = self._team.pets
  for i = 1, #pets do
    local pstid = pets[i]
    if pstid ~= 0 then
      table.insert(pstids, pstid)
    end
  end
  local petModule = self:GetModule(PetModule)
  petModule.uiModule:SetTeamPets(pstids)
  local petid = petModule:GetPet(self._petPstID):GetTemplateID()
  self:ShowDialog("UISpiritDetailGroupController", petid, false)
end

function UIN33EightPetsTeamItem:UIWidget()
  self._petIconLoader = self:GetUIComponent("RawImageLoader", "petIcon")
  self._leader = self:GetUIComponent("RectTransform", "leader")
  self._button = self:GetUIComponent("RectTransform", "button")
  self._widget = self:GetUIComponent("UIView", "widget")
  self._imgAdd = self:GetUIComponent("RectTransform", "imgAdd")
  self._imgGray = self:GetUIComponent("RectTransform", "imgGray")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._career = self._widget:GetUIComponent("Image", "career")
  self._attrMain = self._widget:GetUIComponent("Image", "attrMain")
  self._attrVice = self._widget:GetUIComponent("Image", "attrVice")
  self._petName = self._widget:GetUIComponent("UILocalizationText", "petName")
  self._lvValue = self._widget:GetUIComponent("UILocalizationText", "lvValue")
  self._imgGrade = self._widget:GetUIComponent("Image", "imgGrade")
  self._equipLv = self._widget:GetUIComponent("UISelectObjectPath", "equipLv")
  self._equipLvWidget = nil
  self._stars = {
    self._widget:GetUIComponent("RectTransform", "star1"),
    self._widget:GetUIComponent("RectTransform", "star2"),
    self._widget:GetUIComponent("RectTransform", "star3"),
    self._widget:GetUIComponent("RectTransform", "star4"),
    self._widget:GetUIComponent("RectTransform", "star5"),
    self._widget:GetUIComponent("RectTransform", "star6")
  }
  self._starAwaken = {}
  self._starLock = {}
  for k, v in pairs(self._stars) do
    self._starAwaken[k] = self:GetChildComponent(v, "RectTransform", "starAwaken")
    self._starLock[k] = self:GetChildComponent(v, "RectTransform", "starLock")
  end
  self._warningRoot = self._widget:GetUIComponent("RectTransform", "warning")
  self._txtWarning = self._widget:GetUIComponent("UILocalizationText", "txtWarning")
end

function UIN33EightPetsTeamItem:DefaultVisible()
  self._imgGray.gameObject:SetActive(false)
  self._warningRoot.gameObject:SetActive(false)
end

function UIN33EightPetsTeamItem:UIEvents()
  local function endDragFunc()
    if self._petPstID == 0 then
      return
    end
    self._imgGray.gameObject:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamItemLongPress, false, self._slot, self._petPstID)
  end
  
  local etl = UICustomUIEventListener.Get(self._button.gameObject)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(ped)
    if self._petPstID == 0 or GameGlobal.UIStateManager():IsLocked() then
      return
    end
    self._imgGray.gameObject:SetActive(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamItemLongPress, true, self._slot, self._petPstID)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(ped)
    if self._petPstID == 0 then
      return
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamUpdateReplaceCardPos, ped.position)
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(ped)
    endDragFunc()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    if self._clickCb then
      self._clickCb(self._slot)
    end
  end)
  if not EDITOR then
    self:AddUICustomEventListener(etl, UIEvent.ApplicationFocus, function(b)
      if not b then
        if not etl.IsDragging then
          return
        end
        etl.IsDragging = false
        endDragFunc()
      end
    end)
  end
  self:AttachEvent(GameEventType.PetDataChangeEvent, self.OnPetInfoChanged)
  self:AttachEvent(GameEventType.OnPetSkinChange, self.OnPetInfoChanged)
end

function UIN33EightPetsTeamItem:InitData(atlasProperty, atlasAwake, atlasProf, clickCb)
  self._atlasProperty = atlasProperty
  self._atlasAwake = atlasAwake
  self._atlasProf = atlasProf
  self._clickCb = clickCb
end

function UIN33EightPetsTeamItem:FlushPet(slot, teamId)
  local theFirstIn = self._slot == nil
  local prePetPstID = self._petPstID
  self._slot = slot
  self._teamId = teamId
  self._teams = self._ctx:Teams()
  self._team = self._teams:Get(self._teamId)
  self._petPstID = self._team.pets[self._slot]
  local petModule = self:GetModule(PetModule)
  self._petInfo = petModule:GetPet(self._petPstID)
  self:OnPetInfoChanged()
  if not theFirstIn and prePetPstID ~= self._petPstID and self._petInfo ~= nil then
    self._animation:Play("effanim_UIN33EightPetsTeamItem_in")
  end
end

function UIN33EightPetsTeamItem:OnPetInfoChanged()
  if self._petInfo == nil then
    self._petIconLoader.gameObject:SetActive(false)
    self._leader.gameObject:SetActive(false)
    self._widget.gameObject:SetActive(false)
    self._imgAdd.gameObject:SetActive(true)
  else
    self._petIconLoader.gameObject:SetActive(true)
    self._leader.gameObject:SetActive(self._slot == 1)
    self._widget.gameObject:SetActive(true)
    self._imgAdd.gameObject:SetActive(false)
    self:ShowCareer()
    self:ShowName()
    self:ShowBattleMes()
    self:ShowLevel()
    self:ShowElement()
    self:ShowStarLevel()
    self:ShowGrade()
    self:ShowEquipLv()
    self:CheckGuideWarn()
  end
end

function UIN33EightPetsTeamItem:ShowCareer()
  if self._prof2Img == nil then
    self._prof2Img = {
      [PetProfType.PetProf_Color] = "epg_gqxq_icon08",
      [PetProfType.PetProf_Blood] = "epg_gqxq_icon06",
      [PetProfType.PetProf_Attack] = "epg_gqxq_icon07",
      [PetProfType.PetProf_Function] = "epg_gqxq_icon09"
    }
    self._prof2Name = {
      [PetProfType.PetProf_Color] = "str_pet_tag_job_name_color_change_1",
      [PetProfType.PetProf_Blood] = "str_pet_tag_job_name_return_blood_1",
      [PetProfType.PetProf_Attack] = "str_pet_tag_job_name_attack_1",
      [PetProfType.PetProf_Function] = "str_pet_tag_job_name_function_1"
    }
  end
  local prof = self._petInfo:GetProf()
  local spriteName = self._prof2Img[prof]
  self._career.sprite = self._atlasProf:GetSprite(spriteName)
end

function UIN33EightPetsTeamItem:ShowName()
  self._petName:SetText(StringTable.Get(self._petInfo:GetPetName()))
end

function UIN33EightPetsTeamItem:ShowBattleMes()
  local tid = self._petInfo:GetTemplateID()
  local grade = self._petInfo:GetPetGrade()
  local skinId = self._petInfo:GetSkinId()
  local path = PetSkinEffectPath.CARD_TEAM
  local hpProxy = HelperProxy:GetInstance()
  local nameBattleMes = hpProxy:GetPetBattleMes(tid, grade, skinId, path)
  self._petIconLoader:LoadImage(nameBattleMes)
end

function UIN33EightPetsTeamItem:ShowLevel()
  local petLevel = self._petInfo:GetPetLevel()
  self._lvValue:SetText(StringTable.Get("str_common_LV_dot_en") .. " " .. petLevel)
end

function UIN33EightPetsTeamItem:ShowElement()
  local cfg_pet_element = Cfg.cfg_pet_element({})
  if cfg_pet_element == nil then
    self._attrMain.gameObject:SetActive(false)
    self._attrVice.gameObject:SetActive(false)
    return
  end
  local v1stSprite, v2ndSprite
  local v1stElement = self._petInfo:GetPetFirstElement()
  local v2ndElement = self._petInfo:GetPetSecondElement()
  if v1stElement ~= nil then
    local spriteName = UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[v1stElement].Icon)
    v1stSprite = self._atlasProperty:GetSprite(spriteName)
  end
  if v2ndElement ~= nil then
    local spriteName = UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[v2ndElement].Icon)
    v2ndSprite = self._atlasProperty:GetSprite(spriteName)
  end
  if v1stSprite ~= nil then
    self._attrMain.gameObject:SetActive(false)
    self._attrVice.gameObject:SetActive(true)
    self._attrVice.sprite = v1stSprite
  end
  if v2ndSprite ~= nil then
    self._attrMain.gameObject:SetActive(true)
    self._attrMain.sprite = v1stSprite
    self._attrVice.sprite = v2ndSprite
  end
end

function UIN33EightPetsTeamItem:ShowStarLevel()
  local petStar = self._petInfo:GetPetStar()
  local awakenStep = self._petInfo:GetPetAwakening()
  local awakenLock = self._petInfo:GetAwakeMatch()
  local maxStarLevel = #self._stars
  for starLevel = 1, maxStarLevel do
    local starGo = self._stars[starLevel].gameObject
    if starLevel <= petStar then
      starGo:SetActive(true)
    else
      starGo:SetActive(false)
    end
    local starGo = self._starAwaken[starLevel].gameObject
    local starLockGo = self._starLock[starLevel].gameObject
    if starLevel <= awakenLock then
      starGo:SetActive(true)
      starLockGo:SetActive(false)
    elseif starLevel <= awakenStep then
      starGo:SetActive(false)
      starLockGo:SetActive(true)
    else
      starGo:SetActive(false)
      starLockGo:SetActive(false)
    end
  end
end

function UIN33EightPetsTeamItem:ShowGrade()
  local petId = self._petInfo:GetTemplateID()
  local petGradeLevel = self._petInfo:GetPetGrade()
  self._imgGrade.sprite = self._atlasAwake:GetSprite(UIPetModule.GetAwakeSpriteName(petId, petGradeLevel))
end

function UIN33EightPetsTeamItem:ShowEquipLv()
  if self._equipLvWidget == nil then
    self._equipLvWidget = UICustomWidgetPool:New(self:RootUIOwner(), self._equipLv)
  end
  local obj = self._equipLvWidget:SpawnObject("UIPetEquipLvIcon")
  obj:SetData(self._petInfo, true)
end

function UIN33EightPetsTeamItem:CheckGuideWarn()
  self._warningRoot.gameObject:SetActive(false)
  local missionModule = self:GetModule(MissionModule)
  local needMissionId = Cfg.cfg_guide_const.guide_team_mission.IntValue
  if not missionModule:IsPassMissionID(needMissionId) then
    return
  end
  local curNeedLevel = 0
  local needGradeLevel = 0
  local teamOpenerType = self._ctx:GetTeamOpenerType()
  local param = self._ctx:GetParam()
  if teamOpenerType == TeamOpenerType.EightPets then
    local id = param[1]
    if param[4] and type(param[4]) == "table" and param[4][1] then
      curNeedLevel = param[4][2] or 0
      needGradeLevel = param[4][3] or 0
    else
      local cfg = Cfg.cfg_eight_pets_mission[id]
      curNeedLevel = cfg and cfg.RecommendLV or 0
      needGradeLevel = cfg and cfg.RecommendAwaken or 0
    end
  else
    return
  end
  local petLevel = self._petInfo:GetPetLevel()
  local gradeLevel = self._petInfo:GetPetGrade()
  local minLevel = Cfg.cfg_guide_const.guide_team_min.IntValue
  local maxLevel = Cfg.cfg_guide_const.guide_team_max.IntValue
  local showWarning = gradeLevel == needGradeLevel and petLevel < curNeedLevel - minLevel
  showWarning = showWarning or needGradeLevel > gradeLevel
  if showWarning then
    self._warningRoot.gameObject:SetActive(showWarning)
    self._txtWarning:SetText(StringTable.Get("str_guide_warn_level_speed"))
  end
end

function UIN33EightPetsTeamItem:HideGuideWarn()
  self._warningRoot.gameObject:SetActive(false)
end

function UIN33EightPetsTeamItem:IsLocked()
  return false
end
