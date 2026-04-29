_class("AirLibMaker", Object)
AirLibMaker = AirLibMaker

function AirLibMaker:Constructor(socialArea, aircraftMain)
  self.m_SocialArea = socialArea
  self.m_AirMain = aircraftMain
  self.m_PointHolder = nil
  self.m_CenterPos = nil
  self.m_GatherCirclePosList = {}
  self.m_CurGatherCircleIdx = 0
  self.m_CloserCirclePosList = {}
  self.m_CurCloserCircleIdx = 0
  self.m_Furniture = self.m_SocialArea:GetFurniture()
  self.m_FurniturePoints = {}
  self.m_FurnitureIndex = 0
  self:InitSeqMaker()
  self:InitHolder()
end

function AirLibMaker:InitSeqMaker()
  if AirHelper.IsActionSeqFurniture(self.m_Furniture) then
    local fType = self.m_Furniture:Type()
    self.m_SeqMaker = AirActionSeqMaker:New(table.count(self.m_SocialArea:GetPets()), fType)
  end
end

function AirLibMaker:GetSeqMaker()
  return self.m_SeqMaker
end

function AirLibMaker:Dispose()
  self:ReleaseAllPoint()
  self.m_CenterPos = nil
  self.m_GatherCirclePosList = {}
  self.m_CurGatherCircleIdx = 0
  self.m_CloserCirclePosList = {}
  self.m_CurCloserCircleIdx = 0
  self.m_Furniture = nil
  self.m_FurnitureIndex = 0
  if self.m_SeqMaker then
    self.m_SeqMaker:Dispose()
    self.m_SeqMaker = nil
  end
end

function AirLibMaker:InitHolder()
  if self.m_Furniture then
    self.m_PointHolder = nil
  else
    local type = self.m_SocialArea:GetAreaType()
    if type == AirSocialAreaType.Work then
      local spaceId = self.m_SocialArea:GetSpaceId()
      local room = self.m_AirMain:GetRoomBySpaceID(spaceId)
      if room then
        if self.m_SocialArea:GetMainLibType() == AirSocialActionType.Gather then
          self.m_PointHolder = room:GetGatherPointHolder()
        else
          self.m_PointHolder = room:GetPointHolder()
        end
      end
    elseif type == AirSocialAreaType.Happy then
      local restAreaType = self.m_SocialArea:GetRestAreaType()
      if self.m_SocialArea:GetMainLibType() == AirSocialActionType.Gather then
        local pointHolder = self.m_AirMain:GetPointHolder(restAreaType)
        self.m_PointHolder = pointHolder
      else
        local pointHolder = self.m_AirMain:GetGatherPointHolder(restAreaType)
        self.m_PointHolder = pointHolder
      end
    end
  end
end

function AirLibMaker:InitGatherCircle(count)
  self.m_GatherCirclePosList = {}
  self.m_CurGatherCircleIdx = 0
  self:InitCircle(count, self.m_GatherCirclePosList, 1)
end

function AirLibMaker:InitCloserCircle(count)
  self.m_CloserCirclePosList = {}
  self.m_CurCloserCircleIdx = 0
  self:InitCircle(count, self.m_CloserCirclePosList, 0.5)
end

function AirLibMaker:InitCircle(count, list)
  if not self.m_CenterPos then
    return
  end
  if count == 3 then
    local tbl = {
      0.25 * math.pi,
      0.5 * math.pi,
      0.75 * math.pi
    }
    for index, a in ipairs(tbl) do
      table.insert(list, {
        x = 1 * math.cos(a) + self.m_CenterPos.x,
        y = self.m_CenterPos.y,
        z = 1 * math.sin(a) + self.m_CenterPos.z
      })
    end
  elseif count == 2 then
    local tbl = {
      0.25 * math.pi,
      0.75 * math.pi
    }
    for index, a in ipairs(tbl) do
      table.insert(list, {
        x = 0.8 * math.cos(a) + self.m_CenterPos.x,
        y = self.m_CenterPos.y,
        z = 0.8 * math.sin(a) + self.m_CenterPos.z
      })
    end
  end
end

