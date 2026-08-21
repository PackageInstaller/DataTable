-- @FileName:   BigHostel_Model_4523_3_h.lua
-- @Description:   大宿舍红叶模型
-- @Author: ZDH
-- @Date:   2025-04-21 18:17:45
-- @Copyright:   (LY) 2025 锚点降临

module('game.bigHostel.model.BigHostel_Model_4523_3_h', Class.impl(bigHostel.BigHostelBaseModel))

--允许切换场景的状态
Idle_State = {
    gs.Animator.StringToHash("Xidle01_body"),
    gs.Animator.StringToHash("Xidle02_body"),
    gs.Animator.StringToHash("Xidle03_body"),
}

--允许注视鼠标的动画
LookAtAniState =
{
    cameraReset_state =
    {
        gs.Animator.StringToHash("Xidle01_body"),
    },
    cameraFree_state =
    {
        gs.Animator.StringToHash("Xidle01_body"),
    },
}
--注视鼠标人物前的距离
LookAtDistance = 0.5

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
    [gs.Animator.StringToHash("showStart")] = {{res = "4523/sfx_role_4523_3_h_01.prefab", layback = 7733}},
    [gs.Animator.StringToHash("Xshow01_body")] = {{res = "4523/sfx_role_4523_3_h_02.prefab", layback = 0}},
    [gs.Animator.StringToHash("Xshow02_body")] = {{res = "4523/sfx_role_4523_3_h_03.prefab", layback = 0}},
    [gs.Animator.StringToHash("Xshow03_body")] = {{res = "4523/sfx_role_4523_3_h_04.prefab", layback = 6283}},
}

--需要添加自由相机的动作及参数
FreeCamera_AniState =
{
    -- 动作名、相机聚焦点、默认距离、最小距离、最大距离、横向最小角度、横向最大角度、纵向最小角度、纵向最大角度
    -- [gs.Animator.StringToHash("Xidle01_body")] = {lookNode = "Look_node_1", minDistance = 1.2, maxDistance = 2.946, minimumX = 145, maximumX = 220, minimumY = 340, maximumY = 400},
    -- [gs.Animator.StringToHash("Xidle02_body")] = {lookNode = "Look_node_2", minDistance = 0.9, maxDistance = 2.5, minimumX = -20, maximumX = 50, minimumY = 350, maximumY = 400},
    -- [gs.Animator.StringToHash("Xidle03_body")] = {lookNode = "Look_node_3", minDistance = 0.63, maxDistance = 2.0, minimumX = 300, maximumX = 400, minimumY = 340, maximumY = 420},
}

--注视鼠标的最大权重 (为 0  不开启注视鼠标)
Max_LookWeight = 1
--头部注视权重
LookAt_HeadWeight = 0.5
--眼部注视权重
LookAt_eyeWeight = 1

--注视鼠标的速度
LookAtSpeed = 5

-- --头部注视角度限制(纵向/横向为0表示不做限制)
--LimitLookAngle = {minVertical = 30, maxVertical = 45, minHorizontal = 0, maxHorizontal = 0}

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

    -- self:clearHeadFrame()
    self:clearTwistFrame()
    self:clearSiWaFrame()
end

