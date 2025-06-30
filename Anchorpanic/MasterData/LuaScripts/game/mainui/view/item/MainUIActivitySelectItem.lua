--[[ 
-----------------------------------------------------
@filename       : MainUIActivitySelectItem
@Description    : 主界面活动轮播选择位置
@date           : 2020-12-09 19:39:31
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.mainui.view.MainUIActivitySelectItem', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainui/MainUIActivitySelectItem.prefab")

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
    self.mImgSelectBg = self:getChildGO("mImgSelectBg")
    self.mImgSelect = self:getChildGO("mImgSelect")
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end
-- 设置选中
function setSelect(self, isSelect)
    self.mImgSelect:SetActive(isSelect)
end
-- 设置显示与否
function setItemActive(self, isActive)
    self.UITrans:SetActive(isActive)
end

-- 添加到父节点 cusSiblingIndex 添加显示层级
function addOnParent(self, cusSiblingIndex)
    if self.UIObject == nil then
        self.UIObject = gs.GOPoolMgr:Get(self.UIRes)
        if self.UIObject then
            self.UITrans = self.UIObject.transform
            self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
            self:configUI()
        end
    end

    super.addOnParent(self, cusSiblingIndex)
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    if self.UIObject then
        gs.GOPoolMgr:Recover(self.UIObject, self.UIRes)
    end

    self.UIObject = nil
    self.UITrans = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self:__deActive()

    LuaPoolMgr:poolRecover(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
