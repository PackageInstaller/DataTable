module('role.RoleHeroSelectListItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
    self.mHeadNode = self:getChildTrans("mHeadNode")
    self.mImgFight = self:getChildGO("mImgFight")
    self.mImgSelectState = self:getChildGO("mImgSelectState")
end

function getTrans(self)
    return self:getChildTrans("mImgToucher")
end

function setData(self, param)
    super.setData(self, param)
    local dataVo = self.data:getDataVo()
    if (dataVo) then
        -- 我方英雄vo
        if (self.mHeadGrid) then
            self.mHeadGrid:poolRecover()
            self.mHeadGrid = nil
        end
        local heroVo = dataVo
        self.mHeadGrid = HeroHeadGrid:poolGet()
        self.mHeadGrid:setData(heroVo)
        self.mHeadGrid:setParent(self.mHeadNode)
        self.mHeadGrid:setLvl(heroVo.lvl)
        self.mHeadGrid:setType(true)
        local showHeroList, showHeroPosDic, showHeroIdDic, tempHeroList = role.RoleManager:getRoleVo():getShowHeroData()
        local pos = showHeroIdDic[heroVo.id]
        self.mImgSelectState:SetActive(false)
        for i, vo in ipairs(tempHeroList) do
            if vo == heroVo.id then
                self.mImgSelectState:SetActive(true)
            end
        end
        self.mImgFight:SetActive(false)
        self:addOnClick(self:getChildGO("mImgToucher"), self.onClickHeadHandler)
    else
        self:deActive()
    end
end

function onClickHeadHandler(self)
    role.RoleManager:setSelectId(self.data:getDataVo().id)
    GameDispatcher:dispatchEvent(EventName.ROLE_HERO_LIST_SELECT, { heroVo = self.data:getDataVo() })
end

function deActive(self)
    super.deActive(self)
    if (self.mHeadGrid) then
        self.mHeadGrid:poolRecover()
        self.mHeadGrid = nil
    end
    self:removeOnClick(self:getChildGO("mImgToucher"))
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
