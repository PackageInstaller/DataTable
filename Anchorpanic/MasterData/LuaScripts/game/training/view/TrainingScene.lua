module("training.TrainingScene", Class.impl())

function open(self)
    self:__addEvent()
    self:__initData()
    self:__initScene()
    self:__initModel()
end

function close(self)
    self:__removeEvent()
    self:__destroyModel()
end

function __addEvent(self)
    GameDispatcher:addEventListener(EventName.ENTER_TRAINING_FORMATION_SUCCSE, self.__enterTrainingFormationSucHandler, self)
    GameDispatcher:addEventListener(EventName.EXIT_TRAINING_FORMATION_SUCCSE, self.__exitTrainingFormationSucHandler, self)
    self:__addFrameUpdate()
end

function __removeEvent(self)
    GameDispatcher:removeEventListener(EventName.ENTER_TRAINING_FORMATION_SUCCSE, self.__enterTrainingFormationSucHandler, self)
    GameDispatcher:removeEventListener(EventName.EXIT_TRAINING_FORMATION_SUCCSE, self.__exitTrainingFormationSucHandler, self)
    self:__removeFrameUpdate()
end

function __initData(self)
    self.mHeroListShowData = {}
    -- 英雄1
    table.insert(self.mHeroListShowData, {pos = gs.Vector3(0, 0, 2), rotation = gs.Vector3(0, 180, 0)})
    -- 英雄2
    table.insert(self.mHeroListShowData, {pos = gs.Vector3(2, 0, 0.5), rotation = gs.Vector3(0, -110, 0)})
    -- 英雄3
    table.insert(self.mHeroListShowData, {pos = gs.Vector3(-2, 0, 0.5), rotation = gs.Vector3(0, 110, 0)})
    -- 英雄4
    table.insert(self.mHeroListShowData, {pos = gs.Vector3(1.25, 0, -2), rotation = gs.Vector3(0, -30, 0)})
    -- 英雄5
    table.insert(self.mHeroListShowData, {pos = gs.Vector3(-1.25, 0, -2), rotation = gs.Vector3(0, 30, 0)})
    -- 怪物
    self.mMonsterShowData = {pos = gs.Vector3(0, 0, 0), rotation = gs.Vector3(0, 0, 0)}
    -- 相机
    self.mCameraShowData = {pos = gs.Vector3(0, 1.4, 8), rotation = gs.Vector3(-3, 180, 0)}
    
    self.mModelList = {}
end

function __initScene(self)
    self.mModelParent = gs.GameObject.Find("[TEMP_GO]").transform
    self.mSceneTrans = gs.CameraMgr:GetSceneCameraTrans()
end

function __initModel(self)
    self:__destroyModel()

    gs.TransQuick:SetLRotation(self.mSceneTrans, self.mCameraShowData.rotation.x, self.mCameraShowData.rotation.y, self.mCameraShowData.rotation.z)
    gs.TransQuick:LPos(self.mSceneTrans, self.mCameraShowData.pos)

    local mosterModel = fight.LiveView.new()
    local trainingConfigVo = training.TrainingManager:getTrainingConfigVo()
    mosterModel:setTID(trainingConfigVo:getRandomMonsterTid(), 1, isEffect, il, __finishCall)
    local trans = mosterModel:getTrans()
    trans:SetParent(self.mModelParent)
    gs.TransQuick:SetLRotation(trans, self.mMonsterShowData.rotation.x, self.mMonsterShowData.rotation.y, self.mMonsterShowData.rotation.z)
    gs.TransQuick:LPos(trans, self.mMonsterShowData.pos)
    gs.TransQuick:Scale(trans, 1, 1, 1)
    mosterModel:playAction(fight.FightDef.ACT_STAND)
    table.insert(self.mModelList, mosterModel)

    local heroFormationList = formation.FormationManager:__getFormationHeroListByTeamId(formation.getTeamIdListByType(formation.TYPE.NORMAL, nil)[1])
    for i = 1, #heroFormationList do
        local heroShowData = self.mHeroListShowData[i]
        local heroModel = fight.LiveView.new()
        heroModel:setTID(heroFormationList[i]:getHeroTid(), 0, isEffect, 1, __finishCall)
        local trans = heroModel:getTrans()
        trans:SetParent(self.mModelParent)
        
        local ro = fight.RoleShowManager:getShowData(heroModel:getModelId())
        local dis = 0
        if ro then dis = ro:getDist() end
        if dis==0 then dis = 4 end

        local pos = math.slideDir(self.mMonsterShowData.pos, (heroShowData.pos-self.mMonsterShowData.pos).normalized, dis)
        gs.TransQuick:SetLRotation(trans, heroShowData.rotation.x, heroShowData.rotation.y, heroShowData.rotation.z)
        gs.TransQuick:Scale(trans, 1, 1, 1)
        gs.TransQuick:LPos(trans, pos)
        
        heroModel:playAction(fight.FightDef.ACT_STAND)
        table.insert(self.mModelList, heroModel)

        -- local _attFinishout = nil
        -- local function _attFinish()
        --     if table.empty(self.mModelList) then return end
        --     local seed = math.random()
        --     if seed>0.8 then
        --         heroModel:playAttActEft(fight.FightDef.ACT_SKILL_1, mosterModel, _attFinishout)
        --     else
        --         heroModel:playAttActEft(fight.FightDef.ACT_ATTACK_1, mosterModel, _attFinishout)
        --     end
        -- end
        -- _attFinishout = function () 
        --     LoopManager:setTimeout(0.8, self, _attFinish)
        -- end

        -- LoopManager:addTimer(math.random()*2+2.5, 0, self, _attFinishout)
    end
    self:_startPlayAtt()
