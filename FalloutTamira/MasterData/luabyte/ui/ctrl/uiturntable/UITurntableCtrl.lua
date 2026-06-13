-- baoruichang
-- 2023/6/8 17:24:08
-- UITurntable
local UITurntableCtrl = BaseClass("UITurntableCtrl", BaseUICtrl)
local M = UITurntableCtrl
local tSort = table.sort
local ITEMNUM = 16

function M:Init()
    self._view.btnReward:onClick(Bind(self, self._onClickReward))
    self._view.btnTask:onClick(Bind(self, self._onClickTask))
    self._view.btnThrow:onClick(Bind(self, self._onClickThrow))
end

-- 进入UI，可传参数
function M:OnEnter(activityId)
    self.activityId = activityId
    self.activityTurntableRewards = ConfigHelper.GetCfgsByLua("activityTurntableReward", {activityId=self.activityId})
    tSort(self.activityTurntableRewards, self._Sort)
    for i = 1, ITEMNUM do
        self._view["Item" .. i]:UpdateData(self.activityTurntableRewards[i])
    end
    self:_intNum()
    self:_UpdateNum()
end

function M:_intNum()
    local activityTurntables = ConfigHelper.GetCfgsByLua("activityTurntable", {activityId=self.activityId})
    if not activityTurntables or #activityTurntables <= 0 then
        Logger.LogError("配置表错误")
        return
    end
    self.activityTurntable = activityTurntables[1]

end

function M:_UpdateNum()
    local num = ItemDataMgr:GetInstance():GetItemNumById(self.activityTurntable.costItem1)
    self._view.labNum:SetText(tostring(num))
end

function M:_onClickReward()

end

function M:_onClickTask()
    local exchangeIds = ConfigHelper.GetCfgPropByLua("activity", self.activityId, "relationId")
    if not exchangeIds or #exchangeIds <= 0 then
        Logger.LogError("转盘任务配置错误：" .. self.activityId)
        return
    end
    local activityId = exchangeIds[1]
    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(activityId, Bind(self, self._OnAsynTaskCallBack))
end

function M:_OnAsynTaskCallBack(activityData)
    UIContextMgr:GetInstance():Show(UIDefine.UITurntableTask, activityData)
end

function M._Sort(data1, data2)
    return data1.id < data2.id
end

function M:_onClickThrow()
    Logger.LogError("点击转盘")
    UIContextMgr:GetInstance():Show(UIDefine.UITurntableThrow, self.activityId )
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return UITurntableCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O. = /O
--                        ____/`---'.____
--						  . ' ..| |// `.
--                       / ..||| : |||// .
--                     / _||||| -:- |||||- .
--                       | | ... - --/ | |
--                     | ._| ''.---/'' |_. |
--                     \ .-.\__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 \ \ `-. ._ __. /__ _/ .-` / /
--         ======`-.____`-.___._____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？

