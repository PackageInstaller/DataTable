local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local GotoUtil = require("Common/GotoUtil")
local RandomPhonyId = -1
local m_actor, m_actorUid, m_dragDelta, m_selectedSkinId, m_randomSkinList, m_randomSkinShowList, m_sentListWhenUnlocked, m_randomUnlocked, m_actorSwitched
local RandomSkinLimitNum = PB.index("Misc", 1).randomSkinLimitNum

function SetupWindow()
  WU.BindDragEvent(REF.NodeSkinPreview, OnDraging)
  WU.BindPressEvent(REF.NodeSkinPreview, OnPress)
  WU.BindButtonEvent(REF.ButtonOperation, OnClickButton)
  WU.BindButtonEvent(REF.ButtonEdit, OnClickEdit)
  WU.BindButtonEvent(REF.ButtonOperationRandom, OnClickButtonRandom)
  REF.ScrollViewSkinList.UIPanel:AddOnClipMoveListener(OnScrollViewMove)
  WU.TraverseChildren(REF.WrapContentSkinSource, function(go)
    WU.BindButtonEvent(_ENV["$"](go).root, OnSkinSourceClick)
  end)
  LU.Bind(REF.WrapContentSkin, {
    updateRow = UpdateRowSkin
  })
  LU.Bind(REF.WrapContentSkinSource, {
    updateRow = UpdateRowSkinSource
  })
  LU.Bind(REF.WrapContentPreview, {
    dataSource = function(dataIndex)
      if m_randomSkinShowList then
        return m_randomSkinShowList[dataIndex]
      end
    end,
    updateSlot = UpdatePreviewSlot
  })
end

function InitWindow()
  this:Bind("Actor/SelectedUid", OnCurrentActorUidChanged)
  WU.SetActive(REF.EffectStageLoop, false)
  WU.SetActive(REF.EffectStageSwitch, false)
  WU.SetActive(REF.EffectStageOpen, true)
  this:DelayInvokeInSeconds(0.5, function()
    WU.SetActive(REF.EffectStageLoop, true)
    WU.SetActive(REF.EffectStageOpen, false)
  end)
  local triggered = WU.GetGameDataCache("ActorSkinNewFuncHintTriggered")
  WU.SetActive(REF.TipTweener, not triggered)
  if not triggered then
    this:DelayInvokeInSeconds(5, function()
      WU.SetActive(REF.TipTweener, false)
    end)
  end
end

function OnCurrentActorUidChanged(uid)
  if uid then
    if m_actorUid then
      this:Unbind("fci/actor/" .. m_actorUid, OnActorChange)
      this:Unbind("fci/random-skin/" .. m_actorUid, OnRandomSkinChange)
    end
    m_actorUid = uid
    if m_actorUid then
      this:Bind("fci/actor/" .. m_actorUid, OnActorChange)
    end
  end
end

function OnActorChange(actor)
  if actor ~= nil and actor ~= nil then
    m_actorSwitched = m_actor ~= nil and m_actor.uid ~= actor.uid
    m_actor = actor
    if m_actor.randomSkin then
      LU.Set(REF.WrapContentPreview, 0)
      m_selectedSkinId = RandomPhonyId
    else
      m_selectedSkinId = m_actor.actorSkin
    end
    this:Unbind("fci/random-skin/" .. m_actorUid, OnRandomSkinChange)
    this:BindRemote(this:GameRequest("fci/random-skin/" .. m_actorUid), OnRandomSkinChange)
  end
end

function OnRandomSkinChange(result)
  if result then
    m_randomSkinList = result.skinList
    if 0 < #m_randomSkinList then
      m_randomUnlocked = true
    else
      local skinIds = _ENV["!"](this:GetData("actor2skin")[m_actor.id]):where(function(k, v)
        return this:GetData("fci/unlockedSkins")[v]
      end):toarray()
      local skinCnt = skinIds:count()
      m_randomUnlocked = skinCnt >= RandomSkinLimitNum
      if m_randomUnlocked and m_sentListWhenUnlocked ~= m_actor.uid then
        m_sentListWhenUnlocked = m_actor.uid
        this:GameRequest("fci/random-skin/" .. m_actor.uid):Post(ProtobufT("ApiActorRandomSkin", {skinList = skinIds, onlySetList = true}), function(resp)
          this:SetData("fci/random-skin/" .. m_actor.uid, resp)
        end)
      end
    end
    if m_actor.randomSkin then
      SetRandomView()
    else
      SetView(m_actor == nil or m_actorSwitched)
      m_actorSwitched = false
    end
  end
end

