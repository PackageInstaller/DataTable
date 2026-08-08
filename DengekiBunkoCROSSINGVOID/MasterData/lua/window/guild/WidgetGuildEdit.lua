local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local m_guild
local m_windowsOnTop = {}
local SocialGroupOperations = {
  Bind = 0,
  Unbind = 1,
  Join = 2
}
local m_socialGroupOperation, m_qqGroupId, m_qqGroupName, m_coroutine

function Start()
  WU.BindButtonEvent(REF.ButtonGuildMore, OnGuildMore)
  WU.BindButtonEvent(REF.ButtonEditMail, OnGuildMail)
  WU.BindButtonEvent(REF.ButtonBulletinMore, OnBulletinMore)
  WU.BindButtonEvent(REF.ButtonSocialGroupMore, OnSocialGroupMore)
  WU.BindButtonEvent(REF.ButtonUpgradeMore, OnUpgradeMore)
  WU.BindButtonEvent(REF.ButtonEditBadge, OnEditBadge)
  WU.BindButtonEvent(REF.ButtonEditName, OnEditName)
  local switch = this:GetData("AccountSwitch")
  WU.SetActive(REF.LabelSocialGroup, switch and switch.GuildSocialGroup)
  WU.SetActive(REF.ButtonSocialGroupOperation, switch and switch.GuildSocialGroup)
  this:RegisterGameEvent("OnGetQQGroupIdCallback", OnGetQQGroupIdCallback)
  this:RegisterGameEvent("OnQueryQQGroupCallback", OnQueryQQGroupCallback)
  this:RegisterGameEvent("OnBindQQGroupCallback", OnBindQQGroupCallback)
  this:RegisterGameEvent("OnUnbindQQGroupCallback", OnUnbindQQGroupCallback)
  this:RegisterGameEvent("OnJoinQQGroupCallback", OnJoinQQGroupCallback)
  this:RegisterGameEvent("OnQueryWXGroupCallback", OnQueryWXGroupCallback)
  this:RegisterGameEvent("OnBindWXGroupCallback", OnBindWXGroupCallback)
  this:RegisterGameEvent("OnUnbindWXGroupCallback", OnUnbindWXGroupCallback)
  this:RegisterGameEvent("OnJoinWXGroupCallback", OnJoinWXGroupCallback)
  WU.BindButtonEvent(REF.ButtonSocialGroupOperation, OnSocialGroupOperationClick)
end

function OnEnable()
  this:Bind("fci/guild/", OnGuildChange)
  this:Bind("fci/guild-player/", OnGuildPlayerChange)
  this:DelayInvokeInFrames(1, function()
    REF.NodeGuildMenu["$Hide"](true)
  end)
  REF.LabelSocialGroup.UILabel.text = ""
  WU.ToggleRendering(REF.ButtonSocialGroupOperation, false)
end

function OnDisable()
  ClearTopWindows()
  this:Unbind("fci/guild/", OnGuildChange)
  this:Unbind("fci/guild-player/", OnGuildPlayerChange)
  if m_coroutine ~= nil then
    this:StopCoroutine(m_coroutine)
    m_coroutine = nil
  end
end

function ClearTopWindows()
  for key, _ in pairs(m_windowsOnTop) do
    WU.RecycleWindow(key)
  end
  m_windowsOnTop = {}
end

function QueryBindGroupStatus(delay)
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = false
  if m_coroutine ~= nil then
    this:StopCoroutine(m_coroutine)
    m_coroutine = nil
  end
  m_coroutine = this:DelayInvokeInSeconds(delay, function()
    local accountCache = this:GetData("accountCache")
    local platform = U.ToEnum(CS.Msdk.ePlatform, accountCache.socialPlatform)
    if platform == CS.Msdk.ePlatform.ePlatform_QQ then
      local gameGuild = CS.Msdk.GameGuild()
      gameGuild.guildId = this:GetData("guildId")
      gameGuild.guildName = this:GetData("fci/guild/").name
      gameGuild.zoneId = this:GetData("worldId")
      gameGuild.roleId = this:GetData("playerId")
      gameGuild.partition = this:GetData("worldId")
      gameGuild.type = "0"
      CS.Msdk.WGPlatform.Instance:WGGetQQGroupCodeV2(gameGuild)
    elseif platform == CS.Msdk.ePlatform.ePlatform_Weixin then
      local guildId = this:GetData("guildId")
      local openId = this:GetData("SocialOpenId") .. ","
      CS.Msdk.WGPlatform.Instance:WGQueryWXGroupInfo(guildId, openId)
    end
  end)
