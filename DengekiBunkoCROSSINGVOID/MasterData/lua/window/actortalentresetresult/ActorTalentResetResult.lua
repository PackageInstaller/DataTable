local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local LU = require("Common/ListUtil")
local m_actor, m_talentPos, m_resetResult, m_resultList, m_animateIndex
local m_sorted = false
local m_reordering = false
local m_emptyTalent = {talentId = 0, talentValue = 999}
local m_ignoreSelection = false

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonSort, OnSortClick)
  WU.BindButtonEvent(REF.ButtonAddChips, function()
    WU.RecordButtonClick(105033)
    WU.OpenActorDecompose({actor = m_actor})
  end)
  WU.BindButtonEvent(REF.ButtonUseGenericChip, OnUseGenericChipClick)
  LU.Bind(REF.WrapContent, {
    dataSource = function(index)
      return m_resultList and m_resultList[index]
    end,
    updateRow = UpdateTalentSlot
  })
end

function InitWindow()
  this:Bind("UseGenericChipForTalentReset", OnUseGenericChip)
  this:RegisterGameEvent("SelectTalentResetResult", OnSelectTalentResetResult)
  local scale = REF.MASK.transform.localScale
  REF.MASK.transform.localScale = CS.UnityEngine.Vector3(REF.DragArea.UIWidget.width, scale.y, 1)
end

function UninitWindow()
  m_actor = nil
  m_talentPos = nil
  m_resetResult = nil
  m_resultList = nil
end

function OnUseGenericChip(status)
  REF.SpriteCheck.gameObject:SetActive(status)
end

function SetResult(actor, result)
  m_actor = actor
  m_resetResult = result
  m_talentPos = m_resetResult.talentPos
  if m_actor then
    local talentResetCost = PB.get("TalentResetCost", m_actor.id)
    local itemInfoCost = PB.get("ItemInfo", talentResetCost.cost.id)
    REF.SpriteCost.UISprite.spriteName = itemInfoCost.icon
    REF.LabelStock.ResourcePrinter:SetResource(talentResetCost.cost.type, talentResetCost.cost.id)
    local itemInfoCostSub = PB.get("ItemInfo", talentResetCost.costSub.id)
    REF.SpriteCostSub.UISprite.spriteName = itemInfoCostSub.icon
    REF.LabelStockSub.ResourcePrinter:SetResource(talentResetCost.costSub.type, talentResetCost.costSub.id)
    m_resultList = _ENV["!"]({})
    local oldTalent = m_actor.talentInfo[m_talentPos]
    table.insert(m_resultList, {
      talentId = oldTalent.talentId,
      talentValue = oldTalent.talentValue,
      index = 0
    })
    for i, talent in ipairs(m_resetResult.talentResetInfo) do
      table.insert(m_resultList, {
        talentId = talent.talentId,
        talentValue = talent.talentValue,
        index = i
      })
    end
    m_sorted = false
    m_animateIndex = #m_resultList - 1
    UpdateTalentList()
    ShowEmptySlot()
    UpdateResetTimes()
  end
end

function ShowEmptySlot()
  if #m_resultList <= 10 then
    this:DelayInvokeInSeconds(0.2, function()
      table.insert(m_resultList, m_emptyTalent)
      UpdateTalentList(true)
    end)
  else
    m_ignoreSelection = true
    this:DelayInvokeInSeconds(1.5, function()
      m_ignoreSelection = false
    end)
  end
end

