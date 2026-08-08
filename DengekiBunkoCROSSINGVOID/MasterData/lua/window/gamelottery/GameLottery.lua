local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local Vector3 = CS.UnityEngine.Vector3
local Vector2 = CS.UnityEngine.Vector2
local m_oriPos = Vector3.zero
local m_distance = 10
local m_lotteryId
local m_blessingNumber = 5
local m_onClick, m_shakeOver, m_beginShake, m_duringTime, m_justTest

function SetupWindow()
  WU.BindButtonEvent(REF.NodeCanister, OnCanisterClick)
  WU.BindButtonEvent(REF.BtnClose, function()
    WU.RecycleWindow("GameLottery")
  end)
  WU.BindButtonEvent(REF.BtnContinue, function()
    WU.RecycleWindow("GameLottery")
  end)
end

function InitWindow()
  m_lotteryId = this:GetData("Welfare/Lottery/Id")
  ResetCanister()
  UpdateUI()
end

function ResetCanister()
  m_shakeOver = false
  WU.SetActive(REF.NodePlay, true)
  WU.SetActive(REF.EffectShake, false)
  WU.SetActive(REF.NodeResult, false)
  REF.ShakeTest.transform.localPosition = m_oriPos
  m_onClick = false
end

function UpdateUI()
  local tex = WU.AcquireAsset("Texture/lucky_draw/lucky_draw_" .. m_lotteryId)
  _ENV["$"](REF.EffectCanister).Text.MeshRenderer.material:SetTexture("_MainTex", tex)
  WU.SetActive(REF.EffectCanister, true)
  REF.EffectCanister.EffectGenerator:Play()
end

function UpdateWindow(delta)
  if m_shakeOver then
    return
  end
  local pos = REF.ShakeTest.transform.localPosition
  local moveDistance = Vector3.Distance(pos, m_oriPos)
  if moveDistance > m_distance then
    if m_beginShake then
      m_duringTime = m_duringTime + delta
    else
      m_beginShake = true
      m_duringTime = 0
    end
  else
    m_beginShake = false
    m_duringTime = 0
  end
  if 2 <= m_duringTime then
    OnCanisterClick()
  end
end

function OnCanisterClick()
  if m_onClick then
    return
  end
  m_onClick = true
  m_shakeOver = true
  if m_justTest then
    TestUI()
    return
  end
  this:GameRequest("fci/lottery/" .. m_lotteryId):Post({}, function(res)
    DBH.ResChange(res.resChange)
    this:BroadcastGameEvent("EvenLotterySuccess", res.lotteryLevel)
    UpdateResultUI(res)
  end)
end

function UpdateResultUI(res)
  REF.TextureLevel.UITexture.mainTexturePath = "Texture/lucky_draw/fortune_" .. res.lotteryLevel
  local index = math.random(1, m_blessingNumber)
  REF.LabelBless.UILabel.text = WU.GetString("Lottery_Bless_" .. res.lotteryLevel .. "_" .. index)
  local rewards = res.resChange
  rewards = IU.FlatInboxItems(rewards)
  local items = _ENV["!"]({})
  local actors = _ENV["!"]({})
  local manualBoxes = _ENV["!"]({})
  for _, reward in pairs(rewards) do
    if reward.baseRes then
      if reward.baseRes.countDelta > 0 and reward.baseRes.param == PB.enum.ResourceParamType.None then
        table.insert(items, {
          type = reward.baseRes.type,
          id = reward.baseRes.id,
          count = reward.baseRes.count,
          countDelta = reward.baseRes.countDelta,
          ownerBoxId = reward.ownerBoxId
        })
      end
    elseif reward.equip then
      if 0 < reward.equip.countDelta then
        table.insert(items, {
          type = PB.enum.ResourceType.ResEquip,
          id = reward.equip.id,
          count = 1,
          ownerBoxId = reward.ownerBoxId
        })
      end
    elseif reward.actor and 0 < reward.actor.countDelta then
      table.insert(items, {
        type = PB.enum.ResourceType.ResActor,
        id = reward.actor.id,
        count = 1,
        ownerBoxId = reward.ownerBoxId,
        quality = reward.actor.quality
      })
    end
  end
  local rewardCount = #items
  for i = 0, #REF.NodeRewards - 1 do
    local ref = REF.NodeRewards[i]
    WU.SetActive(ref.root, rewardCount >= i + 1)
    if rewardCount >= i + 1 then
      local item = items[i + 1]
      if item.type == PB.enum.ResourceType.ResActor then
        ref["$$SetActorCustom"](item)
      else
        ref["$$SetData"](item.type, item.id, item.countDelta or item.count)
      end
      ref["$$SetOwnerBox"](item.ownerBoxId)
      ref["$$SetClickCallback"](function()
        WU.ShowResourceDetail(item.type, item.id)
      end)
    end
  end
  WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
  WU.SetActive(REF.NodePlay, false)
  local tex = WU.AcquireAsset("Texture/lucky_draw/lucky_draw_" .. m_lotteryId)
  _ENV["$"](REF.EffectShake).Text.MeshRenderer.material:SetTexture("_MainTex", tex)
  WU.SetActive(REF.EffectShake, true)
  REF.EffectShake.EffectGenerator:Play()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_NewYear")
  WU.SetActive(REF.NodeRewards, false)
  this:DelayInvokeInSeconds(2, function()
    WU.SetActive(REF.NodeResult, true)
    REF.NodeResult.UIPlayTween:Play(true)
  end)
  this:DelayInvokeInSeconds(2.7, function()
    WU.SetActive(REF.NodeRewards, true)
    REF.NodeRewards.UIGrid:Reposition()
    local t = REF.NodeRewards.UIPlayTween.mDelay * 2
    REF.NodeRewards.UIPlayTween:Play(true)
    for i = 0, rewardCount - 1 do
      local ii = i
      this:DelayInvokeInSeconds(t * ii, function()
        CS.SoundManager.Instance:PlaySound("Sound/system/s_System_GachaRrsult")
      end)
    end
  end)
  this:DelayInvokeInSeconds(2.8, function()
    WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
  end)
end
