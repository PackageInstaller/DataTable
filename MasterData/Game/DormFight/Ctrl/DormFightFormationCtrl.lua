local base = require("Game.Formation.Ctrl.FormationCtrlBase")
local DormFightFormationCtrl = class("DormFightFormationCtrl", base)
local util = require("XLua.Common.xlua_util")
local FmtPlatformEntity = require("Game.Formation.Entity.FmtPlatformEntity")
local FmtEnum = require("Game.Formation.FmtEnum")
local FmtHeroEntity = require("Game.Formation.Entity.FmtHeroEntity")
local DormFightFormationData = require("Game.DormFight.Data.DormFightFormationData")
local CS_Input = CS.UnityEngine.Input
local CS_ResLoader = CS.ResLoader
local CS_Camera = CS.UnityEngine.Camera
local CS_GameObject = CS.UnityEngine.GameObject
local CS_Shader = CS.UnityEngine.Shader
local CS_Physics = CS.PhysicsUtility
local CS_InputUtility = CS.InputUtility
local DragPosOffset = Vector3.New(0, 0.3, -0.3)
local FmtGroundCollider = "FmtGroundCollider"
local FmtWallCollider = "FmtWallCollider"

function DormFightFormationCtrl:ctor(ctrl)
  self.dormFightCtrl = ctrl
  self.heroEntityDic = {}
  self.heroEntityIdDic = {}
  self.formationHeroData = {}
  self.__fmtData = nil
  self._fmtIsChange = false
  self.__OnClickPlatform = BindCallback(self, self.OnClickPlatform)
  self.__OnBeginDrag = BindCallback(self, self.OnBeginDrag)
  self.__OnDrag = BindCallback(self, self.OnDrag)
  self.__OnEndDrag = BindCallback(self, self.OnEndDrag)
end

function DormFightFormationCtrl:EnterDormFightFormation(roomType, endTime)
  self._fmtIsChange = false
  self.__mainCam = UIManager:GetMainCamera()
  self.__lightMain = CS_GameObject.FindWithTag(TagConsts.MainLight)
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.normal
  self.endTime = endTime
  self:GenDfFormationData()
  local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWindow ~= nil then
    homeWindow:OpenOtherWin()
  end
  self.__initCoroutine = GR.StartCoroutine(util.cs_generator(BindCallback(self, self.__LoadDormFightFormation)))
end

function DormFightFormationCtrl:__LoadDormFightFormation()
  UIUtil.AddOneCover("LoadDormFightFormation", SafePack(nil, nil, nil, Color.clear, false))
  self:OnEnterFormationScene()
  local path = PathConsts:GetFormationModelPath("DormFightFormation")
  if self.resLoader == nil then
    self.resLoader = CS_ResLoader.Create()
  end
  local sceneWait = self.resLoader:LoadABAssetAsyncAwait(path)
  coroutine.yield(sceneWait)
  local go = sceneWait.Result:Instantiate()
  self:InitDormFightFormationCtrl(go)
  local currentScene = LuaSceneManager:GetCurrentScene()
  local sceneName
  if currentScene ~= nil then
    sceneName = currentScene.name
  end
  if sceneName == Consts.SceneName.Main then
    local skyGameObject = CS.UnityEngine.GameObject.Find("WeatherSystem")
    skyGameObject:SetActive(false)
    
    function self.exitFunc()
      skyGameObject:SetActive(true)
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.DormFightFormation, function(window)
    if window ~= nil then
      local hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true,
        [UIWindowTypeID.DormFightFormation] = true
      })
      local jumpCorverArgs = {hideWinList = hideWinList}
      window:SetFromWhichUI(eBaseWinFromWhere.jumpCorver)
      window.jumpCorverArgs = jumpCorverArgs
      window:InitUIDormFightFormation(self)
      self.dormFightFormationUI = window
      UIUtil.CloseOneCover("LoadDormFightFormation")
    end
  end)
  self:RefreshFmtScene(true)
  while self.dormFightFormationUI == nil do
    coroutine.yield(nil)
  end
  local customLight
  if not IsNull(self.__camMain) then
    customLight = self.__camMain:GetComponent(typeof(CS.CustomLight))
  end
  if IsNull(customLight) then
    customLight = CS_Camera.main:GetComponent(typeof(CS.CustomLight))
  end
  if not IsNull(customLight) then
    CS_Shader.SetGlobalColor(self._GlobalCharColorHash, customLight.CharacterGlobalColor)
    customLight:RefreshCharacterShadow()
    customLight:RefreshCharacterOutline()
  end
