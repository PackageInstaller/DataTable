--[[
    author:luqucheng
    time:2021-01-13 14:38:47
]]
local AssetFileLoader = CS.Engine.Modules.AssetFileLoader
local ResourceModule = CS.Engine.Modules.ResourceModule
local WaitForSeconds = CS.UnityEngine.WaitForSeconds
local cs_coroutine = import("XLua.cs_coroutine")
local settingMgr = SettingMgr:GetInstance()
local gameUtils = CS.GameUtils
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local AssetFileLoader = CS.Engine.Modules.AssetFileLoader
---@type CriWareUtils
local CriWareUtils =  import('Game.Entry.CriWareUtilsFix')

local ResMgr = {}

ResMgr.ResType = {
    Scene = 1,
    Role = 2,
    FX = 3,
    SFX = 4,
    UI = 5,
    DynamicAtlas = 6,
    AnimatorController = 7,
    Cat = 8,
}

local ws = {
    [ResMgr.ResType.Scene] = 100,
    [ResMgr.ResType.Role] = 20,
    [ResMgr.ResType.FX] = 1,
    [ResMgr.ResType.SFX] = 1,
    [ResMgr.ResType.UI] = 10,
    [ResMgr.ResType.DynamicAtlas] = 10,
    [ResMgr.ResType.AnimatorController] = 10,
    [ResMgr.ResType.Cat] = 10,
}

ResMgr.LoadStatus = {
    Ready = 1,
    Processing = 2,
    Finished = 3,
    Dispose = 4,
}

ResMgr.catModels = nil
ResMgr.roleMoudles = nil
ResMgr.loadQueue = nil
ResMgr.loadingCo = nil
ResMgr.sceneName = nil
ResMgr.sceneLoader = nil
ResMgr.timelines = nil
ResMgr.debug = false

function ResMgr:Init(  )
    self.catModels = {}
    self.roleMoudles = {}
    self.loadQueue = {}
    self.timelines = {}
    self.roleAnimatorControllersLoader = {}
end

function ResMgr:Dispose(  )
    self:MarkAllFinishedToDispose()
    if not BattleViewMgr:NeedUnloadScene() then
        local scenes = self:GetLoadDatas(self.ResType.Scene, ResMgr.LoadStatus.Dispose)
        for i,v in ipairs(scenes) do
            v.status = ResMgr.LoadStatus.Finished
        end
    end
    self:UnloadOldRes()
    -- for i,v in pairs(self.roleMoudles) do
    --     if not isNull(v.loader) then
    --         v.loader:Release(true)
    --         v.loader = nil
    --     end
    -- end
    -- self.roleMoudles = nil
end

function ResMgr:GetTotalProcess(  )
    if not self.loadQueue then
        return 1
    end

    --获取总权重和当前进度权重
    local total = 0
    local now = 0
    for i,v in ipairs(self.loadQueue) do
        local w = self:GetWeight(v.type)
        total  = total + w
        now = now + w * v.process
        if v.process < 1 then
            if self.debug then
                print(v.type, v.data)
            end
        end
    end
    return now / total
end


function ResMgr:GetWeight( t )
    return ws[t] or 1
end

function ResMgr:RequireRes( resType, data, isForce )
    if not isForce then
        for i,v in ipairs(self.loadQueue) do
            if v.type == resType and v.data == data then
                --已经存在
                if v.status == self.LoadStatus.Dispose then
                    --待销毁直接改回完成
                    v.status = self.LoadStatus.Finished
                end
                return
            end
        end
    end
    
    local loadData = {
        type = resType,
        data = data,
        status = self.LoadStatus.Ready,
        process = 0,
    }
    table.insert(self.loadQueue, loadData)
end

function ResMgr:GetReadyLoadDatas( resType )
    return self:GetLoadDatas(resType, ResMgr.LoadStatus.Ready)

end

function ResMgr:GetLoadDatas(resType, status)
    local ds = {}
    for i,v in ipairs(self.loadQueue) do
        if v.type == resType and v.status == status then
            table.insert(ds, v)
            v.status = self.LoadStatus.Processing
        end
    end

    return ds
end

function ResMgr:SetLoadDataFinish( loadData )
    loadData.status = self.LoadStatus.Finished
    loadData.process = 1
end

