local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local ACU = require("Common/ActivityUtil")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local IU = require("Common/ItemUtil")
local ShowFriendCount = 6
local m_activityManager = S:Get("ActivityManager")
local m_inited, m_recallInfo, m_friendList, m_showFriends, m_unsentFriends, m_sentFriendIdSet, m_selectedIndexes, m_rewardConfigs

function Awake()
  WU.BindButtonEvent(REF.ButtonRecall, OnClickRecall)
  WU.BindButtonEvent(REF.ButtonRefresh, OnClickRefresh)
  for i = 0, #REF.GridFriends - 1 do
    REF.GridFriends[i]["@index"] = i + 1
    REF.GridFriends[i]["$$SetClickCallback"](OnClickFriend)
  end
  local activities = m_activityManager.GetActivitiesByTypeSync(PB.enum.ActivityType.RecallActivity)
  if activities and activities[1] then
    local activity = activities[1]
    local timeStart = ACU.RenderTime2(activity.timestampStart, true)
    local timeEnd = ACU.RenderTime2(activity.timestampClose, true)
    REF.LabelTime.UILabel.text = WU.GetString("Window_TimeToTime", timeStart, timeEnd)
  else
    error("GamePlay", "recall activity is not started")
  end
end

function OnEnable()
  m_inited = false
  this:Bind("fci/friendlist/", OnFriendList)
end

function OnDisable()
  this:Unbind("fci/friendlist/", OnFriendList)
end

function OnFriendList(friendList)
  if friendList then
    local accountCache = this:GetData("accountCache")
    local socialPlatform = accountCache.socialPlatform
    m_friendList = _ENV["!"](friendList):where(function(k, v)
      return v.socialPlatform == socialPlatform
    end):toarray()
    this:Unbind("fci/friend-recall-activity/", OnActivity)
    this:BindRemote(this:GameRequest("fci/friend-recall-activity/"), OnActivity)
  end
end

