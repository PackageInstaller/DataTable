require "RoleBehavior.RoleStateName"
local RoleBehaviorCtrl = BaseClass("RoleBehaviorCtrl", Singleton)
local M = RoleBehaviorCtrl

function M:__init()
    self._allGrils = {}
end

function M:_GetGirlKey(id,use)
    return id .."_" .. use
end

--创建通用行为角色，只需要传入开始的行为类型和idle的行为类型  ID 为heroId
function M:CreateCommonGirl(id, showWeapon, startInteractType, idleInteractType,use)
    if not showWeapon then
        showWeapon = false
    end
    if id == 0 then
        return nil
    end

    local heroData = IHeroDataMgr:GetMyHeroDataById(id) --取自己的英雄数据
    if IsNull(heroData)  or use == RoleUse.ChooseBox then --自选箱使用模板
        heroData = IHeroDataMgr:GetHeroDataById(id) --取模板英雄数据
    end
    if IsNull(heroData) then 
        return nil
    end
    
    if use == nil then 
        use = 0 
    end

    if use ~= RoleUse.ChooseBox then --自选箱用英雄ID
        id = heroData:GetSkinId()
    end
    
    local key = self:_GetGirlKey(id,use)
    if self._allGrils[key] then 
        local h = self._allGrils[key]
        h.use = use
        return h
    end

    local showGril = nil
    if use ~= RoleUse.ChooseBox then --自选箱用英雄ID
        showGril = GameHelper.CreateRoleBySkinId(id, showWeapon,false,1)
    else
        showGril = GameHelper.CreateRole(id, showWeapon,false,1)
    end

    local DefaultRoleGirlCtrl = require("RoleBehavior.Ctrls.DefaultRoleGirlCtrl")
    self._allGrils[key] = DefaultRoleGirlCtrl.New(showGril, id, startInteractType, idleInteractType)
    self._allGrils[key]:InitState()
    self._allGrils[key]:AddEvents()
    self._allGrils[key].use = use
    return self._allGrils[key]
end

--创建特定的行为 ID 为heroId
function M:CreateGirl(id, showWeapon, behaviorCtrlClass,use,displayType,...)
    --转为skinId
    local heroData = IHeroDataMgr:GetMyHeroDataById(id) --取自己的英雄数据
    if heroData == nil then
        heroData = IHeroDataMgr:GetHeroDataById(id) --取模板英雄数据
    end

    --return self:CreateGirlBySkinId(heroData:GetSkinId(),showWeapon, behaviorCtrlClass,use,...)


    if not showWeapon then
        showWeapon = false
    end
    if id == 0 then
        return
    end
    if use == nil then 
        use = 0 
    end
    local key = self:_GetGirlKey(id,use)
    if self._allGrils[key] and ( use == 0 or self._allGrils[key].use == use ) then 
        local h = self._allGrils[key]
        h.use = use
        return h
    end
    local mSkinId = heroData:GetSkinId() 
    local showGril = GameHelper.CreateRole(id, showWeapon,nil,displayType)
    self._allGrils[key] = behaviorCtrlClass.New(showGril, mSkinId,...)
    self._allGrils[key]:InitState()
    self._allGrils[key]:AddEvents()
    self._allGrils[key].use = use
    self._allGrils[key].holdWeapon = showWeapon
    return self._allGrils[key]
end

-- 异步创建特定的行为 ID 为heroId
function M:CreateGirlAsync(id, showWeapon, behaviorCtrlClass, use, displayType, onComplete, behaviorTypeBorn,_behaviorTypeIdle,offsetIdx)
    -- 转为skinId
    local heroData = IHeroDataMgr:GetMyHeroDataById(id) -- 取自己的英雄数据
    if heroData == nil then
        heroData = IHeroDataMgr:GetHeroDataById(id) -- 取模板英雄数据
    end
    if not showWeapon then
        showWeapon = false
    end
    if id == 0 then
        if onComplete then
            onComplete()
        end
    end
    if use == nil then
        use = 0
    end
    local key = self:_GetGirlKey(id, use)
    if self._allGrils[key] and (use == 0 or self._allGrils[key].use == use) then
        local h = self._allGrils[key]
        h.use = use
        if onComplete then
            onComplete(h)
        end
    end
    local mSkinId = heroData:GetSkinId()
    local function createCallBack(showGril)
        self._allGrils[key] = behaviorCtrlClass.New(showGril, mSkinId, behaviorTypeBorn,_behaviorTypeIdle,offsetIdx)
        self._allGrils[key]:InitState()
        self._allGrils[key]:AddEvents()
        self._allGrils[key].use = use
        self._allGrils[key].holdWeapon = showWeapon
        if onComplete then
            onComplete(self._allGrils[key])
        end
    end
    GameHelper.CreateRole(id, showWeapon, nil, displayType, createCallBack)
end