end

function DormFightFormationCtrl:InitDormFightFormationCtrl(go)
  self.gameObject = go
  self.transform = go.transform
  self.bind = {}
  UIUtil.LuaUIBindingTable(self.transform, self.bind)
  local screenWidth = CS.UnityEngine.Screen.width
  self.__screenWidthRange = Vector2.New(self.bind.screenWidthOffset, screenWidth - self.bind.screenWidthOffset)
  local halfScreenHeight = CS.UnityEngine.Screen.height / 2
  self.__screenHeightRange = Vector2.New(halfScreenHeight * self.bind.screenHeightOffset.x, halfScreenHeight * self.bind.screenHeightOffset.y)
  self.bind.platformSelectEffect:SetActive(false)
  self.platformEntityDic = {}
  self.platformEntityGoDic = {}
  self.platform3dUIDic = {}
  local fmtIndex = 0
  for idx, go in ipairs(self.bind.platform) do
    fmtIndex = fmtIndex + 1
    local entity = FmtPlatformEntity.New()
    entity:InitFmtPlatEntity(go, fmtIndex, self, self.__OnClickPlatform, false, true)
    entity:SetFmtPlatformDragEvent(self.__OnBeginDrag, self.__OnDrag, self.__OnEndDrag)
    self.platformEntityDic[fmtIndex] = entity
    self.platformEntityGoDic[go] = entity
    self.platform3dUIDic[idx] = {}
    UIUtil.LuaUIBindingTable(self.bind.platform3dUI[idx], self.platform3dUIDic[idx])
    if self.__platformPosY == nil then
      self.__platformPosY = go.transform.position.y
      self.__platformPosZ = go.transform.position.z
    end
  end
end

function DormFightFormationCtrl:ExitDormFightFormation()
  if self._fmtIsChange then
    self:SaveDfFormationData()
  end
  if self.exitFunc ~= nil then
    self.exitFunc()
  end
  self.dormFightFormationUI:Delete()
  self:Delete()
  self:OnLeaveFormationScene()
  UIUtil.SetGlobalHideTopStatus(false)
  UIUtil.SetGlobalIsBlockEsc(false)
end

function DormFightFormationCtrl:OnLeaveFormationScene()
  self:EnableMainCamAndLight(true)
  CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen
end

function DormFightFormationCtrl:GetResloader()
  return self.resLoader
end

function DormFightFormationCtrl:GetHeroEntity(fmtIndex)
  return self.heroEntityDic[fmtIndex]
end

function DormFightFormationCtrl:GetFmtPlatformEntityByGo(gameObject)
  return self.platformEntityGoDic[gameObject]
end

function DormFightFormationCtrl:GetDfFormationData()
  return self.__dfFmtData
end

function DormFightFormationCtrl:GenDfFormationData()
  self.__dfFmtData = self:ReadDfFormationData()
end

function DormFightFormationCtrl:Getplatform3dUIByIndex(index)
  return self.platform3dUIDic[index]
end

function DormFightFormationCtrl:GetEndTime()
  return self.endTime
end

function DormFightFormationCtrl:GetSelectedFighterCount()
  local count = 0
  local formationData = self:GetDfFormationData()
  local formationHeroDic = formationData:GetFormationHeroDic()
  for formatindex, heroId in pairs(formationHeroDic) do
    if heroId ~= nil then
      count = count + 1
    end
  end
  return count
end

function DormFightFormationCtrl:GetMaxFighterCount()
  return 3
end

function DormFightFormationCtrl:ReadDfFormationData()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local data = saveUserData:GetDormFightFormationData()
  local dormFightFormationData = DormFightFormationData.Create()
  if data ~= nil then
    dormFightFormationData.data = data
  end
  return dormFightFormationData
end

function DormFightFormationCtrl:SaveDfFormationData()
  local dormFightFormationData = self:GetDfFormationData()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetDormFightFormationData(dormFightFormationData)
  PersistentManager:SaveModelData(PersistentConfig.ePackage.UserData)
end

