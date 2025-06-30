module("cycle.CycleComboItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleComboItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    --self.mIsSelect = self:getChildGO("mIsSelect")

    self.mGroupSelect = self:getChildGO("mGroupSelect")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mTxtDes= self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

function active(self)
    super.active(self)

end

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
    self:addOnClick(self:getChildGO("mGroup"),self.onClick)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mParentTrans = cusParent
    self.mData = cusData

    self:setSelect(false)

    self:updateView()
end

function setSelect(self,bool)
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
    self.mTxtDes.text = _TT(self.mData.des)

    self.mImgIcon:SetImg(UrlManager:getIconPath(self.mData.icon),false)
end

function onClick(self)
    if self.isSelect == true then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
                    step = CYCLE_STEP.SELECT_COMBO,
                    args = {self.mData.id}
                })
    else
        GameDispatcher:dispatchEvent(EventName.SWITCH_CYCLE_COMBO_SELECT, self.mData.id)
    end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
