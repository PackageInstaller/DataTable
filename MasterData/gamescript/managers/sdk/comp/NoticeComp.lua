local JSON = require("ejoysdk_lua.libs.lunajson")
local ejoysdk_badge = require("ejoysdk_lua.badge.ejoysdk_badge_anns")
local EL = require("ejoysdk_lua.ejoysdk_launcher")
local NoticeComp, Super = System.NewClass("NoticeComp", Component, IUpdater)

function NoticeComp:ctor()
  Super.ctor(self)
end

function NoticeComp:Awake(_)
  Super.Awake(self)
end

function NoticeComp:OnDestroy()
  Super.OnDestroy(self)
end

function NoticeComp:GetNotice(noticeType, tags, serverId, callback)
  EL.ticket_detail_with_badge(noticeType, tags, serverId, function(succ, anns)
    if callback then
      if type(anns) == "string" then
        anns = JSON.decode(anns)
        if anns then
          callback(succ, anns.anns, anns.force_popup)
        end
      else
        callback(false)
      end
    end
  end)
end

function NoticeComp:GetEntranceRed(noticeType, tags, serverId, callback)
  ejoysdk_badge.has_unread_notice(noticeType, tags, serverId, function(ret)
    print("has_unread_notice ===========", ret)
    if callback then
      callback(ret)
    end
  end)
end

function NoticeComp:ReadNotice(noticeType, noticeUid, callback)
  local ret = ejoysdk_badge.consume(noticeType, noticeUid)
  if ret and callback then
    callback()
  end
end

return NoticeComp