function SwitchActor(val)
  local selectedUid = this:GetData("Actor/SelectedUid")
  local traverseActors = this:GetData("Actor/RollerTraverse")
  if traverseActors then
    local idx = table.find(traverseActors, function(k, v)
      return v and v.uid == selectedUid
    end)
    if idx then
      local oIdx = idx
      if #traverseActors == 1 then
        return
      end
      idx = idx + val
      if idx > #traverseActors then
        idx = 1
      elseif idx < 1 then
        idx = #traverseActors
      end
      if oIdx ~= idx then
        this:SetData("Actor/SelectedUid", traverseActors[idx].uid)
        if not REF.EffectStageSwitch.gameObject.active then
          WU.SetActive(REF.EffectStageLoop, false)
          WU.SetActive(REF.EffectStageSwitch, true)
          this:DelayInvokeInSeconds(0.8, function()
            WU.SetActive(REF.EffectStageLoop, true)
            WU.SetActive(REF.EffectStageSwitch, false)
          end)
        end
      end
    end
  end
end

function UpdateRowSkin(refRow, wrapIndex, rowIndex)
  local skinIds = _ENV["!"](this:GetData("actor2skin")[m_actor.id])
  if rowIndex == 0 then
    refRow["$$SetRandom"](m_randomUnlocked, m_actor.randomSkin)
    refRow["$$SetClickCallback"](OnClickRandomWidgetSkin)
    refRow["$$SetSelected"](RandomPhonyId == m_selectedSkinId)
  elseif skinIds and rowIndex ~= nil and rowIndex <= #skinIds then
    local skinId = skinIds[rowIndex]
    refRow["$$SetData"](skinId, m_actorUid)
    refRow["$$SetClickCallback"](function()
      OnClickWidgetSkin(skinId)
    end)
    refRow["$$SetSelected"](skinId == m_selectedSkinId)
  end
end

function UpdateRowSkinSource(refRow, wrapIndex, rowIndex)
  local sourceIds = PB.get("ActorSkin", m_selectedSkinId).sources
  if m_selectedSkinId and rowIndex ~= nil and rowIndex < #sourceIds then
    local sourceId = sourceIds[rowIndex + 1]
    local sourceData = PB.get("Goto", sourceId)
    refRow.Label.UILabel.text = WU.GetString("Goto_" .. sourceId)
    refRow["@windowName"] = sourceData.windowName
    refRow["@params"] = sourceData.params
    refRow["$UISprite"].alpha = fif(sourceData.windowName == "None", 0.5, 1)
  end
end

function UpdatePreviewSlot(ref, skinId)
  ref["$$Clear"]()
  this:DelayInvokeInFrames(1, function()
    ref["$$SetData"](m_actor.id, skinId, this:GetData("fci/unlockedSkins")[skinId])
  end)
end

function OnClickWidgetSkin(skinId)
  m_selectedSkinId = skinId
  if this:GetData("fci/newSkins")[skinId] then
    RequestSetOldSkin(skinId, function(resp)
      local newSkins = this:GetData("fci/newSkins")
      newSkins[skinId] = false
      this:SetData("fci/newSkins", newSkins)
      SetView()
    end)
  else
    SetView()
  end
end

function OnClickRandomWidgetSkin()
  m_selectedSkinId = RandomPhonyId
  SetRandomView()
end

