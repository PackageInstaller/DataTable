--[[ 
-----------------------------------------------------
@filename       : RogueLikeGoodsSelectItem
@Description    : 迷宫通关物品选择item
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] 
module("rogueLike.RogueLikeGoodsSelectItem", Class.impl(BaseReuseItem))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeGoodsSelectItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构
function dtor(self)
end

function initData(self)
    self.isSelect = false
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mGroup = self:getChildGO("mGroup")

    self.mGroupSelect = self:getChildGO("GroupSelect")
    self.mTxtSelectTip = self:getChildGO("mTxtSelectTip"):GetComponent(ty.Text)

    self.mGroupShow = self:getChildTrans("GroupShow")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtImprove = self:getChildGO("mTxtImprove"):GetComponent(ty.Text)
end

-- 激活
function active(self)
    super.active(self)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = "物资"
    self.mTxtSelectTip.text = "确 认 选 择"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroup, self.onClick)
end

function setData(self, cusParent, cusCellId, cusBuffData)
    self:setParentTrans(cusParent)
    self:setSelect(false)

    self.mCellId = cusCellId
    self.mBuffId = cusBuffData.buff_id

    local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.mBuffId)
    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtDes.text = goodsConfigVo:getDes()

    self.mTxtImprove.text = string.substitute("作战效率：{0}%", cusBuffData.improve_efficiency / 10)
    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(goodsConfigVo:getIcon()), true)
    -- self.mImgBg:SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%s.png", (34 + goodsConfigVo.color))))
end

function onClick(self)
    if self.isSelect == false then
        self:setSelect(true)
        self:dispatchEvent(self.EVENT_CHANGE, {item = self})
        return
    end
    if self.isSelect then
        GameDispatcher:dispatchEvent(EventName.REQ_ROGUE_SELECT_BUFF, {buffId = self.mBuffId})
    end
end

function setSelect(self, bool)
    self.isSelect = bool
    self:updateState()
end

function updateState(self)
    if self.isSelect then
        self.mGroupSelect:SetActive(true)
        gs.TransQuick:LPosY(self.mGroupShow, 11)
    else
        self.mGroupSelect:SetActive(false)
        gs.TransQuick:LPosY(self.mGroupShow, 0)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