function DormFightFormationCtrl:GetFormationHeroData(index)
  local heroIdList = self:GetFormationHeroDic()
  if heroIdList == nil then
    return
  end
  local heroId = heroIdList[index]
  if heroId == nil then
    return
  end
  return PlayerDataCenter:GetHeroData(heroId)
end

function DormFightFormationCtrl:GetFormationHeroDic()
  if self.__dfFmtData ~= nil then
    return self.__dfFmtData.data
  end
end

function DormFightFormationCtrl:GetOnDragCardHeroData()
  return self.dragingCardHeroData
end

function DormFightFormationCtrl:SetHero2Formation(index, heroId)
  local dormFightFormationData = self:GetDfFormationData()
  dormFightFormationData:SetHero2Formation(index, heroId)
end

function DormFightFormationCtrl:RefreshFmtScene(forceAnim)
  local newHeroEntityIdDic = {}
  for index, heroId in pairs(self:GetFormationHeroDic()) do
    local heroEntity = self.heroEntityIdDic[heroId]
    if heroEntity ~= nil then
      local heroData = self:GetFormationHeroData(index)
      if heroData == heroEntity.heroData then
        heroEntity:UpdateFmtHeroEntityHeadInfo()
        newHeroEntityIdDic[heroId] = heroEntity
        self.heroEntityIdDic[heroId] = nil
      end
    end
  end
  for k, heroEntity in pairs(self.heroEntityIdDic) do
    heroEntity:OnDelete()
  end
  self.heroEntityIdDic = newHeroEntityIdDic
  self.__loadHeroCo = nil
  self.heroEntityDic = {}
  for index, heroId in pairs(self:GetFormationHeroDic()) do
    local heroData = self:GetFormationHeroData(index)
    if heroData ~= nil then
      local platformEntity = self.platformEntityDic[index]
      platformEntity:ShowFmtPlatform(true)
      local heroEntity = self:__CreateHeroEntity(heroData, platformEntity.transform.position, forceAnim)
      self.heroEntityDic[index] = heroEntity
    end
  end
  self:Refresh3dUI()
end

function DormFightFormationCtrl:FmtCtrlOnStartDraggingCard(heroData)
  if self.__fmtCtrlState ~= FmtEnum.FmtCtrlSate.editing then
    error("fmtCtrl state error: not editing state")
    return
  end
  self.dragingCardHeroData = heroData
end

function DormFightFormationCtrl:FmtCtrlOnEndDraggingCard()
  self.dragingCardHeroData = nil
end

function DormFightFormationCtrl:OnCurrentFmtChanged()
  self._fmtIsChange = true
  self:Refresh3dUI()
end

function DormFightFormationCtrl:ConfirmHeroPutPlatform(heroData)
  local targetPlatform = self._lastSeekHeroPlat
  self:RecoverHeroPutPlatform()
  if targetPlatform == nil then
    return false
  end
  local index
  for k, v in pairs(self.platformEntityDic) do
    if v == targetPlatform then
      index = k
      break
    end
  end
  for formatindex, heroId in pairs(self:GetFormationHeroDic()) do
    if heroId == heroData.dataId and formatindex ~= index then
      index = formatindex
      targetPlatform = self.platformEntityDic[index]
      break
    end
  end
  if index == nil then
    return false
  end
  local heroEntity = self.heroEntityDic[index]
  local beReplaceHeroData = heroEntity ~= nil and heroEntity:GetFmtHeroEntityData() or nil
  self:SetHero2Formation(index, heroData.dataId)
  if beReplaceHeroData ~= nil then
    self.heroEntityIdDic[beReplaceHeroData.dataId] = nil
    heroEntity:OnDelete()
  end
  targetPlatform:ShowFmtPlatform(true)
  heroEntity = self:__CreateHeroEntity(heroData, targetPlatform.transform.position, true)
  self.heroEntityDic[index] = heroEntity
  self.heroEntityIdDic[heroData.dataId] = heroEntity
  return true, beReplaceHeroData
end

