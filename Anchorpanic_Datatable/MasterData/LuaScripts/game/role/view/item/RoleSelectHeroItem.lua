module("role.RoleSelectHeroItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
	super.onInit(self, go)
    self.m_textPos = self.m_childGos["TextPos"]:GetComponent(ty.Text)

    self.m_transHeroCardNode = self.m_childTrans["HeroCardNode"]
    self.m_goToucher = self.m_childGos["ImgToucher"]

    self.m_goSelect = self.m_childGos["ImgSelect"]
    self.m_childGos["TextSelect"]:GetComponent(ty.Text).text = _TT(25207)
    self.m_goShow = self.m_childGos["ImgShow"]
    self.m_goShow:SetActive(false)
    self.m_childGos["TextShow"]:GetComponent(ty.Text).text = _TT(25168)
end

function setData(self, param)
	super.setData(self, param)
    local heroSelectVo = self.data
    local isSelect = heroSelectVo:getSelect()
    local heroVo = heroSelectVo:getDataVo()

    self.m_goSelect:SetActive(isSelect)
    if (heroVo) then
        -- todo ui4
        -- if (not self.m_heroCard) then
        --     self.m_heroCard = hero.HeroCard:poolGet()
        -- end
        -- self.m_heroCard:setData(heroVo)
        -- self.m_heroCard:setScale(1)
        -- self.m_heroCard:setStarLvl(heroVo.evolutionLvl)
        -- self.m_heroCard:setParent(self.m_transHeroCardNode)

        local showHeroList, showHeroPosDic, showHeroIdDic = role.RoleManager:getRoleVo():getShowHeroData()
        local pos = showHeroIdDic[heroVo.id]
        -- if(pos)then
        --     self.m_textPos.text = pos
        --     self.m_goShow:SetActive(false)
        -- else
        --     self.m_goShow:SetActive(false)
        --     self.m_textPos.text = ""
        -- end
    else
        self:deActive()
    end

    self:removeOnClick(self.m_goToucher)
    self:addOnClick(self.m_goToucher, self.onClickItemHandler)
end

function onClickItemHandler(self)
    GameDispatcher:dispatchEvent(EventName.ROLE_HERO_LIST_SELECT, {heroVo = self.data:getDataVo()})
end

function deActive(self)
	super.deActive(self)
    if (self.m_heroCard) then
        self.m_heroCard:poolRecover()
        self.m_heroCard = nil
    end
    self.data = nil
end

function onDelete(self)
	super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25207):	"-当前选中-"
	语言包: _TT(25168):	"展示中"
]]
