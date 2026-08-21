_class("UIAirNavMenu", UICustomWidget)
UIAirNavMenu = UIAirNavMenu

function UIAirNavMenu:OnShow(uiParams)
  self._assetCount = 0
  self._enterlvCount = 0
  self._storyCount = 0
  self._discoveryCount = 0
  self._allCount = 0
  self._lastAllCount = 0
  self._circleOpen = false
  self._isDetailOpen = false
  self._atlas = self:GetAsset("UIAircraftMainUI.spriteatlas", LoadType.SpriteAtlas)
  self._count2pos = {
    [1] = {
      [1] = Vector2(-260, 10)
    },
    [2] = {
      [1] = Vector2(-250, 105),
      [2] = Vector2(-250, -55)
    },
    [3] = {
      [1] = Vector2(-190, 200),
      [2] = Vector2(-260, 10),
      [3] = Vector2(-175, -180)
    },
    [4] = {
      [1] = Vector2(-145, 240),
      [2] = Vector2(-250, 105),
      [3] = Vector2(-240, -55),
      [4] = Vector2(-135, -205)
    }
  }
  self._state2name = {
    [AirNavMenuBtnState.Asset] = "str_aircraft_quality_menu_asset_collect",
    [AirNavMenuBtnState.Room] = "str_aircraft_quality_menu_enter_lv",
    [AirNavMenuBtnState.Story] = "str_aircraft_quality_menu_pet_story",
    [AirNavMenuBtnState.Discovery] = "str_aircraft_quality_menu_discovery_finish"
  }
  self._state2icon = {
    [AirNavMenuBtnState.Asset] = "wind_tongyong_icon25",
    [AirNavMenuBtnState.Room] = "wind_tongyong_icon26",
    [AirNavMenuBtnState.Story] = "wind_tongyong_icon24",
    [AirNavMenuBtnState.Discovery] = "wind_tongyong_icon23"
  }
  self._state2circleColor = {
    [AirNavMenuBtnState.Asset] = Color(0.13333333333333333, 0.7843137254901961, 0.9490196078431372, 1),
    [AirNavMenuBtnState.Room] = Color(0.45098039215686275, 0.9019607843137255, 0.5019607843137255, 1),
    [AirNavMenuBtnState.Story] = Color(0.9764705882352941, 0.5568627450980392, 0.2784313725490196, 1),
    [AirNavMenuBtnState.Discovery] = Color(0.9647058823529412, 0.8431372549019608, 0.3333333333333333, 1)
  }
  self._state2maskImg = {
    [AirNavMenuBtnState.Asset] = "wind_tongyong_fang3",
    [AirNavMenuBtnState.Room] = "wind_tongyong_fang4",
    [AirNavMenuBtnState.Story] = "wind_tongyong_fang2",
    [AirNavMenuBtnState.Discovery] = "wind_tongyong_fang1"
  }
  self._module = GameGlobal.GetModule(AircraftModule)
  self._btnState = AirNavMenuBtnState.All
  self._showSpaceId = {}
  self._navAnim = {
    [1] = "uieff_aircraftNav_Panel_Show",
    [2] = "uieff_aircraftNav_Panel_Hide"
  }
  self.maxCountTime_start = 0
  self.maxCountTime_end = 20
  self.maxCountTime_Gaps = self.maxCountTime_end - self.maxCountTime_start
end

function UIAirNavMenu:SetData(main, focusRoom, focusPet)
  self:GetComponent()
  self._main = main
  self:GetAirNavMenuData()
  self._allCount = self._assetCount + self._enterlvCount + self._storyCount + self._discoveryCount
  self._lastAllCount = self._allCount
  self._focusRoom = focusRoom
  self._focusPet = focusPet
  if self._allCount > 0 then
    self._CountPanel:SetActive(true)
    self._allCountTex:SetText(self._allCount)
  else
    self._isDetailOpen = false
    self._CountPanel:SetActive(false)
  end
end

function UIAirNavMenu:CalcMaskImgSizeWithPosZ(BoxColliderSizeX, BoxColliderSizeY)
  local k = 26
  local sizeX = BoxColliderSizeX * k
  local sizeY = BoxColliderSizeY * k
  return Vector2(sizeX, sizeY)
