local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local NU = require("Common/NotepadUtil")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local DBH = require("Manager/DataBindingHandler")
local BASE = inherit("Window/DungeonBalance/DungeonBalanceBase", _ENV)
local m_balance, m_closeAll, m_effectEnd, m_mazeActivityId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonNextWin, function()
    UpdateMazeInfoAfterBalance(m_balance)
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonNextLose, function()
    UpdateMazeInfoAfterBalance(m_balance)
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonNextAllLose, function()
    if m_closeAll then
      m_closeAll()
    end
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.Mask, function()
    m_effectEnd = true
    REF.Mask.gameObject:SetActive(false)
    InitBalance()
  end)
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  ResetWindow()
  REF.Mask.gameObject:SetActive(true)
  m_effectEnd = false
end

function SetData(data)
  if data then
    REF.Effect.gameObject:SetActive(true)
    REF.Effect.EffectGenerator:Reset()
    REF.Effect.EffectGenerator:Play()
    m_balance = data
    this:DelayInvokeInSeconds(4, function()
      if m_effectEnd == false then
        REF.Mask.gameObject:SetActive(false)
        InitBalance()
      end
    end)
  end
end

function SetAllLose(callBack)
  REF.Mask.gameObject:SetActive(false)
  REF.NodeAllLose.gameObject:SetActive(true)
  REF["$Animator"]:Play("Open", -1, 0)
  m_closeAll = callBack
end

function ResetWindow()
  REF.NodeWin.gameObject:SetActive(false)
  REF.NodeLose.gameObject:SetActive(false)
  REF.NodeAllLose.gameObject:SetActive(false)
end

function OnActorGroupConfirm(result)
  if result == nil then
    return
  end
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
  if m_balance and m_balance.result.win then
    REF.WidgetDungeonGroupWin["$SetView"](m_groups)
    REF.WidgetDungeonGroupWin["$SetHp"](m_groups)
  elseif m_balance and m_balance.result.win == false then
    REF.WidgetDungeonGroupLose["$SetView"](m_groups)
    REF.WidgetDungeonGroupLose["$SetHp"](m_groups)
  end
end

function UpdateMazeInfoAfterBalance(balance)
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

function InitBalance()
  REF.Effect.gameObject:SetActive(false)
  BASE.InitAcquirement(m_balance.result)
  NU.UpdateRoleFavour(m_balance.result.favourChange)
  if #BASE.m_rewards < 6 then
    REF.AcquirementScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
    REF.AcquirementScrollView.UIScrollView:ResetPosition()
  end
  DB:GameRequest("fci/Maze/Actor/" .. m_mazeActivityId .. "/"):Get(function(res)
    AU.OnGetMazeActorPool(res)
    DB:GameRequest("fci/Maze/FightActorGroup/" .. m_mazeActivityId .. "/"):Get(function(result)
      this:SetData("fci/Maze/FightActorGroup/", result)
      OnActorGroupConfirm(result)
      if m_balance.result.win then
        REF.NodeWin.gameObject:SetActive(true)
        REF["$Animator"]:Play("Open", -1, 0)
      else
        REF.NodeLose.gameObject:SetActive(true)
        REF["$Animator"]:Play("Open", -1, 0)
      end
    end)
  end)
end
