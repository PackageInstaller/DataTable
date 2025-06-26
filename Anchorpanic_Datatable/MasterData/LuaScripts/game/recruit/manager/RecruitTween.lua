module('game.recruit.manager.RecruitTween', Class.impl())
--构造函数
function ctor(self)
    self.sceneRes_20 = "arts/sceneModule/ui_main_20/prefabs/ui_main_20.prefab"
end

--获取动画默认层
function getCurrentAnimatorStateInfo(self, animator)
    if animator and not gs.GoUtil.IsCompNull(animator) then
        return animator:GetCurrentAnimatorStateInfo(0)
    end
end

--是否正在播放某个动画
function isPlayingClip(self, animator, clipName)
    if animator and not gs.GoUtil.IsCompNull(animator) then
        return self:getCurrentAnimatorStateInfo(animator):IsName("Base Layer." .. clipName)
    end
end

function active(self)
    self:addEventListener()

    self:initData()
    self:loadRecruitSceneObj()

    GameDispatcher:dispatchEvent(EventName.HIDE_MAIN_UI)
end

--添加事件监听
function addEventListener(self)
    GameDispatcher:addEventListener(EventName.RECRUIT_SKIP, self.onSkip, self)
    GameDispatcher:addEventListener(EventName.CLOSE_RECRUIT_SHOW_ONE_VIEW, self.onCloseOneView, self)
end

--移除事件监听
function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.RECRUIT_SKIP, self.onSkip, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_RECRUIT_SHOW_ONE_VIEW, self.onCloseOneView, self)
end


function initData(self)
    self.mAddQualityNode = {} --已经添加过特效的节点    
    if not self.mQualityEfxNodeList then
        self.mQualityEfxNodeList = {} --品质特效的挂点
    end
    if not self.mQualityEfxDic then
        self.mQualityEfxDic = {} --已经加载的品质特效
    end

    if not self.mCreateQuality then
        self.mCreateQuality = {} --已经实例化处理了的品质特效
    end

    self.mCurShowHeroInfo = { vo = 0, index = 0 } --当前展示的是哪个英雄的信息

    self.mRecruitHeroVo = recruit.RecruitManager:getRecruitHeroResultList()

    self.mCurShowHightHero = false --当前是否在街道场景展示最高品质英雄
end

--跳过
function onSkip(self)
    AudioManager:resumeMusicByFade(6)

    if #self.mRecruitHeroVo > 1 then 
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW )
    else
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, self.mRecruitHeroVo[i])
    end
    self:setCanDrag(false)
end

--加载抽卡动画的预制
function loadRecruitSceneObj(self)
    self.mCurAddQuality = 1
    self.mAddQualityNode = {}

    if self.mRecruitSceneObj_20 == nil or gs.GoUtil.IsGoNull(self.mRecruitSceneObj_20) then
        gs.ResMgr:LoadGOAysn(self.sceneRes_20, function(go)
            self:onLoadComplete(go)
            GameDispatcher:dispatchEvent(EventName.OPENRECRUITSKIPVIEW)
            GameDispatcher:dispatchEvent(EventName.Close_RECRUIT_PANEL)
        end)
    else
        self:setSceneCamera(self.camera_20)
        self:setCanDrag(true)
        if self.mCursor then 
            self.mCursor:SetActive(true)
        end

        GameDispatcher:dispatchEvent(EventName.OPENRECRUITSKIPVIEW)
        GameDispatcher:dispatchEvent(EventName.Close_RECRUIT_PANEL)
    end

    AudioManager:pauseMusicByFade(2)
    self:StopBGM()
    self.bgmAudio = AudioManager:playOtherMusic("arts/audio/UI/recruit/ui_recruit_amb.prefab", true)
end