end

function UIAirNavMenu:GetAirNavMenuData()
  local roomList = self._module:GetAllRooms()
  self._assetCount = 0
  self._assetRoomList = {}
  for spaceid, room in pairs(roomList) do
    local roomType = room:GetRoomType()
    if roomType ~= AirRoomType.DispatchRoom then
      local canCollect = room:CanCollect()
      if canCollect then
        self._assetCount = self._assetCount + 1
        table.insert(self._assetRoomList, room)
      end
    end
  end
  self._enterlvCount = 0
  self._enterLvRoomList = {}
  for i = 1, 16 do
    local canLvUp = self._module:CanRoomLevelUp(i)
    if canLvUp then
      self._enterlvCount = self._enterlvCount + 1
    end
    local canEnter = self._module:CanRoomSettlePet(i)
    if canEnter then
      self._enterlvCount = self._enterlvCount + 1
    end
    local canBuild = self._main:GetRoomCanBuildForNav(i)
    if canBuild then
      self._enterlvCount = self._enterlvCount + 1
    end
    if canLvUp or canEnter or canBuild then
      local lv = canLvUp
      local enter = canEnter
      local data = {}
      data.lv = canLvUp
      data.enter = canEnter
      data.build = canBuild
      data.spaceid = i
      table.insert(self._enterLvRoomList, data)
    end
  end
  local _pets = self._main:GetPets(function(pet)
    local _pet = pet
    if _pet:IsGiftPet() or _pet:IsVisitPet() and _pet:HasVisitGift() or _pet:GetState() == AirPetState.RandomEvent then
      return true
    else
      return false
    end
  end, true)
  self._storyPets = {}
  for i = 1, table.count(_pets) do
    local _pet = _pets[i]
    local _petData = {}
    if _pet:IsVisitPet() then
      _petData.isVisitPet = true
    else
      _petData.isVisitPet = false
    end
    _petData.pet = _pet
    table.insert(self._storyPets, _petData)
  end
  self._storyCount = table.count(self._storyPets)
  self._discoveryCount = 0
  self._discoveryList = {}
end

function UIAirNavMenu:RefreshData()
  self:GetAirNavMenuData()
  self._allCount = self._assetCount + self._enterlvCount + self._storyCount + self._discoveryCount
  if self._allCount > 0 then
    self._CountPanel:SetActive(true)
    self:AllCountAnim()
  else
    if self._isDetailOpen then
      self:CloseNavMenu()
    end
    self._isDetailOpen = false
    self._CountPanel:SetActive(false)
  end
  if self._isDetailOpen then
    self:CreateCircleData()
    self:SpawnBtnItems(false)
    self:ShowAllEff()
  end
end

function UIAirNavMenu:AllCountAnim()
  self.accTime = 0
  self._tweening = true
end

function UIAirNavMenu:Update(dms)
  if self._tweening then
    self.accTime = self.accTime + dms
    local tweenCount = (self.accTime - self.maxCountTime_start) / self.maxCountTime_Gaps
    if self.accTime >= self.maxCountTime_end then
      tweenCount = 1
      self._tweening = false
    end
    if tweenCount <= 1 and 0 <= tweenCount then
      local cRec = DG.Tweening.DOVirtual.EasedValue(self._lastAllCount, self._allCount, tweenCount, DG.Tweening.Ease.OutQuad)
      self._allCountTex:SetText(math.floor(cRec))
    end
    if not self._tweening then
      self._lastAllCount = self._allCount
    end
  end
  if self._circleOpen then
    if self._roomEffs and 0 < #self._roomEffs then
      for i = 1, #self._roomEffs do
        if i <= #self._storyPets then
          local effItem = self._roomEffs[i]
          local pet = self._storyPets[i].pet
          local petGo = pet:GameObject()
          local pos = self:GetPosWithGameObject(petGo)
          effItem:FlushPos(pos)
        end
      end
    end
    if self._roomEffsOutLine and 0 < #self._roomEffsOutLine then
      for i = 1, #self._roomEffsOutLine do
        if i <= #self._storyPets then
          local effItem = self._roomEffsOutLine[i]
          local pet = self._storyPets[i].pet
          local petGo = pet:GameObject()
          local pos = self:GetPosWithGameObject(petGo)
          effItem:FlushPos(pos)
        end
      end
    end
    if self._roomEffsHead and 0 < #self._roomEffsHead then
      for i = 1, #self._roomEffsHead do
        if i <= #self._storyPets then
          local effItem = self._roomEffsHead[i]
          local pet = self._storyPets[i].pet
          local petGo = pet:GameObject()
          local pos = self:GetPosWithGameObject(petGo)
          effItem:FlushPos(pos)
        end
      end
    end
  end
