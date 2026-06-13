-- baoruichang
-- 2023/5/15 10:56:30
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIActivityItemCtrl = BaseClass("UIActivityItemCtrl", CircularScrollViewItem)
local M = UIActivityItemCtrl
local EActivityId = EnumConst.EActivityId

function M:Init()
    self._view:onClick(Bind(self, self._onClick))
end

function M:UpdateItem(data)
    self.data = data
    self._view.labName:SetText(data.name)
    local soundState
    if data.soundId == 0 then
        soundState = false
    else
        soundState = true
    end
    self._view.playerAudio.enabled = soundState
    if self.data.type == ActivityType.SIGN then -- 签到红点
        self._view.redPoint:SetType(0, RedPointConst.LoginAwardChecker)
        self._view.redPoint:SetParam(0, self.data.id)
        self._view.redPoint:Check()
        self._view.redPoint:SetActive(true)
    elseif self.data.type == ActivityType.RES_ACTIVITY_COPY then -- 资源副本红点
        self._view.redPoint:SetType(0, RedPointConst.ResActivityRewardRedPointChecker)
        self._view.redPoint:Check()
        self._view.redPoint:SetActive(true)
    elseif self.data.id == EActivityId.FirstRecharge then -- 首充红点
        self._view.redPoint:SetType(0, RedPointConst.FirseRechargeRedPointChecker)
        self._view.redPoint:Check()
        self._view.redPoint:SetActive(true)
    elseif self.data.id == EActivityId.MonthSign then -- 月签到
        self._view.redPoint:SetType(0, RedPointConst.MonthSignRedPointChecker)
        self._view.redPoint:Check()
        self._view.redPoint:SetActive(true)
    elseif self.data.id == EActivityId.DayEnergy then -- 每日体力领取
        self._view.redPoint:SetType(0, RedPointConst.DayEnergyRedPointChecker)
        self._view.redPoint:Check()
        self._view.redPoint:SetActive(true)
    elseif self.data.id == EActivityId.LevelFund then -- 成长基金
        self._view.redPoint:SetType(0, RedPointConst.LevelFundRedPointChecker)
        self._view.redPoint:Check()
        self._view.redPoint:SetActive(true)
    else
        self._view.redPoint:SetActive(false)
    end
end

function M:GetData()
    if not self.data then
        return
    end
    return self.data
end

function M:SetClick(clickFunc)
    self.clickFunc = clickFunc
end

function M:_onClick()
    if not self.data or not self.clickFunc then
        return
    end
    self.clickFunc(self)
end

function M:GetName()
    return self.data.id
end

function M:SetState(state)
    self._view.uiState:SetState(state)
end

return UIActivityItemCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O\ = /O
--                        ____/`---'\____
--						  . ' \\| |// `.
--                       / \\||| : |||// \
--                     / _||||| -:- |||||- \
--                       | | \\\ - --/ | |
--                     | \_| ''\---/'' | |
--                      \ .-\__ `-` ___/-. /
--                   ___`. .' /--.--\ `. . __
--                ."" '< `.___\_<|>_/___.' >'"".
--               | | : `- \`.;`\ _ /`;.`/ - ` : | |
--                 \ \ `-. \_ __\ /__ _/ .-` / /
--         ======`-.____`-.___\_____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                       一个是阆苑仙葩，
--                       一个是美玉无瑕。
--                       若说没奇缘，
--                       今生偏又遇着他；
--                       若说有奇缘，
--                       如何心事终虚化？
--                       一个枉自嗟呀，
--                       一个空劳牵挂。
--                       一个是水中月，
--                       一个是镜中花。
--                       想眼中能有多少泪珠儿，
--                       怎禁得秋流到冬尽，
--                       春流到夏！

