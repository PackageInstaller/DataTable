local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local m_currInvitee, m_iniviteIndexs, m_cost, m_effectOn

function SetupWindow()
  WU.BindButtonEvent(REF.BtnInvite, OnInviteClick)
  WU.BindButtonEvent(REF.BtnChangeBlessing, OnBtnChangeInviteInfo)
end

function InitWindow()
  _ENV["$"](REF.ButtonClose)["$$SetCallback"](OnCloseClick)
  ResetUI()
  m_currInvitee = this:GetData("ChristmasParty/CurrentInvitee")
  this:Bind("fci/baseinfo/", OnPlayerInfoChange)
  OnBtnChangeInviteInfo()
end

function ResetUI()
  m_effectOn = false
  REF.EnvBack.gameObject:SetActive(false)
  REF.EnvFront.gameObject:SetActive(false)
  REF.POSTCARD.gameObject:SetActive(true)
  REF.NodePlayTween.UIPlayTween.tweenGroup = 11
  REF.NodePlayTween.UIPlayTween:ResetToBeginning()
  REF.NodePlayTween.UIPlayTween.tweenGroup = 13
  REF.NodePlayTween.UIPlayTween:ResetToBeginning()
  REF.POSTCARD.UIPlayTween:ResetToBeginning()
end

function OnBtnChangeInviteInfo()
  if m_effectOn then
    return
  end
  local inviteInfo = GetInvitation()
  REF.LabelTitle.UILabel.text = inviteInfo.call
  REF.LabelContent.UIHtmlLabel.text = inviteInfo.content
  m_effectOn = true
  REF.NodePlayTween.UIPlayTween.tweenGroup = 11
  REF.NodePlayTween.UIPlayTween:Play(true)
  this:DelayInvokeInSeconds(0.76, function()
    m_effectOn = false
  end)
end

function GetInvitation()
  local inviteCount = m_currInvitee.config.inviteCount
  if inviteCount == nil or inviteCount == 0 then
    warning("Actor invite info lack in ActivityInviteActorInfo.xlsx")
    return
  end
  if m_iniviteIndexs == nil or #m_iniviteIndexs == 0 then
    local temp = _ENV["!"]({})
    m_iniviteIndexs = _ENV["!"]({})
    for i = 1, inviteCount do
      table.insert(temp, i)
    end
    for i = 1, inviteCount do
      local t = math.random(1, inviteCount - i + 1)
      table.insert(m_iniviteIndexs, temp[t])
      table.remove(temp, t)
    end
  end
  local index = m_iniviteIndexs[1]
  local inviteInfo = {}
  inviteInfo.call = WU.GetString("ChristmasInviteCall_" .. m_currInvitee.config.roleId .. "_" .. index)
  inviteInfo.content = WU.GetString("ChristmasInviteContent_" .. m_currInvitee.config.roleId .. "_" .. index)
  table.remove(m_iniviteIndexs, 1)
  return inviteInfo
end

function OnPlayerInfoChange(baseInfo)
  if baseInfo then
    AU.SetPlayerName(REF.LabelName, this:GetData("accountCache"), baseInfo)
  end
end

function OnInviteClick()
  if m_effectOn then
    return
  end
  local path = "fci/activity-shop-goods/"
  this:GameRequest(path):Post({
    goodsId = m_currInvitee.config.goodId,
    buyCount = 1
  }, function(res)
    if res == nil then
      warning("Failed to invite the actor ??????????")
      return
    end
    DBH.ResChange(res.resChange)
    local inviteRecords = this:GetData("fci/activity-shop-goods/buy-record")
    if inviteRecords == nil then
      inviteRecords = {
        buyRecord = {
          [1] = {
            id = m_currInvitee.config.goodId,
            buyCount = 1
          }
        }
      }
    else
      local k, v = table.find(inviteRecords.buyRecord, function(k1, v1)
        return v1.id == m_currInvitee.config.goodId
      end)
      if v then
        v.buyCount = v.buyCount + 1
      else
        table.insert(inviteRecords.buyRecord, {
          id = m_currInvitee.config.goodId,
          buyCount = 1
        })
      end
    end
    this:SetData("fci/activity-shop-goods/buy-record", inviteRecords)
    this:SetData("ChristmasParty/ResultMode", 1)
    m_currInvitee.hasInvited = true
    this:SetData("ChristmasParty/CurrentInvitee", m_currInvitee)
    ShowInviteResultEffect()
  end)
end

function OnCloseClick()
  if m_effectOn then
    return
  end
  WU.RecycleWindow("ChristmasPartyInviteDetail")
end

function ShowInviteResultEffect()
  m_effectOn = true
  REF.EnvBack.gameObject:SetActive(true)
  REF.EnvFront.gameObject:SetActive(true)
  REF.NodePlayTween.UIPlayTween.tweenGroup = 13
  REF.NodePlayTween.UIPlayTween:Play(true)
  WU.PreloadWindow("ChristmasPartyInviteResult")
  this:DelayInvokeInSeconds(0.5, function()
    REF.POSTCARD.gameObject:SetActive(false)
  end)
  this:DelayInvokeInSeconds(0.85, function()
    WU.AcquireWindowAsync("ChristmasPartyInviteResult")
    m_effectOn = false
  end)
end
