--[[ 
-----------------------------------------------------
@filename       : InfiniteCityDisasterItem
@Description    : 无限城灾害选择item
@date           : 2021-03-03 09:56:44
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('infiniteCity.InfiniteCityDisasterItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityDisasterItem.prefab")


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
    self.gGroup = self:getChildGO("gGroup")

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    -- self.aa = self:getChildTrans("")
    self.mImgLvBg = self:getChildGO("mImgLvBg"):GetComponent(ty.Image)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)

    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgShield = self:getChildGO("mImgShield")

    self.mImgLvl = self:getChildGO("mImgLvl"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)
    infiniteCity.InfiniteCityManager:addEventListener(infiniteCity.InfiniteCityManager.EVENT_DISASTER_SELECT_UPDATE, self.updateDisasterDesList, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    infiniteCity.InfiniteCityManager:removeEventListener(infiniteCity.InfiniteCityManager.EVENT_DISASTER_SELECT_UPDATE, self.updateDisasterDesList, self)
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
    self:addUIEvent(self.gGroup, self.onClick)
end

function setData(self, cusParent, cusData)
    self:setParentTrans(cusParent)
    self.data = cusData

    -- self.mTxtLv.text = self.data.lvl
    self.mImgIcon:SetImg(UrlManager:getIconPath(string.format("infiniteCity/disaster/infiniteCity_disaster_%s.png", self.data.icon)), true)

    self.mImgLvl:SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_lvl_%s.png", self.data.lvl)), true)

    local list = infiniteCity.InfiniteCityManager.selectDisasterList
    self.isSelect = (table.indexof(list, self.data.id) ~= false)
    self:updateState()
    self:updateBeMutex()
end

function onClick(self)
    if self.isBeMutex then
        -- gs.Message.Show("已选同类型灾害")
        -- gs.Message.Show(_TT(27146))
        local list = infiniteCity.InfiniteCityManager.selectDisasterList
        for i, v in ipairs(list) do
            local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(v)
            if disasterData.type == self.data.type then
                infiniteCity.InfiniteCityManager:setSelectDisasterList(v)
                break
            end
        end
    end

    infiniteCity.InfiniteCityManager:setSelectDisasterList(self.data.id)
end

function updateState(self)
    if self.isSelect then
        self.mImgSelect:SetActive(true)
        -- self.mImgLvBg.color = gs.ColorUtil.GetColor("ED1941FF")
        -- self.mTxtLv.color = gs.ColorUtil.GetColor("000000FF")
    else
        self.mImgSelect:SetActive(false)
        -- self.mImgLvBg.color = gs.ColorUtil.GetColor("000000FF")
        -- self.mTxtLv.color = gs.ColorUtil.GetColor("FFFFFFFF")
    end
end

function updateDisasterDesList(self, args)
    local state = args.state
    local id = args.id

    if id == self.data.id then
        self.isSelect = state == 1
        self:updateState()
    else
        self:updateBeMutex()
    end
end

-- 更新互斥状态
function updateBeMutex(self)
    self.isBeMutex = false
    if not self.isSelect then
        local list = infiniteCity.InfiniteCityManager.selectDisasterList
        for i, v in ipairs(list) do
            local disasterData = infiniteCity.InfiniteCityManager:getDisasterBaseData(v)
            if disasterData.type == self.data.type then
                self.isBeMutex = true
                break
            end
        end
    end
    self.mImgShield:SetActive(self.isBeMutex)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
