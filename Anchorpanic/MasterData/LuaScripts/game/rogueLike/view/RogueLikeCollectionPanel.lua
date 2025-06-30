--[[ 
-----------------------------------------------------
@filename       : RogueLikeCollectionPanel
@Description    : 肉鸽任务界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("rogueLike.RogueLikeCollectionPanel", Class.impl(TabView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeCollectionPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52094))
    self:setBg("common_bg_015.jpg", false)
end

-- 可Override后提供需要active传入子页面的参数
function getActiveArgs(self)
    return {}
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mSuitClick = false
    self.mIsDesc = false
    self.mCurrentFilter = nil
    self.filterItemsDic = {}
end

function getTabViewParent(self)
    return self:getChildTrans("ViewContent")
end

function setCurPage(self, page)
    self.mDefaultPage = page
end

function getTabClass(self)
    self.tabClassDic[rogueLike.CollectionType.All] = rogueLike.RogueLikeCollectionTabView
    self.tabClassDic[rogueLike.CollectionType.Attack] = rogueLike.RogueLikeCollectionTabAttack
    self.tabClassDic[rogueLike.CollectionType.Defense] = rogueLike.RogueLikeCollectionTabDefense
    self.tabClassDic[rogueLike.CollectionType.Treet] = rogueLike.RogueLikeCollectionTabTreet
    self.tabClassDic[rogueLike.CollectionType.Special] = rogueLike.RogueLikeCollectionTabSpecial
    self.tabClassDic[rogueLike.CollectionType.Adverse] = rogueLike.RogueLikeCollectionTabAdverse
    return self.tabClassDic
end

function updateTab(self)
    local list = rogueLike.RogueLikeConst:getCollectionList()
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.mContent, self.setType, self)
    self.tabBar:setData(list)
    self.tabBar:setPage(self.mDefaultPage)
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mContent = self:getChildTrans("Content")
    self.mDefaultPage = rogueLike.CollectionType.All

    self.mNodeFilter = self:getChildGO("NodeFilter")

    self.suitSortMenu = self:getChildGO("SuitSortMenu")
    self.suitMenu = self:getChildGO("SuitMenu")
    self.suitImgUp = self:getChildGO("SuitImgUp")
    self.suitImgDown = self:getChildGO("SuitImgDown")
    self.suitTxtMenu = self:getChildGO("SuitTextMenu"):GetComponent(ty.Text)

    self.suitDropDown = self:getChildGO("SuitDropDown")
    self.subMenuSuitScroll = self:getChildGO("SubMenuSuitScroll"):GetComponent(ty.ScrollRect)
    self.btnSuit = self:getChildGO("BtnSuit")

    self.menuSort = self:getChildGO("MenuSort")
    self.imgSortUp = self:getChildGO("ImgSortUp")
    self.imgSortDown = self:getChildGO("ImgSortDown")
    self.imgClick = self:getChildGO("ImgClick")
end

function addAllUIEvent(self)
    self:addUIEvent(self.imgClick, self.sortClick)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.isShowHas = args.showHas
    self:updateFilter()
    self:updateTab()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearItemDic()
    self.tabBar:reset()
end

rogueLike.filterDic = {}
rogueLike.filterDic[rogueLike.BuffLevel.All] = _TT(56073)
--rogueLike.filterDic[rogueLike.BuffLevel.Green] = _TT(15)
rogueLike.filterDic[rogueLike.BuffLevel.Blue] = _TT(16)
rogueLike.filterDic[rogueLike.BuffLevel.Purple] = _TT(17)
rogueLike.filterDic[rogueLike.BuffLevel.Orange] = _TT(18)
-- rogueLike.filterList = {rogueLike.BuffLevel.All, rogueLike.BuffLevel.Green, rogueLike.BuffLevel.Purple, rogueLike.BuffLevel.Orange}
-- rogueLike.filterName = {"全部", "蓝", "紫", "橙"}

function updateFilter(self)

    self:clearItemDic()
    for k, v in pairs(rogueLike.filterDic) do
        local filterItem = SimpleInsItem:create(self.btnSuit, self.subMenuSuitScroll.content, "RogueLikeCollectionPanelfilter")
        filterItem:getChildGO("TextUnSelect"):GetComponent(ty.Text).text = v
        filterItem:getChildGO("TextSelect"):GetComponent(ty.Text).text = v

        self:addUIEvent(filterItem:getChildGO("ImgClick"), self.onFilterItemClick, nil, k)
        self.filterItemsDic[k] = filterItem
        -- table.insert(self.filterItems, filterItem)
    end

    -- for i = 1, #rogueLike.filterList do
    --     local filterItem = SimpleInsItem:create(self.btnSuit, self.subMenuSuitScroll.content, "filter" .. i)
    --     filterItem:getChildGO("TextUnSelect"):GetComponent(ty.Text).text = rogueLike.filterName[i]
    --     filterItem:getChildGO("TextSelect"):GetComponent(ty.Text).text = rogueLike.filterName[i]

    --     self:addUIEvent(filterItem:getChildGO("ImgClick"), self.onFilterItemClick, nil, i)
    --     table.insert(self.filterItems, filterItem)
    -- end

    self:addUIEvent(self.suitMenu, self.onSuitMenuClick)

    self:onFilterItemClick(rogueLike.BuffLevel.All)
    self:sortClick()
end

function onSuitMenuClick(self)
    self.mSuitClick = not self.mSuitClick

    self.suitImgUp:SetActive(self.mSuitClick)
    self.suitImgDown:SetActive(not self.mSuitClick)
    self.subMenuSuitScroll.gameObject:SetActive(self.mSuitClick)
end

function onFilterItemClick(self, id)
    self.mCurrentFilter = id
    self.suitTxtMenu.text = rogueLike.filterDic[id]

    for k, v in pairs(self.filterItemsDic) do
        self.filterItemsDic[k]:getChildGO("ImgUnSelect"):SetActive(not (id == k))
        self.filterItemsDic[k]:getChildGO("ImgSelect"):SetActive(id == k)

        self.filterItemsDic[k]:getChildGO("TextUnSelect"):SetActive(not (id == k))
        self.filterItemsDic[k]:getChildGO("TextSelect"):SetActive(id == k)
    end
    self.mSuitClick = false
    self.subMenuSuitScroll.gameObject:SetActive(self.mSuitClick)
    rogueLike.RogueLikeManager:updateFilterData({isDesc = self.mIsDesc, currentFilter = self.mCurrentFilter, isShowHas = self.isShowHas})
end

function sortClick(self)
    self.mIsDesc = not self.mIsDesc

    self.imgSortUp:SetActive(self.mIsDesc)
    self.imgSortDown:SetActive(not self.mIsDesc)

    rogueLike.RogueLikeManager:updateFilterData({isDesc = self.mIsDesc, currentFilter = self.mCurrentFilter, isShowHas = self.isShowHas})
end

function clearItemDic(self)
    for k, v in pairs(self.filterItemsDic) do
        self.filterItemsDic[k]:poolRecover()
    end
    self.filterItemsDic = {}
end

return _M

 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(18):	"橙"
	语言包: _TT(17):	"紫"
	语言包: _TT(16):	"蓝"
	语言包: _TT(15):	"绿"
]]
