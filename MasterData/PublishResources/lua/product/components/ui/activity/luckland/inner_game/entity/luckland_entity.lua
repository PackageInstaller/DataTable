_class("LuckLandEntity", Object)
LuckLandEntity = LuckLandEntity

function LuckLandEntity:Constructor(gameModule)
  self._gameModule = gameModule
  self._configMng = self._gameModule:GetConfigMng()
  self._resType = LuckLandCardResType.None
  self._resBase = 0
  self._resAccFix = 0
  self._resAccPer = 0
  self._resTempFix = 0
  self._resTempPer = 0
  self._resFinalTempFactor = 0
  self._resFinalTempMul = 0
  self._buffArray = {}
  self._buffTempValueDic = {}
end

function LuckLandEntity:GetLuckLandModule()
  return self._gameModule
end

function LuckLandEntity:Initialize(ID, templateID)
  self._ID = ID
  self._templateID = templateID
  self:InitData(self._templateID)
  self:InitBuffArray()
end

function LuckLandEntity:ID()
  return self._ID
end

function LuckLandEntity:GetTemplateID()
  return self._templateID
end

function LuckLandEntity:SetTemplateID(tempId)
  self._templateID = tempId
end

function LuckLandEntity:CostCountDown()
  if not self._countDown then
    return
  end
  self._countDown = self._countDown - 1
end

function LuckLandEntity:GetCountDown()
  if not self._countDown then
    return
  end
  return self._countDown
end

function LuckLandEntity:ResetCountDown()
  if not self._countDown then
    return
  end
  self._countDown = self._cfg:GetCountDown()
end

function LuckLandEntity:SetResType(resType)
  self._resType = resType
end

function LuckLandEntity:SetResBaseValue(value)
  self._resBase = value
end

function LuckLandEntity:GetResType()
  return self._resType
end

function LuckLandEntity:AddAccFixValue(val)
  self._resAccFix = self._resAccFix + val
end

function LuckLandEntity:AddAccPerValue(val)
  self._resAccPer = self._resAccPer + val
end

function LuckLandEntity:AddTempFixValue(val)
  self._resTempFix = self._resTempFix + val
end

function LuckLandEntity:AddTempPerValue(val)
  self._resTempPer = self._resTempPer + val
end

function LuckLandEntity:AddFinalTempFactorValue(val)
  self._resFinalTempFactor = self._resFinalTempFactor + val
end

function LuckLandEntity:SetFinalTempMulValue(val)
  self._resFinalTempMul = val
end

function LuckLandEntity:SetFinalTempZero(val)
  self._resTempZero = val
end

function LuckLandEntity:SetTempMove(moveType)
  self._tempMoveType = moveType
end

function LuckLandEntity:GetTempMove()
  return self._tempMoveType
end

function LuckLandEntity:ResetTempParam()
  self._resTempFix = 0
  self._resTempPer = 0
  self._resFinalTempFactor = 0
  self._resFinalTempMul = 0
  self._resTempZero = false
  self._tempMoveType = nil
  self._gold = 0
  self._buffTempValueDic = {}
end

function LuckLandEntity:CalculateRes()
  if self._resType == LuckLandCardResType.None then
    return
  end
  if self._resTempZero then
    return 0
  end
  local val = (self._resBase + self._resAccFix) * (1 + self._resAccPer + self._resTempPer) + self._resTempFix
  val = val * (1 + self._resFinalTempFactor)
  if 0 < self._resFinalTempMul then
    val = val * self._resFinalTempMul
  end
  return lmathext.round(val + LuckLandConst.Epsilon)
end

function LuckLandEntity:CalculateResBag()
  if self._resType == LuckLandCardResType.None then
    return
  end
  if self._resTempZero then
    return 0
  end
  local val = (self._resBase + self._resAccFix) * (1 + self._resAccPer)
  return lmathext.round(val + LuckLandConst.Epsilon)
end

function LuckLandEntity:AddDirectGold(gold)
  if not self._gold then
    self._gold = 0
  end
  self._gold = self._gold + gold
end

function LuckLandEntity:SetDirectGold(gold)
  self._gold = gold
end

function LuckLandEntity:GetDirectGold()
  if self._gold == nil then
    self._gold = 0
  end
  return self._gold
end

function LuckLandEntity:InitBuffArray()
  local buffIDList = self._cfg:GetBuffIDList()
  if not buffIDList then
    return
  end
  local buffMng = self._gameModule:GetBuffMng()
  for _, buffID in ipairs(buffIDList) do
    local buff = buffMng:CreateBuff(buffID, self)
    if buff then
      table.insert(self._buffArray, buff)
    end
  end
end

function LuckLandEntity:GetBuffArray()
  return self._buffArray
end

function LuckLandEntity:SetTempValue(key, value)
  self._buffTempValueDic[key] = value
end

function LuckLandEntity:GetTempValue(key)
  return self._buffTempValueDic[key]
end

function LuckLandEntity:ClearTempValues()
  self._buffTempValueDic = {}
end

function LuckLandEntity:GetEntityType()
  return self._entityType
end
