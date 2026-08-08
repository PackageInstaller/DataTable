local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_kCallback
local m_bSelected = false
local BoardType = {T_DRAW = 2, T_EMOTE = 1}

function Start()
  WU.BindButtonEvent(REF.ButtonSlot, OnTabClick)
end

function OnTabClick(go)
  if m_kCallback ~= nil then
    m_kCallback(go)
  end
end

function IsSelected()
  return m_bSelected
end

function SetSelected(selected)
  m_bSelected = selected
  WU.ToggleRendering(REF.NodeRequire, not selected)
  WU.ToggleRendering(REF.AlreadySet, selected)
end

function SetClickCallback(func)
  m_kCallback = func
end

function SetData(dataBoard)
  if dataBoard.signboardId == this:GetData("BoardActor/RoleId") then
    SetSelected(true)
  else
    m_bSelected = false
    if not dataBoard.unlocked then
      REF.IconActorTexture.UITexture.graify = false
      REF.LabelRequire.UILabel.text = WU.GetString("Notepad_favour_level_required", dataBoard.favourLevel)
      if dataBoard.unlockType ~= PB.enum.SignboardUnlockType.ActorSignboardGift then
        REF.LabelRequire.UILabel.text = WU.GetString("Notepad_favour_level_required", dataBoard.favourLevel)
      else
        REF.LabelRequire.UILabel.text = WU.GetString("Notepad_christmas_reward_required")
      end
      WU.ToggleRendering(REF.NodeRequire, true)
      WU.ToggleRendering(REF.AlreadySet, false)
      if dataBoard.unlockType == PB.enum.SignboardUnlockType.ActorEverGotAndFavourLevel then
        local resUnlocked = false
        if dataBoard.checkResUnlock then
          for i = 1, #dataBoard.checkRes do
            local item = dataBoard.checkRes[i]
            local count = GetCount(item.type, item.id)
            if count >= item.count then
              resUnlocked = true
              break
            end
          end
        end
        if not resUnlocked then
          REF.LabelRequire.UILabel.text = WU.GetString("Error_SignboardLocked")
          REF.IconActorTexture.UITexture.graify = true
        end
      end
    else
      WU.ToggleRendering(REF.NodeRequire, false)
      WU.ToggleRendering(REF.AlreadySet, false)
    end
  end
  if dataBoard.unlockType ~= PB.enum.SignboardUnlockType.ActorSignboardGift then
    local actorConfigs = PB.all("ActorConfig")
    local theConfig
    for _, config in pairs(actorConfigs) do
      if config.id == dataBoard.res then
        theConfig = config
      end
    end
    if dataBoard.type == BoardType.T_DRAW then
      REF.IconActorTexture.UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_big_" .. theConfig.animRes
      REF.LabelName.UILabel.text = WU.GetString("emote_name_static")
    elseif dataBoard.type == BoardType.T_EMOTE then
      REF.LabelName.UILabel.text = WU.GetString("emote_name_dynamic")
      REF.IconActorTexture.UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_emote_big_" .. theConfig.animRes
    end
  elseif dataBoard.type == BoardType.T_DRAW then
    REF.IconActorTexture.UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_big_" .. dataBoard.roleNotepadRes
    REF.LabelName.UILabel.text = WU.GetString("emote_name_static")
  elseif dataBoard.type == BoardType.T_EMOTE then
    REF.LabelName.UILabel.text = WU.GetString("emote_name_dynamic")
    REF.IconActorTexture.UITexture.mainTexturePath = "Texture/ActorHeadBig/actor_head_emote_big_" .. theConfig.roleNotepadRes
  end
end

function GetCount(type, id)
  if type == PB.enum.ResourceType.ResItem then
    local itemInfo = DB:GetData("fci/item/" .. id)
    if itemInfo then
      return itemInfo.count
    else
      return 0
    end
  elseif type == PB.enum.ResourceType.ResMedal then
    local medals = DB:GetData("fci/medal")
    local _, medalInfo = table.find(medals, function(k, v)
      return v.id == id
    end)
    if medalInfo then
      return 1
    else
      return 0
    end
  else
    return DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[type] .. "_" .. id) or 0
  end
end
