--[[
-----------------------------------------------------
@filename       : OrganizeBackpacksLevelVo
@Description    : 整理背包关卡详细数据
@date           : 2024-10-23 21:25:15
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.organizeBackpacks.manager.vo.OrganizeBackpacksLevelVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.scale = cusData.scale
    self.mItemDic = cusData.itemList
    self.mBagDic={}
    for _, vo in pairs(cusData.info) do
        self.mBagDic[vo.type]=vo
    end
end

function getLevelBagDic(self)
    return self.mBagDic or {}
end

function getLevelItemDic(self)
    return self.mItemDic or {}
end

function getID(self)
    return self.id or ""
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
