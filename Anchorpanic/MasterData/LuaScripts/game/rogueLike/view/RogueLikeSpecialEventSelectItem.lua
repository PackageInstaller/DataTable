--[[ 
-----------------------------------------------------
@filename       : RogueLikeSpecialEventSelectItem
@Description    : 肉鸽特殊事件选择item
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeSpecialEventSelectItem", Class.impl(BaseReuseItem))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeSpecialEventSelectItem.prefab")

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

    self.mEventIconQuality = self:getChildGO("mEventIconQuality"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mIsSelect = self:getChildGO("mIsSelect")
    self.mTxtCon = self:getChildGO("mTxtCon"):GetComponent(ty.Text)

    self.mEventIcon = self:getChildGO("mEventIcon"):GetComponent(ty.AutoRefImage)
    -- self.mTxtTodo = self:getChildGO("mTxtTodo"):GetComponent(ty.Text)
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
end

-- 验证条件
function verPre(self)
    local result = false
    if self.eventVo.preconditionType == 0 then
        result = true
    elseif self.eventVo.preconditionType == 1 then
        result = rogueLike.RogueLikeManager:hasBuff(self.eventVo.preconditionArgs[1])
    elseif self.eventVo.preconditionType == 2 then
        result = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.FUNCTION_TID, self.eventVo.preconditionArgs[1], false, false)
    elseif self.eventVo.preconditionType == 3 then
        result = rogueLike.RogueLikeManager:hasBuffList(self.eventVo.preconditionArgs)
    elseif self.eventVo.preconditionType == 4 then
        result = rogueLike.RogueLikeManager:hasTypeBuffNum() >= self.eventVo.preconditionArgs[1]
    end
    return result
end

function setData(self, cusParent, cusCellId, eventId)
    self:setParentTrans(cusParent)
    self:setSelect(false)

    self.cellId = cusCellId
    self.eventId = eventId

    self.eventVo = rogueLike.RogueLikeManager:getRogueLikeEventData(self.eventId)
    self.mTxtTitle.text = _TT(self.eventVo.eventTitle)
    self.mTxtDes.text = _TT(self.eventVo.eventDes)
    self.mEventIconQuality.color = gs.ColorUtil.GetColor(rogueLike.RogueLikeConst:getEventColor(self.eventVo.eventColor))
    local ver = self:verPre()
    self.mTxtCon.text = ver and _TT(self.eventVo.eventTips) or _TT(self.eventVo.eventTipN)

    self.mEventIcon:SetImg(UrlManager:getRogueLikeMapIcon(self.eventVo.icon),true)
    self.mEventIcon.color = gs.ColorUtil.GetColor(rogueLike.RogueLikeConst:getEventColor(self.eventVo.eventColor))
end

function setSelect(self, isSelect)
    self.isSelect = isSelect
    self:updateState()
end

function updateState(self)
    self.mIsSelect:SetActive(self.isSelect)
end

function onClick(self)
    if self:verPre() == false then
        gs.Message.Show("不满足条件 无法选择")
        return
    end

    self:setSelect(not self.isSelect)

    local callback = function()
        if self.eventVo.triggerType == 6 then
            GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_FIGHT_INFO_PANEL, {id = self.cellId, eventId = self.eventId})
        elseif self.eventVo.triggerType == 9 then
            GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SHOP_OPEN, {cellId = self.cellId, eventId = self.eventId})
        end
    end

    if self.isSelect then
        self:dispatchEvent(self.EVENT_CHANGE, {item = self, eventId = self.eventId, callback = callback})
    else
        self:dispatchEvent(self.EVENT_CHANGE, {item = nil, eventId = nil, callback = nil})
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
