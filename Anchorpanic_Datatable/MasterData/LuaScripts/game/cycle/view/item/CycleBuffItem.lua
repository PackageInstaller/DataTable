module("cycle.CycleBuffItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleBuffItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mGroupSelect = self:getChildGO("mGroupSelect")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mIsLock = self:getChildGO("mIsLock")

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

function active(self)
    super.active(self)

end

function deActive(self)
    super.deActive(self)

    if self.aniSn then
        self:clearTimeout(self.aniSn)
        self.aniSn = nil
    end
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addOnClick(self:getChildGO("mGroup"), self.onClick)
end

function setData(self, cusParent, cusData, index)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData
    self.index = index

    self:setGuideTrans("guide_CycleBuffItem_" .. index, self:getChildTrans("GroupShow"))

    self:setSelect(false)

    if self.aniSn then
        self:clearTimeout(self.aniSn)
        self.aniSn = nil
    end
    self.UIObject:SetActive(false)
    self.aniSn = self:setTimeout(self.index * 0.03, function()
        self.UIObject:SetActive(true)
        self.UIObject:GetComponent(ty.UIDoTween):BeginTween()
        -- self.mAnimator:SetTrigger("enter")
    end)

    self:updateView()
end

function setSelect(self, bool)
    self.isSelect = bool
    self:updateState()
end

function updateState(self)
    if self.isSelect then
        self.mGroupSelect:SetActive(true)
    else
        self.mGroupSelect:SetActive(false)
    end
end

function updateView(self)
    self.mTxtName.text = _TT(self.mData.name)
    self.mTxtDes.text = _TT(self.mData.tacticsDes)
    local unLockList = cycle.CycleManager:getUnLockStrategy()
    self.mlockState = table.indexof01(unLockList, self.mData.id) == 0
    self.mIsLock:SetActive(self.mlockState)

    self.mImgIcon:SetImg(UrlManager:getIconPath(self.mData.icon), false)
end

function onClick(self)
    if self.mlockState == true then
        gs.Message.Show(_TT(self.mData.des))
        return
    end

    if self.isSelect == true then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
            step = CYCLE_STEP.SELECT_BUFF,
            args = {self.mData.id}
        })
    else
        GameDispatcher:dispatchEvent(EventName.SWITCH_CYCLE_BUFF_SELECT, self.index)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27526):	"状态还未解锁"
]]
