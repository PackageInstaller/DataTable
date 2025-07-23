--[[ 
-----------------------------------------------------
@filename       : PurchaseChildTabItem
@Description    : 贸易站三级tab
@date           : 2023-04-19 18:39:53
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
-- 
module("game.purchase.base.view.item.PurchaseChildTabItem", Class.impl("lib.component.BaseContainer"))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("purchase/PurchaseChildTabItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mBtnNomal = self:getChildGO("mBtnNomal")
    self.mBtnSelect = self:getChildGO("mBtnSelect")
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mBtnNomal, self.onNomalClick, UrlManager:getUIBaseSoundPath("ui_basic_switch.prefab"))
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnNomal)
end

function setData(self, cusVo, cusIndex, cusCallBack, cusThisObject)
    self.vo = cusVo
    self.index = cusIndex
    self.callBack = cusCallBack
    self.thisObject = cusThisObject

    self:updateView()
end

function getVo(self)
    return self.vo
end

function updateView(self)
    local fashionShopVo = purchase.FashionShopManager:getFashionShopVoByType(self.index)
    self:setBtnLabel(self.mBtnNomal, -1, fashionShopVo:getFashionShopName())
    self:setBtnLabel(self.mBtnSelect, -1, fashionShopVo:getFashionShopName())
    self:setSelect(false)
end

function setSelect(self, bool)
    if bool then
        self.mBtnSelect:SetActive(true)
        self.mBtnNomal:SetActive(false)
    else
        self.mBtnSelect:SetActive(false)
        self.mBtnNomal:SetActive(true)
    end
end

function onNomalClick(self)
    self.callBack(self.thisObject, self.index)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]