--[[ 
-----------------------------------------------------
@filename       : HeroEleAndOccVo
@Description    : 英雄助战数据
@date           : 2023-4-10 15:56:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroEleAndOccVo", Class.impl())

function parseConfigData(self, cusData)
    self.type = cusData.type
    self.subType = cusData.sub_type
    self.name = cusData.name
    self.explain = cusData.explain
    self.icon = cusData.icon
end

function getName(self)
    return _TT(self.name)
end

function getExplin(self)
    return _TT(self.explain)
end

function getType(self)
    return self.type
end

function getIcon(self)
    if self:getType() == 1 then
        return UrlManager:getMonsterJobSmallIconUrl(self.icon)
    else
        return UrlManager:getHeroEleTypeIconUrl(self.icon)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]