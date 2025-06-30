module("AwardPackConfigVo", Class.impl())

function parseConfigData(self, cusData)
    self.id = cusData.id
    self.tid = cusData.item_id
    self.num = cusData.item_num
    --掉落展示 1.小概率 2.概率 3.大概率 4.固定
    self.dropShow = cusData.drop_show
end

function getDropShow(self)
    return self.dropShow or 0
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]