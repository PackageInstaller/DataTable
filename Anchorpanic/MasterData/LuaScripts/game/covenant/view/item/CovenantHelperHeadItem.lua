module('covenant.CovenantHelperHeadItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("covenant/CovenantHelperHeadItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mItemList = {}
    self.isShow = false
end

function configUI(self)
    self.mImgHelper = self:getChildGO('ImgHelper'):GetComponent(ty.AutoRefImage)
    self.mTextLvl = self:getChildGO('TextLvl'):GetComponent(ty.Text)
    self.mGoSelect = self:getChildGO("ImgSelect")
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
    self:addUIEvent(self.UIObject, function() self:dispatchEvent(self.EVENT_CHANGE, self) end)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.mHelperData = cusData
    self:updataView()
end

function getData(self)
    return self.mHelperData
end

function updataView(self)
    self.mImgHelper:SetImg(UrlManager:getIconPath(string.format("helper/helperBody/helper_body_%s.png", self.mHelperData.helperId)), false)
    self.mTextLvl.text = "Lv."..self.mHelperData.lvl
    self:updateBubbleView()
end

function setSelect(self, isSelect)
    self.mGoSelect:SetActive(isSelect)
end

function updateBubbleView(self)
    local helperVo = covenant.CovenantManager:getHelperVo(self.mHelperData.helperId)
    local isCanlvlUp = covenant.CovenantManager:isHelperCanLvlUp(helperVo)
    if (isCanlvlUp) then
        RedPointManager:add(self.UITrans, nil, 55, 65)
    else
        RedPointManager:remove(self.UITrans)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
