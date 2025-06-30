module("cycle.CyclePassCollItem", Class.impl("lib.component.BaseItemRender"))


function onInit(self, go)
    super.onInit(self, go)

    self.mImgBuff = self:getChildGO("mImgBuff"):GetComponent(ty.AutoRefImage)
end


function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function setData(self, data)
    super.setData(self, data)
    self.mImgBuff:SetImg(UrlManager:getCycelCollectionIcon(data.icon),false)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
