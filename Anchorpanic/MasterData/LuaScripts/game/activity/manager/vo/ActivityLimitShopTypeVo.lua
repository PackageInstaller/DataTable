--[[ 
-----------------------------------------------------
@filename       : ActivityLimitShopTypeVo
@Description    : 限时礼包类型配置解析
@date           : 2024-07-29
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.vo.ActivityLimitShopTypeVo', Class.impl())

function parseData(self, type, data)

    self.type = type
    -- 礼包列表
    self.giftList = data.gift_list
    -- 描述
    self.desc = data.desc
    --开启类型
    self.unlockType = data.unlock_type
    --开启配置
    self.unlockParam = data.unlock_param
end

function getGiftList(self)
    return self.giftList
end

function getDesc(self)
    return _TT(self.desc)
end

function getUnlockParam(self)
    return self.unlockParam
end

function getUnlockType(self)
    return self.unlockType
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]