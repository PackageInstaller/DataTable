local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local S = require("Common/Singleton")
local m_gachaId = 1
local m_clickCallback
local m_gachaTimes = 0
local m_effectCor
local m_curNumber = -1
local m_curTimes = -1
local m_numberSpeed = 25
local m_IsGacha = false
local m_willFreeTime
local m_modes = {
  AutumnEvent = "AutumnEvent"
}
local m_curMode, m_costBackUp, m_needShowGetPurpleCount, m_nextGetPurpleCount

function Start()
  WU.BindButtonEvent(REF.ButtonGacha, DoGacha)
  WU.BindButtonEvent(REF.ButtonGachaArm, DoGacha)
  WU.BindButtonEvent(REF.ButtonGachaCustom, OnClickButtonCustomGacha)
  WU.BindButtonEvent(REF.ButtonGachaCustomPool, OnClickButtonCustomPool)
  SetButtonFunc("ButtonAddOne", 1)
  SetButtonFunc("ButtonAddTen", 10)
  SetButtonFunc("ButtonSubtractOne", -1)
  SetButtonFunc("ButtonSubtractTen", -10)
  this:RegisterGameEvent("ResetGachaTimes", OnResetGachaTimes)
  this:RegisterGameEvent("ResetGachaStatus", OnResetGachaStatus)
  WU.BindButtonEvent(REF.ButtonBackUp, function()
    this:BroadcastGameEvent("GachaWeaponCostBackUp", nil)
  end)
end

function SetButtonFunc(name, offset)
  if REF[name] == nil then
    return
  end
  WU.BindButtonEvent(REF[name], function()
    if IsCanFreeGacha() then
      return
    end
    ChangeGachaTimes(offset)
  end)
end

function SetActivity(activity)
  if activity == nil then
    return
  end
  WU.SetActive(REF.ButtonGacha, activity.type ~= PB.enum.ActivityType.GachaCustom)
  WU.SetActive(REF.FateActorNode, activity.type == PB.enum.ActivityType.GachaCustom)
  m_nextGetPurpleCount = activity.nextGetPurpleCount
  UpdateGetPurpleCount()
  UpdateFreeState()
end

function OnGachaInfoChanged(res)
  if res == nil then
    return
  end
  for i = 1, #res do
    local info = res[i]
    if info.id == m_gachaId then
      m_willFreeTime = info.nextFreeGachaTime
      break
    end
  end
  for i, v in ipairs(res) do
    if v.id == m_gachaId and m_gachaId ~= 1 and m_gachaId ~= 2 then
      m_nextGetPurpleCount = v.nextGetPurpleCount
      break
    end
  end
  if m_needShowGetPurpleCount and m_gachaId ~= 1 and m_gachaId ~= 2 then
    UpdateGetPurpleCount()
    m_needShowGetPurpleCount = false
  end
  UpdateFreeState()
end

function UpdateGetPurpleCount()
  if m_curMode == m_modes.AutumnEvent then
    return
  end
  if m_nextGetPurpleCount ~= nil and 0 < m_nextGetPurpleCount then
    REF.LabelNextGet.gameObject:SetActive(true)
    if m_nextGetPurpleCount == 1 then
      REF.LabelNextGet.UIHtmlLabel.text = WU.GetString("WindowGacha_NextGet2")
    else
      REF.LabelNextGet.UIHtmlLabel.text = WU.GetString("WindowGacha_NextGet", m_nextGetPurpleCount)
    end
  else
    REF.LabelNextGet.gameObject:SetActive(false)
  end
end

function UpdateFreeState()
  if IsCanFreeGacha() then
    if REF.GameObjectNoFree.gameObject.activeSelf then
      WU.SetActive(REF.GameObjectNoFree, false)
      REF.ButtonAddOne.UIButton.enabled = false
      REF.ButtonAddTen.UIButton.enabled = false
      REF.ButtonSubtractOne.UIButton.enabled = false
      REF.ButtonSubtractTen.UIButton.enabled = false
    end
    if not REF.GameObjectFree.gameObject.activeSelf then
      REF.GameObjectFree.gameObject:SetActive(true)
    end
    REF.ContainerBtn.UIWidget.alpha = 0.2
    local freeGachaCount = PB.all("Misc")[1].gachaFreeDropCount or 5
    REF.LabelGacha.UIHtmlLabel.text = WU.GetString("WindowGacha_FreeTips5", freeGachaCount)
  else
    if not REF.GameObjectNoFree.gameObject.activeSelf then
      WU.SetActive(REF.GameObjectNoFree, true)
      REF.ButtonAddOne.UIButton.enabled = true
      REF.ButtonAddTen.UIButton.enabled = true
      REF.ButtonSubtractOne.UIButton.enabled = true
      REF.ButtonSubtractTen.UIButton.enabled = true
    end
    REF.ContainerBtn.UIWidget.alpha = 1
    if REF.GameObjectFree.gameObject.activeSelf then
      REF.GameObjectFree.gameObject:SetActive(false)
    end
    REF.LabelGacha.UIHtmlLabel.text = WU.GetString("WindowGacha_GachaOnce")
  end
