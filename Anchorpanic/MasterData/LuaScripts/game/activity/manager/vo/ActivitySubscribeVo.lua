--[[ 
-----------------------------------------------------
@filename       : ActivitySubscribeVo
@Description    : 限时活动数据
@date           : 2023-06-21
@Author         : tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.vo.ActivitySubscribeVo', Class.impl())

function parseData(self, id, data)

    self.id = id
    -- 1 图片  2 外部链接
    self.type = data.type
    -- 链接
    self.url = data.link
    -- 奖励列表
    self.awardItemNum = data.reward[1]
    -- 奖励列表
    self.awardItemTid = data.reward[2]
end



return _M

--[[ 替换语言包自动生成，请勿修改！
]]