function onLoadComplete(self, go)
    -- 实例化是一个克隆对象，并不是加载的那个prefab，需要重新取
    if go ~= nil then
        self.mRecruitSceneObj_20 = go

        local sceneTran = self.mRecruitSceneObj_20.transform
        sceneTran.position = gs.Vector3(1000, 1000, 1000)
        local cameraNode = sceneTran:Find("Environment/[SCamera]")
        self.camera_20 = cameraNode:GetComponent(ty.Camera)
        local Environment = sceneTran:Find("Environment")
        if not gs.GoUtil.IsTransNull(Environment) then
            self.mEnvironmentAnima = Environment:GetComponent(ty.Animator)
        end

        --设置场景拖拽滑动脚本
        self.dragScript = self.mRecruitSceneObj_20:GetComponent(ty.RecruitDrag)
        self.dragScript.StartEvent = function()
            if self.mCursor then 
                self.mCursor:SetActive(false)
            end
            AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit_open.prefab")
        end
        self.dragScript.DragEvent = function(index)
            if index ~= 0 then
                AudioManager:playSoundEffect(string.format("arts/audio/UI/recruit/ui_recruit_spin_0%s.prefab", index))
            end
        end
        self.dragScript.ResetEvent = function()
            AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit_launch.prefab")
            if #self.mRecruitHeroVo > 1 then 
                self.mEnvironmentAnima:Play("wujian_02_hudong_gai")
            else
                self.mEnvironmentAnima:Play("wujian_02_hudong_dan")
            end
        end
        if gs.CameraMgr:IsGraphicBlitCamera() then
            self.dragScript:SetRaycastCamera(gs.CameraMgr:GetToScreenSceneCamera())
        end

        --拖动指示器
        local cursor = sceneTran:Find("Environment/sphere/fx_main_20_yiduan_zhishi")
        if not gs.GoUtil.IsTransNull(cursor) then
            self.mCursor = sceneTran:Find("Environment/sphere/fx_main_20_yiduan_zhishi").gameObject
        end

        --品质光节点收集
        local nodeTran = sceneTran:Find("Environment/sphere/fx_main_20_erduan_10")
        for i = 1, nodeTran.childCount do
            self.mQualityEfxNodeList[i] = nodeTran:GetChild(i - 1)
        end

        --初始化帧事件
        local animatCall = Environment:GetComponent(ty.AnimatCall)
        animatCall:AddFrameEventCall("AddEfx", function()
            --开始添加特效
            if #self.mRecruitHeroVo > 1 then 
                if self.mCurAddQuality <= 6 then
                    for i=1,3 do
                        self:addQulityEfx()
                    end
                else
                    for i=self.mCurAddQuality,#self.mRecruitHeroVo do
                        self:addQulityEfx()
                    end
                end
            else
                self:addQulityEfx()
            end
        end)
        animatCall:AddFrameEventCall("RecruitFinish", function()
            self:ShowRecruitResult()
        end)

        animatCall:AddFrameEventCall("PlayAudio_Ball", function()
            AudioManager:playSoundEffect("arts/audio/UI/recruit/ui_recruit_process.prefab")
        end)
        animatCall:AddFrameEventCall("StopBGM",function ()
            self:StopBGM()
        end)

        self:setSceneCamera(self.camera_20)
        self:setCanDrag(true)
    end
end