end

function UIAirNavMenu:GetComponent()
  self._btnPool = self:GetUIComponent("UISelectObjectPath", "itemPool")
  self._allCountTex = self:GetUIComponent("UILocalizationText", "allCount")
  self._assetRoomEffPool = self:GetUIComponent("UISelectObjectPath", "assetRoomEffPool")
  self._enterRoomEffPool = self:GetUIComponent("UISelectObjectPath", "enterRoomEffPool")
  self._storyPetEffPool = self:GetUIComponent("UISelectObjectPath", "storyPetEffPool")
  self._discoveryRoomEffPool = self:GetUIComponent("UISelectObjectPath", "discoveryRoomEffPool")
  self._storyPetCircleEffPool = self:GetUIComponent("UISelectObjectPath", "storyPetCircleEffPool")
  self._storyPetCircleEffPoolOutLine = self:GetUIComponent("UISelectObjectPath", "storyPetCircleEffPoolOutLine")
  self._assetRoomEffPoolGo = self:GetGameObject("assetRoomEffPool")
  self._enterRoomEffPoolGo = self:GetGameObject("enterRoomEffPool")
  self._storyPetEffPoolGo = self:GetGameObject("storyPetEffPool")
  self._discoveryRoomEffPoolGo = self:GetGameObject("discoveryRoomEffPool")
  self._storyPetCircleEffPoolGo = self:GetGameObject("storyPetCircleEffPool")
  self._storyPetCircleEffPoolOutLineGo = self:GetGameObject("storyPetCircleEffPoolOutLine")
  self._alpha = self:GetGameObject("alpha")
  self._CountPanel = self:GetGameObject("CountPanel")
  self._CountPanel:SetActive(true)
  self._normalGo = self:GetGameObject("normal")
  self._normalGo:SetActive(true)
  self._detailGo = self:GetGameObject("detail")
  self._detailGo:SetActive(false)
  self._circlrImgGo = self:GetGameObject("circlrBg")
  self._circlrImg = self:GetUIComponent("Image", "circlrBg")
  self._circlrImgGo:SetActive(false)
  self._maskGo = self:GetGameObject("mask")
  self._maskRect = self:GetUIComponent("RectTransform", "mask")
  self._maskGo:SetActive(false)
  self._circleAnim = self:GetUIComponent("Animation", "CountPanel")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "mask")
  self._iconRect = self:GetUIComponent("RectTransform", "normalIcon")
  self._iconImg = self:GetUIComponent("Image", "normalIcon")
end

function UIAirNavMenu:_CheckNormalDetailActive()
  self._detailGo:SetActive(self._isDetailOpen)
  self._maskGo:SetActive(self._isDetailOpen)
  self._normalGo:SetActive(not self._isDetailOpen)
end

function UIAirNavMenu:_ShowCircleBg()
  self._circlrImgGo:SetActive(self._btnState ~= AirNavMenuBtnState.All)
  if self._btnState ~= AirNavMenuBtnState.All then
    self._circlrImg.color = self._state2circleColor[self._btnState]
  end
end

