module("props.PropsVo", Class.impl(props.PropsConfigVo))

-- 道具数据更新
UPDATE = 'UPDATE'

function ctor(self)
    self:__init()
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:__init()
    LuaPoolMgr:poolRecover(self)
end

function __init(self)
    -- 唯一id
    self.id = nil
    -- 创建时间戳
    self.createdTime = nil
    -- 数量
    self.count = 0
    -- 过期时间，时间戳（s），入背包后开始计时剩余时间
    self.expiredTime = nil
    -- 限时多久（秒）之后会过期，作为纯显示用，未进包的道具如果进包了多久后会过期
    self.expiredOddTime = nil
    -- 品质
    self.color = nil
    -- 背包类型
    self.bagType = nil
    -- 是否上锁 1是0否
    self.isLock = nil
end

function setTid(self, cusTid)
    local config = props.PropsManager:getPropsConfigVo(cusTid)
    if (not config) then
        Debug:log_error("PropsVo", "通过tid设置时，找不到道具配置：", cusTid)
        return
    end
    self:setConfigData(config)
end

function setConfigData(self, cusConfigVo)
    if (not cusConfigVo) then
        Debug:log_error("PropsVo", "解析道具失败")
        return
    end
    self.tid = cusConfigVo.tid
    self.name = cusConfigVo.name
    self.type = cusConfigVo.type
    self.subType = cusConfigVo.subType
    self.icon = cusConfigVo.icon
    self.color = cusConfigVo.color
    self.des = cusConfigVo.des
    self.maxNum = cusConfigVo.maxNum
    self.isCanBatchUse = cusConfigVo.isCanBatchUse
    self.useLvl = cusConfigVo.useLvl
    self.isCanSell = cusConfigVo.isCanSell
    self.isCanDecompose = cusConfigVo.isCanDecompose
    self.sellType = cusConfigVo.sellType
    self.price = cusConfigVo.price
    self.uiCode = cusConfigVo.uiCode
    
    self.uiCodeList = cusConfigVo.uiCodeList
    self.useUiCodeList = cusConfigVo.useUiCodeList
    self.sort = cusConfigVo.sort

    self.effectType = cusConfigVo.effectType
    self.effectList = cusConfigVo.effectList
    self.isQuickUse = cusConfigVo.isQuickUse
    self.isCanUse = cusConfigVo.isCanUse
end

-- 是否已经过期
function isExpired(self)
    if (self.expiredTime < 1) then
        return false
    end
    return GameManager:getClientTime() > self.expiredTime
end

-- 解析已进包的道具数据
function setPropsBagMsgData(self, cusBagType, pt_prop_bag)
    local configVo = props.PropsManager:getPropsConfigVo(pt_prop_bag.tid)
    if (not configVo) then
        Debug:log_error("PropsVo", "解析已进包的道具数据失败：" .. pt_prop_bag.tid)
        return
    end
    self:setConfigData(configVo)
    self.bagType = cusBagType == nil and bag.BagType.Bag or cusBagType
    self.id = pt_prop_bag.id
    self.createdTime = pt_prop_bag.createdTime
    self.count = pt_prop_bag.count
    self.expiredTime = pt_prop_bag.expiredTime
    self.color = pt_prop_bag.color
    self:setLockState(pt_prop_bag.is_lock)
    GameDispatcher:dispatchEvent(EventName.UPDATE_PROPS_LOCK_STATE,{id = self.id,lock =pt_prop_bag.is_lock }) 
end

-- 解析服务器道具奖励数据
function setPropsAwardMsgData(self, pt_prop_award)
    local configVo = props.PropsManager:getPropsConfigVo(pt_prop_award.tid)
    if (not configVo) then
        Debug:log_error("PropsVo", "解析服务器道具奖励数据失败：" .. pt_prop_award.tid)
        return
    end
    self:setConfigData(configVo)
    self.id = pt_prop_award.id
    self.count = pt_prop_award.count
    self.color = pt_prop_award.color
    self.expiredTime = pt_prop_award.expiredTime
    self.expiredOddTime = pt_prop_award.expiredOddTime
    self:setLockState( pt_prop_award.is_lock)
end

-- 设置奖励展示道具数据(本地奖励包) */
function setAwardPackgeData(self, AwardPackageBaseVo)
    local configVo = props.PropsManager:getPropsConfigVo(AwardPackageBaseVo.tid)
    if (not configVo) then
        Debug:log_error("PropsVo", "设置奖励展示道具数据(本地奖励包)失败：" .. AwardPackageBaseVo.tid)
        return
    end
    self:setConfigData(configVo)
    self.count = AwardPackageBaseVo.num
end

-- 改变道具锁状态
function setLockState(self, cusValue)
    local function _tryParse()
        local isLock = self.isLock
        self.isLock = cusValue
        if isLock ~= nil and isLock ~= cusValue then
            self:dispatchEvent(props.PropsVo.UPDATE)
        end
    end
    local isParseOk, value = pcall(_tryParse)
    
end

function clone(self)
    local vo = LuaPoolMgr:poolGet(self)
    vo:setConfigData(self)

    vo.id = self.id
    vo.createdTime = self.createdTime
    vo.count = self.count
    vo.expiredTime = self.expiredTime
    vo.expiredOddTime = self.expiredOddTime
    vo.color = self.color
    vo.bagType = self.bagType

    return vo
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
