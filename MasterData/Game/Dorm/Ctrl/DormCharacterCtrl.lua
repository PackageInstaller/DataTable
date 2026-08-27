local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormCharacterCtrl = class("DormCharacterCtrl", DormCtrlBase)
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormRoomCharacterCtrl = require("Game.Dorm.Character.DormRoomCharacterCtrl")
local DormInterPointEntity = require("Game.Dorm.Entity.DormInterPointEntity")
local CS_Physics = CS.PhysicsUtility
local CS_LeanTouch = CS.Lean.Touch.LeanTouch

function DormCharacterCtrl:ctor(dormCtrl)
  self.dormCtrl = dormCtrl
  self.houseCtrl = dormCtrl.houseCtrl
  self.__onUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__onUpdate)
  self.__charcterActive = false
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__OnDormBindRoleChanged = BindCallback(self, self.OnDormBindRoleChanged)
  MsgCenter:AddListener(eMsgEventId.DormBindRoleChanged, self.__OnDormBindRoleChanged)
  self.__OnDormUnbindSwitchChanged = BindCallback(self, self.OnDormUnbindSwitchChanged)
  MsgCenter:AddListener(eMsgEventId.DormUnbindSwitchChanged, self.__OnDormUnbindSwitchChanged)
  self.__OnChangeHeroSkin = BindCallback(self, self.OnChangeHeroSkin)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnChangeHeroSkin)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnChangeHeroSkin)
end

function DormCharacterCtrl:OnEnterDormScene()
  self.__interPointPool = {}
  self.__dragIndicatorGo = self.dormCtrl.comRes.selectRolePrefab:Instantiate()
  self.__dragIndicatorGo:SetActive(false)
end

function DormCharacterCtrl:OnEnterDormHouse()
  self:__InitCharacterCtrl()
  self.__charcterActive = true
end

function DormCharacterCtrl:GetActiveRoomCount()
  return self.__activeRoomCount
end

function DormCharacterCtrl:IsDormCharacterActive()
  return self.__charcterActive
end

function DormCharacterCtrl:OnEnterDormHouseEditMode()
  self.__charcterActive = false
end

function DormCharacterCtrl:OnExitDormHouseEditMode(success)
  self.__charcterActive = true
end

function DormCharacterCtrl:OnEnterDormRoomEditMode(roomEntity)
  self.__charcterActive = false
  for k, v in pairs(self.roomCharacter) do
    v:HidePauseRoomCharacter()
  end
end

function DormCharacterCtrl:OnExitDormRoomEditMode(roomEntity, success)
  local pos = roomEntity.spos
  self.__charcterActive = true
  self:ResetRoomCharacter(pos)
  if not success then
    for k, v in pairs(self.roomCharacter) do
      v:ShowResumeRoomCharacter()
    end
    return
  end
  for k, v in pairs(self.roomCharacter) do
    if k ~= pos then
      v:ShowResumeRoomCharacter()
    end
  end
end

