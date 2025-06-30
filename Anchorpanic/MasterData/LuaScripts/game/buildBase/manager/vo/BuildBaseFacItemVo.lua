module("buildBase.BuildBaseFacItemVo", Class.impl())

function parseData(self, id, data)
    self.id = id
    -- 产物
    self.propProps = data.prop_props
    -- 需要材料
    self.requiredProps = data.required_props
    -- 需要金币
    self.requiredCoin = data.required_coin
    -- 需要等级
    self.needLevel = data.need_level
    -- 单个生产时间
    self.needTime = data.need_time
    -- 单个消耗的仓库空间
    self.store = data.single_store
end

return _M