function ResMgr:RequireRole(roleData)
    --音效
    if self.debug then
        print("RequireRoleSFX")
    end
    self:RequireRoleSFX(roleData)

    if self.debug then
        print("RequireRoleFX")
    end
    --特效
    self:RequireRoleFX(roleData)
   
    if self.debug then
        print("RequireRoleModel")
    end
    --模型
    self:RequireRoleModel(roleData)

    if self.debug then
        print("RequireCatModel")
    end
    --模型
    self:RequireCatModel(roleData)

    if self.debug then
        print("RequireRoleAnimatorController")
    end
    --动画状态机
    self:RequireRoleAnimatorController(roleData)

    if roleData.summons and #roleData.summons > 0 then
        for i,v in ipairs(roleData.summons) do
            self:RequireRole(v)
        end
    end
end

function ResMgr:RequireRoleAnimatorController(roleData)
    local controllerPathList = self:GetRoleAnimatorController(roleData)
    for i,v in ipairs(controllerPathList) do
        self:RequireRes(self.ResType.AnimatorController, v)
    end
end

function ResMgr:RequireRoleModel(roleData)
    self:RequireRes(self.ResType.Role, self:GetModelId(roleData))
end

function ResMgr:RequireCatModel(roleData)
    self:RequireRes(self.ResType.Cat, roleData.skinId)
end

function ResMgr:RequireRoleSFX( roleData )
    local sfx = self:GetRoleSFX(roleData)
    for i,v in ipairs(sfx) do
        self:RequireRes(self.ResType.SFX, v)
    end
end

function ResMgr:RequireRoleFX( roleData )
    local fx = self:GetRoleFX(roleData)
    local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
    for i,v in ipairs(fx) do
        if not Tools.isNullKey(v) then
            --判断是否是绑定骨骼的特效
            --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
            local FXResVo = setting:Get(v)
            --特殊特效和timeline不加载
            if not FXResVo 
                or FXResVo.fxType == Constants.FXType.Special 
                or FXResVo.fxType == Constants.FXType.Timeline 
                or FXResVo.fxType == Constants.FXType.Matcap 
            then
            else
                self:RequireRes(self.ResType.FX, v)
            end
        end
    end
end

function ResMgr:RequireNormalFX(  )
    for i, v in pairs(Constants.BattleCommonFX) do
        self:RequireRes(self.ResType.FX, v)
    end
end