end

function OnGuildChange(guild)
  m_guild = guild
  if m_guild then
    REF.WidgetGuildProfile["$SetData"](m_guild)
    local guildScore = 0
    local memberCountText = ""
    local vicePresidentCountText = ""
    local qqGroup = ""
    local expProgress = 0
    guildScore = m_guild.score
    qqGroup = m_guild.qqGroup
    local guildLevel = PB.get("GuildLevel", math.max(1, m_guild.level))
    expProgress = fif(m_guild.level >= PB.index("GuildMisc", 1).maxGuildLevel, 1, m_guild.exp / guildLevel.exp)
    memberCountText = m_guild.membersCount .. "/" .. guildLevel.maxMemberCount
    vicePresidentCountText = #m_guild.vicePresident .. "/" .. guildLevel.maxVicePresidentCount
    REF.LabelMemberCount.UILabel.text = memberCountText
    REF.ProgressBarExp.UIProgressBar.value = expProgress
    REF.LabelTotalScore.UILabel.text = guildScore
    REF.LabelVicePresidentCount.UILabel.text = vicePresidentCountText
    QueryBindGroupStatus(0)
  end
end

function OnGuildPlayerChange(guildPlayer)
  if guildPlayer then
    local highPos = guildPlayer.type == PB.enum.GuildMemberType.President or guildPlayer.type == PB.enum.GuildMemberType.VicePresident
    REF.LabelMyScore.UILabel.text = guildPlayer.guildScoreRecord
    REF.NodeButtons.gameObject:SetActive(GU.IsGuildManager() and m_guild)
    REF.ButtonEditMail.gameObject:SetActive(highPos)
    if highPos then
      WU.ActiveByNeverClick(REF.GuildMailTip_GuildEdit)
      this:DelayInvokeInSeconds(5, function()
        WU.SetClickB4(REF.GuildMailTip_GuildEdit)
      end)
    else
      REF.GuildMailTip_GuildEdit.gameObject:SetActive(false)
    end
  end
end

function OnGuildMore()
  if m_guild then
    REF.NodeGuildMenu["$Show"]()
    REF.ButtonGrid.UIGrid:Reposition()
  end
end

function OnEditBadge()
  if m_guild then
    WU.AcquireWindowAsync("GuildCustom", function(ui)
      local guildMisc = PB.index("GuildMisc", 1)
      _ENV["$"](ui)["$$SetData"](guildMisc.badgeCount, tonumber(m_guild.icon) or 1, function(badge)
        RequestPatchGuild({
          icon = tostring(badge)
        })
      end)
    end)
  end
  REF.NodeGuildMenu["$Hide"]()
end

function OnEditName()
  if m_guild then
    local guildMisc = PB.index("GuildMisc", 1)
    local renameCost = guildMisc.renameCost
    local costHtml = "<img src='ResIcon_s.ResGuildScore_0'/>&nbsp;" .. tostring(renameCost)
    if renameCost > m_guild.score then
      costHtml = "<font color=#fd5454>" .. costHtml .. "</font>"
    end
    m_windowsOnTop.EditBox = true
    WU.ShowEditBox({
      title = WU.GetString("Window_GuildEditName"),
      subTitle = WU.GetString("Window_GuildEditNameSub"),
      tips = WU.GetString("Window_CharacterLimit", guildMisc.maxNameLen),
      characterLimit = guildMisc.maxNameLen,
      costEx = costHtml
    }, function(name)
      m_windowsOnTop.EditBox = nil
      if m_guild and name ~= m_guild.name then
        if m_guild.score >= renameCost then
          RequestPatchGuild({name = name})
        else
          WU.ShowHintText(WU.GetString("Window_GuildScoreInsufficient"))
          return false
        end
      end
      return true
    end, function()
      m_windowsOnTop.EditBox = nil
    end)
  end
  REF.NodeGuildMenu["$Hide"]()
end

