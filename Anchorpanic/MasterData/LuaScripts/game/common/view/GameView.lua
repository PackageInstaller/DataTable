module("GameView", Class.impl())

function ctor(self)
    local goPoolCache = gs.GameObject.Find("[POOL_CACHE]")
    gs.GoUtil.DontDestroyOnLoad(goPoolCache)
    gs.GOPoolMgr:Setup(goPoolCache.transform)

    UICache = goPoolCache.transform:Find("[UI_CACHE]").gameObject
    gs.GoUtil.DontDestroyOnLoad(UICache)
    UICache:SetActive(false)
    UICache = UICache.transform

    UINode = {}
    stage = gs.GameObject.Find("[UI_ROOT]")
    if not stage then
        Debug:log_error("GameView", "UI_ROOT is null")
        return
    end
    gs.GoUtil.DontDestroyOnLoad(stage)
    local rootTrans = stage.transform
    scene = rootTrans:Find("SCENE")
    UINode["SCENE"] = scene

    mainUI = rootTrans:Find("MAIN_UI")
    UINode["MAIN_UI"] = mainUI
    pop = rootTrans:Find("POP")
    UINode["POP"] = pop

    subPop = rootTrans:Find("SUB_POP")
    UINode["SUB_POP"] = subPop
    -- gs.UIBlurManager.RegisterNode1("SUB_POP", subPop)
    story = rootTrans:Find("STORY")
    UINode["STORY"] = story
    guide = rootTrans:Find("GUIDE")
    UINode["GUIDE"] = guide
    -- gs.UIBlurManager.RegisterNode1("GUIDE", guide)
    loading = rootTrans:Find("LOADING")
    UINode["LOADING"] = loading
    -- gs.UIBlurManager.RegisterNode1("LOADING", loading)
    alert = rootTrans:Find("ALERT")
    UINode["ALERT"] = alert
    -- gs.UIBlurManager.RegisterNode1("ALERT", alert)
    msg = rootTrans:Find("MSG")
    UINode["MSG"] = msg

    touchEffect = rootTrans:Find("TOUCH_EFFECT")
    UINode["TOUCH_EFFECT"] = touchEffect

    gm = rootTrans:Find("GM")
    UINode["GM"] = gm
    -- gs.UIBlurManager.RegisterNode1("MSG", msg)

    -- stage2 = gs.GameObject.Find("[UI_ROOT2]")
    -- gs.GoUtil.DontDestroyOnLoad(stage2)
    -- local rootTrans2 = stage2.transform
    -- subPop = rootTrans2:Find("SUB_POP")
    -- gs.UIBlurManager.RegisterNode2("SUB_POP", subPop)
    -- UINode["SUB_POP"] = subPop
    -- story = rootTrans2:Find("STORY")
    -- gs.UIBlurManager.RegisterNode2("STORY", story)
    -- UINode["STORY"] = story
    -- guide = rootTrans2:Find("GUIDE")
    -- gs.UIBlurManager.RegisterNode2("GUIDE", guide)
    -- UINode["GUIDE"] = guide
    -- loading = rootTrans2:Find("LOADING")
    -- gs.UIBlurManager.RegisterNode2("LOADING", loading)
    -- UINode["LOADING"] = loading
    -- alert = rootTrans2:Find("ALERT")
    -- gs.UIBlurManager.RegisterNode2("ALERT", alert)
    -- UINode["ALERT"] = alert
    -- msg = rootTrans2:Find("MSG")
    -- gs.UIBlurManager.RegisterNode2("MSG", msg)
    -- UINode["MSG"] = msg

    local tmpLayer = rootTrans:Find("EDITOR_TEMP_LAYER")
    if tmpLayer then
        gs.GameObject.Destroy(tmpLayer.gameObject)
    end
    local tmpGO = gs.GameObject.Find("[EDITOR_GO]")
    if tmpGO then
        gs.GameObject.Destroy(tmpGO)
    end

    local cameraGOs = gs.GameObject.Find("[CAMERAs]")
    gs.GoUtil.DontDestroyOnLoad(cameraGOs)

    local cameraParentTrans = cameraGOs.transform
    gs.CameraMgr:SetCameraRoot(cameraParentTrans)

    local cameraGO = cameraParentTrans:Find("[UI_CAMERA]").gameObject
    gs.CameraMgr:SetUICamera(cameraGO:GetComponent(ty.Camera))

    cameraGO = cameraParentTrans:Find("[UI_CAMERA2]").gameObject
    gs.CameraMgr:SetUICamera2(cameraGO:GetComponent(ty.Camera))

    cameraGO = cameraParentTrans:Find("[SCENE_CAMERA]").gameObject
    --cameraGO:GetComponent(ty.Camera).depth = 1
    gs.CameraMgr:SetDefSceneCamera(cameraGO:GetComponent(ty.Camera))

    cameraGO = cameraParentTrans:Find("[RENDER_TEXTURE_CAMERA]").gameObject
    gs.CameraMgr:SetTextureCamera(cameraGO:GetComponent(ty.Camera))
    TextureCameraHandler:setTextureCameraGO(cameraGO)

    cameraGO = cameraParentTrans:Find("[STAND_OUT_CAMERA]").gameObject
    gs.CameraMgr:SetStandOutCamera(cameraGO:GetComponent(ty.Camera))
    -- StandOut3DHandler:setStandOutCameraGO(cameraGO)

    SubLayerMgr:setTagLayer(gud.SLAYER_BAR, "BAR", UrlManager:getPrefabPath("base/EmptyLayer.prefab"), scene)
    SubLayerMgr:setTagLayer(gud.SLAYER_FLOAT, "FLOAT", UrlManager:getPrefabPath("base/EmptyLayer.prefab"), scene)
    SubLayerMgr:setTagLayer(gud.SPINE_BLACK, "SPINE_BLACK", UrlManager:getPrefabPath("base/BlackLayer.prefab"), scene)
    
    local blackLayer = SubLayerMgr:getLayer(gud.SPINE_BLACK)
    if blackLayer and not gs.GoUtil.IsTransNull(blackLayer) then
        blackLayer.gameObject:SetActive(false)
    end
    -- local floatLayer = SubLayerMgr:getLayer(gud.SLAYER_FLOAT)
    -- gs.TransQuick:SetRotation(floatLayer, 20, 0, 0)
    -- LoopManager:setTimeout(1,self, self._afterLoadRootUI)

    -- gs.TransQuick:PosY(gs.CameraMgr:GetUICamera2().transform, 510)
    -- stage:GetComponent(ty.Canvas).sortingOrder = 0
    -- stage2:GetComponent(ty.Canvas).sortingOrder = 0

    if gs.ApplicationUtil.IsPC() then
        local cursor = gs.ResMgr:LoadTexture("arts/texture/customUI/MouseIcon.png")
        CS.UnityEngine.Cursor.SetCursor(cursor, gs.Vector2.zero, CS.UnityEngine.CursorMode.Auto)
    end

    local uidTrans = msg:Find("UID")
    if(uidTrans and not gs.GoUtil.IsTransNull(uidTrans))then
        local uidText = gs.GoUtil.AddComponent(uidTrans.gameObject, ty.Text)
        UINode["UID"] = uidText
    else
        local uidGo = gs.GameObject()
        uidGo.name = "UID"
        uidGo.transform:SetParent(msg, false)
        gs.GoUtil.AddComponent(uidGo, ty.Outline)
        local uidRect = gs.GoUtil.AddComponent(uidGo, ty.RectTransform)
        local uidText = gs.GoUtil.AddComponent(uidGo, ty.Text)
        uidText.font = gs.ResMgr:Load("arts/fonts/font/SourceHanSansCN-Medium.otf")
        uidText.fontSize = 16
        uidText.raycastTarget = false
        UINode["UID"] = uidText

        gs.TransQuick:SizeDelta(uidGo.transform, 500, 20)
        uidText.alignment = gs.TextAnchor.MiddleRight
        uidRect.anchorMin = gs.Vector2(1, 0)
        uidRect.anchorMax = gs.Vector2(1, 0)
        uidRect.pivot = gs.Vector2(1, 0)
        uidRect.anchoredPosition = gs.Vector2(-40, 0)
    end
end

function setUIDNode(self,isAct)
    UINode["UID"].gameObject:SetActive(isAct)
end

function SceneStoryHideUI(self)
    -- mainUI = rootTrans:Find("MAIN_UI")
    UINode["MAIN_UI"].gameObject:SetActive(false)
    -- pop = rootTrans:Find("POP")
    UINode["POP"].gameObject:SetActive(false)

    -- subPop = rootTrans:Find("SUB_POP")
    UINode["SUB_POP"].gameObject:SetActive(false)

    UINode["SCENE"].gameObject:SetActive(false)
end

function SceneStoryShowUI(self)
    -- mainUI = rootTrans:Find("MAIN_UI")
    UINode["MAIN_UI"].gameObject:SetActive(true)
    -- pop = rootTrans:Find("POP")
    UINode["POP"].gameObject:SetActive(true)

    -- subPop = rootTrans:Find("SUB_POP")
    UINode["SUB_POP"].gameObject:SetActive(true)

    UINode["SCENE"].gameObject:SetActive(true)
end
-- function _afterLoadRootUI()
-- 	gs.LightMgr:SetOpenUIGlobalModelLigth(false)
-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]