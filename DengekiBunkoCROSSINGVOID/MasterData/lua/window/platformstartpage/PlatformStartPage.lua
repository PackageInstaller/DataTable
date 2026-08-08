local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local IU = require("Common/ItemUtil")
local DU = require("Common/DungeonUtil")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local m_summary, m_drops, m_hasMoreFloor
local m_hasValidGroup = true

function SetupWindow()
end

function InitWindow()
end

function SetData(data)
  local pt
  if data == nil then
    local accountCache = this:GetData("accountCache")
    pt = accountCache.socialPlatform
  else
    pt = data.socialPlatform
  end
  local platform = U.ToEnum(CS.Msdk.ePlatform, pt)
  REF.QQ.gameObject:SetActive(false)
  REF.WX.gameObject:SetActive(false)
  if platform == CS.Msdk.ePlatform.ePlatform_QQ then
    REF.QQ.gameObject:SetActive(true)
  else
    REF.WX.gameObject:SetActive(true)
  end
end
