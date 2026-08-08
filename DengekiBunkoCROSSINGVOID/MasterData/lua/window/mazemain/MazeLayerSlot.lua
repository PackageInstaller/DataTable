local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local CO = require("Common/Coroutine")
local m_buffRowList, m_curIndex, m_isEnd, m_cellData, m_mazeId, m_playTween, m_preCell, m_mazeActivityId
local m_delayShow = 0.8
local effectStartSound = "Sound/system/s_System_MazeOccur"
local m_mazeResourceId

function Start()
  WU.BindButtonEvent(REF.SpriteSlot, onClick)
end

function onClick()
  local data = m_cellData.data
  if data == nil then
    return
  end
  if m_preCell == nil and not m_cellData.isStart then
    return
  end
  if IsAllActorDead() then
    WU.ShowHintText(WU.GetString("LocalMaze_Tips26"))
    return
  end
  local mazeInfo = this:GetData("fci/MazeInfo/")
  if mazeInfo == nil then
    return
  elseif mazeInfo.isMazeOver == true then
    WU.ShowHintText(WU.GetString("LocalMaze_Tips21"))
    return
  end
  local param = {}
  local playerIndex = this:GetData("MazePlayerIndex")
  param.startCellIndex = playerIndex
  param.endCellIndex = m_cellData.index
  if playerIndex == m_cellData.index then
    return
  end
  this:GameRequest("fci/Maze/Move/" .. m_mazeActivityId .. "/"):Post(param, function(res)
    this:BroadcastGameEvent("MazeMove", res)
  end)
end

function IsAllActorDead()
  return AU.MazeActorAllDead()
end

function Awake()
end

function UpdateData(cellData)
  m_playTween = false
  if cellData == nil then
    return
  end
  m_cellData = cellData
  local data = cellData.data
  REF.SpriteSlot.gameObject:SetActive(false)
  if data ~= nil then
    m_preCell = this:GetData("MazeCellData" .. data.preCellIndex)
    local playerIndex = this:GetData("MazePlayerIndex")
    if cellData.index == playerIndex or cellData.isStart or data.preCellIndex ~= 0 and data.invisible == true and m_preCell and m_preCell.data and m_preCell.data.isPassed == true or data.invisible == false then
      local hasPlayTween = this:GetData("MazeCellHasPlayTween" .. m_cellData.index)
      if hasPlayTween == false then
        m_playTween = true
        this:SetData("MazeCellDataPlayTween" .. m_cellData.index, nil)
        this:SetData("MazeCellHasPlayTween" .. m_cellData.index, true)
        local flag = this:GetData("MazeCellLineHasPlayTween" .. m_cellData.index)
        if flag ~= true then
          this:SetData("MazeCellLineHasPlayTween" .. m_cellData.index, false)
        end
      end
      REF.SpriteSlot.gameObject:SetActive(true)
      REF.SpriteSlot.UISprite.spriteName = "road_0" .. m_mazeResourceId .. "_1"
    end
    
    local function fucSetSlot(slotName, y)
      local changeFlag = true
      local name = ""
      REF.EffectFlag.gameObject:SetActive(true)
      if m_playTween == true then
        name = slotName
        REF.EffectFlag.gameObject:SetActive(false)
        this:DelayInvokeInSeconds(0.8, function()
          CS.SoundManager.Instance:PlaySound(effectStartSound)
          REF.EffectFlag.gameObject:SetActive(true)
        end)
      else
        name = slotName .. "_loop"
        REF.EffectFlag.gameObject:SetActive(true)
      end
      changeFlag = REF.EffectFlag.EffectGenerator.m_EffectName ~= name
      REF.EffectFlag.EffectGenerator.m_EffectName = name
      if changeFlag then
        REF.EffectFlag.EffectGenerator:Reset()
      end
      if y then
        REF.EffectFlag.transform.localPosition = CS.UnityEngine.Vector3(0, y, 0)
      else
        REF.EffectFlag.transform.localPosition = CS.UnityEngine.Vector3.zero
      end
    end
    
    local function fucSetEventSlot()
      if data.eventType == PB.enum.MazeEventType.MazeEvent_Story then
        local storyId = data.eventProgress
        if storyId ~= 0 then
          local storyInfo = PB.get("MazeEventStoryInfo", storyId)
          if storyInfo and storyInfo.effectIcon and storyInfo.effectIcon ~= "" then
            fucSetSlot(storyInfo.effectIcon, 30)
          else
            fucSetSlot("UI_Maze_question_icon", 30)
          end
        else
          fucSetSlot("UI_Maze_question_icon", 30)
        end
      elseif data.eventType == PB.enum.MazeEventType.MazeEvent_Fight then
        fucSetSlot("UI_Maze_fight_icon", 30)
      elseif data.eventType == PB.enum.MazeEventType.MazeEvent_Treasure then
        fucSetSlot("UI_Maze_treasure_icon", 30)
      elseif data.eventType == PB.enum.MazeEventType.MazeEvent_Boss then
        fucSetSlot("UI_Maze_boss_icon", 30)
      elseif data.eventType == PB.enum.MazeEventType.MazeEvent_Camp then
        fucSetSlot("UI_Maze_camp_icon", 60)
      elseif data.eventType == PB.enum.MazeEventType.MazeEvent_Shop then
        fucSetSlot("UI_Maze_store_icon", 30)
      elseif cellData.isEnd == true then
        local info = PB.get("MazeInfo", m_mazeId)
        local mazeInfo = this:GetData("fci/MazeInfo/")
        if mazeInfo == nil then
          return
        end
        local isLastFloor = false
        if info then
          isLastFloor = mazeInfo.curMazeFloor >= info.maxFloor
        end
        fucSetSlot(fif(isLastFloor, "UI_Maze_exit_02", "UI_Maze_exit_01"), 30)
      else
        REF.EffectFlag.gameObject:SetActive(false)
      end
    end
    
    if m_preCell and m_preCell.data and data.invisible == true and m_preCell.data.isPassed == false or data.isComplete == true and cellData.isEnd ~= true or cellData.index == playerIndex then
      if this:GetData("Maze/Moving") == false then
        REF.EffectFlag.gameObject:SetActive(false)
      end
    else
      fucSetEventSlot()
    end
    local isTweeon = this:GetData("MazeFirstTweenOn")
    if m_playTween then
      do
        local function call()
          REF.SpriteSlot.TweenAlpha:ResetToBeginning()
          
          REF.SpriteSlot.TweenPosition:ResetToBeginning()
          REF.SpriteSlot.TweenAlpha:PlayForward()
          REF.SpriteSlot.TweenPosition:PlayForward()
        end
        
        if isTweeon then
          REF.SpriteSlot.gameObject:SetActive(false)
          this:DelayInvokeInSeconds(m_delayShow, function()
            REF.SpriteSlot.gameObject:SetActive(true)
            call()
          end)
        else
          call()
        end
      end
    end
  end
  SetRoadStatus(cellData)
