--[[ 
-----------------------------------------------------
@filename       : InfiniteCitySupplyItem
@Description    : 无限城补给选择item
@date           : 2021-03-05 11:55:30
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('infiniteCity.InfiniteCitySupplyItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCitySupplyItem.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.isSelect = false
    self.isBeMutex = false
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("mGroup")

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mImgSelect = self:getChildGO("mImgSelect")

    self.mTxtLock = self:getChildGO("mTxtLock"):GetComponent(ty.Text)
    self.mImgLock = self:getChildGO("mImgLock")
end

--激活
function active(self)
    super.active(self)
    -- infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_SUPPLY_SELECT_UPDATE, self.updateSupplyDesList, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    -- infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_SUPPLY_SELECT_UPDATE, self.updateSupplyDesList, self)
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

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.data = cusData

    self.mTxtName.text = self.data:getName()
    self.mTxtDes.text = self.data:getDes()

    self.mTxtDes:GetComponent(ty.ContentSizeFitter):SetLayoutVertical()
    gs.LayoutRebuilder:ForceRebuildLayoutImmediate(self.mTxtDes.transform)

    local list = infiniteCity.InfiniteCityManager.selectSupplyList
    self.isSelect = (table.indexof(list, self.data.id) ~= false)
    self:updateState()
    self:updateLock()
    -- self:updateSupplyDesList()
end

function onClick(self)

    if not self:isActive() then
        gs.Message.Show(_TT(self.data.langId))
        return
    end
    local list = infiniteCity.InfiniteCityManager.selectSupplyList
    if #list >= 4 and self.isSelect == false then
        -- gs.Message.Show("最多携带4个补给")
        gs.Message.Show(_TT(27145))
        return
    end
    self.isSelect = self.isSelect == false
    infiniteCity.InfiniteCityManager:setSelectSupplyList(self.data.id)
    self:updateState()
end

function updateState(self)
    if self.isSelect then
        self.mImgSelect:SetActive(true)
    else
        self.mImgSelect:SetActive(false)
    end
end

function updateLock(self)
    self.mImgLock:SetActive(false)
    if not self:isActive() then
        self.mImgLock:SetActive(true)
        self.mTxtLock.text = _TT(self.data.langId)
    end
end

-- 是否激活
function isActive(self)
    return infiniteCity.InfiniteCityManager:getSupplyIsActive(self.data.id)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
