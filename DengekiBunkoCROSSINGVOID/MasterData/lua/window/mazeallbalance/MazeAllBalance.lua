local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local IU = require("Common/ItemUtil")
local m_mazeList = PB.all("MazeInfo")
local m_rewards = {}
local m_mazeActivityId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    this:GameRequest("fci/Maze/Summary/" .. m_mazeActivityId .. "/"):Get(function(res)
      this:SetData("mazePassedIds", res.mazePassed)
      this:SetData("fci/MazeInfo/", res.mazeInfo)
      if res.mazeId == 0 then
        this:SetData("fci/MazeId/" .. m_mazeActivityId .. "/", res.mazeId)
        WU.AcquireWindowAsync("MazeEnter", function()
          WU.RecycleWindow(this)
        end)
      end
    end)
  end)
  LU.Bind(REF.WrapContent, {
    dataSource = function(dataIndex)
      return m_rewards and m_rewards[dataIndex]
    end,
    updateSlot = OnRewardItemShow
  })
end

function InitWindow()
  WU.SetGameDataCache("Maze/BalanceAllB4" .. DB:GetData("playerId"), true)
  WU.ActiveByNeverClick(REF.MazeEvaluationTip)
  m_mazeActivityId = this:GetData("MazeActivityId")
  REF.BGSpe.transform.localScale = CS.UnityEngine.Vector3(-REF.BGSpe.transform.localScale.x, REF.BGSpe.transform.localScale.y, REF.BGSpe.transform.localScale.z)
  REF.city.gameObject:SetActive(false)
  REF.city2.gameObject:SetActive(false)
  REF.lines.gameObject:SetActive(false)
end

function UninitWindow()
  WU.SetClickB4(REF.MazeEvaluationTip)
end

function SetData(data)
  SetLabels(data)
  InitAcquirement(data)
  local len = #REF.WrapContent
  for i = 1, len do
    local refItem = REF.WrapContent[i - 1]
    refItem["$"].UIGrid:Reposition()
  end
end

function InitAcquirement(balance)
  m_rewards = GetDungeonBalanceRewardShow(balance)
  if m_rewards ~= nil then
    local row = #REF.WrapContent[0]["$"]
    LU.Set(REF.WrapContent, math.ceil(#m_rewards / row))
  end
end

function OnRewardItemShow(ref, reward)
  if reward ~= nil then
    if reward.baseRes then
      ref["$$SetData"](reward.baseRes.type, reward.baseRes.id, reward.baseRes.countDelta or reward.baseRes.count)
      ref["$$SetClickCallback"](function()
        WU.ShowResourceDetail(reward.baseRes.type, reward.baseRes.id)
      end)
      if reward.multiple and reward.multiple ~= 0 then
        ref["$$ShowCustom"]({dropUp = true})
      end
      if reward.isExpReturn and reward.isExpReturn == 1 then
        ref["$$ShowExpReturn"](true)
      end
    elseif reward.actor then
      ref["$$SetActor"](reward.actor)
    elseif reward.equip then
      ref["$$SetEquip"](reward.equip)
      ref["$$SetClickCallback"](function()
        WU.ShowEquipDetailByUid(reward.equip.uid, {
          enhance = false,
          equipped = false,
          share = false
        })
      end)
    end
    local additions = ref.Visual.transform:Find("Additions")
    WU.SetActive(additions, reward.showAdditions)
    if additions == nil and reward.showAdditions then
      AddAdditions(ref)
    end
    ref["$$SetOwnerBox"](reward.ownerBoxId)
  else
    ref["$$ClearSlot"]()
  end
end

function AddAdditions(ref)
  local additions = CS.UnityEngine.GameObject.Instantiate(ref.ButtonRemove.gameObject, ref.Visual.transform)
  additions.transform.localPosition = CS.UnityEngine.Vector3(-3, 143, 0)
  additions.name = "Additions"
  local uisprite = _ENV["$"](additions)["$UISprite"]
  uisprite.atlasPath = "CommonWindow"
  uisprite.spriteName = "actor_tips"
  uisprite:SnapWithoutScale()
  additions.gameObject:SetActive(true)
  local labelObj = CS.UnityEngine.GameObject.Instantiate(ref.CountLabel.gameObject, additions.transform)
  local label = labelObj.transform:GetComponent(typeof(CS.UILabel))
  label.fontSize = 38
  label.text = WU.GetString("Window_SemiFixedAdditionsBalance")
  label.color = CS.NGUIMath.HexToColor(2945268223)
  label.depth = uisprite.depth + 1
  labelObj.transform.localPosition = CS.UnityEngine.Vector3(0, 12, 0)
  labelObj.gameObject:SetActive(true)
end

function SetLabels(data)
  REF.LabelPointCount.UILabel.text = math.floor(data.totalScore)
  REF.LabelFloorCount.UILabel.text = data.floorCount or 0
  REF.LabelEventCount.UILabel.text = data.eventCount or 0
end

function GetDungeonBalanceRewardShow(balance)
  local result = {}
  local expOverFlow = {}
  if not balance or not balance.resShowed and not balance.expReturn then
    return _ENV["!"]({})
  else
    if balance and balance.resShowed then
      result = IU.FlatInboxItems(balance.resShowed):where(function(_, change)
        local target = change.baseRes or change.equip or change.actor
        return target and target.countDelta > 0 and (not target.baseRes or target.baseRes.type ~= PB.enum.ResourceType.ResPlayerExp)
      end):toarray()
    end
    if balance and balance.expReturn then
      expOverFlow = IU.FlatInboxItems(balance.expReturn):where(function(_, change)
        local target = change.baseRes
        return target and target.countDelta > 0 and (not target.baseRes or target.baseRes.type ~= PB.enum.ResourceType.ResPlayerExp)
      end):toarray()
      for i, v in pairs(expOverFlow) do
        v.isExpReturn = 1
        table.insert(result, v)
      end
    end
    return result
  end
end
