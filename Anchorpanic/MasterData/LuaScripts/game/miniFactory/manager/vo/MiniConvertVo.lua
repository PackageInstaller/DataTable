--[[ 
-----------------------------------------------------
@filename       : MiniConvertVo
@Description    : 迷你工厂-兑换页面解析
@date           : 2022-03-01 15:11:27
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('miniFactory.MiniConvertVo', Class.impl())

function parmsProduce(self, cusMsg)
    --当前产能值
    self.capacity = cusMsg.speed_material
    --下次自然增加产能的时间戳
    self.nextTime = cusMsg.next_add_time
    --恢复所有产能的时间戳
    self.allTime = cusMsg.all_add_time
    --已购买次数
    self.buyTimes = cusMsg.buy_times
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
