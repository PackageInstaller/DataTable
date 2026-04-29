require("homelandpet_component_base")
_class("HomelandPetComponentBubble", HomelandPetComponentBase)
HomelandPetComponentBubble = HomelandPetComponentBubble
local HomePetBubbleType = {Bubble = 1, Tex = 2}
_enum("HomePetBubbleType", HomePetBubbleType)
local HomePetBubble = {
  None = 0,
  Happy = 1,
  Sad = 2
}
_enum("HomePetBubble", HomePetBubble)

function HomelandPetComponentBubble:Constructor(componentType, pet, behavior)
  HomelandPetComponentBubble.super.Constructor(self, componentType, pet, behavior)
  local homeModule = GameGlobal.GetUIModule(HomelandModule)
  local homeClient = homeModule:GetClient()
  self._effMng = homeClient:GetHomelandSceneEffectManager()
  self._canShow = true
  self._randomBubbleID = 0
end

function HomelandPetComponentBubble:OnExcute()
  if self.state == HomelandPetComponentState.Resting then
    if self._randomBubbleID <= 0 then
      self.state = HomelandPetComponentState.Success
      return
    end
    self._cfg = Cfg.cfg_home_pet_bubble[self._randomBubbleID]
    if not self._cfg then
      self.state = HomelandPetComponentState.Success
      Log.error("###[HomelandPetComponentBubble] cfg_home_pet_bubble is nil ! id --> ", self._randomBubbleID)
      return
    end
    self:_Stop()
    self._params = self._cfg.Params
    self._faceSeq = self._cfg.FaceSeq
    if self._cfg.Offset then
      self._offset = Vector3(self._cfg.Offset[1], self._cfg.Offset[2], self._cfg.Offset[3])
    else
      self._offset = Vector3(0, 0, 0)
    end
    if self._cfg.Scale then
      self._scale = Vector3(self._cfg.Scale[1], self._cfg.Scale[2], self._cfg.Scale[3])
    else
      self._scale = Vector3(1, 1, 1)
    end
    self._length = self._cfg.Length
    local homeModule = GameGlobal.GetUIModule(HomelandModule)
    local homeClient = homeModule:GetClient()
    self._camera = homeClient:CameraManager()
    self._type = self._cfg.Type
    if self._type == HomePetBubbleType.Bubble then
      self:_ShowBubble()
    elseif self._type == HomePetBubbleType.Tex then
      self:_ShowTex()
    end
    self._faceSeq = {}
    self._faceIdx = 1
    self._curTime = 0
    if self._cfg.FaceSeq then
      for i, value in ipairs(self._cfg.FaceSeq) do
        local face = {}
        face.frame = value[1]
        local time = value[2]
        face.time = time
        self._faceSeq[#self._faceSeq + 1] = face
      end
      self:_SetFace(self._faceSeq[1].frame)
      self._hasFace = true
    else
      self._hasFace = false
    end
    self.state = HomelandPetComponentState.Running
  end
end

function HomelandPetComponentBubble:Exit()
  HomelandPetComponentBubble.super.Exit(self)
  self:_Stop()
end

function HomelandPetComponentBubble:Show()
  local _petid = self._pet:TemplateID()
  local _self = 1
  local _type = self._pet:GetPetBehavior():GetCurBehaviorType()
  local cfgs = Cfg.cfg_home_pet_solilo({
    PetID = _petid,
    Self = _self,
    State = _type
  })
  if cfgs and table.count(cfgs) > 0 then
    local cfg = cfgs[1]
    if _type == HomelandPetBehaviorType.InteractingFurniture then
      local build = self._pet:GetInteractingBuilding()
      local buildID = build:GetBuildId()
      local buildRandomList = cfg.BuildRandomList
      if buildRandomList[buildID] then
        self._randomList = buildRandomList[buildID]
      else
        self._randomList = cfg.RandomList
      end
    else
      self._randomList = cfg.RandomList
    end
  else
    self._randomList = nil
  end
  if self._randomBubbleID ~= 0 then
    return
  end
  if not self._randomList then
    return
  end
  self._randomBubbleID = self:RandomID()
end

function HomelandPetComponentBubble:SetBubbleID(bubbleID)
  self._randomBubbleID = bubbleID
end

function HomelandPetComponentBubble:_SetFace(frame)
  if self._pet then
    local mat = self._pet:GetFaceMat()
    if mat then
      mat:SetInt("_Frame", frame)
    end
  end
end

function HomelandPetComponentBubble:ShowBubble(bubble)
  self._cfg = Cfg.cfg_home_pet_bubble[bubble]
  if not self._cfg then
    self.state = HomelandPetComponentState.Success
    Log.error("###[HomelandPetComponentBubble] cfg_home_pet_bubble is nil ! id --> ", self._randomBubbleID)
    return
  end
  self:_Stop()
  self._params = self._cfg.Params
  self._faceSeq = self._cfg.FaceSeq
  if self._cfg.Offset then
    self._offset = Vector3(self._cfg.Offset[1], self._cfg.Offset[2], self._cfg.Offset[3])
  else
    self._offset = Vector3(0, 0, 0)
  end
  if self._cfg.Scale then
    self._scale = Vector3(self._cfg.Scale[1], self._cfg.Scale[2], self._cfg.Scale[3])
  else
    self._scale = Vector3(1, 1, 1)
  end
  self._length = self._cfg.Length
  local homeModule = GameGlobal.GetUIModule(HomelandModule)
  local homeClient = homeModule:GetClient()
  self._camera = homeClient:CameraManager()
  self._type = self._cfg.Type
  if self._type == HomePetBubbleType.Bubble then
    self:_ShowBubble()
  elseif self._type == HomePetBubbleType.Tex then
    self:_ShowTex()
  end
  self._faceSeq = {}
  self._faceIdx = 1
  self._curTime = 0
  if self._cfg.FaceSeq then
    for i, value in ipairs(self._cfg.FaceSeq) do
      local face = {}
      face.frame = value[1]
      local time = value[2]
      face.time = time
      self._faceSeq[#self._faceSeq + 1] = face
    end
    self:_SetFace(self._faceSeq[1].frame)
    self._hasFace = true
  else
    self._hasFace = false
  end
  self.state = HomelandPetComponentState.Running
  return self._length
end

function HomelandPetComponentBubble:_ShowBubble()
  local anis = self._cfg.BubbleAni
  if anis == nil then
    anis = {}
  end
  self._bubbleEffectID, self._bubbleitem = self._effMng:NewEffect(self._params, anis[1], anis[2], anis[3])
  self._effMng:SetScale(self._bubbleEffectID, self._scale)
  self._effMng:Execute(self._bubbleEffectID)
  self:UpdateBubblePos()
  if self._bubbleitem then
    self._bubbleitem:SetVisible(self._canShow)
  end
end

function HomelandPetComponentBubble:UpdateBubblePos()
  local rot = self._camera:Rotation()
  local pos = self._pet:HeadPos() + self._offset
  self._effMng:UpdatePosRota(self._bubbleEffectID, pos, rot)
end

function HomelandPetComponentBubble:Setvisible(value)
  if self._bubbleEffectID then
    self._effMng:SetVisible(self._bubbleEffectID, value)
  end
end

function HomelandPetComponentBubble:_ShowTex()
  local homeModule = GameGlobal.GetUIModule(HomelandModule)
  local homeClient = homeModule:GetClient()
  self._3duiMgr = homeClient:Home3DUIManager()
  self._talkUnit = self._3duiMgr:GetTalkUnit()
  if not self._talkUnit then
    return
  end
  self._talkUnit:SetTex(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(self._params)))
end

function HomelandPetComponentBubble:RandomID()
  if self._randomList == nil then
    return 0
  end
  local id = 0
  local all = 0
  local weightTab = {}
  for i = 1, #self._randomList do
    all = all + self._randomList[i][2]
    local weightTabItem = {}
    weightTabItem.id = self._randomList[i][1]
    weightTabItem.weight = all
    table.insert(weightTab, weightTabItem)
  end
  if all < 1 then
    all = 1
  end
  local randomNumber = math.random(1, all)
  for i = 1, #weightTab do
    if randomNumber <= weightTab[i].weight then
      id = weightTab[i].id
      break
    end
  end
  return id
end

function HomelandPetComponentBubble:Update(deltaTime)
  self._curTime = self._curTime + deltaTime
  if self._length > 0 and self._curTime >= self._length then
    self:_Stop()
    self.state = HomelandPetComponentState.Success
  else
    if self._type == HomePetBubbleType.Tex then
      if self._talkUnit then
        local pos = self._pet:HeadPos()
        local petName = self._pet:TemplateID()
        self._talkUnit:SetPos(pos)
        local rot = self._camera:Rotation()
        self._talkUnit:SetRotation(rot)
      end
    elseif self._type == HomePetBubbleType.Bubble and self._bubbleEffectID then
      self:UpdateBubblePos()
    end
    if self._hasFace and self._faceIdx <= #self._faceSeq and self._curTime > self._faceSeq[self._faceIdx].time then
      self._faceIdx = self._faceIdx + 1
      if self._faceIdx <= #self._faceSeq then
        self:_SetFace(self._faceSeq[self._faceIdx].frame)
      end
    end
  end
end

function HomelandPetComponentBubble:_Stop()
  if self._type == HomePetBubbleType.Tex then
    if self._talkUnit then
      self._3duiMgr:ReturnTalkUnit(self._talkUnit)
      self._talkUnit = nil
    end
  elseif self._type == HomePetBubbleType.Bubble then
    if self._bubbleEffectID then
      self._effMng:Exit(self._bubbleEffectID)
    end
    self._bubbleEffectID = nil
  end
  self._type = nil
end

function HomelandPetComponentBubble:Hide()
  self:_Stop()
end

function HomelandPetComponentBubble:SetCanShowBubble(canShow)
  self._canShow = canShow
end
