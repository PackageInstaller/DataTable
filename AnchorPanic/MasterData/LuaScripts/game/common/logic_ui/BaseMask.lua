module('BaseMask', Class.impl('lib.component.BaseContainer'))
UIRes = UrlManager:getPrefabPath('base/MaskLayer.prefab')
local gIns = nil
function getInstance()
    if gIns == nil then
        gIns = BaseMask.new()
        gIns:addEventListener(View.EVENT_VIEW_DESTROY, gIns.onDestroyViewHandler, gIns)
    end
    return gIns
end

function onDestroyViewHandler(self)
    gIns = nil
end

function initData(self)
    self.m_layerTrans = nil
end

function configUI(self)
    if self.m_isOpen == true then
        self.m_isOpen = false
        if self.m_layerTrans and self.UIObject then
            self.UITrans:SetParent(self.m_layerTrans, false)
            self.UITrans:SetSiblingIndex(0)
        end
    end
end
--打开窗口
function open(self, layerTrans, siblingIdx)
    self.m_layerTrans = layerTrans
    if not self.UITrans or gs.GoUtil.IsTransNull(self.UITrans) then
        self:loadAsset()
    end
    if self.UIObject then
        self.UITrans:SetParent(layerTrans, false)
        siblingIdx = siblingIdx or 0
        self.UITrans:SetSiblingIndex(siblingIdx)
    else
        self.m_isOpen = true
    end
end

-- 关闭窗口
function close(self)
    self.m_isOpen = false
    if self.UITrans and not gs.GoUtil.IsTransNull(self.UITrans) then
        self.UITrans:SetParent(GameView.UICache, false)
    end
end

function destroy(self)

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
