_class("UISeasonMazePetsTeamsPrimary", UIController)
UISeasonMazePetsTeamsPrimary = UISeasonMazePetsTeamsPrimary

function UISeasonMazePetsTeamsPrimary:Constructor()
  self._widgetCount = 8
  self._layoutWidth = 0
  self._isLongPressing = false
  self._lastClickTime = 0
  self._primaryMap = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0
  }
  self._primaryCount = 4
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._uiSeasonMazeModule = self._seasonMazeModule.uiModule
  self._allPets = self._uiSeasonMazeModule:GetSeasonMazeCfgPets()
  self._seasonObj = self._seasonMazeModule:CurSeasonObj()
  self._com = self._seasonObj:GetMazeComponent()
  self._dialLine2Hp = Cfg.cfg_global.UIWidgetBattlePet_dialLine2Hp.IntValue or 200
  self._bigDiaLine = Cfg.cfg_global.UIWidgetBattlePet_bigDiaLine.IntValue or 5
end

function UISeasonMazePetsTeamsPrimary:LoadDataOnEnter(TT, res, uiParams)
  self._module = self:GetModule(MissionModule)
  self._ctx = self._module:TeamCtx()
end

function UISeasonMazePetsTeamsPrimary:OnShow(uiParams)
  self:UnLock("DoEnterEightPetsTeam")
  self._diff = uiParams[1]
  self._missionID = uiParams[2]
  self:UIWidget()
  self:DefaultVisible()
  self:AddEvents()
  self:InitCommonTopButton()
  self:InitTeams()
  self:FlushTeam()
  self:SetTeamRecommendArea(self._missionID)
  self:InitRollingTips()
  self:InAnimation()
end

function UISeasonMazePetsTeamsPrimary:OnHide()
  if self._ctx:IsFastSelect() then
    self._ctx:ClearFastSelect()
  end
  self:GetModule(PetModule):ClearAllPetSortInfo()
end

function UISeasonMazePetsTeamsPrimary:OnUpdate(deltaTimeMS)
  self:OnLayoutChanged(deltaTimeMS)
end

function UISeasonMazePetsTeamsPrimary:BtnClearOnClick(go)
  local havePet = false
  for k, v in pairs(self._primaryMap) do
    if v and 0 < v then
      havePet = true
      break
    end
  end
  if not havePet then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_discovery_clear_all_pet_or_not"), function(param)
    self._primaryMap = {
      [1] = 0,
      [2] = 0,
      [3] = 0,
      [4] = 0
    }
    self:FlushTeam()
  end, nil, function(param)
  end, nil)
end

function UISeasonMazePetsTeamsPrimary:BtnFastTeamOnClick(go)
  if self._ctx then
    self._ctx:InitTeamFastSelect()
  end
  local allPets = self._uiSeasonMazeModule:GetSeasonMazeCfgPets()
  self:ShowDialog("UISeasonMazeTeamChangeControllerPrimary", allPets, function(petList)
    if petList and next(petList) then
      for index, value in ipairs(petList) do
        self._primaryMap[index] = value
      end
    else
      self._primaryMap = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0
      }
    end
    self:FlushTeam()
  end, nil, true, self._primaryMap, self._allPets)
end

function UISeasonMazePetsTeamsPrimary:BtnFightOnClick(go)
  for key, value in pairs(self._primaryMap) do
    if value == 0 then
      ToastManager.ShowToast(StringTable.Get("str_season_maze_team_primary_count_limit"))
      return
    end
  end
  self:Lock("UISeasonMazePetsTeamsPrimary:BtnFightOnClick")
  GameGlobal.TaskManager():StartTask(self.OnBtnFightOnClick, self)
end

