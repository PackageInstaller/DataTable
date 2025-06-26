--[[ 
-----------------------------------------------------
@filename       : GmPropsView
@Description    : gm快捷道具面板
@date           : 2021-05-21 20:22:07
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('gm.GmPropsView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("gm/GmPropsView.prefab")

function initData(self)
    self.mPropsConfigDic = props.PropsManager:getPropsConfigDic()
end

-- 初始化
function configUI(self)
    -- self.mBtnAll = self:getChildGO("mBtnAll"):GetComponent(ty.Image)
    -- self.bb = self:getChildTrans("bb")
    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(gm.GmPropsItem)

    self.mTxtType = self:getChildGO("mTxtType"):GetComponent(ty.InputField)
    self.mTxtSubType = self:getChildGO("mTxtSubType"):GetComponent(ty.InputField)

    self.mBtnAll = self:getChildGO("mBtnAll")
    self.mBtnHero = self:getChildGO("mBtnHero")
    self.mBtnEquip = self:getChildGO("mBtnEquip")
    self.mBtnNomal = self:getChildGO("mBtnNomal")
    self.mBtnOrder = self:getChildGO("mBtnOrder")
    self.mBtnFashion = self:getChildGO("mBtnFashion")
    self.mBtnBracelets = self:getChildGO("mBtnBracelets")

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.InputField)
end

--激活
function active(self)
    super.active(self)

    local list = table.values(self.mPropsConfigDic)
    self:updateView(list)

    self.mTxtType.onValueChanged:AddListener(function()
        self:inputChange()
    end);
    self.mTxtSubType.onValueChanged:AddListener(function()
        self:inputChange()
    end);
    self.mTxtName.onValueChanged:AddListener(function()
        self:inputNameChange()
    end);
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.mTxtType.onValueChanged:RemoveAllListeners()
    self.mTxtSubType.onValueChanged:RemoveAllListeners()
    self.mTxtName.onValueChanged:RemoveAllListeners()
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
    self:addUIEvent(self.mBtnAll, self.onClickAll)
    self:addUIEvent(self.mBtnHero, self.onClickHero)
    self:addUIEvent(self.mBtnEquip, self.onClickEquip)
    self:addUIEvent(self.mBtnNomal, self.onClickNomal)
    self:addUIEvent(self.mBtnBracelets, self.onClickBracelets)
    self:addUIEvent(self.mBtnOrder, self.onClickOrder)
    self:addUIEvent(self.mBtnFashion, self.onClickFashion)
end

--所有道具
function onClickAll(self)
    local list = table.values(self.mPropsConfigDic)
    self:updateView(list)
end

--战员
function onClickHero(self)
    local list = {}
    for k, v in pairs(self.mPropsConfigDic) do
        if v.type == 3 then
            table.insert(list, v)
        end
    end
    self:updateView(list)
end

--芯片
function onClickEquip(self)
    local list = {}
    for k, v in pairs(self.mPropsConfigDic) do
        if v.type == 2 and v.subType ~= 7 then
            table.insert(list, v)
        end
    end
    self:updateView(list)
end

--手环
function onClickBracelets(self)
    local list = {}
    for k, v in pairs(self.mPropsConfigDic) do
        if v.type == 2 and v.subType == 7 then
            table.insert(list, v)
        end
    end
    self:updateView(list)
end

--序列物
function onClickOrder(self)
    local list = {}
    for k, v in pairs(self.mPropsConfigDic) do
        if v.type == 6 then
            table.insert(list, v)
        end
    end
    self:updateView(list)
end

--消耗品
function onClickNomal(self)
    local list = {}
    for k, v in pairs(self.mPropsConfigDic) do
        if v.type == 1 then
            table.insert(list, v)
        end
    end
    self:updateView(list)
end

--皮肤
function onClickFashion(self)
    local list = {}
    for k, v in pairs(self.mPropsConfigDic) do
        if v.type == 10 then
            table.insert(list, v)
        end
    end
    self:updateView(list)
end

--检索
function inputChange(self)
    local list = {}
    local type = self.mTxtType.text
    local subType = self.mTxtSubType.text
    for k, v in pairs(self.mPropsConfigDic) do
        if v.type == tonumber(type) then
            if not subType or #subType <= 0 or v.subType == tonumber(subType) then
                table.insert(list, v)
            end
        end
    end
    self:updateView(list)
end

-- 名字检索
function inputNameChange(self)
    local inputName = self.mTxtName.text
    local list = {}
    for k, v in pairs(self.mPropsConfigDic) do
        local nameStr = v:getName()
        local index = string.find(v:getName(), inputName)
        if index ~= nil then
            table.insert(list, v)
        end
    end

    self:updateView(list)
end

function updateView(self, list)
    table.sort(list, bag.BagManager.sortPropsListByDescending)
    self.mLyScroller.DataProvider = list
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
