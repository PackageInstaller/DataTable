-- @FileName:   PutImageDupConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.putImage.manager.vo.PutImageDupConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.name = cusData.name
    self.first_award = cusData.first_award
    self.jigsaw_list = cusData.jigsaw_list
    self.pre_id = cusData.pre_id
    self.bg_img = cusData.bg_img

    if not table.empty(cusData.begin_time) then
        self.begin_time =
        {
            year = cusData.begin_time[1][1],
            month = cusData.begin_time[1][2],
            day = cusData.begin_time[1][3],
            hour = cusData.begin_time[2][1],
            min = cusData.begin_time[2][2],
            sec = cusData.begin_time[2][3],
        }
    end
end

function getImgBgPath(self)
    return "arts/ui/bg/putImage/" .. self.bg_img
end

function getMaxSize(self)
    if self.maxRow == nil or self.maxCol == nil then
        self.maxRow, self.maxCol = 0, 0
        for k, v in pairs(self.jigsaw_list) do
            if v.row > self.maxRow then
                self.maxRow = v.row
            end

            if v.col > self.maxCol then
                self.maxCol = v.col
            end
        end
    end

    return self.maxRow, self.maxCol
end

function isOpen(self)
    if not self.begin_time then
        return true
    end

    local configDt = os.time(self.begin_time)
    local clientDt = GameManager:getClientTime()
    return clientDt >= configDt
end

function getAward(self)
    return AwardPackManager:getAwardListById(self.first_award)
end

function getName(self)
    return self.name
end

return _M
