local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local SU = require("Common/SortUtil")
local m_countPerPage = 10

function Start()
  WU.TraverseChildren(REF["$"], function(go)
    _ENV["$"](go)["$$SetClickCallback"](OnClickRoleSlot)
  end)
end

function OnClickRoleSlot(go)
  WU.AcquireWindowAsync("CollectionsActorDetail", function(w)
    _ENV["$"](w)["$$SetRole"](_ENV["$"](go)["@roleId"])
  end)
end

function SetData(pageIndex)
  local roles = this:GetData("Collections/Roles")
  WU.TraverseChildren(REF["$"], function(go, i)
    local ref = _ENV["$"](go)
    local roleIndex = m_countPerPage * pageIndex + i + 1
    ref["$gameObject"]:SetActive(roleIndex <= #roles)
    if roleIndex <= #roles then
      ref["@roleId"] = roles[roleIndex].roleId
      ref["$$SetActorByRoleId"](roles[roleIndex].roleId, fif(#roles[roleIndex].actorIds == 1, 1, 2), not roles[roleIndex].unlock)
    end
  end)
end

function SetDragCallback(dragCallback)
  WU.TraverseChildren(REF["$"], function(go)
    _ENV["$"](go)["$$SetDragCallback"](dragCallback)
  end)
end
