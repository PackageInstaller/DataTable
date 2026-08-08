local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_exploreLevel, m_explorePointCount, m_eventCount, m_hollowCount, m_resMazePointCount, m_mainList, m_subList, m_gotList, m_mainCount, m_subCount, m_maxCountSub, m_maxCountMain, m_maxCountTeam, m_mazeInfo

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonTechStudy, OnClickTechStudy)
  WU.BindButtonEvent(REF.ButtonGetIn, OnGetIn)
  LU.Bind(_ENV["$"](REF.MazeOutMainRowItemMain).WrapContent, {
    updateRow = UpdateMainList
  })
  LU.Bind(_ENV["$"](REF.MazeOutMainRowItemSub).WrapContent, {
    updateRow = UpdateSubList
  })
end

function InitWindow()
  REF.NodeLabel.gameObject:SetActive(false)
  REF.NodeActors.gameObject:SetActive(false)
  this:Bind("fci/MazeId", OnSetMazeInfo)
  this:BindRemote(DB:GameRequest("fci/Maze/Research/"), OnRefreshData)
  this:Bind("fci/resource/ResMazePoint_0", OnSetResMazePoint)
  m_maxCountSub = 18
  m_maxCountMain = 18
  m_maxCountTeam = m_maxCountMain + m_maxCountSub
  this:BindRemote(DB:GameRequest("fci/Maze/Actor/"), OnRefreshActor)
end

function OnClickTechStudy()
  WU.AcquireWindowAsync("MazeTechStudy")
end

function OnRefreshData(result)
  warning("Researchresult", table.dump(result))
  if result then
    m_hollowCount = #result.unlockedHollows
    REF.LabelRelicCount.UILabel.text = m_hollowCount
    REF.LabelLevelCount.UILabel.text = result.researchLevel
    REF.NodeLabel.gameObject:SetActive(true)
  end
end

function UpdateMainList(goRef, wrapIndex, realIndex)
  if m_mainList ~= nil and realIndex ~= nil and realIndex <= #m_mainList then
    SetSlot(goRef, m_mainList[realIndex + 1])
  end
end

function UpdateSubList(goRef, wrapIndex, realIndex)
  if m_subList ~= nil and realIndex ~= nil and realIndex <= #m_subList then
    SetSlot(goRef, m_subList[realIndex + 1])
  end
end

