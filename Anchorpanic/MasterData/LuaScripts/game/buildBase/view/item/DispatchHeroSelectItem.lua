module("buildBase.DispatchHeroSelectItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgSelect:SetActive(false)
    self.mGuideClick = self:getChildGO("mGuideClick")
    self.mImgDispatched = self:getChildGO("mImgDispatched")
    self.mHeroElem = self:getChildGO("mHeroElem"):GetComponent(ty.AutoRefImage)
end

function getGuideTrans(self)
    return self.mGuideClick.transform
end

function active(self)
    super.active(self)
end

function setData(self, data)
    super.setData(self, data)
    self.dataVo = self.data.m_dataVo
    if (self.dataVo) then
        self.tid = self.dataVo.tid
        if not self.mHeroHead then
            self.mHeroHead = HeroHeadGrid:poolGet()
        else
            self.mHeroHead:poolRecover()
            self.mHeroHead = HeroHeadGrid:poolGet()
        end
        if not self.mHeroNode then
            self.mHeroNode = self:getChildTrans("mHeroNode")
        end
        self.mHeroHead:setData(self.dataVo, false)
        self.mHeroHead:setScale(0.8)
        self.mHeroHead.m_textLvl.gameObject:SetActive(false)
        self.mHeroHead:setEleType(true)
        self.mHeroHead:setShowColor(false)
        self.mHeroHead:setType(true)
        self.mHeroHead:setParent(self.mHeroNode)
        self.mHeroElem:SetImg(UrlManager:getHeroEleTypeIconUrl(self.dataVo.eleType), false)
        self.isSelect = buildBase.DispatchDockManager:getHeroSelect(self.tid)
        self.mImgSelect:SetActive(self.isSelect)
        local isDispatched = buildBase.DispatchDockManager:getHeroDispathed(self.tid)
        self.mImgDispatched:SetActive(isDispatched)
        self:addOnClick(self.mGuideClick, self.onClickItemHandler)
    else
        self:deActive()
    end

end



function onClickItemHandler(self)
    -- if buildBase.BuildBaseHeroManager:checkHeroIsWork(self.tid) then
    --     UIFactory:alertMessge(_TT(76177), true, function()
    --         buildBase.DispatchDockManager:dispatchEvent(buildBase.DispatchDockManager.ON_HERO_SELECT, self.tid)
    --         buildBase.DispatchDockManager:flagShowTips()
    --     end, _TT(1), nil, true, 
    --     nil
    --     , _TT(2), _TT(5), nil, RemindConst.BUILDBASE_DISPATCH_HERO
    --     )
    -- else
       
    -- end
    buildBase.DispatchDockManager:dispatchEvent(buildBase.DispatchDockManager.ON_HERO_SELECT, self.tid)
end


function deActive(self)
    super.deActive(self)
    if self.mHeroHead then
        self.mHeroHead.m_textLvl.gameObject:SetActive(true)
        self.mHeroHead:poolRecover()
        self.mHeroHead = nil
    end
    self:removeOnClick(self.mGuideClick)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]