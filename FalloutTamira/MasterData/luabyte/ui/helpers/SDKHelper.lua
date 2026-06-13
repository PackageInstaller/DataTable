local SDKHelper = {}
local responseRoleRechargeHandle = nil
local notifyRechargeResultHandle = nil
local _callback = nil
local _payCfg = nil
local payCallbackUrl = "http://pub-tpor.planofrebirth.com:5098/recharge/v1/yk"
local _payChannel = 0
local _param
local _isEnablePay = true
local _authHandler = nil
local _authCallback = nil
-- 支付 回调如果成功则是true,否则false
function SDKHelper.Pay(payId, callback)
    if not _isEnablePay then
        GameHelper.Tips(10914)
        return
    end
    _callback = callback
    local cfg = ConfigHelper.GetCfg("pay", payId)
    if cfg == nil then
        GameHelper.Tips("payId = .. " .. payId .. "配置无法在pay中找到")
        return
    end
    if responseRoleRechargeHandle then
        NetPack:UnRegistResponse(Proto.MessageId.ResponseRoleRecharge, responseRoleRechargeHandle)
    end
    -- 仅仅用于直充、直接通过人民币购买星斯石  248元 , 648元等
    if notifyRechargeResultHandle then
        NetPack:UnRegistResponse(Proto.MessageId.NotifyRechargeResult, notifyRechargeResultHandle)
    end

    SDKHelper._ChoosePay(function(payChannel)
        -- 生成订单号
        _payChannel = payChannel
        notifyRechargeResultHandle = nil
        responseRoleRechargeHandle = NetPack:RegistResponse(Proto.MessageId.ResponseRoleRecharge,
            SDKHelper._OnResponseRoleRecharge)
        _payCfg = cfg
        local RequestRoleRecharge = {}
        local ExtData = CS.GameX.GameHelper.GetPayPlaftomParams()
        RequestRoleRecharge.RechargeId = payId
        RequestRoleRecharge.ExtData = ExtData
        print("ExtData:" .. ExtData)
        RequestRoleRecharge.RechargeType = payChannel.value__
        NetPack:SendMessage(Proto.MessageId.RequestRoleRecharge, RequestRoleRecharge)
        SDKHelper._ShowWait(true)
    end, payId)
end

function SDKHelper._ChoosePay(callback, payId)
    local itemId = GameHelper.GetParamter(375)
    local cfg = ConfigHelper.GetCfg("pay", payId)
    local itemData = ItemDataMgr:GetInstance():GetItemById(itemId)
    if itemData and (itemData.Num >= (cfg.truePrice / 100)) then
        GameHelper.ConfirmPopupUI(
            string.format("<size=42>您当前拥有 <color=orange>%sx%d</color> 可使用，是否进行抵扣？</size>", itemData.Name, itemData.Num),
            function(ok)
                if ok then
                    callback(CS.GameX.EPayChannel.Voucher)
                else
                    callback(CS.GameX.EPayChannel.SDK)
                end
            end)
    else
        callback(CS.GameX.EPayChannel.SDK)
    end
    -- SDK支付
    -- if not CS.GameX.GameGlobal.isCustomPay then
    --     --以发货为支付成功
    --     callback(CS.GameX.EPayChannel.SDK)
    --     return
    -- end
    -- UIContextMgr:GetInstance():Show("PayChoose", callback, payId)
end