function OnRefreshActor(result)
  m_mainList = {}
  m_subList = {}
  m_gotList = {}
  warning("result", table.dump(result))
  if result and result.selectActors then
    m_gotList = result.selectActors
    for k, v in pairs(m_gotList) do
      local actor = v.actor or v
      local kind = WU.GetKindByActorId(actor.id)
      if kind == 1 then
        table.insert(m_mainList, actor)
      elseif kind == 2 then
        table.insert(m_subList, actor)
      end
    end
    if #m_subList <= m_mazeInfo.maxActorCount then
      m_subCount = #m_subList
      for i = #m_subList + 1, m_mazeInfo.maxActorCount do
        table.insert(m_subList, {})
      end
    end
    if #m_mainList <= m_mazeInfo.maxActorCount then
      m_mainCount = #m_mainList
      for i = #m_mainList + 1, m_mazeInfo.maxActorCount do
        table.insert(m_mainList, {})
      end
    end
    local limitInfoNext = PB.get("MazeInfo", m_mazeInfo.id + 1)
    local limitActorCountNext = 0
    if limitInfoNext then
      limitActorCountNext = limitInfoNext.maxActorCount - m_mazeInfo.maxActorCount
    else
      limitActorCountNext = 0
    end
    if #m_subList <= m_mazeInfo.maxActorCount + limitActorCountNext then
      for i = #m_subList + 1, m_mazeInfo.maxActorCount + limitActorCountNext do
        table.insert(m_subList, {
          limit = true,
          limitLevel = limitInfoNext.difficulty
        })
      end
    end
    if #m_mainList <= m_mazeInfo.maxActorCount + limitActorCountNext then
      for i = #m_mainList + 1, m_mazeInfo.maxActorCount + limitActorCountNext do
        table.insert(m_mainList, {
          limit = true,
          limitLevel = limitInfoNext.difficulty
        })
      end
    end
    if #m_subList < m_maxCountSub then
      for i = #m_subList + 1, m_maxCountSub do
        table.insert(m_subList, {limit = true, lock = true})
      end
    end
    if #m_mainList < m_maxCountMain then
      for i = #m_mainList + 1, m_maxCountMain do
        table.insert(m_mainList, {limit = true, lock = true})
      end
    end
    LU.Set(_ENV["$"](REF.MazeOutMainRowItemMain).WrapContent, #m_mainList)
    LU.Set(_ENV["$"](REF.MazeOutMainRowItemSub).WrapContent, #m_subList)
    REF.LabelMainCount.UILabel.text = m_mainCount .. "/" .. m_maxCountMain
    REF.LabelSubCount.UILabel.text = m_subCount .. "/" .. m_maxCountSub
    REF.NodeActors.gameObject:SetActive(true)
  end
end

function OnGetIn()
  local pMazeId = this:GetData("fci/MazeId")
  local param = {mazeId = pMazeId, mazeFloor = 1}
  local gotListUid = this:GetData("MazeSelectActorUid")
  warning("gotListUid", table.dump(gotListUid))
  if gotListUid and not table.empty(gotListUid) then
    this:GameRequest("fci/Maze/Enter/"):Post(param, function(res)
      this:SetData("fci/MazeInfo", res.mazeInfo)
      warning("res.mazeInfo", table.dump(res.mazeInfo))
      DBH.ResChange(res.resChange)
      this:GameRequest("fci/Maze/Actor/"):Post({actorUids = gotListUid}, function(result)
        warning("result", table.dump(result))
        this:SetData("fci/Maze/Actor/", result)
        WU.RecycleWindow(this)
        WU.RecycleWindow("MazeEnter")
        WU.AcquireWindow("MazeMain")
      end)
    end)
  else
    WU.ShowHintText(WU.GetString("Tower_AtleastOneMain"))
  end
end

function SetSlot(ref, data)
  ref.NodeNextLock.gameObject:SetActive(false)
  ref.SpriteLock.gameObject:SetActive(false)
  ref.SpriteAdd.gameObject:SetActive(false)
  if data then
    if data.limit then
      if data.limitLevel then
        ref.LabelLock.UILabel.text = WU.GetString("Maze_LimitLevel", data.limitLevel)
        ref.NodeNextLock.gameObject:SetActive(true)
      elseif data.lock then
        ref.SpriteLock.gameObject:SetActive(true)
      end
      ref.Visual.gameObject:SetActive(false)
      ref["$$SetClickCallback"](function()
      end)
    else
      if table.empty(data) then
        ref.Visual.gameObject:SetActive(false)
        ref.SpriteAdd.gameObject:SetActive(true)
      else
        ref.Visual.gameObject:SetActive(data ~= nil)
        if data then
          ref["$$SetActor"](data)
        end
      end
      ref["$$SetClickCallback"](function()
        WU.AcquireWindowAsync("MazeNewTeam")
      end)
    end
  end
  ref.NodeAcSelected.gameObject:SetActive(false)
end

function OnSetResMazePoint(result)
  m_resMazePointCount = result
  REF.LabelPointCount.UILabel.text = m_resMazePointCount
end

function OnSetMazeInfo(id)
  m_mazeInfo = PB.get("MazeInfo", id)
  if m_mazeInfo then
    REF.LabelLevel.UILabel.text = "Lv." .. m_mazeInfo.difficulty
    REF.TextureBG.UITexture.mainTexturePath = "Texture/Background/ChaoticSpace_scene_" .. id
  else
    error("MazeInfo has no this id " .. id)
  end
end
