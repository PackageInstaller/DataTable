require("sp_base_inst")
_class("SkillPreviewPlayShowAtkOrSummonOnPickupPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayShowAtkOrSummonOnPickupPosInstruction = SkillPreviewPlayShowAtkOrSummonOnPickupPosInstruction

function SkillPreviewPlayShowAtkOrSummonOnPickupPosInstruction:Constructor(params)
  local strList = params.trapIDList
  local strIDs = string.split(strList, "|")
  self._trapIDList = {}
  for i = 1, #strIDs do
    local trapID = tonumber(strIDs[i])
    table.insert(self._trapIDList, trapID)
  end
  self._effectID = tonumber(params.effectID)
  self._scopeParam = {
    TargetType = tonumber(params.scopeTargetType),
    ScopeType = tonumber(params.scopeType),
    ScopeParam = {
      tonumber(params.scopeParam)
    },
    ScopeCenterType = tonumber(params.scopeCenterType)
  }
  self._matchType = tonumber(params.matchType)
  self._matchScopeParam = {
    TargetType = tonumber(params.matchScopeTargetType),
    ScopeType = tonumber(params.matchScopeType),
    ScopeParam = {
      tonumber(params.matchScopeParam)
    },
    ScopeCenterType = tonumber(params.matchScopeCenterType)
  }
  self._skinUseEffectMap = {}
  if params.skinUseEffectID then
    local splitedStrArray = string.split(params.skinUseEffectID, "|")
    local keyFlag = 1
    local key, value
    for i, v in ipairs(splitedStrArray) do
      local num = tonumber(v)
      if keyFlag == 1 then
        key = num
      else
        value = num
        self._skinUseEffectMap[key] = value
      end
      keyFlag = keyFlag + 1
      if 2 < keyFlag then
        keyFlag = 1
      end
    end
  end
end

function SkillPreviewPlayShowAtkOrSummonOnPickupPosInstruction:GetCacheResource()
  local res = {}
  local effRes = {
    Cfg.cfg_effect[self._effectID].ResPath,
    1
  }
  table.insert(res, effRes)
  for i, effectID in pairs(self._skinUseEffectMap) do
    local skinEffRes = {
      Cfg.cfg_effect[effectID].ResPath,
      1
    }
    table.insert(res, skinEffRes)
  end
  return res
end

function SkillPreviewPlayShowAtkOrSummonOnPickupPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local pickUpPos = previewContext:GetPickUpPos()
  local boardCmpt = world:GetBoardEntity():Board()
  local traps = boardCmpt:GetPieceEntities(pickUpPos, function(e)
    local isOwner = false
    if e:HasSummoner() then
      local summonEntityID = e:Summoner():GetSummonerEntityID()
      local summonEntity = e:GetSummonerEntity()
      if summonEntity and summonEntity:HasSuperEntity() and summonEntity:GetSuperEntity() then
        summonEntityID = summonEntity:GetSuperEntity():GetID()
      end
      if summonEntityID == casterEntity:GetID() then
        isOwner = true
      end
    else
      isOwner = true
    end
    return isOwner and e:HasTrapRender() and table.icontains(self._trapIDList, e:TrapRender():GetTrapID()) and not e:HasDeadMark()
  end)
  if 0 < #traps then
    local isMatchPieceType = false
    if self._matchType then
      local utilData = world:GetService("UtilData")
      local pieceType = utilData:FindPieceElement(pickUpPos)
      if pieceType == self._matchType then
        isMatchPieceType = true
      end
    end
    if isMatchPieceType then
      self:_CalcSkillScopeAndTarget(self._matchScopeParam, casterEntity, previewContext)
    else
      self:_CalcSkillScopeAndTarget(self._scopeParam, casterEntity, previewContext)
    end
  else
    local useEffectID = self._effectID
    local skinId = 1
    if casterEntity:MatchPet() then
      skinId = casterEntity:MatchPet():GetMatchPet():GetSkinId()
      if skinId and self._skinUseEffectMap[skinId] then
        useEffectID = self._skinUseEffectMap[skinId]
      end
    end
    local effectEntity = world:GetService("Effect"):CreateWorldPositionEffect(useEffectID, pickUpPos)
    local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
    previewPickUpComponent:AddPickUpEffectEntityID(effectEntity:GetID())
    previewContext:SetScopeResult(nil)
    local targetList = {}
    previewContext:SetTargetEntityIDList(targetList)
  end
end

function SkillPreviewPlayShowAtkOrSummonOnPickupPosInstruction:_CalcSkillScopeAndTarget(scopeParam, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local configSvc = world:GetService("Config")
  local helper = configSvc._skillConfigHelper
  local parser = helper._scopeParamParser
  local spScopeParam = SkillPreviewScopeParam:New(scopeParam)
  local param = parser:ParseScopeParam(scopeParam.ScopeType, scopeParam.ScopeParam)
  spScopeParam:SetScopeParamData(param)
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local scopeResult = previewActiveSkillService:CalcScopeResult(spScopeParam, casterEntity)
  previewContext:SetScopeResult(scopeResult:GetAttackRange())
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, scopeParam.TargetType, scopeResult)
  previewContext:SetTargetEntityIDList(targetIDList)
end
