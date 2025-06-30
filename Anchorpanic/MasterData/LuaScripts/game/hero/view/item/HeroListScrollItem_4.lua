--[[ 
-----------------------------------------------------
@filename       : HeroListScrollItem_4
@Description    : 战员小卡片（用于战员列表）
@Author         : lyx
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroListScrollItem_4", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mGoCur = self:getChildGO("mGoCur")
    self.mTxtCur = self:getChildGO("mTxtCur"):GetComponent(ty.Text)
    self.mTxtCur.text = _TT(1108)
    self.mBtnGuide = self:getChildGO("mBtnGuide")
    self:addOnClick(self.mBtnGuide, self.onClickItemHandler)
end

function getGuideTrans(self)
    return self.mBtnGuide.transform
end

function setData(self, param)
    super.setData(self, param)
    local heroSelectVo = self.data
    local isSelect = heroSelectVo:getSelect()
    local heroVo = heroSelectVo:getDataVo()
    if (heroVo) then
        local redType = heroSelectVo.redType
        local function __onLoadFinishHandler()
            self:updateBubbleView(hero.HeroFlagManager:getFlag(heroVo.id, heroSelectVo.heroRedStyle))
            self.mHeroCard:setDetailVisible(false)
        end
        self:updateBubbleView(false)
        if (not self.mHeroCard) then
            self.mHeroCard = hero.HeroCard:poolGet()
        end
        self.mHeroCard:setData(heroVo, nil, __onLoadFinishHandler)
        self.mHeroCard:setStarLvl(heroVo.evolutionLvl)
        self.mHeroCard:setParent(self:getChildTrans("mHeroCardNode"))
        self.mHeroCard:setShowUseState(false)
        self.mGoCur:SetActive(heroVo.id == hero.HeroManager:getPanelShowHeroId())
    else
        self.mGoCur:SetActive(false)
    end

end

function onBubbleUpdateHandler(self, args)
    local heroSelectVo = self.data
    local heroVo = heroSelectVo:getDataVo()
    if (heroVo.id == args.heroId) then
        self:updateBubbleView(args.isFlag)
    end
end

function updateBubbleView(self, isFlag)
    if (isFlag) then
        RedPointManager:add(self.UIObject.transform, nil, 97.6, 179.5)
    else
        RedPointManager:remove(self.UIObject.transform)
    end
end

function onClickItemHandler(self)
    local heroSelectVo = self.data
    local heroVo = heroSelectVo:getDataVo()
    hero.HeroManager:dispatchEvent(hero.HeroManager.PANEL_SINGLE_SELECT_HERO, { heroId = heroVo.id })
end

function deActive(self)
    super.deActive(self)
    if (self.mHeroCard) then
        self.mHeroCard:poolRecover()
        self.mHeroCard = nil
    end
    self:updateBubbleView(false)
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1108):	"当前"
]]