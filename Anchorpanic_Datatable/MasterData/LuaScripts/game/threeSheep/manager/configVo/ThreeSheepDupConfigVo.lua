-- @FileName:   ThreeSheepDupConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.threeSheep.manager.configVo.ThreeSheepDupConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.name = cusData.name
    self.desc = cusData.desc
    self.first_award = cusData.first_award

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

    self.map_list = cusData.map_list--地图列表
    self.pre_id = cusData.pre_id

    self.create_list = cusData.create_list --生成规则{{生成层级,{{卡牌类型，生成数量},{卡牌类型，生成数量}}}}
    self.slot = cusData.slot -- 槽位数量
    self.item_num = cusData.item_num -- 道具数量
    self.star_list = cusData.star_list -- 星级id
end

function getName(self)
    return self.name
end

function getDesc(self)
    return _TT(self.desc)
end

function isOpen(self)
    if not self.begin_time then
        return true
    end

    local configDt = os.time(self.begin_time)
    local clientDt = GameManager:getClientTime()
    return clientDt >= configDt
end

function getPropItemConfig(self, id)
    local langId = {138602, 138603, 138604}
    return {num = self.item_num[id], lanId = langId[id]}
end

return _M
