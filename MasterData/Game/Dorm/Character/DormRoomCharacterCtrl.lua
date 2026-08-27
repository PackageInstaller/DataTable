local DormRoomCharacterCtrl = class("DormRoomCharacterCtrl")
local DormCharacterEntity = require("Game.Dorm.Character.Entity.DormCharacterEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local cs_DormAStarUtils = CS.DormAStarUtils

function DormRoomCharacterCtrl:ctor(characterCtrl, roomEntity)
  self.characterCtrl = characterCtrl
  self.roomEntity = roomEntity
  self.roomData = roomEntity.roomData
  self.__isCurEnterRoom = false
  self.__onUpdate = BindCallback(self, self.OnUpdate)
  self.characterDic = {}
  self.__charCount = 0
  self:InitDormRoomCharacterCtrl()
end

function DormRoomCharacterCtrl:GetRoomCharacterCount()
  return self.__charCount
end

function DormRoomCharacterCtrl:GetRoomCharcterIdDic()
  local heroIdDic = {}
  for heroId, _ in pairs(self.characterDic) do
    heroIdDic[heroId] = true
  end
  return heroIdDic
end

function DormRoomCharacterCtrl:GetRoomUnbindCharacterId()
  local heroIdDic = {}
  for heroId, charEntity in pairs(self.characterDic) do
    if not charEntity.isBind then
      heroIdDic[heroId] = true
    end
  end
  return heroIdDic
end

function DormRoomCharacterCtrl:IsRoomCharacterFull()
  return self.__charCount >= self:GetDormRoomMaxHero()
end

function DormRoomCharacterCtrl:GetDormRoomMaxHero()
  return self.roomData:GetDormRoomMaxHero()
end

function DormRoomCharacterCtrl:InitDormRoomCharacterCtrl()
  self.mapDic = setmetatable({}, {
    __index = function(tab, key)
      return 0
    end
  })
  for k, fntData in pairs(self.roomData.fntDataList) do
    local sizeX, sizeY = fntData:GetFntSize()
    DormUtil.AddFntToMapDic(self.mapDic, fntData.x, fntData.y, sizeX, sizeY, fntData.r)
  end
  local canBindfntDataList = self.roomData:GetRoomCanBindList()
  for k, fntData in ipairs(canBindfntDataList) do
    local param = fntData:GetFntParam()
    local heroData = PlayerDataCenter.heroDic[param]
    if heroData ~= nil then
      self:AddBindCharacter(heroData, fntData)
    end
  end
end

function DormRoomCharacterCtrl:TryRefreshCharacterModle(heroId)
  local charEntity = self.characterDic[heroId]
  if charEntity == nil then
    return
  end
  if not charEntity:IsHaveNewModleRes() then
    return
  end
  if not self:DeleteCharacterById(heroId) then
    return
  end
  if charEntity.isBind then
    for _, fntData in pairs(self.roomData:GetRoomCanBindList()) do
      local param = fntData:GetFntParam()
      if heroId == param then
        local heroData = PlayerDataCenter.heroDic[param]
        self:AddBindCharacter(heroData, fntData)
        return
      end
    end
  else
    local heroData = charEntity.heroData
    self:AddUnBindCharacter(heroData)
  end
end

function DormRoomCharacterCtrl:StartCharacterLogic()
  for heroId, charEntity in pairs(self.characterDic) do
    charEntity:StartAIBehavior()
  end
end

function DormRoomCharacterCtrl:__RandomUnBindActiveTime()
  local minTime = ConfigData.game_config.DormUnBindActiveTime[1]
  local maxTime = ConfigData.game_config.DormUnBindActiveTime[2]
  local time = minTime + math.random(maxTime - minTime + 1) - 1
  return time
end

function DormRoomCharacterCtrl:AddUnBindCharacter(heroData, activeTime)
  local ok, pos = cs_DormAStarUtils.RandomOnePoint(self.roomEntity.transform.position, 10000)
  if not ok then
    return
  end
  self.__charCount = self.__charCount + 1
  local charEntity = DormCharacterEntity.New(heroData, pos, self, activeTime or self:__RandomUnBindActiveTime())
  self.characterDic[heroData.dataId] = charEntity
  charEntity:LoadDormCharacter(self.roomEntity.characterHolder)
  return charEntity
end

function DormRoomCharacterCtrl:AddUnBindCharacterAction(heroData, action)
  self.__charCount = self.__charCount + 1
  local charEntity = DormCharacterEntity.New(heroData, nil, self, self:__RandomUnBindActiveTime())
  self.characterDic[heroData.dataId] = charEntity
  charEntity:LoadDormCharacter(self.roomEntity.characterHolder, action)
  return charEntity
end

function DormRoomCharacterCtrl:AddBindCharacter(heroData, fntData)
  local ok, pos = cs_DormAStarUtils.RandomOnePoint(self.roomEntity.transform.position, 10000)
  if not ok then
    return
  end
  self.__charCount = self.__charCount + 1
  local charEntity = DormCharacterEntity.New(heroData, pos, self, -1)
  self.characterDic[heroData.dataId] = charEntity
  charEntity:LoadDormCharacter(self.roomEntity.characterHolder)
end

function DormRoomCharacterCtrl:FindActivePosNearby(x, y)
  local gridLength = self.roomData:GetRoomGridLengthCount()
  if not DormUtil.IsFntCoordLegal(x, y, gridLength) then
    return
  end
  local pos = DormUtil.XYCoord2Fnt(x, y)
  if self.mapDic[pos] == 0 then
    return x, y
  end
  local pointQue = {}
  local closeQue = {}
  table.insert(pointQue, pos)
  closeQue[pos] = true
  while 0 < #pointQue do
    local pos = table.remove(pointQue, 1)
    local dx, dy = DormUtil.FntCoord2XY(pos)
    for k, v in ipairs(DormUtil.FntForOffset) do
      local idx = dx + v.x
      local idy = dy + v.y
      local ipos = DormUtil.XYCoord2Fnt(idx, idy)
      if not closeQue[ipos] and DormUtil.IsFntCoordLegal(idx, idy, gridLength) then
        if self.mapDic[ipos] == 0 then
          return idx, idy
        else
          table.insert(pointQue, ipos)
          closeQue[ipos] = true
        end
      end
    end
  end
end

function DormRoomCharacterCtrl:GetCharacterEntityById(heroId)
  local findEntity = self.characterDic[heroId]
  return findEntity
end

function DormRoomCharacterCtrl:RemoveCharacterEntity(charEntity)
  local heroId = charEntity.heroData.dataId
  local findEntity = self.characterDic[heroId]
  if findEntity == charEntity then
    self.characterDic[heroId] = nil
    self.__charCount = self.__charCount - 1
  end
end

function DormRoomCharacterCtrl:DeleteCharacterById(heroId)
  local findEntity = self.characterDic[heroId]
  if findEntity ~= nil then
    self.characterDic[heroId] = nil
    findEntity:OnDelete()
    self.__charCount = self.__charCount - 1
    return true
  end
  return false
end

function DormRoomCharacterCtrl:AddCharacterEntity(charEntity)
  local heroId = charEntity.heroData.dataId
  if self.characterDic[heroId] ~= nil then
    return
  end
  self.characterDic[heroId] = charEntity
  charEntity.transform:SetParent(self.roomEntity.characterHolder)
  charEntity:SetNewRoomCtrl(self)
  self.__charCount = self.__charCount + 1
end

function DormRoomCharacterCtrl:FindNearActivePoint(count, x, y)
  local pos = DormUtil.XYCoord2Fnt(x, y)
  local pointQue = {}
  local closeQue = {}
  local findQue = {}
  table.insert(pointQue, pos)
  closeQue[pos] = true
  while 0 < #pointQue do
    local pos = table.remove(pointQue, 1)
    local dx, dy = DormUtil.FntCoord2XY(pos)
    for k, v in ipairs(DormUtil.FntForOffset) do
      local idx = dx + v.x
      local idy = dy + v.y
      local ipos = DormUtil.XYCoord2Fnt(idx, idy)
      local gridLength = self.roomData:GetRoomGridLengthCount()
      if not closeQue[ipos] and DormUtil.IsFntCoordLegal(idx, idy, gridLength) and self.mapDic[ipos] == 0 then
        table.insert(findQue, ipos)
        table.insert(pointQue, ipos)
        closeQue[ipos] = true
      end
    end
    if count <= #findQue then
      return findQue
    end
  end
  return findQue
end

function DormRoomCharacterCtrl:OnUpdate()
  if self.characterDic == nil then
    return
  end
  for heroId, charEntity in pairs(self.characterDic) do
    charEntity:OnUpdate()
  end
end

function DormRoomCharacterCtrl:HidePauseRoomCharacter()
  for k, v in pairs(self.characterDic) do
    v:HidePauseCharacter()
  end
end

function DormRoomCharacterCtrl:ShowResumeRoomCharacter()
  for k, v in pairs(self.characterDic) do
    v:ShowResumeCharacter()
  end
end

function DormRoomCharacterCtrl:SetAsEnterActiveRoom()
  self.__isCurEnterRoom = true
  self:GenRoomInterPointEntity()
end

function DormRoomCharacterCtrl:UnSetAsEnterActiveRoom()
  if not self.__isCurEnterRoom then
    return
  end
  self.__isCurEnterRoom = false
  self:ClearSelectInterPoint()
  self:RecoveryInterPointEntity()
end

function DormRoomCharacterCtrl:GenRoomInterPointEntity()
  self.pointEntityList = {}
  for _, interPoint in pairs(self.roomData.interpoint) do
    local fntEntity = self.roomEntity:GetFntByData(interPoint.fntData)
    local offsetWorld = fntEntity.transform:TransformPoint(interPoint:GetInterOffsetCoord())
    local startPos = fntEntity.transform:TransformPoint(interPoint:GetInterStartCoord())
    local pointEntity = self.characterCtrl:GenInterPointEntity(interPoint, offsetWorld)
    pointEntity:InitInterPointEntity(interPoint, startPos, offsetWorld, fntEntity)
    table.insert(self.pointEntityList, pointEntity)
  end
end

function DormRoomCharacterCtrl:GetInterPointEntityList()
  return self.pointEntityList
end

function DormRoomCharacterCtrl:GetRoomCharacterDic()
  return self.characterDic
end

function DormRoomCharacterCtrl:RefreshInterPointDistanceState(touchScreenPos)
  if self.pointEntityList == nil then
    return
  end
  local selectPoint
  local minDistance = DormUtil.NearInterPointDistance
  for _, pointEntity in pairs(self.pointEntityList) do
    local dis = pointEntity:GetSqrDistanceToScreenTouch(touchScreenPos)
    if minDistance >= dis then
      selectPoint = pointEntity
      minDistance = dis
    end
  end
  if selectPoint == self.selectPoint then
    return
  end
  if selectPoint ~= nil and self.selectPoint ~= nil and self.selectPoint:GetPointFromFntEntity() == selectPoint:GetPointFromFntEntity() then
    self.selectPoint = selectPoint
    return
  end
  if self.selectPoint ~= nil then
    self.selectPoint:RemovePointFntHighlight()
  end
  self.selectPoint = selectPoint
  if self.selectPoint ~= nil then
    self.selectPoint:AddPointFntHighlight()
  end
end

function DormRoomCharacterCtrl:ClearSelectInterPoint()
  if self.selectPoint == nil then
    return
  end
  self.selectPoint:RemovePointFntHighlight()
  self.selectPoint = nil
end

function DormRoomCharacterCtrl:RecoveryInterPointEntity()
  if self.pointEntityList == nil then
    return
  end
  for _, pointEntity in pairs(self.pointEntityList) do
    self.characterCtrl:RecoveryInterPoint(pointEntity)
  end
  self.pointEntityList = nil
end

function DormRoomCharacterCtrl:FinishCharacterOperate(charEntity)
  if self.selectPoint ~= nil then
    local charEntity = self.selectPoint:GetInterPointData():GetBindCharacter()
    if charEntity ~= nil then
      charEntity:QuickExitAIState()
    end
  end
  charEntity:SetCharacterOperateEnd(self.selectPoint)
  self:ClearSelectInterPoint()
end

function DormRoomCharacterCtrl:ChangeCharacterToOtherRoom(charEntity)
  local roomCtrl = self.characterCtrl:RangeOtherNoFullRoomCtrl(self)
  if roomCtrl == nil then
    return false
  end
  self:RemoveCharacterEntity(charEntity)
  roomCtrl:AddCharacterEntity(charEntity)
  return true
end

function DormRoomCharacterCtrl:IsHaveOtherUnBindCharacter()
  return #self.characterCtrl.unbindCharList > 0
end

function DormRoomCharacterCtrl:ExchangeUnBindCharacter(oldEntity)
  if oldEntity ~= nil then
    self:DeleteCharacterById(oldEntity.heroData.dataId)
  end
  local wallId, worldPos, startPos = self.roomEntity:GetRoomDoorPos()
  self.characterCtrl:RandChangeUnBindCharacter(self, oldEntity, function(charEntity)
    if charEntity == nil then
      return
    end
    charEntity:SetStarAIPathActive(false)
    charEntity:SetMoveAniSpeed(1)
    charEntity.transform.rotation = DormUtil.GetDormWallRot(wallId)
    charEntity.transform.position = worldPos
    charEntity:DoMoveUnityPos(startPos, function()
      charEntity:SetMoveAniSpeed(0)
      if charEntity ~= nil then
        charEntity:StartAIBehavior(true)
      end
    end)
  end)
end

function DormRoomCharacterCtrl:HaveOtherNoFullRoom()
  local count = 0
  for _, v in pairs(self.characterCtrl.roomCharacter) do
    if v ~= self and not v:IsRoomCharacterFull() then
      count = count + 1
    end
  end
  return 0 < count
end

function DormRoomCharacterCtrl:RandRemoveUnBindCharacter()
  local unbindList = {}
  for heroId, charEntity in pairs(self.characterDic) do
    if not charEntity.isBind then
      table.insert(unbindList, heroId)
    end
  end
  if #unbindList == 0 then
    return
  end
  local index = math.random(#unbindList)
  local heroId = unbindList[index]
  self:DeleteCharacterById(heroId)
end

function DormRoomCharacterCtrl:OnDelete()
  self:ClearSelectInterPoint()
  self:UnSetAsEnterActiveRoom()
  if self.characterDic ~= nil then
    for k, v in pairs(self.characterDic) do
      v:OnDelete()
    end
  end
end

return DormRoomCharacterCtrl
