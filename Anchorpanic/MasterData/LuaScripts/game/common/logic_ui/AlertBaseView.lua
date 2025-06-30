module('AlertBaseView', Class.impl('lib.component.BaseContainer'))

-- 正式包刚进入还未加载GameView，临时处理
function __getLayerAlert(self)
    if(not GameView)then
        GameView = require("game/common/view/GameView").new()
    end
    return GameView.alert
end

-- 正式包刚进入还未加载GameView，临时处理
function __getLayerUICache(self)
    if(not GameView)then
        GameView = require("game/common/view/GameView").new()
    end
    return GameView.UICache
end

function initData(self)
    self.m_call = nil
    self.m_titleStr = nil
    self.m_msgStr = nil
    self.m_btnTitleTexts = {}
    self.m_btnTitleStrs = {}
    
    self.m_isOpen = false
end

--打开窗口
function open(self)
    self.m_isOpen = true
    if self.UIObject then
        self.UITrans:SetParent(self:__getLayerAlert(), false)
        UIFactory:bgMaskOpen(self:__getLayerAlert())
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_prompt.prefab"))
        self:active()
    end
end

-- 关闭窗口
function close(self)
    self.m_isOpen = false
    if self.UITrans then
        self.UITrans:SetParent(self:__getLayerUICache(), false)
    end
    UIFactory:bgMaskClose()
    self:deActive()
end

function configUI(self)
    self.m_titleText = self:getChildGO('TitleText'):GetComponent(ty.Text)
    self.m_msgText = self:getChildGO('MsgText'):GetComponent(ty.Text)
    self.m_scrollView = self:getChildGO('ScrollView'):GetComponent(ty.ScrollRect)
    local scrollViewTrans = self:getChildGO('ScrollView'):GetComponent(ty.RectTransform)
    self.m_contentTrans = self:getChildGO('Content'):GetComponent(ty.RectTransform)
    self.m_maxContentHeight = scrollViewTrans.sizeDelta.y
    if self.m_titleStr then
        self.m_titleText.text = self.m_titleStr
    end
    if self.m_msgStr then
        self.m_msgText.text = self.m_msgStr
        self:_setContentHeight()
    end
    if self.m_isOpen==true then
        self.UITrans:SetParent(self:__getLayerAlert(), false)
        UIFactory:bgMaskOpen(self:__getLayerAlert())
    end
end

function destroyPanel(self)
    self:destroy(true)
    self:dispatchEvent(View.EVENT_VIEW_DESTROY)
end

function setInfo(self, title, msg, call, tipCall)
    self.m_call = call
    self.m_tipCall = tipCall
    if self.m_titleText then
        self.m_titleText.text = title
    else
        self.m_titleStr = title
    end
    if self.m_msgText then
        self.m_msgText.text = msg
        self:_setContentHeight()
    else
        self.m_msgStr = msg
    end
end

function setBtnTitle( self, tag, titleStr )
    local text = self.m_btnTitleTexts[tag]
    if text then
        text.text = titleStr
    else
        self.m_btnTitleStrs[tag] = titleStr
    end
end

function _setContentHeight(self)
    local height = self.m_msgText.preferredHeight+16
    if height>self.m_maxContentHeight then
        local sd = self.m_contentTrans.sizeDelta
        sd.y = height
        self.m_contentTrans.sizeDelta = sd
        self.m_scrollView.movementType = gs.ScrollRect.MovementType.Elastic
    else
        self.m_scrollView.movementType = gs.ScrollRect.MovementType.Clamped
    end
end

function _setBtnTitleComponent( self, tag, text )
    self.m_btnTitleTexts[tag] = text
    local titleStr = self.m_btnTitleStrs[tag]
    if titleStr then
        text.text = titleStr
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
