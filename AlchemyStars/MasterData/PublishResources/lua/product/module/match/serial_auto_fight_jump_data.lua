_class("SerialAutoFightJumpData", Object)
SerialAutoFightJumpData = SerialAutoFightJumpData
local SerialAutoFight_JumpTo = {
  MainLine = 1,
  Resource = 2,
  Aircraft = 3,
  Tower = 4
}
_enum("SerialAutoFight_JumpTo", SerialAutoFight_JumpTo)
local SerialAutoFight_TrackStep = {
  Pet = 1,
  From = 2,
  Item = 3,
  Jump = 4,
  Stage = 5,
  Fin = 6
}
_enum("SerialAutoFight_TrackStep", SerialAutoFight_TrackStep)

function SerialAutoFightJumpData:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function SerialAutoFightJumpData:Constructor()
  self:Jump_Clear()
  self:Track_Init()
end

function SerialAutoFightJumpData:Dispose()
end

function SerialAutoFightJumpData:JumpBack()
  if string.isnullorempty(self._jumpFrom.fromUi) then
    return false
  end
  local petId = self._jumpFrom.petId
  local uiName = self._jumpFrom.fromUi
  local uiPetModule = GameGlobal.GetUIModule(PetModule)
  uiPetModule:JumpToPetUI(petId, uiName)
  local str = UILogHelper.ParamsFormatString({petId = petId, uiName = uiName})
  Log.info("SerialAutoFightJumpData:JumpBack() ", str)
  return true
end

function SerialAutoFightJumpData:Jump_Clear()
  Log.info("SerialAutoFightJumpData:Jump_Clear()")
  self._jumpTo = {
    toType = 0,
    data = {}
  }
  self._jumpFrom = {
    fromUi = "",
    petId = 0,
    itemId = 0,
    itemCondition = 0
  }
end

function SerialAutoFightJumpData:IsShowTargetItem(data)
  if self._bForceShowTarget then
    return true
  end
  if self._jumpFrom.itemId == nil or self._jumpFrom.itemCondition == nil then
    return false
  end
  if self._jumpTo == nil then
    return false
  end
  local targetType = self._jumpTo.toType
  local targetData = self._jumpTo.data
  local isSame = table.equal(targetData, data)
  return isSame
end

function SerialAutoFightJumpData:SetForceShowTarget(itemId, itemCondition)
  self._forceShowItmeId = itemId
  self._forceShowItemCondition = itemCondition
  if not itemId or not itemCondition then
    self._bForceShowTarget = nil
  else
    self._bForceShowTarget = true
  end
end

function SerialAutoFightJumpData:GetTargetItem()
  if self._bForceShowTarget then
    return self._forceShowItmeId, self._forceShowItemCondition
  end
  local itemId = self._jumpFrom and self._jumpFrom.itemId
  local itemCondition = self._jumpFrom and self._jumpFrom.itemCondition
  return itemId, itemCondition
end

function SerialAutoFightJumpData:OpenOptionAgain(useNew)
  local option = self._option
  if option then
    option.toIndex = 2
    local uiName = useNew and "UISerialAutoFightOptionNew" or "UISerialAutoFightOption"
    GameGlobal.UIStateManager():ShowDialog(uiName, option)
  end
end

function SerialAutoFightJumpData:Track_Init()
  Log.info("SerialAutoFightJumpData:Track_Init()")
  self._track = {
    step = SerialAutoFight_TrackStep.Pet,
    _jumpFrom = {},
    _jumpTo = {}
  }
end

function SerialAutoFightJumpData:Track_Pet(petId)
  local str = UILogHelper.ParamsFormatString({petId = petId})
  Log.info("SerialAutoFightJumpData:Track_From() ", str)
  local step = SerialAutoFight_TrackStep.Pet
  if self:_TrackCheck(step, petId) then
    self._track._jumpFrom.petId = petId
  end
end

function SerialAutoFightJumpData:Track_From(fromUi)
  local str = UILogHelper.ParamsFormatString({fromUi = fromUi})
  Log.info("SerialAutoFightJumpData:Track_From() ", str)
  local step = SerialAutoFight_TrackStep.From
  if self:_TrackCheck(step, fromUi) then
    self._track._jumpFrom.fromUi = fromUi
  end
end

function SerialAutoFightJumpData:Track_Item(itemId, itemCondition)
  if itemId ~= nil and itemCondition == nil then
    return
  end
  local str = UILogHelper.ParamsFormatString({itemId = itemId, itemCondition = itemCondition})
  Log.info("SerialAutoFightJumpData:Track_Item() ", str)
  local step = SerialAutoFight_TrackStep.Item
  if self:_TrackCheck(step, itemId) then
    self._track._jumpFrom.itemId = itemId
    self._track._jumpFrom.itemCondition = itemCondition
  end
end

function SerialAutoFightJumpData:Track_Jump(idJump)
  local str = UILogHelper.ParamsFormatString({idJump = idJump})
  Log.info("SerialAutoFightJumpData:Track_Jump() ", str)
  local toType = self:_CalcJumpType(idJump)
  local step = SerialAutoFight_TrackStep.Jump
  if self:_TrackCheck(step, toType) then
    self._track._jumpTo.toType = toType
  end
end

function SerialAutoFightJumpData:Track_Stage(data)
  local nodeId = data and data.nodeId
  local mainType = data and data.mainType
  local str = UILogHelper.ParamsFormatString({nodeId = nodeId, mainType = mainType})
  Log.info("SerialAutoFightJumpData:Track_Stage() ", str)
  local step = SerialAutoFight_TrackStep.Stage
  if self:_TrackCheck(step, data) then
    self._track._jumpTo.data = data
    self._jumpFrom = self._track._jumpFrom
    self._jumpTo = self._track._jumpTo
    self:Track_Init()
  end
end

function SerialAutoFightJumpData:Track_Option(data)
  self._option = data
end

function SerialAutoFightJumpData:CreateTrackData_MainLine(nodeId, chapterId, reach, again)
  return {
    nodeId = nodeId,
    chapterId = chapterId,
    reach = reach,
    again = again
  }
end

function SerialAutoFightJumpData:CreateTrackData_Resource(mainType, gotoSubType)
  return {mainType = mainType, gotoSubType = gotoSubType}
end

function SerialAutoFightJumpData:_TrackCheck(step, data)
  local res = false
  local dir = data ~= nil and 1 or 0
  local forward = dir == 1 and step == self._track.step
  local backward = dir == 0 and step == self._track.step - 1
  if forward or backward then
    self._track.step = step + dir
    res = true
  end
  local str = UILogHelper.ParamsFormatString({
    forward = forward,
    backward = backward,
    res = res
  })
  Log.info("SerialAutoFightJumpData:_TrackCheck() ", str)
  return res
end

function SerialAutoFightJumpData:_CalcJumpType(idJump)
  if not idJump then
    return
  end
  local cfg = Cfg.cfg_jump[idJump]
  if cfg == nil then
    return
  end
  local jumpType = cfg.JumpID
  Log.info("SerialAutoFightJumpData:_CalcJumpType() UIJumpType == ", jumpType)
  local tb = {
    [UIJumpType.UI_JumpMission] = SerialAutoFight_JumpTo.MainLine,
    [UIJumpType.UI_JumpResDungeon] = SerialAutoFight_JumpTo.Resource,
    [UIJumpType.UI_JumpAircraft] = nil,
    [UIJumpType.UI_JumpTowerLayer] = nil
  }
  return tb[jumpType]
end
