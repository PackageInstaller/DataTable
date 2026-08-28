local module = {}

function module.LoadTimeLine(id, callback, isReplaceRoles)
  local timeLineCA = PlayerData:GetFactoryData(id, "TimeLineFactory")
  if timeLineCA and timeLineCA.timeLinePath ~= nil then
    TimelineManager:AddTimeLine(id, timeLineCA.timeLinePath, Vector3(timeLineCA.x, timeLineCA.y, timeLineCA.z), callback)
    if isReplaceRoles == nil or isReplaceRoles == true then
      isReplaceRoles = #timeLineCA.actorList > 0
    end
    if isReplaceRoles then
      local roles = {}
      for k, v in pairs(PlayerData.ServerData.roles) do
        local roleId = tonumber(k)
        local isFind = false
        for k1, v1 in pairs(timeLineCA.fixedActorList) do
          if v1.id == roleId then
            isFind = true
            break
          end
        end
        if not isFind then
          table.insert(roles, roleId)
        end
      end
      
      local function getOneRoleId()
        if #roles == 0 then
          return nil
        end
        local idx = math.random(1, #roles)
        local id = roles[idx]
        table.remove(roles, idx)
        return id
      end
      
      local sources = {}
      local targets = {}
      for k, v in pairs(timeLineCA.actorList) do
        if v.replaceType == "CanNot" then
        elseif v.replaceType == "HomeCharacter" then
          local id = getOneRoleId()
          if id ~= nil then
            local unitCA = PlayerData:GetFactoryData(id, "unitFactory")
            if unitCA.homeCharacter > 0 then
              local homeCharacterCA = PlayerData:GetFactoryData(unitCA.homeCharacter, "HomeCharacterFactory")
              table.insert(sources, v.actor)
              table.insert(targets, homeCharacterCA.resDir)
            end
          end
        elseif v.replaceType == "BattleCharacter" then
          local id = getOneRoleId()
          if id ~= nil then
            local unitCA = PlayerData:GetFactoryData(id, "unitFactory")
            local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
            table.insert(sources, v.actor)
            table.insert(targets, unitViewCA.resDir)
          end
        elseif v.replaceType == "Limit" and 0 < v.limitList then
          local listCA = PlayerData:GetFactoryData(v.limitList, "ListFactory")
          local totalWeight = 0
          for k1, v1 in pairs(listCA.spineList) do
            totalWeight = totalWeight + v1.weight
          end
          local weight = math.random(1, totalWeight)
          for k1, v1 in pairs(listCA.spineList) do
            weight = weight - v1.weight
            if weight <= 0 then
              table.insert(sources, v.actor)
              table.insert(targets, v1.spinePath)
              break
            end
          end
        end
      end
      if GameSetting.isInOriginPack == nil or GameSetting.isInOriginPack == false then
        TimelineManager:ReplaceAllActors(timeLineCA.timeLinePath, sources, targets)
      end
    end
    if 0 < table.count(timeLineCA.lczPathList) then
      local gender = PlayerData:GetUserInfo().gender or 1
      local homeCharacter = gender == 1 and 70000067 or 70000063
      local homeCharacterCA = PlayerData:GetFactoryData(homeCharacter, "HomeCharacterFactory")
      for i, v in pairs(timeLineCA.lczPathList) do
        local resDir = homeCharacterCA.resDir
        resDir = module.GetCharacterCAStatePath(homeCharacterCA, 1)
        TimelineManager:ReplaceConductor(timeLineCA.timeLinePath, v.lcz, resDir)
      end
      ChangeSkinUtil.InitTimeLineCaptainSpineSkin(id)
      ChangeSkinUtil.InitTimeLineCaptainSpineHairColor(id)
    end
  end
end

function module.SetTimeLineTimeCallback(id, time, callback)
  local timeLineCA = PlayerData:GetFactoryData(id, "TimeLineFactory")
  if timeLineCA and timeLineCA.timeLinePath ~= nil then
    TimelineManager:SetTimeLineTimeCallback(timeLineCA.timeLinePath, time, callback)
  end
end

function module.RemoveTimeLine(id)
  local timeLineCA = PlayerData:GetFactoryData(id, "TimeLineFactory")
  if timeLineCA and timeLineCA.timeLinePath ~= nil then
    TimelineManager:RemoveTimeLine(timeLineCA.timeLinePath)
  end
end

function module.GetCharacterCAStatePath(characterCA, state)
  local path = characterCA.resDir
  if 0 <= state and 0 < #characterCA.resStatePath then
    for k, v in ipairs(characterCA.resStatePath) do
      if v.state == state then
        path = v.path
        break
      end
    end
  end
  return path
end

return module
