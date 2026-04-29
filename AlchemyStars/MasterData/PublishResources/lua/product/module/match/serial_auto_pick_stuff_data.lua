_class("SerialAutoPickStuffData", Object)
SerialAutoPickStuffData = SerialAutoPickStuffData
local SerialAutoPickStuffEnum = {
  Dungeon_MainLine = 1,
  Dungeon_Resource = 2,
  Jump_Equip = 10,
  Jump_Awaken = 11,
  Track_Begin = 100,
  Track_Jump = 101,
  Track_Enable = 102
}
_enum("SerialAutoPickStuffEnum", SerialAutoPickStuffEnum)

function SerialAutoPickStuffData:Constructor()
  self._typeDungeon = 0
  self._typeJump = 0
  self._petTid = 0
  self._itemId = 0
  self._itemCondition = 0
  self._track = false
  self._enable = false
  self._uiState = {
    nodeId = nil,
    chapterId = nil,
    reach = nil,
    again = nil
  }
  self._uiResource = {mainType = nil, gotoSubType = nil}
  self._uiCount = {
    matchType = nil,
    needPower = nil,
    doubleTicket = nil,
    uuid = nil
  }
  self._autoFight = {
    nodeId = nil,
    chapterId = nil,
    mainType = nil,
    gotoSubType = nil
  }
  SerialAutoPickStuffData.theInstance = self
  self:AttachEventListener(true)
end

function SerialAutoPickStuffData:Dispose()
  self:AttachEventListener(false)
  SerialAutoPickStuffData.theInstance = nil
end

function SerialAutoPickStuffData:AttachEventListener(isAttach)
  if isAttach then
    self._eventUIOpen = GameHelper:GetInstance():CreateCallback(self.OnUIOpenHandle, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIOpen, self._eventUIOpen)
    self._eventUIClose = GameHelper:GetInstance():CreateCallback(self.OnUICloseHandle, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.UIClose, self._eventUIClose)
  else
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIOpen, self._eventUIOpen)
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.UIClose, self._eventUIClose)
  end
end

function SerialAutoPickStuffData:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function SerialAutoPickStuffData:StartTask(func, ...)
  return GameGlobal.TaskManager():StartTask(func, ...)
end

function SerialAutoPickStuffData:Lock(name)
  GameGlobal.UIStateManager():Lock(name)
end

function SerialAutoPickStuffData:UnLock(name)
  GameGlobal.UIStateManager():UnLock(name)
end

function SerialAutoPickStuffData:ShowDialog(uiName, ...)
  GameGlobal.UIStateManager():ShowDialog(uiName, ...)
end

function SerialAutoPickStuffData:IsEnable(outOfFight)
  if not self._enable then
    return false
  elseif outOfFight then
    if self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_MainLine then
      local uiStateManager = GameGlobal.UIStateManager()
      local uiController = uiStateManager:GetController("UIStage")
      local nodeId, chapterId
      if uiController ~= nil then
        nodeId = uiController:GetNodeId()
        chapterId = uiController:GetChapterID()
      end
      return nodeId == self._uiState.nodeId and chapterId == self._uiState.chapterId
    elseif self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_Resource then
      local uiStateManager = GameGlobal.UIStateManager()
      local uiController = uiStateManager:GetController("UIResDetailController")
      local mainType, gotoSubType
      if uiController ~= nil then
        mainType = uiController:GetMainType()
        gotoSubType = uiController:GetGotoSubType()
      end
      return mainType == self._uiResource.mainType and gotoSubType == self._uiResource.gotoSubType
    end
  elseif self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_MainLine then
    return self._autoFight.nodeId == self._uiState.nodeId and self._autoFight.chapterId == self._uiState.chapterId
  elseif self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_Resource then
    return self._autoFight.mainType == self._uiResource.mainType and self._autoFight.gotoSubType == self._uiResource.gotoSubType
  end
  return false
end

function SerialAutoPickStuffData:GetItemID()
  return self._itemId
end

function SerialAutoPickStuffData:GetItemCondition()
  return self._itemCondition
end

function SerialAutoPickStuffData:IsPowerEnough()
  if not self._enable then
    return false
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  local currentPhysicalPower = roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
  return currentPhysicalPower >= self._uiCount.needPower
end

function SerialAutoPickStuffData:SetDungeon(inDungeon)
  self._typeDungeon = inDungeon
end

function SerialAutoPickStuffData:SetJump(inJump)
  self._typeJump = inJump
end

function SerialAutoPickStuffData:SetPetId(inPetTid)
  self._petTid = inPetTid
end

