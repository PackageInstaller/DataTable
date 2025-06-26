module("fashion.FashionColorMsgVo", Class.impl())

function parseMsg(self, cusData)
    self.heroTid = cusData.hero_tid
    self.fashionId = cusData.fashion_id
    -- 正在使用的
    self.colorId = cusData.color_id
    -- 已解锁列表
    self.colorList = cusData.color_list
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]