module('guide.GuideUITransHandler', Class.impl(Manager))

function ctor(self)
    super.ctor(self)
    self.m_uiTransDict = {}
end

function addTrans(self, uiFlag, ctlname, trans)
    if not uiFlag then return end
    if trans and not gs.GoUtil.IsTransNull(trans) then
        local vo = self.m_uiTransDict[uiFlag]
        if not vo then
            vo = guide.GuideUITransVo.new()
            self.m_uiTransDict[uiFlag] = vo
        end
        for flag,voData in pairs(self.m_uiTransDict) do
            if flag~=uiFlag and voData:getTrans(ctlname) then
                logWarn(string.format("在[%s]和[%s]中 有同名控件 [%s]", uiFlag, flag, ctlname))
                break
            end
        end
        -- print("GuideUITransHandler addTrans", uiFlag, ctlname, trans)
        vo:addTrans(ctlname, trans)
        guide.GuideManager:handleWaitGData()
    end
end

function getTrans(self, ctlname)
    for flag,voData in pairs(self.m_uiTransDict) do
        if voData:isActive() then
            local trans = voData:getTrans(ctlname)
            if trans and not gs.GoUtil.IsTransNull(trans) then
                -- print("GuideUITransHandler GET ====", ctlname)
                return trans
            end
        end
    end
    -- print("GuideUITransHandler====", ctlname, " ===nil")
end

function clearTrans(self, uiFlag)
    if not uiFlag then return end
    -- print("GuideUITransHandler clearTrans===========", uiFlag)
    self.m_uiTransDict[uiFlag] = nil
end

function active(self, uiFlag)
    if not uiFlag then return end
    local vo = self.m_uiTransDict[uiFlag]
    if vo then
        vo:active()
    end
end
--非激活
function deActive(self, uiFlag)
    if not uiFlag then return end
    local vo = self.m_uiTransDict[uiFlag]
    if vo then
        vo:deActive()
    end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