function UIAirNavMenu:CreateCircleData()
  self._showCount = 0
  self._showTab = {}
  if 0 < self._assetCount then
    self._showCount = self._showCount + 1
    local tab = {}
    tab.state = AirNavMenuBtnState.Asset
    tab.count = self._assetCount
    self._showTab[#self._showTab + 1] = tab
  end
  if 0 < self._enterlvCount then
    self._showCount = self._showCount + 1
    local tab = {}
    tab.state = AirNavMenuBtnState.Room
    tab.count = self._enterlvCount
    self._showTab[#self._showTab + 1] = tab
  end
  if 0 < self._storyCount then
    self._showCount = self._showCount + 1
    local tab = {}
    tab.state = AirNavMenuBtnState.Story
    tab.count = self._storyCount
    self._showTab[#self._showTab + 1] = tab
  end
  if 0 < self._discoveryCount then
    self._showCount = self._showCount + 1
    local tab = {}
    tab.state = AirNavMenuBtnState.Discovery
    tab.count = self._discoveryCount
    self._showTab[#self._showTab + 1] = tab
  end
end

function UIAirNavMenu:SpawnBtnItems(needAnim)
  self._btnPool:SpawnObjects("UIAirNavMenuBtnItem", #self._showTab)
  local pools = self._btnPool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    if i <= self._showCount then
      item:GetGameObject():SetActive(true)
      local idx = i
      local state = self._showTab[i].state
      local count = self._showTab[i].count
      local icon = self._atlas:GetSprite(self._state2icon[state])
      local name = self._state2name[state]
      local pos = self._count2pos[self._showCount][i]
      
      local function cb(state)
        self:OnItemClick(state)
      end
      
      item:SetData(idx, state, self._btnState, count, icon, name, pos, cb)
      if needAnim then
        local yieldTime = (idx - 1) * 33
        item:PlayAnim_In(yieldTime)
      end
    else
      item:GetGameObject():SetActive(false)
    end
  end
end

function UIAirNavMenu:CloseAllEff()
  self._assetRoomEffPoolGo:SetActive(false)
  self._enterRoomEffPoolGo:SetActive(false)
  self._storyPetEffPoolGo:SetActive(false)
  self._discoveryRoomEffPoolGo:SetActive(false)
  self._storyPetCircleEffPoolGo:SetActive(false)
  self._storyPetCircleEffPoolOutLineGo:SetActive(false)
  self._alpha:SetActive(false)
end

function UIAirNavMenu:ShowAllEff()
  self:GetAirNavMenuData()
  self._assetRoomEffPoolGo:SetActive(true)
  self._enterRoomEffPoolGo:SetActive(true)
  self._storyPetEffPoolGo:SetActive(true)
  self._discoveryRoomEffPoolGo:SetActive(true)
  self._storyPetCircleEffPoolGo:SetActive(false)
  self._storyPetCircleEffPoolOutLineGo:SetActive(false)
  self._alpha:SetActive(false)
  self:ShowStoryPetEff()
  if self._btnState == AirNavMenuBtnState.Story then
    self:ShowStoryPetCircleEff()
  end
  self:ShowDiscoveryRoomEff()
  self:ShowAssetRoomEff()
  self:ShowEnterLvRoomEff()
end

function UIAirNavMenu:OnEffAssetRoomClick(room)
  Log.debug("###[UIAirNavMenu] OnEffAssetRoomClick !")
  local clickRoom = room
  local roomType = room:GetRoomType()
  if roomType == AirRoomType.TacticRoom then
    self:OnEffDiscoveryRoomClick(room)
  else
    self:Lock("UIAirNavMenu:CollectOneAsset")
    local spaceid = clickRoom:SpaceId()
    self:CloseNavMenu()
    GameGlobal.TaskManager():StartTask(self.OnOnEffAssetRoomClick, self, spaceid)
  end
end

function UIAirNavMenu:OnOnEffAssetRoomClick(TT, spaceid)
  Log.debug("###[UIAirNavMenu] OnOnEffAssetRoomClick !")
  local res, msg = self._module:RequestCollectAsset(TT, spaceid)
  self:UnLock("UIAirNavMenu:CollectOneAsset")
  if res and res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshMainUI)
    Log.debug("###[UIAirNavMenu] CollectAllAsset  Succ!")
    local matList = msg.asset
    self:ShowDialog("UIGetItemController", matList)
  else
    self:GetAssetFailTips(res:GetResult())
    Log.error("###[NavMenu]UIAirNavMenu:OnCollectAllAsset result --> ", res:GetResult())
  end
end

function UIAirNavMenu:OnEffEnterRoomClick(data)
  self:CloseNavMenu()
  local spaceid = data.spaceid
  if data.build then
    GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "SelectRoom", spaceid)
  else
    if data.enter then
      GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "SetNavMenuData", 1)
    elseif data.lv then
      GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "SetNavMenuData", 2)
    end
    GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "SelectAndFocusRoom", spaceid)
  end
