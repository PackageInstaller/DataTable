--[[ 
-----------------------------------------------------
@filename       : MazeGoodsInfoItem
@Description    : 迷宫物品信息item
@date           : 2021-08-07 11:11:58
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('gm.TestDeltaListItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("gm/TestDeltaListItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)
    self.mData = nil
end

-- 初始化
function configUI(self)
    self.mBtn = self:getChildGO("mBtn")
    self.mImgBody = self:getChildGO("mImgBody"):GetComponent(ty.AutoRefImage)
    self.mTextIndex = self:getChildGO("mTextIndex"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtn, self.onClick)
end

function setData(self, cusParent, data)
    self:setParentTrans(cusParent)
    self.mData = data

    local itemData = self.mData.itemData
    local itemIndex = self.mData.itemIndex
    self.mImgBody:GetComponent(ty.AutoRefImage):SetImg(itemData.bodySource, true)
    self.mTextIndex.text = itemIndex
end

function onClick(self)
    local itemData = self.mData.itemData
    local itemIndex = self.mData.itemIndex
    gs.Message.Show("点击按钮" .. itemIndex)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