function OnBulletinMore()
  if m_guild then
    local guildMisc = PB.index("GuildMisc", 1)
    m_windowsOnTop.EditBox = true
    WU.ShowEditBox({
      title = WU.GetString("Window_GuildEditBulletin"),
      subTitle = WU.GetString("Window_GuildEditBulletinSub"),
      tips = WU.GetString("Window_CharacterLimit", guildMisc.maxBillboardLen),
      characterLimit = guildMisc.maxBillboardLen,
      multiple = true,
      allowEmpty = true,
      defaultText = m_guild.billboard
    }, function(bulletin)
      m_windowsOnTop.EditBox = nil
      if bulletin ~= m_guild.billboard then
        RequestPatchGuild({billboard = bulletin}, nil)
      end
      return true
    end, function()
      m_windowsOnTop.EditBox = nil
    end)
  end
end

function OnSocialGroupMore()
  if m_guild then
    m_windowsOnTop.EditBox = true
    WU.ShowEditBox({
      title = WU.GetString("Window_GuildEditQQGroup"),
      subTitle = WU.GetString("Window_GuildEditQQGroupSub"),
      keyboardType = CS.UIInput.KeyboardType.NumberPad,
      allowEmpty = true
    }, function(qqGroup)
      m_windowsOnTop.EditBox = nil
      if m_guild and qqGroup ~= m_guild.qqGroup then
        RequestPatchGuild({qqGroup = qqGroup})
      end
      return true
    end, function()
      m_windowsOnTop.EditBox = nil
    end)
  end
end

function OnUpgradeMore()
  WU.AcquireWindowAsync("GuildUpgradePreview")
end

function RequestPatchGuild(patch)
  this:GameRequest("fci/guild/{guildId}/"):Patch(patch, function(result)
    DBH.ResChange(result.resChange)
    this:SetData("fci/guild/", result.baseInfo)
  end)
end

function SetSocialOperationButtonStatus(operation)
  local text = ""
  local platform = U.ToEnum(CS.Msdk.ePlatform, this:GetData("accountCache").socialPlatform)
  local isLoginWithQQ = platform == CS.Msdk.ePlatform.ePlatform_QQ
  if operation == SocialGroupOperations.Bind then
    text = WU.GetString(fif(isLoginWithQQ, "Window_GuildSocialGroup_QQ_Bind", "Window_GuildSocialGroup_WX_Bind"))
  elseif operation == SocialGroupOperations.Unbind then
    text = WU.GetString(fif(isLoginWithQQ, "Window_GuildSocialGroup_QQ_Unbind", "Window_GuildSocialGroup_WX_Unbind"))
  elseif operation == SocialGroupOperations.Join then
    text = WU.GetString(fif(isLoginWithQQ, "Window_GuildSocialGroup_QQ_Join", "Window_GuildSocialGroup_WX_Join"))
  end
  REF.LabelSocialGroupOperation.UILabel.text = text
  m_socialGroupOperation = operation
end

function OnSocialGroupOperationClick()
  if m_guild then
    local gameGuild = CS.Msdk.GameGuild()
    gameGuild.guildId = this:GetData("guildId")
    gameGuild.guildName = this:GetData("fci/guild/").name
    gameGuild.zoneId = this:GetData("worldId")
    gameGuild.roleId = this:GetData("playerId")
    gameGuild.partition = this:GetData("worldId")
    gameGuild.type = "0"
    if m_socialGroupOperation == SocialGroupOperations.Bind then
      local platform = U.ToEnum(CS.Msdk.ePlatform, this:GetData("accountCache").socialPlatform)
      if platform == CS.Msdk.ePlatform.ePlatform_QQ then
        m_qqGroupName = gameGuild.guildName
        CS.Msdk.WGPlatform.Instance:WGCreateQQGroupV2(gameGuild)
      elseif platform == CS.Msdk.ePlatform.ePlatform_Weixin then
        local baseInfo = this:GetData("fci/baseinfo/")
        CS.Msdk.WGPlatform.Instance:WGCreateWXGroup(gameGuild.guildId, gameGuild.guildName, baseInfo.name)
      end
      QueryBindGroupStatus(2)
    elseif m_socialGroupOperation == SocialGroupOperations.Unbind then
      local platform = U.ToEnum(CS.Msdk.ePlatform, this:GetData("accountCache").socialPlatform)
      if platform == CS.Msdk.ePlatform.ePlatform_QQ then
        local switch = this:GetData("AccountSwitch")
        if switch and switch.GuildSocialGroupBackend then
          this:GameRequest("fci/guild/" .. gameGuild.guildId .. "/group/unlink/"):Post(nil, function(res)
            if res then
              OnUnbindQQGroupCallback(res.ret == CS.Msdk.eFlag.eFlag_Succ, gameGuild.guildId, res.errorcode)
            end
          end)
        else
          CS.Msdk.WGPlatform.Instance:WGUnbindQQGroupV2(gameGuild)
        end
      elseif platform == CS.Msdk.ePlatform.ePlatform_Weixin then
        CS.Msdk.WGPlatform.Instance:WGUnbindWeiXinGroup(gameGuild.guildId)
      end
      QueryBindGroupStatus(2)
    elseif m_socialGroupOperation == SocialGroupOperations.Join then
      do
        local platform = U.ToEnum(CS.Msdk.ePlatform, this:GetData("accountCache").socialPlatform)
        if platform == CS.Msdk.ePlatform.ePlatform_QQ then
          CS.Msdk.WGPlatform.Instance:WGJoinQQGroupV2(gameGuild, m_qqGroupId)
        elseif platform == CS.Msdk.ePlatform.ePlatform_Weixin then
          local baseInfo = this:GetData("fci/baseinfo/")
          CS.Msdk.WGPlatform.Instance:WGJoinWXGroup(gameGuild.guildId, baseInfo.name)
        end
        QueryBindGroupStatus(2)
      end
    end
  end