end

function UIAirNavMenu:OnStoryPetClick(aircraftPet)
  local cliclPet = aircraftPet
  if self._focusPet then
    self._focusPet(cliclPet)
  end
  self:CloseNavMenu()
end

function UIAirNavMenu:OnEffDiscoveryRoomClick(room)
  local spaceid = room:SpaceId()
  local clickRoom = self._main:GetRoomBySpaceID(spaceid)
  local roomType = room:GetRoomType()
  if self._focusRoom then
    self._focusRoom(clickRoom, function()
      GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "SelectRoom", spaceid)
      if roomType == AirRoomType.TacticRoom then
        GameGlobal.UIStateManager():ShowDialog("UIAircraftTactic")
      elseif roomType == AirRoomType.DispatchRoom then
        GameGlobal.UIStateManager():ShowDialog("UIDispatchMapController")
      end
    end)
  end
  self:CloseNavMenu()
end

function UIAirNavMenu:ShowAssetRoomEff()
  local roomList = self._assetRoomList
  local tableCount = table.count(roomList)
  self._assetRoomEffPool:SpawnObjects("UIAirNavMenuAssetRoomEff", tableCount)
  local roomEffs = self._assetRoomEffPool:GetAllSpawnList()
  for i = 1, #roomEffs do
    local active = true
    if i > tableCount then
      active = false
    else
      local data = roomList[i]
      local spaceid = data:SpaceId()
      if self._showSpaceId[spaceid] then
        active = false
      end
    end
    local effItem = roomEffs[i]
    if active then
      local data = roomList[i]
      local spaceid = data:SpaceId()
      local roomGo = self._main:GetRoomGoSpaceID(spaceid)
      local pos = self:GetPosWithGameObject(roomGo)
      local sizeX = roomGo:GetComponent("BoxCollider").size.x
      local sizeY = roomGo:GetComponent("BoxCollider").size.y
      local size = self:CalcMaskImgSizeWithPosZ(sizeX, sizeY)
      effItem:GetGameObject():SetActive(true)
      effItem:SetData(pos, size, data, function(room)
        self:OnEffAssetRoomClick(room)
      end)
      self._showSpaceId[spaceid] = true
    else
      effItem:GetGameObject():SetActive(false)
    end
  end
end

function UIAirNavMenu:ShowEnterLvRoomEff()
  local roomList = self._enterLvRoomList
  local tableCount = table.count(roomList)
  self._enterRoomEffPool:SpawnObjects("UIAirNavMenuEnterRoomEff", tableCount)
  local roomEffs = self._enterRoomEffPool:GetAllSpawnList()
  for i = 1, #roomEffs do
    local active = true
    if i > tableCount then
      active = false
    else
      local data = roomList[i]
      local spaceid = data.spaceid
      if self._showSpaceId[spaceid] then
        active = false
      end
    end
    local effItem = roomEffs[i]
    if active then
      local data = roomList[i]
      local spaceid = data.spaceid
      local roomGo = self._main:GetRoomGoSpaceID(spaceid)
      local pos = self:GetPosWithGameObject(roomGo)
      local sizeX = roomGo:GetComponent("BoxCollider").size.x
      local sizeY = roomGo:GetComponent("BoxCollider").size.y
      local size = self:CalcMaskImgSizeWithPosZ(sizeX, sizeY)
      effItem:GetGameObject():SetActive(true)
      effItem:SetData(pos, size, data, function(data)
        self:OnEffEnterRoomClick(data)
      end)
      self._showSpaceId[spaceid] = true
    else
      effItem:GetGameObject():SetActive(false)
    end
  end
end

