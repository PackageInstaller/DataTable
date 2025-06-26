--[[ 
-----------------------------------------------------
@filename       : WaterpipeGameItem
@Description    : 接水管小游戏水管格子
@date           : 2020-12-24 20:08:02
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.view.item.WaterpipeGameItem', Class.impl("lib.component.BaseContainer"))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyGame/WaterpipeGameItem.prefab")

ITEM_W = 60
ITEM_H = 60

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.curDir = 1
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgMask = self:getChildGO("mImgMask")
    self.mTxtDir = self:getChildGO("mTxtDir"):GetComponent(ty.Text)
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
    self.removeOnClick(self.mGroup)
end

function onClick(self)
    if self.waterpipeData.canRotate == 0 then
        return
    end

    self.curDir = self.curDir == 4 and 1 or self.curDir + 1
    self.mTxtDir.text = self.curDir
    gs.TransQuick:Rotate(self.mImgIcon.transform, 0, 0, -90)
end

function setData(self, cusParent, cusGameId, cusId)
    self:setParentTrans(cusParent)

    self.waterpipeData = storyGame.WaterpipeGameManager:getWaterpipeBaseData(cusId)
    self.mImgIcon:SetImg(UrlManager:getPackPath(string.format("waterpipe/waterpipe_%s_%s.jpg", cusGameId, self.waterpipeData.img)))


    self.curDir = self.waterpipeData.initDir
    self.mTxtDir.text = self.curDir
    gs.TransQuick:SetRotation(self.mImgIcon.transform, 0, 0, -90 * (self.curDir - 1))


    local row = self.waterpipeData.pos[1]
    local column = self.waterpipeData.pos[2]

    local parentW = cusParent.rect.size.x
    local parentH = cusParent.rect.size.y

    local itemX = -parentW / 2 + (column - 1) * self.ITEM_W + self.ITEM_W / 2
    local itemY = parentH / 2 - (row - 1) * self.ITEM_H - self.ITEM_H / 2

    if self.waterpipeData.canRotate == 1 then
        self.mImgMask:SetActive(false)
    else
        self.mImgMask:SetActive(true)
    end

    gs.TransQuick:LPosXY(self.UITrans, itemX, itemY)
end

-- 是否正确方向
function isCorrect(self)
    return self.waterpipeData:isCorrect(self.curDir)
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
