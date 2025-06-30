--[[
-----------------------------------------------------
@filename       : OrganizeBackpacksItemVo
@Description    : 整理背包道具数据
@date           : 2024-10-23 10:07:15
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.organizeBackpacks.manager.vo.OrganizeBackpacksItemVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.infoDic = cusData
    self.allVoDic = {}
    self.allPosListDic = {}
    self.allSizeDic = {}
    self.allTargetItemListDic = {}
    for _, vo in pairs(cusData) do
        self.allVoDic[vo.name] = vo
        self.allSizeDic[vo.name] = table.nums(vo.posList)
        if not self.allPosListDic[vo.name] then
            self.allPosListDic[vo.name] = {}
        end
        self.allPosListDic[vo.name] = vo.posList
        self.allTargetItemListDic[vo.name] = vo.targetItem
    end
end

function getALLSize(self)
    local num = 0
    for k, v in pairs(self.allSizeDic) do
        num = num + v
    end
    return num
end

function getSizeByName(self, name)
    return self.allSizeDic[name]
end

function getAllPosDic(self)
    return self.allPosListDic
end

function checkIsHasTarget(self, name)
    return not string.NullOrEmpty(self.allTargetItemListDic[name])
end

function getTargetByName(self, name)
    return self.allTargetItemListDic[name]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
