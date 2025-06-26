--[[ 
-----------------------------------------------------
@filename       : FavorableCaseView
@Description    : 战员档案-秘闻
@date           : 2021-08-20 12:06:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.view.tab.FavorableCaseView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("favorable/tab/FavorableCaseView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function setMask(self)
end

function initData(self)
    self.mItemList = {}
end

-- 初始化
function configUI(self)
    self.mBtnMass = self:getChildGO("mBtnMass")
    self.mContent = self:getChildTrans("mContent")
    self.mGroupMass = self:getChildGO("mGroupMass")
    self.mScrollView = self:getChildTrans("mScrollView")
    self.mTxtMassNum = self:getChildGO("mTxtMassNum"):GetComponent(ty.Text)
    self.mTxtBtnMass = self:getChildGO("mTxtBtnMass"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mHeroId = args.heroId
    self.mHeroTid = args.heroTid
    if (self.mHeroId ~= nil) then
        self.curHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    else
        self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    end
    self:updateView()
    GameDispatcher:addEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItemList()
    GameDispatcher:removeEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
end

function onChangeHero(self, args)
    self.mHeroId = args.heroId
    self.mHeroTid = args.heroTid

    if (self.mHeroId ~= nil) then
        self.curHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    else
        self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    end
    self:updateView()
end

function updateView(self)
    self:recoverItemList()
    local list = favorable.FavorableManager:getCaseList(self.mHeroTid)
    for i, v in ipairs(list) do
        v.tweenId = i
        local item = favorable.FavorableCaseItem:poolGet()
        item:setData(self.mContent, v, self.mHeroId, self.mHeroTid)
        item:addEventListener(item.EVENT_CHANGE, self.onUpdateCaseShow, self)
        table.insert(self.mItemList, item)
    end
    self:updateMass(self.mHeroTid)
end

function itemLocation(self, id)
    local targetItem = nil
    for index, item in ipairs(self.mItemList) do
        item:setSelect(item.data.id == id)
        if item.data.id == id then
            targetItem = item
        end
    end
    if targetItem then
        self:addTimer(0.1, 1, function()
            local targetPosY = (math.abs(targetItem.UITrans.anchoredPosition.y) + (targetItem.UITrans.rect.height / 2)) - self:getChildTrans("mContent").anchoredPosition.y - self.mScrollView.rect.height
            if targetPosY > 0 then
                targetPosY = targetPosY + 13
                gs.TransQuick:LPosY(self:getChildTrans("mContent"), (self:getChildTrans("mContent").anchoredPosition.y + targetPosY))
            end
        end)
    end
end

--更新集结状态
function updateMass(self, heroTid)
    if hero.HeroManager:getIsObtain(heroTid) or self.isNoMass then
        self.mGroupMass:SetActive(false)
        return
    else
        self.mGroupMass:SetActive(true)
        local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
        local hasCount = bag.BagManager:getPropsCountByTid(heroConfigVo.needFragment[1])
        local needCount = heroConfigVo.needFragment[2]
        self.mTxtMassNum.text = HtmlUtil:color(hasCount, hasCount >= needCount and ColorUtil.GREEN_NUM or ColorUtil.RED_NUM) .. "/" .. needCount
        local btnTxtColor = hasCount >= needCount and "202226ff" or "202226ff"
        self.mTxtBtnMass.text = HtmlUtil:color("集结", btnTxtColor)
        return
    end
end

function onUpdateCaseShow(self, id)
    self:itemLocation(id)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnMass, self.onClickMassHandler)
end

--集结
function onClickMassHandler(self)
    local isCanUnLock = hero.HeroFlagManager:isHeroCanUnLock(self.curHeroVo)
    if (isCanUnLock) then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_FRAGMENT_COMPOSE, { heroTid = self.mHeroTid })
    else
        gs.Message.Show(_TT(4306))
    end
end

function recoverItemList(self)
    for i, item in ipairs(self.mItemList) do
        item:removeEventListener(item.EVENT_CHANGE, self.onUpdateCaseShow, self)
        item:poolRecover()
    end
    self.mItemList = {}
end

function onDispose(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]