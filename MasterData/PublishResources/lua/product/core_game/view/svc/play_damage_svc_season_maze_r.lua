require("play_damage_svc_r")
_class("PlayDamageService_SeasonMaze", PlayDamageService)
PlayDamageService_SeasonMaze = PlayDamageService_SeasonMaze

function PlayDamageService_SeasonMaze:_RefreshTeamHP(TT, defenderEntity, damageInfo)
  local teamEntity
  if defenderEntity:HasTeam() then
    teamEntity = defenderEntity
  elseif defenderEntity:PetPstID() then
    teamEntity = defenderEntity:Pet():GetOwnerTeamEntity()
  else
    return
  end
  local petList = teamEntity:Team():GetTeamPetEntities()
  local battleRenderCmpt = self._world:BattleRenderConfig()
  for id, entity in ipairs(petList) do
    if not entity:HasPetDeadMark() then
      local curDamageInfo = damageInfo:GetMazeTeamMemberDamageInfo(entity:GetID())
      if defenderEntity:PetPstID() then
        if defenderEntity:GetID() == entity:GetID() then
          curDamageInfo = damageInfo
          goto lbl_51
        end
      else
        ::lbl_51::
        if curDamageInfo then
          local changeValue = curDamageInfo:GetChangeHP() or 0
          local renderCurMaxHP = entity:HP():GetMaxHP()
          local renderCurHP = entity:HP():GetRedHP()
          renderCurHP = renderCurHP + changeValue
          if renderCurMaxHP < renderCurHP then
            renderCurHP = renderCurMaxHP
          end
          if renderCurHP < 0 then
            renderCurHP = 0
          end
          entity:ReplaceRedHP(renderCurHP)
          local petPstIDComponent = entity:PetPstID()
          local pstID = petPstIDComponent:GetPstID()
          local is_dead = false
          if renderCurHP <= 0 then
            is_dead = true
            battleRenderCmpt:AddDeadPet(entity:PetPstID():GetTemplateID())
          end
          Log.notice("_RefreshTeamHP() entityID:", entity:GetID(), "CurHP:", renderCurHP, "MaxHP:", renderCurMaxHP)
          if changeValue ~= 0 then
            self:_OnHpChangeNotifyBuff(TT, entity, changeValue, curDamageInfo)
            GameGlobal.EventDispatcher():Dispatch(GameEventType.OnPetHpChangedInMaze, {
              pet_pstid = pstID,
              cur_hp = renderCurHP,
              max_hp = renderCurMaxHP,
              is_dead = is_dead,
              change_value = changeValue
            })
          end
        end
      end
    end
  end
  local curTeamHP, maxTeamHP = 0, 0
  for _, entity in ipairs(petList) do
    local renderCurHP = entity:HP():GetRedHP()
    local renderCurMaxHP = entity:HP():GetMaxHP()
    curTeamHP = curTeamHP + renderCurHP
    maxTeamHP = maxTeamHP + renderCurMaxHP
  end
  local hpCmpt = teamEntity:HP()
  local shieldPoint = hpCmpt:GetShieldValue()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamHPChange, {
    isLocalTeam = true,
    currentHP = curTeamHP,
    hitpoint = curTeamHP,
    maxHP = maxTeamHP,
    shield = shieldPoint,
    entityID = teamEntity:GetID(),
    showCurseHp = hpCmpt:GetShowCurseHp(),
    curseHpVal = hpCmpt:GetCurseHpValue()
  })
  teamEntity:ReplaceRedHPAndWhitHP(curTeamHP)
end

function PlayDamageService_SeasonMaze:OnTeamOrderChangeRefresh()
end

function PlayDamageService_SeasonMaze:GetAlivePetCount(teamEntity)
  local petEntityList = teamEntity:Team():GetTeamPetEntities()
  local count = 0
  for _, entity in ipairs(petEntityList) do
    if not entity:HasPetDeadMark() then
      count = count + 1
    end
  end
  return count
end
