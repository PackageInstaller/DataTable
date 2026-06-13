-- baoruichang
-- 2023/6/12 10:25:23
local UITurntableContext = BaseClass("UITurntableContext", BaseContext)
local M = UITurntableContext
local MessageId = Proto.MessageId

function M:Init()
end

function M:Open()
    self.activityId = ActivityDataMgr:GetInstance():GetActivityIdByType(ActivityType.TURNTABLE)
    if self.activityId == 0 then
        return
    end
    self:RequestTurntableInfo()
end

function M:GetActivityId()
    return self.positions
end

--------------------------------------Proto Start-------------------------------------------------------
function M:RequestTurntableInfo()
    self._tempResponseTurntableInfoCallback = NetPack:RegistResponse(MessageId.ResponseTurntableInfo, Bind(self, self._ResponseTurntableInfoCallback))
    local request = {}
    request.ActivityId = self.activityId
    NetPack:SendMessage(MessageId.RequestTurntableInfo, request)
end

function M:_ResponseTurntableInfoCallback(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseTurntableInfo, self._tempResponseTurntableInfoCallback)
    self._tempResponseTurntableInfoCallback = nil
    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self.positions = msg.positions or {}
    self:_Show(self.activityId)
end
--------------------------------------Proto End----------------------------------------------------------

function M:OnClose()
    M.super.OnClose(self)
end

return UITurntableContext
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
--                     | ._| ''\---/'' |_. |
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

