-- 成长基金
-- baoruichang
-- 2023/6/21 11:22:19
local UILevelFundContext = BaseClass("UILevelFundContext", BaseContext)
local M = UILevelFundContext
local MessageId = Proto.MessageId

function M:Init()

end

function M:Open()
    if LevelFundMgr:GetInstance():IsReady() then
        self:_Show()
    else
        GameHelper.TipsById(6297)
    end
end

------------------------------------Start-------------------------------------------
-- 领取成长基金Req
function M:RequestGrowGoldAwards(id, tpe)
    self._tempResponseGrowGoldAwardsCallBack = NetPack:RegistResponse(MessageId.ResponseGrowGoldAwards, Bind(self, self.ResponseGrowGoldAwardsCallBack))
    local request = {}
    request.Id = id
    request.Tpe = tpe
    NetPack:SendMessage(MessageId.RequestGrowGoldAwards, request)
end

-- 领取成长基金Ack
function M:ResponseGrowGoldAwardsCallBack(_, result, msg)
    Logger.Log("Ack")
    NetPack:UnRegistResponse(MessageId.ResponseGrowGoldAwards, self._tempResponseGrowGoldAwardsCallBack)
    self._tempResponseGrowGoldAwardsCallBack = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    LevelFundMgr:GetInstance():UpdateData(msg.AwardMask, msg.AwardMaskPaid)
    self:GetCtrl():RefList()
    local itemDic = {}
    for _, item in ipairs(msg.Awards) do
        local num = itemDic[item.Id] or 0
        itemDic[item.Id] = item.Cnt + num
    end
    GameHelper.ShowGetItems(itemDic)
    RedPointMgr:ForceCheck(RedPointConst.LevelFundRedPointChecker)
end
------------------------------------End-------------------------------------------

function M:OnClose()
    M.super.OnClose(self)
end

return UILevelFundContext
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

