module("PropsSelectGrid", Class.impl(BaseGrid))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/PropsSelectGrid.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function poolRecover(self)
    super.poolRecover(self)
    self:initData()
end

function initData(self)
    self.mPropsGrid = nil
end

function configUI(self)
    self.mGroupGrid = self:getChildTrans("mGroupGrid")
    self.mImgSelect = self:getChildGO("mImgSelect")
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    if (self.mPropsGrid) then
        self.mPropsGrid:poolRecover()
        self.mPropsGrid = nil
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
    super.addAllUIEvent(self)
end

-- 设置数据
function setData(self, cusData, cusParent)
    self:setParentTrans(cusParent)
    self.mPropsVo = cusData
    self:updateData()
end

-- 更新数据
function updateData(self)
    self:updateGrid()
    self:setSelectState(false)
end

-- 更新道具格子
function updateGrid(self)
    if not self.mPropsGrid then
        self.mPropsGrid = PropsGrid:poolGet()
    end
    if self.mPropsVo then
        self.mPropsGrid:setData(self.mPropsVo, self.mGroupGrid)
    end
end

-- 点击默认触发
function onDefaultClickHandler(self)
    if (self.mPropsGrid) then
        self.mPropsGrid:onDefaultClickHandler()
    end
end

function setCallBack(self, cusCallObj, cusCallFun, ...)
    super.setCallBack(self, cusCallObj, cusCallFun, ...)

    if (self.mPropsGrid) then
        self.mPropsGrid:setClickEnable(false)
    end
end

function setSelectState(self, cusIsSelect)
    self.mImgSelect:SetActive(cusIsSelect)
end

function getSelectState(self)
    return self.mImgSelect.activeSelf
end

-- 设置打开的tip是否显示使用按钮
function setIsShowUseInTip(self, isShowUseInTip)
    if (self.mPropsGrid) then
        self.mPropsGrid:setIsShowUseInTip(isShowUseInTip)
    end
end

-- 设置是否显示底部栏数量
function setIsShowCount(self, isShowCount)
    if (self.mPropsGrid) then
        self.mPropsGrid:setIsShowCount(isShowCount)
    end
end

-- 取道具图标矩形
function getIconRect(self)
    return self.mPropsGrid:getIconRect()
end

-- 是否显示使用按钮
function getCanUseInTip(self)
    return self.mPropsGrid:getIsShowUseInTip()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]