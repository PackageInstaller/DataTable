module("equipBuild.EquipMaterialItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
end

function getTrans(self)
    return self:getChildTrans("mBtnClick")
end

function setData(self, param)
    super.setData(self, param)
    self:__updateView()
end

function __updateView(self)
    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    if propsVo then
        propsVo:removeEventListener(props.PropsVo.UPDATE, self.updateProp, self)
    end
    propsVo:addEventListener(props.PropsVo.UPDATE, self.updateProp, self)

    if self.m_propsGrid then
        self.m_propsGrid:poolRecover()
        self.m_propsGrid = nil
    end

    if propsVo._NAME == equip.EquipVo._NAME then
        self.m_propsGrid = EquipSelectGrid:poolGet()
        self.m_propsGrid:setData(propsVo, self:getChildTrans("mGroupGrid2"))
        self.m_propsGrid:setShowEquipStrengthenLvl(true)
        self.m_propsGrid:setShowHeroIcon(true)
        gs.TransQuick:Scale(self.m_propsGrid.mImgLock:GetComponent(ty.RectTransform), 1.388, 1.388, 1.388)
        self.needRecoverSize = true
    else
        self.m_propsGrid = PropsGrid2:poolGet()
        self.m_propsGrid:setData(propsVo, self:getChildTrans("mGroupGrid"))
        self.m_propsGrid:setCount()
        self:updateSelectCount()
        self:addOnClick(self:getChildGO("mBtnCut"), self.onClickCutHandler)
    end
    self.m_propsGrid:setClickEnable(false)
    self.m_propsGrid:setScale(1)

    self:getChildGO("mImgSelectIcon"):SetActive(propsVo.type == PropsType.EQUIP)
    self:getChildGO("mImgTxtSelectCount"):SetActive(propsVo.type == PropsType.NORMAL)
    self:setSelectState(scrollEquipVo:getSelect())

    self:addOnClick(self:getChildGO("mBtnClick"), self.onClickGridHandler)
end

function updateSelectCount(self)
    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    self:getChildGO("mImgSelectIcon"):SetActive(propsVo.type == PropsType.EQUIP)
    self:getChildGO("mImgTxtSelectCount"):SetActive(propsVo.type == PropsType.NORMAL)
    self:setSelectState(scrollEquipVo:getSelect())
    if scrollEquipVo:getArgs() and scrollEquipVo:getArgs() > 0 then
        self:getChildGO("mTxtSelectCount"):GetComponent(ty.Text).text = "x" .. scrollEquipVo:getArgs()
    end
end

function updateProp(self)
    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    if propsVo.isLock == 1 then
        scrollEquipVo:setArgs(0)
        scrollEquipVo:setSelect(false)
        -- self:setSelectState(scrollEquipVo:getSelect())
        equipBuild.EquipStrengthenManager:dispatchEvent(equipBuild.EquipStrengthenManager.EQUIP_STRENGTHEN_MATERIAL_SELECT, scrollEquipVo)
        GameDispatcher:dispatchEvent(EventName.SELECT_MATERIAL_CHANGE_EVENT)
    end
end

function onClickGridHandler(self, args)
    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()

    if propsVo.type == PropsType.EQUIP then
        self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, propsVo.id)
        if self.isNew then
            self.m_propsGrid:setIsNew(false)
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = propsVo.id })
        end

        TipsFactory:closeEquipTips()
    end

    if propsVo.isLock == 1 then
        TipsFactory:openEquipTips({ equipVo = propsVo })
        gs.Message.Show("无法选择锁定的装备")
        return
    end
    if propsVo.type == PropsType.NORMAL then
        local count = (scrollEquipVo:getArgs() or 0) + 1
        scrollEquipVo:setArgs(count)
        scrollEquipVo:setSelect(true)
    else
        if propsVo.heroId > 0 then
            gs.Message.Show(_TT(71434))
            return
        end

        scrollEquipVo:setArgs(1)
        scrollEquipVo:setSelect(not scrollEquipVo:getSelect())

        if scrollEquipVo:getSelect() then
            TipsFactory:openEquipTips({ equipVo = propsVo })
        end
        -- self:setSelectState(scrollEquipVo:getSelect())
    end
    equipBuild.EquipStrengthenManager:dispatchEvent(equipBuild.EquipStrengthenManager.EQUIP_STRENGTHEN_MATERIAL_SELECT, scrollEquipVo)
end

function onClickCutHandler(self)
    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    local count = (scrollEquipVo:getArgs() or 0) - 1
    scrollEquipVo:setArgs(count)
    if scrollEquipVo:getArgs() <= 0 then
        scrollEquipVo:setSelect(false)
    end
    equipBuild.EquipStrengthenManager:dispatchEvent(equipBuild.EquipStrengthenManager.EQUIP_STRENGTHEN_MATERIAL_SELECT, scrollEquipVo)
end

function setSelectState(self, cusIsSelect)
    self.isSelect = cusIsSelect
    if gs.GoUtil.IsGoNull(self:getChildGO("mImgSelect")) then
        return
    end

    self:getChildGO("mImgSelect"):SetActive(cusIsSelect)
    self:getChildGO("mBtnCut"):SetActive(cusIsSelect and self.data:getDataVo().type == PropsType.NORMAL)
end

function getSelectState(self)
    return self.isSelect
end

function deActive(self)
    super.deActive(self)
    self:removeOnClick(self:getChildGO("mBtnClick"))
    if (self.m_propsGrid) then
        if self.needRecoverSize then
            gs.TransQuick:Scale(self.m_propsGrid.mImgLock:GetComponent(ty.RectTransform), 1, 1, 1)
            self.needRecoverSize = nil
        end
        self.m_propsGrid:poolRecover()
        self.m_propsGrid = nil
    end

    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    if propsVo then
        propsVo:removeEventListener(props.PropsVo.UPDATE, self.updateProp, self)
    end
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71434):	"已被装备,无法选择"
]]