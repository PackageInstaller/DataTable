-- @FileName:   SandPlayNPCModel.lua
-- @Description:   沙盒玩法模型基类
-- @Author: ZDH
-- @Date:   2023-07-25 15:35:17
-- @Copyright:   (LY) 2023 雷焰网络

module('game.sandPlay.model.SandPlayNPCModel', Class.impl())

function ctor(self)
    -- 动作控制
    self.m_ani = nil
    self.m_loadSn = 0
end

-- 开始加载模型模型
-- beAlwayEft : 是否开启常驻特效
function setupPrefab(self, prefabname, beAlwayEft, finishCall, sorceId)
    if self.m_rootGo == nil then
        self.m_rootGo = gs.GameObject()
        self.m_trans = self.m_rootGo.transform
    end

    self.m_prefabName = prefabname

    self:setModelGoName()
    self:clearModel()

    local function _loadAysnModeCall(go)
        self:loadFinish(go, finishCall, sorceId)
    end
    self.m_loadSn = gs.ResMgr:LoadGOAysn(self.m_prefabName, _loadAysnModeCall)
end

function loadFinish(self, go, finishCall, sorceId)
    if go then
        self.m_model = go
        self.m_modelTrans = self.m_model.transform
        self.m_modelTrans:SetParent(self.m_trans, false)

        self.m_ani = self.m_model:GetComponent(ty.Animator)

        if finishCall then
            finishCall(false, self)
        end
    else
        logError("Role Model " .. self.m_prefabName .. "not exist")
        if finishCall then
            finishCall(false, self)
        end
    end
end

function IsPlayingShortNameHash(self, actHash)
    local info = self.m_ani:GetCurrentAnimatorStateInfo(0);
    if (info.shortNameHash == actHash) then
        return true
    end

    return false
end

function playAction(self, aniName, startCall, endCall, isForceEndCall)
    if not self.m_ani or gs.GoUtil.IsCompNull(self.m_ani) then
        return
    end

    local aniHash = gs.Animator.StringToHash(aniName)
    if not self:IsPlayingShortNameHash(aniHash) then
        self.m_ani:Play(aniName, 0, 0)
    end
end

function setPosition(self, lpos)
    if self.m_trans and lpos then
        gs.TransQuick:Pos(self.m_trans, lpos.x, lpos.y, lpos.z)
    end
end

function setModelGoName(self, name)
    if not name then
        local strArr = string.split(self.m_prefabName, "/")
        self.m_rootGo.name = strArr[#strArr] .. "_Root"
    else
        self.m_rootGo.name = name
    end
end

-- 获取动作时长
function getAniLenght(self, aniName, callback)
    if callback and self.m_ani then
        local timeLenght = AnimatorUtil.getAnimatorClipTime(self.m_ani, aniName)
        callback(timeLenght)
    end
end

function cancelLoadAsync(self)
    if self.m_loadSn and self.m_loadSn ~= 0 then
        gs.ResMgr:CancelLoadAsync(self.m_loadSn)
        self.m_loadSn = 0
    end
end

-- 清空模型 (并不是删除! 删除请用destroy)
function clearModel(self)
    self:cancelLoadAsync()
end

function onRecover(self)
    self:clearModel()

    if self.m_rootGo then
        gs.GameObject.Destroy(self.m_rootGo)
        self.m_rootGo = nil
        self.m_trans = nil
    end
end

return _M
