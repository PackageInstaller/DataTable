module("ExploreArenaVo",Class.impl())

function parseArenaData(self,cusData)
   self.arenaId = cusData.arena_id
   self.heroIdList = cusData.hero_id_list
   self.randEventId = cusData.rand_event_id
   self.endTime = cusData.end_time
   self.state = cusData.state
   self.todayExploreTimes = cusData.today_explore_times
   self.needTime = cusData.need_time

   -- logInfo("服务端返回: [区域id]:<color=green>"..cusData.arena_id.."</color>")
   -- logInfo("服务端返回: [今日已探险次数]:<color=green>"..cusData.today_explore_times.."</color>")
   -- logInfo("服务端返回: [随机出来的事件id]:<color=green>"..cusData.rand_event_id.."</color>")
   -- logInfo("服务端返回: [state]:<color=green>"..cusData.state.."</color> 状态0-未开始1-进行中2-已完成未领取")
   -- logInfo("服务端返回: [开始探险的事件戳]:<color=green>"..cusData.start_time.."</color>")

   -- for i = 1, #self.heroIdList do
   --    local s = "服务端返回: [战员id]:<color=green>"
   --    for i = 1, #self.heroIdList do
   --        s = s.. self.heroIdList[i] .."|"
   --    end
   --    s = s.."</color>"
   --    logInfo(s)
   -- end

end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
