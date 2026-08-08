local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SU = require("Common/SortUtil")
local LU = require("Common/ListUtil")
local NU = require("Common/NotepadUtil")
local SDU = require("Common/SoundUtil")
local m_allList, m_nowActor, m_indexOfcurrentSelectedActor, m_nowAudioSource
local m_init = false
local m_nowSelectedWidget
local m_widthOfWhenHasImage = 300
local m_widthOfWhenNotHasImage = 435
local m_lastBindRoleId

function SetupWindow()
  WU.BindButtonEvent(REF.BtnEnterThis, function()
    WU.RecordButtonClick(100134001)
    if m_nowActor then
      this:SetData("Notepad/AllSortedNotepads", m_allList)
      this:SetData("Notepad/SelectedRoleId", m_nowActor.roleId)
      WU.AcquireWindowAsync("RoleNotepadDetail")
      if m_nowAudioSource ~= nil then
        m_nowAudioSource:Stop()
      end
    end
  end)
  WU.BindButtonEvent(REF.ActorTexture, function()
    if m_nowAudioSource ~= nil and m_nowAudioSource.isPlaying then
      return
    end
    if m_nowActor ~= nil then
      m_nowAudioSource = SDU.PlayActorNotePad(m_nowActor.roleId)
    end
  end)
  LU.Bind(REF.WrapContent, {
    updateRow = OnInitItemAtIndex,
    delta = 0.03
  })
end

function InitWindow()
  local inInit = true
  this:Bind("fci/RoleNotePad/", function(notepads)
    local all = notepads
    m_init = false
    if all ~= nil and 0 < #all then
      if inInit then
        local sort = PB.get("Sort", 17)
        SU.SortOnce(all, sort, true)
        m_allList = all
        local firstData = m_allList[1]
        m_nowActor = firstData
        m_indexOfcurrentSelectedActor = 1
      end
      m_allList = all
      InitTheActorInfo()
      OnScrollViewChanged(inInit)
      REF.NodeScrollView.gameObject:SetActive(true)
      REF.BGNode.gameObject:SetActive(true)
    else
      REF.NodeScrollView.gameObject:SetActive(false)
      REF.BGNode.gameObject:SetActive(false)
    end
  end)
  inInit = false
  this:Bind("SortFinished", OnSortFinished)
  this:RegisterGameEvent("RoleNotePadDetailSwitch", OnSelectedRoleIdChanged)
end

function OnSortFinished(data)
  if data ~= nil and REF["$SortMate"] == data.sortMate then
    m_allList = data.list
    m_nowActor = m_allList[1]
    if m_nowActor then
      OnSelectedRoleIdChanged(m_nowActor.roleId)
    end
    OnScrollViewChanged(false)
  end
end

function OnSelectedRoleIdChanged(roleId)
  if roleId ~= nil then
    local _, data = table.find(m_allList, function(_, v)
      return v.roleId == roleId
    end)
    if data == nil then
      m_nowActor = m_allList[1]
    else
      m_nowActor = data
    end
    OnScrollViewChanged(true)
    InitTheActorInfo()
  end
end

function InitTheActorInfo()
  local role = PB.get("Role", m_nowActor.roleId)
  REF.LabelLastestActorDesc.UILabel.text = ""
  REF.IconActorHeader.UISprite.spriteName = ""
  if m_lastBindRoleId ~= nil then
    this:Unbind("fci/RoleNotePad/" .. m_lastBindRoleId, OnGetRoleNotepadEvents)
  end
  m_lastBindRoleId = m_nowActor.roleId
  this:BindRemote(DB:GameRequest("fci/RoleNotePad/" .. m_lastBindRoleId), OnGetRoleNotepadEvents)
  REF.ActorTexture.UITexture.mainTexturePath = "Texture/ActorPortrait/actor_portrait_" .. tostring(role.animRes)
  local width = REF.ActorTexture.UITexture.width
  local height = REF.ActorTexture.UITexture.height
  local allActorConfig = PB.all("ActorConfig")
  local actorCofnig
  for _, v in pairs(allActorConfig) do
    if v.role == m_nowActor.roleId then
      actorCofnig = v
      break
    end
  end
  local offsetX = -actorCofnig.portraitUVOffsetX / width
  local offsetY = actorCofnig.portraitUVOffsetY / height
  local tileX = 1
  local tileY = 1
  REF.ActorTexture.UITexture.uvRect = CS.UnityEngine.Rect(offsetX, offsetY, tileX, tileY)
end

