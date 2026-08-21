_class("BuffViewInitMonsterMoveGroupLineRenderer", BuffViewBase)
BuffViewInitMonsterMoveGroupLineRenderer = BuffViewInitMonsterMoveGroupLineRenderer

function BuffViewInitMonsterMoveGroupLineRenderer:PlayView(TT)
  local entity = self._entity
  if not entity:HasView() then
    return
  end
  local monsterIDCmpt = self._entity:MonsterID()
  local utilCalcServiceShare = self._world:GetService("UtilCalc")
  local myGroupMonsterList = utilCalcServiceShare:FindMonsterByMoveGroupID(monsterIDCmpt:GetMoveGroupID())
  local beginEntityList = {}
  local endEntityList = {}
  for i, startMonsterEntity in ipairs(myGroupMonsterList) do
    local beginPos = startMonsterEntity:GetGridPosition()
    for j, endMonsterEntity in ipairs(myGroupMonsterList) do
      if i ~= j then
        local endPos = endMonsterEntity:GetGridPosition()
        if utilCalcServiceShare:IsNeedShowMoveGroupLine(beginPos, endPos) then
          local flag = true
          if (table.intable(beginEntityList, startMonsterEntity:GetID()) or table.intable(endEntityList, startMonsterEntity:GetID())) and (table.ikey(beginEntityList, startMonsterEntity:GetID()) == table.ikey(endEntityList, endMonsterEntity:GetID()) or table.ikey(endEntityList, startMonsterEntity:GetID()) == table.ikey(beginEntityList, endMonsterEntity:GetID())) then
            flag = false
          end
          if flag then
            table.insert(beginEntityList, startMonsterEntity:GetID())
            table.insert(endEntityList, endMonsterEntity:GetID())
          end
        end
      end
    end
    if #beginEntityList == #myGroupMonsterList - 1 then
      break
    end
  end
  local effectID = self._buffResult[1]
  local effectSvc = self._world:GetService("Effect")
  effectSvc:CreateMonsterMoveLineEffects(TT, effectID, entity, beginEntityList, "Hit", endEntityList, "Hit")
end

function BuffViewInitMonsterMoveGroupLineRenderer:IsNotifyMatch(notify)
  local myGroupID = self._buffResult[2]
  return notify:GetGroupID() == myGroupID
end

_class("BuffViewUpdateMonsterMoveGroupLineRenderer", BuffViewBase)
BuffViewUpdateMonsterMoveGroupLineRenderer = BuffViewUpdateMonsterMoveGroupLineRenderer

function BuffViewUpdateMonsterMoveGroupLineRenderer:PlayView(TT)
  local buffResult = self._buffResult
  local entity = self._entity
  if not entity:HasView() then
    return
  end
  local entityViewRoot = entity:View().ViewWrapper.GameObject.transform
  local curRoot = GameObjectHelper.FindChild(entityViewRoot, buffResult:GetCurrent())
  local targetRoot
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in pairs(monsterGroup:GetEntities()) do
    local cBuff = monsterEntity:BuffView()
    if cBuff and cBuff:HasBuffEffect(buffResult:GetBuffEffect()) then
      targetRoot = GameObjectHelper.FindChild(monsterEntity:View().ViewWrapper.GameObject.transform, buffResult:GetTarget())
      break
    end
  end
  if not curRoot or not targetRoot then
    return
  end
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    return
  end
  local effectList = effectHolderCmpt:GetPermanentEffect()
  for i, eff in ipairs(effectList) do
    local e = self._world:GetEntityByID(eff)
    if e:HasView() then
      local go = e:View():GetGameObject()
      local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
      for i = 0, renderers.Length - 1 do
        local line = renderers[i]
        if line then
          local currentPos = curRoot.position - entityViewRoot.position
          local targetPos = targetRoot.position - entityViewRoot.position
          line.gameObject:SetActive(true)
          line:SetPosition(0, currentPos)
          line:SetPosition(1, targetPos)
        end
      end
    end
  end
end

_class("BuffViewDeleteMonsterMoveGroupLineRenderer", BuffViewBase)
BuffViewDeleteMonsterMoveGroupLineRenderer = BuffViewDeleteMonsterMoveGroupLineRenderer

function BuffViewDeleteMonsterMoveGroupLineRenderer:PlayView(TT)
  local entity = self._entity
  if not entity then
    return
  end
  local cEffectHolder = entity:EffectHolder()
  if not cEffectHolder then
    return
  end
  local effectID = self._buffResult
  local effectIDEntityDic = cEffectHolder:GetEffectIDEntityDic()[effectID]
  if effectIDEntityDic then
    for _, entityID in pairs(effectIDEntityDic) do
      local effectEntity = self._world:GetEntityByID(entityID)
      if effectEntity ~= nil then
        self._world:DestroyEntity(effectEntity)
      end
    end
  end
  effectIDEntityDic = {}
  entity:RemoveEffectLineRenderer()
  Log.fatal("BuffRemoveEffectLineRenderer")
end
