-- 时装类型
fashion.Type = {
    -- 服饰
    CLOTHES = 0,
    -- 武器
    WEAPON = 1,
}

-- 时装状态
fashion.State = {
    -- 未解锁
    LOCK = 0,
    -- 穿戴中
    WEARING = 1,
    -- 已解锁
    UNLOCK = 2,
}

fashion.getTabName = function(cusTabType)
    local name = ""
    if (cusTabType == fashion.Type.CLOTHES) then
        name = _TT(62501) --"服饰"
    elseif (cusTabType == fashion.Type.WEAPON) then
        name = _TT(62504) --"武器"
    end
    return name
end

fashion.getMsgFashionType = function(fashionType)
    if(fashionType == fashion.Type.CLOTHES)then
        return 1
    elseif(fashionType == fashion.Type.WEAPON)then
        return 2
    end
end

fashion.getFashionTypeByMsg = function(msgFashionType)
    if(msgFashionType == 1)then
        return fashion.Type.CLOTHES
    elseif(msgFashionType == 2)then
        return fashion.Type.WEAPON
    end
end
 
--[[ 替换语言包自动生成，请勿修改！
]]
