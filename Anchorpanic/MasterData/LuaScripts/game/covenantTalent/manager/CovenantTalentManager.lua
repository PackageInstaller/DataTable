--[[ 
-----------------------------------------------------
@filename       : CovenantTalentManager
@Description    : 战盟天赋
@date           : 2021-06-16 17:34:22
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.manager.CovenantTalentManager', Class.impl(Manager))

-- 序列物详细信息更新
UPDATE_ORDER_DETAIL_DATA = 'UPDATE_ORDER_DETAIL_DATA'
-- 序列物选择
COVENANT_TALENT_BAG_EQUIP_SELECT = 'COVENANT_TALENT_BAG_EQUIP_SELECT'
-- 助手基因信息更新
COVENANT_TALENT_HELPER_GENE_UPDATE = 'COVENANT_TALENT_HELPER_GENE_UPDATE'
-- 助手基因升级
COVENANT_TALENT_HELPER_GENE_LV_UP = 'COVENANT_TALENT_HELPER_GENE_LV_UP'


--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    self:init()
end

--初始化
function init(self)
    self.helperGeneDic = {}
    self.helperInfoDic = {}
end

-- 解析基础数据
function parseConfigData(self)
    self.mTalentData = {}
    self.mTalentColData = {}
    local baseData = RefMgr:getData("forces_helper_data")
    for helperId, data in pairs(baseData) do
        if not self.mTalentData[helperId] then
            self.mTalentData[helperId] = {}
        end
        if not self.mTalentColData[helperId] then
            self.mTalentColData[helperId] = {}
        end
        for k, v in pairs(data.helper_tree) do
            local vo = covenantTalent.CovenantTalentBaseVo.new()
            vo:parseData(v)
            self.mTalentData[helperId][vo.id] = vo

            if not self.mTalentColData[helperId][vo.mutex] then
                self.mTalentColData[helperId][vo.mutex] = {}
            end
            table.insert(self.mTalentColData[helperId][vo.mutex], vo)
        end
    end
end

-- 解析装备配置表
function parseOrderDataConfig(self)
    self.mOrderTidDic = {}
    local baseData = RefMgr:getData("order_data")
    for tid, data in pairs(baseData) do
        local vo = covenantTalent.OrderConfigVo.new()
        vo:parseConfigData(tid, data)
        if (not self.mOrderTidDic[tid]) then
            self.mOrderTidDic[tid] = {}
        end
        self.mOrderTidDic[tid] = vo
    end
end

-- 解析基因重组表
function parseForceGeneDataConfig(self)
    self.mForceGeneData = {}
    local baseData = RefMgr:getData("forces_gene_data")
    for id, data in pairs(baseData) do
        self.mForceGeneData[id] = { payCoin = data.pay_coin, payNum = data.pay_coin_num, itemTid = data.pay_item, itemNum = data.pay_item_num }
    end
end

-- 解析所有助手基因信息
function parseAllGeneInfoMsg(self, msg)
    for k, msgData in pairs(msg.all_helper_gene_info) do
        if not self.helperGeneDic[msgData.helper_id] then
            self.helperGeneDic[msgData.helper_id] = {}
        end
        for i, info in ipairs(msgData.gene_info) do
            local vo = covenantTalent.CovenantTalentGeneVo.new()
            vo:parseMsg(info)
            self.helperGeneDic[msgData.helper_id][vo.id] = vo
        end
        self.helperInfoDic[msgData.helper_id] = { usedPoint = msgData.used_gene_point, resetTimes = msgData.reset_gene_times }
    end
    self:dispatchEvent(self.COVENANT_TALENT_HELPER_GENE_UPDATE)
end

-- 解析单个助手基因信息
function parseGeneInfoMsg(self, msg)
    for k, msgData in pairs(msg.helper_gene_info) do
        if not self.helperGeneDic[msgData.helper_id] then
            self.helperGeneDic[msgData.helper_id] = {}
        end
        for i, info in ipairs(msgData.gene_info) do
            local vo = self.helperGeneDic[msgData.helper_id][info.groove_id]
            if not vo then
                vo = covenantTalent.CovenantTalentGeneVo.new()
                self.helperGeneDic[msgData.helper_id][info.groove_id] = vo
            end
            vo:parseMsg(info)
        end
        self.helperInfoDic[msgData.helper_id] = { usedPoint = msgData.used_gene_point, resetTimes = msgData.reset_gene_times }
    end
    self:dispatchEvent(self.COVENANT_TALENT_HELPER_GENE_UPDATE)
end

-- 基因升级返回
function parseGeneLvlUpMsg(self, msg)
    if msg.result == 1 then
        local data = self:getGeneData(msg.helper_id, msg.groove_id)
        data.lvl = msg.gene_lv
    end
    self:dispatchEvent(self.COVENANT_TALENT_HELPER_GENE_LV_UP)
end

-- 势力发生改变，清理天赋缓存
function clearTalentInfo(self)
    self.helperGeneDic = {}
    self.helperInfoDic = {}
end


-- 获取基因重组配置信息
function getForcesGeneData(self, cusId)
    if (not self.mForceGeneData) then
        self:parseForceGeneDataConfig()
    end
    if cusId > 0 and not self.mForceGeneData[cusId] then
        return self.mForceGeneData[table.nums(self.mForceGeneData)]
    end
    return self.mForceGeneData[cusId]
end

-- 根据装备tid获取装备配置
function getOrderConfigVo(self, cusTid)
    if (not self.mOrderTidDic) then
        self:parseOrderDataConfig()
    end
    return self.mOrderTidDic[cusTid]
end

-- 取助手的天赋列表
function getTalentData(self, cusHelperId)
    if not self.mTalentData then
        self:parseConfigData()
    end
    return self.mTalentData[cusHelperId]
end

-- 取助手的天赋列表按列
function getTalentColData(self, cusHelperId)
    if not self.mTalentColData then
        self:parseConfigData()
    end
    return self.mTalentColData[cusHelperId]
end

-- 是否为序列槽位
function isOrderType(self, type)
    if type == 2 or type == 3 or type == 4 then
        return true
    end
    return false
end

-- 取某个助手的一个槽位数据
function getGeneData(self, cusHelperId, cusGeneId)
    if not self.helperGeneDic[cusHelperId] then
        return nil
    end
    return self.helperGeneDic[cusHelperId][cusGeneId]
end

-- 助手科技树的信息
function getHelperInfo(self, cusHelperId)
    return self.helperInfoDic[cusHelperId]
end

-- 获基因最大等级
function getGeneMaxLvl(self, cusHelperId, cusGeneId)
    local data = self:getTalentData(cusHelperId)
    if not data then
        logError(string.format("没有助手%s的配置数据，找策划", cusHelperId), "CovenantTaletnManager")
    end
    local covenantTalentBaseVo = data[cusGeneId]
    local lvl = 0
    for k, v in pairs(covenantTalentBaseVo.skillLvlUp) do
        lvl = math.max(lvl, k)
    end
    return lvl
end

-- 基因是否已经最大等级
function getGeneLvlIsMax(self, cusHelperId, cusGeneId)
    local lvl = self:getGeneMaxLvl(cusHelperId, cusGeneId)
    local data = self:getGeneData(cusHelperId, cusGeneId)
    if data.lvl >= lvl then
        return true
    end
    return false
end

-- 获取助手身上指定的序列物
function getOrderVoInHelper(self, cusHelperId, cusOrderId)
    local data = self:getGeneData(cusHelperId, cusOrderId)
    return data.orderVo
end


-- 获取页签对应的背包道具列表
function getEquipList(self, cusPageType, cusSubType, cusSortData, cusFilterHeroId)
    local propsDic = bag.BagManager:getPropsDic(bag.BagType.Bag)
    local list = {}
    for id, propsVo in pairs(propsDic) do
        if (bag.BagManager:isBelongPage(propsVo, cusPageType)) then
            if cusSubType and cusSubType == propsVo.subType then
                table.insert(list, propsVo)
            end
        end
    end
    local isHeroWear = cusSortData and cusSortData.isHeroWear
    if (isHeroWear) then
        local helperGeneDic = self.helperGeneDic
        for helperId, helperGeneList in pairs(helperGeneDic) do
            if (cusFilterHeroId ~= helperId) then
                if (helperGeneList) then
                    for i, geneVo in pairs(helperGeneList) do
                        if geneVo.orderVo and cusSubType and cusSubType == geneVo.type then
                            table.insert(list, geneVo.orderVo)
                        end
                    end
                end
            end
        end
    end
    if cusSortData then
        -- 是否降序
        local isDescending = cusSortData.isDescending
        local sortList = cusSortData.sortList
        local function _sort(equipVo1, equipVo2)
            if (equipVo1 and equipVo2) then
                for i = 1, #sortList do
                    local sortFun = nil
                    if i == 1 then
                        -- 主排序按实际排序，其他默认升序
                        sortFun = bag.getSortFun(isDescending, sortList[i])
                    else
                        sortFun = bag.getSortFun(true, sortList[i])
                    end

                    local result = sortFun(equipVo1, equipVo2)
                    sortFun = nil
                    if (result ~= nil) then
                        return result
                    end
                end
            end
            return false
        end
        table.sort(list, _sort)
    end
    return list
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
