module("selectedHero.SelectedHeroItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("selectedHero/item/SelectedHeroItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.isSelect = false
    self.heroHeadGrid = nil
end

function configUI(self)
    self.mHeroGroup = self:getChildTrans("mHeroGroup")
    self.mHeroState = self:getChildGO("mHeroState")
    self.mTxtHeroState = self:getChildGO("mTxtHeroState"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.isSelectMask = self:getChildGO("IsSelect")
    self.btn = self:getChildGO("Btn")
    self.mBtnChack = self:getChildGO("mBtnChack")
end

function setData(self, cusParent, cusItemVo)
    self:setParentTrans(cusParent)
    self.vo = cusItemVo[1]
    self.id = cusItemVo[2]

    self:updateView()

    self.btn:SetActive(cusItemVo[3])
    -- self.isSelectMask:SetActive(cusItemVo[3])
end

function setIsSelect(self, is)
    self.isSelect = is
    self.isSelectMask:SetActive(self.isSelect)
end

function updateView(self)
    --战员自选
    if (not self.heroHeadGrid) then
        self.heroHeadGrid = HeroHeadGrid:poolGet()
    end
    local heroConfigVo = hero.HeroManager:getHeroConfigVo(self.vo.tid)
    self.heroHeadGrid:setData(heroConfigVo)
    self.heroHeadGrid:setParent(self.mHeroGroup)
    self.heroHeadGrid:setName("")
    self.heroHeadGrid:setEleType(true)
    local isObtain, heroVo = hero.HeroManager:getIsObtain(self.vo.tid)
    if isObtain then
        self.mHeroState:SetActive(true)
        local maxStarLvl = hero.HeroStarManager:getHeroMaxStarLvl()
        if heroVo.evolutionLvl == maxStarLvl then
            self.mTxtHeroState.text = "已满星"
        else
            self.mTxtHeroState.text = "已拥有"
        end
        self.heroHeadGrid:setLvl(heroVo.lvl)
        self.heroHeadGrid:setStarLvl(heroVo.evolutionLvl)
    else
        self.mHeroState:SetActive(false)
        self.heroHeadGrid:setLvl(1)
        self.heroHeadGrid:setStarLvl(heroConfigVo.star)
    end

    --通用的处理
    self.mTxtName.text = self.vo.name
    self.isSelectMask:SetActive(false)
end

function addAllUIEvent(self)
    self:addUIEvent(self.btn, self.onSelfClick)
    self:addUIEvent(self.mBtnChack, self.onCheckHandler)
end

function onSelfClick(self)
    if selectedHero.SelectedHeroManager:getCurrentCount() < selectedHero.SelectedHeroManager:getMaxCount() or self.isSelect == true then
        self.isSelect = not self.isSelect
        self.isSelectMask:SetActive(self.isSelect)
        selectedHero.SelectedHeroManager:dispatchEvent(selectedHero.SelectedHeroManager.EVENT_HERO_SELECT, self.id)
    else
        gs.Message.Show(_TT(4046))
    end
end

function onCheckHandler(self)
    GameDispatcher:dispatchEvent(EventName.DEACTIVE_SELECT_HERO_VIEW, false)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILSINFOPANEL, {heroTid = self.vo.tid})
end

function poolRecover(self)
    if(self.heroHeadGrid)then
        self.heroHeadGrid:poolRecover()
        self.heroHeadGrid = nil
    end
    super.poolRecover(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
