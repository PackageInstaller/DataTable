module('game.common.logic_ui.LoadOnView', Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("common/LoadOnView.prefab")
isAdapta = 1-- 是否适应全面屏

-- 构造函数
function ctor(self)
    super.ctor(self)
    self.m_showing = false
end

-- 析构  
function dtor(self)
end

function initData(self)
    self.m_isFirstActive = true
    self.m_isTweening = false
    self.m_loadingDataRo = nil
end

function getAdaptaTrans(self)
    return self:getChildTrans("GroupContent")
end

-- 初始化
function configUI(self)
    self.m_contentCanvasGroup = self:getChildGO("GroupContent"):GetComponent(ty.CanvasGroup)
    self.m_goClick = self:getChildGO("ImgClick")
    self.m_transGoAct = self:getChildTrans("ImgAct")
    self.m_imgBg_1 = self:getChildGO("ImgBg_1"):GetComponent(ty.AutoRefImage)
    self.m_img1CanvasGroup = self:getChildGO("ImgBg_1"):GetComponent(ty.CanvasGroup)
    self.m_imgBg_2 = self:getChildGO("ImgBg_2"):GetComponent(ty.AutoRefImage)
    self.m_img2CanvasGroup = self:getChildGO("ImgBg_2"):GetComponent(ty.CanvasGroup)
    self.m_textTitle = self:getChildGO("TextTitle"):GetComponent(ty.Text)
    self.m_textContent = self:getChildGO("TextContent"):GetComponent(ty.Text)
end

-- 激活
function active(self)
    super.active(self)
    if self.m_showing then return end
    self.m_showing = true
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
    if (self.m_contentTweener) then
        self.m_contentTweener:Kill()
        self.m_contentTweener = nil
    end
    if (self.m_bgTweener) then
        self.m_bgTweener:Kill()
        self.m_bgTweener = nil
    end
    -- self:addOnClick(self.m_goClick, self.__onClickHandler)
    self.mActionFrameSn = LoopManager:addFrame(gs.Application.targetFrameRate == 30 and 1 or 2, 0, self, self.onActionFrameHandler)

    self:initData()
    self.m_contentCanvasGroup.alpha = 0
    -- self.m_img1CanvasGroup.alpha = 0
    self.m_img2CanvasGroup.alpha = 0
    -- self:__onClickHandler()

    self.m_lastMusicVolume = AudioManager:getMusicVolume()
    AudioManager:setMusicVolume(0.001)
end

-- 反激活（销毁工作）
function deActive(self)
    AudioManager:setMusicVolume(self.m_lastMusicVolume)
    self.m_showing = false
    super.deActive(self)
    -- self:removeOnClick(self.m_goClick, self.__onClickHandler)
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
    if (self.m_contentTweener) then
        self.m_contentTweener:Kill()
        self.m_contentTweener = nil
    end
    if (self.m_bgTweener) then
        self.m_bgTweener:Kill()
        self.m_bgTweener = nil
    end
end

function __onClickHandler(self)
    if (not self.m_isTweening) then
        self.m_isTweening = true
        if (not self.m_loadingDataRo) then
            self.m_loadingDataRo = LoadOnManager:getRandomRo()
        -- else
        --     local randomVo = LoadOnManager:getRandomRo(self.m_loadingDataRo)
        --     if (randomVo and randomVo:getRefID() ~= self.m_loadingDataRo:getRefID() and randomVo:getBackground() ~= self.m_loadingDataRo:getBackground() and randomVo:getDes() ~= self.m_loadingDataRo:getDes() and randomVo:getTitle() ~= self.m_loadingDataRo:getTitle()) then
        --         self.m_loadingDataRo = randomVo
        --     else
        --         return
        --     end
        end

        if (self.m_loadingDataRo) then
            -- self.UIObject:SetActive(true)
            if (self.m_isFirstActive) then
                self.m_isFirstActive = false
                self.m_isTweening = false

                self.m_textTitle.text = _TT(self.m_loadingDataRo:getTitle())
                self.m_textContent.text = string.replaceSpacesToFullAngle(_TT(self.m_loadingDataRo:getDes()))
                self.m_contentCanvasGroup.alpha = 1

                local bgSource = self.m_loadingDataRo:getBackground()
                -- self.m_imgBg_1:SetImg(bgSource, true)
                self.m_imgBg_2:SetImg(bgSource, false)
                -- self.m_img1CanvasGroup.alpha = 1
                self.m_img2CanvasGroup.alpha = 1
            else
                self:__tweenContent()
                self:__tweenBg()
            end
        else
            -- self.UIObject:SetActive(false)
        end
    end
end

function __tweenContent(self)
    if (self.m_contentTweener) then
        self.m_contentTweener:Kill()
        self.m_contentTweener = nil
    end
    self.m_contentTweener = TweenFactory:canvasGroupAlphaTo(self.m_contentCanvasGroup, 1, 0, 0.3, gs.DT.Ease.InExpo,
    function()
        self.m_textTitle.text = _TT(self.m_loadingDataRo:getTitle())
        self.m_textContent.text = _TT(self.m_loadingDataRo:getDes())
        self.m_contentTweener = TweenFactory:canvasGroupAlphaTo(self.m_contentCanvasGroup, self.m_contentCanvasGroup.alpha, 1, 0.3, gs.DT.Ease.InExpo)
    end)
end

function __tweenBg(self)
    local bgSource = UrlManager:getBgPath("common/" .. self.m_loadingDataRo:getBackground())
    self.m_imgBg_1:SetImg(bgSource, true)

    if (self.m_bgTweener) then
        self.m_bgTweener:Kill()
        self.m_bgTweener = nil
    end
    self.m_bgTweener = TweenFactory:canvasGroupAlphaTo(self.m_img2CanvasGroup, 1, 0, 0.5, gs.DT.Ease.InExpo,
    function()
        self.m_isTweening = false
        self.m_imgBg_2:SetImg(bgSource, true)
    end)
end

function onActionFrameHandler(self)
    if (not self.m_rotation) then
        self.m_rotation = 360
    else
        if (self.m_rotation <= 0) then
            self.m_rotation = 360 - 2
        else
            self.m_rotation = self.m_rotation - 4
        end
    end
    gs.TransQuick:SetRotation(self.m_transGoAct, 0, 0, self.m_rotation)
end

function open(self,load_id)
    if self.isPop ~= 1 then
        self.isPop = 1

        if self.m_showing then return end
        if self.UIObject then
            -- self.UITrans:SetParent(GameView.loading, false)
            -- self.UITrans:SetSiblingIndex(0)
            self:setParentTrans(GameView.loading, 0)
        end

        self.m_loadingDataRo = LoadOnManager:getLoadingDataRo(load_id)

        self:active()
        self:__onClickHandler()
    end
end

function close(self)
    if self.isPop ~= 0 then
        self.isPop = 0

        self:deActive()
        if self.UITrans then
            self.UITrans:SetParent(GameView.UICache, false)
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]