end

function UpdateFreeTime()
  UpdateFreeState()
end

function IsCanFreeGacha()
  if m_willFreeTime and 0 < m_willFreeTime then
    return 0 >= m_willFreeTime - CS.GameTime.serverUtc
  else
    return false
  end
end

function OnEnable()
  m_needShowGetPurpleCount = true
  m_nextGetPurpleCount = nil
  this:Bind("NavigationContext", OnWindowShow)
  REF.LabelStock.ResourceChangeListener:AddListener(OnResourceChanged)
  if m_effectCor ~= nil then
    this:StopCoroutine(m_effectCor)
    m_effectCor = nil
  end
  m_effectCor = this:DelayInvokeInSeconds(0.367, function()
    REF.CoinEffect.EffectGenerator:Play()
  end)
  OnResetGachaStatus()
  REF.ButtonBackUp.gameObject:SetActive(false)
  this:RepeatInvokeInSeconds(1.0, function()
    UpdateFreeTime()
  end)
end

function OnDisable()
  this:Unbind("NavigationContext", OnWindowShow)
  REF.LabelStock.ResourceChangeListener:RemoveListener(OnResourceChanged)
  OnResetGachaTimes()
end

function Update(delta)
  if m_curTimes == m_gachaTimes then
    return
  end
  if m_curNumber > m_gachaTimes then
    m_curNumber = m_gachaTimes
    m_curTimes = m_gachaTimes
    REF.LabelGachaTimes.UILabel.text = m_gachaTimes
  else
    m_curNumber = m_curNumber + delta * m_numberSpeed
    m_curTimes = math.floor(m_curNumber)
    REF.LabelGachaTimes.UILabel.text = m_curTimes
  end
end

function OnWindowShow(name)
  if name == "GachaNormal" or name == "GachaPeriodic" then
    UpdateGetPurpleCount()
  end
end

function OnResourceChanged(type, id, count)
  RefreshGachaCost()
end

function DoGacha()
  if m_clickCallback ~= nil then
    m_IsGacha = true
    if m_gachaTimes == 0 then
      local times = 1
      if IsCanFreeGacha() then
        times = 0
      end
      ChangeGachaTimes(times)
      WU.SetLockFlag(WU.LockInputFlag.UITransition, true)
      this:DelayInvokeInSeconds(0.2, function()
        WU.SetLockFlag(WU.LockInputFlag.UITransition, false)
        m_clickCallback(m_gachaTimes)
      end)
    else
      m_clickCallback(m_gachaTimes)
    end
  end
end

function OnClickButtonCustomGacha()
  local gachainfo = DB:GetData("fci/gachainfo")
  local _, customGacha = table.find(gachainfo, function(k, v)
    return v.id == 7
  end)
  if customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_None then
    WU.ShowHintText(WU.GetString("Window_GachaCustomPoolNone"))
  elseif customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_Choose then
    WU.ShowHintText(WU.GetString("Window_GachaCustomUnselectedActivities"))
  elseif customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
    WU.ShowMessageYesNo(WU.GetString("Window_GachaCustomTip"), function(result)
      if result == "YES" then
        DoGacha()
      end
    end)
  elseif customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_Locked then
    DoGacha()
  end
end

function OnClickButtonCustomPool()
  local gachainfo = DB:GetData("fci/gachainfo")
  local _, customGacha = _ENV["!"](gachainfo):find(function(k, v)
    return v.id == 7
  end)
  if customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_None then
    WU.AcquireWindowAsync("GachaSelectFateActor")
  elseif customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_Choose then
    WU.AcquireWindowAsync("GachaSelectFateActor")
  elseif customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_Activity then
    WU.AcquireWindowAsync("GachaSelectFateActor")
  elseif customGacha.customPoolStatus == PB.enum.GachaCustomPoolStatus.GachaCustomPool_Locked then
    DB:GameRequest("fci/gacha-custom/choose-pool/"):Get(function(pool)
      WU.AcquireWindowAsync("GachaSelectFateActorMain", function(w)
        _ENV["$"](w)["$$ShowCustomPoolLocked"](pool)
      end)
    end)
  end
