local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local RU = require("Common/RedMarkUtil")
local m_data, m_index

function Start()
  WU.BindButtonEvent(REF.NodePresent, function()
    if m_index ~= nil then
      this:GameRequest("fci/RolePresent/" .. m_data[m_index].presentId):Post({}, function(result)
        DBH.ResChange(result.resChange)
        table.remove(m_data, m_index)
        WU.ShowRewards(result.resChange, function()
          if #m_data == 0 then
            m_index = nil
            WU.ToggleRendering(REF.NodePresent, false)
            WU.ToggleRendering(REF.DefaultDisplay, true)
            RU.SetRedMark("Welfare/RolePresent", false)
          else
            SetRoleActor(m_index)
          end
        end)
      end)
    end
  end)
end

function OnEnable()
  this:BindRemote(DB:GameRequest("fci/RolePresent/"), OnRolePresent)
end

function OnDisable()
  this:Unbind("fci/RolePresent/", OnRolePresent)
end

function SetRoleActor(index)
  m_index = index
  local data = m_data[index]
  if data ~= nil then
    local role = PB.get("Role", data.roleId)
    REF.PresentRoleTexture.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. role.animRes
    REF.PresentRoleTexture.transform.localPosition = CS.UnityEngine.Vector3(role.portraitOffsetX, role.portraitOffsetY, 0)
  end
end

function OnRolePresent(data)
  if data then
    m_index = nil
    WU.ToggleRendering(REF.NodePresent, data ~= nil and 0 < #data)
    WU.ToggleRendering(REF.DefaultDisplay, data == nil or #data == 0)
    if data ~= nil then
      m_data = data
      SetRoleActor(1)
    end
  end
end
