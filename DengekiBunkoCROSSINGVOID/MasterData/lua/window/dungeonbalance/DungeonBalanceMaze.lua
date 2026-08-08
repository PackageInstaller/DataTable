local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local NU = require("Common/NotepadUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local SDU = require("Common/SoundUtil")
local m_balance, m_rewards, m_skipAnim, m_summary, m_groups
local m_isMaxFloor = true
local m_mazeActivityId
local m_startCountdown = false
local m_time = 10

function SetupWindow()
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.BottomButtons, false)
  WU.BindButtonEvent(REF.AnimMask, OnSkipAnimClick)
  REF.WidgetDungeonGroup.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.ButtonFight, function()
    if m_balance.dropHollows and not table.empty(m_balance.dropHollows) then
      WU.AcquireWindowAsync("MazeRelicSelect", function(window)
        _ENV["$"](window)["$$SetData"](m_balance.dropHollows)
        _ENV["$"](window)["$$SetClickCallBack"](function()
          BASE.OnButtonContinueClick()
        end)
      end)
    else
      BASE.OnButtonContinueClick()
    end
  end)
end

function UpdateMazeInfo(balance)
  local mazeInfo = this:GetData("fci/MazeInfo/")
  if mazeInfo then
    mazeInfo = balance.autoMove.mazeInfo
    this:SetData("fci/MazeInfo/", mazeInfo)
    this:SetData("MazePlayerIndex", mazeInfo.playerCellIndex)
  end
  local mazeCellIndex = this:GetData("MazeSelectIndex")
  local mazeCell
  if mazeCellIndex and mazeCell == nil then
    this:GameRequest("fci/Maze/Summary/" .. m_mazeActivityId .. "/"):Get(function(res)
      this:SetData("fci/MazeInfo/", res.mazeInfo)
    end)
  end
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  REF.LabelDesc.UILabel.text = WU.GetString("DungeonBalanceDescribe_" .. dungeonId)
  m_balance = this:GetData("DungeonBalance/result")
  m_rewards = DU.GetDungeonBalanceRewards(m_balance.result)
  DBH.ResChange(m_balance.result.resChange)
  WU.ToggleRendering(REF.TitleLine1, false)
  WU.ToggleRendering(REF.AcquirementList, false)
  WU.ToggleRendering(REF.WidgetProfitBuffList, false)
  DB:GameRequest("fci/Maze/Actor/" .. m_mazeActivityId .. "/"):Get(function(res)
    AU.OnGetMazeActorPool(res)
    DB:GameRequest("fci/Maze/FightActorGroup/" .. m_mazeActivityId .. "/"):Get(function(result)
      OnActorGroupConfirm(result)
    end)
  end)
  BASE.InitAcquirement(m_balance.result)
  NU.UpdateRoleFavour(m_balance.result.favourChange)
  WU.ToggleRendering(REF.AnimMask, true)
  PlayAnim()
  if #BASE.m_rewards < 7 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.TopRight
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
  BASE.SetActorTextureEffect(this:GetData("FightWinActor"))
end

function OnActorGroupConfirm(result)
  if result == nil then
    return
  end
  WU.ToggleRendering(REF.WidgetDungeonGroup, true)
  REF.WidgetDungeonGroup.gameObject:SetActive(true)
  m_groups = result.fightGroup[1]
  for i, v in ipairs(m_groups.members) do
    local actorWrap
    if v.actorUid and v.actorUid > 0 then
      actorWrap = this:GetData("fci/mazeactor/" .. v.actorUid)
    end
    if actorWrap then
      v.hp = actorWrap.hp
      v.actor = actorWrap.actor
    end
  end
  REF.WidgetDungeonGroup["$SetView"](m_groups)
  REF.WidgetDungeonGroup["$SetHp"](m_groups)
end

function OnSkipAnimClick()
  m_skipAnim = true
  WU.ToggleRendering(REF.AnimMask, false)
  WU.ToggleRendering(REF.TitleLine1, true)
  BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Left)
  WU.ToggleRendering(REF.AcquirementList, true)
  if 0 < #m_rewards then
    REF.AcquirementContent.UIPlayTween:Play(true)
    REF.AcquirementContent.UIPlayTween:Finish()
  end
  OnAnimFinished()
end

function PlayAnim()
  this:DelayInvokeInSeconds(0.5, function()
    if m_skipAnim then
      return
    end
    WU.ToggleRendering(REF.TitleLine1, true)
    REF.TitleLine1.UIPlayTween:Play(true)
    BASE.SetProfitBuff(m_balance.profits, CS.UIWidget.Pivot.Left)
    this:DelayInvokeInSeconds(BASE.TitleAnimTime, function()
      if m_skipAnim then
        return
      end
      WU.ToggleRendering(REF.AcquirementList, true)
      REF.AcquirementContent.UIPlayTween:Play(true)
      this:DelayInvokeInSeconds(#m_rewards * BASE.RewardAnimTime, function()
        if m_skipAnim then
          return
        end
        this:DelayInvokeInSeconds(0.5, function()
          if m_skipAnim then
            return
          end
          OnAnimFinished()
        end)
      end)
    end)
  end)
end

function OnAnimFinished()
  WU.ToggleRendering(REF.AnimMask, false)
  m_startCountdown = true
  WU.ToggleRendering(REF.BottomButtons, true)
  if #m_rewards > #REF.AcquirementContent - 2 then
    REF.AcquirementList.BoxCollider2D.enabled = true
    WU.TraverseChildren(REF.AcquirementContent, function(go)
      go:GetComponentInChildren(typeof(CS.UIDragScrollView)).enabled = true
    end)
  end
  BASE.OnDungeonAnimFinished()
  UpdateMazeInfo(m_balance)
end

function OnDestroy()
  BASE.OnDestroy()
end
