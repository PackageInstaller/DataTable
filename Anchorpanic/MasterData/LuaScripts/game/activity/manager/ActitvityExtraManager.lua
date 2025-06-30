--[[ 
-----------------------------------------------------
@filename       : ActitvityExtraManager
@Description    : 额外活动管理器
@date           : 2023
@Author         : tonn  
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.ActitvityExtraManager', Class.impl(Manager))

--内部事件  网络协议更新 
UPDATE_SUBCTRIBE_MSG = "UPDATE_SUBCTRIBE_MSG"

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    self.mLimitShopGiftConfigDic = {}
    self.mLimitShopGiftTypeDic = {}
    self.mLimitShopGiftMsgDic = {}
    self.mCarnivalConfigDic = {}
    self.subscribeConfigDic = {}
    self.subscribeMsgDic = {}
    self.allReceived = true
    self.lastAwardTime = 0
    self.isBiliOpen = 0
    self.mCarnivalOpenDay=0
    self.mIsCarnivalRecharge=0
    self.mRecivedAwardList={}
    self.mOpenedUicodeList = {}
    self.mRechargeNiceGiftState=0--0 不可领取 1 可领取 已领取
    self.isInitLimitShopInfo = true
end

--------------------------Config-----------------------------
-- 解析配置表数据
function parseConfig(self)
    self.mBillboardList = {}
    local baseData = RefMgr:getData("concern_gift_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activity.ActivitySubscribeVo)
        vo:parseData(key, data)
        self.subscribeConfigDic[key] = vo
    end
end

function parseActivityLimitShopGiftTypeConfig(self)
    self.mLimitShopGiftTypeDic = {}
    local baseData = RefMgr:getData("limited_gift_type_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activity.ActivityLimitShopTypeVo)
        vo:parseData(key, data)
        self.mLimitShopGiftTypeDic[key] = vo
    end
end

function parseActivityLimitShopGiftConfig(self)
    self.mLimitShopGiftConfigDic = {}
    local baseData = RefMgr:getData("limited_gift_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activity.ActivityLimitShopVo)
        vo:parseData(key, data)
        self.mLimitShopGiftConfigDic[vo.id] = vo
    end
end
--狂欢好礼
function parseActivityCarnivalGiftConfig(self)
    self.mCarnivalConfigDic = {}
    local baseData = RefMgr:getData("activity_pay_sign_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activity.ActivityCarnivalVo)
        vo:parseData(key, data)
        self.mCarnivalConfigDic[vo.id] = vo
    end
end

--------------------------MSG-----------------------------
--狂欢好礼
function getCarnivalGiftConfigList(self)
    local list={}
    if table.nums(self.mCarnivalConfigDic)<=0  then
        self:parseActivityCarnivalGiftConfig()
    end
    for k, v in pairs(self.mCarnivalConfigDic) do
        table.insert(list,v)
    end
    table.sort(list,function (a,b)
        return a:getId()<b:getId()
    end)
    return list
end

--充值好礼充值后的领取是否可领取奖励状态
function getCarnivalIsRechargeCanGetRewardState(self)
    if not self:getIsCarnivalRecharge() then
        return false
    end
    for i, v in ipairs(self:getCarnivalGiftConfigList()) do
        if v:getIsCanRec() then
            return true
        end
    end
    return false
end

--充值好礼活动每日奖励是否可领取状态
function getCarnivalIsCanGetEveryDayRewardState(self)
    return not activity.ActivityManager:checkIsGotDailyReward(activity.ActivityId.Activity_Carnival_Gift)
end

function getCarnivalIsRedState(self)
    local isRechargeCanGetRewardState = self:getCarnivalIsRechargeCanGetRewardState()
    local isCanGetEveryDayRewardState = self:getCarnivalIsCanGetEveryDayRewardState()
    local isCanGetHisFashion = self:getFashionRedInfo()
    return isRechargeCanGetRewardState or isCanGetEveryDayRewardState or isCanGetHisFashion
end

--充值好礼状态
function updateRechargeNiceGiftStateMsg(self, msg)
    if self.mRechargeNiceGiftState~=msg.gain_state  then 
        self.mRechargeNiceGiftState=msg.gain_state
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
        GameDispatcher:dispatchEvent(EventName.UPDATE_RECHARGENICE_GIFT)
    end 
end

--获取充值状态
function getRechargeNcieGiftState(self)
    return self.mRechargeNiceGiftState
end

function getRechargeNcieGiftRed(self)
    return self.mRechargeNiceGiftState==1
end

--狂欢好礼面板信息
function updateRechargeNiceGiftInfoMsg(self, msg)
    if msg then
        self.mCarnivalOpenDay = msg.diff_day
        for i, v in ipairs(msg.gain_list) do
            if not table.indexof(self.mRecivedAwardList,v) then
                table.insert(self.mRecivedAwardList,v)
            end
        end
        self.mIsCarnivalRecharge = msg.is_recharge==1
        GameDispatcher:dispatchEvent(EventName.UPDATE_CARNIVAL_GIFT_INFO)
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    end
end
--狂欢好礼开启天数
function getIsOpenByDay(self,num)
    return self.mCarnivalOpenDay>=num
end
--获取狂欢好礼充值金额
function getIsCarnivalRecharge(self)
    return self.mIsCarnivalRecharge
end

--狂欢好礼当天是否已领取
function getIsRecivedByDay(self,day)
    return table.indexof(self.mRecivedAwardList,day)
end

function getLimitShopTypeConfigDic(self)
    if table.nums(self.mLimitShopGiftTypeDic)<=0 then
        self:parseActivityLimitShopGiftTypeConfig()
    end
    return self.mLimitShopGiftTypeDic
end

function getShopTypeConfigVoByType(self,type)
    local giftID=0
    for i, v in ipairs(self:getLimitShopGiftList()) do
        if v.type== type then
            giftID=v:getId()
            break
        end
    end
    for k, v in pairs(self:getLimitShopTypeConfigDic()) do
        if table.indexof(v:getGiftList(),giftID) then
            return v
        end
    end
    return nil
end

function getLimitShopTypeUnLockParamListByType(self,type)
    local list={}
    for k, typeVo in pairs(self:getLimitShopTypeConfigDic()) do
        if typeVo:getUnlockType()== type then
            list = table.mergeAll(list,typeVo:getUnlockParam())
        end
    end
    return list
end

function getLimitShopGiftList(self)
    if table.nums(self.mLimitShopGiftConfigDic)<=0 then
        self:parseActivityLimitShopGiftConfig()
    end
    local list = {}
    for _, v in pairs(self.mLimitShopGiftMsgDic) do
        if self.mLimitShopGiftConfigDic[v.id] and v.end_time > GameManager:getClientTime() then
            table.insert(list,self.mLimitShopGiftConfigDic[v.id])
        end
    end
    table.sort(list,function (vo1,vo2)
        return vo1.id<vo2.id
    end)
    return list
end

function getFirstShopLimitEndTime(self)
    local minEndTime=0
    for type, typeList in pairs(self:getLimitShopTypeDic()) do
        if (minEndTime<=0  or minEndTime > typeList[1]:getEndTime()) and self:getRemainingBuyNumByType(type)>0 then
            minEndTime = typeList[1]:getEndTime()
        end
    end
    return minEndTime>0 and minEndTime-GameManager:getClientTime() or minEndTime
end

function getLimitShopGiftDic(self)
    if table.nums(self.mLimitShopGiftConfigDic)<=0 then
        self:parseActivityLimitShopGiftConfig()
    end
    return self.mLimitShopGiftConfigDic
end

function getLimitShopTypeDic(self)
    local typeDic={}
    local list = self:getLimitShopGiftList()
    for i, v in ipairs(list) do
        if not typeDic[v.type]  then
            typeDic[v.type]={}
        end
        table.insert(typeDic[v.type],v)
    end
    return typeDic
end

function getRemainingBuyNumByType(self,type)
    local num = 0
    local list = self:getLimitShopTypeDic()[type]
    for i, v in ipairs(list) do
        if v:getIsCanBuy() then
            if v:getBuyType()==1 then
               return 1 
            end
            num=num+1
        end
    end
    return num
end

function getLimitShopTypeList(self)
    local typeList={}
    local typeDic=self:getLimitShopTypeDic()
    for i, v in pairs(typeDic) do
        table.insert(typeList,v)
    end
    table.sort(typeList,function (vo1,vo2)
        if self:getRemainingBuyNumByType(vo1[1].type)<=0 or self:getRemainingBuyNumByType(vo2[1].type)<=0 then
            return self:getRemainingBuyNumByType(vo1[1].type) > self:getRemainingBuyNumByType(vo2[1].type)
        else
            return vo1[1]:getEndTime() < vo2[1]:getEndTime()
        end
    end)
    return typeList
end

function getLimitShopMsgVoById(self,id)
    return self.mLimitShopGiftMsgDic[id] or nil
end
--通过类型获取条件是否符合
function getIsLimitShopTypeParam(self,type,param)
    local list = {}
    if type == activity.LimitShopActivityType.View and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SHOP_LIMIT_GIFT, false) then
        list = self:getLimitShopTypeUnLockParamListByType(type)
        if table.indexof(list,param) and not table.indexof(self.mOpenedUicodeList,param) then
            return true
        end
    end
    return false
end

-- 商店限时礼包面板解析
function parsenLimitShopGiftMsg(self, msg)
    if msg then
        local newType = self:checkNewType(msg.goods_list)
        for _, v in pairs(msg.goods_list) do
            self.mLimitShopGiftMsgDic[v.id] = v
        end
        for i, viewId in ipairs(msg.panel_ids) do
            table.insert(self.mOpenedUicodeList,viewId)
        end
        if msg.is_new_unlock == 1 and newType then
            GameDispatcher:dispatchEvent(EventName.OPEN_LIMIT_SHOP_BUY_PANEL,{type = newType})
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL)
    end
end

function checkNewType(self,list)
    local typeList={}
    local newType=nil
    for i, v in pairs(list) do
        if self:getLimitShopGiftDic()[v.id] and not self.mLimitShopGiftMsgDic[v.id] then
            if not table.indexof(typeList,self:getLimitShopGiftDic()[v.id]) then
                table.insert(typeList,self:getLimitShopGiftDic()[v.id])
            end
        end
    end
    if #typeList>1 then
        table.sort(typeList,function (vo1,vo2)
            return vo1.id>vo2.id
        end) 
    end
    if #typeList>0 then
        newType = typeList[1].type
    end
    return newType
end

--商店限时礼包购买返回
function updateLimitShopGiftMsg(self, msg)
    if msg then
        if self.mLimitShopGiftMsgDic[msg.goods_id] then
            self.mLimitShopGiftMsgDic[msg.goods_id].buy_times = msg.num
        end
        if msg.award_list then
            ShowAwardPanel:showPropsAwardMsg(msg.award_list)
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL)
    end
end

-- Msg
function parsenMsg(self, msg)
    self.isBiliOpen = msg.is_b_open --B站包是否开启功能
    self.lastAwardTime = msg.last_award_time --最后一次领取时间

    if msg and msg.gain_state_list then
        --可领取状态 0-未关注 1-可领取 2-已领取 
        for _, msgVo in pairs(msg.gain_state_list) do
            self.subscribeMsgDic[msgVo.key] = msgVo.value
        end
    else
        logInfo("msg  not_award_list 为空, 后端协议问题 ")
        if not    self.subscribeMsgDic then
            self.subscribeMsgDic = {}
        end
    end
    self:dispatchEvent(self.UPDATE_SUBCTRIBE_MSG)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    self:checkIsAllReceived()
end

-- 更新Msg
function updateMsg(self, msg)
    if msg and msg.id then
        if msg.result == 1 then
            if self.subscribeMsgDic[msg.id] ~= 2 then
                self.subscribeMsgDic[msg.id] = 2  --领取成功
            end
        end
    else
        logInfo("msg  not_award_list 为空, 后端协议问题 ")
        if not    self.subscribeMsgDic then
            self.subscribeMsgDic = {}
        end
    end
    self:dispatchEvent(self.UPDATE_SUBCTRIBE_MSG)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    self:checkIsAllReceived()
end

--------------------------function-----------------------------

--  请求领取 
--  写在管理器里 不放在控制器里了 好拿数据 
function sendReceiveRequest(self, id)
    if id ~= nil then
        if self:getConfigVoById(id) ~= nil then
            local state = self.subscribeMsgDic[id]
            if state == 1 then
                SOCKET_SEND(Protocol.CS_GAIN_CONCERN_GIFT, { id = id })
            elseif state == 2 then
                gs.Message.Show("重复领取")
            elseif state == 0 then
                gs.Message.Show("请先关注")
            end
        else
            logError("此Id不在配置表里，找策划")
        end
    else
        gs.Message.Show("无效Id")
    end
end



--  关注请求
--  
function sendSubscribeRequest(self, id)
    if id ~= nil then
        if self:getConfigVoById(id) ~= nil then
            -- 0 未关注
            if self.subscribeMsgDic[id] then
                if self.subscribeMsgDic[id] == 0 then
                    SOCKET_SEND(Protocol.CS_CONCERN_GIFT_CAN_GAIN, { id = id })
                else
                    gs.Message.Show("已经关注")
                end
            else
                logError("后端数据问题 ,Id 不在后端MSG中")
            end
        else
            gs.Message.Show("此Id不在配置表里")
        end
    else
        gs.Message.Show("无效Id")
    end
end


function getConfigVoById(self, id)
    if next(self.subscribeConfigDic) == nil then
        self:parseConfig()
    end
    return self.subscribeConfigDic[id]
end

function getMsgVoById(self, id)
    return self.subscribeMsgDic[id]
end

function checkIsOpen(self)
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if channelId == sdk.AndroidChannelId.BILI and self.isBiliOpen == 0 then
        -- bilibili包后端控制开放
        return false
    end
    local funcIsOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_SUBSCRIBE, false)
    if funcIsOpen then
        if self:checkIsAllReceived() then
            local clientTime = GameManager:getClientTime()
            local remaidTime = clientTime - self.lastAwardTime
            if remaidTime > 8 * 60 * 60 then
                -- 8小时后关闭
                return false
            end
        end
        return true
    else
        return false
    end
end

-- 是否全部已领取
function checkIsAllReceived(self)
    for _, state in pairs(self.subscribeMsgDic) do
        if state < 2 then
            return false
        end
    end
    return true
end

-- 红点判断
function checkBubble(self)
    if not self:checkIsOpen() then
        return false
    end
    if next(self.subscribeMsgDic) then
        for _, state in pairs(self.subscribeMsgDic) do
            if state == 1 then
                return true
            end
        end
    end
    return false
end


function parseSelectBuyData(self)
    self.mSelectBuyData = {}
    local baseData = RefMgr:getData("select_gift_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activity.ActivitySelectBuyVo)
       
        vo:parseData(key, data)
        table.insert(self.mSelectBuyData,vo)
    end
    table.sort(self.mSelectBuyData,function (vo1,vo2)
        return vo1.id < vo2.id
    end)
end

function getSelectBuyData(self)
    if self.mSelectBuyData == nil then
        self:parseSelectBuyData()
    end

    for i = 1,#self.mSelectBuyData do
        local msgData = self:getSelectGiftMsgData(self.mSelectBuyData[i].id)
        self.mSelectBuyData[i].isBuy = msgData.is_buy
    end

    table.sort(self.mSelectBuyData,function (vo1,vo2)
        if vo1.isBuy ==vo2.isBuy then
            return vo1.id < vo2.id
        else
            return vo1.isBuy < vo2.isBuy
        end
    end)

    return self.mSelectBuyData
end

function getSelectBuyDataById(self,id)
    if self.mSelectBuyData == nil then
        self:parseSelectBuyData()
    end

    for i = 1,#self.mSelectBuyData do
        if self.mSelectBuyData[i].id == id then
            return self.mSelectBuyData[i]
        end
    end

    return nil
end

function updateSelectGiftMsgData(self,msg)
    self.mSelectMsgData = msg.select_gift_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_SELECT_BUY_VIEW)
end

function getSelectGiftMsgData(self,id)
    for i = 1,#self.mSelectMsgData do
        if self.mSelectMsgData[i].id == id then
            return self.mSelectMsgData[i]
        end
    end
    return nil
end

function setIsRMBBuy(self,giftId, isBuy)
    self.needGiftId = giftId
    self.isBuy = isBuy
end

function getIsRMBBuy(self)
    return self.isBuy ,self.needGiftId
end

--自选礼包活动红点
function getSelectGiftIsRedState(self)
    --每日奖励可领取
    local isCanGetEveryDayRewardState = not activity.ActivityManager:checkIsGotDailyReward(activity.ActivityId.SelectBuy)
    return isCanGetEveryDayRewardState
end




--------------------------时装回廊-----------------------------

function parseFashionHisData(self)
    self.mFashionHisData = {}
    local baseData = RefMgr:getData("activity_expired_goods_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activity.ActivityExpiredGoodsVo)
       
        vo:parseData(key, data)
        table.insert(self.mFashionHisData,vo)
    end
    table.sort(self.mFashionHisData,function (vo1,vo2)
        return vo1.sort < vo2.sort
    end)
end

function getFashionHisDataByType(self,type)
    if self.mFashionHisData == nil then
        self:parseFashionHisData()
    end
    local list = {}
    for i = 1, #self.mFashionHisData, 1 do
        if self.mFashionHisData[i].type == type then
            table.insert(list, self.mFashionHisData[i])
        end
    end

    return list
end

function getFashionHisDataById(self,id)
    if self.mFashionHisData == nil then
        self:parseFashionHisData()
    end
    for i = 1, #self.mFashionHisData, 1 do
        if self.mFashionHisData[i].id == id then
            return self.mFashionHisData[i]
        end
    end
    return nil
end

function parseFashionHisBuyMsg(self,args)
    self.mFashionHisBuyMsg = args.buy_list
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_FASHION_HIS_RED)
    --self:updateFashionRedInfo()
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_FASHION_HIS_VIEW)
end

function getFashionRedInfo(self)
    local prefixVersion =
    download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)

    local isShow = StorageUtil:getBool1(prefixVersion .. "hisFashionHisBuy") == true 

    local hisList = self:getFashionHisDataByType(activity.FashionHisType.CarnivalGift)
    if self.mFashionHisBuyMsg == nil then
        return not isShow
    end
    
    local allHave = true
    for i = 1, #hisList, 1 do
        if self:getFashionHisIsBuy(hisList[i].id) == false then
            allHave = false
            break
        end
    end

    return  allHave == false and not isShow
end

function getFashionPermitRedInfo(self)
    local clientTime = GameManager:getClientTime()
    local activityVo = activity.ActivityManager:getActivityVoById(activity.ActivityId.PermitFashionHis)
    if activityVo == nil or activityVo:getEndTime() - clientTime < 0  then
        return false
    end

    local prefixVersion =
    download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey) 

    local isShow = StorageUtil:getBool1(prefixVersion .. "hisFashionHisBuyFashionPermit") == true 

    local hisList = self:getFashionHisDataByType(activity.FashionHisType.FashionPermit)
    if self.mFashionHisBuyMsg == nil then
        return not isShow
    end

    local allHave = true
    for i = 1, #hisList, 1 do
        if self:getFashionHisIsBuy(hisList[i].id) == false then
            allHave = false
            break
        end
    end

    return  allHave == false and not isShow
end

function getFashionHisIsBuy(self,id)
    if self.mFashionHisBuyMsg == nil then
        return false
    end

    return table.indexof01(self.mFashionHisBuyMsg,id) > 0
end


--充值好礼
return _M

--[[ 替换语言包自动生成，请勿修改！
]]