function UIAirNavMenu:ShowStoryPetEff()
  local storyPets = self._storyPets
  local tableCount = table.count(storyPets)
  self._storyPetEffPool:SpawnObjects("UIAirNavMenuPetStoryEff", tableCount)
  self._roomEffsHead = self._storyPetEffPool:GetAllSpawnList()
  for i = 1, #self._roomEffsHead do
    local effItem = self._roomEffsHead[i]
    if tableCount >= i then
      local pet = storyPets[i].pet
      local isVisitPet = storyPets[i].isVisitPet
      local petGo = pet:GameObject()
      local pos = self:GetPosWithGameObject(petGo)
      effItem:SetData(pos, Vector2(0, 0), pet, isVisitPet, function(aircraftPet)
        self:OnStoryPetClick(aircraftPet)
      end)
      effItem:GetGameObject():SetActive(true)
    else
      effItem:GetGameObject():SetActive(false)
    end
  end
end

function UIAirNavMenu:ShowDiscoveryRoomEff()
  local roomList = self._discoveryList
  local tableCount = table.count(roomList)
  self._discoveryRoomEffPool:SpawnObjects("UIAirNavMenuDiscoveryRoomEff", tableCount)
  local roomEffs = self._discoveryRoomEffPool:GetAllSpawnList()
  for i = 1, #roomEffs do
    local active = true
    if i > tableCount then
      active = false
    else
      local data = roomList[i]
      local _room = data.room
      local spaceid = _room:SpaceId()
      if self._showSpaceId[spaceid] then
        active = false
      end
    end
    local effItem = roomEffs[i]
    if active then
      local data = roomList[i]
      local _room = data.room
      local spaceid = _room:SpaceId()
      local roomGo = self._main:GetRoomGoSpaceID(spaceid)
      local pos = self:GetPosWithGameObject(roomGo)
      local sizeX = roomGo:GetComponent("BoxCollider").size.x
      local sizeY = roomGo:GetComponent("BoxCollider").size.y
      local size = self:CalcMaskImgSizeWithPosZ(sizeX, sizeY)
      effItem:GetGameObject():SetActive(true)
      effItem:SetData(pos, size, data, function(data)
        self:OnEffDiscoveryRoomClick(data)
      end)
      self._showSpaceId[spaceid] = true
    else
      effItem:GetGameObject():SetActive(false)
    end
  end
end

function UIAirNavMenu:OnItemClick(state)
  self._btnState = state
  self:_RefreshBtnState()
  self._showSpaceId = {}
  self:_ShowCircleBg()
  if self._btnState == AirNavMenuBtnState.Asset then
    self:CollectAllAsset()
    return
  end
  self._assetRoomEffPoolGo:SetActive(self._btnState == AirNavMenuBtnState.Asset)
  self._enterRoomEffPoolGo:SetActive(self._btnState == AirNavMenuBtnState.Room)
  self._storyPetEffPoolGo:SetActive(self._btnState == AirNavMenuBtnState.Story)
  self._discoveryRoomEffPoolGo:SetActive(self._btnState == AirNavMenuBtnState.Discovery)
  self._storyPetCircleEffPoolGo:SetActive(self._btnState == AirNavMenuBtnState.Story)
  self._storyPetCircleEffPoolOutLineGo:SetActive(self._btnState == AirNavMenuBtnState.Story)
  self._alpha:SetActive(self._btnState == AirNavMenuBtnState.Story)
  if self._btnState == AirNavMenuBtnState.Room then
    self:ShowEnterLvRoomEff()
  elseif self._btnState == AirNavMenuBtnState.Story then
    local giftPets = {}
    local visitPets = {}
    for _, v in pairs(self._storyPets) do
      local pet = v.pet
      if pet:IsGiftPet() then
        table.insert(giftPets, pet)
      elseif pet:HasVisitGift() then
        table.insert(visitPets, pet)
      end
    end
    self._main:AcceptAllPresent(giftPets, visitPets, function(assetList)
      if 0 < #assetList then
        GameGlobal.UIStateManager():ShowDialog("UIGetItemController", assetList, function()
          for _, v in pairs(self._storyPets) do
            local pet = v.pet
            pet:StopSpecialAction(AircraftSpecialActionType.PresentBag)
            if pet:IsGiftPet() then
              pet:SetGiftFlag(nil)
            elseif pet:HasVisitGift() then
              pet:SetVisitGift(nil)
            end
            if pet:IsWorkingPet() then
              AirLog("送礼星灵走回工作房间：", pet:TemplateID(), "，空间id：", pet:GetSpace())
              local action = AirActionMoveToWork:New(self._main, pet)
              pet:StartMainAction(action)
            end
            GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshNavMenuData)
          end
        end)
      else
        self:ShowStoryPetEff()
        self:ShowStoryPetCircleEff()
      end
    end)
  elseif self._btnState == AirNavMenuBtnState.Discovery then
    local room = self._discoveryList[1].room
    self:OnEffDiscoveryRoomClick(room)
  end
  self._circleOpen = self._btnState == AirNavMenuBtnState.Story
