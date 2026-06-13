local SweepMachineCtrl = BaseClass("SweepMachineCtrl")
local M = SweepMachineCtrl
local tInsert = table.insert
local tRemove = table.remove

function M:IsIdle()
    return self._machineCurState == self._machineState.idle  
end


function M:IsLieIdle()
    return self._machineCurState == self._machineState.freemoving or self:IsIdle()
end


function M:IsMoving()
    if self._machineCurState ~= self._machineState.freemoving and self._machineCurState ~= self._machineState.gorubbish then
        return true
    end

    return self._machine:GetNavMeshAgent().pathPending or self._machine:GetNavMeshAgent().remainingDistance > self._machine:GetNavMeshAgent().stoppingDistance;
end


function M:MachDoTewwnMoveY(y, speed)
    return self._body.transform:SetDoMoveY(y, speed)
end


function M:PlayBodyAnimation(state)
    if self._animator then
        self._animator:Play(state)
    end
end


function M:SetMachineState(state)
    self._machineCurState = state
    self:_SetEffectActive(false)
    self:_EnterState()
    self:PlayBodyAnimation(state)
end


function M:_EnterState()
    if self._machineCurState == self._machineState.freemoving then
        self:_FreeMove()
    elseif self._machineCurState == self._machineState.gorubbish then
        self:_FromRubbish()
    elseif self._machineCurState == self._machineState.recovering then
        self:_StartRecovery()
    elseif self._machineCurState == self._machineState.digestion then
        self:_DigestionRubbish()
    elseif self._machineCurState == self._machineState.flay then
        self:_Flay()
    end
end


function M:_FreeMove()
    local pos = self._machine.transform:GetRandomNavMeshAgentPos(1)
    self._machine.transform:NavMeshAgentMove(pos.x, pos.y, pos.z, 0.1)
    self._stateTimer = TimerManager:GetInstance():GetTimer(self._freeMoveTime, Bind(self, self._OnFreeMove), nil, true)
    self._stateTimer:Start()
end


function M:_FromRubbish()
    self._machine.transform:NavMeshAgentMove(self._rubbishs[1].pos.x, self._rubbishs[1].pos.y, self._rubbishs[1].pos.z)
    local tween = self:MachDoTewwnMoveY(0.3, 2.8)
    tween.onComplete = function ()
        self:_StopMoveBody()
    end
end


function M:_StartRecovery()
    self:_SetEffectActive(true)
    self._stateTimer = TimerManager:GetInstance():GetTimer(self._recoveryTime, Bind(self, self._OnRecoveryRubbish), nil, true)
    self._stateTimer:Start()
end


function M:_DigestionRubbish()
    local tween = self:MachDoTewwnMoveY(self._defaultHeight, 2)
    tween.onComplete = function ()
        self:SetMachineState(self._machineState.idle)
    end
end


function M:_Flay()
    self._stateTimer = TimerManager:GetInstance():GetTimer(self._flayTime, Bind(self, self._OnFlay), nil, true)
    self._stateTimer:Start()
end


function M:_LieIdle()
    local index = math.random(1, 50)
    if index < 10 then
        self:SetMachineState(self._machineState.flay)
        return
    end

    self:SetMachineState(self._machineState.freemoving) 
end


function M:_StopMoveBody()
    if self._machineCurState == self._machineState.freemoving then
        self:SetMachineState(self._machineState.idle)
        return
    end

    self:SetMachineState(self._machineState.recovering)
end


function M:_SetEffectActive(b)
    if self._effectSweep then
        self._effectSweep:SetActive(b)
    end

    if #self._rubbishs > 0 then
        self._rubbishs[1].control.enabled = b
    end
end


function M:Init()
    self:_InitMachine()
    self:_InitRubbishTool()
    self._actionTimer:Start()
    self._rubbishTimer:Start()
end


function M:_InitMachine()
    self._body = ResourceManager:GetInstance():InstanceGameObject('Furniture/Machine')
    self._body.transform:SetParent(self._machine.transform)
    self._body:SetPos(0, self._defaultHeight, -0.3)
    self._animator = self._body.transform:GetAnimator()
    self._effectSweep = self._body.transform:FindChildren('Effect_Sweep')
    self:SetMachineState(self._machineState.idle)