function DormCharacterCtrl:OnEnterDormRoomEnd(roomEntity)
  CS_LeanTouch.OnFingerDown("+", self.__onFingerDown)
  CS_LeanTouch.OnFingerSet("+", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("+", self.__onFingerUp)
  self.roomEntity = roomEntity
  local roomCharacterCtrl = DormRoomCharacterCtrl.New(self, roomEntity)
  self.roomCharacter[roomEntity.spos] = roomCharacterCtrl
  self:SetCurRoomCharacterCtrl()
  self:FirstAddUnBindCharacter()
  roomCharacterCtrl:StartCharacterLogic()
end

function DormCharacterCtrl:OnExitDormRoomStart(roomEntity, toOtherRoom)
  if toOtherRoom then
    self:BeforeEnterNextRoom()
  end
  if self.curRoomCharCtrl ~= nil then
    self.curRoomCharCtrl:UnSetAsEnterActiveRoom()
  end
  roomEntity.roomData:ClearDormRoom()
  self.roomEntity = nil
  self.roomCharacter[roomEntity.spos] = nil
  if self.curRoomCharCtrl ~= nil then
    self.curRoomCharCtrl:OnDelete()
    self.curRoomCharCtrl = nil
  end
  CS_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  CS_LeanTouch.OnFingerSet("-", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("-", self.__onFingerUp)
end

function DormCharacterCtrl:GetRoomCharacterCtrl(roomEntity)
  local roomCharCtrl = self.roomCharacter[roomEntity.spos]
  return roomCharCtrl
end

function DormCharacterCtrl:__InitCharacterCtrl()
  self.roomCharacter = {}
end

function DormCharacterCtrl:OnDormBindRoleChanged()
  if self.roomEntity == nil then
    return
  end
  self:__ReGenUnbindCharList()
  self:ResetRoomCharacter(self.roomEntity.spos, true)
end

function DormCharacterCtrl:OnDormUnbindSwitchChanged(opDic)
  if self.roomEntity == nil then
    return
  end
  local changeValue = opDic[self.roomEntity.spos]
  if changeValue ~= nil then
    if changeValue then
      self:__RandAddUnBindCharacterEvenly(true)
    else
      self:ResetRoomCharacter(self.roomEntity.spos)
    end
  end
end

function DormCharacterCtrl:BeforeEnterNextRoom()
  if self.curRoomCharCtrl == nil then
    return
  end
  self.__lastUnbindIds = self.curRoomCharCtrl:GetRoomUnbindCharacterId()
end

function DormCharacterCtrl:FirstAddUnBindCharacter()
  self:__ReGenUnbindCharList()
  self:__RandAddUnBindCharacterEvenly()
  if self.__lastUnbindIds ~= nil then
    for heroId, _ in pairs(self.__lastUnbindIds) do
      table.insert(self.unbindCharList, heroId)
    end
    self.__lastUnbindIds = nil
  end
end

function DormCharacterCtrl:__ReGenUnbindCharList()
  local allBindFntData = self.dormCtrl:GetAllBindFntData()
  if allBindFntData == nil then
    return
  end
  self.unbindCharList = {}
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    if allBindFntData.boundDic[heroId] == nil and (self.__lastUnbindIds == nil or self.__lastUnbindIds[heroId] == nil) then
      table.insert(self.unbindCharList, heroId)
    end
  end
end

function DormCharacterCtrl:__RandAddUnBindCharacterEvenly(starAI, resetCharCtrl)
  if isEditorMode and (resetCharCtrl ~= nil or self.roomEntity ~= nil) then
    local customeDormHero = CS.GMController.Instance.CustomeDormHero
    if not string.IsNullOrEmpty(customeDormHero) then
      local heroIds = string.split(customeDormHero, "|")
      if 0 < #heroIds then
        resetCharCtrl = resetCharCtrl or self.roomCharacter[self.roomEntity.spos]
        for _, heroId in pairs(heroIds) do
          local heroData = PlayerDataCenter.heroDic[tonumber(heroId)]
          if heroData == nil then
            error("current not heroData heroId:" .. tostring(heroId))
          else
            local charEntity = resetCharCtrl:AddUnBindCharacter(heroData, 9999999)
          end
        end
        return
      end
    end
  end
  local roomCtrl = self.curRoomCharCtrl
  if not roomCtrl.roomData:GetEnableUnbind() then
    return
  end
  local nowRoleCount = roomCtrl:GetRoomCharacterCount()
  local MaxRoomRole = roomCtrl:GetDormRoomMaxHero()
  while nowRoleCount < MaxRoomRole and 0 < #self.unbindCharList do
    if not roomCtrl:IsRoomCharacterFull() then
      nowRoleCount = nowRoleCount + 1
      local sign = math.random(100)
      if not (sign > 100 - ConfigData.game_config.DormUnbindRoleChance) then
        local index = math.random(#self.unbindCharList)
        local heroId = self.unbindCharList[index]
        local heroData = PlayerDataCenter.heroDic[heroId]
        local charEntity = roomCtrl:AddUnBindCharacter(heroData)
        if charEntity ~= nil then
          table.remove(self.unbindCharList, index)
          if starAI then
            charEntity:StartAIBehavior()
          end
        end
      end
    end
  end
end

function DormCharacterCtrl:RandChangeUnBindCharacter(roomCtrl, oldEntity, action)
  local charEntity
  local sign = math.random(100)
  if #self.unbindCharList > 0 and sign <= 100 - ConfigData.game_config.DormUnbindRoleChance then
    local index = math.random(#self.unbindCharList)
    local heroId = self.unbindCharList[index]
    local heroData = PlayerDataCenter.heroDic[heroId]
    charEntity = roomCtrl:AddUnBindCharacterAction(heroData, action)
    if charEntity ~= nil then
      table.remove(self.unbindCharList, index)
    end
  end
  table.insert(self.unbindCharList, oldEntity.heroData.dataId)
  return charEntity
end

function DormCharacterCtrl:RangeOtherNoFullRoomCtrl(roomCtrl)
  local activeRoomList = {}
  for pos, v in pairs(self.roomCharacter) do
    if v ~= roomCtrl and not v:IsRoomCharacterFull() then
      table.insert(activeRoomList, v)
    end
  end
  if #activeRoomList == 0 then
    return nil
  end
  local index = math.random(#activeRoomList)
  return activeRoomList[index]
end

function DormCharacterCtrl:ResetDormCharacter()
  for k, v in pairs(self.roomCharacter) do
    v:OnDelete()
  end
  self:OnEnterDormHouse()
end

function DormCharacterCtrl:ResetRoomCharacter(pos, totalReset)
  local oldCharCtrl = self.roomCharacter[pos]
  local lastHeroDic
  if oldCharCtrl ~= nil then
    lastHeroDic = oldCharCtrl:GetRoomCharcterIdDic()
    oldCharCtrl:OnDelete()
  else
    lastHeroDic = {}
  end
  local roomEntity = self.houseCtrl.roomEnityDic[pos]
  if roomEntity == nil or roomEntity:IsEmptyRoom() then
    return
  end
  local roomCharacterCtrl = DormRoomCharacterCtrl.New(self, roomEntity)
  self.roomCharacter[pos] = roomCharacterCtrl
  self:SetCurRoomCharacterCtrl()
  local roomCtrl = self.curRoomCharCtrl
  local nowRoleCount = roomCharacterCtrl:GetRoomCharacterCount()
  local MaxRoomRole = roomCharacterCtrl:GetDormRoomMaxHero()
  local allBindFntData = self.dormCtrl:GetAllBindFntData()
  if allBindFntData == nil then
    roomCharacterCtrl:StartCharacterLogic()
    return
  end
  local addedUnbindHeros = {}
  if roomEntity.roomData:GetEnableUnbind() then
    for heroId, _ in pairs(lastHeroDic) do
      if nowRoleCount >= MaxRoomRole then
        break
      end
      if allBindFntData.boundDic[heroId] == nil then
        addedUnbindHeros[heroId] = true
        nowRoleCount = nowRoleCount + 1
        local heroData = PlayerDataCenter.heroDic[heroId]
        local charEntity = roomCtrl:AddUnBindCharacter(heroData)
      end
    end
  end
  if totalReset then
    for i = #self.unbindCharList, 1, -1 do
      local heroId = self.unbindCharList[i]
      if addedUnbindHeros[heroId] then
        table.remove(self.unbindCharList, i)
      end
    end
  else
    for heroId, _ in pairs(lastHeroDic) do
      if allBindFntData.boundDic[heroId] == nil and not addedUnbindHeros[heroId] then
        table.insert(self.unbindCharList, heroId)
      end
    end
  end
  roomCharacterCtrl:StartCharacterLogic()
end

function DormCharacterCtrl:SetCurRoomCharacterCtrl()
  self.curRoomCharCtrl = self.roomCharacter[self.roomEntity.spos]
  self.curRoomCharCtrl:SetAsEnterActiveRoom()
end

function DormCharacterCtrl:SetBindCharacterChange(fntData, oldHeroId, newHeroId)
  local successOld = false
  local findNewHero = false
  local newCharacterEntity
  if oldHeroId ~= nil then
    for _, roomCtrl in pairs(self.roomCharacter) do
      if not successOld then
        successOld = roomCtrl:DeleteCharacterById(oldHeroId)
        if successOld then
          table.insert(self.unbindCharList, oldHeroId)
        end
      end
      if not findNewHero then
        newCharacterEntity = roomCtrl:GetCharacterEntityById(newHeroId)
        if newCharacterEntity ~= nil then
          findNewHero = true
          roomCtrl:RemoveCharacterEntity(newCharacterEntity)
        end
      end
    end
  end
  local roomData = fntData:GetFntRoom()
  local roomCtrl = self.roomCharacter[roomData.spos]
  local heroData = PlayerDataCenter.heroDic[newHeroId]
  if roomCtrl == nil or heroData == nil then
    return
  end
  if newCharacterEntity ~= nil then
    roomCtrl:AddCharacterEntity(newCharacterEntity)
    newCharacterEntity:ResetToDoorCoord()
    newCharacterEntity:StartAIBehavior()
  else
    if roomCtrl:IsRoomCharacterFull() then
      roomCtrl:RandRemoveUnBindCharacter()
    end
    roomCtrl:AddBindCharacter(heroData, fntData)
  end
end

function DormCharacterCtrl:GenInterPointEntity(interPoint, unityPos)
  local interPointEntity
  if #self.__interPointPool > 0 then
    interPointEntity = table.remove(self.__interPointPool)
  else
    interPointEntity = DormInterPointEntity.New()
  end
  return interPointEntity
end

function DormCharacterCtrl:RecoveryInterPoint(pointEntity)
  pointEntity:ClearPointEntityData()
  table.insert(self.__interPointPool, pointEntity)
end

function DormCharacterCtrl:OnUpdate()
  if not self.__charcterActive or self.roomCharacter == nil then
    return
  end
  for spos, roomCharacterCtrl in pairs(self.roomCharacter) do
    roomCharacterCtrl:OnUpdate()
  end
end

function DormCharacterCtrl:SetSelectCharacter(charEntity)
  self.__selectCharEntity = charEntity
  self.__selectCharEntity:SetCharacterOperateStart()
  self.__dragIndicatorGo:SetActive(true)
  self:SetDragIndicatorPosition(self.__selectCharEntity.x, self.__selectCharEntity.y)
  MsgCenter:Broadcast(eMsgEventId.OnDormCharacterOpChanged, true)
end

function DormCharacterCtrl:SetDragIndicatorPosition(x, y)
  local pos = DormUtil.GetFntUnityCoord(self.__selectCharEntity.x, self.__selectCharEntity.y)
  self.__dragIndicatorGo.transform.position = self.curRoomCharCtrl.roomEntity.fntHolder:TransformPoint(pos)
end

function DormCharacterCtrl:OnFingerDown(finger)
  if self.dormCtrl.state ~= DormEnum.eDormState.Room or finger.IsOverGui then
    return
  end
  if not self.dormCtrl.cmderCtrl:IsCmderInteractStateNone() then
    return
  end
  if self.curRoomCharCtrl == nil then
    return
  end
  if self.__selectCharEntity ~= nil then
    return
  end
  local hits = CS_Physics.Raycast(self.dormCtrl.bind.camera, 1 << LayerMask.Raycast, true)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) and hitCollider.tag == TagConsts.Character then
      local gameObject = hitCollider.gameObject
      for k, charEntity in pairs(self.curRoomCharCtrl.characterDic) do
        if charEntity.gameObject == gameObject then
          self:SetSelectCharacter(charEntity)
          self.__fingerId = finger.Index
          break
        end
      end
      if self.__fingerId ~= nil then
        break
      end
    end
  end
end

function DormCharacterCtrl:OnFingerSet(finger)
  if self.__selectCharEntity == nil or finger.Index ~= self.__fingerId then
    return
  end
  local hits = CS_Physics.Raycast(self.dormCtrl.bind.camera, 1 << LayerMask.Raycast)
  for i = 0, hits.Length - 1 do
    local hitCollider = hits[i].collider
    if not IsNull(hitCollider) and hitCollider.tag == TagConsts.DormFloor then
      self.curRoomCharCtrl:RefreshInterPointDistanceState(finger.ScreenPosition)
      local hitPos = self.curRoomCharCtrl.roomEntity.fntHolder:InverseTransformPoint(hits[i].point)
      hitPos.y = 0
      local move, newX, newY = self.__selectCharEntity:SetCharacterPosFromUnity(hitPos)
      if move then
        self:SetDragIndicatorPosition(newX, newY)
      end
    end
  end
end

function DormCharacterCtrl:OnFingerUp(finger)
  if self.__selectCharEntity == nil or finger.Index ~= self.__fingerId then
    return
  end
  self:EndOperateCharacter()
end

function DormCharacterCtrl:EndOperateCharacter()
  if self.__selectCharEntity == nil then
    return
  end
  self.curRoomCharCtrl:FinishCharacterOperate(self.__selectCharEntity)
  self.__dragIndicatorGo:SetActive(false)
  self.__fingerId = nil
  self.__selectCharEntity = nil
  MsgCenter:Broadcast(eMsgEventId.OnDormCharacterOpChanged, false)
end

function DormCharacterCtrl:IsDragCharacter()
  if self.__fingerId ~= nil or self.__selectCharEntity ~= nil then
    return true
  end
  return false
end

function DormCharacterCtrl:OnChangeHeroSkin(changeSkinHeroId, skinId)
  if self.curRoomCharCtrl == nil then
    return
  end
  self.curRoomCharCtrl:TryRefreshCharacterModle(changeSkinHeroId)
end

function DormCharacterCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.DormBindRoleChanged, self.__OnDormBindRoleChanged)
  MsgCenter:RemoveListener(eMsgEventId.DormUnbindSwitchChanged, self.__OnDormUnbindSwitchChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnChangeHeroSkin)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnChangeHeroSkin)
  CS_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  CS_LeanTouch.OnFingerSet("-", self.__onFingerSet)
  CS_LeanTouch.OnFingerUp("-", self.__onFingerUp)
  if self.roomCharacter ~= nil then
    for spos, roomCharacterCtrl in pairs(self.roomCharacter) do
      roomCharacterCtrl:OnDelete()
    end
    self.roomCharacter = nil
  end
  UpdateManager:RemoveUpdate(self.__onUpdate)
end

return DormCharacterCtrl
