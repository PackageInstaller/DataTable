--[[
-----------------------------------------------------
   @CreateTime:2024/12/11 16:31:22
   @Author:zengweiwen
   @Copyright: (LY)2021 雷焰网络
   @Description:TODO
]]

module("game.dna.manager.DnaManager", Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    self:init()
end

function resetData(self)
    super.resetData(self)
    self:init()
end

function init(self)
    --战员蛋配置 key是战员属性 value是table（key是品质，value是对应configvo）
    self.mEggDataConfigvoDic = nil
    --战员人形态配置 key是唯一id value是对应configvo
    self.mHeroEggDataConfigvoDic = nil
    --蛋图鉴信息
    self.mDnaManualDic = {}
end

-- 解析dna蛋图鉴服务器返回
function parseDnaEggMsg(self, msg)
    if msg.is_init == 1 then
        self.mDnaEggDic = {}
    end
    for _, id in ipairs(msg.hero_egg_list) do
        self.mDnaEggDic[id] = 1
    end
end

---获取配置相关

-- 获取并初始化所有dna蛋配置
function getAllEggDataConfigVo(self)
    if not self.mEggDataConfigvoDic then
        self.mEggDataConfigvoDic = {}
        local egg_data = RefMgr:getData("egg_data")
        for quality, data in pairs(egg_data) do
            for _, subData in pairs(data.ele_type_data) do
                local dnaEggDataConfigVo = dna.DnaEggDataConfigVo.new()
                --以蛋的道具id为唯一索引存储
                dnaEggDataConfigVo:parseConfigData(subData.item_id, subData, quality)
                local dic_qualityEggCfgVo = self.mEggDataConfigvoDic[dnaEggDataConfigVo.hero_ele_type]
                if not dic_qualityEggCfgVo then
                    dic_qualityEggCfgVo = {}
                    self.mEggDataConfigvoDic[dnaEggDataConfigVo.hero_ele_type] = dic_qualityEggCfgVo
                end
                dic_qualityEggCfgVo[quality] = dnaEggDataConfigVo
            end
        end
    end
    return self.mEggDataConfigvoDic
end

-- 获取并初始化所有dna人形配置
function getAllHeroEggDataConfigVo(self)
    if not self.mHeroEggDataConfigvoDic then
        self.mHeroEggDataConfigvoDic = {}
        local hero_egg_data = RefMgr:getData("hero_egg_data")
        for tid, cfg in pairs(hero_egg_data) do
            local dnaHeroEggDataConfigVo = dna.DnaHeroEggDataConfigVo.new()
            dnaHeroEggDataConfigVo:parseConfigData(tid, cfg)
            self.mHeroEggDataConfigvoDic[dnaHeroEggDataConfigVo.tid] = dnaHeroEggDataConfigVo
        end
    end
    return self.mHeroEggDataConfigvoDic
end

--获取dna蛋配置
--根据传入的 战员属性 去获取
function getEggDataCfgVoDicByEleType(self, eleType)
    local allEggDataConfigVo = self:getAllEggDataConfigVo()
    local dic_qualityEggCfgVo = allEggDataConfigVo[eleType]
    if not dic_qualityEggCfgVo then
        logError(string.format("dna蛋egg_data配置错误，没有战员属性为%s的配置", eleType))
    end
    return dic_qualityEggCfgVo
end

--获取dna蛋配置
--根据传入的 品质 去获取
function getEggDataConfigVoListByQuality(self, quality)
    local eggDataCfgVoList = {}
    local allEggDataConfigVo = self:getAllEggDataConfigVo()
    for _, dic_qualityEggCfgVo in pairs(allEggDataConfigVo) do
        for _, eggCfgVo in pairs(dic_qualityEggCfgVo) do
            if eggCfgVo.quality == quality then
                table.insert(eggDataCfgVoList, eggCfgVo)
            end
        end
    end
    return eggDataCfgVoList
end

--获取dna蛋配置
--根据传入的 战员属性 和 蛋品质id 去获取
function getSingleEggDataCfgVoByEleTypeAndQuality(self, eleType, eggQuality)
    local dic_qualityEggCfgVo = self:getEggDataCfgVoDicByEleType(eleType)
    local eggDataCfgVo = dic_qualityEggCfgVo[eggQuality]
    if not eggDataCfgVo then
        logError(string.format("dna蛋egg_data配置错误，没有战员属性为：%s, 蛋品质为：%s的配置", eleType, eggQuality))
    end
    return eggDataCfgVo
end

--获取dna蛋配置
--根据传入的 道具id 去获取
function getSingleEggDataCfgVoByItemId(self, item_id, unPrint)
    local allEggDataConfigVo = self:getAllEggDataConfigVo()
    for _, dic_qualityEggCfgVo in pairs(allEggDataConfigVo) do
        for _, eggCfgVo in pairs(dic_qualityEggCfgVo) do
            if eggCfgVo.item_id == item_id then
                return eggCfgVo
            end
        end
    end
    if not unPrint then
        logError(string.format("没有找到道具id为：%s 的dna蛋egg_data配置", item_id))
    end
    return nil
end

--获取dna人形配置
--根据传入的 id 去获取（id认为是战员id）
--会有空的情况 没有配置代表不允许孵化
function getSingleHeroEggDataConfigVo(self, tid, unPrint)
    local allHeroEggDataConfigVo = self:getAllHeroEggDataConfigVo()
    local heroEggDataCfgVo = allHeroEggDataConfigVo[tid]
    if not heroEggDataCfgVo and not unPrint then
        logError(string.format("dna战员蛋hero_egg_data配置错误，没有id为：%s的配置", tid))
    end
    return heroEggDataCfgVo
end

--获取dna蛋配置
--根据传入的战员唯一id去获取
function getSingleEggDataCfgVoByHeroId(self, heroId)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    local isEgg = heroVo:checkDnaStatus(hero.eggType.egg)
    if not isEgg then
        logError("该战员数据egg_form当前形态并非蛋形")
        return nil
    end
    local eleType = heroVo.eleType
    local egg_id = heroVo.egg_id
    local eggDataCfgVo = self:getSingleEggDataCfgVoByEleTypeAndQuality(eleType, egg_id)
    return eggDataCfgVo
end

--获取dna人形配置
--根据传入的战员唯一id去获取
function getSingleHeroEggDataCfgVoByHeroId(self, heroId)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    local isRole = heroVo:checkDnaStatus(hero.eggType.role)
    if not isRole then
        logError("该战员数据egg_form当前形态并非人形")
        return nil
    end
    local egg_id = heroVo.egg_id
    local heroEggDataCfgVo = self:getSingleHeroEggDataConfigVo(egg_id)
    return heroEggDataCfgVo
end

--获取可选择装备的dna蛋配置列表
--根据传入的战员唯一id去获取
function getSelectWearEggDataCfgVoListByHeroId(self, heroId)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    local eleType = heroVo.eleType
    local dic_qualityEggCfgVo = self:getEggDataCfgVoDicByEleType(eleType)
    local egg_id = heroVo.egg_id or 0
    local list_eggDataCfgVo = {}
    for _, eleEggCfgVo in pairs(dic_qualityEggCfgVo) do
        if eleEggCfgVo.quality > egg_id then
            table.insert(list_eggDataCfgVo, eleEggCfgVo)
        end
    end
    table.sort(list_eggDataCfgVo, function(a, b)
        return a.quality < b.quality
    end)
    return list_eggDataCfgVo
end

--获取蛋的孵化消耗
function getEggBreakCostInfo()
    local param = sysParam.SysParamManager:getValue(SysParamType.DNA_INCUBATION_NEED_PROPS)
    local payData = param[#param]
    local cost_tid_list, pay_id, pay_num = {}, payData[1], payData[2]
    for i = 1, #param - 1 do
        local itemData = param[i]
        table.insert(cost_tid_list, itemData)
    end
    return cost_tid_list, pay_id, pay_num
end

--战员蛋功能是否开启
function checkFuncIsOpen(self, isShowTips)
    local isOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EGG, isShowTips)
    return isOpen
end

--判断这个战员是否满足dna功能的开启条件
function checkHeroDnaFuncOpen(self, heroId, isTips)
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    local litmitValue = sysParam.SysParamManager:getValue(SysParamType.DNA_FUNC_OPEN_PARAM)
    local isOpen = heroVo.militaryRank >= litmitValue
    if not isOpen and isTips then
        gs.Message.Show(_TT(149931, string.getRomanConversion(litmitValue)))
    end
    return isOpen
end

--判断蛋是否是当前属性的最高品质
function checkIsMaxQualityEgg(self, targetEggDataCfgVo)
    local dic_qualityEggCfgVo = self:getEggDataCfgVoDicByEleType(targetEggDataCfgVo.hero_ele_type)
    for _, eggDataCfgVo in pairs(dic_qualityEggCfgVo) do
        if eggDataCfgVo.quality > targetEggDataCfgVo.quality then
            return false
        end
    end
    return true
end

--判断当前dna蛋是否解锁图鉴
function checkDnaEggIsUnlock(self, id)
    return self.mDnaEggDic[id] ~= nil
end

--获取某个战员的dna功能红点状态
function getHeroDnaFuncRedFlag(self, heroVo)
    if not self:checkFuncIsOpen(false) then
        return false
    end
    if not self:checkHeroDnaFuncOpen(heroVo.id, false) then
        return false
    end
    if self:getReadModelRed(heroVo, true) then
        return true
    end

    if self:checkIsCanReplaceEgg(heroVo) then
        return true
    end

    if self:checkIsCanDnaLvlup(heroVo) then
        return true
    end

    return false
end

--判断战员是否可以装备更高级别的蛋
function checkIsCanReplaceEgg(self, heroVo)
    local isNone = heroVo:checkDnaStatus(hero.eggType.none)
    local isEgg = heroVo:checkDnaStatus(hero.eggType.egg)
    if isNone or isEgg then
        local list_eggDataCfgVo = self:getSelectWearEggDataCfgVoListByHeroId(heroVo.id)
        for _, eggDataCfgVo in ipairs(list_eggDataCfgVo) do
            local item_id = eggDataCfgVo.item_id
            if bag.BagManager:checkPropsCountIsEnough(item_id, 1, true) then
                return true
            end
        end
    end
    return false
end

--判断战员当前是否可以升级或者孵化
function checkIsCanDnaLvlup(self, heroVo)
    local isEgg = heroVo:checkDnaStatus(hero.eggType.egg)
    local isRole = heroVo:checkDnaStatus(hero.eggType.role)
    local cost_tid_list, pay_id, pay_num
    if isEgg then
        local eggDataCfgVo = self:getSingleEggDataCfgVoByHeroId(heroVo.id)
        local isFullLevel = eggDataCfgVo:checkIsFullLevel(heroVo.egg_lv)
        local levelData = eggDataCfgVo:getLevelData(heroVo.egg_lv)
        local heroEggDataCfgVo = self:getSingleHeroEggDataConfigVo(heroVo.tid, true)
        local isMaxQualityEgg = self:checkIsMaxQualityEgg(eggDataCfgVo)
        local isFuhua = isFullLevel and heroEggDataCfgVo ~= nil and isMaxQualityEgg
        if isFuhua then
            cost_tid_list, pay_id, pay_num = self:getEggBreakCostInfo()
        else
            if isFullLevel then
               return false 
            end
            cost_tid_list, pay_id, pay_num = levelData.cost_tid_list, levelData.pay_id, levelData.pay_num
        end
        if self:commonCheckItem(cost_tid_list, pay_id, pay_num, false) then
            return true
        end
    elseif isRole then
        local heroEggDataCfgVo = self:getSingleHeroEggDataConfigVo(heroVo.tid)
        if heroEggDataCfgVo:checkIsFullLevel(heroVo.egg_lv) then
           return false 
        end
        local levelData = heroEggDataCfgVo:getLevelData(heroVo.egg_lv)
        cost_tid_list, pay_id, pay_num = levelData.cost_tid_list, levelData.pay_id, levelData.pay_num
        if self:commonCheckItem(cost_tid_list, pay_id, pay_num, false) then
            return true
        end
    end
    return false
end

function getReadModelRed(self, heroVo, noCheckFuncOpen)
    if not noCheckFuncOpen then
        if not self:checkFuncIsOpen(false) then
            return false
        end
        if not self:checkHeroDnaFuncOpen(heroVo.id, false) then
            return false
        end
    end
    if not self:getSingleHeroEggDataConfigVo(heroVo.tid, true) then
       return false 
    end
    return read.ReadManager:isModuleRead(ReadConst.DNA_NEW, 1)
end

function setReadModelRed(self, heroId)
    GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {
        type = ReadConst.DNA_NEW,
        id = 1
    })
end

function commonCheckItem(self, cost_tid_list, pay_id, pay_num, isShowTip)
    local isMoney = MoneyUtil.judgeNeedMoneyCountByTid(pay_id, pay_num, nil, isShowTip)
    if not isMoney then
        return false
    end
    for i, costInfo in ipairs(cost_tid_list) do
        if not bag.BagManager:checkPropsCountIsEnough(costInfo[1], costInfo[2], not isShowTip) then
            return false
        end
    end
    return true
end

return _M
