module("decorate.DecorateTitleItem", Class.impl("game.decorate.view.item.DecorateBaseItem"))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)
    self.m_goBg:SetActive(false)

    local tabType = self.data:getDataVo().tabType
    local dataRo = self.data:getDataVo().configVo
    
    self.m_imgShow:SetImg(UrlManager:getPlayerTitleUrl(dataRo:getIcon()), true)
    self:setSelect(self.data:getSelect())
    self:setUse(role.RoleManager:getRoleVo():getTitleId() == dataRo:getRefID())
    self:setNew(decorate.DecorateManager:getIsNew(decorate.getModuleTypeByTabType(tabType), dataRo:getRefID()))
    self:setMask(not decorate.DecorateManager:getIsActive(decorate.getModuleTypeByTabType(tabType), dataRo:getRefID()))
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
