local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local IU = require("Common/ItemUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local m_manualBox, m_dataList, m_isPreview, m_callback, m_goodsInfo, m_usedInConditionReward, m_usedInTaskPresent, m_usedInTaskPresentChoose

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollViewActor.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  LU.Bind(REF.WrapContentActor, {
    updateRow = UpdateActorSlot
  })
  for i = 1, #REF.WrapContentActor do
    REF.WrapContentActor[i - 1]["$$SetClickCallback"](OnActorClick)
  end
  WU.BindButtonEvent(REF.ButtonClose, OnCloseClick)
end

function UninitWindow()
  m_goodsInfo = nil
  m_usedInConditionReward = nil
  m_usedInTaskPresent = nil
  m_usedInTaskPresentChoose = nil
end

function SetBoxId(boxId, isPreview, callback)
  if boxId then
    WU.ToggleRendering(REF.NodeContent, true)
    WU.SetActive(REF.LabelTip, m_usedInTaskPresentChoose)
    WU.SetActive(REF.LabelBoxDesc, not m_usedInTaskPresentChoose)
    if m_usedInTaskPresentChoose then
      REF.LabelBoxName.UILabel.text = WU.GetString("Window_TaskPresentChooseTitle")
      REF.LabelBoxDesc.UIHtmlLabel.text = WU.GetString("Window_TaskPresentChooseTip")
    else
      REF.LabelBoxName.UILabel.text = WU.GetString("ItemName_" .. boxId)
      REF.LabelBoxDesc.UIHtmlLabel.text = WU.GetItemDesc(boxId)
    end
    m_isPreview = isPreview
    m_callback = callback
    m_manualBox = IU.GetManualBox(boxId)
    if m_manualBox.type == PB.enum.ManualBoxType.Actor then
      m_dataList = {}
      for k, v in ipairs(m_manualBox.inBoxArray) do
        local quality = AU.CheckActorStarRandom(v.id, v.param)
        local data = {
          id = v.id,
          index = k,
          inBox = v,
          isNew = IsNew(v.id, quality),
          quality = quality
        }
        data.chosen = (m_usedInTaskPresent or m_usedInTaskPresentChoose) and v.id == this:GetData("taskPresentTargetActor")
        table.insert(m_dataList, data)
      end
      table.sort(m_dataList, function(a, b)
        if a.chosen ~= b.chosen then
          return a.chosen
        end
        if a.isNew ~= b.isNew then
          return a.isNew
        end
        local kindA = PB.get("ActorConfig", a.id).kind
        local kindB = PB.get("ActorConfig", b.id).kind
        if kindA ~= kindB then
          return kindA < kindB
        end
        return a.id < b.id
      end)
      local count = #m_dataList
      if REF.WrapContentActor.UIWrapContent.itemSize * (count - 1) + REF.WrapContentActor[0]["$UIWidget"].width <= REF.ScrollViewActor.UIPanel.finalClipRegion.z then
        REF.ScrollViewActor.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
      else
        REF.ScrollViewActor.UIScrollView.contentPivot = CS.UIWidget.Pivot.Left
      end
      LU.Set(REF.WrapContentActor, #m_dataList, true, true)
    else
      error("ManualBoxActor", "ManualBox with id " .. boxId .. " was not an actor box")
    end
    WU.ToggleRendering(REF.EffectOpen, false)
  end
end

function SetBoxIdTrueLove(boxId, callback)
  if boxId then
    m_usedInConditionReward = true
    SetBoxId(boxId, false, callback)
  end
end

function SetBoxIdTaskPresent(boxId, callback)
  if boxId then
    m_usedInTaskPresent = true
    SetBoxId(boxId, false, callback)
  end
end

function SetBoxIdTaskPresentChoose(boxId, callback)
  if boxId then
    m_usedInTaskPresentChoose = true
    SetBoxId(boxId, false, callback)
  end
end

function SetGoodsInfo(goodsInfo)
  m_goodsInfo = goodsInfo
  if m_goodsInfo then
    SetBoxId(m_goodsInfo.good.id)
  end
end

function UpdateActorSlot(slotRef, wrapIndex, rowIndex)
  if m_dataList and rowIndex and rowIndex < #m_dataList then
    slotRef["$$SetData"](m_dataList[rowIndex + 1], rowIndex)
  end
end

function IsNew(actorId, quality)
  local actors = this:GetData("fci/actor")
  local found = table.find(actors, function(k, v)
    return v.id == actorId and v.quality == quality
  end)
  return not found
end

function OnActorClick(selection)
  if not m_isPreview then
    if m_usedInTaskPresentChoose then
      this:GameRequest("fci/present-target-actor"):Post({
        presentTargetActor = selection.inBox.id
      }, function(resp)
        this:SetData("taskPresentTargetActor", selection.inBox.id)
        WU.RecycleWindow(this)
      end)
    else
      WU.AcquireWindowAsync("ManualBoxActorConfirm", function(ui)
        _ENV["$"](ui)["$$SetData"](selection.inBox.id, selection.quality, function()
          if m_goodsInfo then
            this:BroadcastGameEvent("TryToBuyGoods", m_goodsInfo, selection.index - 1, 1, function()
              WU.RecycleWindow(this)
              if m_callback then
                m_callback(true)
              end
            end)
          elseif m_usedInConditionReward then
            this:GameRequest("fci/conditionreward"):Post({
              manualBoxIndex = selection.index - 1
            }, function(result)
              ShowResChange(result.manualBoxResChange)
            end)
          else
            this:GameRequest("fci/itemuse/"):Post({
              id = m_manualBox.id,
              count = 1,
              index = selection.index - 1
            }, function(result)
              ShowResChange(result.resChange)
            end)
          end
        end, m_goodsInfo)
      end)
    end
  end
end

function ShowResChange(change)
  DBH.ResChange(change)
  WU.ShowRewards(change, function()
    WU.RecycleWindow(this)
    DB:DelayInvokeInFrames(1, function()
      if m_callback then
        m_callback(true)
      end
    end)
  end)
end

function OnCloseClick()
  WU.RecycleWindow(this)
  DB:DelayInvokeInFrames(1, function()
    if m_callback then
      m_callback(false)
    end
  end)
end
