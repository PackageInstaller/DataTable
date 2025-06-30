--[[ 
-----------------------------------------------------
@filename       : ShopFragmentsView
@Description    : 碎片商店内容页
@date           : 2022-02-08 11:38:16
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
--
module('game.shop.view.sub.ShopFragmentsView', Class.impl(shop.ShopSubView))

--UIRes = UrlManager:getUIPrefabPath("shop/ShopFragmentsView.prefab")
--function active(self, args)
--    super.active(self, args)
--    self.mGroupRefresh:SetActive(false)
--    self.mTxtTime.gameObject:SetActive(false)
--    self.mItemBtnList = {}
--    self.mItemVoList = {}
--    self.sortType = 0
--    self:updateSort()
--end
--
--function deActive(self)
--    super.deActive(self)
--    self.sortType = 0
--    self:clearItem()
--    if self.mLyScroller then
--        self.mLyScroller:CleanAllItem()
--    end
--end
----更新排序
--function updateSort(self)
--    self:clearItem()
--    self.mItemVoList = { { page = 0, nomalLan = _TT(25196) }, { page = 1, nomalLan = _TT(25032) }, { page = 3, nomalLan = _TT(25033) }, { page = 4, nomalLan = _TT(25034) } }
--    self:getChildGO("mSubMenuCommon"):SetActive(false)
--    for i, vo in ipairs(self.mItemVoList) do
--        local btnCommon = SimpleInsItem:create(self:getChildGO("mBtnCommon"), self:getChildTrans("mSubMenuCommon"), "btnCommon" .. i)
--        btnCommon:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = vo.nomalLan
--        btnCommon:getChildGO("mTxtUnSelect"):GetComponent(ty.Text).text = vo.nomalLan
--        self.mItemBtnList[vo.page] = btnCommon
--    end
--    self:onCliclIndexBtnHandler(0)
--end
----帧监听回调
--function addAllUIEvent(self)
--    self:addUIEvent(self:getChildGO("mImgClick"), self.onClickSelectHandler)
--    for i, vo in ipairs(self.mItemVoList) do
--        self:addUIEvent(self.mItemBtnList[vo.page]:getChildGO("mImgClickCommon"), self.onCliclIndexBtnHandler, nil, vo.page)
--    end
--end
----选中回调
--function onCliclIndexBtnHandler(self, index)
--    local curVo
--    for _, vo in ipairs(self.mItemVoList) do
--        if vo.page == index then
--            curVo = vo
--            break
--        end
--    end
--    self:setSortPage(curVo.page)
--    for i, v in ipairs(self.mItemVoList) do
--        if v.page == curVo.page then
--            self.mItemBtnList[v.page]:getChildGO("mImgSelect"):SetActive(true)
--        else
--            self.mItemBtnList[v.page]:getChildGO("mImgSelect"):SetActive(false)
--        end
--    end
--    self:getChildGO("mTxtMenu"):GetComponent(ty.Text).text = curVo.nomalLan
--    self:getChildGO("mSubMenuCommon"):SetActive(false)
--end
----根据选中按钮设置显示页面
--function setSortPage(self, page)
--    self.sortType = page
--    self:updateShopList(true)
--end
----更新商品列表
--function updateShopList(self, isTween, isUpdate)
--    self.mShoplist = {}
--    local list = shop.ShopManager:getShopItemList(self:getShopType())
--    for i, vo in ipairs(list) do
--        if self.sortType == 0 or self:checkIsEnoughSort(self.sortType, vo) then
--            if vo:isEnoughLimit() then
--                table.insert(self.mShoplist, vo)
--            end
--        end
--    end
--
--    table.sort(self.mShoplist, function(a, b)
--        if a.lock < b.lock then
--            return true
--        elseif a.lock > b.lock then
--            return false
--        else
--            return a:getItemTid() < b:getItemTid()
--        end
--    end)
--    self:addShopItem()
--end
--
---- 是否符合筛选
--function checkIsEnoughSort(self, sortType, shopVo)
--    local propsConfigVo = shopVo:getItemConfigVo()
--    local heroTid = propsConfigVo.subType
--    local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
--    if sortType == heroConfigVo.professionType then
--        return true
--    end
--    return false
--end
---- 当前选中按钮显示
--function onClickSelectHandler(self)
--    local isOnClick = self:getChildGO("mSubMenuCommon").activeSelf == false and true or false
--    self:getChildGO("mSubMenuCommon"):SetActive(isOnClick)
--    self:getChildGO("mImgUp"):SetActive(isOnClick)
--    self:getChildGO("mImgDown"):SetActive(isOnClick == false)
--end
---- 删除临时预制体
--function clearItem(self)
--    if self.mItemBtnList then
--        for i, v in ipairs(self.mItemVoList) do
--            self.mItemBtnList[v.page]:poolRecover()
--        end
--        self.mItemBtnList = {}
--    end
--    if #self.mItemVoList > 0 then
--        self.mItemVoList = {}
--    end
--end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(25034):	"辅助"
	语言包: _TT(25033):	"输出"
	语言包: _TT(25032):	"坦克"
	语言包: _TT(25196):	"全部"
]]