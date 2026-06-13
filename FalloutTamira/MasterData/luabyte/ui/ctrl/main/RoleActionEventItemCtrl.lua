local RoleActionEventItemCtrl = BaseClass("RoleActionEventItemCtrl",require("Framework.UI.Component.CircularScrollViewItem"))
local M = RoleActionEventItemCtrl

function M:Init()
    M.super.Init(self)
    self._view.go:onClick(Bind(self,self._OnClickGo))
    self._view.playBtn:onClick(Bind(self,self._OnPlay))
    self._jumpId = 0 
    self._playComplete = Bind(self,self._OnPlayComplete)
    self._isDisposed = false 
    self._timer = nil
end

function M:UpdateItem(data, idx)
    self._data = data 
    local taskId = data.taskId 
    self._heroId = data.heroId 
    local isPlaying = data.playActionId == data.interactActionId
    self._interactActionId = data.interactActionId
    --self._onPlay = data.onPlay 
    local interactCfg = ConfigHelper.GetCfg("interactAction",self._interactActionId)
    self._view.titleTf:SetText(interactCfg.acitonName)
    local isDoing = false 
    if taskId > 0 then 
        isDoing = TaskDataMgr:GetDoingState(taskId)
    end
    local contentLanId = 0
    local stateId = 0 
    if (not isDoing) or CS.GameX.GameGlobal.KanbanMusumeCanPlayAmimation then 
        contentLanId = interactCfg.acitonDes
        stateId = 2
        if isPlaying then 
            stateId = 3
        end
        self._view.contentTf:SetText(contentLanId)
    else
        local taskCfg = ConfigHelper.GetCfg("task",taskId)
        contentLanId = taskCfg.des
        stateId = 1
        self._view.go:SetActive(taskCfg.jumpId > 0)
        self._jumpId = taskCfg.jumpId
        local taskData = TaskDataMgr:GetTaskData(taskCfg.type,taskId)
        self._view.contentTf:SetText(ConfigHelper.GetLocalString(contentLanId) .. "(" .. taskData.value0 .. "/" .. taskData.limitValue1 .. ")")
    end
    
    
    self._view.state:SetState(stateId)
end

function M:_OnClickGo(go)
    if self._jumpId > 0 then 
        Logger.Log("interactActionId:"..self._interactActionId .. ",taskId:" .. tostring(self._data.taskId) .. ",jumpId:" ..self._jumpId )
        JumpMgr:GetInstance():Execute(self._jumpId)
    end
end

function M:_OnPlay(go)
    self._view.state:SetState(3)
    if self._data.onPlay then
        Logger.Log("interactActionId:"..self._interactActionId)
        self._data.onPlay( true,self._interactActionId)
    end
    self:RefreshList()
    if self._timer then 
        self._timer:Stop()
    end
    --如果动画被打断了，最多5秒把播放UI关掉
    self._timer = TimerManager:GetInstance():GetTimer(5,self._playComplete,nil,true)
    self._timer:Start()
    IRoleActionMgr:Play( self._heroId,self._interactActionId ,self._playComplete )
end

function M:_OnPlayComplete()
    if self._isDisposed then 
        return 
    end
    if self._timer then 
        self._timer:Stop()
    end
    self._timer = nil 
    if  self._data.playActionId == self._data.interactActionId then 
        if self._data.onPlay then 
            self._data.onPlay( false,self._interactActionId)
        end
        self:RefreshList()
    end
end

function M:OnDispose()
    M.super.OnDispose(self)
    self._playComplete = nil 
    self._isDisposed = true 
end
return M 