function ResMgr:Unload(loadData)
    local ResType = self.ResType
    local LoadStatus = self.LoadStatus
    if self.debug then
        print("load... Unload", loadData.type, loadData.data)
    end

    if loadData.type == ResType.Role then
        self:UnloadRoleModel(loadData.data)
    elseif loadData.type == ResType.FX then
        self:UnloadFX({loadData.data})
    elseif loadData.type == ResType.SFX then
        self:UnloadSFX({loadData.data})
    elseif loadData.type == ResType.Scene then
        local sceneId = loadData.data
        local setting = settingMgr:GetSetting(AutoIds.IdSetting270, "BattleSceneVo")
        --@RefType [Game.Setting.Vo.BattleSceneVo#BattleSceneVo]
        local battleSceneVo = setting:Get(sceneId)
        local sceneName = battleSceneVo.sceneName
        CS.UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync(sceneName)
        if self.sceneLoader then
            self.sceneLoader:Release(true)
            self.sceneLoader = nil
        end
    elseif loadData.type == ResType.AnimatorController then
        local path = loadData.data
        self:UnloadAnimatorController({path})
    elseif loadData.type == ResType.Cat then
        self:UnloadCatModel(loadData.data)
    end
end

function ResMgr:UnloadRoleRes( roleData )
    local sfx = self:GetRoleSFX(roleData)
    self:UnloadSFX(sfx)
    local fx = self:GetRoleFX(roleData)
    self:UnloadFX(fx)
    local roleModelId = self:GetModelId(roleData)
    self:UnloadRoleModel(roleModelId)
    local controllerPathList = self:GetRoleAnimatorController(roleData)
    self:UnloadAnimatorControllers(controllerPathList)
    self:UnloadCatModel(roleData.skinId)
end

function ResMgr:UnloadBattleScene(  )
    if self.sceneName then
        CS.UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync(self.sceneName)
    end
    if self.sceneLoader then
        self.sceneLoader:Release(true)
        self.sceneLoader = nil
    end
end

function ResMgr:MarkAllFinishedToDispose()
    for i,v in ipairs(self.loadQueue) do
        if v.status == self.LoadStatus.Finished then
            v.status = self.LoadStatus.Dispose
        end
    end
end

function ResMgr:UnloadOldRes()
    for i,v in fipairs(self.loadQueue) do
        if v.status == self.LoadStatus.Dispose then
            self:Unload(v)
            --清除所有已完成记录
            table.remove( self.loadQueue, i )
        end
    end
end

function ResMgr:IsRequire(resType, data)
    for i,v in ipairs(self.loadQueue) do
        if v.status ~= self.LoadStatus.Finished and resType == v.type and v.data == data then
            return true
        end
    end

    return false
end

function ResMgr:StartLoading( onProcess, notAdditive )
    if notAdditive then
        self:UnloadOldRes()
    end

    CS.UnityEngine.Application.backgroundLoadingPriority = CS.UnityEngine.ThreadPriority.High
    cs_coroutine.start(self.LoadFX, self)
    cs_coroutine.start(self.LoadSFX, self)
    cs_coroutine.start(self.LoadRole, self)
    cs_coroutine.start(self.LoadAnimatorController, self)
    cs_coroutine.start(self.LoadCat, self)

    local scenes = self:GetReadyLoadDatas(self.ResType.Scene)
    if #scenes > 1 then
        printError('同时加载超过1个场景!')
    elseif #scenes == 1 then
        cs_coroutine.start(self.LoadScene, self, scenes[1])
    end
 
    cs_coroutine.start(self.LoadDynamicAtlas, self)
    cs_coroutine.start(self.LoadUI, self)


    while true do
        local totalProcess = self:GetTotalProcess()
        if onProcess then
            onProcess(totalProcess)
        end
        if totalProcess >= 1 then
            break
        end
        coroutine.yield()
    end

    CS.UnityEngine.Application.backgroundLoadingPriority = CS.UnityEngine.ThreadPriority.Normal
end

function ResMgr:LoadBundleAsync(resPath)
    if not string.isEmpty(resPath) and not AssetFileLoader.IsBundleResourceExist(resPath) then
        Events.Broadcast(Constants.EventNames.LoadingResourceError, {resPath = resPath})
    end
    return ResourceModule.LoadBundleAsync(resPath, nil, true)
end

function ResMgr:LoadScene(loadData)
    local SceneManagement = CS.UnityEngine.SceneManagement
    local sceneId = loadData.data
    local setting = settingMgr:GetSetting(AutoIds.IdSetting270, "BattleSceneVo")
    --@RefType [Game.Setting.Vo.BattleSceneVo#BattleSceneVo]
    local battleSceneVo = setting:Get(sceneId)
    local sceneName = battleSceneVo.sceneName
    self.sceneName = sceneName
    if self.debug then
        print(sceneName)
    end
    local scene = SceneManagement.SceneManager.GetSceneByName(sceneName)
    if scene and scene.isLoaded then
        --已经加载过了
        self:SetLoadDataFinish(loadData)
        BattleViewMgr:OnLoadSceneFinished()
        return
    end

    local loader = self:LoadBundleAsync("Scenes/".. sceneName ..".unity")
    while not loader.IsSuccess do
        cs_coroutine.yield_return()
    end
    if loader.IsError then
        loader:Release(true)
        return
    end
    if not loader.ResultObject then
        loader:Release(true)
        return
    end
    self.sceneLoader = loader
    --自定义加载进度的逻辑在此处
    local displayProgress = 0
    local toProgress = 100
    --  UIModule.CheckScene( "Assets/Scene/"..sceneName..".unity" )
    ---@type UnityEngine.AsyncOperation
    local operation = SceneManager.LoadSceneAsync(sceneName, SceneManagement.LoadSceneMode.Additive)
    operation.allowSceneActivation = false
    if not operation.isDone then
        while operation.progress < 0.8 do
            loadData.process = operation.progress
            coroutine.yield()
        end
        operation.allowSceneActivation = true

        while not operation.isDone do
            coroutine.yield()
        end
        operation.allowSceneActivation = true

        while not operation.isDone do
            coroutine.yield()
        end
        self:SetLoadDataFinish(loadData)
        BattleViewMgr:OnLoadSceneFinished()

    end
end

function ResMgr:GetModelId( roleData )
    local modelId = Core:GetModleId(roleData.skinId)
    return modelId
end

function ResMgr:LoadRole()
    local setting = settingMgr:GetSetting(AutoIds.IdSetting274, "ModelVo")

    local roles = self:GetReadyLoadDatas(self.ResType.Role)
    if #roles <= 0 then
        return
    end
    local sw = CS.System.Diagnostics.Stopwatch()
    sw:Start()
    local loaders = {}
    for i,v in ipairs(roles) do
        local modelId = v.data
        --@RefType [Game.Setting.Vo.ModelVo#ModelVo]
        local modelVo = setting:Get(modelId)
        if modelVo and not self.roleMoudles[modelId] then
            local loader = self:LoadBundleAsync("Arts/Prefab/" .. modelVo.modelRes .. ".prefab")
            table.insert(loaders, {loader = loader, loadData = v, modelVo = modelVo, modelId = modelId})
        else
            self:SetLoadDataFinish(v)
        end
    end

    while #loaders > 0 do
        for i,v in fipairs(loaders) do
            local loader = v.loader
            if loader.IsSuccess then
                if not loader.IsError then
                    self.roleMoudles[v.modelId] = {
                        loader = loader,
                        modelVo = v.modelVo
                    }
                end
                self:SetLoadDataFinish(v.loadData)
                table.remove( loaders, i )
            end
        end
        coroutine.yield()
    end
    sw:Stop()
    if self.debug then
        print("load... role", sw.ElapsedMilliseconds)
    end
end

function ResMgr:UnloadRoleModel( modelId )
    local moudle = self.roleMoudles[modelId]
    if not moudle then
        return
    end
    if self.debug then
        print("UnloadRoleModel", modelId)
    end
    moudle.loader:Release(true)
    moudle.loader = nil
    self.roleMoudles[modelId] = nil
end

function ResMgr:LoadCat()
    local setting = settingMgr:GetSetting(AutoIds.IdSetting113, "CardSkinVo")

    local cats = self:GetReadyLoadDatas(self.ResType.Cat)
    if #cats <= 0 then
        return
    end
    local sw = CS.System.Diagnostics.Stopwatch()
    sw:Start()
    local loaders = {}
    for i,v in ipairs(cats) do
        local skinId = v.data
        --@RefType [Game.Setting.Vo.ModelVo#ModelVo]
        local skinVo = setting:Get(skinId)
        if skinVo
        and skinVo.isMonster == 0                   -- 是猫娘
        and not string.isEmpty(skinVo.catPrefab)    -- 有猫模型
        and not self.catModels[skinId] then
            local prefabName = string.gsub(skinVo.catPrefab, "lobby", "battle")
            local prefabPath = string.format("Arts/Prefab_battle/Cat/%s.prefab", prefabName)
            local loader = self:LoadBundleAsync(prefabPath)
            table.insert(loaders, {loader = loader, loadData = v, skinVo = skinVo, skinId = skinId})
        else
            self:SetLoadDataFinish(v)
        end
    end

    while #loaders > 0 do
        for i,v in fipairs(loaders) do
            local loader = v.loader
            if loader.IsSuccess then
                if not loader.IsError then
                    self.catModels[v.skinId] = {
                        loader = loader,
                        skinVo = v.skinVo
                    }
                end
                self:SetLoadDataFinish(v.loadData)
                table.remove( loaders, i )
            end
        end
        coroutine.yield()
    end
    sw:Stop()
    if self.debug then
        print("load... cat", sw.ElapsedMilliseconds)
    end
end

function ResMgr:UnloadCatModel(skinId)
    local model = self.catModels[skinId]
    if not model then
        return
    end
    if self.debug then
        print("UnloadCatModel", skinId)
    end
    model.loader:Release(true)
    model.loader = nil
    self.catModels[skinId] = nil
end

function ResMgr:LoadFX()
    --加载特效
    local fx = self:GetReadyLoadDatas(self.ResType.FX)
    if #fx <= 0 then
        return
    end
    if self.debug then
        print("load... fx num", #fx)
    end
    local sw = CS.System.Diagnostics.Stopwatch()
    sw:Start()
    local totalTime = 0
    local time = 0
    local loaders = {}

    local setting = settingMgr:GetSetting(AutoIds.IdSetting566, "FXResVo")
    for i, v in ipairs(fx) do
        if not Tools.isNullKey(v.data) then
            --判断是否是绑定骨骼的特效
            --@RefType [Game.Setting.Vo.FXResVo#FXResVo]
            local FXResVo = setting:Get(v.data)
            --特殊特效和timeline不加载
            if not FXResVo 
                or FXResVo.fxType == Constants.FXType.Special 
                or FXResVo.fxType == Constants.FXType.Timeline 
                or FXResVo.fxType == Constants.FXType.Matcap 
            then
                self:SetLoadDataFinish(v)
            else
                xTry(function ()
                    local loader = ResourceModule.LoadBundleAsync(CS.GameUtils.GetEffectFullPath(FXResVo.resourcesId), nil, true)
                    -- local loader = self:LoadBundleAsync(CS.GameUtils.GetEffectFullPath(FXResVo.resourcesId))
                    table.insert(loaders, {loader = loader, loadData = v})
                end, function ()
                    self:SetLoadDataFinish(v)
                end)
            end
        else
            self:SetLoadDataFinish(v)
        end
    end

    local NativeFXMgr = CS.Game.Native.ParticleManager.Instance
    while #loaders > 0 do
        for i,v in fipairs(loaders) do
            local loader = v.loader
            if loader.IsSuccess or loader.IsError  then
                if not loader.IsError then
                    NativeFXMgr:StorePoolParticle(v.loadData.data, loader)
                end
                self:SetLoadDataFinish(v.loadData)
                table.remove( loaders, i )
            end
        end
        coroutine.yield()
    end
    sw:Stop()
    if self.debug then
        print("load... fx", sw.ElapsedMilliseconds)
    end
end

function ResMgr:UnloadFX(fxIds)
    local NativeFXMgr = CS.Game.Native.ParticleManager.Instance
    for i,v in ipairs(fxIds) do
        if not Tools.isNullKey(v) then
            NativeFXMgr:RemovePoolParticle(v)
        end
    end
end

function ResMgr:LoadSFX()

    local sfx = self:GetReadyLoadDatas(self.ResType.SFX)
    if #sfx <= 0 then
        return
    end
    --移除所有不存在的id
    --local s = {}
    for i,v in ipairs(sfx) do
        if not Tools.isNullKey(v.data) then
            --table.insert(s, v.data)
            CriWareUtils.PrepareSheetById(v.data)
        end
    end
    BattleViewMgr.battleUI:PrepareAudioSheet()  -- 预热UI音效
    --local sw = CS.System.Diagnostics.Stopwatch()
    --sw:Restart()
    --print(table.toString(s,"sfx"))
    --for _, v in pairs(s) do
    --    CriWareUtils.PrepareSheetById(v)
    --end
    --sw:Stop()
    --print("load... sfx", sw.ElapsedMilliseconds)

    for i, v in ipairs(sfx) do
        self:SetLoadDataFinish(v)
    end
end

function ResMgr:UnloadSFX( sfx )
    for i, v in pairs(sfx) do
        CriWareUtils.RemoveCueSheetById(v)
    end
end

function ResMgr:LoadAnimatorController(  )
    local loadDatas = self:GetReadyLoadDatas(self.ResType.AnimatorController)
    if #loadDatas <= 0 then
        return
    end
    local loadInfo = {}
    for i, loadData in ipairs(loadDatas) do
        local path = loadData.data
        if not string.isEmpty(path) and not AssetFileLoader.IsBundleResourceExist(path) then
            printError(string.format("资源不存在 %s", path))
            self:SetLoadDataFinish(loadData)
        else
            local loader = ResourceModule.LoadBundleAsync(path, nil, true)
            table.insert(loadInfo, {loader = loader, loadData = loadData})
        end
    end

    while #loadInfo > 0 do
        for i,v in fipairs(loadInfo) do
            local loadData = v.loadData
            local loader = v.loader
            if loader.IsSuccess or loader.IsError  then
                if not loader.IsError then
                    self.roleAnimatorControllersLoader[loadData.data] = loader
                end
                self:SetLoadDataFinish(loadData)
                table.remove( loadInfo, i )
            end
        end
        coroutine.yield()
    end
end

function ResMgr:UnloadAnimatorController( controllerPathList )
    for i, path in ipairs(controllerPathList) do
        local loader = self.roleAnimatorControllersLoader[path]
        if isNotNull(loader) then
            loader:Release()
            self.roleAnimatorControllersLoader[path] = nil
        end
    end
end

function ResMgr:LoadDynamicAtlas(  )
    local atlas = self:GetReadyLoadDatas(self.ResType.DynamicAtlas)
    if #atlas > 0 then
        BattleViewMgr.battleUI:CreaterDynamicAtlas()
    end
    for i,v in ipairs(atlas) do
        self:SetLoadDataFinish(v)
    end
end

function ResMgr:LoadUI(  )
    local ui = self:GetReadyLoadDatas(self.ResType.UI)
    if #ui > 0 then
        BattleViewMgr.battleUI:InitComponent()
    end
    for i,v in ipairs(ui) do
        self:SetLoadDataFinish(v)
    end
end

--@rs: [Game.BattleView.Entity.RoleView#RoleView<>]
function ResMgr:GetRoleFX(roleData)
    local fx = {}
    local addSkillFx = function(skill, skillShowId, isSPSkill)
        --@RefType [Game.Battle.Core.Skill#Skill]
        local skill = skill
        -- print("GetProLoadFX", "skillId", skill.skillId, " skillShowId",skillShowId)
        local setting = settingMgr:GetSetting(AutoIds.IdSetting272, "SkillViewVo")
        --@RefType [Game.Setting.Vo.SkillViewVo#SkillViewVo]
        local skillViewVo = setting:Get(skillShowId)
        fx = table.link(fx, skillViewVo.attackFXs)
        table.link(fx, skillViewVo.aoeHitFX)
        table.link(fx, skillViewVo.hitFX)
        for j, bId in ipairs(skillViewVo.projectileIds) do
            --子弹
            -- print(projectileId)
            local setting2 = settingMgr:GetSetting(AutoIds.IdSetting275, "BulletVo")
            --@RefType [Game.Setting.Vo.BulletVo#BulletVo]
            local bulletVo = setting2:Get(bId)
            if bulletVo then
                table.insert(fx, bulletVo.FX)
            end
        end

        --效果
        local skillEffects = {}
        local buffs = {}
        local showIds = {}
        for i, v in ipairs(skill.subEffects) do
            if not Tools.isNullKey(v.effectId) then
                if v.effectType == Constants.EffectType.Buff then
                    table.insert(buffs, v.effectId)
                elseif v.effectType == Constants.EffectType.SkillEffect then
                    table.insert(skillEffects, v.effectId)
                end
            end
        end
        if not Tools.isNullKey(skill.damageEffect) then
            if skill.damageEffectType == Constants.EffectType.Buff then
                table.insert(buffs, skill.damageEffect)
            elseif skill.damageEffectType == Constants.EffectType.SkillEffect then
                -- table.insert(skillEffects, skill.damageEffect)
                -- 大招主效果
                local effectData = Core:GetSkillEffectData(skill.damageEffect, skill.star, skill.lv, isSPSkill, true)
                if effectData then
                    table.insert(showIds, effectData.showId)
                end
            end
        end

        for i, v in ipairs(skillEffects) do
            local effectData = Core:GetSkillEffectData(v, skill.star, skill.lv, isSPSkill, false)
            if effectData then
                table.insert(showIds, effectData.showId)
            end
        end
        for i, v in ipairs(buffs) do
            local buffData = Core:GetBuffData(v, skill.star, skill.lv)
            if buffData then
                table.link(showIds, buffData.showIds)
            end
        end

        for i, v in ipairs(showIds) do
            local setting3 = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
            --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
            local skillEffectViewVo = setting3:Get(v)
            if skillEffectViewVo then
                --多加载几次
                table.insert(fx, skillEffectViewVo.addFX)
                table.insert(fx, skillEffectViewVo.buffLoopFX)
                table.insert(fx, skillEffectViewVo.buffRemoveFX)
                table.insert(fx, skillEffectViewVo.buffTriggerFX)
            end
        end
    end

    local modelId = self:GetModelId(roleData)
    --获取模型id
    for k,skillCardId in pairs(roleData.generalSkills) do
        if not Tools.isNullKey(skillCardId) then

            --从技能牌去寻找
            local skillCardVo = Core:GetSkillCardData(skillCardId)
            for j, skillId in ipairs(skillCardVo.orginSkills) do
                if not Tools.isNullKey(skillId) then
                    local skillData = Core:GetSkillData(skillId, j, 1)
                    local skillShowId = string.format("4%d%d", skillData.action, modelId)
                    addSkillFx(skillData, skillShowId, false)
                end
            end

            for j, skillIds in ipairs(skillCardVo.overSkills) do
                for i, skillId in ipairs(skillIds) do
                    local skillData = Core:GetSkillData(skillId, j, 1)
                    local skillShowId = string.format("4%d%d", skillData.action, modelId)
                    addSkillFx(skillData, skillShowId, false)
                end
            end
        end

        -- if not Tools.isNullKey(v) then
        --     local s = Core:GetSkillData(v, 1, 1)
        --     local skillShowId = string.format("4%d%d", tonumber(k), modelId)
        --     addSkillFx(Core:GetSkillData(v, s.skillStarMax, 1), skillShowId)
        -- end
    end
    --大招
    local ultraInfo = Tools.splitToNum(roleData.finalSkills, '=')
    local skillCardId = ultraInfo[1]
    local star = ultraInfo[2]
    if not Tools.isNullKey(skillCardId) then
        local ultraSkillCardVo = Core:GetSkillCardData(skillCardId)
        local skillOriginId = ultraSkillCardVo.orginSkills[1]
        local skillOverId = ultraSkillCardVo.overSkills[1][1]
        if not Tools.isNullKey(skillOriginId) then
            local skillData = Core:GetSkillData(skillOriginId, star, 1)
            local skillShowId = string.format("4%d%d", skillData.action, modelId)
            addSkillFx(skillData, skillShowId, true)
        end
        if not Tools.isNullKey(skillOverId) then
            local skillData = Core:GetSkillData(skillOverId, star, 1)
            local skillShowId = string.format("4%d%d", skillData.action, modelId)
            addSkillFx(skillData, skillShowId, true)
        end
    end

    local skinData = Core:GetSkinData(roleData.skinId)
    if skinData and not Tools.isNullKey(skinData.enterFX) then
        table.insert(fx, skinData.enterFX)
    end

    return fx
end

--@rs: [Game.BattleView.Entity.RoleView#RoleView<>]
function ResMgr:GetRoleSFX(roleData)
    if not roleData then
        return
    end
    local sfx = {}
    local modelId = self:GetModelId(roleData)

    local addSkillSFX = function(skill)
        local skillShowId = string.format("4%d%d", skill.action, modelId)
        --@RefType [Game.Battle.Core.Skill#Skill]
        local skill = skill
        if self.debug then
            print("GerProLoadSFX", "skillId", skill.skillId, " skillShowId",skillShowId)
        end
        local setting = settingMgr:GetSetting(AutoIds.IdSetting272, "SkillViewVo")
        --@RefType [Game.Setting.Vo.SkillViewVo#SkillViewVo]
        local skillViewVo = setting:Get(skillShowId)
        table.insert(sfx, skillViewVo.attackSFX)
        table.insert(sfx, skillViewVo.hitSFX)
        table.insert(sfx, skillViewVo.readySFX)

        --效果
        local effects = { skill.damageEffect, skill.effect1, skill.effect2, skill.effect3 }
        for i, v in ipairs(effects) do
            local setting3 = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
            --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
            local skillEffectViewVo = setting3:Get(v)
            if skillEffectViewVo then
                --多加载几次
                table.insert(sfx, skillEffectViewVo.addSFX)
            end
        end
    end

    --获取模型id
    --获取模型id
    for k,skillCardId in pairs(roleData.generalSkills) do
         --从技能牌去寻找
        if not Tools.isNullKey(skillCardId) then
            local skillCardVo = Core:GetSkillCardData(skillCardId)
            for j, skillId in ipairs(skillCardVo.orginSkills) do

                if not Tools.isNullKey(skillId) then
                    local skillData = Core:GetSkillData(skillId, j, 1)
                    addSkillSFX(skillData)
                end
            end

            for j, skillIds in ipairs(skillCardVo.overSkills) do
                for i, skillId in ipairs(skillIds) do
                    local skillData = Core:GetSkillData(skillId, j, 1)
                    addSkillSFX(skillData)
                end
            end
        end
        -- if not Tools.isNullKey(v) then
        --     local s = Core:GetSkillData(v, 1, 1)
        --     local skillShowId = string.format("4%d%d", tonumber(k), modelId)
        --     addSkillSFX(Core:GetSkillData(v, s.skillStarMax, 1), skillShowId)
        -- end
    end
    --大招
    local ultraInfo = Tools.splitToNum( roleData.finalSkills, '=')
    local skillCardId = ultraInfo[1]
    local star = ultraInfo[2]
    if not Tools.isNullKey(skillCardId) then
        local ultraSkillCardVo = Core:GetSkillCardData(skillCardId)
        local skillOriginId = ultraSkillCardVo.orginSkills[1]
        local skillOverId = ultraSkillCardVo.overSkills[1][1]
        if not Tools.isNullKey(skillOriginId) then
            local skillData = Core:GetSkillData(skillOriginId, star, 1)
            addSkillSFX(skillData)
        end
        if not Tools.isNullKey(skillOverId) then
            local skillData = Core:GetSkillData(skillOverId, star, 1)
            addSkillSFX(skillData)
        end
    end
    
    return sfx
end

function ResMgr:GetRoleAnimatorController(roleData)
    local controllerPathList = {}
    local addSkillFx = function(skill, skillShowId, isSPSkill)
        --@RefType [Game.Battle.Core.Skill#Skill]
        local skill = skill

        --效果
        local skillEffects = {}
        local buffs = {}
        local showIds = {}
        for i, v in ipairs(skill.subEffects) do
            if not Tools.isNullKey(v.effectId) then
                if v.effectType == Constants.EffectType.Buff then
                    table.insert(buffs, v.effectId)
                elseif v.effectType == Constants.EffectType.SkillEffect then
                    table.insert(skillEffects, v.effectId)
                end
            end
        end
        if not Tools.isNullKey(skill.damageEffect) then
            if skill.damageEffectType == Constants.EffectType.Buff then
                table.insert(buffs, skill.damageEffect)
            elseif skill.damageEffectType == Constants.EffectType.SkillEffect then
                -- table.insert(skillEffects, skill.damageEffect)
                -- 大招主效果
                local effectData = Core:GetSkillEffectData(skill.damageEffect, skill.star, skill.lv, isSPSkill, true)
                if effectData then
                    table.insert(showIds, effectData.showId)
                end
            end
        end

        for i, v in ipairs(skillEffects) do
            local effectData = Core:GetSkillEffectData(v, skill.star, skill.lv, isSPSkill, false)
            if effectData then
                table.insert(showIds, effectData.showId)
            end
        end
        for i, v in ipairs(buffs) do
            local buffData = Core:GetBuffData(v, skill.star, skill.lv)
            if buffData then
                table.link(showIds, buffData.showIds)
            end
        end

        for i, v in ipairs(showIds) do
            local setting3 = settingMgr:GetSetting(AutoIds.IdSetting273, "SkillEffectViewVo")
            --@RefType [Game.Setting.Vo.SkillEffectViewVo#SkillEffectViewVo]
            local skillEffectViewVo = setting3:Get(v)
            if skillEffectViewVo and skillEffectViewVo.addControllerTrigPoint > 0 then
                local controllerPath = "RuntimeController/Animator_trans/"
                local extendName = ".overrideController"
                
                table.insert(controllerPathList, controllerPath..skillEffectViewVo.addControllerName..extendName)
                table.insert(controllerPathList, controllerPath..skillEffectViewVo.removeControllerName..extendName)
            end
        end
    end

    local modelId = self:GetModelId(roleData)
    --获取模型id
    for k,skillCardId in pairs(roleData.generalSkills) do
        if not Tools.isNullKey(skillCardId) then

            --从技能牌去寻找
            local skillCardVo = Core:GetSkillCardData(skillCardId)
            for j, skillId in ipairs(skillCardVo.orginSkills) do
                if not Tools.isNullKey(skillId) then
                    local skillData = Core:GetSkillData(skillId, j, 1)
                    local skillShowId = string.format("4%d%d", skillData.action, modelId)
                    addSkillFx(skillData, skillShowId, false)
                end
            end

            for j, skillIds in ipairs(skillCardVo.overSkills) do
                for i, skillId in ipairs(skillIds) do
                    local skillData = Core:GetSkillData(skillId, j, 1)
                    local skillShowId = string.format("4%d%d", skillData.action, modelId)
                    addSkillFx(skillData, skillShowId, false)
                end
            end
        end

        -- if not Tools.isNullKey(v) then
        --     local s = Core:GetSkillData(v, 1, 1)
        --     local skillShowId = string.format("4%d%d", tonumber(k), modelId)
        --     addSkillFx(Core:GetSkillData(v, s.skillStarMax, 1), skillShowId)
        -- end
    end
    --大招
    local ultraInfo = Tools.splitToNum(roleData.finalSkills, '=')
    local skillCardId = ultraInfo[1]
    local star = ultraInfo[2]
    if not Tools.isNullKey(skillCardId) then
        local ultraSkillCardVo = Core:GetSkillCardData(skillCardId)
        local skillOriginId = ultraSkillCardVo.orginSkills[1]
        local skillOverId = ultraSkillCardVo.overSkills[1][1]
        if not Tools.isNullKey(skillOriginId) then
            local skillData = Core:GetSkillData(skillOriginId, star, 1)
            local skillShowId = string.format("4%d%d", skillData.action, modelId)
            addSkillFx(skillData, skillShowId, true)
        end
        if not Tools.isNullKey(skillOverId) then
            local skillData = Core:GetSkillData(skillOverId, star, 1)
            local skillShowId = string.format("4%d%d", skillData.action, modelId)
            addSkillFx(skillData, skillShowId, true)
        end
    end

    return controllerPathList
end

return ResMgr