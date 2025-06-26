module("tips.BaseTips", Class.impl(View))

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isShowMoneyBar = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

function setSize(self, w, h)
    super.setSize(self, w, h)
    self.gBtnClose:SetActive(false)
    if(self.base_childGos["gImgBg2"])then
        self.base_childGos["gImgBg2"]:SetActive(false)
    end
    if(self.base_childGos["gImgBg3"])then
        self.base_childGos["gImgBg3"]:SetActive(false)
    end
end

--析构函数
function dtor(self)
end

-- 初始化数据
function initData(self)
end

--初始化UI
function configUI(self)
end

--激活
function active(self)
    super.active(self)
    self.moneyTidList = MoneyManager:getMoneyTidList()
    -- self:addOnClick(self.m_childGos["BtnClose"], self.close, self:getCloseSoundPath())
end

--非激活
function deActive(self)
    super.deActive(self)
end

function recover(self)
end

function __tempAction(self, clickPosData)
    if(clickPosData and clickPosData.rectTransform)then
        local iconTweenTime = 0.2
        local targetRect = clickPosData.rectTransform
        local startPos = targetRect.position
        local startScale = targetRect.localScale
        local startSize = targetRect.sizeDelta

        local moveRect = self.m_childTrans["ImgIconAction"]:GetComponent(ty.RectTransform)
        local endPos = moveRect.position
        local endScale = moveRect.localScale
        local endSize = moveRect.sizeDelta

        local _iconTweenFinishCall = function()
            self.m_iconTweener:Kill()
            self.m_iconTweener = nil
        end
        local vo = self.m_propsVo and self.m_propsVo or self.m_equipVo
        moveRect:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(vo.tid), true)
        self.m_iconTweener = TweenFactory:propsMoveTo(moveRect, startScale, endScale, startSize, endSize, startPos, endPos, iconTweenTime, nil, _iconTweenFinishCall)

        -- local groupTweenTime = 0.2
        local canvasGroup = self.m_childGos["GameAction"]:GetComponent(ty.CanvasGroup)
        -- local _groupTweenFinishCall = function()
        --     self.m_groupTweener:Kill()
        --     self.m_groupTweener = nil
        -- end
        -- self.m_groupTweener = TweenFactory:canvasGroupAlphaTo(canvasGroup, 0, 1, groupTweenTime, nil, _groupTweenFinishCall, 0.1)
        canvasGroup.alpha = 1
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