function UISeasonMazePetsTeamsPrimary:OnBtnFightOnClick(TT)
  local res = AsyncRequestRes:New()
  local petList = {}
  for key, value in ipairs(self._primaryMap) do
    table.insert(petList, value)
  end
  self._com:HandleSeasonMazeSelectHard(TT, res, self._diff, petList)
  self:UnLock("UISeasonMazePetsTeamsPrimary:BtnFightOnClick")
  if res:GetSucc() then
    LocalDB.SetInt("UISeasonMazeEnterController_Enter_Game_New", 1)
    self._uiSeasonMazeModule:Enter()
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazePetsTeamsPrimary] HandleSeasonMazeSelectHard fail ! result:", result)
    GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res)
  end
end

function UISeasonMazePetsTeamsPrimary:UIWidget()
  self._btns = self:GetUIComponent("UISelectObjectPath", "btns")
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
  self._uiSeasonMazeAtlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._primaryTips = self:GetGameObject("primaryTips")
  if self._primaryTips then
    self._primaryTips:SetActive(false)
  end
  self._primaryRollingTipsGo = self:GetGameObject("primaryRollingTips")
  self._primaryRollingTipsText = self:GetUIComponent("UILocalizationText", "primaryRollingTipsText")
  if self._primaryRollingTipsGo then
    self._primaryRollingTipsGo:SetActive(true)
  end
  self.teamRecommendGo = self:GetGameObject("TeamRecommend")
  self.teamRecommendGen = self:GetUIComponent("UISelectObjectPath", "TeamRecommend")
  self._diaSp1 = self._uiSeasonMazeAtlas:GetSprite("cn14_sjmj_zdf_di017")
  self._diaSp2 = self._uiSeasonMazeAtlas:GetSprite("cn14_sjmj_zdf_di016")
end

function UISeasonMazePetsTeamsPrimary:GetHpCfg()
  return self._dialLine2Hp, self._bigDiaLine, self._diaSp1, self._diaSp2
end

function UISeasonMazePetsTeamsPrimary:DefaultVisible()
  self._replaceTran.gameObject:SetActive(false)
end

function UISeasonMazePetsTeamsPrimary:AddEvents()
  self:AttachEvent(GameEventType.TeamItemLongPress, self.TeamItemLongPress)
  self:AttachEvent(GameEventType.TeamUpdateReplaceCardPos, self.UpdateReplaceCardPos)
end

function UISeasonMazePetsTeamsPrimary:InitCommonTopButton()
  self._backBtns = self._btns:SpawnObject("UISMazeCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp3, 3)
  end, function()
    UICommonHelper:GetInstance():SwitchToUIMain()
  end, false, nil)
end

function UISeasonMazePetsTeamsPrimary:InitTeams()
  self._hlgSpawns = self._hlgPath:SpawnObjects("UISeasonMazePetsTeamsItem", self._widgetCount)
  for k, v in pairs(self._hlgSpawns) do
    v:GetGameObject().name = k - 1
  end
  self:OnLayoutChanged(0)
  for k, v in pairs(self._hlgSpawns) do
    v:InitData(self._atlasProperty, self._atlasAwake, self._atlasProf, function(slot)
      self:OpenTeamMemberSelect(slot)
    end, function()
      local petList = {}
      for key, value in ipairs(self._primaryMap) do
        local pet = self._allPets[value]
        if pet then
          table.insert(petList, pet)
        end
      end
      return petList
    end, function()
      return self:GetHpCfg()
    end, true)
  end
  self._replaceCard = self._replaceCardPath:SpawnObject("UISeasonMazePetsTeamsItem")
  self._replaceCard:InitData(self._atlasProperty, self._atlasAwake, self._atlasProf, function(slot)
    self:OpenTeamMemberSelect(slot)
  end, function()
    local petList = {}
    for key, value in ipairs(self._primaryMap) do
      local pet = self._allPets[value]
      if pet then
        table.insert(petList, pet)
      end
    end
    return petList
  end, function()
    return self:GetHpCfg()
  end, true)
end

function UISeasonMazePetsTeamsPrimary:OnLayoutChanged(deltaTimeMS)
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
  end
end

