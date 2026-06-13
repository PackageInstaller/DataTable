local LotteryConst = {}

local LuckDrawState = {
    Active = 0, --正常激活状态
    Notice = 1, --预告期
    Overdue = 2, --过期关闭状态
}

LotteryConst.LuckDrawState = LuckDrawState
return LotteryConst