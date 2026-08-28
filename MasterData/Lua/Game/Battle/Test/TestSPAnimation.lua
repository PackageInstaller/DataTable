local GameObject = CS.UnityEngine.GameObject
local KTool = CS.Engine.Lib.KTool
local RoleView = import("Game.BattleView.Entity.RoleView")
local BattleSkillCameraMgr = CS.Game.Native.Battle.BattleSkillCameraMgr

local cs_coroutine = import('XLua.cs_coroutine')
local TestInitData = '{"starConditions":[],"battleSkill":[[]],"questId":290101,"specialTeam":[[]],"isSimulator":false,"mapId":30301,"enemyPartyCat":[],"callTeam":[[]],"enemyTeam":[[{"type":1,"id":1000,"enemyId":31027001,"attribute":1,"attr":"1=5&2=148.5&3=1425600&6=1.5","summons":[],"generalSkills":{"1":511027001},"treasureType":0,"currentHp":1425600,"career":1,"skinId":30102701,"playerId":-2,"level":100,"maxSP":5,"ai":"monster/monster_91000091_01","passiveSkills":"","currentEnergy":0,"weakId":0,"pos":1,"finalSkills":"571027001=1"}]],"skillQueueLoop":0,"treasures":[],"selfId":4044,"settingId":1,"playerCombatVal":8289,"playerTeam":[[{"maxSP":5,"id":1,"combatValue":3436,"attribute":1,"attr":"1=243&2=87&3=454&20=0.01&6=1.383&21=0.05&206=0.011&215=0.011","summons":[],"cardId":101008,"urStar":0,"advanceLevel":1,"awakeningLevel":1,"generalSkills":{"2":72101008,"1":71101008},"playerCardId":37719,"currentHp":454,"career":0,"skinId":10100801,"playerId":4044,"level":5,"ai":"","weaponUnlocked":0,"passiveSkills":"110100801=1=2&110100803=1=2","star":0,"currentEnergy":1,"weakId":0,"finalSkills":"73101008=5"},{"maxSP":5,"id":2,"combatValue":4853,"attribute":2,"attr":"1=369&2=130&3=783&20=0.01&6=1.233&206=0.011&215=0.011","summons":[],"cardId":108008,"ai":"","urStar":0,"advanceLevel":2,"awakeningLevel":1,"generalSkills":{"2":72108008,"1":71108008},"playerCardId":37364,"currentHp":783,"career":0,"skinId":10800801,"playerId":4044,"level":15,"enterVoice":true,"weaponUnlocked":0,"passiveSkills":"110800802=1=2","star":1,"currentEnergy":1,"weakId":0,"finalSkills":"73108008=2"}]],"skillQueue":"","playerCatTeam":[[{"type":1,"id":5000,"catId":6401001,"playerCatId":1345,"playerId":4044,"attr":"1=612&2=217&3=1237","passiveSkills":"","star":0,"camp":1,"finalSkills":"71010011=1"}],[],[]],"randomSeed":"65b8a43e31a8e","mergeSkillId":[],"playerTeamSkill":"","rounds":10,"pvpSettingId":0,"first":2,"enemyCombatVal":2852830,"recommendCombatVal":0,"enemyCatTeam":[],"myPartyCat":[],"isOpenOverwhelming":0,"overwhelmingGroup":0}'

local TestSPAnimation = {}

TestSPAnimation.roleCache = {}

function TestSPAnimation:Run()
    self.roleCache = {}
    if BattleViewMgr then
        BattleViewMgr:RestartBattle()
        return
    end
    CS.Engine.Tools.PlayerPrefsUtility.SetEncryptedString("TestData", TestInitData)
    GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.BattleScene }, {}, Constants.LoadingType.BattleScene, false)
end

