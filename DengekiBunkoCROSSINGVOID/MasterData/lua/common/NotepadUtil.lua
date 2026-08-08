local WU, DB, REF = require("Common/WindowUtil")()
local HU = require("Common/HtmlUtil")
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local NU = {}

function NU.GetNotepadText(event, data, ref)
  local jsonObj = JsonD(event.text)
  if event.type == PB.enum.NotePadEventType.GetActor then
    return WU.GetString("NotepadEvent_GetActor", WU.GetString("RoleName_" .. data.roleId))
  elseif event.type == PB.enum.NotePadEventType.FavourLvUp then
    local key = "NotepadEvent_FavourLvUp_" .. jsonObj.favour_level
    local roleName = WU.GetString("RoleName_" .. data.roleId)
    return WU.GetString(key, roleName, roleName, jsonObj.favour_level)
  elseif event.type == PB.enum.NotePadEventType.Present then
    local key = "NotepadEvent_FavourLvUp_" .. jsonObj.favour_level
    local roleName = WU.GetString("RoleName_" .. data.roleId)
    return WU.GetString(key, roleName, roleName, jsonObj.favour_level)
  elseif event.type == PB.enum.NotePadEventType.Monologue then
    if ref ~= nil then
      WU.BindButtonEvent(ref.RightSprite, function()
        WU.EnterCartoonLevel(tonumber(jsonObj.cartoon), "RoleNotepad, RoleNotepadDetail")
      end)
    end
    return WU.GetString("MonologueText_" .. jsonObj.id)
  elseif event.type == PB.enum.NotePadEventType.GetHeadPhoto then
    if ref ~= nil then
      local row = PB.get("PlayerHeadPhoto", jsonObj.id)
      if row ~= nil then
        ref.RightSprite.UISprite.spriteName = row.sprite
      else
        warning("PlayerHeadPhoto.xlsx", "id not find : " .. tostring(jsonObj.id))
        ref.RightSprite.UISprite.spriteName = "playerheadicon_bg"
      end
    end
    return WU.GetString("NotepadEvent_GetHeadPhoto", WU.GetString("RoleName_" .. data.roleId))
  elseif event.type == PB.enum.NotePadEventType.GetChatImage then
    if ref ~= nil then
      local row = PB.get("ChatImage", 1, jsonObj.id)
      if row ~= nil then
        ref.RightSprite.UISprite.enabled = true
        ref.RightSprite.UISprite.spriteName = row.sprite
      else
        warning("ChatImage.xlsx", "id not find : " .. tostring(jsonObj.id))
        ref.RightSprite.UISprite.enabled = false
      end
    end
    return WU.GetString("NotepadEvent_NewEmoji", WU.GetString("RoleName_" .. data.roleId))
  elseif event.type == PB.enum.NotePadEventType.NotePadEventType_ClassicAna then
    local theSpeach = PB.get("RoleClassicAna", jsonObj.id)
    return WU.GetString("AnaContent_" .. theSpeach.id)
  elseif event.type == PB.enum.NotePadEventType.NotePadEventType_Cartoon then
    if ref ~= nil then
      WU.BindButtonEvent(ref.RightTexture, function()
        WU.EnterCartoonLevel(jsonObj.id, "RoleNotepadDetail")
      end)
      local cartoonConfig = PB.get("CartoonConfig", jsonObj.id)
      ref.RightTexture.UITexture.mainTexturePath = "Texture/JouneyVideo/" .. cartoonConfig.movieIcon
    end
    return WU.GetString("CartoonName_" .. jsonObj.id)
  elseif event.type == PB.enum.NotePadEventType.NotePadEventType_UnlockActorSkin then
    if ref ~= nil then
      ref.WidgetIconSkin["$SetData"](jsonObj.id)
    end
    return WU.GetString("NotepadEvent_GetRoleSkin", WU.GetString("RoleName_" .. data.roleId))
  elseif event.type == PB.enum.NotePadEventType.NotePadEventType_Postcard then
    if ref ~= nil then
      WU.BindButtonEvent(ref.RightSprite, function()
        local path = "Texture/Welfare/2400mikoto"
        WU.AcquireWindowAsync("PostcardFullScreen", function(window)
          _ENV["$"](window)["$$SetPicture"](path)
        end)
      end)
    end
    return WU.GetString("NotepadEvent_GetPostcard", WU.GetString("RoleName_" .. data.roleId))
  elseif event.type == PB.enum.NotePadEventType.ActorCultivation then
    if ref ~= nil and ref.RightSprite then
      ref.RightSprite.UITexture.mainTexturePath = "Texture/Welfare/ActorCultivation_small_" .. jsonObj.id .. "a"
      WU.BindButtonEvent(ref.RightSprite, function()
        WU.AcquireWindowAsync("ActorCultivationComplete", function(win)
          _ENV["$"](win)["$$SetView"]({
            TextureBg = "Texture/Background/ActorCultivation_share_" .. jsonObj.id .. "a",
            atcorID = jsonObj.id
          }, true)
        end)
      end)
    end
    return WU.GetString("ActorCultivation_NotepadEvent", WU.GetString("RoleName_" .. data.roleId))
  elseif event.type == PB.enum.NotePadEventType.CustomActorCultivation then
    if ref ~= nil and ref.WidgetCustomActorCultivationCG then
      ref.WidgetCustomActorCultivationCG["$SetData"](jsonObj.activity_id, jsonObj.actor_id)
      ref.WidgetCustomActorCultivationCG["$SetClickCallback"](function()
        WU.AcquireWindowAsync("CustomActorCultivationComplete", function(w)
          _ENV["$"](w)["$$SetView"](jsonObj.activity_id, jsonObj.actor_id, nil, false)
        end)
      end)
    end
    return WU.GetString("ActorCultivation_NotepadEvent", WU.GetString("RoleName_" .. data.roleId))
  end
