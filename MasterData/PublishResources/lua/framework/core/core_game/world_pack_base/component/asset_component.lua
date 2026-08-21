_class("AssetComponent", Object)
AssetComponent = AssetComponent

function AssetComponent:Constructor(detail)
  self.AssetDetail = detail
end

function AssetComponent:Dispose()
  self.AssetDetail = nil
end

function AssetComponent:GetResPath()
  return self.AssetDetail:GetResPath()
end

function Entity:Asset()
  return self:GetComponent(self.WEComponentsEnum.Asset)
end

function Entity:HasAsset()
  return self:HasComponent(self.WEComponentsEnum.Asset)
end

function Entity:AddAsset(detail)
  local index = self.WEComponentsEnum.Asset
  local component = AssetComponent:New(detail)
  self:AddComponent(index, component)
end

function Entity:ReplaceAsset(detail)
  local index = self.WEComponentsEnum.Asset
  local component = AssetComponent:New(detail)
  self:ReplaceComponent(index, component)
  self:AddViewSync()
end

function Entity:RemoveAsset()
  if self:HasAsset() then
    self:RemoveComponent(self.WEComponentsEnum.Asset)
  end
end

function Entity:AddViewSync()
  local world = self:GetOwnerWorld()
  local resServ = world.BW_Services.ResourcesPool
  if self:HasView() then
    resServ:DestroyView(self:View().ViewWrapper)
  end
  self:Asset().AssetDetail:GenerateView(resServ, Entity.OnViewCreated, self, self)
end

function Entity:OnViewCreated(e, viewWrapper)
  if viewWrapper then
    e:ReplaceView(viewWrapper)
    local world = self:GetOwnerWorld()
    local trapRenderSvc = world:GetService("TrapRender")
    local entityTypeCmp = e:EntityType()
    if entityTypeCmp and not trapRenderSvc:IsRuneTrap(e) then
      local entityType = entityTypeCmp.Value
      if EntityTypeHelper:GetInstance():IsBulletTimeEffectEntity(entityType) then
        local fadeMonoCmpt = viewWrapper.GameObject:GetComponent(typeof(FadeComponent))
        if not fadeMonoCmpt then
          viewWrapper.GameObject:AddComponent(typeof(FadeComponent))
        end
      end
      local isMonsterNeedMaterialAnimation = self:CheckMaterialAnimationCmptByEntityProperty(e)
      if EntityTypeHelper:GetInstance():NeedMaterialAnimation(entityType) and isMonsterNeedMaterialAnimation then
        local matAnimMonoCmpt = viewWrapper.GameObject:GetComponent(typeof(MaterialAnimation))
        if matAnimMonoCmpt then
          UnityEngine.Object.Destroy(matAnimMonoCmpt)
        end
        matAnimMonoCmpt = viewWrapper.GameObject:AddComponent(typeof(MaterialAnimation))
        local disable = self:NeedDisableMaterialAnimationFlag(e)
        if disable then
          matAnimMonoCmpt.isApplyAllRenders = false
        end
        e:RemoveMaterialAnimationComponent()
        local resServ = world.BW_Services.ResourcesPool
        local container = resServ:LoadAsset("globalShaderEffects.asset")
        assert(container)
        e:AddMaterialAnimationComponent(container, matAnimMonoCmpt)
        local shaderEffect = self:OnGetSpecialShaderEffect(e)
        if shaderEffect then
          local containerShaderEffect = resServ:LoadAsset(shaderEffect)
          if not containerShaderEffect then
            local respool = world.BW_Services.ResourcesPool
            respool:CacheAsset(shaderEffect, 1)
            containerShaderEffect = resServ:LoadAsset(shaderEffect)
          end
          assert(containerShaderEffect, shaderEffect)
          e:MaterialAnimationComponent():LoadContainer(containerShaderEffect)
        end
        local subShaderEffect = self:OnGetSubSpecialShaderEffect(e)
        if subShaderEffect then
          for _, effCfg in ipairs(subShaderEffect) do
            local nodeName = effCfg.node
            local nodeGo
            local nodeRect = GameObjectHelper.FindChild(viewWrapper.GameObject.transform, nodeName)
            if nodeRect then
              nodeGo = nodeRect.gameObject
            end
            if nodeGo then
              local matAnimMonoCmpt = nodeGo:GetComponent(typeof(MaterialAnimation))
              if matAnimMonoCmpt then
                UnityEngine.Object.Destroy(matAnimMonoCmpt)
              end
              matAnimMonoCmpt = nodeGo:AddComponent(typeof(MaterialAnimation))
              local resName = effCfg.res
              local containerShaderEffect = resServ:LoadAsset(resName)
              if not containerShaderEffect then
                local respool = world.BW_Services.ResourcesPool
                respool:CacheAsset(resName, 1)
                containerShaderEffect = resServ:LoadAsset(resName)
              end
              assert(containerShaderEffect)
              e:MaterialAnimationComponent():AddSubMaterialAnimation(nodeName, matAnimMonoCmpt)
              e:MaterialAnimationComponent():SubLoadContainer(nodeName, containerShaderEffect)
            end
          end
        end
      end
      if entityType == EntityType.Monster or entityType == EntityType.CutsceneMonster then
        local eliteEffIDList = self:OnGetEliteEffIDList(e)
        if #eliteEffIDList == 0 then
          local trailEffect = self:OnGetTrailEffect(e)
          local trailEffectExCmpt = viewWrapper.GameObject.transform:Find("Root").gameObject:GetComponent(typeof(TrailsFX.TrailEffectEx))
          if trailEffectExCmpt then
            UnityEngine.Object.Destroy(trailEffectExCmpt)
          end
          e:RemoveTrailEffectEx()
          if trailEffect then
            trailEffectExCmpt = viewWrapper.GameObject.transform:Find("Root").gameObject:AddComponent(typeof(TrailsFX.TrailEffectEx))
            local resServ = world.BW_Services.ResourcesPool
            local containerTrailEffect = resServ:LoadAsset(trailEffect)
            if not containerTrailEffect then
              resServ:CacheAsset(trailEffect, 1)
              containerTrailEffect = resServ:LoadAsset(trailEffect)
            end
            assert(containerTrailEffect)
            e:AddTrailEffectEx(containerTrailEffect, trailEffectExCmpt)
          end
        end
      end
      if e:HasMonsterID() and self._world:MatchType() == MatchType.MT_Chess then
        local resServ = world.BW_Services.ResourcesPool
        local containerN15MateEffect = resServ:LoadAsset(BattleConst.N15MaterialAnimAsset)
        if not containerN15MateEffect then
          resServ:CacheAsset(BattleConst.N15MaterialAnimAsset, 1)
          containerN15MateEffect = resServ:LoadAsset(BattleConst.N15MaterialAnimAsset)
        end
        assert(containerN15MateEffect)
        e:MaterialAnimationComponent():AddContainer(containerN15MateEffect)
        local outlineCmpt = viewWrapper.GameObject:GetComponent(typeof(OutlineComponent))
        outlineCmpt = outlineCmpt or viewWrapper.GameObject:AddComponent(typeof(OutlineComponent))
        outlineCmpt.enabled = false
      end
    end
    if not GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() and world:GetRunningPosition() ~= WorldRunPostion.Performance then
      local battleSvcR = world:GetService("RenderBattle")
      battleSvcR:SetActorOutLine(viewWrapper.GameObject)
    end
  else
    e:RemoveView()
  end