function DormFightFormationCtrl:SeekHeroPutPlatform()
  local newPos = self:__GetGroundPoint()
  newPos = newPos + DragPosOffset
  local targetPlatform = self:__GetTargetPlatform(newPos)
  local dragCardHeroData = self:GetOnDragCardHeroData()
  for fmtIndex, _ in ipairs(self.bind.platform) do
    if self.heroEntityDic[fmtIndex] ~= nil and self.heroEntityDic[fmtIndex]:GetFmtHeroEntityData().dataId == dragCardHeroData.dataId and self.platformEntityDic[fmtIndex]:IsFmtPlatformUnlock() then
      targetPlatform = self.platformEntityDic[fmtIndex]
      break
    end
  end
  if targetPlatform ~= nil then
    self.bind.platformSelectEffect:SetActive(true)
    self.bind.platformSelectEffect.transform.localPosition = targetPlatform.gameObject.transform.localPosition
  else
    self.bind.platformSelectEffect:SetActive(false)
  end
  self._lastSeekHeroPlat = targetPlatform
end

function DormFightFormationCtrl:RecoverHeroPutPlatform()
  self.bind.platformSelectEffect:SetActive(false)
  self._lastSeekHeroPlat = nil
end

function DormFightFormationCtrl:RegisterPullFormationDragAct(onDragAct, pullFormatonDealAct)
  self.__OnpullFormationDrag = onDragAct
  self.__OnpullFormatonDeal = pullFormatonDealAct
end

function DormFightFormationCtrl:PullFormationDrag(touchPos)
  if self.__OnpullFormationDrag ~= nil then
    return self.__OnpullFormationDrag(touchPos)
  end
  return false
end

function DormFightFormationCtrl:PullFormationEnd(touchPos, heroEntity)
  if heroEntity == nil then
    return false
  end
  if self.__OnpullFormatonDeal == nil or self.__OnpullFormationDrag == nil then
    return false
  end
  local isPull = self.__OnpullFormationDrag(touchPos)
  if isPull then
    local index
    for k, v in pairs(self.heroEntityDic) do
      if v == heroEntity then
        index = k
        break
      end
    end
    if index ~= nil then
      local heroData = heroEntity:GetFmtHeroEntityData()
      self:SetHero2Formation(index, nil)
      self.heroEntityDic[index] = nil
      self.heroEntityIdDic[heroData.dataId] = nil
      heroEntity:OnDelete()
      self.__OnpullFormatonDeal(heroEntity:GetFmtHeroEntityData())
      return true
    end
  end
  self.__OnpullFormatonDeal(nil)
  return false
end

function DormFightFormationCtrl:ClearFmtInEditorModel()
  if not self:IsFmtCtrlInEditState() then
    return
  end
  for idx, heroEntity in pairs(self.heroEntityDic) do
    heroEntity:OnDelete()
    self.heroEntityIdDic[heroEntity.heroData.dataId] = nil
    self.heroEntityDic[idx] = nil
  end
  local formationData = self:GetDfFormationData()
  formationData:CleanFormation()
  self:OnCurrentFmtChanged()
end

function DormFightFormationCtrl:SwapFmtPlatformHero(fromFmtIndex, toFmtIndex)
  local heroDic = self.heroEntityDic
  heroDic[fromFmtIndex], heroDic[toFmtIndex] = heroDic[toFmtIndex], heroDic[fromFmtIndex]
  local dormFightFormationData = self:GetDfFormationData()
  dormFightFormationData:Exchange2Hero(fromFmtIndex, toFmtIndex)
  self:OnCurrentFmtChanged()
end

function DormFightFormationCtrl:__CreateHeroEntity(heroData, position, forceAnim)
  local heroEntity = self.heroEntityIdDic[heroData.dataId]
  local coFunc
  if heroEntity == nil then
    local go = CS_GameObject(tostring(heroData.dataId))
    go.transform:SetParent(self.bind.characters)
    heroEntity = FmtHeroEntity.New(self.fmtCtrl, self.enterFmtData)
    coFunc = heroEntity:InitFmtHeroEntity(go, heroData, self.bind.camera)
    self.heroEntityIdDic[heroData.dataId] = heroEntity
  elseif forceAnim then
    heroEntity.gameObject:SetActive(false)
    
    function coFunc()
      if not IsNull(heroEntity.gameObject) then
        heroEntity.gameObject:SetActive(true)
        return heroEntity
      end
    end
  end
  heroEntity:SetFmtHeroEntityPos(position)
  if self.__loadHeroCoFuncList == nil then
    self.__loadHeroCoFuncList = {}
  end
  table.insert(self.__loadHeroCoFuncList, coFunc)
  if self.__loadHeroCo == nil then
    local function loadHeroListFunc()
      coroutine.yield(nil)
      
      while #self.__loadHeroCoFuncList > 0 do
        local coFunc = table.remove(self.__loadHeroCoFuncList, 1)
        local loadHeroEntity = coFunc()
        coroutine.yield(nil)
      end
      self.__loadHeroCo = nil
    end
    
    self.__loadHeroCo = GR.StartCoroutine(util.cs_generator(loadHeroListFunc))
  end
  return heroEntity