function SerialAutoPickStuffData:SetAutoFight()
  if not self._enable then
    return
  end
  if self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_MainLine then
    local uiStateManager = GameGlobal.UIStateManager()
    local uiController = uiStateManager:GetController("UIStage")
    self._autoFight.nodeId = nil
    self._autoFight.chapterId = nil
    if uiController ~= nil then
      self._autoFight.nodeId = uiController:GetNodeId()
      self._autoFight.chapterId = uiController:GetChapterID()
    end
  elseif self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_Resource then
    local uiStateManager = GameGlobal.UIStateManager()
    local uiController = uiStateManager:GetController("UIResDetailController")
    self._autoFight.mainType = nil
    self._autoFight.gotoSubType = nil
    if uiController ~= nil then
      self._autoFight.mainType = uiController:GetMainType()
      self._autoFight.gotoSubType = uiController:GetGotoSubType()
    end
  end
end

function SerialAutoPickStuffData:TrackStuff(itemId, itemCondition)
  self._itemId = itemId
  self._itemCondition = itemCondition
end

function SerialAutoPickStuffData:SetEnable(active)
  self._enable = active
end

function SerialAutoPickStuffData:SetTrack(track)
  if track then
    self._track = SerialAutoPickStuffEnum.Track_Begin
    self._enable = false
  end
end

function SerialAutoPickStuffData:GotoWithItemGetPath(idJump, idItem)
  local cfg = Cfg.cfg_jump[idJump]
  if cfg == nil then
    return
  end
  if self._track == SerialAutoPickStuffEnum.Track_Jump then
    if cfg.JumpID == UIJumpType.UI_JumpMission then
      self._typeDungeon = SerialAutoPickStuffEnum.Dungeon_MainLine
      self._itemId = idItem
      self._track = SerialAutoPickStuffEnum.Track_Enable
    elseif cfg.JumpID == UIJumpType.UI_JumpResDungeon then
      self._typeDungeon = SerialAutoPickStuffEnum.Dungeon_Resource
      self._itemId = idItem
      self._track = SerialAutoPickStuffEnum.Track_Enable
    elseif cfg.JumpID == UIJumpType.UI_JumpAircraft then
      self._track = false
    end
  end
end

function SerialAutoPickStuffData:OnUIOpenHandle(uiName)
  local uiStateManager = GameGlobal.UIStateManager()
  local uiController = uiStateManager:GetController(uiName)
  if self._enable then
    if uiName == "UISerialAutoFightOption" then
      self._uiCount = uiController:GetParams()
    end
  elseif self._track == SerialAutoPickStuffEnum.Track_Begin then
    if uiName == "UIPetEquipUpLevelController" then
      self._typeJump = SerialAutoPickStuffEnum.Jump_Equip
      self._track = SerialAutoPickStuffEnum.Track_Jump
    elseif uiName == "UIGradeInterfaceController" then
      self._typeJump = SerialAutoPickStuffEnum.Jump_Awaken
      self._track = SerialAutoPickStuffEnum.Track_Jump
    end
  elseif self._track == SerialAutoPickStuffEnum.Track_Jump then
    if uiName == "UIItemGetPathController" then
      local uiController = uiStateManager:GetController("UIItemGetPathController")
      self._itemCondition = uiController:GetItemCondition()
      local uiController = uiStateManager:GetController("UISpiritDetailGroupController")
      local petInfo = uiController:GetCurrentPetInfos()
      self._petTid = petInfo:GetTemplateID()
    end
  elseif self._track == SerialAutoPickStuffEnum.Track_Enable then
    if uiName == "UIStage" then
      self._track = false
      self._enable = true
      self._uiState.nodeId = uiController:GetNodeId()
      self._uiState.chapterId = uiController:GetChapterID()
      self._uiState.reach = uiController:GetReach()
      self._uiState.again = uiController:GetFightAgain()
    elseif uiName == "UIResDetailController" then
      self._track = false
      self._enable = true
      self._uiResource.mainType = uiController:GetMainType()
      self._uiResource.gotoSubType = uiController:GetGotoSubType()
    end
  end
end

function SerialAutoPickStuffData:OnUICloseHandle(uiName)
  local inBattle = self:GetModule(SerialAutoFightModule):IsRunning()
  if self._enable and inBattle then
    return
  elseif self._enable then
    if self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_MainLine and uiName == "UIDiscovery" then
      self._track = false
      self._enable = false
    elseif self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_Resource and uiName == "UIResEntryController" then
      self._track = false
      self._enable = false
    end
  elseif self._track == SerialAutoPickStuffEnum.Track_Jump then
    if uiName == "UIPetEquipUpLevelController" then
      self._track = false
    elseif uiName == "UIGradeInterfaceController" then
      self._track = false
    end
  end
end

function SerialAutoPickStuffData:EnsureVisibleTT(TT, uiName)
  local uiStateManager = GameGlobal.UIStateManager()
  while not uiStateManager:IsShow(uiName) do
    YIELD(TT)
  end
end

