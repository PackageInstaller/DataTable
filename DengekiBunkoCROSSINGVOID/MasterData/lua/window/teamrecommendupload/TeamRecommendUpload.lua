local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_configDataManager = S:Get("ConfigDataManager")
local TR = require("Common/TeamRCMDUtil")
local m_index = 1
local m_groups = {}
local Misc = PB.all("Misc")[1]
local m_tag = 1
local maxLen = Misc.inputLimit.TeamRCMDDescription or 1

function SetupWindow()
  WU.TraverseChildren(REF.TeamTab, function(GO, index)
    local ref = _ENV["$"](GO)
    ref.LabelTab.UILabel.text = WU.GetString("WindowSpace_Team") .. index + 1
    WU.BindButtonEvent(ref.root, function()
      m_index = index + 1
    end)
  end)
  WU.TraverseChildren(REF.TagTab, function(GO, index)
    local ref = _ENV["$"](GO)
    WU.BindButtonEvent(ref.SpriteTab, function()
      m_tag = index + 1
    end)
  end)
  WU.BindButtonEvent(REF.BtnUpload, Upload)
  REF.InputDescription.UIInput.defaultText = WU.GetString("TeamRCMD_DiscripLenLimit", maxLen)
  REF.InputDescription.UIInput.characterLimit = maxLen
end

function Upload()
  local content = REF.InputDescription.UIInput.value
  if #U.trim(content) <= 0 then
    return WU.ShowHintText(WU.GetString("TeamRCMD_TeamNameEmpty"))
  end
  local data = {
    name = content,
    tag = m_tag,
    actors = m_groups[m_index],
    uploadVersion = m_configDataManager.FullVersion()
  }
  local hasActors = data.actors[1] and data.actors[2] and data.actors[3] and data.actors[4] and data.actors[5] and data.actors[6]
  if not hasActors then
    return WU.ShowHintText(WU.GetString("TeamRCMD_ActorVancant"))
  end
  this:GameRequest("fci/share-group/group/"):Post(ProtobufT("ApiShareGroupList", data), function(resp)
    for i = 1, 6 do
      resp.uploadGroup.actors[i] = TR.ActorDataStencil(resp.uploadGroup.actors[i])
    end
    this:BroadcastGameEvent("AddNewTeam", resp.uploadGroup)
    WU.AcquireWindowAsync("TeamRecommendDetails", function(UI)
      WU.RecycleWindow(this)
      DBH.ResChange(resp.resChange)
      _ENV["$"](UI)["$$SetData"](resp.uploadGroup)
    end)
  end)
end

function InitWindow()
  this:BindRemote(DB:GameRequest("fci/ActorGroup/"), OnActorGroupChanged)
end

function UninitWindow()
  this:Unbind("fci/ActorGroup/", OnActorGroupChanged)
end

function OnActorGroupChanged(groups)
  if groups then
    WU.TraverseChildren(REF.TeamTab, function(GO, index)
      local ref = _ENV["$"](GO)
      m_groups[index + 1] = TR.UpdateGroup(ref, index + 1, groups)
    end)
  end
end
