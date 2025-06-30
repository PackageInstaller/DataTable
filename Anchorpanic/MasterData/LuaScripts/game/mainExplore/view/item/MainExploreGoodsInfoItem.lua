--[[ 
-----------------------------------------------------
@filename       : MainExploreGoodsInfoItem
@Description    : 迷宫物品信息item
@date           : 2021-08-07 11:11:58
@Author         : Zzz
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('mainExplore.MainExploreGoodsInfoItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreGoodsInfoItem.prefab")

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

    self.mGroupSelect = self:getChildGO("GroupSelect")
    self.mTxtSelectTip = self:getChildGO("mTxtSelectTip"):GetComponent(ty.Text)

    self.mGroupShow = self:getChildTrans("GroupShow")
    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTxtEfficiency = self:getChildGO("mTxtEfficiency"):GetComponent(ty.Text)
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
    self.mTxtTitle.text = _TT(63014)
    self.mTxtSelectTip.text = _TT(63026)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mGroup, self.onClick)
end

function setData(self, cusParent, cusBuffId)
    self:setParentTrans(cusParent)
    self:setSelect(false)

    self.buffId = cusBuffId
    local goodsConfigVo = mainExplore.MainExploreSceneManager:getGoodsConfigVo(self.buffId)
    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtDes.text = goodsConfigVo:getDes()
    self.mTxtEfficiency.text = _TT(63013, goodsConfigVo.efficiency / 10)
    -- self.mImgIcon:SetImg()
    -- self.mImgBg:SetImg(UrlManager:getPackPath(string.format("infiniteCity/infiniteCity_%s.png", (34 + goodsConfigVo.color))))
end

function onClick(self)
    self:dispatchEvent(self.EVENT_CHANGE, { item = self })
end

function setSelect(self, bool)
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

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(63026):	"确 认 选 择"
	语言包: _TT(63014):	"物资"
]]