--- 连续播放所有角色卡牌表里，所有角色的大招timeline
function TestSPAnimation:PlayAllCardTimeline()
    BattleViewMgr.enableUltraAnim = true

    local cardVoList = {}

    for voIndex, cardVo in ipairs(CfUtils.GetWholeVo(AutoIds.IdSetting28, 'CardVo')) do
        table.insert(cardVoList, cardVo)
    end

    -- local cardIdList = {129008,123008}
    -- for i, cardId in ipairs(cardIdList) do
    --     table.insert(cardVoList, CfUtils.GetCfVo(AutoIds.IdSetting28, "CardVo", cardId))
    -- end

    cs_coroutine.start(function()
        for i, cardVo in ipairs(cardVoList) do
            if cardVo.status > 0 then
                local modelId = checkNumber(cardVo.modelRes)
                local skillCardId = cardVo.skillNode.finalSkill
                local tableFile = SettingMgr:GetInstance():GetSetting(AutoIds.IdSetting576, "SkillCardVo")
                local skillData = tableFile:Get(skillCardId)
                local skillId = skillData.orginSkills[1]
                
                local targetId = BattleMgr:GetAliveRoles(2)[1].id
                local roleView = BattleViewMgr:FindRoleView(1)
                roleView.modelVo.id = modelId
                roleView.skinId = cardVo.defaultSkin
                
                local record = {
                    ["na"] = false,     -- noAction
                    ["subs"] = {{}},    
                    ["sl"] = 1,         -- level
                    ["ss"] = 1,         -- star
                    ["ip"] = true,      -- isInputSkill
                    ["r"] = 1,          -- Constants.RecordType.Skill
                    ["idx"] = 0,        -- skillIndex
                
                
                    ["t"] = targetId,       -- target
                    ["a"] = 1,          -- attacker
                    ["s"] = skillId,    -- skillId
                    ["mts"] = 
                    {
                        [1] = targetId,
                    },
                    ["hts"] = 
                    {
                        [1] = {
                            [1] = targetId,
                        },
                    },
                }
                cs_coroutine.yield_return(RecordReader.SkillRecordReader:DoRecord(record, false))
            end
        end
    end)
end

--- 连续播放所有猫球大招timeline
function TestSPAnimation:PlayAllSkillCatTimeline()
    BattleViewMgr.enableUltraAnim = true
    local skillId = 41010011
    local skillViewIds = {4030101, 4330101}
    CoStart(function()
        for i, skillViewId in ipairs(skillViewIds) do
            local targetId = BattleMgr:GetAliveRoles(2)[1].id
            local skillCatView
            for i, v in ipairs(BattleViewMgr.skillCatViews) do
                if v.camp == Constants.Camp.One and v.type == 1 then
                    skillCatView = v
                end
            end
            skillCatView.skillViewId = skillViewId
            local record = {
                ["na"] = false,     -- noAction
                ["subs"] = {{}},    
                ["sl"] = 1,         -- level
                ["ss"] = 1,         -- star
                ["ip"] = true,      -- isInputSkill
                ["r"] = 1,          -- Constants.RecordType.Skill
                ["idx"] = 0,        -- skillIndex
                ["t"] = targetId,       -- target
                ["a"] = skillCatView.id,          -- attacker
                ["s"] = skillId,    -- skillId
                ["mts"] = { targetId },
                ["hts"] = {{targetId}},
            }
            cs_coroutine.yield_return(RecordReader.SkillRecordReader:DoRecord(record, false))
            CoYield(1)
        end
    end)
    
end

--- 播放角色或者怪物的技能
---@param id any 角色卡牌表id 或者 角色皮肤id 或者 怪物类型id
---@param index any 技能序号
---@param isOverride any 是否是复写技能
function TestSPAnimation:PlaySkill(id, index, isOverride)
    BattleViewMgr.enableUltraAnim = true
    id = checkNumber(id)
    index = checkNumber(index)
    local roleData = self:GetRoleData(id)
    self:LoadRole(roleData, function(roleView)
        CoYield(0.5)
        local targetId = BattleMgr:GetAliveRoles(2)[1].id
        local skillId = self:GetSkillId(roleData, index, isOverride)
        local record = {
            ["na"] = false,     -- noAction
            ["subs"] = {{}},    
            ["sl"] = 1,         -- level
            ["ss"] = 1,         -- star
            ["ip"] = true,      -- isInputSkill
            ["r"] = 1,          -- Constants.RecordType.Skill
            ["idx"] = index,        -- skillIndex
            ["t"] = targetId,       -- target
            ["a"] = 10,          -- attacker
            ["s"] = skillId,    -- skillId
            ["mts"] = { targetId },
            ["hts"] = {{targetId}},
        }
        BattleSkillCameraMgr.Instance:SwitchBattleCamera(true, BattleViewMgr.sceneVo.battleAndUICameraSwitchTime)
        cs_coroutine.yield_return(RecordReader.SkillRecordReader:DoRecord(record, false))
        BattleViewMgr:SwithToUICamera()
    end)
end