function AirLibMaker:GetCurPos(petTempId)
  local pets = self.m_SocialArea:GetPets()
  local pet = pets[petTempId]
  if self.m_Furniture then
    return self.m_FurniturePoints[petTempId]:MovePoint()
  else
    if pet:GetSocialLocationIndex() then
      self.m_CurGatherCircleIdx = pet:GetSocialLocationIndex()
    else
      self.m_CurGatherCircleIdx = self.m_CurGatherCircleIdx + 1
      pet:SetSocialLocationIndex(self.m_CurGatherCircleIdx)
    end
    local c = self.m_GatherCirclePosList[self.m_CurGatherCircleIdx]
    if c then
      local pos = Vector3(c.x, c.y, c.z)
      return pos
    else
      return self.m_CenterPos
    end
  end
end

function AirLibMaker:GetCloserPos()
  self.m_CurCloserCircleIdx = self.m_CurCloserCircleIdx + 1
  local c = self.m_CloserCirclePosList[self.m_CurCloserCircleIdx]
  if c then
    local pos = Vector3(c.x, c.y, c.z)
    return pos
  else
    return self.m_CenterPos
  end
end

function AirLibMaker:GetTargetPos()
  return self.m_CenterPos
end

function AirLibMaker:PopPoint(count)
  if self.m_PointHolder then
    local pointHolderIndex = self.m_SocialArea:GetSocialPointHolderIndex()
    if not pointHolderIndex then
      local point = self.m_PointHolder:PopPoint()
      local index = point:Index()
      self.m_CenterPos = point:Pos()
      self._point = point
      self.m_SocialArea:SetSocialPointHolderIndex(index, true)
    else
      local point = self.m_PointHolder:OccupyPoint(pointHolderIndex)
      if point then
        self.m_CenterPos = point:Pos()
        self._point = point
      end
    end
    self:InitGatherCircle(count)
    self:InitCloserCircle(count)
    return self.m_CenterPos
  else
    for petTempId, pet in pairs(self.m_SocialArea:GetPets()) do
      local point
      if pet:GetSocialLocationIndex() then
        if not self.m_Furniture:HasPoint(pet:GetSocialLocationIndex()) then
          Log.exception("社交家具行为反序列化找家具入驻点失败，存的为", pet:GetSocialLocationIndex(), "目标家具为：", self.m_Furniture:GetPstKey())
          point = self.m_Furniture:PopPoint()
          AirLog("社交获取一个家具点，家具：", self.m_Furniture:CfgID(), "，索引：", point:Index())
          if point then
            pet:SetSocialLocationIndex(point:Index())
          end
        else
          AirLog("社交反序列化占据一个家具点，家具ID：", self.m_Furniture:CfgID(), "，索引：", pet:GetSocialLocationIndex())
          point = self.m_Furniture:OccupyPointByIndex(pet:GetSocialLocationIndex())
        end
      else
        point = self.m_Furniture:PopPoint()
        if point then
          pet:SetSocialLocationIndex(point:Index())
        end
        AirLog("社交获取一个家具点，家具：", self.m_Furniture:CfgID(), "，索引：", point:Index())
      end
      self.m_FurniturePoints[petTempId] = point
    end
  end
end

function AirLibMaker:ReleasePoint()
  if table.count(self.m_FurniturePoints) > 0 then
    self:_ReleaseFurniturePoints()
  else
    if self._point then
      self.m_PointHolder:ReleasePoint(self._point)
    end
    self.m_SocialArea:SetSocialPointHolderIndex(nil, true)
    self._point = nil
  end
end

function AirLibMaker:GetFurniturePoint(petTempID)
  return self.m_FurniturePoints[petTempID]
end

function AirLibMaker:_ReleaseFurniturePoints()
  self.m_FurniturePoints = {}
end

function AirLibMaker:ReleaseAllPoint()
  if self.m_PointHolder and self._point then
    self.m_PointHolder:ReleasePoint(self._point)
  end
  self.m_PointHolder = nil
  self:_ReleaseFurniturePoints()
end

function AirLibMaker:GetFurniture()
  return self.m_Furniture
end
