--[[ 
    充值商品控制器
    @author zzz
]]
module('recharge.RechargeController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    -- 请求充值列表
    GameDispatcher:addEventListener(EventName.REQ_RECHARGE_LIST, self.onReqRechargeListHandler, self)
    -- 请求充值
    GameDispatcher:addEventListener(EventName.REQ_RECHARGE, self.onReqRechargeHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 充值数据 10021
        SC_PAY_DATA = self.onResRechargeListHandler,
    }
end

-- 请求充值数据列表
function onReqRechargeListHandler(self)
    SOCKET_SEND(Protocol.CS_PAY_DATA, nil, Protocol.SC_PAY_DATA)
end

-- 返回充值数据列表
function onResRechargeListHandler(self, msg)
    if msg then
        recharge.RechargeManager:parseRechargeList(msg)
    end
end

-- 充值请求
function onReqRechargeHandler(self, args)
    local RMB = nil
    local itemId = args.itemId
    local type = args.type
    local subType = args.subType
    local itemTitle = args.itemTitle
    local itemName = args.itemName
    local itemDes = args.itemDes
    local successFun = args.successFun
    local failFun = args.failFun
    local list = recharge.RechargeManager:getAllRechargeList(type, subType)
    if (list and #list > 0) then
        for i = 1, #list do
            if (list[i].itemId == itemId) then
                RMB = list[i].RMB
                break
            end
        end
        if (RMB) then
            local moneyType = 1
            web.WebController:reqRecharge(itemId, RMB, moneyType, itemTitle, itemName, itemDes, successFun, failFun)
        else
            print("充值价格有误")
        end
    else
        print("无对应充值列表")
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]