--[[ 
-----------------------------------------------------
@filename       : RogueLikeShopItem
@Description    : 肉鸽商店item
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeShopItem", Class.impl(BaseReuseItem))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeShopItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构
function dtor(self)
end

function initData(self)
    self.isSelect = false
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnGroup = self:getChildGO("mBtnGroup")

    self.mNameTxt = self:getChildGO("mNameTxt"):GetComponent(ty.Text)
    self.mBuffIcon = self:getChildGO("mBuffIcon"):GetComponent(ty.AutoRefImage)
    self.mDesTxt = self:getChildGO("mDesTxt"):GetComponent(ty.Text)
    self.mCostIcon = self:getChildGO("mCostIcon"):GetComponent(ty.AutoRefImage)
    self.mCostTxt = self:getChildGO("mCostTxt"):GetComponent(ty.Text)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.AutoRefImage)
    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mBtnLock = self:getChildGO("mBtnLock")
    self.mBtnLockImg = self:getChildGO("mBtnLock"):GetComponent(ty.AutoRefImage)
    self.mIsBuy = self:getChildGO("mIsBuy")
end

-- 激活
function active(self)
    super.active(self)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGroup, self.onClick)
    self:addUIEvent(self.mBtnLock, self.onSwitchLock)
end

function setData(self, cusParent, cusCellId, goodData, showState)
    self:setParentTrans(cusParent)
    self:setSelect(false)

    self.cellId = cusCellId
    if showState == 0 then
        self.grooveId = goodData.groove_id
        self.showId = goodData.goods_id
        self.price = goodData.price
        self.isBuy = goodData.is_buy
        self.isLock = goodData.is_lock
    else
        self.showId = goodData
        --self.price = goodData.price
        self.grooveId = 0
        self.isBuy = 0
        self.isLock = 0
    end

    self.mBtnLock:SetActive(showState == 0)
    self.showState = showState

    local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.showId)
    self.mNameTxt.text = goodsConfigVo:getName()
    self.mDesTxt.text = goodsConfigVo:getDes()

    if self.showState == 0 then
        self.mCostTxt.text = self.price
        self.mImgState:SetImg(UrlManager:getCommonPath("common_1006.png"), false)
    else
        self.mCostTxt.text = goodsConfigVo:getSellCost()[2]
        self.mImgState:SetImg(UrlManager:getCommonPath("common_1007.png"), false)
    end

    self.mIsBuy:SetActive(self.isBuy > 0)
    self:updateLock()
end

function onSwitchLock(self)
    self.isLock = 1 - self.isLock
    rogueLike.RogueLikeManager:updateLockState(self.grooveId, self.isLock)
    self:updateLock()
end
-- 切换锁定状态
function updateLock(self)
    local url
    if self.isLock == 0 then
        url = UrlManager:getCommon4Path("common_5419.png")
    else
        url = UrlManager:getCommon4Path("common_5402.png")
    end
    self.mBtnLockImg:SetImg(url, false)
end

function setSelect(self, isSelect)
    self.isSelect = isSelect
    self:updateState()
end

function updateState(self)
    self.mIsSelect:SetActive(self.isSelect)
end

function onClick(self)
    if self.isBuy > 0 then
        gs.Message.Show("商品已经购买")
        return
    end
    self:dispatchEvent(self.EVENT_CHANGE, {item = self, showId = self.showId, grooveId = self.grooveId,price = self.price})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
