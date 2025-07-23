-- @FileName:   SandPlayFishConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.manager.configVo.SandPlayFishConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.name = cusData.fish_name
    self.head_icon = cusData.head_icon
    self.body_icon = cusData.body_icon
    self.modelName = cusData.model
    self.watersText = cusData.waters
    self.appearing_timeType = cusData.appearing_time -- 0.全天1.早上（6:00到11:59:59）2.中午（12:00到14:00）3.下午（14:00:01到18:00）4.晚上（18:00 到第二天 6:00:00）
    self.struggle_value = cusData.struggle_value --挣扎扣除值
    self.likeBait = cusData.favorite_bait
    self.buoy_move_speed = cusData.buoy_move --浮标移动速度
    self.buoy_length = cusData.buoy_length--浮标长度
    self.begin_buoy = cusData.begin_buoy --初始浮标长度
    self.reward = cusData.reward
    self.stay_time = cusData.stay_time --有效区域停留时间
    self.add_fillAmount = cusData.rate_speed[1] / 100 --钓鱼进度每帧添加多少
    self.reduce_fillAmount = cusData.rate_speed[2] / 100 --钓鱼进度每帧减少多少

end

function getShowDt(self)
    local clientTime = GameManager:getClientTime()
    local clientData = os.date("*t", clientTime)
    if self.appearing_timeType == 0 then
        return 0, 0
    elseif self.appearing_timeType == 1 then
        local start_data = {}
        start_data.year = clientData.year
        start_data.month = clientData.month
        start_data.day = clientData.day
        start_data.hour = 6
        start_data.min = 0
        start_data.sec = 0

        local end_data = {}
        end_data.year = clientData.year
        end_data.month = clientData.month
        end_data.day = clientData.day
        end_data.hour = 11
        end_data.min = 59
        end_data.sec = 59

        return os.time(start_data), os.time(end_data)
    elseif self.appearing_timeType == 2 then
        local start_data = {}
        start_data.year = clientData.year
        start_data.month = clientData.month
        start_data.day = clientData.day
        start_data.hour = 12
        start_data.min = 0
        start_data.sec = 0

        local end_data = {}
        end_data.year = clientData.year
        end_data.month = clientData.month
        end_data.day = clientData.day
        end_data.hour = 14
        end_data.min = 0
        end_data.sec = 0

        return os.time(start_data), os.time(end_data)
    elseif self.appearing_timeType == 3 then
        local start_data = {}
        start_data.year = clientData.year
        start_data.month = clientData.month
        start_data.day = clientData.day
        start_data.hour = 14
        start_data.min = 0
        start_data.sec = 1

        local end_data = {}
        end_data.year = clientData.year
        end_data.month = clientData.month
        end_data.day = clientData.day
        end_data.hour = 18
        end_data.min = 0
        end_data.sec = 0

        return os.time(start_data), os.time(end_data)
    elseif self.appearing_timeType == 4 then
        local start_data = {}
        start_data.year = clientData.year
        start_data.month = clientData.month
        start_data.day = clientData.day
        start_data.hour = 18
        start_data.min = 0
        start_data.sec = 0

        local end_data = {}
        end_data.year = clientData.year
        end_data.month = clientData.month
        end_data.day = clientData.day + 1
        end_data.hour = 6
        end_data.min = 0
        end_data.sec = 0

        return os.time(start_data), os.time(end_data)
    end
end

function getHeadPath(self)
    return "arts/ui/icon/sandPlay/" .. self.head_icon
end

function getBodyPath(self)
    return "arts/ui/icon/sandPlay/" .. self.body_icon
end

return _M