end


function M:_InitRubbishTool()
    self._rubbishTool = {}
    for i = 1, 6 do
        local rubbish = {}
        local name = string.format('Rubbish%0.2d', i)
        rubbish.obj = self:_CreateRubbisObj(name)
        rubbish.pos = rubbish.obj.transform.position
        rubbish.control = rubbish.obj.transform:GetDiffuseDissolveControl()
        rubbish.control.enabled = false
        rubbish.obj:SetActive(false)
        tInsert(self._rubbishTool, rubbish)
    end
end


function M:_CreateRubbisObj(name)
    return self._activityRegion[name]
end


function M:_CreateRubbish()
    local index = math.random(1, #self._rubbishTool)
    local rubbish = self:_TryRubbishObj(index) 
    rubbish.obj:SetActive(true)
    tInsert(self._rubbishs, rubbish)
end


function M:_TryRubbishObj(index)
    if not self._rubbishTool[index] then
        return
    end

    local rubbish = self._rubbishTool[index]
    tRemove(self._rubbishTool, index)
    return rubbish
end


function M:_ClearFirshRubbish()
    local rubbish = self._rubbishs[1]
    rubbish.obj:SetActive(false)
    rubbish.control.enabled = false
    tInsert(self._rubbishTool, rubbish)
    tRemove(self._rubbishs, 1)
end


function M:__init(view)
    self._activityRegion = view
    self._machine = view.Machine
    self._machineState = { 
        idle = 'Idle', 
        freemoving = 'Move', 
        gorubbish = 'GoTo' ,
        recovering = 'Recovery', 
        digestion = 'Digestion' ,
        flay = 'Flay'
    }

    self._body = nil
    self._animator = nil
    self._defaultHeight = 1
    self._newRubbishTime = 60
    self._actionTime = 1
    self._freeMoveTime = 10
    self._flayTime = 2.3
    self._recoveryTime = 2.2
    self._rubbishTool = {}
    self._rubbishs = {}
   
    self._stateTimer = nil
    self._rubbishTimer = TimerManager:GetInstance():GetTimer(self._newRubbishTime, Bind(self, self._OnCreateRubbish), nil, false)
    self._actionTimer = TimerManager:GetInstance():GetTimer(self._actionTime, Bind(self, self._OnActionState), nil, false)
 
    self:Init()
end


function M:_OnCreateRubbish()
    if #self._rubbishTool <= 0 then
        return
    end

    self:_CreateRubbish()
end


function M:_OnActionState()
    if not self:IsLieIdle() then
        return
    end

    if #self._rubbishs > 0 then
        self._stateTimer:Stop()
        self:SetMachineState(self._machineState.gorubbish)
        return
    end

    if self:IsIdle() then
        self:_LieIdle()
    end
end


function M:_OnFreeMove()
    self._stateTimer:Stop()
    self:SetMachineState(self._machineState.idle)
end


function M:_OnRecoveryRubbish()
    self._stateTimer:Stop()
    self:_ClearFirshRubbish()
    self:SetMachineState(self._machineState.digestion)
end

function M:_OnFlay()
    self._stateTimer:Stop()
    self:SetMachineState(self._machineState.idle) 
end

function M:EnableActivityRegion(value)
    self._activityRegion:SetActive(value)
end

function M:EnableMachine(value)
    if self.machineObj then
        self.machineObj:SetActive(value)
    end
end

function M:SetMachineObj(object)
    self.machineObj = object
end

function M:SetTimer(isPause)
    if isPause then
        if self._rubbishTimer then
            self._rubbishTimer:Pause()
        end
    
        if self._actionTimer then
            self._actionTimer:Pause()
        end
    else
        if self._rubbishTimer then
            self._rubbishTimer:Resume()
        end
    
        if self._actionTimer then
            self._actionTimer:Resume()
        end
    end
end

function M:OnDispose()
    if self._rubbishTimer then
        self._rubbishTimer:Stop()
        self._rubbishTimer = nil
    end

    if self._actionTimer then
        self._actionTimer:Stop()
        self._actionTimer = nil
    end
    
    self._animator = nil
    self._rubbishs = {}
    self._rubbishTool = {}
    GameUtil.DestroyGo(self._body)
end





return SweepMachineCtrl
