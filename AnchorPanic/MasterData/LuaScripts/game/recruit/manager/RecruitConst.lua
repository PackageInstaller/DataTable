-- 招募面板页签类型
recruit.RecruitType = {
    -- 高级招募
    RECRUIT_TOP = 1,
    -- 新手招募
    RECRUIT_NEW_PLAYER = 3,
    -- 普通招募
    RECRUIT_COMMON = 2,
    -- 手环研发
    RECRUIT_BRACELETS = 5,
    -- 活动招募
    RECRUIT_ACTIVITY_1 = 6,
    -- 手环活动研发
    RECRUIT_ACTIVITY_2 = 7,
    -- 活动招募
    RECRUIT_ACTIVITY_3 = 8,
}

-- 招募预先判断条件
recruit.RecruitJudge = {
    -- 道具充足
    PROPS_ENOUGH = 1,
    -- 道具不足，商城无出售
    PROPS_NOT_ENOUGH = 2,
    -- 道具不足，商城有出售，且货币充足
    MONEY_ENOUGH = 3,
    -- 道具不足，商城有出售，但货币不足
    MONEY_NOT_ENOUGH = 4,
    -- 道具不足，商城有出售，但购买次数不足
    BUY_TIMES_NOT_ENOUGH = 6,
}
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(563):	"限定研发"
	语言包: _TT(562):	"限定招募"
	语言包: _TT(560):	"手环研发"
]]
