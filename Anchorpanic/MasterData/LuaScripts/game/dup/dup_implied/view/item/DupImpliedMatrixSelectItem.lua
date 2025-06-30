--[[ 
-----------------------------------------------------
@filename       : DupImpliedMatrixSelectItem
@Description    : 默示之境通关战利品选择item
@date           : 2021-07-07 11:11:58
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('dup.DupImpliedMatrixSelectItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupImplied/DupImpliedMatrixSelectItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.isSelect = false
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("mGroup")

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtImprove = self:getChildGO("mTxtImprove"):GetComponent(ty.Text)

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

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroup, self.onClick)
end

function setData(self, cusParent, cusData, cusImprove, cusCityId)
    self:setParentTrans(cusParent)
    self.isSelect = false

    self.cityId = cusCityId
    self.data = cusData

    self.mTxtName.text = self.data:getName()
    self.mTxtDes.text = self.data:getDes()

    self.mTxtImprove.text = _TT(42106, cusImprove / 10)

    self.mImgIcon:SetImg(UrlManager:getIconPath(string.format("dupImplied/matrix/%s", self.data.icon)), true)

    self:updateState()
end

function onClick(self)
    if self.isSelect == false then
        self:setSelect(true)
        self:dispatchEvent(self.EVENT_CHANGE, { item = self ,matrixId = self.data.id})
    end
end

function updateState(self)
    if self.isSelect then
        self.mImgSelect:SetActive(true)
    else
        self.mImgSelect:SetActive(false)
    end
end

function setSelect(self, bool)
    self.isSelect = bool
    self:updateState()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