function UpdateTalentSlot(slotRef, wrapIndex, realIndex)
  if m_resultList and realIndex and realIndex < #m_resultList then
    local talent = m_resultList[realIndex + 1]
    slotRef["$$SetTalent"](talent)
    if m_animateIndex and m_animateIndex == talent.index then
      slotRef["$UIPlayTween"]:Play(true)
      m_animateIndex = nil
    end
    if m_reordering then
      local countOnRight = #m_resultList - (realIndex + 1)
      local offsetToRight = (countOnRight - 1) * REF.WrapContent.UIWrapContent.itemSize + REF.WrapContent[0]["$UIWidget"].width
      local viewCount = math.ceil(REF.ScrollView.UIPanel.finalClipRegion.z / REF.WrapContent.UIWrapContent.itemSize)
      if offsetToRight < REF.ScrollView.UIPanel.finalClipRegion.z then
        slotRef["$UIWidget"].alpha = 0
        local delayFactor = fif(viewCount > #m_resultList, realIndex + 1, viewCount - countOnRight)
        slotRef["$LuaInjector"]:DelayInvokeInSeconds(0.1 * delayFactor, function()
          slotRef["$UIWidget"].alpha = 1
          slotRef["$UIPlayTween"]:Play(true)
        end)
      end
    end
  end
end

function OnSortClick()
  WU.RecordButtonClick(105034)
  if 0 < #m_resultList and not m_sorted then
    table.sort(m_resultList, function(a, b)
      return a.talentValue < b.talentValue
    end)
    m_reordering = true
    UpdateTalentList()
    m_reordering = false
    m_sorted = true
  end
end

function RequestReset()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_TalentReset")
  this:GameRequest("fci/talent/reset/"):Post({
    actorUid = m_actor.uid,
    talentPos = m_talentPos
  }, OnResetResponse)
end

function OnResetResponse(result)
  m_resetResult = result
  local newTalent = m_resetResult.talentResetInfo[#m_resetResult.talentResetInfo]
  local newTalentInfo = AU.GetTalentDisplayInfo(newTalent.talentId, newTalent.talentValue)
  local intervals = PB.all("TalentMisc")[1].interval
  local gradeCount = #intervals
  if 1 < gradeCount and intervals[gradeCount - 1].val < newTalentInfo.score and newTalentInfo.score <= intervals[gradeCount].val then
    CS.GameUtility.Vibrate()
  end
  table.remove(m_resultList, #m_resultList)
  table.insert(m_resultList, {
    talentId = newTalent.talentId,
    talentValue = newTalent.talentValue,
    index = #m_resultList
  })
  m_sorted = false
  m_animateIndex = #m_resultList - 1
  UpdateTalentList()
  ShowEmptySlot()
  UpdateResetTimes()
  DBH.ResChange(m_resetResult.resChange)
end

function UpdateTalentList(slidIn)
  local wasCenterAligned = REF.ScrollView.UIScrollView.contentPivot == CS.UIWidget.Pivot.Center
  local resultCount = #m_resultList
  local extendWidth = REF.BoundExtend.UIWidget.width - REF.WrapContent[0]["$UIWidget"].width / 2
  if REF.WrapContent.UIWrapContent.itemSize * resultCount - (REF.WrapContent.UIWrapContent.itemSize - REF.WrapContent[0]["$UIWidget"].width) + extendWidth <= REF.ScrollView.UIPanel.finalClipRegion.z then
    REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
  else
    REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Right
  end
  LU.Set(REF.WrapContent, resultCount, true, true)
  if REF.ScrollView.UIScrollView.contentPivot == CS.UIWidget.Pivot.Right then
    REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(-resultCount * REF.WrapContent.UIWrapContent.itemSize + REF.ScrollView.UIPanel.finalClipRegion.z / 2 + REF.WrapContent.UIWrapContent.itemSize / 2, 0, 0))
  end
  REF.ScrollView.UIScrollView:ResetPosition()
  if slidIn then
    local offsetX = REF.WrapContent.UIWrapContent.itemSize
    if wasCenterAligned then
      offsetX = offsetX / 2
    end
    REF.ScrollView.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(offsetX, 0, 0))
    REF.ScrollView.UIScrollView:SpringRelative(CS.UnityEngine.Vector3(-offsetX, 0, 0), 20)
  end
end

function UpdateResetTimes()
  REF.LabelTimes.UILabel.text = tostring(#m_resultList - 1)
  REF.LabelMaxTimes.UILabel.text = tostring(PB.all("Misc"):first().maxResetTalentCount)
end

function OnSelectTalentResetResult(index)
  if not m_ignoreSelection then
    if index then
      WU.RecordButtonClick(105036)
      WU.AcquireWindowAsync("ActorTalentResetConfirm", function(window)
        local newTalent
        if 0 < index then
          newTalent = m_resetResult.talentResetInfo[index]
        end
        local oldTalent = m_actor.talentInfo[m_talentPos]
        _ENV["$"](window)["$$SetTalents"](oldTalent, newTalent, function()
          local param = {
            actorUid = m_actor.uid,
            select = 0 < index
          }
          if 0 < index then
            param.selectTalentPos = index
          end
          this:GameRequest("fci/talent/select/"):Post(param, function(result)
            DBH.UpdateActors(result.actor)
            this:BroadcastGameEvent("EventConfirmSelection")
            WU.RecycleWindow(this)
            if result.upgradeTalentInfo then
              WU.AcquireWindowAsync("ActorQualityUp", function(ui)
                _ENV["$"](ui)["$$SetData"](result.actor)
              end)
            end
          end)
        end)
      end)
    else
      WU.RecordButtonClick(105035)
      AU.TryResetTalent(m_actor, m_talentPos, RequestReset)
    end
  end
end

function OnUseGenericChipClick()
  local toogle = this:GetData("UseGenericChipForTalentReset")
  if not toogle then
    WU.RecordButtonClick(105032)
  end
  this:SetData("UseGenericChipForTalentReset", not this:GetData("UseGenericChipForTalentReset"))
end

function Focus()
  WU.RecordWindowFocus(100105, true)
end
