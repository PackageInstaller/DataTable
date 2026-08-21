require("bounce_player")
_class("BounceObjMgr", Object)
BounceObjMgr = BounceObjMgr

function BounceObjMgr:Constructor()
  self.player = nil
  self.playerCamp = {}
  self.monsterCamp = {}
  self.monsterPool = nil
  self.coreController = nil
  self._tempDeleteMonster = {}
  self.guideModule = GameGlobal.GetModule(GuideModule)
end

function BounceObjMgr:Init(coreController)
  self.coreController = coreController
  self.monsterPool = coreController:GetMonsterPool()
end

function BounceObjMgr:InitPlayer()
  self.player = BouncePlayer:New()
  local parentRt = self.coreController:GetObjectsRoot()
  local palyerPrefabName = self.coreController:GetPlayerPrefabName()
  self.player:Init(self.coreController, palyerPrefabName, parentRt)
  self:SetPlayerVisbile(false)
end

function BounceObjMgr:AddMonster(monster)
  local pstId = monster.pstID
  if self.monsterCamp[pstId] then
    Log.fatal("BounceObjMgr err: duplicated monsterPstID " .. pstId)
  end
  self.monsterCamp[pstId] = monster
  monster:Show()
end

function BounceObjMgr:RemoveMonster(monster)
  local pstId = monster.pstID
  if self.monsterCamp[pstId] then
    self.monsterCamp[pstId] = nil
  elseif self.playerCamp[pstId] then
    self.playerCamp[pstId] = nil
  end
  self.monsterPool:Recyle(monster)
end

function BounceObjMgr:ChgMonsterCampToPlayer(monster)
  local pstId = monster.pstID
  if self.monsterCamp[pstId] then
    self.monsterCamp[pstId] = nil
  end
  self.playerCamp[pstId] = monster
end

function BounceObjMgr:Reset()
  self:ClearMonsters()
  self.player:Reset()
  self.player:ChgPlayerState(StateBouncePlayer.Init)
end

function BounceObjMgr:SetPlayerVisbile(bVisible)
  self.player:SetVisible(bVisible)
end

function BounceObjMgr:ClearMonsters()
  for k, v in pairs(self.playerCamp) do
    self.monsterPool:Recyle(v)
  end
  table.clear(self.playerCamp)
  for k, v in pairs(self.monsterCamp) do
    self.monsterPool:Recyle(v)
  end
  table.clear(self.monsterCamp)
  table.clear(self._tempDeleteMonster)
end

function BounceObjMgr:OnUpdate(deltaMS)
  self.player:OnUpdate(deltaMS)
  for k, v in pairs(self.playerCamp) do
    if v:OnUpdate(deltaMS) then
      table.insert(self._tempDeleteMonster, v)
    end
  end
  for k, v in pairs(self.monsterCamp) do
    if v:OnUpdate(deltaMS) then
      table.insert(self._tempDeleteMonster, v)
    end
  end
  for k, v in pairs(self._tempDeleteMonster) do
    self:RemoveMonster(v)
  end
  table.clear(self._tempDeleteMonster)
  if self.coreController.bounceData.isOvering then
    return
  end
  if self.player.state ~= BounceObjState.Alive then
    return
  end
  if self.coreController.bounceData.isGuiding then
    self:Guide_CheckMonsterPosition()
  end
  local baseRect, weaponRect = self.player:GetRect()
  if not baseRect then
    return
  end
  local isPlayerDown = self.player:IsDown()
  for k, v in pairs(self.monsterCamp) do
    if v.state == BounceObjState.Alive or v.state == BounceObjState.Transformation then
      local monsterRect = v:GetRect()
      if monsterRect then
        local hurtBehavior = v:GetBehavior(MonsterBeHaviorHurt:Name())
        local weaponOverlapsMonster
        if weaponRect and weaponRect:Overlaps(monsterRect) then
          if hurtBehavior then
            hurtBehavior:Exec(self.player.playerData.ap)
            if isPlayerDown then
              self:OnHurtMonsterWhenDown()
            end
            weaponOverlapsMonster = true
            AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BounceJump)
          else
            local chgCampBehavior = v:GetBehavior(MonsterBeHaviorChgCampWhenAttacked:Name())
            if chgCampBehavior then
              chgCampBehavior:Exec()
              weaponOverlapsMonster = true
            end
            local chgDirBehavior = v:GetBehavior(MonsterBeHaviorChgDirectionWhenAttacked:Name())
            if chgDirBehavior then
              chgDirBehavior:Exec()
              weaponOverlapsMonster = true
            end
          end
        end
        if not weaponOverlapsMonster and baseRect:Overlaps(monsterRect) then
          local attakBehavior = v:GetBehavior(MonsterBeHaviorAttack:Name())
          if not hurtBehavior then
            self.player:OnHurt(v.monsterData.ap)
            if attakBehavior then
              attakBehavior:Exec()
            end
          elseif not attakBehavior then
            hurtBehavior:Exec(self.player.playerData.ap)
            if isPlayerDown then
              self:OnHurtMonsterWhenDown()
            end
          elseif v.monsterData.underPlayer then
            hurtBehavior:Exec(self.player.playerData.ap)
            if isPlayerDown then
              self:OnHurtMonsterWhenDown()
            end
          else
            self.player:OnHurt(v.monsterData.ap)
            if attakBehavior then
              attakBehavior:Exec()
            end
          end
          v.monsterData.underPlayer = false
        else
          self:UpdateMonsterPosState(v, monsterRect, baseRect, isPlayerDown)
        end
      end
    end
  end
  if self.player.state ~= BounceObjState.Alive then
    return
  end
  for kb, bullet in pairs(self.playerCamp) do
    if bullet.state ~= BounceObjState.Alive then
      break
    end
    local bulletRect = bullet:GetRect()
    if not bullet then
      break
    end
    for k, v in pairs(self.monsterCamp) do
      if v.state == BounceObjState.Alive then
        local hurtBehavior = v:GetBehavior(MonsterBeHaviorHurt:Name())
        if hurtBehavior then
          local monsterRect = v:GetRect()
          if monsterRect and bulletRect:Overlaps(monsterRect) then
            self:CheckBulletAttackMonsterGuide(v)
            hurtBehavior:Exec(1)
            local bulletAttackBehavior = bullet:GetBehavior(MonsterBeHaviorAttack:Name())
            if bulletAttackBehavior then
              bulletAttackBehavior:Exec()
            end
            break
          end
        end
      end
    end
  end
