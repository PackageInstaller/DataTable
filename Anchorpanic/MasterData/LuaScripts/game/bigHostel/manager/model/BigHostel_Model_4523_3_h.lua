-- @FileName:   BigHostel_Model_4523_3_h.lua
-- @Description:   大宿舍角色模型
-- @Author: ZDH
-- @Date:   2025-04-21 18:17:45
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostel_Model_4523_3_h', Class.impl(bigHostel.BigHostelBaseModel))

--允许切换镜头的状态
Can_Switch_State = {
    gs.Animator.StringToHash("Xidle01_body"),
    gs.Animator.StringToHash("Xidle02_body"),
    gs.Animator.StringToHash("Xidle03_body"),
}

--状态对应的待机trigger
Idle_StateTrigger = {
    [gs.Animator.StringToHash("showStart")] = "idle_1",
    [gs.Animator.StringToHash("Xidle01_body")] = "idle_1",
    [gs.Animator.StringToHash("Xleave03_body")] = "idle_1",
    [gs.Animator.StringToHash("Xleave01_body")] = "idle_2",
    [gs.Animator.StringToHash("Xidle02_body")] = "idle_2",
    [gs.Animator.StringToHash("Xleave02_body")] = "idle_3",
    [gs.Animator.StringToHash("Xidle03_body")] = "idle_3",
}

--状态对应的音效
ActionSound_list = {
    [gs.Animator.StringToHash("showStart")] = {res = "4523/sfx_role_4523_3_h_01.prefab", layback = 7733},
    [gs.Animator.StringToHash("Xshow01_body")] = {res = "4523/sfx_role_4523_3_h_02.prefab", layback = 0},
    [gs.Animator.StringToHash("Xshow02_body")] = {res = "4523/sfx_role_4523_3_h_03.prefab", layback = 0},
    [gs.Animator.StringToHash("Xshow03_body")] = {res = "4523/sfx_role_4523_3_h_04.prefab", layback = 6283},
}

--构造函数
function ctor(self)

end

--删除
function destroy(self)
    super.destroy(self)

    self.m_startMousePos = nil
    self.m_operateMousePoint = nil
    self.m_show02Time = nil

    self.m_siwaValue = nil
    self.m_siwaMaterial = nil

    self.m_faceValue = nil
    self.m_faceMaterial = nil

    self:removeInteractCollider()

    self:clearTwistFrame()
    self:clearSiWaFrame()
end

function loadFinish(self, go, finishCall)
    super.loadFinish(self, go, finishCall)

    local node = gs.GameObject.Find("4523_3_h_Face")
    if node and not gs.GoUtil.IsGoNull(node) then
        local skinnedMeshRenderer = node:GetComponent(ty.SkinnedMeshRenderer)

        for i = 0, skinnedMeshRenderer.materials.Length do
            if string.find(skinnedMeshRenderer.materials[i].name, "Face") then
                self.m_faceMaterial = skinnedMeshRenderer.materials[i]
                break
            end
        end
    end

    node = gs.GameObject.Find("4523_3_h_Body")
    if node and not gs.GoUtil.IsGoNull(node) then
        local skinnedMeshRenderer = node:GetComponent(ty.SkinnedMeshRenderer)

        for i = 0, skinnedMeshRenderer.materials.Length do
            if string.find(skinnedMeshRenderer.materials[i].name, "siwa") then
                self.m_siwaMaterial = skinnedMeshRenderer.materials[i]
                break
            end
        end
    end

    self.m_camera = gs.CameraMgr:GetToScreenSceneCamera()

    self.m_bipColliderDic = {}

    self:addAnimationClipEvent("Xshow03_body", 400, nil, function(_key)
        self.m_siwaMaterial:SetFloat("_NewClothesReplaceValue", 0)
    end)

    self:addAnimationClipEvent("Xshow03_face", 450, nil, function(_key)
        self.m_faceMaterial:SetFloat("_BlushIntensity", 0)
    end)

    self:addAnimationClipEvent("Xshow02_face", 200, nil, function(_key)
        self.m_faceMaterial:SetFloat("_BlushIntensity", 0)
    end)
end

function addEventListener(self)
    super.addEventListener(self)

    -- GameDispatcher:addEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG, self.onScreenDrag, self)
    -- GameDispatcher:addEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG_END, self.onScreenDragEnd, self)
end

function removeEventListener(self)
    super.removeEventListener(self)

    -- GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG, self.onScreenDrag, self)
    -- GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG_END, self.onScreenDragEnd, self)
end