end

function DormFightFormationCtrl:OnEnterFormationScene()
  UIUtil.SetGlobalHideTopStatus(true)
  UIUtil.SetGlobalIsBlockEsc(true)
  self:EnableMainCamAndLight(false)
  self.__multiTouchEnabledBeforeOpen = CS_Input.multiTouchEnabled
  CS_Input.multiTouchEnabled = false
end

function DormFightFormationCtrl:OnLeaveFormationScene()
  self:EnableMainCamAndLight(true)
  CS_Input.multiTouchEnabled = self.__multiTouchEnabledBeforeOpen
end

function DormFightFormationCtrl:EnableMainCamAndLight(enable)
  if not IsNull(self.__mainCam) then
    self.__mainCam.gameObject:SetActive(enable)
  end
  if not IsNull(self.__lightMain) then
    self.__lightMain:SetActive(enable)
  end
end

function DormFightFormationCtrl:IsFmtCtrlInEditState()
  return self.__fmtCtrlState == FmtEnum.FmtCtrlSate.editing
end

function DormFightFormationCtrl:EnterEditSate()
  if self.__fmtCtrlState == FmtEnum.FmtCtrlSate.editing then
    return
  end
  if self.__fmtCtrlState ~= FmtEnum.FmtCtrlSate.normal then
    error("fmtCtrl state error: not normal state when enter EditSate")
    return
  end
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.editing
  UIUtil.AddOneCover("DormFightEnterEditSate", SafePack(nil, nil, nil, Color.clear, false))
  self.dormFightFormationUI:EnterEditorMode()
  self:PlayTimeLine(function()
    UIUtil.CloseOneCover("DormFightEnterEditSate")
  end)
end

function DormFightFormationCtrl:ExitEditSate()
  if self.__fmtCtrlState ~= FmtEnum.FmtCtrlSate.editing then
    error("DormFightFormationCtrl state error: not editing state when Exit EditSate")
    return
  end
  self.__fmtCtrlState = FmtEnum.FmtCtrlSate.normal
  UIUtil.AddOneCover("DormFightFormationCtrlExitEditSate", SafePack(nil, nil, nil, Color.clear, false))
  self.dormFightFormationUI:ExitEditorMode()
  self:RewindTimeLine(function()
    UIUtil.CloseOneCover("DormFightFormationCtrlExitEditSate")
  end)
end

function DormFightFormationCtrl:OtherSelectReady()
  if isGameDev then
    print("对方选人")
  end
  if self.dormFightFormationUI ~= nil then
    self.dormFightFormationUI:OnOtherSelectReady()
  end
end

function DormFightFormationCtrl:PlayTimeLine(endAction)
  self:SwitchEditorModeTimeLine(true, endAction)
end

function DormFightFormationCtrl:RewindTimeLine(endAction)
  self:SwitchEditorModeTimeLine(false, endAction)
end

function DormFightFormationCtrl:SwitchEditorModeTimeLine(isToEditor, endAction)
  if self._tlCoroutine ~= nil then
    return
  end
  
  local function __OnTimeLineEnd()
    TimelineUtil.StopTlCo(self._tlCoroutine)
    self._tlCoroutine = nil
    if endAction ~= nil then
      endAction()
    end
  end
  
  if isToEditor then
    self._tlCoroutine = TimelineUtil.Play(self.bind.timeLine, __OnTimeLineEnd)
  else
    self._tlCoroutine = TimelineUtil.Rewind(self.bind.timeLine, __OnTimeLineEnd)
  end
end

function DormFightFormationCtrl:Refresh3dUI()
  local formationData = self:GetDfFormationData()
  local formationHeroDic = formationData:GetFormationHeroDic()
  for formatindex, platform3dUI in pairs(self.platform3dUIDic) do
    self:RefreshUIFmtPlatform(formatindex, platform3dUI)
  end