end

function _startPlayAtt(self)
    if self.m_startingPlayAtt==true then return end
    if table.empty(self.mModelList) then return end
    self.m_startingPlayAtt = true
    for i = 2, #self.mModelList do
        local heroModel = self.mModelList[i]
        local _attFinishout = nil
        local function _attFinish()
            if table.empty(self.mModelList) then return end
            if self.m_startingPlayAtt==false then return end
            local seed = math.random()
            if seed>0.8 then
                heroModel:playAttActEft(fight.FightDef.ACT_SKILL_1, self.mModelList[1], _attFinishout)
            else
                heroModel:playAttActEft(fight.FightDef.ACT_ATTACK_1, self.mModelList[1], _attFinishout)
            end
        end
        _attFinishout = function () 
            LoopManager:setTimeout(0.8, self, _attFinish)
        end
        -- _attFinishout()
        LoopManager:setTimeout(math.random()*2+2.5, self, _attFinishout)
    end
end

function _stopPlayAtt(self)
    if self.m_startingPlayAtt==false then return end
    if table.empty(self.mModelList) then return end
    self.m_startingPlayAtt = false
    for i = 2, #self.mModelList do
        local heroModel = self.mModelList[i]
        heroModel:playAction(fight.FightDef.ACT_STAND)
    end
end

function __addFrameUpdate(self)
    if(not self.m_loopSn)then
        self.m_loopSn = LoopManager:addFrame(1, 0, self, self.__updateTickTimeHandler)
    end
end

function __removeFrameUpdate(self)
    if(self.m_loopSn)then
        LoopManager:removeFrameByIndex(self.m_loopSn)
        self.m_loopSn = nil
        STravelHandle:removeAllTravel()
    end
end

function __exitTrainingFormationSucHandler(self)
    self:__addFrameUpdate()
    self:_startPlayAtt()
    if (self.mSceneTrans and not gs.GoUtil.IsTransNull(self.mSceneTrans)) then
        gs.GoUtil.RemoveComponent(self.mSceneTrans.gameObject, ty.PhysicsRaycaster)
    end
end

function __enterTrainingFormationSucHandler(self)
    self:_stopPlayAtt()
    self:__removeFrameUpdate()
    if (self.mSceneTrans and not gs.GoUtil.IsTransNull(self.mSceneTrans)) then
        gs.GoUtil.AddComponent(self.mSceneTrans.gameObject, ty.PhysicsRaycaster)
    end
end

function __updateTickTimeHandler(self)
    if(self.mSceneTrans and not gs.GoUtil.IsTransNull(self.mSceneTrans))then
        self.mSceneTrans:RotateAround(self.mMonsterShowData.pos, gs.Vector3.up, gs.Time.deltaTime * 4)
    end
    STravelHandle:updateTravel(gs.Time.deltaTime)
end

function __destroyModel(self)
    if table.empty(self.mModelList) then return end
    for _, heroModel in ipairs(self.mModelList) do
        heroModel:destroy()
    end
    self.mModelList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
