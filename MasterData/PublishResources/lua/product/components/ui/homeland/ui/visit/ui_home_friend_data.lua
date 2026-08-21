_class("UIHomeFriendData", Object)
UIHomeFriendData = UIHomeFriendData

function UIHomeFriendData:Constructor(social_info, visit_info)
  self._socialInfo = social_info
  self._visitInfo = visit_info
  self._level = 0
  local cfgs = Cfg.cfg_homeland_level({})
  for i = #cfgs, 1, -1 do
    if self._visitInfo.exp >= cfgs[i].UpgradeCondition then
      self._level = i
      break
    end
  end
end

function UIHomeFriendData:Name()
  return self._socialInfo.simple_info.nick
end

function UIHomeFriendData:Icon()
  return self._socialInfo.simple_info.head
end

function UIHomeFriendData:OnlineInfo()
  if self._socialInfo.simple_info.is_online then
    return StringTable.Get("str_chat_online")
  end
  local now = GetSvrTimeNow()
  local time = self._socialInfo.simple_info.last_logout_time
  return HelperProxy:GetInstance():FormatTime_3(now - time)
end

function UIHomeFriendData:Level()
  return self._level
end

function UIHomeFriendData:LivableValue()
  return self._visitInfo.livable
end

function UIHomeFriendData:PstID()
  return self._visitInfo.pstid
end

function UIHomeFriendData:CanGetGift()
  return self._visitInfo.mask & HomelandVisitMask.HVM_Item > 0
end

function UIHomeFriendData:CanSpeedup()
  return self._visitInfo.mask & HomelandVisitMask.HVM_Forge > 0
end

function UIHomeFriendData:CanWater()
  return self._visitInfo.mask & HomelandVisitMask.HVM_Cultivation > 0
end

function UIHomeFriendData:HeadIcon()
  return self._socialInfo.simple_info.head, self._socialInfo.simple_info.head_bg, self._socialInfo.simple_info.frame_id
end