-- 获得订单号，调用SDK
function SDKHelper._OnResponseRoleRecharge(msgId, result, msg)
    if responseRoleRechargeHandle then
        NetPack:UnRegistResponse(msgId, responseRoleRechargeHandle)
    end

    responseRoleRechargeHandle = nil
    if result ~= 0 then
        SDKHelper._ShowWait(false)
        if _callback then
            _callback(false)
        end
        _callback = nil
        return
    end
    -- 获得订单号之后，调用SDK
    if notifyRechargeResultHandle then
        NetPack:UnRegistResponse(Proto.MessageId.NotifyRechargeResult, notifyRechargeResultHandle)
    end
    notifyRechargeResultHandle = NetPack:RegistResponse(Proto.MessageId.NotifyRechargeResult,
        SDKHelper._OnNotifyRechargeResult)
    local orderId = msg.OrderId
    if orderId == nil or orderId == '' then
        GameHelper.Tips("orderId is nil")
        SDKHelper._ShowWait(false)
        return
    end
    -- 单位是美分 x 0.01后单位变成美元
    local price = tostring(_payCfg.truePrice)
    if CS.GameX.GameGlobal.debugPay then -- 不是sdk登录的话模拟充值
        local RequestGameCmd = {}
        RequestGameCmd.cmdType = protocol.GmCmdType.CMD_RechargeYK
        RequestGameCmd.cmdPara = tostring(orderId)
        NetPack:SendMessage(Proto.MessageId.RequestGameCmd, RequestGameCmd)
        return
    end
    local param = {}
    param.accountId = tostring(NetPack:GetAccountId())
    param.orderId = tostring(orderId)
    local macro = CS.GameX.GameHelper.GetUnityMacro()
    local payId = 0
    if macro == "UNITY_IOS" then
        payId = tostring(_payCfg.payId)
    else
        payId = tostring(_payCfg.androidPayId)
    end
    local name = ConfigHelper.GetLocalString(_payCfg.name)
    param.goodsId = tostring(payId)
    param.orderPrice = tostring(price)
    param.serverId = tostring(NetPack:GetServerId())
    param.produceName = name
    param.produceDesc = name
    param.extension = msg.TransData or ""
    param.OrderInfo = msg.OrderInfo
    _param = param

    --模拟支付
    if macro == "UNITY_EDITOR" then
        GameHelper.PostTestRecharge(tostring(price), tostring(orderId), msg.TransData)
        return
    end

    print("OrderInfo:" .. msg.OrderInfo)
    if msg.RechargeType ~= CS.GameX.EPayChannel.Voucher:ToInt() then --代金券充值不调用SDK
        CS.GameX.GameHelper.SetPayCallbackUrl(payCallbackUrl)
        CS.GameX.GameHelper.Pay(_payChannel, param, SDKHelper._OnPay)
    end
    -- AAAAAAAAAAA
    -- 充值埋点
    local dataValues = { tostring(_payCfg.id), orderId, tostring(price) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.RechargePull, dataValues)
end

-- SDK回调
function SDKHelper._OnPay(isSuc, msg)
    print("支付:" .. tostring(isSuc))
end

function SDKHelper.Submit()
    SubmitData()
end

function SubmitData()
    SDKHelper._ShowWait(false)
    if _param == nil then
        return
    end
    -- 充值埋点
    -- 订单号
    local platform = tostring(CS.GameX.GameHelper.GetPlatform())
    local uuid = ""--CS.XNPlusAdapter.Instance:GetUUID()
    local user_id = tostring(INetPack.accountId)
    local event_code = "pay"
    local order_id = _param.orderId
    local amount = _param.orderPrice * 0.1 -- 毛
    local unit = "元"
    local currency = "RMB"
    local pay_type = tostring(_payChannel.value__) -- 微信支付宝
    local status = "1"
    local id = tostring(_payCfg.id)
    local name = ConfigHelper.GetLocalString(_payCfg.name)
    local data = { platform, uuid, user_id, event_code, order_id, amount, unit, currency, pay_type, status, id, name }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Recharge, data)
    print("发货成功" .. tostring(order_id))
    _param = nil
end

-- 发货
function SDKHelper._OnNotifyRechargeResult(msgId, result, msg)
    if notifyRechargeResultHandle then
        NetPack:UnRegistResponse(Proto.MessageId.NotifyRechargeResult, notifyRechargeResultHandle)
    end
    if result ~= 0 then
        if _callback then
            _callback(false)
        end
        _callback = nil
        return
    end

    if _callback then
        local call = _callback
        -- 显示道具
        GameHelper.ShowGetItemsByItems(msg.Data, function()
            call(true)
        end)
    end
    _callback = nil
    SubmitData()
end

function SDKHelper._ShowWait(isShow)
    if IsNull(INetPack) or IsNull(INetPack.connector) then
        return
    end
    INetPack.connector:SetBlockUIActive(isShow)
end

--授权登录，用于绑定
function SDKHelper.AuthAccount(channel, callback)
    --SDKHelper._ShowWait(true)
    _authCallback = callback
    --local uid = "105273049"
    CS.GameX.GameHelper.AuthAccount(channel, function(uid)
        --失败
        --SDKHelper._ShowWait(false)
        if uid == nil then
            return
        end
        if _authHandler then
            NetPack:UnRegistResponse(Proto.MessageId.ResponseAccountBind, _authHandler)
        end
        _authHandler = NetPack:RegistResponse(Proto.MessageId.ResponseAccountBind, SDKHelper._OnAuthSuc)
        local msgData = {}
        if channel == CS.GameX.EChannel.EChanHYKB then
            msgData.PlatformId = protocol.PlatformId.HYKB
        elseif channel == CS.GameX.EChannel.EChanTap then
            msgData.PlatformId = protocol.PlatformId.TapTap
        end
        msgData.OpenId = uid
        NetPack:SendMessage(Proto.MessageId.RequestAccountBind, msgData)
    end)
end

function SDKHelper._OnAuthSuc(msgId, result, msg)
    if result ~= 0 then
        return
    end
    if _authCallback then
        _authCallback(msg.OpenId)
    end
    _authCallback = nil
end

return SDKHelper
