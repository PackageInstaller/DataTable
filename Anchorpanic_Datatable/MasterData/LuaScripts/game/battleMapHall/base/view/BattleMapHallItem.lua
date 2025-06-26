--[[ 
-----------------------------------------------------
@filename       : BattleMapHallItem
@Description    : 副本进入item
@date           : 2020-12-25 16:03:12
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('battleMapHall.BattleMapHallItem', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("battleMapHall/BattleMapHallItem.prefab")

EVENT_SELECT = "EVENT_SELECT"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mList = {}
end

-- 初始化
function configUI(self)

    self.mGroup = self:getChildGO("mGroup")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    -- self.aa = self:getChildTrans("")
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mGroup, self.onClick)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mGroup)
end

function onClick(self)
    self:dispatchEvent(self.EVENT_SELECT, self.type)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)

    self.type = cusData.type
    self.uicode = cusData.uicode
    self.mTxtTitle.text = cusData.name
    self.mImgIcon:SetImg(UrlManager:getBgPath(string.format("battleHall/battle_enter_s_%s.png", self.type + 1)))
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