function SetView(resetWrapContentList)
  if resetWrapContentList == nil then
    resetWrapContentList = false
  end
  WU.SetActive(REF.NodeRealSkin, true)
  WU.SetActive(REF.NodeRandomSkin, false)
  local actorId = m_actor.id
  local actor2skin = this:GetData("actor2skin")
  local resSkin = PB.get("ActorSkin", m_selectedSkinId)
  if m_selectedSkinId ~= 0 and resSkin == nil then
    error("ActorSkin.xlsx", "can't find skin, id: " .. m_selectedSkinId)
    return
  end
  local unlocked = this:GetData("fci/unlockedSkins")[m_selectedSkinId]
  local resConfig = PB.get("ActorConfig", actorId)
  REF.LabelSkinName.UILabel.text = WU.GetString("ActorSkinName_" .. m_selectedSkinId)
  REF.LabelSkinDesc.UILabel.text = WU.GetStringEmpty("ActorSkinDesc_" .. m_selectedSkinId)
  local actorIds = {}
  if m_selectedSkinId == 0 then
    actorIds = {actorId}
  else
    for i = 1, #resSkin.actorIds do
      local resConfig = PB.get("ActorConfig", resSkin.actorIds[i])
      if resConfig and AU.IsActorOpen(resConfig.id, resConfig.openTime) then
        table.insert(actorIds, resConfig.id)
      end
    end
  end
  for i = 0, #REF.GridApplicable - 1 do
    local actorId = actorIds[i + 1 - (#REF.GridApplicable - #actorIds)]
    local refIcon = REF.GridApplicable[i]
    WU.SetActive(refIcon.root, actorId ~= nil)
    if actorId then
      refIcon["$$SetData"](actorId)
    end
  end
  SetListView(resetWrapContentList)
  local sourceIds = resSkin and resSkin.sources or {}
  LU.Set(REF.WrapContentSkinSource, #sourceIds, true, false)
  _ENV["$"](REF.WidgetSkinPreview).TexturePreview.ActorUIPreview:ResetActor(actorId, AU.GetActorPaletteIndex(actorId, m_selectedSkinId))
  WU.SetActive(REF.ButtonOperation, unlocked and (m_selectedSkinId ~= m_actor.actorSkin or m_actor.randomSkin))
end

function SetRandomView(resetWrapContentList)
  WU.SetActive(REF.NodeRealSkin, false)
  WU.SetActive(REF.NodeRandomSkin, true)
  local actorId = m_actor.id
  SetListView(resetWrapContentList)
  _ENV["$"](REF.WidgetSkinPreview).TexturePreview.ActorUIPreview:ResetActor(actorId, AU.GetActorPaletteIndex(actorId, 0))
  local skinIds = _ENV["!"](this:GetData("actor2skin")[actorId] or {})
  local skinCnt = skinIds:where(function(k, v)
    return this:GetData("fci/unlockedSkins")[v]
  end):count()
  REF.LabelOwn.UILabel.text = WU.GetString("EventActivity_NowOwe") .. string.format("  [EA6363FF]%s[-]/%s", skinCnt, RandomSkinLimitNum)
  local unlocked = skinCnt >= RandomSkinLimitNum
  WU.SetActive(REF.NodeOwn, unlocked)
  WU.SetActive(REF.NodeUnown, not unlocked)
  if unlocked then
    m_randomSkinShowList = m_randomSkinList
  else
    m_randomSkinShowList = skinIds:where(function(k, v)
      return this:GetData("fci/unlockedSkins")[v]
    end):toarray()
  end
  WU.SetActive(REF.SpriteInUse, m_actor.randomSkin)
  WU.SetActive(REF.ButtonOperationRandom, not m_actor.randomSkin)
  LU.Set(REF.WrapContentPreview, math.ceil(#m_randomSkinShowList / 3))
end

function SetListView(resetWrapContentList)
  local actorId = m_actor.id
  local skinIds = this:GetData("actor2skin")[actorId] or {}
  table.sort(skinIds, function(a, b)
    if a == 0 then
      return true
    end
    if b == 0 then
      return false
    end
    local ua = fif(this:GetData("fci/unlockedSkins")[a], 1, 0)
    local ub = fif(this:GetData("fci/unlockedSkins")[b], 1, 0)
    if ua ~= ub then
      return ua > ub
    end
    return a < b
  end)
  LU.Set(REF.WrapContentSkin, #skinIds + 1, resetWrapContentList, false)
end

function RequestSetOldSkin(skinId, callback)
  this:GameRequest("fci/new-flag"):Patch({
    isNew = false,
    resInfo = {
      {
        idOrUid = skinId,
        type = PB.enum.ResourceType.ResActorSkin
      }
    }
  }, function(resp)
    callback(resp)
  end)
end

function RequestChangeSkin(skinId)
  this:GameRequest("fci/actor/{Actor/SelectedUid}/skin"):Patch({actorSkin = skinId}, function(resp)
    m_actor.actorSkin = resp.actorSkin
    m_actor.randomSkin = false
    this:SetData("fci/actor/{Actor/SelectedUid}", m_actor)
  end)
end

function OnSkinSourceClick(go)
  local windowName = _ENV["$"](go)["@windowName"]
  local params = _ENV["$"](go)["@params"]
  if windowName ~= "None" then
    GotoUtil.Goto(windowName, params)
  end
end

function OnDraging(go, delta)
  m_dragDelta = m_dragDelta + delta
end

function OnPress(go, press)
  if press then
    m_dragDelta = CS.UnityEngine.Vector2.zero
  elseif m_dragDelta.x < -100 then
    SwitchActor(1)
  elseif m_dragDelta.x > 100 then
    SwitchActor(-1)
  end
end

function OnClickButton()
  if this:GetData("fci/unlockedSkins")[m_selectedSkinId] then
    RequestChangeSkin(m_selectedSkinId)
  end
end

function OnClickButtonRandom()
  if _ENV["!"](m_randomSkinList):count() > 1 then
    this:GameRequest("fci/random-skin/" .. m_actor.uid):Post(ProtobufT("ApiActorRandomSkin", {skinList = m_randomSkinList, onlySetList = false}), function(resp)
      m_actor.randomSkin = true
      this:SetData("fci/actor/{Actor/SelectedUid}", m_actor)
    end)
  else
    WU.ShowHintText(WU.GetString("Window_ActorSkinRandomHint4"))
  end
end

function OnClickEdit()
  local skinIds = _ENV["!"](this:GetData("actor2skin")[m_actor.id]):where(function(k, v)
    return this:GetData("fci/unlockedSkins")[v]
  end):toarray()
  local skinCnt = skinIds:count()
  if m_randomUnlocked then
    WU.AcquireWindowAsync("ActorSkinEdit")
  else
    WU.ShowHintText(WU.GetString("Window_ActorSkinRandomHint5", RandomSkinLimitNum - skinCnt))
  end
end

function OnScrollViewMove()
  local triggered = WU.GetGameDataCache("ActorSkinNewFuncHintTriggered")
  if not triggered then
    WU.SetGameDataCache("ActorSkinNewFuncHintTriggered", true)
    WU.SetActive(REF.TipTweener, false)
  end
end
