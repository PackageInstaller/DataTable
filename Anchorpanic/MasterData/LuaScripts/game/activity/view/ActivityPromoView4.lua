--[[ 
-----------------------------------------------------
@filename       : ActivityPromoView4
@Description    : 宣传推广页面4——广告图——弹脸图需求
@date           : 2025-5-23
@Author         : wemen
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityPromoView4', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityPromoView4.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnBuy = self:getChildGO("mBtnBuy")
    self.mToggleRemaid = self:getChildGO("mToggleRemaid"):GetComponent(ty.Toggle)
    self.mAwardTrans = self:getChildTrans("mAwardTrans")
end

--激活
function active(self)
    super.active(self)

    self.id = sysParam.SysParamManager:getValue(SysParamType.MAIN_BANNER_PROMO4_ID, 0)
    local fashionComboConfigVo = purchase.FashionShopManager:getFashionComboData(self.id)
    if not fashionComboConfigVo then
        logError(string.format("杂项id：%s, 配置的值：%s, 拿不到FashionComboConfig"))
        return
    end

    self:getChildGO("mTxtOriginal"):GetComponent(ty.Text).text = _TT(50011, fashionComboConfigVo.originalCost / 100)
    self:getChildGO("mTxtDisco"):GetComponent(ty.Text).text = fashionComboConfigVo.scaleOff / 100
    -- self:getChildGO("mImgBannerBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(fashionComboConfigVo.main_img))
    self:setBtnLabel(self.mBtnBuy, nil, 
        string.format("￥  <size=45><i>%s</i></size>    <size=30>%s</size>", fashionComboConfigVo.cost / 100, _TT(9))
    )
    self:closeAllitemList()
    for i,itemId in ipairs(fashionComboConfigVo.itemList) do
        self.mPropsList[i] = PropsGrid:create(self.mAwardTrans, { itemId, 1 })
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    if self.mToggleRemaid.isOn then
        GameDispatcher:dispatchEvent(EventName.ADD_MONTH_NO_FLAG, { viewClass = self })
    end
    self:closeAllitemList()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtToggleRemaid"):GetComponent(ty.Text).text = _TT(97)
    self:getChildGO("TextDisco2Dec"):GetComponent(ty.Text).text = _TT(25037)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnBuy, self.onClickBuyHandler)
end

function onClickBuyHandler(self)
    recharge.sendRecharge(recharge.RechargeType.FASHION_COMBO, nil, self.id, function()
        self:onClickClose()
    end)
end

function closeAllitemList(self)
    if self.mPropsList then
        for i, _ in pairs(self.mPropsList) do
            self.mPropsList[i]:poolRecover()
            self.mPropsList[i] = nil
        end
    end
    self.mPropsList = {}
end

return _M