end

function UIAirNavMenu:ShowStoryPetCircleEff()
  local storyPets = self._storyPets
  self._storyPetCircleEffPool:SpawnObjects("UIAirNavMenuPetStoryCircleEff", #storyPets)
  self._roomEffs = self._storyPetCircleEffPool:GetAllSpawnList()
  for i = 1, #self._roomEffs do
    local effItem = self._roomEffs[i]
    if i <= #storyPets then
      local pet = storyPets[i].pet
      local petGo = pet:GameObject()
      local pos = self:GetPosWithGameObject(petGo)
      effItem:SetData(pos, Vector2(64, 64), pet)
      effItem:GetGameObject():SetActive(true)
    else
      effItem:GetGameObject():SetActive(false)
    end
  end
  self._storyPetCircleEffPoolOutLine:SpawnObjects("UIAirNavMenuPetStoryCircleEff", #storyPets)
  self._roomEffsOutLine = self._storyPetCircleEffPoolOutLine:GetAllSpawnList()
  for i = 1, #self._roomEffsOutLine do
    local effItem = self._roomEffsOutLine[i]
    if i <= #storyPets then
      local pet = storyPets[i].pet
      local petGo = pet:GameObject()
      local pos = self:GetPosWithGameObject(petGo)
      effItem:SetData(pos, Vector2(66, 66), pet)
      effItem:GetGameObject():SetActive(true)
    else
      effItem:GetGameObject():SetActive(false)
    end
  end
end

function UIAirNavMenu:_RefreshBtnState()
  local pools = self._btnPool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:RefreshBtnState(self._btnState)
  end
end

function UIAirNavMenu:normalBtnOnClick(go)
  if not self._isDetailOpen then
    GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "ClearCurrentRoom")
    self._isDetailOpen = true
    local currentCameraPos = GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "GetCurrentCameraPos")
    local targetCameraPos = GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "GetNavMenuTargetCameraPos")
    local distance = Vector3.Distance(currentCameraPos, targetCameraPos)
    local speed = 0.15
    local moveTime = distance / speed
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftMainMoveCameraToNavMenu, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SetCameraToNavMenuPos)
      self._circleAnim:Play(self._navAnim[1])
      self._canvasGroup.alpha = 0
      self._canvasGroup:DOFade(1, 0.1)
      self:Lock("AirNavMenu_CircleAnim")
      GameGlobal.Timer():AddEvent(500, function()
        self:UnLock("AirNavMenu_CircleAnim")
      end)
      self:_CheckNormalDetailActive()
      self:CreateCircleData()
      self:SpawnBtnItems(true)
      self:_ShowCircleBg()
      self:CloseAllEff()
      GameGlobal.Timer():AddEvent(200, function()
        self:ShowAllEff()
      end)
    end, moveTime)
  end
end

function UIAirNavMenu:CollectAllAsset()
  Log.debug("###[UIAirNavMenu] CollectAllAsset !")
  if #self._assetRoomList <= 0 then
    Log.error("###[UIAirNavMenu] self._assetRoomList count == 0 , but click all collect !")
    return
  end
  if #self._assetRoomList == 1 then
    local room = self._assetRoomList[1]
    local roomType = room:GetRoomType()
    if roomType == AirRoomType.TacticRoom then
      self:OnEffDiscoveryRoomClick(room)
      return
    end
  end
  self:Lock("UIAirNavMenu:CollectAllAsset")
  GameGlobal.TaskManager():StartTask(self.OnCollectAllAsset, self)
end