end

function OnGetQQGroupIdCallback(result, errorCode, qqGroupId, qqGroupName)
  if result then
    m_qqGroupId = qqGroupId
    m_qqGroupName = qqGroupName
    if qqGroupId ~= nil and qqGroupId ~= "" then
      REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildQQGroupExist", m_qqGroupId)
      CS.Msdk.WGPlatform.Instance:WGQueryQQGroupInfoV2(qqGroupId)
    else
      if GU.IsGuildManager() then
        WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
        SetSocialOperationButtonStatus(SocialGroupOperations.Bind)
      else
        WU.ToggleRendering(REF.ButtonSocialGroupOperation, false)
      end
      REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildQQGroupNotSet")
    end
  else
    WU.ShowHintText(WU.GetString("Guild_BindBroup_GetQQGroupIdError", errorCode))
  end
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = true
end

function OnQueryQQGroupCallback(result, relation)
  if result then
    if relation == 1 or relation == 2 or relation == 3 then
      if GU.IsGuildManager() then
        WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
        SetSocialOperationButtonStatus(SocialGroupOperations.Unbind)
      end
    else
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
      SetSocialOperationButtonStatus(SocialGroupOperations.Join)
    end
  else
    WU.ShowHintText(WU.GetString("Guild_BindBroup_QueryQQGroupError", errorCode))
  end
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = true
end

function OnQueryWXGroupCallback(groupHadExist, openIdList)
  if groupHadExist then
    if openIdList == this:GetData("SocialOpenId") then
      if GU.IsGuildManager() then
        WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
        SetSocialOperationButtonStatus(SocialGroupOperations.Unbind)
      else
        WU.ToggleRendering(REF.ButtonSocialGroupOperation, false)
      end
      REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildWechatGroupAlreadyIn")
    else
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
      SetSocialOperationButtonStatus(SocialGroupOperations.Join)
      REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildWechatGroupExist")
    end
  else
    if GU.IsGuildManager() then
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
      SetSocialOperationButtonStatus(SocialGroupOperations.Bind)
    else
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, false)
    end
    REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildWechatGroupNotSet")
  end
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = true
end

function OnBindQQGroupCallback(result, groupId, errorCode)
  if result then
    m_qqGroupId = groupId
    REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildQQGroupExist", m_qqGroupId)
    SetSocialOperationButtonStatus(SocialGroupOperations.Unbind)
    this:GameRequest("fci/guild/{guildId}/socialgroup"):Patch({
      isBoundWx = false,
      qqGroupId = m_qqGroupId,
      resetQq = false,
      resetWx = false,
      joinQq = false,
      joinWx = false
    })
  else
    ShowBindGroupError(true, errorCode)
  end
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = true
end

