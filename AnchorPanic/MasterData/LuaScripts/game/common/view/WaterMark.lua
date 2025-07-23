module("WaterMark", Class.impl())

function ctor(self)

    self:initWatermark()
end

-- 水印系统初始化
function initWatermark(self)
    local waterMaskGo = gs.GameObject.Find("[WATER_MASK]")
    if not waterMaskGo then
        waterMaskGo = AssetLoader.GetGO(UrlManager:getPrefabPath("base/[WATER_MASK].prefab"), self)
        self.waterMaskRoot = waterMaskGo.transform
        local launchGo = gs.GameObject.Find("GameLaunch")
        self.waterMaskRoot:SetParent(launchGo.transform, false)
        local canvas = waterMaskGo:GetComponent(ty.Canvas)
        local camera = gs.CameraMgr:GetUICamera2()
        canvas.worldCamera = camera
    end
    -- 创建渲染载体
    local rendererObj = gs.GameObject("WatermarkRenderer")
    rendererObj.transform:SetParent(GameView.gm.transform, false)
    rendererObj.layer = gs.LayerMask.NameToLayer("UI_SUB")
    local uidRect = gs.GoUtil.AddComponent(rendererObj, ty.RectTransform)
    uidRect.anchorMin = gs.Vector2(0, 0)
    uidRect.anchorMax = gs.Vector2(1, 1)
    uidRect.pivot = gs.Vector2(0.5, 0.5)

    -- 添加核心组件
    self.rawImage = gs.GoUtil.AddComponent(rendererObj, ty.RawImage)
    self.rawImage.raycastTarget = false
    -- self.material = gs.Material(gs.Shader.Find("Leiyan/UI/WatermarkTiling"))

    self.material = gs.ResMgr:Load(UrlManager:getUIMaterial("WatermarkTiling.mat"))

    self.rawImage.material = self.material


    self.rawImgPos = self.rawImage.transform.position
    self.rawImageScale = self.rawImage.transform.localScale
    self.rawImageRotation = self.rawImage.transform.rotation
    self.rawImgColor = self.rawImage.color

end

-- 更新水印内容
function updateWatermark(self, text, rotation)

    self.textLen = #text
    -- 生成新纹理
    local newTex = self:GenerateWatermarkTexture(text)

    -- 更新材质参数
    self.material:SetTexture("_MainTex", newTex)
    self.material:SetFloat("_Rotation", math.rad(rotation))

    -- 自动适配平铺
    local aspect = gs.Screen.width / gs.Screen.height
    self.material:SetVector("_Tiling", gs.Vector4(aspect * 8, 12, 0, 0))

    -- 偏移设置
    -- self.material:SetVector("_Offset", gs.Vector4(0, 0, 0, 0))

    self.rawImage.enabled = false
    self.rawImage.enabled = true  -- 禁用再启用以刷新状态


    if self.frameSn then
        LoopManager:removeFrameByIndex(self.frameSn)
        self.frameSn = nil
    end
    self.frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)
end

-- 生成水印纹理
function GenerateWatermarkTexture(self, templateText)
    -- 创建临时渲染环境
    local camera = gs.CameraMgr:GetUICamera2()
    camera.gameObject:SetActive(true)

    local size = 256 * self.textLen / 9
    -- 配置渲染纹理
    local rt = gs.RenderTexture(size, 256, 0)
    rt.name = "rt_watermask"
    camera.targetTexture = rt

    local uidText = self.waterMaskRoot:Find("mask_txt")
    uidText.gameObject:SetActive(true)
    -- 创建文本对象
    uidText:GetComponent(ty.Text).text = templateText

    -- 执行渲染
    camera:Render()

    -- 显式释放RenderTexture
    rt:Release()

    return rt
end

function onFrame(self)
    if self.rawImage.texture ~= nil then
        self.rawImgTex = self.rawImage.texture
    end
    if self.rawImage.enabled == false or self.rawImage.gameObject.enabled == false or self.rawImage.transform.position ~= self.rawImgPos
    or self.rawImgColor ~= self.rawImage.color or self.rawImageScale ~= self.rawImage.transform.localScale or self.rawImageRotation ~= self.rawImage.transform.rotation
    -- or self.rawImgTex ~= self.rawImage.texture then
        then
        if self.frameSn then
            LoopManager:removeFrameByIndex(self.frameSn)
            self.frameSn = nil
        end
        UIFactory:alertOK0("警告", "想干嘛？当内鬼？遵纪守法哦~", function()
            GameDispatcher:dispatchEvent(EventName.REQ_EXIT_GAME, { isCleanGameRes = false, isCleanServerInfo = false, isNeedLoginSdk = true, isNeedRunUpdate = false })
        end)
    end
end

function destroy(self)
    if self.frameSn then
        LoopManager:removeFrameByIndex(self.frameSn)
        self.frameSn = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]