function UISeasonMazePetsTeamsPrimary:FlushTeam()
  for k, v in ipairs(self._hlgSpawns) do
    local lock = false
    local pet
    if self._primaryMap[k] and self._primaryMap[k] > 0 then
      pet = self._allPets[self._primaryMap[k]]
    end
    if k > self._primaryCount then
      lock = true
    end
    v:FlushPet(k, pet, lock)
  end
end

function UISeasonMazePetsTeamsPrimary:InAnimation()
  local lockName = "UISeasonMazePetsTeamsPrimary:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("effanim_UISeasonMazePetsTeamsPrimary_in")
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
end

function UISeasonMazePetsTeamsPrimary:OnActivityCloseEvent(id)
  self:CloseDialog()
end

function UISeasonMazePetsTeamsPrimary:OpenTeamMemberSelect(slot)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  local openList = {}
  for key, value in pairs(self._allPets) do
    local pstid = value:GetPstID()
    if table.icontains(self._primaryMap, pstid) then
    else
      openList[key] = value
    end
  end
  local openPet
  if self._primaryMap[slot] > 0 then
    openPet = self._allPets[self._primaryMap[slot]]
    openList[self._primaryMap[slot]] = openPet
  end
  if self._ctx then
    self._ctx:ClearFastSelect()
  end
  self:ShowDialog("UISeasonMazeTeamChangeControllerPrimary", openList, function(pstid, del)
    if del then
      self._primaryMap[slot] = 0
    else
      local removeSp
      local pet = self._allPets[pstid]
      for i, v in ipairs(self._primaryMap) do
        if v and 0 < v and slot ~= i then
          local isSp = pet:IsBinderPet(v)
          if isSp then
            self._primaryMap[i] = 0
            removeSp = v
          end
        end
      end
      if removeSp then
        local peta = self._allPets[removeSp]
        local petb = self._allPets[pstid]
        local namea = StringTable.Get(peta:GetPetName())
        local nameb = StringTable.Get(petb:GetPetName())
        local tips = StringTable.Get("str_team_change_binder_toast_tips", nameb, namea)
        ToastManager.ShowToast(tips)
      end
      self._primaryMap[slot] = pstid
    end
    self:FlushTeam()
  end, openPet, false, self._primaryMap, self._allPets)
end

function UISeasonMazePetsTeamsPrimary:TeamItemLongPress(isBegin, slot, pet)
  if isBegin then
    self._isLongPressing = true
    self._replaceCard:FlushPet(slot, pet, false)
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
      if tran.rect:Contains(localPos) and not v:IsLocked() and i <= self._primaryCount then
        local tmp = self._primaryMap[slot]
        local tmp2 = self._primaryMap[i]
        self._primaryMap[slot] = tmp2
        self._primaryMap[i] = tmp
        self:FlushTeam()
        break
      end
    end
  end
  self._replaceTran.gameObject:SetActive(self._isLongPressing)
end

function UISeasonMazePetsTeamsPrimary:UpdateReplaceCardPos(screenPos)
  if self._replaceTran ~= nil then
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._replaceTran.parent, screenPos, camera)
    self._replaceTran.position = pos
  end
end

function UISeasonMazePetsTeamsPrimary:SetTeamRecommendArea(missionID)
  if missionID and 0 < missionID then
    if self.teamRecommendGo then
      self.teamRecommendGo:SetActive(true)
    end
    if not self._teamRecommendWidget and self.teamRecommendGen then
      self._teamRecommendWidget = self.teamRecommendGen:SpawnObject("UISeasonMazeTeamRecommend")
    end
    if self._teamRecommendWidget then
      self._teamRecommendWidget:SetData(missionID)
    end
  elseif self.teamRecommendGo then
    self.teamRecommendGo:SetActive(false)
  end
end

function UISeasonMazePetsTeamsPrimary:InitRollingTips()
  if self._primaryRollingTipsText then
    local str = StringTable.Get("str_season_maze_init_team_tips")
    self._primaryRollingTipsText:SetText(str)
  end
end
