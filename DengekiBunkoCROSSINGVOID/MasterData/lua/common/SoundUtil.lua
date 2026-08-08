local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local SDU = {}

function SDU.PlayActorWin(actorID)
  local resActorConfig = PB.get("ActorConfig", actorID)
  if resActorConfig == nil then
    return
  end
  CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.voiceRes .. "/Event/Win", 1.0)
end

function SDU.PlayActorAdded(actorID)
  local resActorConfig = PB.get("ActorConfig", actorID)
  if resActorConfig == nil then
    return
  end
  CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.voiceRes .. "/Event/Choose", 1.0)
end

function SDU.StopActorAdded(actorID)
  local _, resActorConfig = PB.get("ActorConfig", actorID)
  if resActorConfig == nil then
    return
  end
  CS.SoundManager.Instance:StopSound("Voice/" .. resActorConfig.voiceRes .. "/Event/Choose")
end

function SDU.PlayActorWiki(roleID)
  local _, resActorConfig = PB.all("ActorConfig"):find(function(_, v)
    return v.role == roleID
  end)
  if resActorConfig == nil then
    return
  end
  return CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.voiceRes .. "/Event/Encyclopedia", 1.0)
end

function SDU.PlayActorNotePad(roleID, usedforBoard, signBoardId)
  local _, resActorConfig = PB.all("ActorConfig"):find(function(_, v)
    return v.role == roleID
  end)
  if resActorConfig == nil then
    return
  end
  if usedforBoard then
    local signBoard = PB.get("Signboard", signBoardId)
    local boardTab = PB.get("BoardActorConfig", signBoard.BoardOfEmote)
    local audioTab = {}
    for i = 1, #boardTab.actions do
      if boardTab.actions[i].audio ~= "" then
        table.insert(audioTab, boardTab.actions[i].audio)
      end
    end
    local adName = audioTab[math.random(1, #audioTab)]
    return CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.voiceRes .. "/board_Emote/" .. adName, 1.0)
  else
    return CS.SoundManager.Instance:PlaySound("Voice/" .. resActorConfig.voiceRes .. "/Event/Journaling", 1.0)
  end
end

function SDU.PlaySaku()
  local _, sakuConfig = table.find(PB.all("Signboard"), function(_, v)
    return v.type == PB.enum.SignboardType.Virtual
  end)
  local boardTab = PB.get("BoardActorConfig", sakuConfig.BoardOfEmote)
  local audioTab = {}
  for i = 1, #boardTab.actions do
    if boardTab.actions[i].audio ~= "" then
      table.insert(audioTab, boardTab.actions[i].audio)
    end
  end
  local adName = audioTab[math.random(1, #audioTab)]
  return CS.SoundManager.Instance:PlaySound("Voice/saku/board_Emote/" .. adName, 1.0)
end

return SDU