function TestSPAnimation:LoadRole(roleData, cb)
    -- local roleData = {
    --     generalSkills = {
    --         [2] = 72107010,
    --         [1] = 71107010
    --     },
    --     skinId = 10701001,
    --     finalSkills = "73107010=9"
    -- }

    local data = self.roleCache[roleData.skinId]
    if isNotNull(data) 
    and isNotNull(data.roleView) 
    and isNotNull(data.roleView.gameObject) then
        CoStart(function()
            CoYield(cb(data.roleView))
        end)
        return
    end

    self:ClearRoleCache()

    ResMgr:RequireRole(roleData)
    CoStart(function()
        ResMgr:LoadRole()
        ------------------------------------------------------------------------
        local modelId = Core:GetModleId(roleData.skinId)
        local model = ResMgr.roleMoudles[modelId]
        if not model or isNull(model.loader) then
            printError('找不到模型:'..model)
            return
        end
        local modelVo = model.modelVo
        local go = GameObject.Instantiate(model.loader.ResultObject)
        KTool.SetActive(go, true) 
        go.transform.position = Vector3.zero
        go.transform:SetParent(BattleViewMgr.rootNode.transform)
        go.transform.localScale = Vector3.one * modelVo.battleScale

        local roleId = 10
        local roleView = RoleView.New(roleId, roleData, Constants.RoleType.Hero, go, roleId, Constants.Camp.One, modelVo, 100, 5)
        roleView:SetStand( BattleViewMgr:GetStand(1, 1) )
        table.insert(BattleViewMgr.roleViews, roleView)

        self:AddRoleCache(roleData, roleView)

        CoYield(cb(roleView))
    end)
end

function TestSPAnimation:GetCardId(skinId)
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting113, "CardSkinVo", skinId)
    if isNotNull(vo) then
        return vo.roleId
    end
end

function TestSPAnimation:GetRoleData(id)
    -- 如果是皮肤id，转换成角色id
    local isSkinId = false
    local cardId = self:GetCardId(id)
    if isNotNull(cardId) then
        id = cardId
        isSkinId = true
    end

    -- 判断角色Id是卡牌id还是怪物类型id
    local roleType = Constants.RoleType.Hero
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo', id)
    if isNull(vo) then
        if isSkinId then
            GameUtils.Toast("怪物不能使用皮肤id查找,要使用怪物类型表id", 4)
        else
            roleType = Constants.RoleType.Monster
            vo = CfUtils.GetCfVo(AutoIds.IdSetting39, 'MonsterTypeVo', id)
        end
    end

    if isNull(vo) then
        GameUtils.Toast(string.format("没有找到id %s", id))
    end

    local roleData = {}

    if roleType == Constants.RoleType.Hero then
        roleData.generalSkills = {
            [1] = vo.skillNode.generalSkill,
            [2] = vo.skillNode.advancedSkill,
        }
        roleData.finalSkills = tostring(vo.skillNode.finalSkill).."=1"
        roleData.skinId = vo.defaultSkin
    elseif roleType == Constants.RoleType.Monster then
        roleData.generalSkills = {
            [1] = vo.atkSkill,
            [2] = vo.atkSkill2,
            [3] = vo.atkSkill3,
            [4] = vo.atkSkill4,
            [5] = vo.atkSkill5,
            [6] = vo.atkSkill6,
        }
        roleData.finalSkills = tostring(vo.hitSkill).."=1"
        roleData.skinId = vo.skinId
    end
    return roleData
end

function TestSPAnimation:GetSkillId(roleData, index, isOverride)
    local skillCardId
    if index == 0 then
        skillCardId = string.split(roleData.finalSkills, "=")[1]
    elseif index > 0 then
        skillCardId = roleData.generalSkills[index]
    end
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting576, "SkillCardVo", skillCardId)
    return isOverride and vo.overSkills[1][1] or vo.orginSkills[1]
end

function TestSPAnimation:AddRoleCache(roleData, roleView)
    self.roleCache[roleData.skinId] = {
        roleData = roleData,
        roleView = roleView,
    }
end

function TestSPAnimation:ClearRoleCache()
    for skinId, cache in pairs(self.roleCache) do
        ResMgr:UnloadRoleRes(cache.roleData)
        xTry(function()
            table.removebyvalue(BattleViewMgr.roleViews, cache.roleView)
            cache.roleView:Dispose()
        end)
    end
    self.roleCache = {}
end


return TestSPAnimation