-- 创建特定的行为 ID 为皮肤ID
function M:CreateGirlBySkinId(id, showWeapon, behaviorCtrlClass, use, displayType, ...)
    if not showWeapon then
        showWeapon = false
    end
    if id == 0 then
        return
    end
    if use == nil then
        use = 0
    end
    local key = self:_GetGirlKey(id, use)
    if self._allGrils[key] and (use == 0 or self._allGrils[key].use == use) then
        local h = self._allGrils[key]
        h.use = use
        return h
    end
    local showGril = GameHelper.CreateRoleBySkinId(id, showWeapon, false, displayType)
    self._allGrils[key] = behaviorCtrlClass.New(showGril, id, ...)
    self._allGrils[key]:InitState()
    self._allGrils[key]:AddEvents()
    self._allGrils[key].use = use
    self._allGrils[key].holdWeapon = showWeapon
    return self._allGrils[key]
end

-- 创建特定的行为 ID 为皮肤ID
function M:CreateGirlBySkinIdAsync(id, showWeapon, behaviorCtrlClass, use, displayType, onComplete, behaviorTypeBorn,_behaviorTypeIdle,offsetIdx)
    if not showWeapon then
        showWeapon = false
    end
    if id == 0 then
        if onComplete then
            onComplete()
        end
    end
    if use == nil then
        use = 0
    end
    local key = self:_GetGirlKey(id, use)
    if self._allGrils[key] and (use == 0 or self._allGrils[key].use == use) then
        local h = self._allGrils[key]
        h.use = use
        if onComplete then
            onComplete(h)
        end
    end
    local function createCallBack(showGril)
        self._allGrils[key] = behaviorCtrlClass.New(showGril, id, behaviorTypeBorn,_behaviorTypeIdle,offsetIdx)
        self._allGrils[key]:InitState()
        self._allGrils[key]:AddEvents()
        self._allGrils[key].use = use
        self._allGrils[key].holdWeapon = showWeapon
        if onComplete then
            onComplete(self._allGrils[key])
        end
    end
    GameHelper.CreateRoleBySkinId(id, showWeapon, false, displayType, createCallBack)
end

-- 通过英雄删除
function M:RemoveGirlByHeroId(id, use)
    if id == nil or id == 0 then
        return
    end
    local heroData = IHeroDataMgr:GetMyHeroDataById(id) -- 取自己的英雄数据
    if IsNull(heroData) then
        heroData = IHeroDataMgr:GetHeroDataById(id) -- 取模板英雄数据
    end
    if IsNull(heroData) then 
        return 
    end
    local skinId = heroData:GetSkinId()
    self:RemoveGirl(skinId,use)
end

function M:GetRuningNum(id)
    if id == 0 then 
        return 0 
    end
    local num = 0 
    for k,ctrl in pairs(self._allGrils) do 
        local arr = string.split(k,"_")
        local tmpId = arr[1]
        local tmpUse = arr[2]
        if tmpId == tostring(id) then 
            num = num + 1 
        end
    end
    return num
end

--通过皮肤删除
function M:RemoveGirl(id,use)
    if use == nil then 
        use = 0 
    end
    local num = string.len(tostring(id))
    local tmpHeroId = 0 
    local tmpSkinId = 0
    --皮肤 
    if num > 6 then 
        tmpSkinId = id
        tmpHeroId = math.modf(id / 100 )
    else --英雄
        tmpHeroId = id
        tmpSkinId = id * 100 + 1 
    end
    if use == 0 then 
        local deleteArr = {}
        for k,ctrl in pairs(self._allGrils) do 
            local arr = string.split(k,"_")
            local tmpId = arr[1] -- skin or hero
            local tmpUse = arr[2]
            if tmpId == tostring(tmpHeroId) or tmpId == tostring(tmpSkinId) then 
                -- if ctrl then 
                --     ctrl:DestorySelf()
                -- end
                table.insert(deleteArr,k)
            end
        end
        for i = 1 , #deleteArr do 
            local delKey = deleteArr[i]
            local ctrl = self._allGrils[delKey]
            if ctrl then
                ctrl:DestorySelf()
            end
            self._allGrils[delKey] = nil
        end
        return 
    end
    local key = self:_GetGirlKey(tmpHeroId,use)
    local ctrl = self._allGrils[key]
    if ctrl then
        ctrl:DestorySelf()
        self._allGrils[key] = nil
    else
        key = self:_GetGirlKey(tmpSkinId,use)
        ctrl = self._allGrils[key]
        if ctrl then 
            ctrl:DestorySelf()
        end
        self._allGrils[key] = nil
    end
end

function M:RemoveAllGirls()
    for _,ctrl in pairs(self._allGrils) do 
        if ctrl then 
            ctrl:DestorySelf()
        end
    end
    self._allGrils = {}
end

return RoleBehaviorCtrl