end

function NU.UpdateRoleFavour(favourChanges)
  if favourChanges then
    for i = 1, #favourChanges do
      local change = favourChanges[i]
      DB:SetData("fci/RoleNotePad/" .. change.roleId, nil)
      local notepads = DB:GetData("fci/RoleNotePad/")
      local _, roleNotePad = table.find(notepads, function(_, v)
        return v.roleId == change.roleId
      end)
      if roleNotePad ~= nil then
        roleNotePad.favourLevel = change.favourLevel
        roleNotePad.favour = change.favour
        DB:SetData("fci/RoleNotePad/", notepads)
      end
    end
  end
end

function NU.CreateRolesData()
  local container = _ENV["!"]({})
  local allActors = 0
  local actorConfigs = PB.all("ActorConfig")
  for _, config in pairs(actorConfigs) do
    if AU.IsActorOpen(config.id, config.openTime) then
      allActors = allActors + 1
      local roleData = container[config.role]
      if roleData == nil then
        local roleXlsx = PB.get("Role", config.role)
        local animRes = ""
        if roleXlsx then
          animRes = roleXlsx.animRes
        else
          warning("Role.xlsx", "role id not found " .. tostring(config.role))
        end
        container[config.role] = {
          roleId = config.role,
          actorIds = {
            config.id
          },
          activePoster = false,
          canReward = false,
          unlock = false,
          addTime = 0,
          animRes = animRes,
          category = config.category
        }
      else
        table.insert(roleData.actorIds, config.id)
      end
    end
  end
  local list = container:toarray()
  DB:SetData("Collections/Roles", list)
  return container, allActors, math.ceil(#list / 10)
end

function NU.CreateAllActorData()
  local container = _ENV["!"]({})
  local allActors = 0
  local actorConfigs = PB.all("ActorConfig")
  local allActors = #actorConfigs
  for _, config in pairs(actorConfigs) do
    if AU.IsActorOpen(config.id, config.openTime) then
      local roleXlsx = PB.get("Role", config.role)
      local animRes = ""
      if roleXlsx then
        animRes = roleXlsx.animRes
      else
        warning("Role.xlsx", "role id not found " .. tostring(config.role))
      end
      local tab = {
        roleId = config.role,
        id = config.id,
        activePoster = false,
        canReward = false,
        unlock = false,
        addTime = 0,
        animRes = animRes,
        category = config.category,
        kind = config.kind,
        openTime = config.openTime
      }
      container[config.id] = tab
    end
  end
  return container
end

function NU.CreateNovelsData()
  local novelList = DB:GetData("Collections/Novels")
  if not novelList then
    novelList = _ENV["!"]({})
    local novels = PB.all("Novel"):where(function(k, v)
      return v.isNovel and v.active
    end):toarray()
    for i = 1, #novels do
      novels[i].actors = table.where(novels[i].actors, function(k, v)
        local resConfig = PB.get("ActorConfig", v)
        if resConfig then
          return AU.IsActorOpen(v, resConfig.openTime)
        else
          error("Novel.xlsx", "cannot find data in ActorConfig.xlsx, actorId: " .. tostring(v) .. " ,novelId: " .. tostring(novels[i].id))
        end
      end):toarray()
      novels[i].isOpen = #novels[i].actors > 0
    end
    table.sort(novels, function(a, b)
      return a.isOpen and not b.isOpen
    end)
    local isPreCommit = WU.IsPreCommit()
    for i = 1, #novels do
      local novelData = ProtobufI("Novel", {
        unlock = false,
        canGetReward = false,
        curCover = novels[i].id,
        novelId = novels[i].id,
        curRewardNum = 0
      })
      table.merge(novelData, novels[i])
      if isPreCommit then
        if novelData.isOpen == true then
          table.insert(novelList, novelData)
          DB:SetData("Collections/Novels/" .. novels[i].id, novelData)
        end
      else
        table.insert(novelList, novelData)
        DB:SetData("Collections/Novels/" .. novels[i].id, novelData)
      end
    end
    DB:SetData("Collections/Novels", novelList)
  end
  return novelList
end

function NU.CheckBoardSpeech(type, predicate)
  local conditions = NU.GetBoardSpeechConditions(type)
  for i = 1, #conditions do
    local condition = conditions[i]
    local params = _ENV["!"]({})
    _ENV["!"](condition.params):copy(params)
    for i = 1, #params do
      if params[i] == "/" then
        params[i] = nil
      end
    end
    if predicate(condition.params) then
      return condition
    end
  end
end

function NU.GetBoardSpeechConditions(type)
  local signBoardID = DB:GetData("BoardActor/RoleId")
  local roleId = 0
  local entity = PB.get("Signboard", signBoardID)
  if entity then
    roleId = entity.roleId
  end
  local result = PB.all("BoardSpeechCondition"):where(function(_, e)
    return e.type == type and not ReachBoardSpeechLimit(e.id) and PB.get("BoardSpeech", roleId, e.id) ~= nil
  end):toarray()
  table.sort(result, function(a, b)
    return a.priority < b.priority
  end)
  return result
end

function ReachBoardSpeechLimit(id)
  local cache = DB:GetData("gameDataCache")
  local condition = PB.get("BoardSpeechCondition", id)
  return cache.boardActorSpeechTimes[id] >= condition.limit
end

function NU.UpdateCollectionsActor(actors)
  if actors == nil then
    return
  end
  local actorDataList = NU.CreateAllActorData()
  for _, r in pairs(actors) do
    local actor = actorDataList[r.id]
    if actor ~= nil then
      actor.unlock = true
      actor.activePoster = r.activePoster
      actor.canReward = r.canReward
      actor.addTime = r.addTime
    end
  end
  local array = actorDataList:toarray()
  for _, v in pairs(array) do
    local actorName = WU.GetString("ActorNameEn_" .. v.id)
    v.actorName = actorName
    v.actorFirstLetterVal = string.byte(string.upper(string.sub(actorName, 1, 1)))
  end
  DB:SetData("Collections/Actors", array)
  NU.UpdateAllCollectedActors(array)
  return array
end

function NU.AlreadyOwedActor(actorId)
  local actorsCollected = DB:GetData("CollectionsActor/ActorsCollected")
  local owed = false
  for k, v in ipairs(actorsCollected) do
    if actorsCollected[k].id == actorId then
      owed = true
      break
    end
  end
  return owed
end

function NU.GetCollectionsActor(callback)
  local actors = DB:GetData("Collections/Actors")
  if actors == nil then
    DB:GameRequest("fci/CollectionsActor"):Get(function(response)
      actors = NU.UpdateCollectionsActor(response.actors)
      if callback then
        callback(actors)
      end
    end)
  elseif callback then
    callback(actors)
  end
end

function NU.UpdateAllCollectedActors(actors)
  local actorsCollected = {}
  for _, r in pairs(actors) do
    if r.unlock then
      table.insert(actorsCollected, r)
    end
  end
  DB:SetData("CollectionsActor/ActorsCollected", actorsCollected)
  return actorsCollected
end

function NU.OpenNotepadForActor(actor)
  if WU.WindowIsLocked(PB.enum.UnlockWindow.Journey, PB.enum.UnlockWindow.Journey) then
    return
  end
  NU.GetCollectionsActor(function(actors)
    local _, findNotepadActor = table.find(actors, function(_, v)
      return v.id == actor.id
    end)
    if findNotepadActor then
      WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
        _ENV["$"](w)["$$SetViewFrom"](2)
        _ENV["$"](w)["$$SetActor"](findNotepadActor)
      end)
    else
      WU.AcquireWindowAsync("CollectionsActor")
    end
  end)
end

return NU
