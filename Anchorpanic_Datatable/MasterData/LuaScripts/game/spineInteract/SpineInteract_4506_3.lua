--[[ 
-----------------------------------------------------
@filename       : SpineInteract_4506_3
@Description    : 圣诞冷蛟互动
@date           : 2024-05-17 16:58:15
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.spineInteract.SpineInteract_4506_3', Class.impl("lib.component.BaseContainer"))

function setup(self, go, modelId)
    self.mSpineGo = go
    self.modelId = modelId

    local spineTrans = self.mSpineGo.transform:Find("mGroup/spine_" .. modelId)
    local anim = spineTrans:GetComponent(ty.Animator)
    self.mSpineTrans = spineTrans
    self.spineAnim = self.mSpineTrans:GetComponent(ty.Animator)
    if not self.spineAnim then
        return
    end

    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.mSpineGo)


    self.mEventTrigger = self.m_childGos["mImgClick1"]:GetComponent(ty.LongPressOrClickEventTrigger)

    local function onPointDownHandler()

        self.spineAnim:Play("anim02")

        self.lastMousePosition = gs.Input.mousePosition
        LoopManager:addFrame(1, 0, self, self.updateFrame)
    end
    local function onPointUpHandler()
        self:stopMove()
    end
    self.mEventTrigger.onPointerDown:AddListener(onPointDownHandler)
    self.mEventTrigger.onPointerUp:AddListener(onPointUpHandler)
end

function updateFrame(self)
    -- 获取鼠标位置的变化量
    local mouseDelta = gs.Input.mousePosition - self.lastMousePosition

    -- 计算鼠标拖拽的速度
    local dragSpeed = mouseDelta.magnitude / gs.Time.deltaTime

    -- 根据鼠标位置的变化量确定播放方向
    local direction = -gs.Mathf.Sign(mouseDelta.x)

    dragSpeed = math.max(dragSpeed, -1000)
    dragSpeed = math.min(dragSpeed, 1000)

    local speed = dragSpeed * 0.003 * direction
    -- 更新动画速度和方向
    self.spineAnim:SetFloat("Speed", speed)

    if speed ~= 0 then
        local currTime = self.spineAnim:GetCurrentAnimatorStateInfo(0).normalizedTime
        local currTime1 = math.abs(currTime * speed)

        if direction == 1 and currTime1 >= 0.99 then
            self:stopMove()
        end
        if direction == -1 and currTime1 <= 0.01 then
            self:stopMove()
        end
    end



    -- 更新鼠标位置
    self.lastMousePosition = gs.Input.mousePosition
end

function stopMove(self)
    self.spineAnim:SetFloat("Speed", 0)
    self.spineAnim:StopPlayback()
    LoopManager:removeFrame(self, self.updateFrame)
end

function destroy(self)
    LoopManager:removeFrame(self, self.updateFrame)

    self.mEventTrigger.onPointerDown:RemoveAllListeners()
    self.mEventTrigger.onPointerUp:RemoveAllListeners()
end

return _M