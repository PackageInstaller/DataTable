--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDupItem
@Description    : 无限城副本item
@date           : 2021-03-03 09:56:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('infiniteCity.InfiniteCityDupItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityDupItem.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    -- self.aa = self:getChildTrans("")
    self.mGroupActive = self:getChildGO("mGroupActive")
    self.mGroupPass = self:getChildGO("mGroupPass")
    self.mGroupLock = self:getChildGO("mGroupLock")
    self.mImgLine = self:getChildGO("mImgLine")
    self.mTxtName1 = self:getChildGO("mTxtName1"):GetComponent(ty.Text)
    self.mTxtName2 = self:getChildGO("mTxtName2"):GetComponent(ty.Text)
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
    self:addUIEvent(self.mGroupActive, self.onClick)
    self:addUIEvent(self.mGroupPass, self.onClick)
end

function setData(self, cusParent, cusDupData)
    self:setParentTrans(cusParent)
    self.dupData = cusDupData

    self.mTxtName1.text = self.dupData.name
    self.mTxtName2.text = self.dupData.name

    self.mImgLine:SetActive(true)
    local curId = infiniteCity.InfiniteCityManager:getCurDupId()
    if self.dupData.id < curId or curId == 0 then
        -- self.mImgLine:SetActive(true)
        self.mGroupActive:SetActive(false)
        self.mGroupPass:SetActive(true)
        self.mGroupLock:SetActive(false)
    elseif self.dupData.id > curId then
        -- self.mImgLine:SetActive(false)
        self.mGroupActive:SetActive(false)
        self.mGroupPass:SetActive(false)
        self.mGroupLock:SetActive(true)
    else
        self.mGroupActive:SetActive(true)
        self.mGroupPass:SetActive(false)
        self.mGroupLock:SetActive(false)
    end

    if self.dupData.id == infiniteCity.InfiniteCityManager:getMaxDupId() then
        self.mImgLine:SetActive(false)
    end

end

function onClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_INFINITE_CITY_DUP_INFO_VIEW, self.dupData.id)
end

function getData(self)
    return self.dupData
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