end

function DormFightFormationCtrl:RefreshUIFmtPlatform(index, platform3dUI)
  local heroEntity = self.heroEntityDic[index]
  if heroEntity == nil then
    platform3dUI.img_name:SetActive(false)
    platform3dUI.img_select:SetActive(true)
  else
    platform3dUI.img_name:SetActive(true)
    platform3dUI.img_select:SetActive(false)
    platform3dUI.tex_name.text = heroEntity.heroData:GetHeroName(true)
  end
end

function DormFightFormationCtrl:OnClickPlatform(fmtIndex)
  if self.__dragPlatform ~= nil then
    return
  end
  local heroData
  local heroEntity = self.heroEntityDic[fmtIndex]
  if heroEntity ~= nil then
    heroData = heroEntity:GetFmtHeroEntityData()
  end
  if heroData == nil and not self:IsFmtCtrlInEditState() then
    self:EnterEditSate()
  end
end

function DormFightFormationCtrl:OnBeginDrag(platformItem, eventData)
  if self.__dragPlatform ~= nil then
    return
  end
  local heroEntity = self:GetHeroEntity(platformItem:GetFmtIndex())
  if heroEntity == nil then
    return
  end
  self.__dragHero = heroEntity
  self.__dragHero:FmtHeroOnDrag(true)
  platformItem:EnableFmtPlatformRaycast(false)
  self.__dragPlatform = platformItem
  AudioManager:PlayAudioById(1018)
end

function DormFightFormationCtrl:OnDrag(platformItem, eventData)
  if self.__dragPlatform == nil or self.__dragPlatform ~= platformItem then
    return
  end
  local newPos = self:__GetGroundPoint()
  newPos = newPos + DragPosOffset
  self.__dragHero:SetFmtHeroEntityPos(newPos)
  local targetPlatform = self:__GetTargetPlatform(newPos)
  if targetPlatform == nil then
    if self.__swappedHero ~= nil then
      self.__swappedHero:DragHeroEndTweenHeroDetailItem(self.__swappedPlatform.transform.position)
      self.__swappedHero = nil
      self.__swappedPlatform = nil
    end
  elseif targetPlatform ~= platformItem and targetPlatform ~= self.__swappedPlatform then
    if self.__swappedHero ~= nil then
      self.__swappedHero:DragHeroEndTweenHeroDetailItem(self.__swappedPlatform.transform.position)
      self.__swappedHero = nil
      self.__swappedPlatform = nil
    end
    if targetPlatform:IsFmtPlatformUnlock() then
      local heroEntity = self:GetHeroEntity(targetPlatform:GetFmtIndex())
      if heroEntity ~= nil then
        heroEntity:DragHeroEndTweenHeroDetailItem(platformItem.transform.position)
        self.__swappedPlatform = targetPlatform
        self.__swappedHero = heroEntity
      end
    end
  end
  if self:PullFormationDrag(eventData.position) then
    self:RecoverHeroPutPlatform()
  else
    local lightPlat = targetPlatform ~= nil and targetPlatform:IsFmtPlatformUnlock() and not targetPlatIsFixedHero and targetPlatform or platformItem
    if lightPlat ~= nil then
      self.bind.platformSelectEffect:SetActive(true)
      self.bind.platformSelectEffect.transform.localPosition = lightPlat.gameObject.transform.localPosition
    else
      self.bind.platformSelectEffect:SetActive(false)
    end
    self._lastSeekHeroPlat = lightPlat
  end
end

