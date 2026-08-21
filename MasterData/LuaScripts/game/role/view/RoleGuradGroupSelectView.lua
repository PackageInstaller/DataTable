--[[ 
-----------------------------------------------------
@filename       : RoleGuradGroupSelectView
@Description    : 预备看板战员组选择战员
@date           : 2024-12-20 15:26:43
@Author         : Jacob
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.role.view.RoleGuradGroupSelectView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("role/RoleGuradGroupSelectView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
-- isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 480)
    self:setTxtTitle(_TT(41737)) --"值班选择"
    -- self:setBg("common_bg_016.jpg", false)
    -- self:setUICode(LinkCode.HomePage)
end
--析构  
function dtor(self)
end

function initData(self)

    self.mTabList = {}

end

-- 初始化
function configUI(self)
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(role.RoleGuradGroupSelectItem)

    self.mEmptyStateItem = self:getChildGO("EmptyStateItem")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)

    self.mGroupTabItem = self:getChildTrans("mGroupTabItem")
    self.mShopTabChildItem = self:getChildGO("mShopTabChildItem")
end

--激活
function active(self, args)
    super.active(self, args)

    self.selectId = args.selectId
    if self.selectId then
        self.mGuradType, self.id = role.RoleManager:getGuradTypeAndId(self.selectId)
    else
        self.mGuradType = role.GuradType.Gurad_hero
    end

    GameDispatcher:addEventListener(EventName.HERO_GROUP_SELECT_ONE, self.onHeroGroupSelectOne, self)

    self.mIsShowSpine = role.RoleManager:getHeroGroupShowSpine()

    table.insert(self.mTabList, { page = 1, nomalLan = "助理选择", nomalLanId = 84510 })
    if self.mIsShowSpine == 1 then
        table.insert(self.mTabList, { page = 2, nomalLan = "图册选择", nomalLanId = 84511 })
    end
    self:creatTab()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.HERO_GROUP_SELECT_ONE, self.onHeroGroupSelectOne, self)
    if self.mLyScroller then
        self.mLyScroller:CleanAllItem()
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtEmptyTip.text = _TT(41742)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateView(self, cusIndex)
    local scrollList = {}

    if cusIndex == 1 then
        local heroList = hero.HeroManager:getHeroList()
        for i, heroVo in ipairs(heroList) do
            if self.mIsShowSpine == 0 or (self.mIsShowSpine == 1 and hero.HeroInteractManager:getModelIsDynamic(heroVo:getHeroModel())) then

                local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
                scrollerVo:setDataVo(heroVo)
                scrollerVo:setSelect(tonumber(self.id) == heroVo.id)
                scrollerVo:setArgs(role.GuradType.Gurad_hero)
                table.insert(scrollList, scrollerVo)
            end
        end
        self.mLyScroller.DataProvider = scrollList

        self.mEmptyStateItem:SetActive(not scrollList or table.empty(scrollList))
    else
        local paintingList = purchase.FashionShopManager:getAllUnlockPatintingData()
        for k, vo in pairs(paintingList) do

            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollerVo:setDataVo(vo)
            scrollerVo:setSelect(tonumber(self.id) == vo.id)
            scrollerVo:setArgs(role.GuradType.Gurad_painting)
            table.insert(scrollList, scrollerVo)
        end

        self.mLyScroller.DataProvider = scrollList
        self.mEmptyStateItem:SetActive(not scrollList or table.empty(scrollList))

    end

end

function updateHeroItem(self)

end

function onHeroGroupSelectOne(self, args)
    self:close()
end


function onClickChildItem(self, index)
    for k, v in pairs(self.mSubViewItem) do
        v:getChildGO("mBtnNomal"):SetActive(k ~= index)
        v:getChildGO("mBtnSelect"):SetActive(k == index)
    end

    self.mLastIndex = index

    self:updateView(index)
end

function creatTab(self)
    self:clearTabItem()
    for k, v in ipairs(self.mTabList) do
        local item = SimpleInsItem:create(self.mShopTabChildItem, self.mGroupTabItem, "mFashionShopSub")
        item:getChildGO("mTxtNomal"):GetComponent(ty.Text).text = v.nomalLan --_TT(v.nomalLanId)
        item:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = v.nomalLan --_TT(v.nomalLanId)
        -- self:setBtnLabel(item:getChildGO("onClickChildItem"), v.nomalLanId)
        item:addUIEvent("mBtnClick", function()
            self:onClickChildItem(v.page)
        end)
        self.mSubViewItem[v.page] = item
    end

    if self.mGuradType == role.GuradType.Gurad_hero then
        self:onClickChildItem(1)
    else
        self:onClickChildItem(2)
    end

end


function clearTabItem(self)
    if self.mSubViewItem then
        for k, v in pairs(self.mSubViewItem) do
            v:poolRecover()
        end
    end
    self.mSubViewItem = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]