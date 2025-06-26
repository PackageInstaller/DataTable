--[[ 
-----------------------------------------------------
@filename       : Screensaver
@Description    : 黑色屏保
@date           : 2021-01-29 17:34:10
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.common.logic_ui.ScreensaverOld', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("common/ScreensaverView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

function initData(self)
    self.isShow = false
    self.isClose = false
    -- 是否已经被首次调用过了
    self.hasBeCalled = false
end

function loadAsset(self)
    if (self.UIRes ~= nil and self.UIRes ~= '') then
        if (self.IsAsyn == nil or self.IsAsyn == false) then
            AssetLoader.PreLoad(self.UIRes, self.onLoadAssetComplete, self)
        else
            AssetLoader.PreLoadAsyn(self.UIRes, self.onLoadAssetComplete, self)
        end
    else
        self:configUI()
        self:__active()
        self:dispatchEvent(EVENT_LOAD_FINISH)
    end
end

-- 初始化
function configUI(self)
    self.mImgBlack = self:getChildGO("mImgBlack")
    self.mImgBlackGroup = self.mImgBlack:GetComponent(ty.CanvasGroup)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.isShow = false
    self.isClose = false
    self.hasBeCalled = false
end

-- 添加到屏幕（未计时消失，需要调用start）
function show(self, time, noLoad)
    note.NoteManager:addEnableByLoading(false)
    if self.isForcibly then
        return
    end
    if self.UIObject then
        self.hasBeCalled = true
        local time = time or 0.4
        if self.blackTweener then
            self.blackTweener:Kill()
            self.blackTweener = nil
        end

        if self.isShow then
            self.blackTweener = TweenFactory:canvasGroupAlphaTo(self.mImgBlackGroup, self.mImgBlackGroup.alpha, 0, time, gs.DT.Ease.InExpo, function()
                self.mImgBlack:SetActive(false)
                self.blackTweener:Kill()
                self.blackTweener = nil
    
                if (self.isClose) then
                    self.isClose = false
                    self:close()
                end
            end)
            self.blackTweener:SetUpdate(true)
            return
        end
        self.isShow = true

        self.UITrans:SetParent(GameView.loading, false)
        self.mImgBlack:SetActive(true)
        self.mImgBlackGroup.alpha = 1
        if not noLoad then
            UIFactory:openLoadOnView()
        end
        
        self.blackTweener = TweenFactory:canvasGroupAlphaTo(self.mImgBlackGroup, 1, 0, time, gs.DT.Ease.InExpo, function()
            self.mImgBlack:SetActive(false)
            self.blackTweener:Kill()
            self.blackTweener = nil

            if (self.isClose) then
                self.isClose = false
                self:close()
            end
        end)
        self.blackTweener:SetUpdate(true)
    end
end

-- 添加后自动计时消失
function start(self, time)
    if self.isForcibly then
        return
    end
    self.isClose = true
    if self.isShow then
        if (not self.blackTweener) then
            self:show(time)
        end
    else
        self:show(time)
    end
    UIFactory:closeLoadOnView()
    note.NoteManager:addEnableByLoading(true)
end

-- 强制显示，不被其他关闭，必须和closeForcibly成对出现
function startForcibly(self)
    if not self.isForcibly then
        UIFactory:openLoadOnView()
        self.isForcibly = true
    end
    note.NoteManager:addEnableByLoading(false)
end
-- 取消强制显示
function closeForcibly(self)
    if self.isForcibly then
        self.isForcibly = false
        self:start()
    end
end

function close(self)
    if self.blackTweener then
        self.blackTweener:Kill()
        self.blackTweener = nil
    end
    if self.UITrans then
        self.UITrans:SetParent(GameView.UICache, false)
        self:deActive()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
