module("PostHandler", Class.impl())

function ctor(self)
    self.m_chromaticTween = nil
end
-- 还原色散
function resetChromatic(self)
    if self.m_chromaticTween then
        self.m_chromaticTween:Kill()
        self.m_chromaticTween = nil
    end
    if self.mChromaticToggle ~= nil then
        local post = gs.CameraMgr:GetSceneCameraTrans():GetComponent(ty.PostProcessing)
        if post and not gs.GoUtil.IsCompNull(post) then
            post.ChromaticAberrationToggle = self.mChromaticToggle
            post.ChromaticAberrationAmount = self.mChromaticAmount
            post.ChromaticAberrationStep = self.mChromaticStep
        end
        -- self.mChromaticToggle = nil
        -- self.mChromaticAmount = nil
        -- self.mChromaticStep = nil
    end

    self:resetBloomIntensity()
end

-- 进场景初始化色散值
function initChromatioc(self)
    if not gs.GoUtil.IsCompNull(gs.CameraMgr:GetSceneCameraTrans()) then
        local post = gs.CameraMgr:GetSceneCameraTrans():GetComponent(ty.PostProcessing)
        if post and not gs.GoUtil.IsCompNull(post) then
            self.mChromaticToggle = post.ChromaticAberrationToggle
            self.mChromaticAmount = post.ChromaticAberrationAmount
            self.mChromaticStep = post.ChromaticAberrationStep
        end
    end
end

-- 色散的调用
function chromaticTween(self, amount, startStep, endStep, duration)
    if not gs.GoUtil.IsCompNull(gs.CameraMgr:GetSceneCameraTrans()) then
        local post = gs.CameraMgr:GetSceneCameraTrans():GetComponent(ty.PostProcessing)
        if post and not gs.GoUtil.IsCompNull(post) then
            -- if self.mChromaticToggle == nil then
            --     self.mChromaticToggle = post.ChromaticAberrationToggle
            --     self.mChromaticAmount = post.ChromaticAberrationAmount
            --     self.mChromaticStep = post.ChromaticAberrationStep
            -- end
            local function _closeCall()
                if self.m_chromaticTween then
                    self.m_chromaticTween:Kill()
                    self.m_chromaticTween = nil
                end
                if not gs.GoUtil.IsCompNull(post) then
                    post.ChromaticAberrationToggle = self.mChromaticToggle
                    post.ChromaticAberrationAmount = self.mChromaticAmount
                    post.ChromaticAberrationStep = self.mChromaticStep
                end
            end
            if self.m_chromaticTween then
                self.m_chromaticTween:Kill()
                -- _closeCall()
            end

            local function _progressCall(val)
                if gs.GoUtil.IsCompNull(post) then
                    _closeCall()
                    return
                end
                post.ChromaticAberrationStep = val
            end
            post.ChromaticAberrationToggle = true
            post.ChromaticAberrationAmount = amount
            post.ChromaticAberrationStep = startStep
            -- duration = duration+0.5
            self.m_chromaticTween = gs.DT.DoTweenEx.DOProgressFloatVal(startStep, endStep, duration, _progressCall)
            self.m_chromaticTween:OnComplete(_closeCall)
        end
    else
        local tmpObj = gs.GameObject.Find("[SCamera]")
        if tmpObj then
            local cameraCom = tmpObj:GetComponent(ty.Camera)
            gs.CameraMgr:SetSceneCamera(cameraCom)
        end

        print("=============chromaticTween 色散调用: 场景摄像机不存在", gs.CameraMgr:GetSceneCameraTrans(), tmpObj.transform)
    end
end

