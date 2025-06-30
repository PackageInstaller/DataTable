--[[
-----------------------------------------------------
@filename       : MiningDupItem
@Description    : 挖矿副本item
@date           : 2023-12-08 10:57:06
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.mining.view.item.MiningDupItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mining/MiningDupItem.prefab")

-- 点击选择
EVENT_CLICK_SELECT = "EVENT_CLICK_SELECT"

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
    self.mGroup = self:getChildTrans("mGroup")
    self.mImgBg = self:getChildGO("mImgBg")
    self.mImgBg01 = self:getChildGO("mImgBg01")
    self.mImgBg02 = self:getChildGO("mImgBg02")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mImgSelect = self:getChildGO("mImgSelect")
    self.mImgPass = self:getChildGO("mImgPass")

    self.mImgLine1 = self:getChildGO("mImgLine1")
    self.mImgLine2 = self:getChildGO("mImgLine2")
    self.mImgLine1_1 = self:getChildGO("mImgLine1_1")
    self.mImgLine2_1 = self:getChildGO("mImgLine2_1")

    self.mGroupStar = self:getChildTrans("mGroupStar")

    self.mImgRed = self:getChildGO("mImgRed")

    self.mImgTime = self:getChildGO("mImgTime")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
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
    self:addUIEvent(self.mImgBg, self.onClick)
end

function onClick(self)
    StorageUtil:saveBool1(mining.MiningManager.DupNewOpenStorageKey .. self.dupVo.id, true)
    self:getChildGO("mImgRed"):SetActive(false)

    if not self:isOpenTime() then
        local openTime = TimeUtil.transTime2(self.dupVo.beginTime)
        local date = os.date("*t", openTime)
        local str = string.format("%02d/%02d %02d:%02d%s", date.month, date.day, date.hour, date.min, _TT(92026))
        gs.Message.Show(str)
        return
    end
    if self:isLock() then
        gs.Message.Show(_TT(99569))
        return
    end
    self:dispatchEvent(self.EVENT_CLICK_SELECT, self.dupVo)
end

function getDupVo(self)
    return self.dupVo
end

function setData(self, cusParent, cusData, index)
    super.setData(self, cusParent, cusData)
    self.index = index
    self.dupVo = cusData

    self:updateView()
end

function updateView(self)
    self.mImgSelect:SetActive(false)

    self.mTxtName.text = self.dupVo.name
    self.mImgBg01:SetActive(true)
    self.mImgBg02:SetActive(false)

    local record = mining.MiningManager:getPlayerDupRecord(self.dupVo.id)
    local starCount = mining.MiningManager:getPlayerDupStar(self.dupVo.id, record)
    self:recoverItem()
    for i = 1, starCount do
        local starItem = SimpleInsItem:create(self:getChildGO("GroupStarItem"), self.mGroupStar, "MiningDupItemStarItem ")
        table.insert(self.mStarList, starItem)
    end

    self.mImgPass:SetActive(record > 0)

    if self.index % 2 == 0 then
        gs.TransQuick:LPosY(self.mGroup, -100)
        self.mImgLine1:SetActive(false)
        self.mImgLine1_1:SetActive(false)
        self.mImgLine2:SetActive(record > 0)
        self.mImgLine2_1:SetActive(record <= 0)
    else
        gs.TransQuick:LPosY(self.mGroup, 60)
        self.mImgLine1:SetActive(record > 0)
        self.mImgLine1_1:SetActive(record <= 0)
        self.mImgLine2:SetActive(false)
        self.mImgLine2_1:SetActive(false)
    end

    self.mImgTime:SetActive(not self:isOpenTime())
    if not table.empty(self.dupVo.beginTime) then
        local openTime = TimeUtil.transTime2(self.dupVo.beginTime)
        local date = os.date("*t", openTime)
        local str = string.format("%02d/%02d %02d:%02d%s", date.month, date.day, date.hour, date.min, _TT(92026))
        self.mTxtTime.text = str
    end

    local isOpen = not self:isLock() and self:isOpenTime()
    self:getChildGO("mImgRed"):SetActive(isOpen and not StorageUtil:getBool1(mining.MiningManager.DupNewOpenStorageKey .. self.dupVo.id))

    self.mImgSelect.transform.localScale = gs.Vector3(0.8, 0.8, 0.8)
end

function recoverItem(self)
    if self.mStarList then
        for i, v in pairs(self.mStarList) do
            v:poolRecover()
        end
    end
    self.mStarList = {}
end

-- 是否锁定未开放
function isLock(self)
    return mining.MiningManager:getDupIsLock(self.dupVo)
end

-- 是否开放时间
function isOpenTime(self)
    return mining.MiningManager:getDupIsOpenTime(self.dupVo)
end

-- 设置为最后一项
function setLastItem(self)
    self.mImgBg01:SetActive(false)
    self.mImgSelect.transform.localScale = gs.VEC3_ONE
    self.mImgBg02:SetActive(true)
    self.mImgLine1:SetActive(false)
    self.mImgLine2:SetActive(false)
    self.mImgLine1_1:SetActive(false)
    self.mImgLine2_1:SetActive(false)
end

-- 设置选择
function setSelect(self, isSelect)
    self.mImgSelect:SetActive(isSelect)
end

return _M
