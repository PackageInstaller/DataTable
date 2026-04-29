_class("BuffMaterialAnimationSystem_Render", Object)
BuffMaterialAnimationSystem_Render = BuffMaterialAnimationSystem_Render

function BuffMaterialAnimationSystem_Render:Constructor(world)
  self._world = world
  self._group = world:GetGroup(world.BW_WEMatchers.BuffView)
  self._timeService = self._world:GetService("Time")
  self._show_anim_delta_time = 0
  self._show_anim_interval_time = 2
end

function BuffMaterialAnimationSystem_Render:Execute()
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity then
    local previewChainPathCmpt = previewEntity:PreviewChainPath()
    if previewChainPathCmpt and previewChainPathCmpt:IsLinkLine() then
      self:StopAnimation()
      return
    end
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local curMainStateID = utilDataSvc:GetCurMainStateID()
  if curMainStateID == GameStateID.PreviewActiveSkill or curMainStateID == GameStateID.PickUpActiveSkillTarget then
    self:StopAnimation()
    return
  end
  self._show_anim_delta_time = self._show_anim_delta_time + self._timeService:GetDeltaTime()
  if self._show_anim_delta_time < self._show_anim_interval_time then
    return
  end
  self._show_anim_delta_time = 0
  for _, e in ipairs(self._group:GetEntities()) do
    local anims = e:BuffView():GetMaterialAnimiationArray()
    local targetEntity = e
    if e:HasTeam() then
      targetEntity = e:GetTeamLeaderPetEntity()
    end
    if targetEntity then
      if #anims == 0 and not e:HasPetPstID() and not e:HasTrapRender() then
        targetEntity:StopMaterialAnimLayer(MaterialAnimLayer.Dot)
      end
      if 0 < #anims and not e:HasDeadFlag() then
        local cur_anim = e:BuffView():GetBuffValue("CurMaterialAnimation")
        if not cur_anim then
          cur_anim = anims[1]
        else
          local find = false
          for i = 1, #anims do
            if cur_anim == anims[i] then
              local next = i + 1
              if next > #anims then
                next = 1
              end
              find = true
              cur_anim = anims[next]
              break
            end
          end
          if not find then
            cur_anim = anims[1]
          end
        end
        e:BuffView():SetBuffValue("CurMaterialAnimation", cur_anim)
        targetEntity:PlayMaterialAnim(cur_anim)
      end
    end
  end
end

function BuffMaterialAnimationSystem_Render:StopAnimation()
  for _, e in ipairs(self._group:GetEntities()) do
    local targetEntity = e
    if e:HasTeam() then
      targetEntity = e:GetTeamLeaderPetEntity()
    end
    if targetEntity then
      targetEntity:StopMaterialAnimLayer(MaterialAnimLayer.Dot)
      local cur_anim = e:BuffView():GetBuffValue("CurMaterialAnimation")
      if cur_anim and cur_anim ~= "common_shadoweff" then
        targetEntity:StopMaterialAnim(cur_anim)
      end
      e:BuffView():SetBuffValue("CurMaterialAnimation", nil)
    end
  end
end