end

function BounceObjMgr:UpdateMonsterPosState(monster, monsterRect, playerRect, playerIsDown)
  monster.monsterData.underPlayer = false
  if playerIsDown then
    local cPlayer = playerRect.center
    local cMonster = monsterRect.center
    if cMonster.y > cPlayer.y then
      return
    end
    if monsterRect.xMax < playerRect.xMin then
      return
    end
    if monsterRect.xMin > playerRect.xMax then
      return
    end
    monster.monsterData.underPlayer = true
  end
end

function BounceObjMgr:OnHurtMonsterWhenDown()
  self.player:OnHurtMonsterWhenDown()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N28BoucneStomp)
end

function BounceObjMgr:Guide_CheckMonsterPosition()
  if self.coreController.bounceData.isGuiding and GuideHelper.IsUIGuideShow() then
    return
  end
  local posKeys
  if self.coreController.bounceData.guidingId == BounceConst.GuideFirst then
    posKeys = self.coreController.firstGuideStepPositionKeys
  elseif self.coreController.bounceData.guidingId == BounceConst.GuideSecond then
    posKeys = self.coreController.secondGuideStepPositionKeys
  else
    return
  end
  for i, posKey in ipairs(posKeys) do
    local rt = self.coreController:GetGuideRt(posKey)
    if rt then
      local bounceRect = BounceRect:New(rt.anchoredPosition, rt.sizeDelta)
      for _, subMonster in pairs(self.monsterCamp) do
        local monsterRect = subMonster:GetBounceRect()
        if monsterRect then
          local p1 = monsterRect:GetMin()
          local p2 = monsterRect:GetMax()
          if bounceRect:Contains(p1) and bounceRect:Contains(p2) then
            self.coreController:OnTrigerGuideStep(posKey)
          end
        end
      end
    end
  end
end

function BounceObjMgr:CheckBulletAttackMonsterGuide(monster)
  if self.coreController.bounceData.levelId == 6 and not self.guideModule:IsGuideDone(BounceConst.GuideBoss3) then
    local pos = monster:GetPosition()
    if not pos then
      return
    end
    self.coreController:SetGuidePosition(BounceConst.GuideBoss3_BulletPosKey1, pos)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIBounceMainControllerBoss3)
    self.coreController.bounceData.guidingId = BounceConst.GuideBoss3
    local isGuiding = self.guideModule:IsGuideProcess(BounceConst.GuideBoss3)
    self.coreController.bounceData:SetIsGuiding(isGuiding)
  end
end
