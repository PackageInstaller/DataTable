module("buildBase.BuildBaseMsgVo", Class.impl())

function parseData(self, data)
    self.id = data.building_id
    -- 建筑等级
    self.lv = data.lv
    -- 入驻战员
    self.heroList = data.hero_list
    --生产道具tid 
    self.itemTid = data.item_tid
    -- 可领取的生产资源数量   仓库资源数量
    self.produce = data.produce_num
    --仓库最大数量
    self.maxNum = data.max_num
    -- 生产速率（效率加成后）
    self.speed = data.speed
    -- 生产开始时间
    self.startTime = data.start_time
    -- 下一次生产完成时间
    self.time = data.produce_time
    --生产满级时间
    self.fullTime =  data.full_time
    -- 建筑加成的技能id列表{id,lv}
    self.skillList = {}
    for k,v in pairs(data.skill_list) do
        self.skillList[v.skill_id] = v.skill_lv
    end
end

return _M