function SerialAutoPickStuffData:ContinueBattle()
  if not self._enable then
    return
  end
  if self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_MainLine then
    self:StartTask(self.ContinueBattleMainLine, self)
  elseif self._typeDungeon == SerialAutoPickStuffEnum.Dungeon_Resource then
    self:StartTask(self.ContinueBattleResource, self)
  end
end

function SerialAutoPickStuffData:ContinueBattleMainLine(TT)
  self:Lock("SerialAutoPickStuffData:ContinueBattleMainLine")
  local p = self._uiState
  self:ShowDialog("UIStage", p.nodeId, p.chapterId, p.reach, p.again)
  self:EnsureVisibleTT(TT, "UIStage")
  YIELD(TT, 300)
  local p = self._uiCount
  self:ShowDialog("UISerialAutoFightOption", p.matchType, p.stageId, p.needPower, p.uuid, p.unlock, p.trackData)
  self:UnLock("SerialAutoPickStuffData:ContinueBattleMainLine")
end

function SerialAutoPickStuffData:ContinueBattleResource(TT)
  self:Lock("SerialAutoPickStuffData:ContinueBattleResource")
  YIELD(TT, 33)
  local p = self._uiCount
  self:ShowDialog("UISerialAutoFightOption", p.matchType, p.stageId, p.needPower, p.uuid, p.unlock, p.trackData)
  self:UnLock("SerialAutoPickStuffData:ContinueBattleResource")
end

function SerialAutoPickStuffData:ReturnSpirit()
  if not self._enable then
    return
  end
  if self._typeJump == SerialAutoPickStuffEnum.Jump_Equip then
    self:StartTask(self.ReturnSpiritTask, self)
  elseif self._typeJump == SerialAutoPickStuffEnum.Jump_Awaken then
    self:StartTask(self.ReturnSpiritTask, self)
  end
end

function SerialAutoPickStuffData:ReturnSpirit_TestCase()
  self._petTid = 1600061
  self._typeJump = SerialAutoPickStuffEnum.Jump_Awaken
  if self._typeJump == SerialAutoPickStuffEnum.Jump_Equip then
    self:StartTask(self.ReturnSpiritTask, self)
  elseif self._typeJump == SerialAutoPickStuffEnum.Jump_Awaken then
    self:StartTask(self.ReturnSpiritTask, self)
  end
end

function SerialAutoPickStuffData:ReturnSpiritTask(TT)
  self:Lock("SerialAutoPickStuffData:ReturnSpiritTask")
  local uiStateManager = GameGlobal.UIStateManager()
  uiStateManager:SwitchState(UIStateType.UIMain)
  self:EnsureVisibleTT(TT, "UIMainLobbyController")
  YIELD(TT, 50)
  self:ShowDialog("UIHeartSpiritController")
  self:EnsureVisibleTT(TT, "UIHeartSpiritController")
  YIELD(TT, 50)
  local uiController = uiStateManager:GetController("UIHeartSpiritController")
  local heartItem = uiController:GetPetHeartItem(self._petTid)
  self:ShowDialog("UISpiritDetailGroupController", self._petTid, nil, nil, heartItem)
  self:EnsureVisibleTT(TT, "UISpiritDetailGroupController")
  YIELD(TT, 50)
  local guideModule = GameGlobal.GetModule(GuideModule)
  local inGuideProcess = guideModule:IsGuideProcessKey("guide_pet_awaken")
  if inGuideProcess then
  elseif self._typeJump == SerialAutoPickStuffEnum.Jump_Equip then
    local uiController = uiStateManager:GetController("UISpiritDetailGroupController")
    local petInfo = uiController:GetCurrentPetInfos()
    self:ShowDialog("UIPetEquipController", petInfo)
    self:EnsureVisibleTT(TT, "UIPetEquipController")
    YIELD(TT, 50)
    local petId = petInfo:GetTemplateID()
    local currentEquipLv = petInfo:GetEquipLv()
    local equipMaxLv = 0
    local cfg_equip = Cfg.cfg_pet_equip({PetID = petId})
    if cfg_equip and 0 < #cfg_equip then
      equipMaxLv = cfg_equip[#cfg_equip].Level
    end
    if currentEquipLv >= equipMaxLv then
      petInfo = nil
    else
      self:SetTrack(true)
      self:ShowDialog("UIPetEquipUpLevelController", petInfo)
    end
  elseif self._typeJump == SerialAutoPickStuffEnum.Jump_Awaken then
    local uiController = uiStateManager:GetController("UISpiritDetailGroupController")
    if uiController ~= nil then
      uiController:awakenBtnOnClick(nil)
    else
      self:SetTrack(true)
      self:ShowDialog("UIGradeInterfaceController", self._petTid)
    end
  end
  self:UnLock("SerialAutoPickStuffData:ReturnSpiritTask")
end
