module("PropsAddGrid", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/PropsAddGrid.prefab")

function __initData(self)
    super.__initData(self)

    --------------------------------------------- 数据源 self.m_data 为 props.PropsConfigVo ---------------------------------------------
    self.m_propsGrid = nil
end

function __reset(self)
    if (self.m_propsGrid) then
        self.m_propsGrid:poolRecover()
        self.m_propsGrid = nil
    end
    super.__reset(self)
end

function setData(self, cusPropsVo, cusIsAsyn, finishCall)
    self:__reset()
    local name = self:__getPrefabName()
    self.m_uiGo = gs.GOPoolMgr:Get(name)
    self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_uiGo)
    self:addOnClick(self.m_uiGo, self.__onClickHandler)
    self.m_isLoadFinish = true
    self.m_data = cusPropsVo

    self:__updateGrid(cusIsAsyn, finishCall)
end

function __updateGrid(self, cusIsAsyn, finishCall)
    local propsVo = self:getData()
    if (propsVo) then
        self.m_propsGrid = PropsGrid:poolGet()
        self.m_propsGrid:setData(propsVo, self.m_childTrans["BaseGrid"])
        -- self.m_propsGrid:setPosition(gs.Vector3(0, 0, 0))
    end
end

function setParent(self, cusParentTrans)
    if (self.m_uiGo) then
        self.m_uiGo.transform:SetParent(cusParentTrans, false)
    end
end

function __initGo(self)
end

-- 点击默认触发
function __onDefaultClickHandler(self)
    if (self.m_propsGrid) then
        self.m_propsGrid:__onDefaultClickHandler()
    end
end

function setCallBack(self, cusCallObj, cusCallFun, ...)
    super.setCallBack(self, cusCallObj, cusCallFun, ...)

    if (self.m_propsGrid) then
        self.m_propsGrid:setClickEnable(false)
    end
end

return _M