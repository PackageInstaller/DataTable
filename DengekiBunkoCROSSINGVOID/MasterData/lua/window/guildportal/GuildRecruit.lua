local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GuildUtil")
local DBH = require("Manager/DataBindingHandler")
local m_hour = 1
local m_id, m_config, m_recruitInfo
local m_enough = false
local m_showing = false

function SetupWindow()
  ManageButtonEvents()
end

function SetContent(recruitInfo)
  m_hour = 1
  m_recruitInfo = recruitInfo
  REF.InputGuildBillboard.UIInput.value = nil
  this:Bind("fci/guild/", function(guild)
    m_id = guild.id
    m_config = PB.all("Misc"):first().guildRecruitConfig
    local remainTime = m_recruitInfo.publishTime + m_recruitInfo.duration - CS.GameTime.serverUtc
    UpdateHour()
    m_showing = m_recruitInfo.publishTime ~= 0 and 0 <= remainTime
    REF.NodeCreate.gameObject:SetActive(not m_showing)
    REF.NodeModify.gameObject:SetActive(m_showing)
    if m_showing then
      REF.InputGuildBillboard.UIInput.defaultText = m_recruitInfo.bulletinContent
    else
      REF.InputGuildBillboard.UIInput.defaultText = WU.GetString("Window_GuildAdDefaultText")
    end
    REF.SpriteBadge.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", tonumber(guild.icon) or 1) .. "s"
  end)
end

function ManagePace(pace)
  m_hour = m_hour + pace
  UpdateHour()
end

function UpdateHour()
  m_hour = math.clamp(m_hour, 1, 24)
  local item = m_config.publishCost
  WU.SetLabel(REF.LabelHour, m_hour .. WU.GetString("Window_GuildHour"))
  REF.ButtonDecrease.UISprite.graify = m_hour <= 1
  REF.ButtonIncrease.UISprite.graify = 24 <= m_hour
  local resIconHtml = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[item.type] .. "_" .. item.id .. "' />"
  WU.SetLabel(REF.LabelCost, resIconHtml .. item.count * m_hour)
  m_enough = true
  local guild = this:GetData("fci/guild/")
  local costStock = guild.score
  m_enough = costStock >= item.count * m_hour
end

function ValidateContent(content)
  if content == "" or content == nil then
    if m_showing then
      WU.RecycleWindow(this)
      return true
    else
      WU.ShowHintText(WU.GetString("Window_GuildEmptyForbidden"))
      return true
    end
  elseif WU.CharacterLength(content) > m_config.maxBulletinContentLength then
    WU.ShowHintText(WU.GetString("Window_GuildAdDefaultText"))
    return true
  end
  return false
end

function RenderTime(time)
  local remainTime = time - CS.GameTime.serverUtc
  local hours = math.floor(time / 3600)
  local minutes = math.floor(time % 3600 / 60)
  local seconds = math.floor(time % 3600 % 60)
  local str = hours .. WU.GetString("Window_HourUnit") .. minutes .. WU.GetString("Window_MinUnit") .. seconds .. WU.GetString("Window_SecUnit")
  return WU.GetString("Window_RemainTime") .. str
end

function UpdateWindow(delta)
  if m_showing and m_recruitInfo then
    local remainTime = m_recruitInfo.publishTime + m_recruitInfo.duration - CS.GameTime.serverUtc
    WU.SetLabel(REF.LabelTime, RenderTime(math.max(0, remainTime)))
  end
end

function ManageButtonEvents()
  WU.BindButtonEvent(REF.ButtonIncrease, function()
    ManagePace(1)
  end)
  WU.BindButtonEvent(REF.ButtonDecrease, function()
    ManagePace(-1)
  end)
  WU.BindButtonEvent(REF.ButtonMax, function()
    m_hour = 24
    UpdateHour()
  end)
  WU.BindButtonEvent(REF.ButtonCreate, function()
    local param = {
      duration = m_hour,
      guildId = m_id,
      bulletinContent = REF.InputGuildBillboard.UIInput.value
    }
    if ValidateContent(param.bulletinContent) then
      return
    end
    if not m_enough then
      WU.ShowHintText(WU.GetString("Window_GuildNotEnough"))
      return
    end
    this:GameRequest("fci/guild-recruit/"):Post(param, function(result)
      if result == nil then
        return WU.RecycleWindow(this)
      end
      local guild = this:GetData("fci/guild/")
      guild.score = result.newGuildScore
      this:SetData("fci/guild/", guild)
      WU.ShowHintText(WU.GetString("Window_GuildAdPass"))
      WU.RecycleWindow(this)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonModify, function()
    local param = {
      guildId = m_id,
      newBulletinContent = REF.InputGuildBillboard.UIInput.value
    }
    if ValidateContent(param.newBulletinContent) then
      return
    end
    this:GameRequest("fci/guild-recruit-self/"):Post(param, function(result)
      if not result.isExpire then
        WU.ShowHintText(WU.GetString("Window_GuildAdModified"))
      else
        WU.ShowHintText(WU.GetString("Window_GuildExpire"))
      end
      WU.RecycleWindow(this)
    end)
  end)
  WU.BindButtonEvent(REF.ButtonCancel, function()
    WU.RecycleWindow(this)
  end)
end