function loadFinish(self)
    super.loadFinish(self)

    --------------------旧版本兼容--------------------------------------------
    --添加挂点帧监听
    local model_baseNode = gs.GameObject.Find("MODEL_NODE").transform
    if model_baseNode == nil or gs.GoUtil.IsTransNull(model_baseNode) then
        logError("场景节点挂点为空！！！" .. "MODEL_NODE")
        return
    end

    local count = model_baseNode.childCount
    if count <= 0 then
        logError("MODEL_NODE 下不存在挂点")
        return
    end

    for i = 0, count - 1 do
        local node = model_baseNode:GetChild(i)
        local function call()
            self:setParent(node)
        end
        self.m_aniCall:AddFrameEventCall("NODE_" .. (i + 1), call)
    end

    --添加灯光帧监听
    local light_parent = gs.GameObject.Find("LIGHT").transform
    if light_parent == nil or gs.GoUtil.IsTransNull(light_parent) then
        logError("场景节点挂点为空！！！" .. "LIGHT")
        return
    end

    count = light_parent.childCount
    if count <= 0 then
        logError("LIGHT 下不存在挂点")
        return
    end

    for i = 0, count - 1 do
        local function call()
            for j = 0, count - 1 do
                local node = light_parent:GetChild(j)
                node.gameObject:SetActive(j == i)
            end
        end
        self.m_aniCall:AddFrameEventCall("LIGHT_" .. (i + 1), call)
    end

    --添加Clip帧事件监听（美术那边添加）
    --显示UI
    local function showMainUI()
        GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_SCENEUI)
    end
    self.m_aniCall:AddFrameEventCall("SHOW_MAINUI", showMainUI)
    --不显示UI
    local function closeMainUI()
        GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_SCENEUI)
    end
    self.m_aniCall:AddFrameEventCall("HIDE_MIANUI", closeMainUI)
    --显示黑屏
    local function showBlack()
        GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_BLACK)
    end
    self.m_aniCall:AddFrameEventCall("SHOW_BLACK", showBlack)
    ---不显示黑屏
    local function closeBlack()
        GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
    end
    self.m_aniCall:AddFrameEventCall("CLOSE_BLACK", closeBlack)

    ---------------------------------------------------------------------------------------------

    local node = gs.GameObject.Find("4523_3_h_Face")
    if node and not gs.GoUtil.IsGoNull(node) then
        local skinnedMeshRenderer = node:GetComponent(ty.SkinnedMeshRenderer)

        for i = 0, skinnedMeshRenderer.materials.Length - 1 do
            if string.find(skinnedMeshRenderer.materials[i].name, "Face") then
                self.m_faceMaterial = skinnedMeshRenderer.materials[i]
                break
            end
        end
    end

    node = gs.GameObject.Find("4523_3_h_Body")
    if node and not gs.GoUtil.IsGoNull(node) then
        local skinnedMeshRenderer = node:GetComponent(ty.SkinnedMeshRenderer)

        for i = 0, skinnedMeshRenderer.materials.Length - 1 do
            if string.find(skinnedMeshRenderer.materials[i].name, "siwa") then
                self.m_siwaMaterial = skinnedMeshRenderer.materials[i]
                break
            end
        end
    end

    self:addAnimationClipEvent("Xshow03_body", 400, nil, function(_key)
        self.m_siwaMaterial:SetFloat("_NewClothesReplaceValue", 0)
    end)

    self:addAnimationClipEvent("Xshow03_face", 450, nil, function(_key)
        self.m_faceMaterial:SetFloat("_BlushIntensity", 0)
    end)

    self:addAnimationClipEvent("Xshow02_face", 200, nil, function(_key)
        self.m_faceMaterial:SetFloat("_BlushIntensity", 0)
    end)

    self:addAnimationClipEvent("Xidle01_face", 1, nil, function(_key)
        self.m_faceMaterial:SetFloat("_BlushIntensity", 0)
    end)
end

function addEventListener(self)
    super.addEventListener(self)

end

