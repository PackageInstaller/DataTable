inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local DBH = require("Manager/DataBindingHandler")
local RU = require("Common/RedMarkUtil")
local LU = require("Common/ListUtil")
local m_requestList, m_currentRequest
local m_donateLeftCount = 0
local m_receivedDonations = {}
local m_donateRes
local m_windowsOnTop = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonRequestSupport, OnRequestSupportClick)
  WU.BindButtonEvent(REF.ButtonSend, OnSendClick)
  WU.BindButtonEvent(REF.ButtonIntimate, OnIntimateClick)
  WU.SetRuleCallback("GuildSupport", function()
    WU.AcquireWindowAsync("RuleCommon", function(ui)
      _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_GuildSupport"))
    end)
    m_windowsOnTop.RuleCommon = true
  end)
  LU.Bind(REF.WrapContentSupportList, {
    updateRow = UpdateSupportRow
  })
  LU.Bind(REF.WrapContentDonateList, {
    updateRow = UpdateDonateRow
  })
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  m_currentRequest = nil
  REF.WrapContentSupportList.UICenterOnChild.onCenter = OnCenter
  REF.GuildSupportList.gameObject:SetActive(false)
  REF.NodeBottom.gameObject:SetActive(false)
  REF.NodeDonateSend.gameObject:SetActive(false)
  REF.NodeDonation.gameObject:SetActive(false)
  this:Bind("fci/guild/donate/", OnGuildDonateChange)
  REF.LabelMyGuildScore.ResourceChangeListener:SetResource(PB.enum.ResourceType.ResGuildScore, 0)
  REF.LabelMyGuildScore.ResourceChangeListener:AddListener(OnGuildScoreChange, true)
  RU.BindRedMark(this, "Relation/Guild/Support/Donate", function(flag)
    REF.SpriteRequestRedMark.gameObject:SetActive(flag)
  end)
  RU.BindRedMark(this, "Relation/Guild/Support/Touch", function(flag)
    REF.SpriteIntimateRedMark.gameObject:SetActive(flag)
  end)
end

function UninitWindow()
  m_donateRes = nil
  REF.LabelMyGuildScore.ResourceChangeListener:RemoveListener(OnGuildScoreChange)
  ClearTopWindows()
end

function ClearTopWindows()
  for key, _ in pairs(m_windowsOnTop) do
    WU.RecycleWindow(key)
  end
  m_windowsOnTop = {}
end

function OnGuildScoreChange(type, id, count)
  REF.LabelMyGuildScore.UILabel.text = WU.GetString("Window_GuildMyGuildScore", count)
end

function OnRequestSupportClick()
  WU.RecordButtonClick(161001)
  if GU.CheckSupportRequestCD() then
    WU.AcquireWindowAsync("GuildSupportPicker")
  end
end

function OnSendClick()
  WU.RecordButtonClick(161004)
  if m_currentRequest then
    local item = this:GetData("fci/item/" .. m_currentRequest.donateRes.id)
    if item.count > 0 then
      if 0 < m_donateLeftCount then
        local receivedCount = GU.GetDonateInfo(m_currentRequest)
        local guildMisc = PB.index("GuildMisc", 1)
        if receivedCount < guildMisc.donateMaxCount then
          local donateRes = {
            type = m_currentRequest.donateRes.type,
            id = m_currentRequest.donateRes.id,
            count = 1
          }
          local param = {
            playerIdRequest = m_currentRequest.requestPlayerId,
            res = donateRes
          }
          this:GameRequest("fci/guild/{guildId}/donate/send/"):Post(param, function(result)
            local guildDonate = this:GetData("fci/guild/donate/")
            guildDonate.donates[result.donate.requestPlayerId] = result.donate
            for k, v in pairs(result.donatePlayerInfo) do
              guildDonate.donatePlayerInfo[k] = v
            end
            DBH.ResChange(result.resChange)
            this:SetData("fci/guild/donate/", guildDonate)
          end)
        end
      else
        WU.ShowHintText(WU.GetString("Window_GuildDonateMaxCount"))
      end
    else
      WU.ShowMessageYesNo(WU.GetString("Window_GuildDonateNoItem"), function(result)
        if result == "YES" then
          WU.OpenActorDecompose({
            chipId = item.id
          })
        end
      end)
    end
  end