function UIAirNavMenu:OnCollectAllAsset(TT)
  local res, msg = self._module:OneKeyCollectAsset(TT)
  Log.debug("###[UIAirNavMenu] OnCollectAllAsset !")
  self:UnLock("UIAirNavMenu:CollectAllAsset")
  if res and res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftRefreshMainUI)
    Log.debug("###[UIAirNavMenu] CollectAllAsset  Succ!")
    local matList = msg.asset
    self:ShowDialog("UIGetItemController", matList)
  else
    self:GetAssetFailTips(res:GetResult())
    Log.debug("###[NavMenu]UIAirNavMenu:OnCollectAllAsset result --> ", res:GetResult())
  end
end

function UIAirNavMenu:GetAssetFailTips(result)
  if result == AircraftEventResult.COLLECT_ASSET_EMPTY or result == AircraftEventResult.COLLECT_ASSET_ERROR_PHY then
    local tips = StringTable.Get("str_physicalpower_error_phy_add_full")
    ToastManager.ShowToast(tips)
  end
end

function UIAirNavMenu:CloseNavMenu()
  self:bgOnClick()
end

function UIAirNavMenu:IsDetailOpen()
  return self._isDetailOpen
end

function UIAirNavMenu:bgOnClick(go)
  if self._isDetailOpen then
    self._canvasGroup.alpha = 1
    self._canvasGroup:DOFade(0, 0.1)
    self._circleAnim:Play(self._navAnim[2])
    self:Lock("AirNavMenu_CircleAnim")
    GameGlobal.Timer():AddEvent(667, function()
      self._showSpaceId = {}
      self._isDetailOpen = false
      self._btnState = AirNavMenuBtnState.All
      self:_CheckNormalDetailActive()
      self:_ShowCircleBg()
      self._circleOpen = false
      self._petEffHead = self._storyPetEffPool:GetAllSpawnList()
      if self._petEffHead and table.count(self._petEffHead) > 0 then
        for i = 1, #self._petEffHead do
          local effItem = self._petEffHead[i]
          effItem:GetGameObject():SetActive(false)
        end
      end
      self._petEff = self._storyPetCircleEffPool:GetAllSpawnList()
      if self._petEff and 0 < table.count(self._petEff) then
        for i = 1, #self._petEff do
          local effItem = self._petEff[i]
          effItem:GetGameObject():SetActive(false)
        end
      end
      self._petEffOut = self._storyPetCircleEffPoolOutLine:GetAllSpawnList()
      if self._petEffOut and 0 < table.count(self._petEffOut) then
        for i = 1, #self._petEffOut do
          local effItem = self._petEffOut[i]
          effItem:GetGameObject():SetActive(false)
        end
      end
      self._storyPetCircleEffPoolGo:SetActive(false)
      self._storyPetCircleEffPoolOutLineGo:SetActive(false)
      self._alpha:SetActive(false)
      self:UnLock("AirNavMenu_CircleAnim")
    end)
  end
end

function UIAirNavMenu:OnHide()
end

function UIAirNavMenu:GetPosWithGameObject(go)
  local tr = go.transform
  local box = go:GetComponent("BoxCollider")
  local petPos
  if box then
    petPos = tr.position + box.center
  else
    petPos = tr.position
  end
  local camera3d = self:GetAirCamera3D()
  local screenPos = camera3d:WorldToScreenPoint(petPos)
  local camera2d = self:GetAirCamera2D()
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self._maskRect, screenPos, camera2d, nil)
  return pos
end

function UIAirNavMenu:GetAirCamera3D()
  return GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "GetAirCamera3D")
end

function UIAirNavMenu:GetAirCamera2D()
  return GameGlobal.UIStateManager():CallUIMethod("UIAircraftController", "GetAirCamera2D")
end

function UIAirNavMenu:ResetIconPos()
  self._iconRect.anchoredPosition = Vector2(-95.2, -5.7)
  self._iconImg.color = Color(1, 1, 1, 1)
end

local AirNavMenuBtnState = {
  All = 0,
  Asset = 1,
  Room = 2,
  Story = 3,
  Discovery = 4
}
_enum("AirNavMenuBtnState", AirNavMenuBtnState)