end

function SetData(cellData)
  m_mazeActivityId = this:GetData("MazeActivityId")
  if cellData == nil then
    return
  end
  m_mazeId = this:GetData("fci/MazeId/" .. m_mazeActivityId .. "/")
  m_mazeResourceId = this:GetData("fci/MazeInfo/").mazeResourceId
  UpdateData(cellData)
end

function _SetRoadShow(i, b, index)
  local refRoad, ref
  if i == 1 or i == 2 then
    refRoad = _ENV["$"](REF.Road1)
    ref = REF.Road1
  else
    refRoad = _ENV["$"](REF.Road2)
    ref = REF.Road2
  end
  local spLine = refRoad[string.format("SpriteLine%d", i)]
  if i == 1 or i == 3 then
    spLine.UISprite.spriteName = "road_0" .. m_mazeResourceId .. "_3"
  else
    spLine.UISprite.spriteName = "road_0" .. m_mazeResourceId .. "_2"
  end
  REF.Road1.gameObject:SetActive(true)
  REF.Road2.gameObject:SetActive(true)
  spLine.gameObject:SetActive(b)
  if index and b then
    local flag = this:GetData("MazeCellLineHasPlayTween" .. index)
    local isTweeon = this:GetData("MazeFirstTweenOn")
    if flag == false then
      this:SetData("MazeCellLineHasPlayTween" .. index, true)
      
      local function call()
        REF.Road1.TweenAlpha:ResetToBeginning()
        REF.Road1.TweenPosition:ResetToBeginning()
        REF.Road2.TweenAlpha:ResetToBeginning()
        REF.Road2.TweenPosition:ResetToBeginning()
        REF.Road1.TweenAlpha:PlayForward()
        REF.Road1.TweenPosition:PlayForward()
        REF.Road2.TweenAlpha:PlayForward()
        REF.Road2.TweenPosition:PlayForward()
      end
      
      if isTweeon then
        REF.Road1.gameObject:SetActive(false)
        REF.Road2.gameObject:SetActive(false)
        this:DelayInvokeInSeconds(m_delayShow, function()
          REF.Road1.gameObject:SetActive(true)
          REF.Road2.gameObject:SetActive(true)
          call()
        end)
      else
        call()
      end
    end
  end
end

function SetRoadStatus(cellSlotData)
  for i = 1, 4 do
    _SetRoadShow(i, false)
  end
  local data = cellSlotData.data
  if data and (data.invisible == false or data.invisible == true and m_preCell and m_preCell.data and m_preCell.data.isPassed == true) then
    for i, v in pairs(cellSlotData.nextCell) do
      local nextCellData = this:GetData("MazeCellData" .. v.index)
      if nextCellData.data.invisible == false or nextCellData.data.invisible == true and data.isPassed == true then
        if v.index > cellSlotData.index then
          if v.index == cellSlotData.index + 1 then
            _SetRoadShow(3, true, v.index)
          else
            _SetRoadShow(4, true, v.index)
          end
        elseif v.index == cellSlotData.index - 1 then
          _SetRoadShow(1, true, v.index)
        else
          _SetRoadShow(2, true, v.index)
        end
      end
    end
  end
end
