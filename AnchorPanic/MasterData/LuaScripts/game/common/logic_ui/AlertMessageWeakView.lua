module('game.common.logic_ui.AlertMessageWeakView', Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("common/AlertMessageWeakView.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.m_rectShowItem = self:getChildGO("ShowItem"):GetComponent(ty.RectTransform)
    self.m_canvasGroupShowItem = self:getChildGO("ShowItem"):GetComponent(ty.CanvasGroup)
    self.m_textContent = self:getChildGO("TextContent"):GetComponent(ty.Text)
end

-- 激活
function active(self)
    super.active(self)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function setContent(self, content)
    AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_intensify.prefab"))
    self.m_textContent.text = content
    self.m_canvasGroupShowItem.alpha = 0
    gs.TransQuick:UIPosY(self.m_rectShowItem, 0)
    self:__tween()
end

function __tween(self)
    if (self.m_timeFrameSn) then
        LoopManager:removeTimerByIndex(self.m_timeFrameSn)
        self.m_timeFrameSn = nil
    end
    if (self.m_alphaTweener) then
        self.m_alphaTweener:Kill()
        self.m_alphaTweener = nil
    end
    if (self.m_posTweener) then
        self.m_posTweener:Kill()
        self.m_posTweener = nil
    end
    self:__tweenAlpha()
    self:__tweenPos()
end

function __tweenAlpha(self)
    self.m_alphaTweener = TweenFactory:canvasGroupAlphaTo(self.m_canvasGroupShowItem, 0, 1, 0.3, gs.DT.Ease.Linear, 
    function()
    end)
end

function __tweenPos(self)
    local w, h = ScreenUtil:getScreenSize(nil)
    self.m_posTweener = TweenFactory:move2LPosY(self.m_rectShowItem, h / 2 -90, 0.3, gs.DT.Ease.Linear, 
    function()
        self.m_timeFrameSn = LoopManager:addTimer(1, 0, self, function() UIFactory:closeAlertWeakView() end)
    end)
end

function open(self)
    if self.isPop ~= 1 then
        self.isPop = 1
        self:active()
        if self.UIObject then
            self.UITrans:SetParent(GameView.alert, false)
        end
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