function removeEventListener(self)
    super.removeEventListener(self)

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
        local function onPointDown()

            self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
        end

        local function onPointUp()

        end

        self:addBoxColliderEventByName("Bip001 Neck", gs.Vector3(0.3, 0.3, 0.3), gs.Vector3(0, 0, 0), onPointDown, onPointUp)

        -- local node_2 = self.m_FBBIK.solver.headMapping.bone.gameObject
        -- self.m_bipColliderDic["head_node"] = node_2:GetComponent(ty.BoxCollider)
        -- if self.m_bipColliderDic["head_node"] == nil or gs.GoUtil.IsCompNull(self.m_bipColliderDic["head_node"]) then
        --     self.m_bipColliderDic["head_node"] = node_2:AddComponent(ty.SphereCollider)
        --     gs.UnityEngineUtil.InitSphereCollider(self.m_bipColliderDic["head_node"], 0.1, -0.08, 0, 0)
        -- end

        -- local function onPointDown()
        --     self.m_DragQuadDic["Idle01_Head"]:SetActive(true)
        --     self.m_leftHandPos = self.m_FBBIK.solver.leftHandEffector.bone.position
        --     self.m_rightHandPos = self.m_FBBIK.solver.rightHandEffector.bone.position

        --     self.m_FBBIK.solver.leftHandEffector.position = self.m_leftHandPos
        --     self.m_FBBIK.solver.rightHandEffector.position = self.m_rightHandPos

        --     self.m_FBBIK.solver.leftHandEffector.positionWeight = 1
        --     self.m_FBBIK.solver.rightHandEffector.positionWeight = 1

        --     self:lockLookAt(true)
        --     -- self:lookAtWeight(1, 0.1, 1, 0, 0.95, 0.2, 0.5)
        --     self:lookAtWeight(1, 0.1, 1, 0)

        --     self.m_headFrameSn = LoopManager:addFrame(1, 0, self, self.onHeadFrame)
        -- end

        -- local function onPointUp()
        --     self.m_DragQuadDic["Idle01_Head"]:SetActive(false)

        --     self.m_FBBIK.solver.leftHandEffector.positionWeight = 0
        --     self.m_FBBIK.solver.rightHandEffector.positionWeight = 0

        --     self:lockLookAt(false)

        --     self:clearHeadFrame()
        -- end

        -- local mouseEvent = node_2.gameObject:GetComponent(ty.GoMouseEvent)
        -- if mouseEvent == nil or gs.GoUtil.IsCompNull(mouseEvent) then
        --     mouseEvent = node_2.gameObject:AddComponent(ty.GoMouseEvent)
        --     mouseEvent:SetCallFun(self, nil, onPointDown, onPointUp, nil)
        -- end
    else
        self:removeBoxColliderEventByName("Bip001 Neck")
        -- self:removeBoxColliderEventByName("head_node")
    end

    if stateHash == gs.Animator.StringToHash("Xidle02_body") then
        self:setInt("twist_state", 0)

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
                self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
            else
                self:setInt("twist_state", 0)
            end
        end

        self:addBoxColliderEventByName("Bip001 L Foot", gs.Vector3(0.2, 0.2, 0.2), nil, onPointDown, onPointUp)
    else
        if stateHash ~= gs.Animator.StringToHash("Twist_move") then
            self:removeBoxColliderEventByName("Bip001 L Foot")
        end
    end

    if stateHash == gs.Animator.StringToHash("Xidle03_body") then
        if self.m_siwaMaterial then
            self.m_siwaMaterial:EnableKeyword("_REPLACE_CLOTH_ON")

            self.m_siwaValue = 0
            self.m_faceValue = 0

            local function onPointDown()
                self:setInt("siwa_state", 1)

                self.m_siwaFrameSn = LoopManager:addFrame(1, 0, self, self.onSiWaFrame)
            end

            local function onPointUp()
                if self.m_siwaValue > 0.7 then
                    self:setTrigger(BigHostelConst.BaseAnimatorParams.Show)
                else
                    self:setInt("siwa_state", 0)
                end

                self:clearSiWaFrame()

                self.m_startMousePos = nil
            end

            self:setInt("siwa_state", 0)

            self:addBoxColliderEventByName("Bip001 L Calf", gs.Vector3(0.8, 0.4, 0.1), nil, onPointDown, onPointUp)
        end

        --IK拖拽屁股
        local drag_panel = self.m_DragQuadDic["Idle03_Pelvs"]
        local node = self.m_FBBIK.references.pelvis.gameObject
        local drag_bones =
        {
            BigHostelConst.FullBodyBipedEffector.LeftThigh,
            BigHostelConst.FullBodyBipedEffector.RightThigh,
            BigHostelConst.FullBodyBipedEffector.LeftHand,
        }

        local limit = {min_x = 0.03, max_x = 0.03, min_y = 0.05, max_y = 0.05, min_z = 0.03, max_z = 0.03}
        self:addIKDragVo("Xidle03_body_Pelvis", node, {x = 0.2, y = 0.2, z = 0.2}, drag_panel, drag_bones, nil, nil, nil, limit, 8, 8)
    else
        self:clearSiWaFrame()
        self:removeBoxColliderEventByName("Bip001 L Calf")

        self:recoverIKDragVo("Xidle03_body_Pelvis")
    end

    if stateHash ~= gs.Animator.StringToHash("Xidle03_body") and stateHash ~= gs.Animator.StringToHash("Xshow03_body") and stateHash ~= gs.Animator.StringToHash("Xleave03_body") then
        self.m_siwaMaterial:SetFloat("_NewClothesReplaceValue", 0)
    end
end

-- function onHeadFrame(self, deltaTime)
--     local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(self.m_camera, "Event", 500)
--     if hitInfo and hitInfo.collider then
--         self:lookAtPosition(hitInfo.point, 5)
--     end
-- end

-- function clearHeadFrame(self)
--     if self.m_headFrameSn then
--         LoopManager:removeFrameByIndex(self.m_headFrameSn)
--         self.m_headFrameSn = nil
--     end
-- end

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
    if self.m_startMousePos then
        local curVal = (self.m_startMousePos.y - viewPos.y) * deltaTime * 30
        self.m_siwaValue = self.m_siwaValue + curVal

        self.m_siwaValue = math.min(self.m_siwaValue, 1)
        self.m_siwaValue = math.max(self.m_siwaValue, 0)

        self.m_siwaMaterial:SetFloat("_NewClothesReplaceValue", self.m_siwaValue)

        if gs.Input.mousePosition.y < self.m_startMousePos.y then
            local _curVal = (self.m_startMousePos.y - viewPos.y) * deltaTime * 30
            self.m_faceValue = self.m_faceValue + _curVal

            self.m_faceValue = math.min(self.m_faceValue, 0.5)
            self.m_faceValue = math.max(self.m_faceValue, 0)

            self.m_faceMaterial:SetFloat("_BlushIntensity", self.m_faceValue)
        end
    end

    self.m_startMousePos = viewPos
end

function clearSiWaFrame(self)
    if self.m_siwaFrameSn then
        LoopManager:removeFrameByIndex(self.m_siwaFrameSn)
        self.m_siwaFrameSn = nil
    end
end

function onFrame(self)
    super.onFrame(self)

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
