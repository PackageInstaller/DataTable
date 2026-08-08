local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_chefs
local m_chefMaxLevel = 6
local m_curChefRoleId

function SetupWindow()
  WU.TraverseChildren(REF.WrapContentActor, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnChefClick)
  end)
  LU.Bind(REF.WrapContentActor, {
    updateRow = UpdateActorSlot
  })
end

function InitWindow()
  local data = this:GetData("fci/cooking-summary/")
  local chefs = data and data.roleProgressDetails
  m_curChefRoleId = data.currentRoleId or 1
  m_chefs = _ENV["!"](chefs):distinct()
  table.sort(m_chefs, function(a, b)
    return a.roleId < b.roleId
  end)
  LU.Set(REF.WrapContentActor, #m_chefs)
end

function OnChefClick(go)
  local chefInfo = _ENV["$"](go)["@chefInfo"]
  if chefInfo.roleId == m_curChefRoleId then
    WU.RecycleWindow("HotPotChefChange")
  else
    this:GameRequest("fci/cooking-summary/" .. chefInfo.roleId):Post({}, function(res)
      if res then
        local data = this:GetData("fci/cooking-summary/")
        data.currentRoleId = chefInfo.roleId
        this:BroadcastGameEvent("HotPot/ChefChange", chefInfo.roleId)
        this:DelayInvokeInFrames(2, function()
          WU.RecycleWindow("HotPotChefChange")
        end)
      end
    end)
  end
end

function UpdateActorSlot(goRef, wrapIndex, realIndex)
  if m_chefs and realIndex < #m_chefs then
    local chefInfo = m_chefs[realIndex + 1]
    goRef["@chefInfo"] = chefInfo
    WU.SetActive(goRef.SpriteCurrent, chefInfo.roleId == m_curChefRoleId)
    local roleConfig = PB.get("Role", chefInfo.roleId)
    goRef.TextureActorHead.UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_big_" .. roleConfig.animRes
    goRef.SpriteActorName.UISprite.spriteName = "actor_name_" .. roleConfig.animRes
    goRef.SpriteActorName.UISprite:SnapWithoutScale()
    goRef.LabelLevel.UILabel.text = fif(chefInfo.isMax, WU.GetString("Window_Level", "Max"), WU.GetString("Window_Level", chefInfo.level))
  end
end