-- bloom强度的缓动
function bloomIntensityTween(self, amount, startStep, endStep, duration, callFun)
    if not gs.GoUtil.IsCompNull(gs.CameraMgr:GetSceneCameraTrans()) then
        local post = gs.CameraMgr:GetSceneCameraTrans():GetComponent(ty.PostProcessing)
        if post and not gs.GoUtil.IsCompNull(post) then
            if self.mBloomIntensity == nil then
                self.mBloomIntensity = post.BloomIntensity
            end
            local function _closeCall()
                if self.mBloomIntensityTween then
                    self.mBloomIntensityTween:Kill()
                    self.mBloomIntensityTween = nil

                    if callFun then
                        callFun()
                    end
                end
                if not gs.GoUtil.IsCompNull(post) then
                    post.BloomIntensity = self.mBloomIntensity

                end
            end
            if self.mBloomIntensityTween then
                self.mBloomIntensityTween:Kill()
            end

            local function _progressCall(val)
                if gs.GoUtil.IsCompNull(post) then
                    _closeCall()
                    return
                end
                post.BloomIntensity = val
            end
            post.BloomIntensity = startStep
            self.mBloomIntensityTween = gs.DT.DoTweenEx.DOProgressFloatVal(startStep, endStep, duration, _progressCall)
            self.mBloomIntensityTween:OnComplete(_closeCall)
        end
    else
        local tmpObj = gs.GameObject.Find("[SCamera]")
        if tmpObj then
            local cameraCom = tmpObj:GetComponent(ty.Camera)
            gs.CameraMgr:SetSceneCamera(cameraCom)
        end
    end
end

-- 重置bloom强度值
function resetBloomIntensity(self)
    if self.mBloomIntensityTween then
        self.mBloomIntensityTween:Kill()
        self.mBloomIntensityTween = nil
    end
    if self.mBloomIntensity ~= nil then
        local post = gs.CameraMgr:GetSceneCameraTrans():GetComponent(ty.PostProcessing)
        if post and not gs.GoUtil.IsCompNull(post) then
            post.BloomIntensity = self.mBloomIntensity
        end
        self.mBloomIntensity = nil
    end
end

-- 设置bloom所有值
function setBloomValue(self, cameraTrans, intensity, color, radius, gamma, threshold, softKnee, sampleScale)
    self.mCameraTrans = cameraTrans or gs.CameraMgr:GetSceneCameraTrans()
    if not gs.GoUtil.IsCompNull(self.mCameraTrans) then
        local post = self.mCameraTrans:GetComponent(ty.PostProcessing)
        if post and not gs.GoUtil.IsCompNull(post) then
            if self.mBloomIntensity == nil then
                self.mBloomIntensity = post.BloomIntensity
                self.mBloomColor = post.BloomColor
                self.mBloomRadius = post.BloomRadius
                self.mBloomGamma = post.BloomGamma
                self.mBloomThreshold = post.BloomThreshold
                self.mBloomSoftKnee = post.BloomSoftKnee
                self.mBloomSampleScale = post.BloomSampleScale
            end

            post.BloomIntensity = intensity or self.mBloomIntensity
            post.BloomColor = color or self.mBloomColor
            post.BloomRadius = radius or self.mBloomRadius
            post.BloomGamma = gamma or self.mBloomGamma
            post.BloomThreshold = threshold or self.mBloomThreshold
            post.BloomSoftKnee = softKnee or self.mBloomSoftKnee
            post.BloomSampleScale = sampleScale or self.mBloomSampleScale

        end
    end
end

-- 重置bloom所有值
function resetBloomValue(self)
    self.mCameraTrans = self.mCameraTrans or gs.CameraMgr:GetSceneCameraTrans()
    if self.mBloomIntensity ~= nil then
        local post = self.mCameraTrans:GetComponent(ty.PostProcessing)
        if post and not gs.GoUtil.IsCompNull(post) then
            post.BloomIntensity = self.mBloomIntensity
            post.BloomColor = self.mBloomColor
            post.BloomRadius = self.mBloomRadius
            post.BloomGamma = self.mBloomGamma
            post.BloomThreshold = self.mBloomThreshold
            post.BloomSoftKnee = self.mBloomSoftKnee
            post.BloomSampleScale = self.mBloomSampleScale
        end
        self.mBloomIntensity = nil
        self.mBloomColor = nil
        self.mBloomRadius = nil
        self.mBloomGamma = nil
        self.mBloomThreshold = nil
        self.mBloomSoftKnee = nil
        self.mBloomSampleScale = nil
        self.mCameraTrans = nil
    end
end


return _M