function getRandomNode(self)
    local nodeIndex = math.random(1, #self.mQualityEfxNodeList)

    if self.mAddQualityNode[nodeIndex] ~= nil then
        nodeIndex = self:getRandomNode()
    end

    self.mAddQualityNode[nodeIndex] = nodeIndex
    return nodeIndex
end

function addQulityEfx(self)
    if self.mCurAddQuality > #self.mRecruitHeroVo then return end

    local heroVo = hero.HeroManager:getHeroConfigVo(self.mRecruitHeroVo[self.mCurAddQuality].heroTid)
    local quality = heroVo.color
    local efxParent = self.mQualityEfxNodeList[self:getRandomNode()]

    if not self.mCreateQuality[quality] then
        self.mCreateQuality[quality] = {}
    end
    if self.mQualityEfxDic[quality] == nil then
        local efxPath = string.format("arts/fx/3d/scene/main_20/fx_main_20_erduan_10_0%s.prefab", quality)
        gs.ResMgr:LoadGOAysn(efxPath, function(go)
            self.mQualityEfxDic[quality] = go
            go.transform:SetParent(efxParent, false)
            table.insert(self.mCreateQuality[quality], { go = go, active = true })
        end)
    else
        local go = nil
        for k, v in pairs(self.mCreateQuality[quality]) do
            if not v.active then
                go = v.go
                go:SetActive(true)
                v.active = true
                break
            end
        end

        if go == nil then
            go = gs.GameObject.Instantiate(self.mQualityEfxDic[quality])
            table.insert(self.mCreateQuality[quality], { go = go, active = true })
        end
        go.transform:SetParent(efxParent, false)
    end

    self.mCurAddQuality = self.mCurAddQuality + 1
end

--停掉BGM
function StopBGM(self)
    if self.bgmAudio ~= nil then
        AudioManager:stopAudioSound(self.bgmAudio)
        self.bgmAudio = nil
    end
end

--关闭立绘界面
function onCloseOneView(self)
    self:ShowRecruitResult()
end

--展示抽卡结果
function ShowRecruitResult(self)
    if not table.empty(self.mRecruitHeroVo) and self.mCurShowHeroInfo.index < #self.mRecruitHeroVo then
        local heroConfigVo = nil
        for i=1,#self.mRecruitHeroVo do
            if i > self.mCurShowHeroInfo.index then 
                self.mCurShowHeroInfo.index = i
                self.mCurShowHeroInfo.vo = self.mRecruitHeroVo[i]
                GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, self.mRecruitHeroVo[i])
            end
        end
    else
        --多抽打开AllView,单抽回到抽卡界面
        if #self.mRecruitHeroVo > 1 then
            GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ALL_VIEW)
        else
            GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_PANEL)
            self:reset()
        end
    end

    AudioManager:resumeMusicByFade(6)
end

--设置场景相机
function setSceneCamera(self, camera)
    if self.curRenderCamera then
        self.curRenderCamera.gameObject:SetActive(false)
    end
    self.curRenderCamera = camera
    if self.curRenderCamera then
        self.curRenderCamera.gameObject:SetActive(true)
        if gs.CameraMgr:IsGraphicBlitCamera() then
            gs.CameraMgr:SetRenderCamera(self.curRenderCamera)
        end
        gs.CameraMgr:SetSceneCameraVisible(false)
    else
        if gs.CameraMgr:IsGraphicBlitCamera() then
            gs.CameraMgr:SetRenderCamera()
        end
        gs.CameraMgr:SetSceneCameraVisible(true)
    end
end

--设置是否可以拖拽抽卡
function setCanDrag(self, val)
    if self.dragScript then
        self.dragScript.CanDrag = val
    end
end

--还原模型材质
function resetHeroModelMat(self)
    if self.heroMatColorList ~= nil then
        local matList = self.heroModel.m_model:GetComponent(ty.ModelMaterials):getMatList()
        for i = 0, matList.Count - 1 do
            if matList[i]:HasProperty("_BaseColor") then 
                matList[i]:SetColor("_BaseColor", self.heroMatColorList[matList[i]]["_BaseColor"])
            end
            if matList[i]:HasProperty("_ShadeColor") then 
                matList[i]:SetColor("_ShadeColor", self.heroMatColorList[matList[i]]["_ShadeColor"])
            end
        end
    end

    self.heroMatColorList = nil
end

--重置模型
function resetHeroModel(self)
    self:resetHeroModelMat()

    if self.heroModel then 
        self.heroModel:destroy()
        self.heroModel = nil
    end
end

--退出抽卡动画界面的时候 重置动画
function reset(self)
    if self.mEnvironmentAnima then
        self.mEnvironmentAnima:Play("wujian_01_xunhuan")
    end

    for _, qualityTab in pairs(self.mCreateQuality) do
        for k, v in pairs(qualityTab) do
            v.go:SetActive(false)
            v.active = false
        end
    end

    self:removeEventListener()
end

--抽卡界面关闭的时候执行
function destroy(self)
    gs.GameObject.Destroy(self.mRecruitSceneObj_20)

    self.mRecruitSceneObj_20 = nil
    self.mEnvironmentAnima = nil

    self.mQualityEfxNodeList = nil
    self.mQualityEfxDic = nil
    self.mAddQualityNode = nil
    self.mCreateQuality = nil

    self:setSceneCamera()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]