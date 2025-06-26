module("battleMap.BiographyTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/biography/BiographyTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.Biography)
end

function initData(self)
    self.mAttrList = {_TT(81056), _TT(81052), _TT(81051), _TT(81053), _TT(81054), _TT(81055)}
    self.cusAttrType = 0
    self.attrMenuItem = {}
end

function configUI(self)
    self.mScroller = self:getChildGO('LyScroller'):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(battleMap.BiographyItem)
    self.mGroup = self:getChildTrans('mGroup')
    self.mAttrMenu = self:getChildGO('mAttrMenu')

    self.mTxtChallengeNum = self:getChildGO('mTxtChallengeNum'):GetComponent(ty.Text)
    self.mTxt = self:getChildGO('mTxt'):GetComponent(ty.Text)
    self.mLine = self:getChildGO('BiographyEntryLine')
    self.mGoEmpty = self:getChildGO("mGoEmpty")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self:setGuideTrans("funcTips_biography_1", self:getChildTrans("mGuideBiography1"))
    self:setGuideTrans("funcTips_biography_hero", self:getChildTrans("mGuideBiographyHero"))
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end
---------------------------------------------------------------start 排序相关--------------------------------------------------------------
-- 排序菜单
function initSort(self)
    self.m_menu = self:getChildGO('Menu')
    self.m_dropDown = self:getChildGO('DropDown')
    self.m_itemSubMenu = self:getChildGO('ItemSubMenu')
    self:addOnClick(self.m_menu, self.__clickMenu)

    self:__updateMenuList()
    self:__updateSortView()
    self:sortAttr()
end

function __updateMenuList(self)
    -- 是否打开排序菜单
    self.m_isOpenMenu = false
    -- 当前的排序类型列表数据
    self.m_sortList = {-1, hero.ProfessionType.TANK, hero.ProfessionType.OUTPUT, hero.ProfessionType.ASSISTER, hero.ProfessionType.CONTROL, hero.ProfessionType.NUCLEUS}
    -- 当前选择的排序类型
    self.m_curSortType = self.m_curSortType or self.m_sortList[1]
    -- 当前的排序内容列表数据
    self.m_sortPageList = {}
    for i = 1, #self.m_sortList do
        local sortType = self.m_sortList[i]
        table.insert(self.m_sortPageList, {page = sortType, nomalLan = sortType ~= -1 and hero.getProfessionName(sortType) or _TT(4011), nomalLanEn = ""})
    end
    if(self.tabBar)then
        self.tabBar:reset()
    end
    self.tabBar = CustomTabBar:create(self.m_itemSubMenu, self.m_dropDown.transform, self.__clickSubMenu, self)
    self.tabBar:setData(self.m_sortPageList)
    self.tabBar:setDispatcherSame(false)
    self.tabBar:setType(self.m_curSortType, false)
end

function __clickMenu(self)
    self.m_isOpenMenu = not self.m_isOpenMenu
    self:__updateSortView()
end

function __clickSubMenu(self, sortType)
    self.m_curSortType = sortType
    self.m_isOpenMenu = false
    self:__updateMenuList()
    self:__updateSortView()
end

function sortAttr(self)
    self:recoverAttrMenuItem()
    for i=1, 6 do 
        local item = SimpleInsItem:create(self.mAttrMenu, self.mGroup, "AttrMenuItem")
        item:getChildGO("mTxtAttr"):GetComponent(ty.Text).text = self.mAttrList[i]
        item:getChildGO("mImgAttr"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("biography/img_icon_0"..i..".png"))
        local function onclickItem()
            if(self.cusAttrType == i)then
                self.cusAttrType = 0
            else
                self.cusAttrType = i
            end

            self:updateSortAttr()
            self:__updateView()
        end
        item:addUIEvent(nil, onclickItem)
        table.insert(self.attrMenuItem, item)
    end
    self:updateSortAttr()
end

function updateSortAttr(self)
    for i=1, #self.attrMenuItem do
        local item = self.attrMenuItem[i]
        local bg = item:getChildGO("mImgBg"):GetComponent(ty.Image)
        local txt = item:getChildGO("mTxtAttr"):GetComponent(ty.Text)
        local img = item:getChildGO("mImgAttr"):GetComponent(ty.AutoRefImage)
        if (i == self.cusAttrType) then     --选中
            bg.color = gs.ColorUtil.GetColor("FFFFFFFF")
            -- txt.color = gs.ColorUtil.GetColor("ffffffff")
            -- img.color = gs.ColorUtil.GetColor("ffffffff")
        else
            bg.color = gs.ColorUtil.GetColor("00000000")
            -- txt.color = gs.ColorUtil.GetColor("202226ff")
            -- img.color = gs.ColorUtil.GetColor("202226ff")
        end
    end
end

function __updateSortView(self)
    -- 排序菜单状态
    self:setBtnLabel(self.m_menu, -1, self.m_curSortType ~= -1 and hero.getProfessionName(self.m_curSortType) or _TT(4011))
    self.m_dropDown:SetActive(self.m_isOpenMenu)
    
    self:__updateView()
end
---------------------------------------------------------------end 排序相关--------------------------------------------------------------

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
end

function __playerClose(self)
    self.mHasInit = false
end
--规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.Biography })
end

