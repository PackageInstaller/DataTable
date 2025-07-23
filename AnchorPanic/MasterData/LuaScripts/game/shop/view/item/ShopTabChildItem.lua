--[[
-----------------------------------------------------
@filename       : sxt 
@Description    : 商店二级tab add
@date           : 2020-09-01 10:24:53
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.shop.view.ShopTabChildItem', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("shop/ShopTabChildItem.prefab")

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

function setData(self, langId, cusType, cusCallBack, cusThisObject)
    self.langId = langId
    self.type = cusType
    self.callBack = cusCallBack
    self.thisObject = cusThisObject
    self:updateView()
end

function setActive(self, isActive)
    self.UIObject:SetActive(isActive)
end

function getActiveState(self)
    return self.UIObject.activeSelf
end

function getVo(self)
    return self.langId
end

function updateView(self)
    self:setBtnLabel(self.mBtnNomal, self.langId)
    self:setBtnLabel(self.mBtnSelect, self.langId)
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
    self.callBack(self.thisObject, self.type)
end

function addBubble(self)
    RedPointManager:add(self.UITrans, nil, -60, 9)
end

function removeBubble(self)
    RedPointManager:remove(self.UITrans)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
