
module('storyTalk.StoryMsgCell', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
	super.initData(self, rootGo)
    self.m_cellLayoutEle = self.m_go:GetComponent(ty.LayoutElement)
    -- self.m_rTrans = self.m_go:GetComponent(ty.RectTransform)
    self.m_txtRTrans = self:getChildGO('Text'):GetComponent(ty.RectTransform)
    self.m_msgTxt = self:getChildGO('Text'):GetComponent(ty.Text)
    self.m_contentSizeFitter = self:getChildGO('Text'):GetComponent(ty.ContentSizeFitter)
    self.m_isCRbakTxt = false
end

function isCR(self)
    return self.m_isCRbakTxt
end

function setTxt(self, msg, fadeTime)
    if msg=="CR1" or msg=="CR2" or msg=="CR3" or msg=="CR4" or msg=="CR5" then -- 需要替换的
        self.m_isCRbakTxt = msg
        self.m_msgTxt.text = " "
    else
        self.m_isCRbakTxt = nil
        self.m_msgTxt.text = msg
    end
    
    if fadeTime and fadeTime>0 then
        self.m_msgTxt:DOFade(0,0)
        self.m_msgTxt:DOFade(1,fadeTime)
    end
    -- if self.m_contentSizeFitter then
    --     -- print("setTxt", gs.LayoutUtility.GetPreferredHeight(self.m_txtRTrans))
    --     gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.m_txtRTrans);
    --     -- print("setTxt2", gs.LayoutUtility.GetPreferredHeight(self.m_txtRTrans))
    --     -- print("setTxt20", gs.LayoutUtility.GetPreferredHeight(self.m_txtRTrans))
    --     -- print("self.m_txtRTrans.sizeDelta", self.m_txtRTrans.sizeDelta.y) 
    --     -- if gs.ContentSizeFitter.FitMode.MinSize==self.m_contentSizeFitter.verticalFit then
    --     --     self.m_cellLayoutEle.preferredHeight = gs.LayoutUtility.GetMinSize(self.m_txtRTrans, 1);
    --     -- else
    --     --     self.m_cellLayoutEle.preferredHeight = gs.LayoutUtility.GetPreferredSize(self.m_txtRTrans, 1);
    --     -- end
    --     if gs.LayoutUtility.GetPreferredHeight(self.m_txtRTrans)>gs.LayoutUtility.GetMinHeight(self.m_txtRTrans) then
    --         self.m_cellLayoutEle.minHeight = gs.LayoutUtility.GetPreferredHeight(self.m_txtRTrans)+10
    --     -- else
    --     --     self.m_cellLayoutEle.minHeight = gs.LayoutUtility.GetMinHeight(self.m_txtRTrans);
    --     end
    -- end
    if self.rootGo then
        gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rootGo:GetComponent(ty.RectTransform))
    end
    return self.m_cellLayoutEle.minHeight
end

function setPreferredHeight(self, h)
    self.m_cellLayoutEle.minHeight = h
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