end

function Entity:OnGetSpecialShaderEffect(e)
  local shaderEffect
  if e:HasPetPstID() then
    local templateid = e:PetPstID():GetTemplateID()
    local cfg_pet = Cfg.cfg_pet[templateid]
    shaderEffect = cfg_pet.ShaderEffect
  elseif e:HasMonsterID() and not e:HasGhost() and not e:HasGuideGhost() then
    local cfg_monster = Cfg.cfg_monster[e:MonsterID():GetMonsterID()]
    local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
    shaderEffect = cfg_monster_class.ShaderEffect
  elseif e:TrapRender() then
    local cfg_trap = Cfg.cfg_trap[e:TrapRender():GetTrapID()]
    shaderEffect = cfg_trap.ShaderEffect
  end
  return shaderEffect
end

function Entity:OnGetSubSpecialShaderEffect(e)
  local shaderEffect
  if e:HasPetPstID() then
    local templateid = e:PetPstID():GetTemplateID()
    local cfg_pet = Cfg.cfg_pet[templateid]
    shaderEffect = cfg_pet.SubShaderEffect
  elseif e:HasMonsterID() and not e:HasGhost() and not e:HasGuideGhost() then
    local cfg_monster = Cfg.cfg_monster[e:MonsterID():GetMonsterID()]
    local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
    shaderEffect = cfg_monster_class.SubShaderEffect
  elseif e:Trap() then
    local cfg_trap = Cfg.cfg_trap[e:TrapRender():GetTrapID()]
    shaderEffect = cfg_trap.SubShaderEffect
  end
  return shaderEffect
end

function Entity:OnGetTrailEffect(e)
  local trailEffect
  if e:HasMonsterID() and not e:HasGhost() and not e:HasGuideGhost() then
    local cfg_monster = Cfg.cfg_monster[e:MonsterID():GetMonsterID()]
    local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
    local eliteIDs = cfg_monster.EliteID
    if eliteIDs and table.count(eliteIDs) > 0 then
      trailEffect = cfg_monster_class.TrailEffect
    end
  end
  return trailEffect
end

function Entity:OnGetEliteEffIDList(e)
  local idList = {}
  if e:HasMonsterID() and not e:HasGhost() and not e:HasGuideGhost() then
    local monsterIDCmpt = e:MonsterID()
    if monsterIDCmpt then
      local eliteIDs = monsterIDCmpt:GetEliteIDArray()
      for _, eliteID in ipairs(eliteIDs) do
        local cfgElite = Cfg.cfg_monster_elite[eliteID]
        if cfgElite and cfgElite.EffectID then
          table.insert(idList, cfgElite.EffectID)
        end
      end
    end
  end
  return idList
end

function Entity:NeedDisableMaterialAnimationFlag(e)
  local monsterIDCmpt = e:MonsterID()
  if monsterIDCmpt then
    local monsterClassID = monsterIDCmpt:GetMonsterClassID()
    local needDisable = table.icontains(BattleConst.DisableMonsterClassIDList, monsterClassID)
    return needDisable
  end
  return false
end

function Entity:CheckMaterialAnimationCmptByEntityProperty(e)
  local monsterIDCmpt = e:MonsterID()
  if not monsterIDCmpt then
    return true
  end
  local monsterClassID = monsterIDCmpt:GetMonsterClassID()
  local inList = table.icontains(BattleConst.MonsterDontNeedMaterialAnimationClassIDList, monsterClassID)
  if inList then
    return false
  else
    return true
  end
end
