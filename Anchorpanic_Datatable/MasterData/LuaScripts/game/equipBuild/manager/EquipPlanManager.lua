--[[ 
-----------------------------------------------------
@filename       : EquipPlanManager
@Description    : 模组方案数据管理器
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("equipBuild.EquipPlanManager", Class.impl(Manager))

-- 方案选择刷新
EQUIP_PLAN_SELECT = 'EQUIP_PLAN_SELECT'

--构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__initData()
end

function __initData(self)
    self.mEquipPlanList = nil
    self.mAllEquipPlanIdKey = nil
end

-----------------------------------------------------------------------数据响应 start---------------------------------------------------------------------------
--- 更新获取模组方案信息 12191
function parseMsgEquipPlanListData(self, msg)
    self.mEquipPlanList = {}
    for i = 1, #msg.chip_plan_list do
        local equipPlanVo = LuaPoolMgr:poolGet(equipBuild.EquipPlanVo)
        equipPlanVo:parseData(msg.chip_plan_list[i])
        table.insert(self.mEquipPlanList, equipPlanVo)
    end
    table.sort(self.mEquipPlanList, function(equipPlanVo1, equipPlanVo2) return equipPlanVo1.id > equipPlanVo2.id end)
    GameDispatcher:dispatchEvent(EventName.RES_EQUIP_PLANE_LIST_DATA)
    self:updateAllEquipPlanIdList()
end

--- 更新保存模组方案 12193
function parseMsgEquipPlanSaveResult(self, msg)
    if(msg.result == 1)then
        local equipPlanVo = LuaPoolMgr:poolGet(equipBuild.EquipPlanVo)
        equipPlanVo:parseData(msg.chip_plan_info)
        table.insert(self.mEquipPlanList, 1, equipPlanVo)
        GameDispatcher:dispatchEvent(EventName.RES_EQUIP_PLANE_SAVE, {equipPlanId = equipPlanVo.id})
        gs.Message.Show(_TT(1404)) --"保存成功"
    else
        gs.Message.Show(_TT(1405)) --"保存失败"
    end
    self:updateAllEquipPlanIdList()
end

--- 更新更改模组方案名称 12195
function parseMsgEquipPlanChangeNameResult(self, msg)
    if(msg.result == 1)then
        local equipPlanVo = self:getEquipPlanVo(msg.chip_plan_id)
        if(equipPlanVo)then
            equipPlanVo.name = msg.chip_plan_name
            GameDispatcher:dispatchEvent(EventName.RES_EQUIP_PLANE_CHANGE_NAME, {equipPlanId = equipPlanVo.id})
            gs.Message.Show(_TT(1406)) --"修改成功"
        else
            gs.Message.Show(_TT(1406)) --"修改失败"
        end
    else
        gs.Message.Show(_TT(1407)) --"修改失败"
    end
end

--- 更新删除模组方案 12197
function parseMsgEquipPlanDeleteResult(self, msg)
    if(msg.result == 1)then
        local equipPlanVo = nil
        for i = 1, #self.mEquipPlanList do
            equipPlanVo = self.mEquipPlanList[i]
            if(equipPlanVo.id == msg.chip_plan_id)then
                LuaPoolMgr:poolRecover(table.remove(self.mEquipPlanList, i)) 
                break
            end
        end
        if(equipPlanVo)then
            GameDispatcher:dispatchEvent(EventName.RES_EQUIP_PLANE_DELETE, {equipPlanId = equipPlanVo.id})
            gs.Message.Show(_TT(1408)) --"删除成功"
        else
            gs.Message.Show(_TT(1408)) --"删除失败"
        end
    else
        gs.Message.Show(_TT(1409)) --"删除失败"
    end
    self:updateAllEquipPlanIdList()
end

--- 更新装备模组方案 12199
function parseMsgEquipPlanWearResult(self, msg)
    if(msg.result == 1)then
        local equipPlanVo = nil
        for i = 1, #self.mEquipPlanList do
            equipPlanVo = self.mEquipPlanList[i]
            if(equipPlanVo.id == msg.chip_plan_id)then
                break
            end
        end
        if(equipPlanVo)then
            GameDispatcher:dispatchEvent(EventName.RES_EQUIP_PLANE_WEAR, {equipPlanId = equipPlanVo.id, heroId = msg.hero_id})
            gs.Message.Show(_TT(1410)) --"装备成功"
        else
            gs.Message.Show(_TT(1410)) --"装备失败"
        end
    else
        gs.Message.Show(_TT(1411)) --"装备失败"
    end
    self:updateAllEquipPlanIdList()
end

function getEquipPlanList(self)
    if(not self.mEquipPlanList)then
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_PLANE_LIST_DATA)
    end
    return self.mEquipPlanList or {}
end

function getEquipPlanVo(self, id)
    local equipPlanList = self.mEquipPlanList
    if(equipPlanList)then
        for i = 1, #equipPlanList do
            local equipPlanVo = equipPlanList[i]
            if(equipPlanVo.id == id)then
                return equipPlanVo
            end
        end
    end
    return nil
end

function getHeroId(self)
    return equipBuild.EquipBuildManager:getHeroId()
end

function checkEmptyPlan(self)
    local heroId = self:getHeroId()
    local equipPlanList = self.mEquipPlanList
    if(equipPlanList)then
        local isExist = false
        for i = 1, #equipPlanList do
            local equipPlanVo = equipPlanList[i]
            if(not isExist)then
                isExist = equipPlanVo:equalHeroEquipList(heroId)
                if(isExist)then
                    break
                end
            end
        end
        if(isExist)then
            self:deleteEmptyPlan()
        else
            local equipPlanVo = LuaPoolMgr:poolGet(equipBuild.EquipPlanVo)
            equipPlanVo.id = web.__getTime()
            equipPlanVo.name = self:getEmptyPlanVoDefaultName()
            equipPlanVo.equipPosDic = {}
            local curHeroVo = hero.HeroManager:getHeroVo(heroId)
            if(curHeroVo.equipList)then
                for i = 1, #curHeroVo.equipList do
                    local equipVo = curHeroVo.equipList[i]
                    if(equipVo.subType < PropsEquipSubType.SLOT_7)then
                        equipPlanVo.equipPosDic[equipVo.subType] = equipVo.id
                    end
                end
            end
            self.mEmptyEquipPlanVo = equipPlanVo
        end
    end
end

-- 根据战员穿戴的相关装备获取匹配一致模组方案
function getMatchHeroEquipPlan(self)
    local heroId = self:getHeroId()
    local equipPlanList = self.mEquipPlanList
    if(equipPlanList)then
        for i = 1, #equipPlanList do
            local equipPlanVo = equipPlanList[i]
            local isMatch = equipPlanVo:equalHeroEquipList(heroId)
            if(isMatch)then
                return equipPlanVo
            end
        end
    end
    return nil
end

function getEmptyPlanVoDefaultName(self)
    return _TT(1412)--"当前方案"
end

function getEmptyPlanVo(self)
    return self.mEmptyEquipPlanVo
end

function deleteEmptyPlan(self)
    if(self.mEmptyEquipPlanVo)then
        LuaPoolMgr:poolRecover(self.mEmptyEquipPlanVo) 
        self.mEmptyEquipPlanVo = nil
    end
end

function updateAllEquipPlanIdList(self)
    self.mAllEquipPlanIdKey = ""
    local equipPlanList = self.mEquipPlanList
    if(self.mAllEquipPlanIdKey and equipPlanList)then
        for i = 1, #equipPlanList do
            local dic = equipPlanList[i].equipPosDic
            for pos, equipId in pairs(dic)do
                self.mAllEquipPlanIdKey = self.mAllEquipPlanIdKey .. self:getEquipPlanIdKey(equipId)
            end
        end
    end
end

function getEquipPlanIdKey(self, equipId)
    return "_" .. equipId .. "_"
end

function isInEquipPlan(self, equipVo)
    if(self.mAllEquipPlanIdKey and equipVo)then
        if(string.find(self.mAllEquipPlanIdKey or "", self:getEquipPlanIdKey(equipVo.id)) == nil)then
            return false
        else
            return true
        end
    else
        return false
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