function onSwitchIdle(self)
    super.onSwitchIdle(self)

    if self.m_siwaMaterial then
        self.m_siwaMaterial:SetFloat("_NewClothesReplaceValue", 0)
        self.m_faceMaterial:SetFloat("_BlushIntensity", 0)
    end
end

function onAnimaBodyStateSwitch(self, stateHash)
    super.onAnimaBodyStateSwitch(self, stateHash)

    if stateHash == gs.Animator.StringToHash("Xidle01_body") then
        local node_2 = gs.GameObject.Find("Spine_node").transform
        self.m_bipColliderDic["Spine_node"] = node_2.gameObject:GetComponent(ty.BoxCollider)
        if self.m_bipColliderDic["Spine_node"] == nil or gs.GoUtil.IsCompNull(self.m_bipColliderDic["Spine_node"]) then
            self.m_bipColliderDic["Spine_node"] = node_2.gameObject:AddComponent(ty.BoxCollider)
            self.m_bipColliderDic["Spine_node"].size = gs.Vector3(0.35, 0.54, 0.39)
        end

        local function onPointDown()
            if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count > 1 then
                return
            end

            self:setTrigger("show")
        end

        local function onPointUp()

        end

        local mouseEvent = node_2.gameObject:GetComponent(ty.GoMouseEvent)
        if mouseEvent == nil or gs.GoUtil.IsCompNull(mouseEvent) then
            mouseEvent = node_2.gameObject:AddComponent(ty.GoMouseEvent)
            mouseEvent:SetCallFun(self, nil, onPointDown, onPointUp, nil)
        end
    else
        self:removeInteractCollider("Spine_node")
    end

    if stateHash == gs.Animator.StringToHash("Xidle02_body") then
        local node_2 = gs.GameObject.Find("Bip001 L Foot").transform
        self.m_bipColliderDic["Bip001_L_Foot"] = node_2.gameObject:GetComponent(ty.BoxCollider)
        if self.m_bipColliderDic["Bip001_L_Foot"] == nil or gs.GoUtil.IsCompNull(self.m_bipColliderDic["Bip001_L_Foot"]) then
            self.m_bipColliderDic["Bip001_L_Foot"] = node_2.gameObject:AddComponent(ty.BoxCollider)
            self.m_bipColliderDic["Bip001_L_Foot"].size = gs.Vector3(0.2, 0.2, 0.2)
        end

        local function onPointDown()
            self.m_startMousePos = gs.Input.mousePosition
            self.m_operateMousePoint = nil

            self:setInt("twist_state", 1)

            self:setFloat("twist_x", 0)
            self:setFloat("twist_y", 0)

            self.m_show02Time = 0
            self:setFloat("twist_time", 0)

            self.m_twistFrameSn = LoopManager:addFrame(1, 0, self, self.onTwistFrame)
        end

        local function onPointUp()
            self:clearTwistFrame()

            self.m_startMousePos = nil

            if self.m_show02Time > 0.6 then
                self:setTrigger("show")
            else
                self:setInt("twist_state", 0)
            end
        end

        self:setInt("twist_state", 0)

        local mouseEvent = node_2.gameObject:GetComponent(ty.GoMouseEvent)
        if mouseEvent == nil or gs.GoUtil.IsCompNull(mouseEvent) then
            mouseEvent = node_2.gameObject:AddComponent(ty.GoMouseEvent)
            mouseEvent:SetCallFun(self, nil, onPointDown, onPointUp, nil)
        end
    else
        self:removeInteractCollider("Bip001_L_Foot")
    end

    if stateHash == gs.Animator.StringToHash("Xidle03_body") then

        if self.m_siwaMaterial then
            self:setFloat("siwa_val", 0)

            self.m_siwaMaterial:EnableKeyword("_REPLACE_CLOTH_ON")

            local node_2 = gs.GameObject.Find("Bip001 L Calf").transform
            self.m_bipColliderDic["Bip001_L_Calf"] = node_2.gameObject:GetComponent(ty.BoxCollider)
            if self.m_bipColliderDic["Bip001_L_Calf"] == nil or gs.GoUtil.IsCompNull(self.m_bipColliderDic["Bip001_L_Calf"]) then
                self.m_bipColliderDic["Bip001_L_Calf"] = node_2.gameObject:AddComponent(ty.BoxCollider)
                self.m_bipColliderDic["Bip001_L_Calf"].size = gs.Vector3(0.8, 0.4, 0.1)
            end

            self.m_siwaValue = 0
            self.m_faceValue = 0

            local function onPointDown()
                self:setInt("siwa_state", 1)

                self.m_startMousePos = self.m_camera:ScreenToViewportPoint(gs.Input.mousePosition)

                self.m_siwaFrameSn = LoopManager:addFrame(1, 0, self, self.onSiWaFrame)
            end

            local function onPointUp()
                if self.m_siwaValue > 0.4 then
                    self:setTrigger("show")
                else
                    self:setInt("siwa_state", 0)
                end

                self:clearSiWaFrame()

                self.m_startMousePos = nil
            end

            self:setInt("siwa_state", 0)

            local mouseEvent = node_2.gameObject:GetComponent(ty.GoMouseEvent)
            if mouseEvent == nil or gs.GoUtil.IsCompNull(mouseEvent) then
                mouseEvent = node_2.gameObject:AddComponent(ty.GoMouseEvent)
                mouseEvent:SetCallFun(self, nil, onPointDown, onPointUp, nil)
            end
        end
    else
        self:removeInteractCollider("Bip001_L_Calf")
    end