function OnGetRoleNotepadEvents(data)
  if data then
    local all = PB.all("PlayerHeadPhoto")
    local role = PB.get("Role", data.roleId)
    local theLastEvent = data.notepadEvents[#data.notepadEvents]
    if theLastEvent ~= nil then
      local jsonObj = JsonD(theLastEvent.text)
      if theLastEvent.type == PB.enum.NotePadEventType.GetChatImage then
        WU.ToggleRendering(REF.BgIconActor, true)
        WU.ToggleRendering(REF.BgIconActorVideo, false)
        WU.ToggleRendering(REF.BgIconSkin, false)
        WU.ToggleRendering(REF.BgIconPostcard, false)
        REF.LabelLastestActorDesc.UILabel.width = m_widthOfWhenHasImage
        local chatEmojiConfig = PB.get("ChatImage", 1, jsonObj.id)
        REF.IconActorHeader.UISprite.atlasPath = chatEmojiConfig.atlas
        REF.IconActorHeader.UISprite.spriteName = chatEmojiConfig.sprite
      elseif theLastEvent.type == PB.enum.NotePadEventType.GetHeadPhoto then
        WU.ToggleRendering(REF.BgIconActor, true)
        WU.ToggleRendering(REF.BgIconActorVideo, false)
        WU.ToggleRendering(REF.BgIconSkin, false)
        WU.ToggleRendering(REF.BgIconPostcard, false)
        local _, val = table.find(all, function(k, v)
          return data.roleId == v.imageRoleId
        end)
        if val ~= nil then
          REF.IconActorHeader.UISprite.spriteName = val.sprite
          REF.IconActorHeader.UISprite.atlasPath = val.atlas
        else
          error("RoleNotepad", "\232\175\165\232\167\146\232\137\178\230\178\161\230\156\137\229\175\185\229\186\148\231\154\132playerheadicon")
          REF.IconActorHeader.UISprite.spriteName = ""
          REF.LabelLastestActorDesc.UILabel.text = ""
        end
        REF.LabelLastestActorDesc.UILabel.width = m_widthOfWhenHasImage
      elseif theLastEvent.type == PB.enum.NotePadEventType.NotePadEventType_Cartoon then
        WU.ToggleRendering(REF.BgIconActor, false)
        WU.ToggleRendering(REF.BgIconActorVideo, true)
        WU.ToggleRendering(REF.BgIconSkin, false)
        WU.ToggleRendering(REF.BgIconPostcard, false)
        REF.LabelLastestActorDesc.UILabel.width = m_widthOfWhenHasImage
        local cartoonConfig = PB.get("CartoonConfig", jsonObj.id)
        REF.IconActorVideo.UITexture.mainTexturePath = "Texture/JouneyVideo/" .. cartoonConfig.movieIcon
      elseif theLastEvent.type == PB.enum.NotePadEventType.NotePadEventType_UnlockActorSkin then
        WU.ToggleRendering(REF.BgIconActor, false)
        WU.ToggleRendering(REF.BgIconActorVideo, false)
        WU.ToggleRendering(REF.BgIconSkin, true)
        WU.ToggleRendering(REF.BgIconPostcard, false)
        REF.WidgetIconSkin["$SetData"](jsonObj.id)
        REF.LabelLastestActorDesc.UILabel.width = m_widthOfWhenHasImage
      elseif theLastEvent.type == PB.enum.NotePadEventType.NotePadEventType_Postcard then
        WU.ToggleRendering(REF.BgIconActor, false)
        WU.ToggleRendering(REF.BgIconActorVideo, false)
        WU.ToggleRendering(REF.BgIconSkin, false)
        WU.ToggleRendering(REF.BgIconPostcard, true)
        REF.IconActorPostcard.UISprite.spriteName = "postcard_small_01"
        REF.LabelLastestActorDesc.UILabel.width = m_widthOfWhenHasImage
      else
        WU.ToggleRendering(REF.BgIconActor, false)
        WU.ToggleRendering(REF.BgIconActorVideo, false)
        WU.ToggleRendering(REF.BgIconSkin, false)
        WU.ToggleRendering(REF.BgIconPostcard, false)
        REF.LabelLastestActorDesc.UILabel.width = m_widthOfWhenNotHasImage
      end
      REF.LabelLastestActorDesc.UILabel.text = NU.GetNotepadText(theLastEvent, data)
    end
  end
end

function IsCurrentSelectedRoleChanged()
  local index = 0
  index = table.find(m_allList, function(k, v)
    return v.roleId == m_nowActor.roleId
  end)
  return index
end

function OnScrollViewChanged(reset)
  local index = IsCurrentSelectedRoleChanged()
  m_indexOfcurrentSelectedActor = index
  LU.Set(REF.WrapContent, #m_allList, reset)
  if reset then
    local itemHeight = REF.WrapContent.UIWrapContent.itemSize
    if 3 < index then
      local dis = (index - 3) * itemHeight
      REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(0, dis, 0))
    end
  end
end

function OnInitItemAtIndex(goRef, wrapIndex, realIndex)
  WU.ToggleRendering(goRef["$"], realIndex ~= nil)
  if realIndex ~= nil and m_allList ~= nil and realIndex < #m_allList then
    local index = realIndex + 1
    local data = m_allList[index]
    goRef["$$SetData"](data)
    goRef["$$SetClickCallback"](function()
      m_nowActor = data
      if m_nowSelectedWidget ~= nil then
        m_nowSelectedWidget["$$SetSelected"](false)
      end
      m_nowSelectedWidget = goRef
      m_nowSelectedWidget["$$SetSelected"](true)
      m_indexOfcurrentSelectedActor = index
      InitTheActorInfo()
      this:SetData("Notepad/SelectedRoleId", m_nowActor.roleId)
    end)
    if not m_init then
      if index == 1 then
        m_nowSelectedWidget = goRef
        m_indexOfcurrentSelectedActor = index
        m_nowSelectedWidget["$$SetSelected"](true)
      else
        goRef["$$SetSelected"](false)
      end
      if index == #REF.WrapContent then
        m_init = true
      end
    end
    if m_indexOfcurrentSelectedActor == index then
      goRef["$$SetSelected"](true)
      m_nowSelectedWidget = goRef
    else
      goRef["$$SetSelected"](false)
    end
  end
end

function Focus(on)
  WU.RecordWindowFocus(100134, on)
end
