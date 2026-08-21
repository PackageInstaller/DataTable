activityTarget.TabType = {
    One = 1,
    Two = 2,
    Three = 3,
    Four = 4,
    Five = 5,
    Six = 6,
    Seven = 7
}

function activityTarget.getPageName(cusPageType)
    local name = ""

    if (cusPageType == activityTarget.TabType.One) then
        name = _TT(44660)
    elseif (cusPageType == activityTarget.TabType.Two) then
        name = _TT(44661)
    elseif (cusPageType == activityTarget.TabType.Three) then
        name = _TT(44662)
    elseif (cusPageType == activityTarget.TabType.Four) then
        name = _TT(44663)
    elseif (cusPageType == activityTarget.TabType.Five) then
        name = _TT(44664)
    elseif (cusPageType == activityTarget.TabType.Six) then
        name = _TT(44665)
    elseif (cusPageType == activityTarget.TabType.Seven) then
        name = _TT(44666)
    end
    return name
end
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(44666):	"第七天"
	语言包: _TT(44665):	"第六天"
	语言包: _TT(44664):	"第五天"
	语言包: _TT(44663):	"第四天"
	语言包: _TT(44662):	"第三天"
	语言包: _TT(44661):	"第二天"
	语言包: _TT(44660):	"第一天"
]]