end

function OnIntimateClick()
  local guildDonate = this:GetData("fci/guild/donate/")
  if guildDonate then
    local myRequest = guildDonate.donates[this:GetData("playerId")]
    if myRequest then
      if GU.GetDonateInfo(myRequest) > 0 then
        this:GameRequest("fci/guild/{guildId}/donate/touch/"):Post(nil, function(result)
          local guildDonate = this:GetData("fci/guild/donate/")
          guildDonate.donates[result.requestPlayerId] = result
          this:SetData("fci/guild/donate/", guildDonate)
        end)
      else
        WU.AcquireWindowAsync("GuildSupportPicker")
      end
    end
  end
end

function OnGuildDonateChange(guildDonate)
  if guildDonate then
    m_requestList = _ENV["!"](guildDonate.donates):toarray()
    if 0 < #m_requestList then
      table.sort(m_requestList, function(a, b)
        local aFullFactor = fif(GU.IsDonateFull(a), 1, 0)
        local bFullFactor = fif(GU.IsDonateFull(b), 1, 0)
        if aFullFactor ~= bFullFactor then
          return aFullFactor < bFullFactor
        else
          return a.createTime < b.createTime
        end
      end)
    end
    REF.NodeEmpty.gameObject:SetActive(#m_requestList == 0)
    REF.GuildSupportList.gameObject:SetActive(true)
    REF.NodeBottom.gameObject:SetActive(true)
    REF.SpriteCenter.gameObject:SetActive(0 < #m_requestList)
    REF.ButtonSend.gameObject:SetActive(0 < #m_requestList)
    LU.Set(REF.WrapContentSupportList, #m_requestList, false)
    REF.WrapContentSupportList.UICenterOnChild:Recenter()
    UpdateMyDonation(guildDonate)
    UpdateMyRequest(guildDonate)
    UpdateDonateButton()
  end
end

function UpdateMyDonation(guildDonate)
  local donatedCount = 0
  local donatePlayerInfo = guildDonate.donatePlayerInfo[this:GetData("playerId")]
  if donatePlayerInfo then
    donatedCount = donatePlayerInfo.donateCountWeekly
  end
  local guildMisc = PB.index("GuildMisc", 1)
  m_donateLeftCount = guildMisc.donateMaxCountByOnePlayer - donatedCount
  REF.LabelRemainSupportCount.UILabel.text = WU.GetString("Window_GuildWeeklyDonateCountLeft") .. m_donateLeftCount
end

function UpdateMyRequest(guildDonate)
  local myRequest = guildDonate.donates[this:GetData("playerId")]
  REF.NodeMySupport.gameObject:SetActive(myRequest)
  REF.ButtonRequestSupport.gameObject:SetActive(not myRequest)
  if myRequest then
    local guildMisc = PB.index("GuildMisc", 1)
    local receivedCount = GU.GetDonateInfo(myRequest)
    local itemInfo = PB.get("ItemInfo", myRequest.donateRes.id)
    REF.TextureTarget.UITexture.mainTexturePath = "Texture/ItemIcon/" .. itemInfo.icon
    REF.LabelMyCount.UILabel.text = tostring(receivedCount)
    REF.LabelScore.UILabel.text = WU.GetString("Window_GuildIntimacy") .. myRequest.loveScore .. "/" .. guildMisc.maxLoveScore
    local targetSegment
    for i = #guildMisc.loveSegment, 1, -1 do
      local segment = guildMisc.loveSegment[i]
      if segment.scoreLow <= myRequest.loveScore then
        targetSegment = segment
        break
      end
    end
    local minResult = receivedCount
    local maxResult = receivedCount
    if targetSegment then
      minResult = math.floor(targetSegment.randomLow / 10000 * receivedCount)
      maxResult = math.floor(targetSegment.randomHigh / 10000 * receivedCount)
    end
    if 0 < receivedCount then
      local countText = fif(minResult ~= maxResult, minResult .. "~" .. maxResult, tostring(minResult))
      REF.LabelResult.UILabel.text = WU.GetString("Window_GuildSupportResultPrediction", countText)
    else
      REF.LabelResult.UILabel.text = WU.GetString("Window_GuildWaitForDonation")
    end
    local touched = WU.IsToday(CS.GameTime.UtcToLocal(myRequest.lastTouchTime))
    local intimateText = ""
    local intimateEnabled = false
    if myRequest.loveScore >= guildMisc.maxLoveScore then
      intimateText = WU.GetString("Window_GuildIntimacyMax")
    elseif touched then
      intimateText = WU.GetString("Window_GuildIntimateDone")
    elseif receivedCount == 0 then
      intimateText = WU.GetString("Window_GuildChangeSupportRequest")
      intimateEnabled = true
    else
      intimateText = WU.GetString("Window_GuildIntimate")
      intimateEnabled = true
    end
    REF.ButtonIntimate.UIButton.isEnabled = intimateEnabled
    REF.LabelIntimate.UILabel.text = intimateText
    m_receivedDonations = {}
    for playerId, count in pairs(myRequest.donatesCount) do
      local playerName = guildDonate.donatePlayerInfo[playerId].playerName
      table.insert(m_receivedDonations, {name = playerName, count = count})
    end
    table.sort(m_receivedDonations, function(a, b)
      return a.count > b.count
    end)
    REF.NodeDonateList.gameObject:SetActive(0 < #m_receivedDonations)
    REF.NodeNoDonation.gameObject:SetActive(#m_receivedDonations == 0)
    if 0 < #m_receivedDonations then
      LU.Set(REF.WrapContentDonateList, #m_receivedDonations)
    end
  end
end

function UpdateSupportRow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if m_requestList and itemIndex <= #m_requestList then
    refRow.root["$SetRequest"](m_requestList[itemIndex])
  end
end

function OnCenter(gameObject)
  if gameObject then
    local newRequest = _ENV["$"](gameObject).root["$GetRequest"]()
    if m_currentRequest ~= newRequest then
      m_currentRequest = newRequest
      local isMyRequest = m_currentRequest.requestPlayerId == this:GetData("playerId")
      REF.NodeDonateSend.gameObject:SetActive(not isMyRequest)
      REF.NodeDonation.gameObject:SetActive(isMyRequest)
      if isMyRequest then
        LU.Set(REF.WrapContentDonateList, #m_receivedDonations)
      else
        local donateRes = m_currentRequest.donateRes
        if m_donateRes then
          this:Unbind("fci/item/" .. m_donateRes.id, OnDonateResChange)
        end
        m_donateRes = donateRes
        if m_donateRes then
          this:Bind("fci/item/" .. m_donateRes.id, OnDonateResChange)
        end
      end
    end
  end
end

function OnDonateResChange(item)
  UpdateDonateButton()
end

function UpdateDonateButton()
  if m_currentRequest then
    local item = this:GetData("fci/item/" .. m_currentRequest.donateRes.id)
    REF.LabelOwnCount.UILabel.text = WU.GetString("Window_GuildOwnItemCount") .. item.count
    local receivedCount = GU.GetDonateInfo(m_currentRequest)
    local guildMisc = PB.index("GuildMisc", 1)
    local full = receivedCount >= guildMisc.donateMaxCount
    REF.ButtonSend.UIButton.isEnabled = not full
    REF.LabelSend.UILabel.text = WU.GetString(fif(full, "Window_GuildDonateFull", "Window_GuildDonateSend"))
  end
end

function UpdateDonateRow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if 0 < itemIndex and itemIndex <= #m_receivedDonations then
    local donation = m_receivedDonations[itemIndex]
    refRow.root.UIHtmlLabel.text = WU.GetString("Window_GuildDonateDetails", donation.name, donation.count)
  end
end

function Focus(on)
  WU.RecordWindowFocus(100161, on)
end
