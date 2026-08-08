local WU, DB = require("Common/WindowUtil")()
local DB = CS.DataBindingManager.Instance
local PB = require("Common/PbHelper")
local TR = {
  TypeColor = {
    [1] = CS.NGUIMath.HexToColor(3228886271),
    [2] = CS.NGUIMath.HexToColor(1368977663),
    [3] = CS.NGUIMath.HexToColor(918340351)
  },
  ChatColorSet = {
    [PB.enum.CommentPlayerType.None] = CS.NGUIMath.HexToColor(2207429119),
    [PB.enum.CommentPlayerType.Up] = CS.NGUIMath.HexToColor(26864127),
    [PB.enum.CommentPlayerType.Me] = CS.NGUIMath.HexToColor(64677887)
  }
}

function TR.ActorDataStencil(actor)
  return {
    id = actor.id
  }
end

function TR.UpdateGroup(ref, teamNum, groups)
  local members = groups[tostring(teamNum)].members
  local actors = {}
  for index = 1, 6 do
    local member = members[index]
    if member then
      local actor = member.actor
      actors[index] = actor
      if actor == nil then
        if member.actorUid == nil or member.actorUid == 0 then
          actor = {id = -3}
        else
          actor = DB:GetData("fci/actor/" .. member.actorUid)
          if actor then
            actor = TR.ActorDataStencil(actor)
            actors[index] = actor
          else
            actor = {id = -3}
          end
        end
      end
      local Gasketactor = ref["WidgetIconActor" .. index]
      Gasketactor["$SetActorCustom"](actor)
    end
  end
  return actors
end

function TR.AppraiseRequest(groupData, op)
  DB:GameRequest("fci/share-group/group-like/" .. groupData.groupId):SyncInput(false):Post({opType = op}, function(resp)
    groupData.likeCount = resp.likeCount
    groupData.dislikeCount = resp.dislikeCount
    groupData.liked = true
    DB:BroadcastGameEvent("UpdateTeamDetails", groupData)
  end)
end

function TR.AcqPointChange()
  DB:GameRequest("fci/share-group/personal"):Get(function(resp)
    if resp.addPoint > 0 then
      WU.ShowHintText(WU.GetString("TeamRCMD_PointChange", resp.addPoint))
    end
  end)
end

return TR