end

function removeInteractCollider(self, goName)
    if self.m_bipColliderDic == nil then
        return
    end

    if goName == nil then
        for _, v in pairs(self.m_bipColliderDic) do
            gs.GameObject.Destroy(v)
        end

        self.m_bipColliderDic = nil
        return
    end

    if self.m_bipColliderDic[goName] ~= nil and not gs.GoUtil.IsCompNull(self.m_bipColliderDic[goName]) then
        gs.GameObject.Destroy(self.m_bipColliderDic[goName])
        self.m_bipColliderDic[goName] = nil
    end
end

function onTwistFrame(self, deltaTime)
    if self.m_startMousePos == nil then
        return
    end

    local curVal = (self.m_startMousePos.x - gs.Input.mousePosition.x) / 500
    self.m_show02Time = gs.Mathf.Lerp(self.m_show02Time, curVal, deltaTime)

    self.m_show02Time = math.min(self.m_show02Time, 1)
    self.m_show02Time = math.max(self.m_show02Time, 0)
    self:setFloat("twist_time", self.m_show02Time)

    self.m_faceValue = self.m_show02Time
    self.m_faceValue = math.min(self.m_faceValue, 0.8)
    self.m_faceValue = math.max(self.m_faceValue, 0)

    if self.m_show02Time >= 1 then
        if self.m_operateMousePoint == nil then
            self.m_operateMousePoint = gs.Input.mousePosition
        end

        local direction = (gs.Input.mousePosition - self.m_operateMousePoint) * 0.008

        self.m_dragMouse = gs.Vector3.Lerp(self.m_dragMouse, direction, deltaTime)

        local direction_x = self.m_dragMouse.x
        direction_x = math.min(direction_x, 1)
        direction_x = math.max(direction_x, -1)

        local direction_y = self.m_dragMouse.y
        direction_y = math.min(direction_y, 1)
        direction_y = math.max(direction_y, -1)

        self:setFloat("twist_x", direction_x)
        self:setFloat("twist_y", direction_y)
    end

    self.m_faceMaterial:SetFloat("_BlushIntensity", self.m_faceValue)
end

function clearTwistFrame(self)
    if self.m_twistFrameSn then
        LoopManager:removeFrameByIndex(self.m_twistFrameSn)
        self.m_twistFrameSn = nil
    end
end

function onSiWaFrame(self, deltaTime)
    local viewPos = self.m_camera:ScreenToViewportPoint(gs.Input.mousePosition)
    local curVal = (self.m_startMousePos.y - viewPos.y) * deltaTime * 30
    -- curVal = math.min(curVal, 0.01)
    self.m_siwaValue = self.m_siwaValue + curVal

    self.m_siwaValue = math.min(self.m_siwaValue, 1)
    self.m_siwaValue = math.max(self.m_siwaValue, 0)

    self:setFloat("siwa_val", self.m_siwaValue)
    self.m_siwaMaterial:SetFloat("_NewClothesReplaceValue", self.m_siwaValue)

    if gs.Input.mousePosition.y < self.m_startMousePos.y then
        local _curVal = (self.m_startMousePos.y - viewPos.y) * deltaTime * 30
        -- curVal = math.min(curVal, 0.01)
        self.m_faceValue = self.m_faceValue + _curVal

        self.m_faceValue = math.min(self.m_faceValue, 0.5)
        self.m_faceValue = math.max(self.m_faceValue, 0)

        self.m_faceMaterial:SetFloat("_BlushIntensity", self.m_faceValue)
    end

    self.m_startMousePos = viewPos
end

function clearSiWaFrame(self)
    if self.m_siwaFrameSn then
        LoopManager:removeFrameByIndex(self.m_siwaFrameSn)
        self.m_siwaFrameSn = nil
    end
end

-- function onScreenDrag(self)
-- end

-- function onScreenDragEnd(self)

-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
