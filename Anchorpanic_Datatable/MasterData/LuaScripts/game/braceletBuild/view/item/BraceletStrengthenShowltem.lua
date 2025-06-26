

module('braceletBuild.BraceletStrengthenShowltem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)

    local scrollData = self.data:getDataVo()
    local equipScrollVo = scrollData.equipScrollVo
    if (equipScrollVo) then
        local count = equipScrollVo:getArgs()
        local propsVo = equipScrollVo:getDataVo()

        if propsVo._NAME == equip.EquipVo._NAME then
            if self.m_propsGrid and self.m_propsGrid._NAME == PropsGrid._NAME then
                self.m_propsGrid:poolRecover()
                self.m_propsGrid = nil
            end
            if (not self.m_propsGrid) then
                self.m_propsGrid = BraceletsGrid:poolGet()
            end
            self.m_propsGrid:setData(propsVo, self:getChildTrans("mGroupGrid"))
        else
            if self.m_propsGrid and self.m_propsGrid._NAME == EquipGrid2._NAME then
                self.m_propsGrid:poolRecover()
                self.m_propsGrid = nil
            end
            if (not self.m_propsGrid) then
                self.m_propsGrid = PropsGrid2:poolGet()
            end
            self.m_propsGrid:setData(propsVo, self:getChildTrans("mGroupGrid"))
            self.m_propsGrid:setCount(count)
        end
        self.m_propsGrid:setClickEnable(false)
        self.m_propsGrid:setScale(0.95)
    else
        self:deActive()
    end

    self:addOnClick(self:getChildGO("mBtnClick"), self.onClickGridHandler)

    self:clearGuideTrans()
    self:setGuideTrans("funcTips_guide_BraceletStrengthen_Btn_" .. scrollData.index, self:getChildTrans("mBtnClick"))
end

function onClickGridHandler(self, args)
    local scrollData = self.data:getDataVo()
    local targetEquipVo = scrollData.targetEquipVo
    GameDispatcher:dispatchEvent(EventName.OPEN_BRACELET_STRENGTHEN_MATERIAL_VIEW, targetEquipVo)
end

function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.UIObject)
    if (self.m_propsGrid) then
        self.m_propsGrid:poolRecover()
        self.m_propsGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M