function OnActivity(recallInfo)
  WU.SetActive(REF.GridFriends, recallInfo ~= nil)
  if recallInfo == nil then
    return
  end
  m_recallInfo = recallInfo
  m_sentFriendIdSet = _ENV["!"]({})
  m_unsentFriends = _ENV["!"]({})
  for i = 1, #recallInfo.players do
    m_sentFriendIdSet[recallInfo.players[i]] = true
  end
  for i = 1, #m_friendList do
    local friend = m_friendList[i]
    if not m_sentFriendIdSet[friend.playerId] and ReachRecallCondition(friend) then
      table.insert(m_unsentFriends, friend)
    end
  end
  if m_inited then
    SetFriendView()
  else
    m_rewardConfigs = PB.all("RecallActivityReward")
    for i = 0, #REF.GridReward - 1 do
      local ref = REF.GridReward[i]
      local config = m_rewardConfigs[i + 1]
      ref["@process"] = config.process
      local reward = config.rewards[1]
      ref["$$SetData"](reward.type, reward.id)
      ref["$$SetBG"](IU.GetResourceQuality(reward.type, reward.id))
    end
    for i = 0, #REF.GridProgress - 1 do
      local ref = REF.GridProgress[i]
      local config = m_rewardConfigs[i + 1]
      ref.root.UILabel.text = WU.GetString("Window_ActivityRecall_RecallPlayerCount", config.process)
    end
    RefreshShowFriends()
    m_inited = true
  end
  REF.LabelProcess.UILabel.text = recallInfo.recallProcess
  REF.ActivePointProgress.UIProgressBar.value = recallInfo.recallProcess / m_rewardConfigs[#m_rewardConfigs].process
  for i = 0, #REF.GridReward - 1 do
    local ref = REF.GridReward[i]
    local config = m_rewardConfigs[i + 1]
    ref["$$SetGray"](table.has(m_recallInfo.gotProcess, config.process))
    local canReward = not table.has(m_recallInfo.gotProcess, config.process) and config.process <= m_recallInfo.recallProcess
    ref["$$SetClickCallback"](fif(canReward, OnClickReward, nil))
    ref["$$SetEffect"](canReward)
  end
end

function SetFriendView()
  for i = 0, #REF.GridFriends - 1 do
    local ref = REF.GridFriends[i]
    local friend = m_showFriends[i + 1]
    if friend then
      WU.SetActive(ref.root, true)
      ref["$$SetData"](friend)
      ref["$$SetSent"](m_sentFriendIdSet[friend.playerId])
      ref["$$SetSelected"](m_selectedIndexes:has(i + 1))
    else
      WU.SetActive(ref.root, false)
    end
  end
  WU.SetActive(REF.NodeEmpty, m_showFriends == nil or #m_showFriends == 0)
end

function RefreshShowFriends()
  m_selectedIndexes = _ENV["!"]({})
  m_showFriends = _ENV["!"]({})
  m_unsentFriends:shuffle()
  for i = 1, ShowFriendCount do
    local friend = m_unsentFriends[i]
    if friend then
      m_showFriends[i] = friend
    else
      break
    end
  end
  for i = 1, #m_showFriends do
    table.insert(m_selectedIndexes, i)
  end
  SetFriendView()
end

function ReachRecallCondition(playerData)
  local misc = PB.index("Misc", 1)
  local dayLimit = misc.recallActivityDayLimit
  local levelLimit = misc.recallActivityLevelLimit
  local leaveDay = (CS.GameTime.serverUtc - playerData.lastLogoutTime) / 86400
  return playerData.lastLogoutTime > 0 and dayLimit <= leaveDay and levelLimit <= playerData.level
end

function Recall(friendData)
  if friendData == nil then
    return
  end
  local baseinfo = this:GetData("fci/baseinfo/")
  local fopenid = friendData.socialOpenId
  local title = WU.GetString("Msdk_Recall_Title")
  local previewText = WU.GetString("Msdk_Recall_PreviewText")
  local tag = "MSG_INVITE"
  local callbackInfo = "msdkCallbackInfo"
  local succeed = false
  if friendData.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_Wechat then
    local messageExt = "inviteReCall"
    succeed = CS.Msdk.WGPlatform.Instance:WGSendToWXGameFriend(fopenid, title, previewText, "", messageExt, tag, callbackInfo)
  elseif friendData.socialPlatform == PB.enum.MSDKLoginPlatform.MSDK_QQ then
    local summary = WU.GetString("Msdk_Recall_QQ_Summary")
    local targetUrl = "http://gamecenter.qq.com/gcjump?game_tag=MSG_INVITE&plat=qq&pf=invite&appid=100703379&originuin=61793295"
    targetUrl = targetUrl .. "&from=androidqq"
    local imgUrl = PB.all("Misc"):first().msdkFriendIcon
    succeed = CS.Msdk.WGPlatform.Instance:WGSendToQQGameFriend(1, fopenid, title, summary, targetUrl, imgUrl, previewText, tag, callbackInfo)
  end
  if succeed then
  end
end

function OnClickRefresh()
  RefreshShowFriends()
end

function OnClickRecall()
  local selectedIds = {}
  for i = 1, #m_selectedIndexes do
    local friend = m_showFriends[m_selectedIndexes[i]]
    Recall(friend)
    table.insert(selectedIds, friend.playerId)
  end
  if 0 < #selectedIds then
    WU.ShowMessageYesNo(WU.GetString("Window_Recall_Hint1"), function(result)
      if result == "YES" then
        this:GameRequest("fci/friend-recall-activity/"):Post({playerId = selectedIds}, function(resp)
          m_selectedIndexes = _ENV["!"]({})
          this:SetData("fci/friend-recall-activity/", resp)
        end)
      end
    end)
  end
end

function OnClickFriend(go)
  local index = _ENV["$"](go)["@index"]
  local i = table.find(m_selectedIndexes, function(k, v)
    return v == index
  end)
  if i then
    table.remove(m_selectedIndexes, i)
  else
    local friend = m_showFriends[index]
    if not m_sentFriendIdSet[friend.playerId] then
      table.insert(m_selectedIndexes, index)
    end
  end
  SetFriendView()
end

function OnClickReward(go)
  local process = _ENV["$"](go)["@process"]
  this:GameRequest("fci/friend-recall-activity/reward/"):Post({process = process}, function(resp)
    DBH.ResChange(resp.resChange)
    WU.ShowRewards(resp.resChange)
    m_recallInfo.gotProcess = resp.gotProcess
    DB:SetData("fci/friend-recall-activity/", m_recallInfo)
  end)
end