end

function SetGachaId(gachaId, costBackUp)
  m_gachaId = gachaId
  m_costBackUp = costBackUp
  local gachaType = PB.get("GachaType", m_gachaId)
  if m_costBackUp ~= nil then
    REF.GachaTips.UILabel.text = WU.GetString("WindowGacha_TitleTipsArm")
    REF.LabelCost.UILabel.text = WU.GetString("WindowGacha_CostBackUp")
    REF.ButtonBackUp.gameObject:SetActive(true)
    if m_costBackUp == true then
      REF.LabelStock.ResourcePrinter:SetResource(gachaType.costBackUp.type, gachaType.costBackUp.id)
    else
      REF.LabelStock.ResourcePrinter:SetResource(gachaType.cost.type, gachaType.cost.id)
    end
    REF.ButtonGachaArm.gameObject:SetActive(true)
    REF.ButtonGacha.gameObject:SetActive(false)
  else
    REF.LabelCost.UILabel.text = WU.GetString("WindowGacha_Cost")
    REF.GachaTips.UILabel.text = WU.GetString("WindowGacha_TitleTips")
    REF.ButtonBackUp.gameObject:SetActive(false)
    REF.ButtonGachaArm.gameObject:SetActive(false)
    REF.LabelStock.ResourcePrinter:SetResource(gachaType.cost.type, gachaType.cost.id)
  end
  this:Unbind("fci/gachainfo/", OnGachaInfoChanged)
  this:BindRemote(DB:GameRequest("fci/gachainfo/"), OnGachaInfoChanged)
  RefreshGachaCost()
end

function SetGachaClickCallback(clickCallback)
  m_clickCallback = clickCallback
end

function ChangeGachaTimes(times)
  OnResetGachaStatus()
  local maxGachaCountOnce = PB.all("Misc"):first().gachaMaxCountOnce
  m_gachaTimes = m_gachaTimes + times
  if m_gachaTimes < 0 then
    m_gachaTimes = 0
  elseif maxGachaCountOnce < m_gachaTimes then
    WU.ShowHintText(WU.GetString("WindowGacha_GachaMaxOnce", maxGachaCountOnce))
    m_gachaTimes = maxGachaCountOnce
  end
  RefreshGachaCost()
  REF.CoinEffect.EffectGenerator:Play()
end

function RefreshGachaCost()
  if not m_IsGacha then
    local gachaType = PB.get("GachaType", m_gachaId)
    local stockAmount = 0
    local gachaCost = {}
    if m_costBackUp == nil or m_costBackUp == false then
      gachaCost = gachaType.cost
    elseif m_costBackUp == true then
      gachaCost = gachaType.costBackUp
    end
    if gachaCost.type == PB.enum.ResourceType.ResItem then
      local costGacha = this:GetData("fci/item/" .. gachaCost.id)
      if costGacha then
        stockAmount = this:GetData("fci/item/" .. gachaCost.id).count
      else
        stockAmount = 0
      end
    else
      stockAmount = this:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[gachaCost.type] .. "_" .. gachaCost.id)
    end
    local baseAffordTimes = math.floor(math.max(0, stockAmount) / gachaCost.count)
    local extraAffordCount = 0
    if baseAffordTimes < m_gachaTimes then
      extraAffordCount = gachaType.costSub.count * (m_gachaTimes - baseAffordTimes)
    else
      baseAffordTimes = m_gachaTimes
    end
    REF.LabelTicketCost.ResourcePrinter:SetResource(gachaCost.type, gachaCost.id, baseAffordTimes)
    REF.LabelMoneyCost.ResourcePrinter:SetResource(gachaType.costSub.type, gachaType.costSub.id, extraAffordCount)
  end
end

function OnResetGachaTimes()
  m_gachaTimes = 0
  m_curNumber = m_gachaTimes
  m_curTimes = m_gachaTimes
  REF.LabelGachaTimes.UILabel.text = m_gachaTimes
  OnResetGachaStatus()
  local gachaType = PB.get("GachaType", m_gachaId)
  if gachaType then
    if m_costBackUp == nil or m_costBackUp == false then
      REF.LabelTicketCost.ResourcePrinter:SetResource(gachaType.cost.type, gachaType.cost.id, 0)
    elseif m_costBackUp == true then
      REF.LabelTicketCost.ResourcePrinter:SetResource(gachaType.costBackUp.type, gachaType.costBackUp.id, 0)
    end
    REF.LabelMoneyCost.ResourcePrinter:SetResource(gachaType.costSub.type, gachaType.costSub.id, 0)
  end
end

function OnResetGachaStatus()
  m_IsGacha = false
end