function OnBindWXGroupCallback(result, errorCode)
  if result then
    REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildWechatGroupAlreadyIn")
    if GU.IsGuildManager() then
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
      SetSocialOperationButtonStatus(SocialGroupOperations.Unbind)
    else
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, false)
    end
    WU.ShowHintText(WU.GetString("Window_GuildSocialGroup_BindSucceed"))
    this:GameRequest("fci/guild/{guildId}/socialgroup"):Patch({
      isBoundWx = true,
      qqGroupId = "",
      resetQq = false,
      resetWx = false,
      joinQq = false,
      joinWx = false
    })
  else
    ShowBindGroupError(false, errorCode)
  end
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = true
end

function OnUnbindQQGroupCallback(result, groupId, errorCode)
  UnbindGroupImpl(result, true, errorCode)
end

function OnUnbindWXGroupCallback(result, errorCode)
  UnbindGroupImpl(result, false, errorCode)
end

function UnbindGroupImpl(result, isQQOrWX, errorCode)
  if result then
    if isQQOrWX then
      m_qqGroupId = ""
      REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildQQGroupNotSet")
    else
      REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildWechatGroupNotSet")
    end
    if GU.IsGuildManager() then
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
      SetSocialOperationButtonStatus(SocialGroupOperations.Bind)
    else
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, false)
    end
    WU.ShowHintText(WU.GetString("Window_GuildSocialGroup_UnbindSucceed"))
    this:GameRequest("fci/guild/{guildId}/socialgroup"):Patch({
      isBoundWx = false,
      qqGroupId = "",
      resetQq = isQQOrWX,
      resetWx = not isQQOrWX,
      joinQq = false,
      joinWx = false
    })
  else
    ShowBindGroupError(isQQOrWX, errorCode)
  end
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = true
end

function OnJoinQQGroupCallback(result, errorCode)
  JoinGroupImpl(result, true, errorCode)
end

function OnJoinWXGroupCallback(result, errorCode)
  JoinGroupImpl(result, false, errorCode)
end

function JoinGroupImpl(result, isQQOrWX, errorCode)
  if result then
    if not isQQOrWX then
      REF.LabelSocialGroup.UILabel.text = WU.GetString("Window_GuildWechatGroupAlreadyIn")
    end
    if GU.IsGuildManager() then
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, true)
      SetSocialOperationButtonStatus(SocialGroupOperations.Unbind)
    else
      WU.ToggleRendering(REF.ButtonSocialGroupOperation, false)
    end
    WU.ShowHintText(WU.GetString("Window_GuildSocialGroup_JoinSucceed"))
    this:GameRequest("fci/guild/{guildId}/socialgroup"):Patch({
      isBoundWx = false,
      qqGroupId = "",
      resetQq = false,
      resetWx = false,
      joinQq = isQQOrWX,
      joinWx = not isQQOrWX
    })
  else
    ShowBindGroupError(isQQOrWX, errorCode)
  end
  REF.ButtonSocialGroupOperation.UIButton.isEnabled = true
end

function ShowBindGroupError(isQQOrWX, errorCode)
  if isQQOrWX then
    if errorCode == 221011 or errorCode == 221012 or errorCode == -182003 then
      WU.ShowHintText(WU.GetString("Guild_BindBroup_Error_QQ" .. math.abs(errorCode)))
    else
      WU.ShowHintText(WU.GetString("Guild_BindBroup_Error_QQ", errorCode))
    end
  elseif errorCode == CS.MSDK.eFlag.eFlag_Error then
    WU.ShowHintText(WU.GetString("Guild_BindBroup_ErrorUnknown"))
  else
    WU.ShowHintText(WU.GetString("Guild_BindBroup_Error" .. errorCode))
  end
end

function OnGuildMail()
  local guildId = this:GetData("guildId")
  
  local function activateMail()
    WU.AcquireWindowAsync("GuildMail", function(window)
      _ENV["$"](window)["$$SetContent"](guildId)
    end)
  end
  
  this:GameRequest("fci/guild-mail/" .. guildId .. "/"):Get(function(result)
    if result and result.senderName then
      if not result.forbidden then
        local sameWeek = CS.GameTime.IsSameWeek(CS.GameTime.UtcToLocal(result.sendTime), CS.GameTime.serverNow)
        if not sameWeek then
          activateMail()
        else
          WU.ShowHintText(WU.GetString("Window_GuildMailBefore", result.senderName))
        end
      else
        WU.ShowHintText(WU.GetString("Window_GuildForbidden"))
      end
    else
      activateMail()
    end
  end)
end
