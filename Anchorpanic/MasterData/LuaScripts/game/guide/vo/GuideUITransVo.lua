local GuideUITransVo = Class.class("GuideUITransVo")

function GuideUITransVo:ctor()
    self.m_isActive = true
    self.m_transDict = {}
end

function GuideUITransVo:addTrans(ctlname, trans)
    self.m_transDict[ctlname] = trans
end

function GuideUITransVo:getTrans(ctlname)
    -- for k,v in pairs(self.m_transDict) do
    --     print("GuideUITransVo====", k)
    -- end
    return self.m_transDict[ctlname]
end

function GuideUITransVo:isActive()
    return self.m_isActive
end

function GuideUITransVo:active()
    self.m_isActive = true
end
--非激活
function GuideUITransVo:deActive()
    self.m_isActive = false
end

return GuideUITransVo
 
--[[ 替换语言包自动生成，请勿修改！
]]
