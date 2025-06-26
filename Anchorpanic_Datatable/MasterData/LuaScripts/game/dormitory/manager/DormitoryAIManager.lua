--[[ 
-----------------------------------------------------
@filename       : DormitoryAIManager
@Description    : 宿舍战员ai管理
@date           : 2022-03-02 14:23:23
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.manager.DormitoryAIManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

--初始化
function init(self)
    ---所有生成的站员
    self.mQLiveThingDic = {}
    --当前存在的站员
    self.mQliveThingOld = {}
    self.mQRoleAIDic = {}
end

-- 创建可爱的战员
function createQRoleLive(self, cusHeroTid,finishCall)
    if self.mQLiveThingDic[cusHeroTid] == nil then
        if gs.Application.isEditor then
            dormitory.DormitoryLiveThing = require("game/dormitory/view/DormitoryLiveThing")
        end
        local dormitoryLive = dormitory.DormitoryLiveThing.new()
        dormitoryLive:setModelID(cusHeroTid,finishCall)
        dormitoryLive:setToParent(gs.GameObject.Find(DormitoryCost.SITE_ROOT_LIST[DormitoryCost.SITE_FLOOR]).transform)
        self.mQLiveThingDic[cusHeroTid] = dormitoryLive
        self:createQRoleAI(cusHeroTid, dormitoryLive)
    end

    self.mQliveThingOld[cusHeroTid] = 1
end

--清除旧的站员
function clearOldRoleLive(self)
    for heroTid,dormitoryLive in pairs(self.mQLiveThingDic) do
        if self.mQliveThingOld[heroTid] == nil then 
            if self.mQRoleAIDic[heroTid] then
                self.mQRoleAIDic[heroTid]:poolRecover()
                self.mQRoleAIDic[heroTid] = nil
            end

            dormitoryLive:onRecover()
            self.mQLiveThingDic[heroTid] = nil
        end
    end
    self.mQliveThingOld = {}
end


-- 创建可爱战员ai
function createQRoleAI(self, cusHeroTid, cusLive)
    local cls = self:getAIUtil()
    if not cls then
        return
    end
    local ins = cls:poolGet()
    ins:setData(cusHeroTid, cusLive)
    cusLive:setQRoleAI(ins)
    self.mQRoleAIDic[cusHeroTid] = ins
end

-- 获取可爱战员ai
function getQRoleAI(self, cusHeroTid)
    return self.mQRoleAIDic[cusHeroTid]
end

--获取战员
function getLiveTing(self, liveTid)
    return self.mQLiveThingDic[liveTid]
end

-- 获取对应的可爱战员ai文件
function getAIUtil(self, cusHeroTid)
    local ai = nil
    if cusHeroTid == 3101 then
        ai = require("game/dormitory/manager/ai/DormitoryAI_3101")
    else
        if gs.Application.isEditor then
            dormitory.DormitoryBaseAI = require("game/dormitory/manager/ai/DormitoryBaseAI")
        end
        
        ai = dormitory.DormitoryBaseAI
    end
    return ai
end

-- 移除宿舍里的战员
function removeQRole(self, cusHeroTid)
    local dormitoryLive = self.mQLiveThingDic[cusHeroTid]
    if dormitoryLive then
        dormitoryLive:destroy()
    end
    self.mQLiveThingDic[cusHeroTid] = nil

    local ai = self.mQRoleAIDic[cusHeroTid]
    if ai then
        ai:poolRecover()
    end
    self.mQRoleAIDic[cusHeroTid] = nil
end

-- 移除宿舍里所有的战员
function removeAllQRole(self)
    for k, ai in pairs(self.mQRoleAIDic) do
        if ai then
            ai:poolRecover()
        end
    end
    self.mQRoleAIDic = {}

    for k, dormitoryLive in pairs(self.mQLiveThingDic) do
        if dormitoryLive then
            dormitoryLive:destroy()
        end
    end
    self.mQLiveThingDic = {}
    self.mQliveThingOld = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