function DormFightFormationCtrl:OnEndDrag(platformItem, eventData)
  self:RecoverHeroPutPlatform()
  if self.__dragPlatform == nil or self.__dragPlatform ~= platformItem then
    return
  end
  local targetPlatform = self:__GetTargetPlatform(self.__dragHero.transform.position)
  if self:PullFormationEnd(eventData.position, self.__dragHero) then
  elseif targetPlatform == nil or not targetPlatform:IsFmtPlatformUnlock() then
    self.__dragHero:DragHeroEndTweenHeroDetailItem(platformItem.transform.position)
  else
    if targetPlatform ~= platformItem then
      local targetFmtIndex = targetPlatform:GetFmtIndex()
      local heroEntity = self:GetHeroEntity(targetPlatform:GetFmtIndex())
      if heroEntity ~= nil then
        heroEntity:DragHeroEndTweenHeroDetailItem(platformItem.transform.position)
      end
      self.__dragHero:DragHeroEndTweenHeroDetailItem(targetPlatform.transform.position)
      self:SwapFmtPlatformHero(platformItem:GetFmtIndex(), targetFmtIndex)
    else
    end
  end
  self.__dragHero:FmtHeroOnDrag(false)
  self.__dragHero = nil
  self.__swappedPlatform = nil
  self.__swappedHero = nil
  self.__dragPlatform = nil
  platformItem:EnableFmtPlatformRaycast(true)
  AudioManager:PlayAudioById(1019)
end

function DormFightFormationCtrl:__GetGroundPoint()
  local mousePos = CS_InputUtility.MousePosition
  mousePos.x = math.clamp(mousePos.x, self.__screenWidthRange.x, self.__screenWidthRange.y)
  mousePos.y = math.clamp(mousePos.y, self.__screenHeightRange.x, self.__screenHeightRange.y)
  self:__RaycastGround(mousePos, self:IsFmtCtrlInEditState())
  if self:IsFmtCtrlInEditState() and self.__lastGroundPos.y < self.__platformPosY then
    local ratio = (self.__lastGroundPos.x - self.bind.camera.transform.position.x) / (self.__lastGroundPos.y - self.bind.camera.transform.position.y)
    self.__lastGroundPos.y = self.__platformPosY
    self.__lastGroundPos.x = ratio * (self.__lastGroundPos.y - self.bind.camera.transform.position.y) + self.bind.camera.transform.position.x
  else
    self.__lastGroundPos.y = self.__platformPosY
  end
  if self.__lastGroundPos.z > self.__platformPosZ then
    self.__lastGroundPos.z = self.__platformPosZ
  end
  return self.__lastGroundPos
end

function DormFightFormationCtrl:__RaycastGround(mousePos, isUseWallCollider)
  local fixZ
  local hits = CS_Physics.Raycast(self.bind.camera, 1 << LayerMask.Raycast, true, mousePos)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      if hitCollider.name == FmtGroundCollider then
        if not isUseWallCollider then
          self.__lastGroundPos = hits[i].point
          break
        else
          fixZ = hits[i].point.z
        end
      end
      if hitCollider.name == FmtWallCollider and isUseWallCollider then
        self.__lastGroundPos = hits[i].point
      end
    end
  end
  if fixZ ~= nil then
    self.__lastGroundPos.z = fixZ
  end
end

function DormFightFormationCtrl:__GetTargetPlatform(originPos)
  local targetGo
  originPos.y = originPos.y + 5
  local hits = CS_Physics.Raycast(originPos, Vector3.down, 1 << LayerMask.Formation)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) then
      targetGo = hitCollider.gameObject
      break
    end
  end
  local targetPlatform
  if not IsNull(targetGo) then
    targetPlatform = self:GetFmtPlatformEntityByGo(targetGo)
  end
  return targetPlatform
end

function DormFightFormationCtrl:Delete()
  self:OnDelete()
end

function DormFightFormationCtrl:OnDelete()
  UIUtil.CloseAllCover()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.__initCoroutine ~= nil then
    GR.StopCoroutine(self.__initCoroutine)
  end
  if self.__loadHeroCo ~= nil then
    GR.StopCoroutine(self.__loadHeroCo)
  end
  if self.heroEntityIdDic ~= nil then
    for k, heroEntity in pairs(self.heroEntityIdDic) do
      heroEntity:OnDelete()
    end
  end
  self.heroEntityIdDic = nil
  if self.platformEntityDic ~= nil then
    for k, entity in pairs(self.platformEntityDic) do
      entity:OnDelete()
    end
    self.platformEntityDic = nil
  end
  if self._tlCoroutine ~= nil then
    TimelineUtil.StopTlCo(self._tlCoroutine)
    self._tlCoroutine = nil
  end
  local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWindow ~= nil then
    homeWindow:BackFromOtherWin()
  end
  DestroyUnityObject(self.gameObject)
  base.OnDelete(self)
end

return DormFightFormationCtrl
