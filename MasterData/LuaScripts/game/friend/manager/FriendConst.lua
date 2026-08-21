
friend.TabType = {
    -- 好友列表
    LIST = 1,
    -- 推荐好友
    RECOMMEND = 2,
    -- 好友申请
    APPLY = 3,
    -- 黑名单
    BLACK = 4,
}


function friend.getPageName(cusPageType)
    local name = ""
    if (cusPageType == friend.TabType.BLACK) then
        name = _TT(25146)
    elseif (cusPageType == friend.TabType.RECOMMEND) then
        name = _TT(25205)
    elseif (cusPageType == friend.TabType.APPLY) then
        name = _TT(25206)
    end
    return name
end
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25206):	"好友申请"
	语言包: _TT(25205):	"推荐好友"
	语言包: _TT(25146):	"黑名单"
]]
