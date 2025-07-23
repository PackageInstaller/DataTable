--[[ 
-----------------------------------------------------
@filename       : RogueLikeSpecialEventResultItem
@Description    : 肉鸽特殊事件选择item
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeSpecialEventResultItem", Class.impl(BaseReuseItem))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeSpecialEventResultItem.prefab")

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
    self.mEventIconQuality = self:getChildGO("mEventIconQuality"):GetComponent(ty.AutoRefImage)
    -- self.mBtnGroup = self:getChildGO("mBtnGroup")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mEventIcon = self:getChildGO("mEventIcon"):GetComponent(ty.AutoRefImage)
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
    -- self:addUIEvent(self.mBtnGroup, self.onClick)
end

function setData(self, cusParent, cusCellId, eventId)
    self:setParentTrans(cusParent)

    self.cellId = cusCellId
    self.eventId = eventId

    self.eventVo = rogueLike.RogueLikeManager:getRogueLikeEventData(self.eventId)
    self.mTxtTitle.text = _TT(self.eventVo.resultTitle) 
    self.mTxtDes.text = _TT(self.eventVo.result)

    self.mEventIconQuality.color = gs.ColorUtil.GetColor(rogueLike.RogueLikeConst:getEventColor(self.eventVo.eventColor))
    self.mEventIcon:SetImg(UrlManager:getRogueLikeMapIcon(self.eventVo.icon),true)
    self.mEventIcon.color = gs.ColorUtil.GetColor(rogueLike.RogueLikeConst:getEventColor(self.eventVo.eventColor))
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
