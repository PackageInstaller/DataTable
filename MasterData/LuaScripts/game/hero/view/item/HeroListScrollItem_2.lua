--[[ 
-----------------------------------------------------
@filename       : HeroListScrollItem_2
@Description    : 战员小卡片（用于战员列表）
@Author         : zzz
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroListScrollItem_2", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mGroupUnGet = self:getChildGO("mGroupUnGet")
    self.mTextFragment = self:getChildGO("mTextFragment"):GetComponent(ty.Text)
    self.mImgUnlock = self:getChildGO("mImgUnlock")
    self.mImgLock = self:getChildGO("mImgLock")
    self.mGuideClick = self:getChildGO("mGuideClick")
    self.mMain2 = self:getChildTrans("mMain_2")
    self.mImgFragmentBg = self:getChildGO("mImgFragmentBg")
    self:addOnClick(self.mGuideClick, self.onClickItemHandler)
end

function getGuideTrans(self)
    return self.mGuideClick.transform
end

function setData(self, param)
    super.setData(self, param)
    local heroSelectVo = self.data
    local isSelect = heroSelectVo:getSelect()
    local dataVo = heroSelectVo:getDataVo()
    if (dataVo) then
        local function __onLoadFinishHandler()
            if hero.HeroManager:getIsObtain(dataVo.tid) then
                self:updateBubbleView(hero.HeroFlagManager:getFlag(dataVo.id))
                hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_HERO_ID_ROOT, self.onBubbleUpdateHandler, self)
            end
            self.mHeroCard:setDetailVisible(false)
        end
        self:updateBubbleView(false)
        if (not self.mHeroCard) then
            self.mHeroCard = hero.HeroCard2:poolGet()
        end
        self.mHeroCard:setData(dataVo, nil, __onLoadFinishHandler)
        self.mHeroCard:setStarLvl(dataVo.evolutionLvl)
        self.mHeroCard:setParent(self:getChildTrans("mHeroCardNode"))
        self.mHeroCard:setShowUseState(false)
        self.mImgFragmentBg:SetActive(false)
        if (dataVo.__cname == hero.HeroVo.__cname) then
            self.mGroupUnGet:SetActive(false)
            self:updateBubbleView(hero.HeroFlagManager:getFlag(dataVo.id))
            hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_HERO_ID_ROOT, self.onBubbleUpdateHandler, self)
        elseif (dataVo.__cname == hero.HeroConfigVo.__cname) then
            self.mGroupUnGet:SetActive(true)
            if self.mPropGrid then
                self.mPropGrid:poolRecover()
                self.mPropGrid = nil
            end
            local propsConfigVo = props.PropsManager:getPropsConfigVo(dataVo.needFragment[1])
            local hasCount = bag.BagManager:getPropsCountByTid(dataVo.needFragment[1])
            local needCount = dataVo.needFragment[2]
            local imgPath = hasCount < needCount and "hero5/hero_list_lock.png" or "hero5/hero_list_unlock.png"
            self.mPropGrid = PropsGrid:create(self:getChildTrans("mImgFragment"), { dataVo.needFragment[1], 1 }, 0.4)
            self.mPropGrid:setShowColorBgState(false)
            self.mImgLock:SetActive(hasCount < needCount)
            self.mImgUnlock:SetActive(hasCount >= needCount)
            self.mTextFragment.text = string.format("%s/%s", HtmlUtil:color(hasCount, hasCount >= needCount and "ffb136ff" or ColorUtil.RED_NUM), needCount)
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(dataVo.tid)
            local hasCount = bag.BagManager:getPropsCountByTid(heroConfigVo.needFragment[1])
            local needCount = heroConfigVo.needFragment[2]
            self:updateBubbleView(false)
            if hasCount >= needCount and hero.HeroManager:getIsObtain(dataVo.tid) == false then
                if dataVo.tid == self.data:getDataVo().tid then
                    self:updateBubbleView(true)
                else
                    self:updateBubbleView(false)
                end
            end
        end
    else
        self:deActive()
    end
end

function onBubbleUpdateHandler(self, args)
    local heroSelectVo = self.data
    local dataVo = heroSelectVo:getDataVo()
    if (dataVo.__cname == hero.HeroVo.__cname) then
        if (dataVo.id == args.heroId) then
            self:updateBubbleView(args.isFlag)
        end
    elseif (dataVo.__cname == hero.HeroConfigVo.__cname) then
        if (hero.HeroFlagManager:getConfigId(dataVo.tid) == args.heroId) then
            self:updateBubbleView(args.isFlag)
        end
    end
end

function updateBubbleView(self, isFlag)
    if (isFlag and not self.mGroupUnGet.activeSelf) then
        RedPointManager:add(self.mMain2, nil, 99.6, 258.6)
    else
        RedPointManager:remove(self.mMain2)
    end
end


function onClickItemHandler(self)
    local heroSelectVo = self.data
    local dataVo = heroSelectVo:getDataVo()
    if (dataVo.__cname == hero.HeroVo.__cname) then
        hero.HeroManager:dispatchEvent(hero.HeroManager.HERO_LIST_SELECT, { heroVo = dataVo })
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, { heroId = dataVo.id, tabType = hero.DevelopTabType.LVL_UP, subData = {} })
    elseif (dataVo.__cname == hero.HeroConfigVo.__cname) then
        GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, { heroTid = dataVo.tid })
        --GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILS_PANEL, { heroId = dataVo.id, heroTid = dataVo.tid })
    end
end

function deActive(self)
    super.deActive(self)
    self:updateBubbleView(false)
    if (self.mHeroCard) then
        self.mHeroCard:poolRecover()
        self.mHeroCard = nil
    end
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_HERO_ID_ROOT, self.onBubbleUpdateHandler, self)
end

function onDelete(self)
    super.onDelete(self)
end

function destroy(self)
    super.destroy(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1108):	"当前"
]]