function active(self)
    super.active(self)
    self:initSort()
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID},1)
    GameDispatcher:addEventListener(EventName.UPDATE_HERO_BIOGRAPHY, self.__onUpdateListHandler, self)
    self.anim = self.UITrans:GetComponent(ty.Animator)
    if not gs.GoUtil.IsCompNull(self.anim) then
        if not self.isReshow then 
            self.anim:SetTrigger("show")
        end
    end
    
    -- self:__updateView()
    self.mHasInit = true
end

function deActive(self)
    super.deActive(self)
    self.mScroller:CleanAllItem()
    self.m_curSortType = -1
    self.m_isOpenMenu = false
    -- self:__updateSortView()
    -- self:recoverLineAndItem()
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID},1)
    GameDispatcher:removeEventListener(EventName.UPDATE_HERO_BIOGRAPHY, self.__onUpdateListHandler, self)
end

function initViewText(self)
    self.mTxt.text = _TT(49010)
    self.mTxtEmptyTip.text = _TT(73201)
end

function __onUpdateListHandler(self)
    self:__updateView()
end

function __updateView(self)
    local restTime = battleMap.BiographyManager:getResTimes()
    self.mTxtChallengeNum.text = restTime
    self.mTxtChallengeNum.color = gs.ColorUtil.GetColor(restTime == 0 and "ffffffff" or "18EC68ff")
    local list = battleMap.BiographyManager:getHeroConfigList(self.m_curSortType, self.cusAttrType - 1)
    local hasData = #list > 0
    self.mScroller.gameObject:SetActive(hasData)
    self.mGoEmpty:SetActive(not hasData)
    if(not hasData) then 
        return
    end
    local dataList = {}
    local subDataList = {}
    for i=1,#list do
        local index = i % 4 
        if(index == 0) then 
            index = 4 
        end
        if(index == 1 and i ~= 1) then 
            table.insert(dataList, {dataList = subDataList})
            subDataList = {}
        end
        table.insert(subDataList, list[i])
    end
    if(#subDataList>0) then 
        table.insert(dataList, {dataList = subDataList})
    end
    if(self.mScroller.Count <= 0 or not self.mHasInit)then
        self.mScroller.DataProvider = dataList
    else
        self.mScroller:ReplaceAllDataProvider(dataList)
    end
    dataList = {}
    subDataList = {}
end

function recoverAttrMenuItem(self)
    for k,v in pairs(self.attrMenuItem) do 
        if v then 
            v:poolRecover()
        end
    end
    self.attrMenuItem = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(49010):	"剩余挑战次数："
]]
